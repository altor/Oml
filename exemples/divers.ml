open Oml

let factorielle n =
  let range = List.range 1 n in 
  List.prod range


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
