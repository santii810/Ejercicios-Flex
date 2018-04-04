 
%{

  #include <stdio.h>
  extern FILE *yyin;
  extern int yylex();

  #define YYDEBUG 1

%}

%token ABSTRACTO AND ASOCIATIVA BOOLEANO CABECERA CADENA CASO CARACTER CARGA CLASE CONJUNTO CONSTANTE CUERPO CTC_BOOLEANA CTC_CADENA CTC_CARACTER CTC_ENTERA CTC_REAL CONSTRUCTOR CUANDO CUATRO_PTOS DESCENDENTE DESPD DESPI DESTRUCTOR DE DEVOLVER DOS_PTOS EJECUTA ELEMENTO EN ENTERO ENTONCES EQ ES ESPECIFICO EXCEPTO FICHERO FINAL FINALMENTE FLECHA_DOBLE FUNCION GEQ GENERICO HASTA IDENTIFICADOR INTERFAZ LANZAR LEQ LISTA MIENTRAS MODIFICABLE NEQ OTRO OR PAQUETE PARA PATH POTENCIA PRIVADO PROBAR PROCEDIMIENTO PROGRAMA PUBLICO REAL REGISTRO REPITE SALIR SEMIPUBLICO SI SINO TIPO VARIABLE

%%

/************************/
/* programas y paquetes */
/************************/

programa
    : definicion_programa                                 { printf ("EXITO: programa -> def_prog\n"); }
    | definicion_paquete                                  { printf ("EXITO: programa -> def_paq\n"); }
    ;

definicion_programa
    : PROGRAMA nombre ';' bloque_programa                 { printf ("  def_prog -> PROG nombre bloq_prog\n"); }
    ;

nombre
    : IDENTIFICADOR                                       { printf ("  nombre -> IDENTIFICADOR\n"); }
    | nombre CUATRO_PTOS IDENTIFICADOR                    { printf ("  nombre -> IDENTIFICADOR '::' nombre\n"); }
    ;

bloque_programa
    : declaracion_cargas
      declaracion_tipos
      declaracion_constantes
      declaracion_variables
      bloque_instrucciones            { printf ("  bloq_prog -> declr_cargas declr_tipos declr_cons declr_vars blq_intrs\n"); }
    ;

definicion_paquete
    : PAQUETE nombre ';'
      seccion_cabecera
      seccion_cuerpo                  { printf ("  def_paq -> PAQUETE nom ';' seccion_cab seccion_cuerpo\n"); }
    ;

seccion_cabecera
    : CABECERA
      declaracion_cargas
      declaracion_tipos
      declaracion_constantes
      declaracion_variables
      declaracion_interfaces          { printf ("  seccion_cab -> declr_cargas declr_tipos declr_cons declr_vars declr_interfs\n"); }
    ;

seccion_cuerpo
    : CUERPO
      declaracion_tipos
      declaracion_constantes
      declaracion_variables
      declaraciones_subprogramas      { printf ("  seccion_cuerpo -> declr_tipos declr_cons declr_vars declrs_subprgs\n"); }
    ;

/**********/
/* cargas */
/**********/


/*********/
/* tipos */
/*********/


/**************/
/* constantes */
/**************/


/*************/
/* variables */
/*************/


/**************/
/* interfaces */
/**************/


/**********/
/* clases */
/**********/


/****************/
/* subprogramas */
/****************/


/*****************/
/* instrucciones */
/*****************/


/***************/
/* expresiones */
/***************/


%%

int yyerror(char *s) {
  fflush(stdout);
  printf("***************** %s\n",s);
  }

int yywrap() {
  return(1);
  }

int main(int argc, char *argv[]) {

  yydebug = 0;

  if (argc < 2) {
    printf("Uso: ./stupido NombreArchivo\n");
    }
  else {
    yyin = fopen(argv[1],"r");
    yyparse();
    }
  }
