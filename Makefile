#.PHONY: all build run zip clean
OCAMLC=ocamlc
ARCHIVE=hw1.zip

all: build

build: Program.exe

run:
	./Program.exe

lexer: src/LogicLexer.mll
	ocamllex src/LogicLexer.mll

parser: src/LogicParser.mly
	ocamlyacc src/LogicParser.mly

Program.exe: lexer parser
	cd src && $(OCAMLC) LogicTree.ml LogicParser.mli LogicParser.ml LogicLexer.ml Program.ml -o ../Program.exe

clean:
	rm -f src/LogicLexer.ml src/LogicParser.mli src/LogicParser.ml src/*.c* out/Program.exe

zip: clean
	zip $(ARCHIVE) -r Makefile src


