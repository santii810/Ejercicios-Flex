#!/bin/bash
rm salida.txt
clear
flex entrega.l
gcc -o entrega lex.yy.c diccionario.c
./entrega pruebas.txt salida.txt
cat salida.txt
echo ""
echo ""

