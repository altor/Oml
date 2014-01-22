include String

let neutral = "" 
let init i f = 
  let s = create i in 
  for i = 0 to (i - 1) do 
    s.[i] <- f i 
  done;
  s

let reverse s = 
  let len = length s in 
  init len (fun x -> s.[len - x - 1])

let append = Printf.sprintf "%s%c"
let prepend = Printf.sprintf "%c%s"
let return x = append neutral x

let of_int = string_of_int
let of_float = string_of_float
let of_bool = string_of_bool
let of_char  = return 

let to_int = int_of_string
let to_float = float_of_string
let to_bool = bool_of_string
let to_char s = s.[0]

let of_array a = init (Array.length a) (fun x -> a.(x))
let of_list l = 
  let s = create (List.length l) in 
  let rec ol i = function 
    | [] -> s
    | x :: xs -> 
      s.[i] <- x;
      ol (i + 1) xs 
  in ol 0 l

let to_list = OmlList.of_string
let to_array = OmlArray.of_string
let each = iter
let each_with_index = iteri

let fold_left f a s = 
  let len = length s in 
  let rec foldl acc = function 
    | x when x = len -> acc
    | x -> foldl (f acc s.[x]) (x + 1)
  in foldl a 0

let fold_right f s a = 
  let len = length s in 
  let rec foldr acc = function 
    | -1 -> acc 
    |  x -> foldr (f s.[x] acc) (x - 1)
  in foldr a (len - 1)

let filter f s = 
  let rec filter acc = function 
    | x when (length s) = x -> acc
    | x -> filter (append acc s.[x]) (x + 1)
  in filter neutral 0

let all f s = 
  let rec all = function 
    | x when x = (length s) -> true
    | x when f s.[x] -> all (x + 1)
    | _ -> false
  in all 0

let any f s = 
  let rec any = function 
    | x when x = (length s) -> false
    | x when f s.[x] -> true
    | x -> any (x + 1)
  in any 0
let elem c = any (fun x -> x = c)

let head s = 
  if (length s) = 0 then raise (Failure "head")
  else s.[0]

let last s = 
  let len = length s in
  if len = 0 then raise (Failure "last")
  else s.[len - 1]
    
let tail s = 
  let len = length s in
  if len = 0 then raise (Failure "tail")
  else sub s 1 (len - 1)
 
let firsts s = 
  let len = length s in
  if len = 0 then raise (Failure "firsts")
  else sub s 0 (len - 1)
    
let at s x = s.[x]
let set' s x v = 
  let ns = copy s in 
  ns.[x] <- v;
  ns

let join ?(delim = "") = 
  List.fold_left (fun a x -> a ^ x) "" 

let split r = Str.split @@ Str.regexp r
let lines = split "\n"
let words = split " "
 
