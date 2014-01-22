module AbstractChar : OmlNumeric.CHAR with type t = char = struct

  include Char

  let zero = '0' 
  let one = '1'

  let of_char x = x
  let of_int = char_of_int
  let of_float x = of_int (int_of_float x)
  let of_bool x = if x then one else zero
  let of_string s = s.[0]

  let to_char = of_char 
  let to_int = int_of_char
  let to_float x = float_of_int (to_int x)
  let to_bool = ( <> ) zero
  let to_string = String.make 1

  let to_int_value x = (to_int x) - (to_int zero)
  let of_int_value x = 
    of_int ((int_of_char zero) + x)
 
  let inv _ = raise (Failure "inv")
  let succ ?(step = one) x = 
    let stepint = to_int_value step in 
    of_int ((to_int x) + stepint)

  let pred ?(step = one) x = 
    let stepint = to_int_value step in 
    of_int ((to_int x) - stepint)

end

include AbstractChar
