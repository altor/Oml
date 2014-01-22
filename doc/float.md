#Oml.Float
Ce module décrit les opérations primitives sur les `float`. (le type `Oml.Float.t` est équivalent au type `float`).


##Variables du modules

*    `Oml.Float.zero` : `0.0`
*    `Oml.Float.One` : `1.0`

##Fonctions du modules


*    **Oml.Float.of_int**  
     `int -> float  
     Renvoi l'image flottante selon un entier.


*    **Oml.Float.of_float**  
     `float -> float`  
     Copie un flottant.


*    **Oml.Float.of_bool**  
     `bool -> float`  
     Renvoi un flottant selon un booléen.


*    **Oml.Float.of_string**  
     `string -> float`  
     Renvoi l'image flottante d'une chaine de caractère.


*    **Oml.Float.of_char**  
     `char -> float`  
     Renvoi l'image flottante d'un caractère.


*    **Oml.Float.to_int**  
     `float -> int`  
     Renvoi l'image entière d'un flottant.


*    **Oml.Float.to_float**  
     `float -> float`  
     Copie un flottant.


*    **Oml.Float.to_bool**  
     `float -> bool`  
     Renvoi l'image booléenne d'un flottant.


*    **Oml.Float.to_string**  
     `float -> string`  
     Renvoi l'image chaine de caractère d'un flottant.


*    **Oml.Float.to_char**  
     `float -> char`  
     Renvoi l'image d'un caractère selon un flottant.


*    **Oml.Float.succ**  
     `?step:float -> float -> float`  
     Renvoi le successeur d'un flottant, l'argument facultatif (`step`) permet de définir un pas.



*    **Oml.Float.pred**  
     `?step:float -> float -> float`  
     Renvoi le prédécesseur d'un flottant, l'argument facultatif (`step`) permet de définir un pas.


*    **Oml.Float.abs**  
     `float -> float`  
     Renvoi la valeur absolue d'un flottant.


*    **Oml.Float.modulo**  
     `float -> float -> float`  
     Renvoi le reste de la division euclidienne.  
     **Alias**: `Oml.Floa.rem`


*    **Oml.Float.pow**  
     `float -> float -> float`  
     Renvoi un flotta,t mis à une puissance.


*    **Oml.Float.sqrt**  
     `float -> float`  
     Renvoi la racine carré d'un flottant passé en argument.


*    **Oml.Float.exp**  
     `float -> float`  
     Renvoi l'exponentielle d'un flottant passé en argument.


*    **Oml.Float.log**  
     `float -> float`  
     Renvoi le logarithme d'un flottant passé en argument.


*    **Oml.Float.log10**  
     `float -> float`  
     Renvoi le logarithme base 10 d'un flottant passé en argument.


*    **Oml.Float.cos**  
     `float -> float`  
     Renvoi le cosinus (Argument en radian) d'un flottant passé en argument.


*    **Oml.Float.sin**  
     `float -> float`  
     Renvoi le sinus (Argument en radian) d'un flottant passé en argument.


*    **Oml.Float.tan**  
     `float -> float`  
     Renvoi la tangeante (Argument en radian) d'un flottant passé en argument.


*    **Oml.Float.acos**  
     `float -> float`  
     Renvoi l' arc cosinus (Argument en radian) d'un flottant passé en argument.


*    **Oml.Float.asin**  
     `float -> float`  
     Renvoi l'arc sinus (Argument en radian) d'un flottant passé en argument.


*    **Oml.Float.atan**  
     `float -> float`  
     Renvoi l'arc tangeante (Argument en radian) d'un flottant passé en argument.


*    **Oml.Float.atan2**  
     `float -> float -> float`  
     Renvoi l'arc tangeante (Argument en radian) d'un flottant passé en argument.


*    **Oml.Float.hypot**  
     `float -> float -> float`  
     Renvoi l'hypothénuse des deux points (float) passé en argument.


*    **Oml.Float.ceil**  
     `float -> float`  
     Arrondi inférieur.


*    **Oml.Float.floor**  
     `float -> float`  
     Arrondi superieur.
