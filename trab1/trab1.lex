/* Coloque aqui definições regulares */

%{

#include <string>

string lexema;

string sParser(string s) {
    return s.substr(1, s.size()-2);
}

%}

WS	    [ \t\n]
D       [0-9]
L       [a-zA-Z_]
INT     {D}+
FLOAT   {INT}("."{INT})?([Ee][+-]?{INT})?
ID      ($|{L})(@?({D}|{L})+@?({D}|{L})*@?)*
ID_ERR  ({D}|{L}|@|$)*($|@)*
FOR     [Ff][Oo][Rr]
IF      [Ii][Ff]
MAIG    >=
MEIG    <=
IG      ==
DIF     !=
AS_SIM  \'(\\.|(\'\')*|[^'\\])*\'
AS_DUP  \"(\\.|(\"\")*|[^"\\])*\"
EXPR    $\{[^\n]*\}
STRING  {AS_SIM}|{AS_DUP}
STRING2 \`((.|\n)*)\`
COMENT  (\/\*|\/\/)([^*]*|(\*+[^/]))*\*\/

%%
    /* Padrões e ações. Nesta seção, comentários devem ter um tab antes */

{WS}	    { /* ignora espaços, tabs e '\n' */ } 

{FOR}       { lexema = yytext; return _FOR; }

{IF}        { lexema = yytext; return _IF; }

{INT}       { lexema = yytext; return _INT; } 

{FLOAT}     { lexema = yytext; return _FLOAT; }

{MAIG}      { lexema = yytext; return _MAIG; }

{MEIG}      { lexema = yytext; return _MEIG; }

{IG}        { lexema = yytext; return _IG; }

{DIF}       { lexema = yytext; return _DIF; }

{EXPR}      { lexema = yytext; return _EXPR; }

{STRING2}   { lexema = sParser(yytext); return _STRING2; }

{STRING}    { lexema = sParser(yytext); return _STRING; }

{COMENT}    { lexema = yytext; return _COMENTARIO; }

{ID}        { lexema = yytext; return _ID; }

{ID_ERR}    { printf("Erro: Identificador inválido: %s\n", yytext); }

.           { lexema = yytext; return *yytext; 
          /* Essa deve ser a última regra. Dessa forma qualquer caractere isolado será retornado pelo seu código ascii. */ }

%%

/* Não coloque nada aqui - a função main é automaticamente incluída na hora de avaliar e dar a nota. */