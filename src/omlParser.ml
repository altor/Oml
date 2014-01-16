(** Déscription simple d'un document  **)
module Doc = struct

  type token = 
  | Title of int * string
  | Paragraph of parsed
  | Blockquote of parsed
  | Formulas of string 
  | Code of string * string 
  | Inline_Code of string
  | Ol of (string * parsed) list
  | Ul of (string * parsed) list
  | Url of string option * string
  | Line
  | Br
  | Bold of string
  | Italic of string
  | Strike of string
  | Underline of string
  | Picture of string * string
  and parsed = token list

end
