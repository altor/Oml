#Oml.Char
Ce module décrit les opérations primitives sur les caractères. Il étend le module `Char` (documenté sur le site de CaML).

##Fonctions du modules


*    **Oml.Char.of_int**  
     `int -> char`  
     Renvoi l'image caractère d'un entier.


*    **Oml.Char.of_int_value**  
     `int -> char`  
     Renvoi l'entier convertit en caractère (en conservant sa valeur).  
     Par exemple, `5` donnera `'5'`.


*    **Oml.Char.of_float**  
     `int -> char`  
     Renvoi l'image caractère d'un float.


*    **Oml.Char.of_bool**  
     `char -> bool`  
     Renvoi un caractère selon un booléen.

*    **Oml.Char.of_string**  
     `string -> char`  
     Renvoi l'image caractère d'une chaine de caractère.


*    **Oml.Char.of_char**  
     `char -> char`  
     Copie un caractère.


*    **Oml.Char.to_int**  
     `char -> int`  
     Renvoi l'image entière d'un caractère.


*    **Oml.Char.to_int_value**  
     `char -> int`  
     Renvoi l'image caractère d'un entier (en conservant sa valeur).


*    **Oml.Char.to_float**  
     `char -> float`  
     Renvoi l'image float d'un caractère.


*    **Oml.Char.to_bool**  
     `char -> bool`  
     Renvoi l'image booléenne d'un caractère.


*    **Oml.Char.to_string**  
     `char -> string`  
     Renvoi l'image chaine de caractère d'un caractère.


*    **Oml.Char.to_char**  
     `char -> char`  
     Copie un caractère.


*    **Oml.Char.succ**  
     `?step:char -> char -> char`  
     Renvoi le successeur d'un caractère, l'argument facultatif (`step`) permet de définir un pas.



*    **Oml.Char.pred**  
     `?step:char -> char -> char`  
     Renvoi le prédécesseur d'un caractère, l'argument facultatif (`step`) permet de définir un pas.