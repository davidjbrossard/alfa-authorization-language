grammar Alfa2;

alfa returns [Alfa result]
	: namespace* EOF
  ;

namespace returns [Namespace result]
  : NAMESPACE IDENTIFIER LEFTBRACE namespaceBody* RIGHTBRACE
  ;

namespaceBody 
  : namespace                         # namespaceBodyNamespace
  | importDeclaration                 # namespaceBodyImportDeclaration
  | attributeDeclaration              # namespaceBodyAttributeDeclaration
  | structuredAttributeDeclaration    # namespaceBodyStructuredAttributeDeclaration
  | obligationDeclaration             # namespaceBodyObligationDeclaration
  | adviceDeclaration                 # namespaceBodyAdviceDeclaration
  | sharedRule                        # namespaceSharedRule
  | sharedCondition                   # namespaceSharedCondition
  | letExpression                     # namespaceLetExpression
  | policySet                         # namespaceBodyPolicySet
  | policy                            # namespaceBodyPolicy
  ;

importDeclaration 
  : IMPORT qualifiedName            # singleImport
  | IMPORT qualifiedName DOT STAR   # starImport
  ;

qualifiedName 
  : IDENTIFIER
  | IDENTIFIER DOT qualifiedName
  ;

elementName 
  :                                # elementNameEmpty
  | IDENTIFIER                     # elementNameSingle
  ;

policySet 
  : POLICYSET qualifiedName                                     # policySetRef
  | POLICYSET elementName LEFTBRACE policySetBody* RIGHTBRACE   # policySetDef
  ;

policySetBody 
  : policy                                     # policySetBodyPolicy
  | policySet                                  # policySetBodyPolicySet
  | conditionDefinition                        # policySetBodyPolicyCondition
  | targetDefinition                           # policySetBodyPolicyTarget
  | APPLY combiningAlgorithm                   # policySetBodyPolicyCombAlg
  | onEffect                                   # policySetBodyPolicyOnEffect
  ;

policy  
  : POLICY qualifiedName                                   # policyRef
  | POLICY elementName LEFTBRACE policyBodyElement* RIGHTBRACE    # policyDef
  ;

policyBodyElement
  : policyRule                                 # policyBodyRule
  | conditionDefinition                        # policyBodyCondition
  | targetDefinition                           # policyBodyTarget
  | APPLY combiningAlgorithm                   # policyBodyCombAlg
  | onEffect                                   # policyBodyOnEffect
  ;

policyRule 
  : RULE qualifiedName                                 # ruleRef
  | RULE elementName LEFTBRACE ruleBody* RIGHTBRACE    # ruleDef
  | RULE expr THEN (PERMIT | DENY)                     # ruleInline
  ;

sharedCondition
  : CONDITION IDENTIFIER expr                          #sharedConditionDef
  ;

sharedRule
  : RULE elementName LEFTBRACE ruleBody* RIGHTBRACE    #sharedRuleDef
  ;

letExpression
  : LET elementName ':' types ASSIGN expr;

ruleBody 
  : conditionDefinition   # ruleBodyCondition
  | targetDefinition      # ruleBodyTarget
  | decision              # ruleEffect
  | onEffect              # ruleOnEffect
  ;

onEffect 
  : ON PERMIT LEFTBRACE obligationExpression* RIGHTBRACE  
  | ON DENY LEFTBRACE obligationExpression* RIGHTBRACE    
  | ON PERMIT LEFTBRACE adviceExpression* RIGHTBRACE
  | ON DENY LEFTBRACE adviceExpression* RIGHTBRACE
  ;

targetDefinition 
  : TARGET (CLAUSE expr)+
  ;

