module AbstractInt : OmlNumeric.NUMERIC with type t = int = struct

  type t = int 

  let zero = 0 
  let one = 1 
  let max_value = Pervasives.max_int 
  let min_value = Pervasives.min_int

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
  let modulo = ( mod )
  let rem = modulo
  let pow a b = 
    let x = to_float a 
    and y = to_float b 
    in of_float ( ( ** ) x y)
  let sqrt x = 
    let res = Pervasives.sqrt (float_of_int x)
    in (of_float res)

end

include AbstractInt
