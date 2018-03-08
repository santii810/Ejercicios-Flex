
%{ 
   #include <string.h>
   #include <stdlib.h>
   #include "diccionario.h"
   
   DICCIONARIO diccionario;
   char nombre[255];
	int linea = 0;

%}

RESERVADAS abstracto | asociativa | booleano | cabecera | cadena | caso | caracter | clase | conjunto | constante | cuerpo | constructor | cuando | descendente | destructor | de | devolver | carga | elemento | ejecuta | en | entero | entonces | es | especifico | excepto | fichero | final | finalmente | funcion | generico | hasta | interfaz | lanzar | lista | mientras | modificable | otro | paquete | para | privado | probar | procedimiento | programa | publico | real | registro | repite | salir | semipublico | si | sino | tipo | variable





%%
\n			linea++;
(?i:abstracto)		printf("\nlinea %d, palabra reservada: %s", linea, yytext);






%%

int yywrap() 
{ 
	linea = 0;
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
