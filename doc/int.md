#Oml.Int
Ce module décrit les opérations primitives sur les entiers. (le type `Oml.Int.t` est équivalent au type `int`).


##Variables du modules

*    `Oml.Int.zero` : `0`
*    `Oml.Int.One` : `1`
*    `Oml.Int.max_value` : Renvoi la plus grande valeur entière
*    `Oml.Int.min_value` : Renvoi la plus petite valeur entière

##Fonctions du modules


*    **Oml.Int.of_int**  
     `int -> int`  
     Copie entier.


*    **Oml.Int.of_float**  
     `float -> int`  
     Renvoi l'image entière d'un float.


*    **Oml.Int.of_bool**  
     `bool -> int`  
     Renvoi un entier selon un booléen.

*    **Oml.Int.of_string**  
     `string -> int`  
     Renvoi l'image entière d'une chaine de caractère.


*    **Oml.Int.of_char**  
     `char -> int`  
     Renvoi l'image entière d'un caractère.


*    **Oml.Int.to_int**  
     `int -> int`  
     Copie un entier.


*    **Oml.Int.to_float**  
     `int -> float`  
     Renvoi l'image float d'un entier.


*    **Oml.Int.to_bool**  
     `int -> bool`  
     Renvoi l'image booléenne d'un entier.


*    **Oml.Int.to_string**  
     `int -> string`  
     Renvoi l'image chaine de caractère d'un entier.


*    **Oml.Int.to_char**  
     `int -> char`  
     Renvoi l'image d'un caractère selon un entier.


*    **Oml.Int.succ**  
     `?step:int -> int -> int`  
     Renvoi le successeur d'un entier, l'argument facultatif (`step`) permet de définir un pas.



*    **Oml.Int.pred**  
     `?step:int -> int -> int`  
     Renvoi le prédécesseur d'un entier, l'argument facultatif (`step`) permet de définir un pas.


*    **Oml.Int.abs**  
     `int -> int`  
     Renvoi la valeur absolue d'un entier.


*    **Oml.Int.modulo**  
     `int -> int -> int`  
     Renvoi le reste de la division euclidienne.  
     **Alias**: `Oml.Int.rem`


*    **Oml.Int.pow**  
     `int -> int -> int`  
     Renvoi un entier mis à une puissance.


*    **Oml.Int.sqrt**  
     `int -> int`  
     Renvoi la racine carrée de l'entier passé en argument.

