all : ocamloml

omlIntro : 
	ocamlc -o omlIntro.cmo -c src/omlIntro.ml

omlEnum : omlIntro
	ocamlc -o omlEnum.cmo -c src/omlEnum.ml 

oml : omlEnum 
	ocamlc -o oml.cmo -I src/ -c omlIntro.cmo omlEnum.cmo src/oml.ml
	ocamlc -o oml.cma -I src/ -a omlIntro.cmo omlEnum.cmo oml.cmo

ocamloml : oml
	ocamlmktop -custom -o ocamloml oml.cma
	rm *.cmo
	rm *cmi 

clean : 
	rm *.cm*
	rm ocamloml