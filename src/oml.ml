(** Opérateurs standards (pour CaML 3.x) **)
let ( |> ) x f = f x 
let ( @@ ) f x = f x
let id x = x 
let ( $ ) = id

(** Fonctions génériques **)
let switch (a, b) = b, a

(** Inclusion des modules dans Oml **)
module IO = OmlIO.OmlIO
module List = OmlEnum.OmlList
module Array = OmlEnum.OmlArray
module String = OmlEnum.OmlString
module Bool = OmlPrimitive.OmlBool
module Int = OmlPrimitive.OmlInt
module Float = OmlPrimitive.OmlFloat
module Char = OmlPrimitive.OmlChar
module File = OmlFile.File
module Doc = OmlParser.Doc

let _ =
  if !Sys.interactive
  then OmlIntro.display_intro () 
  
