open Oml

let factorielle n =
  let range = List.range 1 n in 
  List.prod range


let ( >>= ) = List.bind
(** Liste de 0 à 20 **)
let une_liste = List.init 20 (fun x -> x)

(** Exemple de transformations **)
let une_autre = une_liste >>= (fun x -> x * 2)
let rien =
  une_liste 
  >>= (fun x -> x mod 9) 
  >>= Int.succ
  >>= Char.of_int_value
  |> List.fold_left (fun a x -> String.prepend x a) ""
  |> print_string

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
  
