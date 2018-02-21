%{ 
   #include <string.h>
   #include <stdlib.h>
   #include "diccionario.h"
   
   DICCIONARIO diccionario;
   char nombre[255];

%}

%x COM
%x ID
%x CONST

SP             [ \t]
IDENTITICADOR  [A-Za-z_][A-Za-z_0-9]*

%%


^({SP}*\n)+                        fputc('\n',yyout);
^{SP}+                             fprintf(yyout,"%s",yytext);
{SP}+$                             ;
{SP}+                              fputc(' ',yyout);

\"[^"]*\"                          fprintf(yyout,"%s",yytext);;

{SP}*"/*"                          BEGIN COM;
<COM>.|\n                          ;
<COM>"*/"({SP}*\n)*                BEGIN 0;

^{SP}*"//".*\n                     ;
{SP}*"//".*                        ;

{SP}*"#include".*\n                ;

{SP}*"#define"{SP}+                BEGIN ID;
<ID>{IDENTITICADOR}                { ENTRADA * entrada = buscar_diccionario(&diccionario,yytext);
                                     if (entrada != NULL) {
                                       printf("identificador repetido: %s\n",yytext);
                                       exit(0);
                                       }
                                     else {
                                       strcpy(nombre,yytext);
                                       }
                                   }
<ID>{SP}+                          BEGIN CONST;
<CONST>[^ \t\n]+                   insertar_diccionario(&diccionario, nombre, yytext);
<CONST>{SP}*\n                     BEGIN INITIAL;

{IDENTITICADOR}                    { ENTRADA * entrada = buscar_diccionario(&diccionario,yytext);
                                     if (entrada == NULL) {
                                       fprintf(yyout,"%s",yytext);
                                       }
                                     else {
                                       fprintf(yyout,"%s",entrada->valor);
                                       }
                                   }

.|\n                               fprintf(yyout,"%s",yytext);;

%%

int yywrap() 
{ 
    return 1; 
}

int main(int argc, char *argv []) 
{
  yyin = fopen(argv[1],"r");
  yyout = fopen(argv[2],"w");
  
  inicializar_diccionario(&diccionario);
  yylex();
  liberar_diccionario(&diccionario);

  fclose(yyin);
  fclose(yyout);
}