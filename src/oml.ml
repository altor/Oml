(** Opérateurs standards (pour CaML 3.x) **)
let ( |> ) x f = f x 
let ( @@ ) f x = f x

(** Inclusion des modules dans Oml **)
module List = OmlEnum.FunctorList(OmlEnum.OmlList)
module Array = OmlEnum.FunctorArray(OmlEnum.OmlArray)
