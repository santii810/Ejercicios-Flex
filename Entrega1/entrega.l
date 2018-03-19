
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


%%
{PATHS}			printf("\nlinea %d, path: %s", linea, yytext);
'{CARACTERES}'		printf("\nlinea %d, caracter: %s", linea, yytext);
'{CADENAS}		BEGIN(CAD);strcat(cadena, yytext);
<CAD>\n			linea++;strcat(cadena, yytext);
<CAD>.*'		BEGIN 0;strcat(cadena, yytext); printf("\nlinea %d, cadena: %s", linea, cadena);
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


(?i:abstracto)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:asociativa)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:booleano)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:cabecera)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:cadena)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:caso)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:caracter)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:clase)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:conjunto)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:constante)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:cuerpo)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:constructor)	printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:cuando)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:descendente)	printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:destructor)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:de)			printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:devolver)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:carga)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:elemento)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:ejecuta)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:en)			printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:entero)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:entonces)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:es)			printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:especifico)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:excepto)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:fichero)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:final)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:finalmente)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:funcion)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:generico)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:hasta)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:interfaz)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:lanzar)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:lista)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:mientras)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:modificable)	printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:otro)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:paquete)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:para)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:privado)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:probar)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:procedimiento)	printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:programa)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:publico)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:real)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:registro)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:repite)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:salir)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:semipublico)	printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:si)			printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:sino)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:tipo)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);
(?i:variable)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);




[a-zA-Z_]{IDENTIFICADOR}*	printf("\nlinea %d, identificador: %s", linea, yytext);
\n				linea++;
(" "|\t)*				printf("\nlinea %d, espacio: %s", linea, yytext);
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
