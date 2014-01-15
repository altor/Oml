(** Représentation des types simples et primitifs **)

module type NATIVE = sig 

  (** Type usuel **)
  type t

  (** Création **)
  val of_int : int -> t
  val of_float : float -> t 
  val of_bool : bool -> t
  val of_char : char -> t
  val of_string : string -> t

  (** Conversion  **)
  val to_int : t -> int
  val to_float : t -> float
  val to_bool : t -> bool
  val to_char : t -> char 
  val to_string : t -> string

  (** Navigation **)
  val inv : t -> t 
  val succ : ?step:t -> t -> t 
  val pred : ?step:t -> t -> t

end

(** Représentation des Booleens **)
module OmlBool : NATIVE with type t = bool = struct

  type t = bool

  let of_int = function 
    | 0 -> false
    | _ -> true

  let of_float = function 
    | 0.0 -> false
    | _ -> true

  let of_bool x = x

  let of_char x = of_int (int_of_char x)

  let of_string x = 
    match (String.lowercase x) with
    | "false" | "0" | "0.0" -> false
    | _ -> true 

  let to_int x = if x then 1 else 0
  let to_float x = if x then 1.0 else 0.0
  let to_char x = char_of_int (to_int x)
  let to_bool = of_bool
  let to_string x = if x then "true" else "false"

  let inv = not
  let pred ?(step = true) x = 
    of_int ((to_int step) + (to_int x))
  let succ = pred

end

module type NUMERIC = sig

  include NATIVE

  val zero : t
  val one : t
  val abs : t -> t
  val modulo : t -> t -> t
  val rem : t -> t -> t
  val pow : t -> t -> t

end

(** Représentation des entiers **)
module OmlInt : NUMERIC with type t = int = struct

  type t = int

  let zero = 0 
  let one = 1

  let of_int x = x
  let of_float = int_of_float
  let of_bool x = if x then one else zero
  let of_char = int_of_char
  let of_string = int_of_string

  let to_int = of_int 
  let to_float = float_of_int
  let to_bool = ( <> ) zero
  let to_char = char_of_int
  let to_string = string_of_int

  let inv = ( - ) zero
  let pred ?(step = one) x = x - step
  let succ ?(step = one) x = x + step

  let abs x = if x < 0 then -x else x
  let modulo = (mod)
  let rem = modulo
  let pow a b= 
    let x = to_float a 
    and y = to_float b in 
    of_float (( ** ) x y)

end

(** Représentation des floats **)
module OmlFloat : NUMERIC with type t = float = 
struct

  type t = float

  let zero = 0.0
  let one = 1.0

  let of_int = float_of_int
  let of_float x = x
  let of_bool x = if x then one else zero
  let of_char x = of_int (int_of_char x)
  let of_string = float_of_string

  let to_int = int_of_float
  let to_float = of_float
  let to_bool = ( <> ) zero
  let to_char x = char_of_int (to_int x)
  let to_string = string_of_float

  let inv = ( -. ) zero
  let succ ?(step = one) i = i +. step
  let pred ?(step = one) i = i +. step
  let abs x = if x < 0.0 then 0.0 -. x else x
  let modulo a b = 
    let x = to_int a 
    and y = to_int b 
    in of_int (x mod y)
  let rem = modulo 
  let pow = ( ** )

end

module type CHAR = sig 

  include NATIVE
  val chr : int -> char
  val escaped : char -> string
  val lowercase : char -> char
  val uppercase : char -> char
  val compare : t -> t -> int
  val of_int_value : int -> char
  val to_int_value : char -> int
  external code : char -> int = "%identity"
  external unsafe_chr : int -> char = "%identity"

end

module OmlChar : CHAR with type t = char = struct
 
  include Char

  let zero = '0' 
  let one = '1'

  let of_char x = x
  let of_int = char_of_int
  let of_float x = of_int (int_of_float x)
  let of_bool = function 
    | true -> one
    | _ -> zero
  let of_string s = s.[0]
  let of_int_value x = 
    of_int ((int_of_char zero) +  x)

  let to_char = of_char
  let to_int = int_of_char 
  let to_float x = float_of_int (to_int x)
  let to_bool = ( <> ) zero
  let to_string = String.make 1 
  let to_int_value x = (to_int x) - (to_int zero)

  let inv _ = raise (Failure "inv")

  let succ ?(step = one) x = 
    let stepint = to_int_value step in 
    of_int ((to_int x) + stepint)

  let pred ?(step = one) x = 
    let stepint = to_int_value step in 
    of_int ((to_int x) - stepint)

end
