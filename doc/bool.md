#Oml.Bool
Ce module décrit les opérations primitives sur les booléens. (Le type Oml.Bool.t est est un booléen et est compatible avec les fonctions qui traitent des booléens).

##Fonctions du modules


*    **Oml.List.of_int**  
     `int -> bool`  
     Renvoi l'image booléenne d'un entier.  
     ```ocaml
     0 = false
     x = true
     ```

*    **Oml.List.of_float**  
     `int -> bool`  
     Renvoi l'image booléenne d'un float.


*    **Oml.List.of_bool**  
     `bool -> bool`  
     Copie un booléen.

*    **Oml.List.of_string**  
     `string -> bool`  
     Renvoi l'image booléenne d'une chaine de caractère.


*    **Oml.List.of_char**  
     `char -> bool`  
     Renvoi l'image booléenne d'un caractère (`'0'` pour `false`).


*    **Oml.List.to_int**  
     `bool -> int`  
     Renvoi l'image entière d'un booléen.


*    **Oml.List.to_float**  
     `bool -> float`  
     Renvoi l'image float d'un booléen.


*    **Oml.List.to_bool**  
     `bool -> bool`  
     Copie un booléen.


*    **Oml.List.to_string**  
     `bool -> string`  
     Renvoi l'image chaine de caractère d'un booléen.


*    **Oml.List.to_char**  
     `bool -> char`  
     Renvoi l'image caractère d'un booléen.


*    **Oml.List.inv**  
     `bool -> bool`  
      Inverse un booléen.


*    **Oml.List.succ**  
     `?step:bool -> bool -> bool`  
     Renvoi le successeur d'un booléen (successeur de `true` = `false` et inversemment.) (Le `step` est un argument facultatif servant plus les numériques, partageant cette interface avec les booléens).


*    **Oml.List.pred**  
     `?step:bool -> bool -> bool`  
     Renvoi le prédécesseur d'un booléen (successeur de `true` = `false` et inversemment.) (Le `step` est un argument facultatif servant plus les numériques, partageant cette interface avec les booléens).