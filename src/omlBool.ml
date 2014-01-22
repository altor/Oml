module AbstractBool : OmlNumeric.NATIVE with type t = bool = struct
  type t = bool 

  let of_int x = not (x = 0)
  let of_float x = not (x = 0.0)
  let of_bool x = x 
  let of_char x = of_int (int_of_char x)

  let of_string x =
    let v = String.lowercase x in 
    not (List.mem v ["0"; "0.0"; "false"])

  let to_int x = if x then 1 else 0 
  let to_float x = if x then 1. else 0.
  let to_char x = if x then '1' else '0'
  let to_string x = if x then "true" else "false"

  let inv = not 
  let pred ?(step = true) x = 
    of_int ((to_int step) + (to_int x)) 
  let succ = pred 

end

include AbstractBool
