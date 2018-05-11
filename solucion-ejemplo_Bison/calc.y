%{ /* Codigo C */
#include <stdio.h>
#include <math.h>
#include "diccionario.h"
DICCIONARIO diccionario; /* variable global para el diccionario */
%}

/* Declaraciones de BISON */
%union {
  int valor_entero;
  double valor_real;
  char * texto;
}

%left OR
%left AND
%left EQ NE LE GE '<' '>'

%left '-' '+'
%left '*' '/'
%right '^'
%left SIN COS TAN

%token <valor_real> CONSTANTE_REAL
%token <valor_entero> CONSTANTE_ENTERA
%token <texto> IDENTIFICADOR

%type <valor_real> expresion
%type <valor_entero> condicion cond_simple

%%
/* Gramatica */
lineas: /* cadena vacia */
  | lineas linea
;

linea: '\n'
  | IDENTIFICADOR '=' expresion '\n'              { insertar_diccionario(&diccionario, $1, $3); 
                                                    printf("%f\n",$3); }
  | expresion '\n'                                { printf ("%f\n", $1); }
  | error '\n'                                    { yyerrok; }
;

condicion: cond_simple                            { $$ = $1; }
  | '(' condicion ')'                             { $$ = $2; }
  | condicion AND condicion                       { $$ = $1*$3; }
  | condicion OR condicion                        { $$ = $1+$3; }
;

cond_simple: expresion '<' expresion              { if ($1 < $3) { $$ = 1; }
                                                    else {$$ = 0; } }
  | expresion '>' expresion                       { if ($1 > $3) { $$ = 1; }
                                                    else {$$ = 0; } }
  | expresion EQ expresion                        { if ($1 == $3) { $$ = 1; }
                                                    else {$$ = 0; } }
  | expresion NE expresion                        { if ($1 != $3) { $$ = 1; }
                                                    else {$$ = 0; } }
  | expresion LE expresion                        { if ($1 <= $3) { $$ = 1; }
                                                    else {$$ = 0; } }
  | expresion GE expresion                        { if ($1 >= $3) { $$ = 1; }
                                                    else {$$ = 0; } }
  ;

expresion: CONSTANTE_REAL                         { $$ = $1; }
  | CONSTANTE_ENTERA                              { $$ = (double) $1; }
  | IDENTIFICADOR                                 { ENTRADA * entrada = buscar_diccionario(&diccionario,$1);
                                                    if (entrada != NULL) { $$ = entrada->valor; }
                                                    else { printf("ERROR: variable %s no definida\n", $1); $$ = 0; } }
  | expresion '+' expresion                       { $$ = $1 + $3; }
  | expresion '-' expresion                       { $$ = $1 - $3; }
  | expresion '*' expresion                       { $$ = $1 * $3; }
  | expresion '/' expresion                       { $$ = $1 / $3; }
  | expresion '^' expresion                       { $$ = pow($1,$3); }
  | SIN '(' expresion ')'                         { $$ = sin($3); }
  | COS '(' expresion ')'                         { $$ = cos($3); }
  | TAN '(' expresion ')'                         { $$ = tan($3); }
  | '-' expresion                                 { $$ = - $2; }
  | '(' expresion ')'                             { $$ = $2; }
  | '(' condicion '?' expresion ':' expresion ')' { $$ = ($2 ? $4 : $6); }
;

%%

int main(int argc, char** argv) {
  inicializar_diccionario(&diccionario);
  yyparse();
  liberar_diccionario(&diccionario);
}

int yyerror (char *s) { printf ("%s\n", s); }

int yywrap() { return 1; }

