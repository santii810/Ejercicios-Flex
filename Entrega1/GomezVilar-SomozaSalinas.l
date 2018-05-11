
%{ 
   #include <string.h>
   #include <stdlib.h>
   int linea = 1;
 char cadena[256] = "";

%}

%x COM
%x CAD


C_ESCAPE 	(\\'|\\?|\\\\|\\a|\\b|\\f|\\n|\\r|\\t|\\v)
C_DECIMAL	([0-1]?[0-9]{1,2}|2[0-4][0-9]|25[0-5])
C_HEXADECIMAL	(?i:\\x[0-9a-f]{1,2})
C_OCTAL		\\[0-3]?[0-7]{1,2}
CARACTER	[a-zA-Z ,;.:-_+*!·#$%&¬=?¡¿/]
ENTEROS 	[+-]?[0-9]+
DECIMALES 	[+-]?[0-9]*\.[0-9]+
IDENTIFICADOR 	[a-zA-Z_0-9]
EXPONENTE	({ENTEROS}|{DECIMALES})[eE][+-]?{ENTEROS}
CARACTERES	({C_ESCAPE}|{C_HEXADECIMAL}|{C_DECIMAL}|{C_OCTAL}|{CARACTER})
PATHS		\"("/"|"./"|"../"){CARACTERES}+\"
DELIMITADORES	([{}():;,|]|"::"|".."|"=>")
OP_COMPUESTOS	(\*{2}|<=|>=|:=|!=|<-|->|\/\\|\\\/)
OP_SIMPLES	([=+*-/%^@&<>!]|\[|\])
COM_LINEA	(\/\/.*\n)
COM_MULTILINEA	\/\*
CADENAS		.*\\
RESERVADAS	(abstracto|asociativa|booleano|cabecera|cadena|caso|caracter|clase|conjunto|constante|cuerpo|constructor|cuando|descendente|destructor|de|devolver|carga|elemento|ejecuta|en|entero|entonces|es|especifico|excepto|fichero|final|finalmente|funcion|generico|hasta|interfaz|lanzar|lista|mientras|modificable|otro|paquete|para|privado|probar|procedimiento|programa|publico|real|registro|repite|salir|semipublico|si|sino|tipo|variable)







%%
{PATHS}			printf("\nlinea %d, path: %s", linea, yytext);
'{CARACTERES}'		printf("\nlinea %d, caracter: %s", linea, yytext);

'{CADENAS}		BEGIN(CAD);strcat(cadena, yytext);
<CAD>\n			linea++;	strcat(cadena, yytext);
<CAD>.*'		BEGIN 0;	strcat(cadena, yytext);	printf("\nlinea %d, cadena: %s", linea, cadena);
<CAD>{CADENAS}		strcat(cadena,yytext);

{COM_MULTILINEA}	BEGIN(COM);
<COM>\n			linea++;
<COM>.			;
<COM>\*\/		BEGIN 0;

{COM_LINEA}		linea++;

{EXPONENTE}		printf("\nlinea %d, constante real: %s", linea, yytext);
{DECIMALES}		printf("\nlinea %d, constante real: %s", linea, yytext);
{ENTEROS}		printf("\nlinea %d, constante entera: %s", linea, yytext);
{DELIMITADORES}		printf("\nlinea %d, delimitador: %s", linea, yytext);	
{OP_COMPUESTOS}		printf("\nlinea %d, operador: %s", linea, yytext);	
{OP_SIMPLES}		printf("\nlinea %d, operador: %s", linea, yytext);

(?i:{RESERVADAS})		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
[a-zA-Z_]{IDENTIFICADOR}*	printf("\nlinea %d, identificador: %s", linea, yytext);
\n				linea++;
(" "|\t)*			;
.				;



%%



int yywrap() 
{ 
   	return 1; 
}

int main(int argc, char *argv []) 
{
  yyin = fopen(argv[1],"r");
  yylex();
  printf("\n\n");
  fclose(yyin);
}
