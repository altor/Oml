module type NATIVE = sig 

  type t

  val of_int : int -> t
  val of_float : float -> t 
  val of_bool : bool -> t
  val of_char : char -> t
  val of_string : string -> t

  val inv : t -> t 
  val succ : ?step:t -> t -> t
  val pred : ?step:t -> t -> t

end

module type NUMERIC = sig 

  include NATIVE

  val zero : t 
  val one : t 
  val abs : t -> t 
  val pow : t -> t -> t
  val modulo : t -> t -> t 
  val rem : t -> t -> t
  val sqrt : t -> t
  val max_value : t
  val min_value : t 

end

module type CHAR = sig 
    
  include NATIVE

  external code : char -> int = "%identity"
  val chr : int -> char
  val escaped : char -> string 
  val lowercase : char -> char
  val uppercase : char -> char 
  val compare : t -> t -> int 
  external unsafe_chr : int -> char = "%identity"
  val zero : t 
  val one : t
  val to_int_value : t -> int
  val of_int_value : int -> t

end
