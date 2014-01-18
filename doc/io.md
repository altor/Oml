#Oml.IO
Ce module propose une interface minimaliste d'affichage/saisie. 

##Variables 

*    `Oml.IO.stdin` : `in_channel` : Entrée standard  
*    `Oml.IO.stdout` : `out_channel` : Sortie standard
*    `Oml.IO.stderr` : `out_channel` : Sortie d'erreur

##Fonctions du module

###Affichage

*    **Oml.IO.show**  
     `'a -> unit`  
     Affiche une valeur (quelconque) sur la sortie standard. Attention, cette fonction n'est pas "parfaite" et elle n'affiche pas correctement certaines valeurs (cependant, elle tend à converger vers ce qui correspond le mieux à une entrée).  
    **Alias :** `Oml.IO.dump`


*    **Oml.IO.newline**  
     `'?error:bool -> unit -> unit`  
     Affiche un retour à la ligne sur la sortie standard. (Si le flag error est à true, le retour à la ligne s'effectuera sur la sortie d'erreur).


*    **Oml.IO.print**  
     `'?error:bool -> string -> unit`  
     Affiche une chaine de caractère sur la sortie standard. (Si le flag error est à true, le retour à l'affichage s'effectuera sur la sortie d'erreur).  
    **Alias :** `Oml.IO.print_string`


*    **Oml.IO.println**  
     `'?error:bool -> string -> unit`  
     Affiche une chaine puis un retour à la ligne sur la sortie standard. (Si le flag error est à true, l'affichage s'effectuera sur la sortie d'erreur).


*    **Oml.IO.print_int**  
     `'?error:bool -> int -> unit`  
     Affiche un entier sur la sortie standard. (Si le flag error est à true, l'affichage s'effectuera sur la sortie d'erreur).


*    **Oml.IO.print_float**  
     `'?error:bool -> float -> unit`  
     Affiche un flottant sur la sortie standard. (Si le flag error est à true, l'affichage s'effectuera sur la sortie d'erreur).


*    **Oml.IO.print_bool**  
     `'?error:bool -> bool -> unit`  
     Affiche un booléen sur la sortie standard. (Si le flag error est à true, l'affichage s'effectuera sur la sortie d'erreur).


*    **Oml.IO.print_char**  
     `'?error:bool -> char -> unit`  
     Affiche un caractère sur la sortie standard. (Si le flag error est à true, l'affichage s'effectuera sur la sortie d'erreur).


*    **Oml.IO.printf**  
     `('a, out_channel, unit) format -> 'a`  
     Produit un affichage formaté (cf `Printf.printf` de CaML).  
     **Alias :** `Oml.IO.format`


*    **Oml.IO.sprintf**  
     `('a, unit, string) format -> 'a`  
     Produit une chaine formaté (cf `Printf.sprintf` de CaML).  
     **Alias :** `Oml.IO.sformat`


###Saisie

*    **Oml.IO.scanf**  
     `('a, 'b, 'c, 'd) Scanf.scanner`  
     Produit une saisie formaté (cf `Scanf.scanf` de CaML).  


*    **Oml.IO.scan**  
     `('a, Scanf.Scanning.in_channel, 'b, 'c -> 'd, 'a -> 'e, 'e) format6 -> 'c -> 'd`  
     Identique à `Oml.IO.scanf` mais vide le buffer après la saisie.  


*    **Oml.IO.read_line**  
     `unit -> string`  
     Lit la chaine saisie au clavier.  
     **Alias :** `Oml.IO.get`


*    **Oml.IO.read_int**  
     `unit -> int`  
     Lit l'entier saisi au clavier.  
     **Alias :** `Oml.IO.get_int`

*    **Oml.IO.read_float**  
     `unit -> float`  
     Lit le flottant saisi au clavier.  
     **Alias :** `Oml.IO.get_float`


*    **Oml.IO.read_bool**  
     `unit -> bool`  
     Lit le booléen saisi au clavier.  
     **Alias :** `Oml.IO.get_bool`


*    **Oml.IO.read_char**  
     `unit -> char`  
     Lit le caractère saisi au clavier.  
     **Alias :** `Oml.IO.get_char`

###Traitement des fichiers

Se réferer à [Oml.File](https://github.com/nukiFW/Oml/blob/master/doc/file.md) (Les fonctions accessibles via `File.etc` sont accessible via `IO.etc`).