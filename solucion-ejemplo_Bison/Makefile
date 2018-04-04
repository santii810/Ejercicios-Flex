calc:	calc.tab.c calc.lex.c
	gcc -o calc calc.tab.c lex.yy.c diccionario.c -lm
calc.tab.c:	calc.y
	bison -dv calc.y
calc.lex.c:	calc.l
	flex calc.l
clean:
	rm  calc.tab.c calc.tab.h calc.output lex.yy.c calc