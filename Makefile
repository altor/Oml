all : ocamloml

omlIntro : 
	ocamlc -o omlIntro.cmo -c src/omlIntro.ml

omlIO : omlIntro
	gcc -I /usr/local/lib/ocaml/ -c src/oml.c -o oml.o
	ocamlc -custom oml.o -c src/omlIO.ml -o omlIO.cmo

omlEnum : omlIO
	ocamlc -o omlEnum.cmo -c src/omlEnum.ml 

omlPrimitive : omlEnum
	ocamlc -o omlPrimitive.cmo -c src/omlPrimitive.ml 

omlFile : omlPrimitive
	ocamlc -o omlFile.cmo -I src/ -c omlEnum.cmo omlIO.cmo src/omlFile.ml

omlParser : omlFile 
	ocamlc -o omlParser.cmo -c str.cma src/omlParser.ml

omlMarshal : omlParser
	ocamlc -o omlMarshal.cmo -c src/omlMarshal.ml

oml : omlMarshal
	ocamlc -custom -o oml.cmo -I src/ -c oml.o omlIO.cmo omlIntro.cmo omlEnum.cmo omlPrimitive.cmo omlFile.cmo omlParser.cmo omlMarshal.cmo src/oml.ml
	ocamlc -o oml.cma -I src/ -a str.cma unix.cma omlIO.cmo  omlIntro.cmo omlEnum.cmo omlPrimitive.cmo omlFile.cmo omlParser.cmo omlMarshal.cmo oml.cmo

ocamloml : oml
	ocamlmktop -custom -o ocamloml oml.o oml.cma

clean : 
	rm *.cm*
	rm ocamloml
	rm oml.o