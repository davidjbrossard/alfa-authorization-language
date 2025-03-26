grammar Alfa2;

body: NAMESPACE; 
     
// Tokens              
MUSTBEPRESENT : 'mustbepresent';

ON: 'on';
THEN: 'then';

OBLIGATION  : 'obligation';
ADVICE      : 'advice';
         
APPLY       : 'apply';
POLICY      : 'policy';
POLICYSET   : 'policyset';
RULE        : 'rule';
PERMIT      : 'permit';
DENY        : 'deny';
TARGET_CLAUSE: 'target clause';
CONDITION   : 'condition';
AND         : '&&';
OR          : '||';
FUNCTION    : 'function';
ASSIGNMENT_OPERATOR : '=';
OVERLOAD_OPERATOR: '|';

ANDCLAUSE   : 'and';
ORCLAUSE    : 'or';

IMPORT      : 'import';
NAMESPACE   : 'namespace';
ATTRIBUTE   : 'attribute';
CATEGORY    : 'category';
ID          : 'id';
BAG         : 'bag';
ALL         : 'all';
TYPE        : 'type';
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

COMBINE_DENY_OVERRIDES : 'denyOverrides';
COMBINE_PERMIT_OVERRIDES : 'permitOverrides';
COMBINE_FIRST_APPLICABLE : 'firstApplicable';
COMBINE_ONLY_ONE_APPLICABLE : 'onlyOne';
COMBINE_DENY_UNLESS_PERMIT : 'denyUnlessPermit';
COMBINE_PERMIT_UNLESS_DENY : 'permitUnlessDeny';

LITERAL_STRING : QUOTE ~( '\n' | '\r' | '"' )*  QUOTE
               | SINGLE_QUOTE ~( '\n' | '\r' | '\'' )* SINGLE_QUOTE;

LITERAL_INTEGER : [0-9]+;
LITERAL_DOUBLE : [0-9]*'.'[0-9]+;
LITERAL_TRUE    : 'true';
LITERAL_FALSE   : 'false';


LITERAL_TYPE_DESIGNTOR: ':';
EQUAL : '==';
NOTEQUAL : '!=';
GREATERTHAN : '>';
LESSTHAN : '<';
GREATERTHANANDEQUAL : '>=';
LESSTHANANDEQUAL : '<=';
NOT : 'not';
PLUS : '+';
MINUS : '-';
MULTIPLY : '*';
DIVIDE : '/';

BRACE_OPEN : '{';
BRACE_CLOSE : '}';
PAREN_OPEN : '(';
PAREN_CLOSE : ')';
SQUAREBRACE_OPEN : '[';
SQUAREBRACE_CLOSE : ']';

COMMA: ',';
                        
INLINECOMMENT: '//' LITERAL_STRING_BODY -> skip;
COMMENTBLOCK : '/*' .*? '*/' -> skip;

IDENTIFIER  : [a-zA-Z_][a-zA-Z0-9_]*('.'[a-zA-Z_][a-zA-Z0-9_]+)*;
WILDCARD    : ('.*');

WHITESPACE  : (' ' | '\t')+ -> channel(HIDDEN);
NEWLINE     : ('\r'? '\n' | '\r')+ -> channel(HIDDEN);

fragment LITERAL_STRING_BODY : ~( '\n' | '\r'  )*;
fragment QUOTE : '"' ;
fragment SINGLE_QUOTE : '\'';
