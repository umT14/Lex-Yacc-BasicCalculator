%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>

#define YYSTYPE double

void yyerror(char *s);
int yylex(void);
int yywrap();

double yylval;

%}

%token NUMBER LPAREN RPAREN EOL
%left PLUS MINUS TIMES DIVIDE
%right POW

%%

line: 
	| line EOL
	| line expr EOL { printf("Result: %f \n" ,$2 ); };

expr: muldiv
	| expr PLUS muldiv { $$ = $1 + $3; }
	| expr MINUS muldiv { $$ = $1 - $3; };


	
muldiv: pow
	| muldiv TIMES pow { $$ = $1 * $3; }
	| muldiv DIVIDE pow { 
		if ($3 != 0) {
			$$ = $1 / $3;
		} else {
			yyerror("Unable to divide zero");
			$$ = 0;
		}
 };

pow: term
	| pow POW term { $$ = pow($1,$3);
};


term: NUMBER { $$ = $1; }
	| LPAREN expr RPAREN { $$ = $2; };


%%
//#include "lex.yy.c"

int main()
{
  printf("Enter expressions:\n");
  return yyparse();
}

void yyerror(char *s)
{
    fprintf( stderr ,"error: %s\n" , s );
}