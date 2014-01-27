(* Inclusion des modules *)
module Poly    = OmlPoly
module IO      = OmlIO
module List    = OmlList
module Array   = OmlArray
module String  = OmlString
module Bool    = OmlBool
module Int     = OmlInt
module Float   = OmlFloat
module Char    = OmlChar
module File    = OmlFile
module Marshal = OmlMarshal
module Database = OmlDatabase

(* Affichage du message en toplevel *)
let _ = 
  if !Sys.interactive then 
    Printf.printf "\tOCaml Mini Library (Toplevel)\n"

