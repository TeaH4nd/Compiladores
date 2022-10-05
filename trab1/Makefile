all: saida 

lex.yy.c: trab1.lex
	lex trab1.lex

saida: lex.yy.c 
	g++ -Wall -std=c++17 main.cc -lfl
	
clean:
	rm lex.yy.c a.out