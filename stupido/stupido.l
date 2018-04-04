%{
#include <stdio.h>
#include "stupido.tab.h"

%}



%%




[ \t]                                    ;

\n                                       linea++;

.                                        printf ("linea %d, ERROR\n",linea);

%%
