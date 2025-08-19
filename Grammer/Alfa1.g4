grammar alfa;

@header {
  package org.fortiss.ucon.parser;
  import org.fortiss.ucon.syntax.*;
}

alfa returns [Alfa result]
	: namespace* EOF
  ;

namespace returns [Namespace result]
  : NAMESPACE IDENTIFIER LEFTBRACE namespaceBody* RIGHTBRACE
  ;

namespaceBody returns [NamespaceBody result]
  : namespace              # namespaceBodyNamespace
  | importDeclaration      # namespaceBodyImportDeclaration
  | attributeDeclaration   # namespaceBodyAttributeDeclaration
  | obligationDeclaration  # namespaceBodyObligationDeclaration
  | policySet              # namespaceBodyPolicySet
  | policy                 # namespaceBodyPolicy
  ;

importDeclaration returns [ImportDeclaration result]
  : IMPORT qualifiedName            # singleImport
  | IMPORT qualifiedName DOT STAR   # starImport
  ;

qualifiedName returns [QualifiedName result]
  : IDENTIFIER
  | IDENTIFIER DOT qualifiedName
  ;

elementName returns [String result]
  :                                # elementNameEmpty
  | IDENTIFIER                     # elementNameSingle
  | IDENTIFIER ASSIGN STRING       # elementNameWithId
  ;

policySet returns [PolicySet result]
  : POLICYSET qualifiedName                                     # policySetRef
  | POLICYSET elementName LEFTBRACE policySetBody* RIGHTBRACE   # policySetDef
  ;

policySetBody returns [Object result]
  : policy                                     # policySetBodyPolicy
  | policySet                                  # policySetBodyPolicySet
  | conditionDefinition                        # policySetBodyPolicyCondition
  | targetDefinition                           # policySetBodyPolicyTarget
  | APPLY combiningAlgorithm                   # policySetBodyPolicyCombAlg
  | onEffect                                   # policySetBodyPolicyOnEffect
  | POLICYISSUER qualifiedName ASSIGN constLit  # policySetBodyIssuer
  ;

policy returns [Policy result]
  : POLICY qualifiedName                                   # policyRef
  | POLICY elementName LEFTBRACE policyBody* RIGHTBRACE    # policyDef
  ;

policyBody returns [Object result]
  : policyRule                                 # policyBodyRule
  | conditionDefinition                        # policyBodyCondition
  | targetDefinition                           # policyBodyTarget
  | APPLY combiningAlgorithm                   # policyBodyCombAlg
  | onEffect                                   # policyBodyOnEffect
  | POLICYISSUER qualifiedName ASSIGN constLit  # policyBodyIssuer
  ;

policyRule returns [Rule result]
  : RULE qualifiedName                                 # ruleRef
  | RULE elementName LEFTBRACE ruleBody* RIGHTBRACE    # ruleDef
  ;

ruleBody returns [Object result]
  : conditionDefinition   # ruleBodyCondition
  | targetDefinition      # ruleBodyTarget
  | decision              # ruleEffect
  | onEffect              # ruleOnEffect
  ;

onEffect returns [OnEffect result]
  : ON PERMIT LEFTBRACE obligationExpression* RIGHTBRACE  # onEffectPermit
  | ON DENY LEFTBRACE obligationExpression* RIGHTBRACE    # onEffectDeny
  ;

targetDefinition returns [Target result]
  : TARGET (CLAUSE anyOfBlock)+
  ;

anyOfBlock returns [Disjunct result]
  : allOfBlock (LOR allOfBlock)*
  ;

allOfBlock returns [Conjunct result]
  : matchExp (LAND matchExp)*
  ;

// TODO: add more cases
matchExp returns [Match result]
  : attributeDesignator binOp constLit     # matchBinOp
  | attributeDesignator                    # matchAttr
  ;

conditionDefinition returns [Condition result]
  : CONDITION expr
  ;

// The operator precedence determined by order of these rules!
// From the standard:
// The order is as follow, going from the operators that bind the weakest to the operators that bind the strongest.
//    • Operators starting with ‘|’. These are right associative.
//    • Operators starting with ‘&’. These are right associative.
//    • Operators starting with ‘=’, ‘<’, ‘>’ or ‘$’. These are left associative.
//    • Operators starting with ‘@’ or ‘^’. These are right associative.
//    • Operators starting with ‘+’ or ‘-‘. These are left associative.
//    • Operators starting with ‘*’, ‘/’ or ‘%’. These are left associative.
// TODO: add more cases
expr returns [Expr result]
  : attributeDesignator                                             # exprAttributeDesignator
  | constLit                                                        # exprConst
  | LEFTPAREN expr RIGHTPAREN                                       # exprParen
  | NOT expr                                                        # exprNot
  |<assoc=left > left=expr op=(EQUAL | LESS | GREATER) right=expr   # exprBinOp
  |<assoc=right> left=expr op=ANDAND right=expr                     # exprBinOp
  |<assoc=right> left=expr op=OROR right=expr                       # exprBinOp
  ;

