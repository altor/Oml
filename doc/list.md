#Oml.List
Ce module étend le module List. Le type proposé par les extensions est `'a Oml.List.t` mais il est compatible à 100% avec le type `'a list`.

##Fonctions ajoutées

*    **Oml.List.init**  
     `int -> (int -> 'a) -> 'a list`  
     Construit une liste en appliquant la fonction passée en argument à chaque indice.


*    **Oml.List.make**  
     `int -> 'a -> 'a list`  
     Construit une liste de la taille passée en argument, remplie de la valeut passée en (deuxième) argument.

*    **Oml.List.copy**  
     `'a list -> 'a list`  
     Renvoi une copie de la liste passée en argument.


*    **Oml.List.reverse**  
     `'a list -> 'a list`  
     Renvoi la liste passé en argument retourné.


*    **Oml.List.range**  
     `int -> int -> int list`  
     Renvoi une liste contenant les entiers du premier argument au dernier argument.


*    **Oml.List.of_string**  
     `string -> char list`  
     Renvoi l'image d'une chaine de caractères en liste de caractères.


*    **Oml.List.of_array**  
     `'a array -> 'a list`  
     Renvoi l'image d'un tableau en liste.


*    **Oml.List.of_list**  
     `'a list -> 'a list`   
     Alias de `Oml.List.copy`.


*    **Oml.List.to_string**  
     `char list -> string`   
     Renvoi l'image d'une liste de caractères en chaine de caractères.


*    **Oml.List.to_array**  
     `'a list -> 'a array`   
     Renvoi l'image d'une liste en tableau.


*    **Oml.List.to_list**  
     `'a list -> 'a list`   
     Alias de `Oml.List.copy`.


*    **Oml.List.sum**  
     `int list ->  int`   
     Renvoi la somme de tous les éléments de la liste passée en argument. (en entier, avec des entiers)


*    **Oml.List.prod**  
     `int list ->  int`   
     Renvoi le produit de tous les éléments de la liste passée en argument. (en entier avec des entiers)


*    **Oml.List.sumf**  
     `float list ->  float`   
     Renvoi la somme de tous les éléments de la liste passée en argument. (en float, avec des floats)



*    **Oml.List.prodf**  
     `float list ->  float`   
     Renvoi le produit de tous les éléments de la liste passée en argument. (en float, avec des floats)


*    **Oml.List.each**  
     `('a -> unit) -> 'a list -> unit`   
     Applique une fonction à chaque itération d'une liste.


*    **Oml.List.each_with_index**  
     `(int -> 'a -> unit) -> 'a list -> unit`   
     Applique une fonction à chaque itération, dont le premier argument de la fonction est l'indice de la liste, d'une liste.


*    **Oml.List.any**  
     `('a -> bool) -> 'a list -> bool`   
     Vérifie si au moins un élément satisfait le prédicat passé en argument.

*    **Oml.List.all**  
     `('a -> bool) -> 'a list -> bool`   
     Vérifie si tous les éléments satisfont le prédicat passé en argument.

*    **Oml.List.elem**  
     `'a -> 'a list -> bool`   
     Vérifie si l'élément est contenu dans la liste.

*    **Oml.List.head**  
     `'a list -> 'a`   
     Renvoi le premier élément de la liste (`List.hd`).

*    **Oml.List.last**  
     `'a list -> 'a`   
     Renvoi le dernier élément d'une liste.

*    **Oml.List.tail**  
     `'a list -> 'a list`   
     Renvoi tous les éléments sauf le premier (`List.tl`).

*    **Oml.List.firsts**  
     `'a list -> 'a list`   
     Renvoi tous les éléments sauf le dernier.


*    **Oml.List.at**  
     `'a list -> int -> 'a`   
     Renvoi l'élément à la position passée en argument.


*    **Oml.List.set**  
     `'a list -> int -> 'a -> 'a list`   
     Renvoi la liste passé en argument avec une modification de la valeur à l'indice donné, par la valeur donnée.


*    **Oml.List.neutral**  
     `'a list`   
     Renvoi une liste vide.


*    **Oml.List.return**  
     `'a -> 'a list`   
     Construit un singleton composé par l'argument.


*    **Oml.List.bind**  
     `'a list -> ('a -> 'b) -> 'b list`   
     Applique une fonction à chaque élément d'une liste (et renvoi la liste modifiée).
