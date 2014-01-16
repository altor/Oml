#Oml.Doc
Ce module ne fait que décrire un type pour représenter un document textuel minimaliste (parsé) dans son sens abstrait. Il servira à traduire/convertir des documents dans d'autres formats (HTML, LaTeX, Markdown etc.)

##Type du module 
Il n'existe que deux types dans ce module : 

```ocaml
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

```
`Doc.parsed` correspond à un document "brute". Ce module est donc destiné à être utilisé par d'autres modules pour proposer des conversions de documents.
