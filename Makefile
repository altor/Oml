all : toplevel

libc :
	@echo "\n======  Compilation de la bibliothèque C  ======\n"
	gcc -I /usr/local/lib/ocaml/ -c src/oml.c -o oml.o

base : libc
	@echo "\n======  Construction des librairies de base  ======\n"
	ocamlc -o omlMonad.cmo -c src/omlMonad.ml
	ocamlc -custom -o omlPoly.cmo -I ../ -c oml.o src/omlPoly.ml
	ocamlc -o omlIO.cmo -I ../ -c str.cma omlPoly.cmo  src/omlIO.ml
	ocamlc -o omlEnum.cmo -I ../ -c omlMonad.cmo src/omlEnum.ml
	ocamlc -o omlList.cmo -I ../ -c omlEnum.cmo src/omlList.ml
	ocamlc -o omlArray.cmo -I ../ -c omlEnum.cmo src/omlArray.ml
	ocamlc -o omlString.cmo -c Str.cma -I ../ omlArray.cmo omlList.cmo src/omlString.ml 
	ocamlc -o omlNumeric.cmo -c src/omlNumeric.ml
	ocamlc -o omlBool.cmo -I ../ -c omlNumeric.cmo src/omlBool.ml
	ocamlc -o omlInt.cmo -I ../ -c omlNumeric.cmo src/omlInt.ml
	ocamlc -o omlFloat.cmo -I ../ -c omlNumeric.cmo src/omlFloat.ml
	ocamlc -o omlChar.cmo -I ../ -c omlNumeric.cmo src/omlChar.ml
	ocamlc -o omlFile.cmo -I ../ -c omlIO.cmo src/omlFile.ml
	ocamlc -o omlMarshal.cmo -c src/omlMarshal.ml
	ocamlc -o omlDatabase.cmo -c src/omlDatabase.ml

lib : base

	@echo "\n======  Construction de la librairie générale  ======\n"
	ocamlc -custom -o oml.cmo -I ../ -c oml.o omlMonad.cmo omlPoly.cmo omlIO.cmo  omlEnum.cmo omlList.cmo omlArray.cmo omlString.cmo omlBool.cmo omlInt.cmo omlFloat.cmo omlChar.cmo omlFile.cmo omlMarshal.cmo omlDatabase.cmo  src/oml.ml

	ocamlc -o oml.cma -a unix.cma str.cma omlMonad.cmo omlPoly.cmo omlIO.cmo omlEnum.cmo omlList.cmo omlArray.cmo omlString.cmo omlBool.cmo omlInt.cmo omlFloat.cmo omlChar.cmo omlFile.cmo omlMarshal.cmo omlDatabase.cmo  oml.cmo 

toplevel : lib 
	@echo "\n======  Construction du toplevel  ======\n"
	ocamlmktop -custom -o ocamloml oml.o oml.cma

clean : 
	@echo "\n======  Suppression des fichiers  ======\n"
	rm -f *.cm* 
	rm -f *.o
	rm -f ocamloml