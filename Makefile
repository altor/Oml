all : ocamloml

omlEnum : 
	ocamlc -o omlEnum.cmo -c src/omlEnum.ml 

oml : omlEnum 
	ocamlc -o oml.cmo -I src/ -c omlEnum.cmo src/oml.ml
	ocamlc -o oml.cma -I src/ -a omlEnum.cmo oml.cmo

ocamloml : oml
	ocamlmktop -custom -o ocamloml oml.cma 

clean : 
	rm *.cm*
	rm ocamloml