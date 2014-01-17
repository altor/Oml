#Exemples rapides de l'utilisation de OML

##Fonctions divers

###1. Lancement d'un terminal OML
Après la compilation d'OML (au moyen de la commande `make`), utiliser, dans le répertoire où vous avez invoqué la commande, cette directive pour lancer un toplevel avec OML chargé : `./ocamloml`.  On peut donc ajouter dans le terminal la directive `open Oml` pour ne pas devoir spécifier chaque fois l'espace nom OML.

**Implémentation d'une fonction factorielle**
Usage des fonctions `List.range` et `List.prod` :

```ocaml
let factorielle n =
  let range = List.range 1 n in 
  List.prod range
```

**Implémentation rapide d'un générateur de liste**
Usage de la fonction `List.bind` (et de fonctions diverses) :

```ocaml
let ( >>= ) = List.bind
(** Liste de 0 à 20 **)
let une_liste = List.init 20 (fun x -> x)

(** Exemple de transformations **)
let une_autre = une_liste >>= (fun x -> x * 2)
let _ =
  une_liste 
  >>= (fun x -> x mod 9) 
  >>= Int.succ
  >>= Char.of_int_value
  |> List.fold_left (fun a x -> String.prepend x a) ""
  |> print_string

```

(Je reconnais que l'exemple est... douteux ;) ).