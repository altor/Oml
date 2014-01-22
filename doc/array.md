#Oml.Array
Ce module étend le module Array. Le type proposé par les extensions est `'a Oml.Array.t` mais il est compatible à 100% avec le type `'a array`.

##Fonctions ajoutées

*    **Oml.Array.reverse**  
     `'a array -> 'a array`  
     Renvoi le tableau passé en argument retourné.


*    **Oml.Array.range**  
     `int -> int -> int array`  
     Renvoi un tableau contenant les entiers du premier argument au dernier argument.


*    **Oml.Array.of_string**  
     `string -> char array`  
     Renvoi l'image d'une chaine de caractères en tableau de caractères.


*    **Oml.Array.of_array**  
     `'a array -> 'a array`  
     Alias de `Array.copy`, renvoi une copie de l'argument.


*    **Oml.Array.of_list**  
     `'a list -> 'a array`   
     Renvoi l'image d'une liste en tableau.


*    **Oml.Array.to_string**  
     `char array -> string`   
     Renvoi l'image d'un tableau de caractères en chaine de caractères.


*    **Oml.Array.to_array**  
     `'a array -> 'a array`   
     Alias de `Array.copy`.


*    **Oml.Array.to_list**  
     `'a array -> 'a list`   
     Renvoi l'image du tableau en liste.


*    **Oml.Array.sum**  
     `int array ->  int`   
     Renvoi la somme de tous les éléments de la liste passée en argument. (en entier, avec des entiers)


*    **Oml.Array.prod**  
     `int array ->  int`   
     Renvoi le produit de tous les éléments de la liste passée en argument. (en entier avec des entiers)


*    **Oml.Array.sumf**  
     `float array ->  float`   
     Renvoi la somme de tous les éléments de la liste passée en argument. (en float, avec des floats)



*    **Oml.Array.prodf**  
     `float array ->  float`   
     Renvoi le produit de tous les éléments de la liste passée en argument. (en float, avec des floats)


*    **Oml.Array.each**  
     `('a -> unit) -> 'a array -> unit`   
     Applique une fonction à chaque itération d'un tableau.


*    **Oml.Array.each_with_index**  
     `(int -> 'a -> unit) -> 'a array -> unit`   
     Applique une fonction à chaque itération, dont le premier argument de la fonction est l'indice du tableau, d'un tableau.


*    **Oml.Array.any**  
     `('a -> bool) -> 'a array -> bool`   
     Vérifie si au moins un élément satisfait le prédicat passé en argument.

*    **Oml.Array.all**  
     `('a -> bool) -> 'a array -> bool`   
     Vérifie si tous les éléments satisfont le prédicat passé en argument.

*    **Oml.Array.elem**  
     `'a -> 'a array -> bool`   
     Vérifie si l'élément est contenu dans le tableau.

*    **Oml.Array.head**  
     `'a array -> 'a`   
     Renvoi le premier élément du tableau.

*    **Oml.Array.last**  
     `'a array -> 'a`   
     Renvoi le dernier élément du tableau.

*    **Oml.Array.tail**  
     `'a array -> 'a array`   
     Renvoi tous les éléments sauf le premier.

*    **Oml.Array.firsts**  
     `'a array -> 'a array`   
     Renvoi tous les éléments sauf le dernier.


*    **Oml.Array.at**  
     `'a array -> int -> 'a`   
     Renvoi l'élément à la position passée en argument.


*    **Oml.Array.set'**  
     `'a array -> int -> 'a -> 'a array`   
     Renvoi une copie du tableau passé en argument avec une modification de la valeur à l'indice donné, par la valeur donnée.


*    **Oml.Array.neutral**  
     `'a array`   
     Renvoi un tableau vide.


*    **Oml.Array.return**  
     `'a -> 'a array`   
     Construit un singleton composé par l'argument.


*    **Oml.Array.bind**  
     `'a array -> ('a -> 'b array) -> 'b array`   
     Opérateur monadique de composition.  
     **Alias** : `Oml.Array.( >>= )


*    **Oml.Array.fmap**  
     `'a array -> ('a -> 'b) -> 'b array`   
     Opérateur monadique de mapping.  
     **Alias** : `Oml.Array.( >>| )
