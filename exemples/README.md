#Exemples rapides de l'utilisation de OML

##Fonctions diverses

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

**Ecrire une liste dans un fichier (et le créer s'il n'existe pas)**  
Utilisation des fonctions de fichiers (et de `openf_out` qui facilite l'ouverture de fichier) :

```ocaml
(** Ecrire une liste **)
let li = 
  [
    "Arthur";"Xavier";"Pierre";"Paul";"Maxime";"Jeremy";
    "Mickael";"Antoine";"Karim";
  ]
let dans = ()
let ecrire liste dans fichier = 
  let chan = File.openf_out fichier "w+" in 
  let rec ecrire = function 
    | [] -> dans
    | x :: xs -> 
      File.push_string chan (Printf.sprintf "%s\n" x);
      ecrire xs
  in ecrire liste

let _ = 
  ecrire li dans "test.txt";
  Printf.printf "Le fichier a été écrit ! \n"; 
  Printf.printf "Contenu du fichier : \n\n:%s" (File.content "test.txt")
  
```
(A noter que le `dans` ne sert absolument à rien, c'était juste pour faire un SEMI-DSL sans aucun intérêt).

**Implémentation de brainfuck**  
Le lien de l'exemple est ici [Implémentation de Brainfuck avec OML](https://github.com/nukiFW/Articles/blob/master/BrainfuckOml/index.md).