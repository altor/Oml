all : ocamloml

omlIntro : 
	ocamlc -o omlIntro.cmo -c src/omlIntro.ml

omlEnum : omlIntro
	ocamlc -o omlEnum.cmo -c src/omlEnum.ml 

omlPrimitive : omlEnum
	ocamlc -o omlPrimitive.cmo -c src/omlPrimitive.ml 

omlFile : omlPrimitive
	ocamlc -o omlFile.cmo -c src/omlFile.ml

oml : omlFile
	ocamlc -o oml.cmo -I src/ -c omlIntro.cmo omlEnum.cmo omlPrimitive.cmo omlFile.cmo src/oml.ml
	ocamlc -o oml.cma -I src/ -a omlIntro.cmo omlEnum.cmo omlPrimitive.cmo omlFile.cmo oml.cmo

ocamloml : oml
	ocamlmktop -custom -o ocamloml oml.cma


clean : 
	rm *.cm*
	rm ocamloml