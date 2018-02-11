%{ 
	#include <diccionario.h>
%} 



%%
\n{2,}	;
%%


int yywrap() 
{ 
    return 1; 
} 

int main(int argc, char **argv) 
{ 
	argc--;
	argv++;
	if(argc >0){
		yyin = fopen(argv[0],"r");
		yyout = fopen(argv[1],"w");
	}else{
		yyin = stdin;
	}
	while (yylex()); 
    	return 0;
}
