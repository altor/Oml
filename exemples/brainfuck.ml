open Oml

(** Type représentant la mémoire **)
type memory = {
  reg : int array;
  mutable cursor : int
}

(** Type représentant les instructions **)
type token = 
| Simple of (memory -> unit) 
| Loop of token list

(** Image fonctionnelle d'un caractère **)
let image c = match c with  
  | '+' -> (fun m -> (m.reg.(m.cursor) <- (m.reg.(m.cursor)+1)))
  | '-' -> (fun m -> (m.reg.(m.cursor) <- (m.reg.(m.cursor)-1)))
  | '>' -> (fun m -> (m.cursor <- (m.cursor + 1)))
  | '<' -> (fun m -> (m.cursor <- m.cursor - 1))
  | '.' -> (fun m -> Printf.printf "%c" (Char.of_int m.reg.(m.cursor)))
  | ',' -> (
    fun m ->
      let c = (read_line ()).[0] in
      m.reg.(m.cursor) <- (Int.of_char c)
  )
  | _ -> raise (Failure ("image"))

(** Transformation d'une liste de char en liste de tokens **)
let parse l = 
  let rec parse acc = function 
    | [] -> ([], List.rev acc)
    | ('+'|'-'|'>'|'<'|'.'|',') as x :: xs ->
      parse ((Simple (image x)) :: acc) xs
    | ']' :: xs -> (xs, List.rev acc)
    | '[' :: xs -> 
      let rest, loop = parse [] xs in 
      parse ((Loop loop) :: acc) rest
    | _ :: xs -> parse acc xs
  in snd (parse [] l)

(** Interprètation **)
let run s = 
  let li = List.of_string s in 
  let parsed = parse li in
  let m = {reg = Array.make 100 0; cursor = 0} in 
  let rec run = function
    | [] -> ()
    | Simple f :: xs -> 
      f m; 
      run xs 
    | (Loop s :: xs) as total -> 
      if m.reg.(m.cursor) = 0 
      then run xs 
      else begin
	run s;
	run total
      end
  in run parsed

let (_) =
  let len = Array.length Sys.argv in
  if len < 2 || len > 4 then 
    Printf.printf "Usage : \n
    ./brainfuck code \n
    ou \n ./brainfuck -f fichier\n\n"
  else begin 
    if len = 2 then 
      run Sys.argv.(1) 
    else 
      let str = File.content Sys.argv.(2) in 
      run str
  end
