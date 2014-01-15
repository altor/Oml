#Oml.Bool
Ce module décrit les opérations primitives sur les booléens. (Le type Oml.Bool.t est est un booléen et est compatible avec les fonctions qui traitent des booléens).

##Fonctions du modules


*    **Oml.Bool.of_int**  
     `int -> bool`  
     Renvoi l'image booléenne d'un entier.  
     ```ocaml
     0 = false
     x = true
     ```

*    **Oml.Bool.of_float**  
     `int -> bool`  
     Renvoi l'image booléenne d'un float.


*    **Oml.Bool.of_bool**  
     `bool -> bool`  
     Copie un booléen.

*    **Oml.Bool.of_string**  
     `string -> bool`  
     Renvoi l'image booléenne d'une chaine de caractère.


*    **Oml.Bool.of_char**  
     `char -> bool`  
     Renvoi l'image booléenne d'un caractère (`'0'` pour `false`).


*    **Oml.Bool.to_int**  
     `bool -> int`  
     Renvoi l'image entière d'un booléen.


*    **Oml.Bool.to_float**  
     `bool -> float`  
     Renvoi l'image float d'un booléen.


*    **Oml.Bool.to_bool**  
     `bool -> bool`  
     Copie un booléen.


*    **Oml.Bool.to_string**  
     `bool -> string`  
     Renvoi l'image chaine de caractère d'un booléen.


*    **Oml.Bool.to_char**  
     `bool -> char`  
     Renvoi l'image caractère d'un booléen.


*    **Oml.Bool.inv**  
     `bool -> bool`  
      Inverse un booléen.


*    **Oml.Bool.succ**  
     `?step:bool -> bool -> bool`  
     Renvoi le successeur d'un booléen (successeur de `true` = `false` et inversemment.) (Le `step` est un argument facultatif servant plus les numériques, partageant cette interface avec les booléens).


*    **Oml.Bool.pred**  
     `?step:bool -> bool -> bool`  
     Renvoi le prédécesseur d'un booléen (successeur de `true` = `false` et inversemment.) (Le `step` est un argument facultatif servant plus les numériques, partageant cette interface avec les booléens).