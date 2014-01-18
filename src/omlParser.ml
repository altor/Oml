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
  | Text of string
  and parsed = token list

end

(** Déscription du Markdown **)
module Markdown  = struct

  let reg = 
    [|
      (**0**) Str.regexp "\n";
      (**1**) Str.regexp "#";
    |]

  let split_lines = Str.split reg.(0)
  let match_title s = Str.string_match reg.(1) s 0
  let mk_title s = 
    let len = String.length s in 
    let rec ts acc = function 
      | x when x = len -> Doc.Text s
      | x when s.[x] = '#' -> ts (acc + 1) (x + 1)
      | x -> Doc.Title (acc, (String.sub s x (len - x)))
    in ts 0 0 
 
  let parse string = 
    let splitted = split_lines string in 
    let rec parse acc = function 
      | [] -> List.rev acc
      | x :: xs when match_title x ->
	 parse ((mk_title x) :: acc) xs
      | x :: xs -> parse ((Doc.Text x) :: acc) xs
    in parse [] splitted
      
      
end
