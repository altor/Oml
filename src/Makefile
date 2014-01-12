all : oml

to_out : oml
	mkdir -p out/
	mv *.cm* out/

omlEnum : 
	ocamlc -c omlEnum.ml

oml : omlEnum
	ocamlc -c omlEnum.cmo oml.ml 

clean :
	rm --verbose *.cm*

clean_out : 
	rm --verbose out/*.cm*