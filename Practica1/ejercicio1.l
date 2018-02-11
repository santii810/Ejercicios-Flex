%{ 
   int numMayus = 0, 
	numMinus = 0,
	numPalabras = 0,
	numEnteros = 0,
	numReales = 0,
	sumEnteros = 0;
double sumReales = 0; 


%} 

MAYUS  [A-Z]+
MINUS  [a-z]+
PALABRAS  [A-z]+
REALES   [0-9]+\.[0-9]+
ENTEROS [0-9]+
%% 

{MAYUS}  	numMayus++;
{MINUS}		numMinus++;
{PALABRAS}	numPalabras++;
{REALES} 	numReales++; sumReales += atof(yytext);
{ENTEROS}	numEnteros++; sumEnteros += atoi(yytext);


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

}else{
	yyin = stdin;
}
    while (yylex()); 
    printf("\n\nNo. palabras en mayus: %d.\nNo. palabras en minus: %d\nNo. palabras: %d.\nNo enteros: %d\nNo. reales: %d. \nSum enteros: %d. \nSum reales: %f.\n",		numMayus, numMinus,numPalabras,numEnteros,numReales,sumEnteros,sumReales); 

return 0;
}
