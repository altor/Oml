#Oml.Poly
Ce module propose des fonctions purement polymorphiques, capables d'effectuer des traitements sur des arguments de type variable.

##Fonctions du modules

*    **Oml.Poly.print**  
     `'a -> unit`  
     Affiche une valeur (quelconque) sur la sortie standard. Attention, cette fonction n'est pas "parfaite" et elle n'affiche pas correctement certaines valeurs (cependant, elle tend à converger vers ce qui correspond le mieux à une entrée).

*    **Oml.Poly.length**  
     `'a -> int`  
     Renvoi la taille d'un élément (quelconque). Les entiers, chars, floats, bool etc. renvoient toujours 1. Les tableaux, listes, n-uplets et strings renvoient le nombre d'éléments qui les constituent.