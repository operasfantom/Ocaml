#.PHONY: all run parser lexer

all:Program.exe

lexer:
	ocamllex src/LogicLexer.mll
parser:
	ocamlyacc src/LogicParser.mly

Program.exe: lexer parser
	ocamlc src/Tree.ml src/LogicLexer.mll src/LogicParser.mly src/Program.ml -o out/Program.exe
run: Program.exe
	Program.exe