#Oml.String
Ce module propose des fonctionnalités en plus au module `String` de OCaML.

##Fonctions ajoutés

*    **Oml.String.init**  
     `int -> (int -> char) -> string`  
     Construit une chaine de caractère en appliquant la fonction passée en argument à chaque indice.

*    **Oml.String.append**  
     `string -> char -> string`  
     Renvoi une chaine de caractère avec, ajouté à la fin, le caractère passé en argument.

*    **Oml.String.prepend**  
     `char -> string -> string`  
     Renvoi une chaine de caractère avec le caractère passé en argument en ajouté au début.

*    **Oml.String.reverse**  
     `string -> string`  
     Renvoi la chaine de caractère retournée.

*    **Oml.String.of_array**  
     `char array -> string`  
     Renvoi l'image du tableau de caractères en chaine de caractères.


*    **Oml.String.of_int**  
     `int -> string`  
     Renvoi l'image de l'entier en chaine de caractères.


*    **Oml.String.of_float**  
     `float -> string`  
     Renvoi l'image du float en chaine de caractères.


*    **Oml.String.of_bool**  
     `bool -> string`  
     Renvoi l'image du booléen en chaine de caractères.


*    **Oml.String.of_char**  
     `char -> string`  
     Renvoi l'image du caractère en chaine de caractères.


*    **Oml.String.of_list**  
     `char list -> string`  
     Renvoi l'image de la liste de caractères en chaine de caractères.


*    **Oml.String.to_int**  
     `string -> int`  
     Renvoi l'image de la chaine de caractères en entier.


*    **Oml.String.to_float**  
     `string -> float`  
     Renvoi l'image de la chaine de caractères en float.


*    **Oml.String.to_bool**  
     `string -> bool`  
     Renvoi l'image de la chaine de caractères en booléen.


*    **Oml.String.to_char**  
     `string -> char`  
     Renvoi l'image de la chaine de caractères en caractère.


*    **Oml.String.to_list**  
     `string -> char list`  
     Renvoi l'image de la chaine de caractère en liste de caractères.

*    **Oml.String.to_array**  
     `string -> char array`  
     Renvoi l'image de la chaine de caractère en tableau de caractères.

*    **Oml.String.each**  
     `(char -> unit) -> string -> unit`  
     Applique une fonction sur chaque caractère d'une chaine de caractère. (une fonction qui prend en argument un caractère et qui renvoi unit).

*    **Oml.String.each_with_index**  
     `(int -> char -> unit) -> string -> unit`  
     Applique une fonction sur chaque caractère d'une chaine de caractère. (une fonction qui prend en argument l'index de l'élément et un  caractère et qui renvoi unit, le premier argument est l'indice du caractère).


*    **Oml.String.fold_left**  
     `('a -> char -> 'a) -> 'a -> string -> 'a`  
     `fold_left` sur les chaines de caractères.


*    **Oml.String.fold_right**  
     `(char -> 'a -> 'a) -> string -> 'a -> 'a`  
     `fold_right` sur les chaines de caractères.


*    **Oml.String.filter**  
     `(char -> bool) -> string -> string`  
     Construit une chaine de caractères avec tous les caractères qui satisfont le prédicat passé en argument.


*    **Oml.String.all**  
     `(char -> bool) -> string -> bool`  
     Vérifie si tous les caractères satisfont le prédicat passé en argument.


*    **Oml.String.any**  
     `(char -> bool) -> string -> bool`  
     Vérifie si (au moins) un des caractères satisfait le prédicat passé en argument.


*    **Oml.String.elem**  
     `char -> string -> bool`  
     Vérifie si le caractère passé en argument est contenu dans la chaine de caractères passée en argument.


*    **Oml.String.head**  
     `string -> char`  
     Renvoi le premier élément d'une chaine de caractères.


*    **Oml.String.last**  
     `string -> char`  
     Renvoi le dernier élément d'une chaine de caractères.


*    **Oml.String.tail**  
     `string -> string`  
     Renvoi une chaine de caractère (sans sa tête) sur base de la chaine de cractères passée en argument.


*    **Oml.String.firsts**  
     `string -> string`  
     Renvoi une chaine de caractères sans le dernier élément de la chaine de caractère passée en argument.


*    **Oml.String.at**  
     `string -> int -> char`  
     Renvoi l'élement à l'indice passé en argument d'une chaine de caractères.


*    **Oml.String.set**  
     `string -> int -> char -> string`  
     Renvoi une nouvelle chaine dont l'élément à l'indice donné en argument est substitué par le caractère passé en argument.


*    **Oml.String.neutral**  
     `string`  
     Renvoi une chaine de cractères vide.

*    **Oml.String.return**  
     `char -> string`  
     Convertit un caractère en chaine de cractères (singleton).

*    **Oml.String.bind**  
     `string -> (char -> char) -> string`  
     Renvoi le résultat d'une application de la fonction passée en argument sur tous les caractères d'une chaine de caractères.