attributeDesignator returns [AttributeDesignator result]
  : qualifiedName                                                   # attributeDesignatorDirect
  | qualifiedName LEFTBRACKET IDENTIFIER RIGHTBRACKET               # attributeDesignatorWithAttribute
  ;

value returns [Expr result]
  : qualifiedName      # valueQualifiedName
  | constLit              # valueConst
  ;
  
constLit returns [Constant result]
  : NUMBER                           # constInt
  | STRING                           # constString
  | BOOL                             # constBool
  | STRING ':' IDENTIFIER            # constIPAddress
    // ipAddress : "127.0.0.1":ipAddress
  ;

decision returns [Object result]
  : PERMIT    # decisionPermit
  | DENY      # decisionDeny
  ;

combiningAlgorithm returns [Object result]
  : 'denyOverrides'
  | 'permitOverrides'
  | 'firstApplicable'
  | 'onlyOneApplicable'
  | 'orderedDenyOverrides'
  | 'orderedPermitOverrides'
  | 'denyUnlessPermit'
  | 'permitUnlessDeny'
  | 'onPermitApplySecond'
  ;

obligationExpression returns [ObligationExpr result]
  : OBLIGATION id=qualifiedName  // By reference
  | OBLIGATION id=qualifiedName LEFTBRACE obligationInstruction*  RIGHTBRACE
        // By reference with attribute assignments
  ;

obligationInstruction returns [Instruction result]
  : lhs=qualifiedName ASSIGN rhs=value
  ;

attributeDeclaration returns [AttributeDeclaration result]
	: ATTRIBUTE IDENTIFIER LEFTBRACE (attributeProperty)* RIGHTBRACE
	;

attributeProperty returns [AttributeProperty result]
  : key=IDENTIFIER ASSIGN data=STRING
  | key=IDENTIFIER ASSIGN data=IDENTIFIER
  ;

obligationDeclaration returns [ObligationDeclaration result]
  : OBLIGATION IDENTIFIER EQUAL STRING
  ;

binOp returns [Object result]
  : EQUAL
  | NOTEQUAL
  | LESS
  | GREATER
  | LESSEQUAL
  | GREATEREQUAL
  ;

/*
 * Lexer Rules
 */

/* General definitions */

fragment LOWERCASE :
	 [a-z]
	 ;

fragment UPPERCASE :
	 [A-Z]
	 ;

fragment DIGIT :
	 [0-9]
	 ;

NUMBER :
	 DIGIT+ ([.,] DIGIT+)?
	 ;


BOOL:
    'true'
  | 'false'
  ;


/* Keywords */

APPLY : 'apply';
NAMESPACE : 'namespace';
IMPORT : 'import';
POLICYSET : 'policyset';
POLICY : 'policy';
POLICYISSUER : 'policyIssuer';
RULE : 'rule';
PERMIT : 'permit';
DENY : 'deny';
TARGET : 'target';
CLAUSE : 'clause';
ADVICE : 'advice';
OBLIGATION : 'obligation';
ON: 'on';
CONDITION : 'condition';
FUNCTION : 'function';

/* Attribute block */

ATTRIBUTE : 'attribute';

DOT : '.';

/* Some Operators */
PLUS : '+';
MINUS : '-';
DIV : '/';
STAR : '*';
LEFTBRACE : '{';
RIGHTBRACE : '}';
LEFTBRACKET : '[';
RIGHTBRACKET : ']';
LEFTPAREN : '(';
RIGHTPAREN : ')';
ASSIGN : '=' ;
MOD : '%' ;
AND : '&';
OR : '|' ;
NOT : 'not' ;
LESS : '<' ;
GREATER : '>';
CARET : '^' ;
EQUAL : '==';
NOTEQUAL : '!=';
LESSEQUAL : '<=';
GREATEREQUAL : '>=';
ANDAND : '&&';
OROR : '||' ;
LAND : 'and';
LOR : 'or' ;

IDENTIFIER:
  [A-Za-z_][A-Za-z_0-9]*
  ;

STRING:
  '"' .*? '"'
  ;

WS: [ \n\t\r]+ -> skip;
COMMENT: '/*' .*? '*/' -> skip;
LINE_COMMENT: '//' ~[\r\n]* -> skip;