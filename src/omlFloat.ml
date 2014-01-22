module AbstractFloat : OmlNumeric.NUMERIC with type t = float = struct

  type t = float
 
  let zero = 0.
  let one = 1.
  let max_value = Pervasives.max_float
  let min_value = Pervasives.min_float
    
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
  let abs = Pervasives.abs_float
  let modulo = Pervasives.mod_float
  let rem = modulo 
  let pow = ( ** )
  let sqrt  = Pervasives.sqrt

end

include AbstractFloat

let exp   = Pervasives.exp 
let log   = Pervasives.log 
let log10 = Pervasives.log10
let sin   = Pervasives.sin 
let cos   = Pervasives.cos
let tan   = Pervasives.tan
let acos  = Pervasives.acos
let asin  = Pervasives.asin
let atan  = Pervasives.atan
let atan2 = Pervasives.atan2
let hypot = Pervasives.hypot
let ceil  = Pervasives.ceil
let floor = Pervasives.floor



