stupido:	stupido.tab.c stupido.lex.c
	gcc -o stupido stupido.tab.c lex.yy.c -lm
stupido.tab.c:	stupido.y
	bison -dv stupido.y
stupido.lex.c:	stupido.l
	flex stupido.l
clean:
	rm  stupido.tab.c stupido.tab.h stupido.output lex.yy.c stupido
