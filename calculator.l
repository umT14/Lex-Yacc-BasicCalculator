%{
#define YYSTYPE double

#include <stdio.h>
#include "y.tab.h"

extern double yylval;

%}

%%

[0-9][0-9]*       {yylval = atof(yytext); return NUMBER;}
[0-9]+\.[0-9]+    {yylval = atof(yytext); return NUMBER;}
"+"               return PLUS;
"-"               return MINUS;
"*"               return TIMES;
"/"               return DIVIDE;
"^"		  return POW;	
"**"		  return POW;
"("               return LPAREN;
")"               return RPAREN;
[ \t] 		  {  }
\n		  return EOL;
.		  {printf("unexpected character: %s\n", yytext);}

%%

int yywrap (void) {
	return 1;
}