conditionDefinition 
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
expr 
  : attributeDesignator                                             # exprAttributeDesignator
  | constLit                                                        # exprConst
  | LEFTPAREN expr RIGHTPAREN                                       # exprParen
  | NOT expr                                                        # exprNot
  |<assoc=left > left=expr op=(EQUAL | LESS | GREATER | NOTEQUAL) right=expr   # exprBinOp
  |<assoc=right> left=expr op=ANDAND right=expr                     # exprBinOp
  |<assoc=right> left=expr op=OROR right=expr                       # exprBinOp
  |functionCall                                                     # exprFunc
  ;

functionCall
  : IDENTIFIER LEFTBRACKET arguments? RIGHTBRACKET
  ;

arguments
  : expr
  | expr COMMA expr
  ; 
attributeDesignator 
  : qualifiedName                                                   # attributeDesignatorDirect
  | qualifiedName LEFTBRACKET IDENTIFIER RIGHTBRACKET               # attributeDesignatorWithAttribute
  ;

value
  : qualifiedName      # valueQualifiedName
  | constLit              # valueConst
  ;
  
constLit 
  : NUMBER                           # constInt
  | LITERAL_STRING                   # constLITERAL_STRING
  | BOOL                             # constBool
  | LITERAL_STRING ':' types         # constTypeCohersion
  ;

decision 
  : PERMIT    # decisionPermit
  | DENY      # decisionDeny
  ;

combiningAlgorithm 
  : 'denyOverrides'
  | 'permitOverrides'
  | 'firstApplicable'
  | 'denyUnlessPermit'
  | 'permitUnlessDeny'
  ;

adviceExpression
  : ADVICE id=qualifiedName LEFTBRACE effectInstruction* RIGHTBRACE;

obligationExpression
  : OBLIGATION id=qualifiedName LEFTBRACE effectInstruction*  RIGHTBRACE;
  

effectInstruction 
  : lhs=qualifiedName ASSIGN rhs=value
  | lhs=qualifiedName
  ;

attributeDeclaration 
	: ATTRIBUTE IDENTIFIER LEFTBRACE (attributeProperty)* RIGHTBRACE
	;

attributeProperty 
  : TYPE ASSIGN types
  | CATEGORY ASSIGN IDENTIFIER
  | ID ASSIGN LITERAL_STRING
  ;

types
  :INTEGER
  | BOOLEAN
  | DOUBLE
  | DURATION
  | MONEY
  | TIME
  | DURATION
  | DATE
  | DATETIME
  | IDENTIFIER
  ;

obligationDeclaration
  : OBLIGATION IDENTIFIER EQUAL LITERAL_STRING
  ;

  adviceDeclaration
   : ADVICE IDENTIFIER EQUAL LITERAL_STRING
   ;

binOp 
  : EQUAL
  | NOTEQUAL
  | LESS
  | GREATER
  | LESSEQUAL
  | GREATEREQUAL
  ;

fieldDefinition: IDENTIFIER ':' types; 
structuredAttributeDeclaration
   : TYPE IDENTIFIER LEFTBRACE (fieldDefinition)+ RIGHTBRACE;

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

COMMA : ',';

BOOL:
    'true'
  | 'false'
  ;


/* Keywords */

TYPE : 'type';
LET: 'let';
THEN: 'then';

ALL         : 'all';
STRING      : 'string';
BOOLEAN     : 'boolean';
INTEGER     : 'integer';
DOUBLE      : 'double';
DATETIME    : 'dateTime';
DATE        : 'date';
TIME        : 'time';
DURATION    : 'duration';
MONEY       : 'money';
MONEY_SUFFIX: 'm';
IP_ADDRESS: 'ipAddress';

CATEGORY :'category';
ID:'id';


APPLY : 'apply';
NAMESPACE : 'namespace';
IMPORT : 'import';
POLICYSET : 'policyset';
POLICY : 'policy';
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

LITERAL_STRING:
  '"' .*? '"'
  ;

WS: [ \n\t\r]+ -> skip;
COMMENT: '/*' .*? '*/' -> skip;
LINE_COMMENT: '//' ~[\r\n]* -> skip;