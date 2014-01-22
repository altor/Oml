module AbstractArray : OmlEnum.ENUM with type 'a t = 'a array = struct

  type 'a t = 'a array

  let neutral = [||]
  let init = Array.init
  let make = Array.make
  let copy = Array.copy 
    
  let reverse a = 
    let len = Array.length a in 
    let nda = init len (fun x -> a.(len - x - 1))
    in nda

  let range a b = 
    let len = abs (a - b) in 
    let f = if a < b then succ else pred in 
    let nda = make len a in 
    let rec range i = function 
      | x when x = (f b) -> nda 
      | x -> 
	nda.(i) <- x;
	range i (f x) 
    in range 0 a

  let of_string s = 
    let len = String.length s in 
    init len (fun x -> s.[x])

  let of_list l = 
    let len = List.length l in 
    if len = 0 then neutral 
    else begin
      let nda = Array.make len (List.hd l) in 
      List.iteri (fun i x -> nda.(i) <- x) l; 
      nda
    end

  let of_array = copy
  let to_array = copy

  let to_string a = 
    let len = Array.length a in 
    let nst = String.create len in 
    for i = 0 to (len - 1) do 
      nst.[i] <- a.(i)
    done;
    nst

  let to_list a = 
    let rec tl acc = function 
      | -1 -> acc
      |  x -> tl (a.(x) :: acc) (x - 1) 
    in tl [] (Array.length a - 1)

  let each = Array.iter
  let each_with_index = Array.iteri 
  let map = Array.map
  let fold_left = Array.fold_left
  let fold_right = Array.fold_right
  let sum = fold_left (fun a x -> a + x) 0
  let sumf = fold_left (fun a x -> a +. x) 0.0
  let prod = fold_left (fun a x -> a * x) 1
  let prodf = fold_left (fun a x -> a *. x) 1.0 
  
  let filter f a = 
    let rec filter acc = function
      | -1 -> acc 
      | x when f a.(x) -> 
	filter (Array.append [|a.(x)|] acc) (x - 1)
      | x -> filter acc (x - 1)
    in filter neutral (Array.length a - 1)

  let any f a = 
    let rec any = function 
      | -1 -> false 
      | x when f a.(x) -> true 
      | x -> any (x - 1) 
    in any (Array.length a - 1)

  let all f a = 
    let rec all = function 
      | -1 -> true 
      | x when f a.(x) -> all (x - 1)
      | _ ->  false 
    in all (Array.length a - 1)

  let elem v = any (fun x -> x = v)
  let sort f a =
    let nda = copy a in
    Array.sort f nda;
    nda

  let head a = 
    if (Array.length a) = 0 then 
      raise (Failure "head")
    else a.(0)

  let last a = 
    if (Array.length a) =  0 then 
      raise (Failure "last")
    else a.(Array.length a - 1)

  let tail a = 
    let len = Array.length a - 1 in 
    Array.sub a 1 len

  let firsts a = 
    let len = Array.length a - 1 in 
    Array.sub a 0 len

  let at a x = a.(x)
  let set' a x v = 
    let na = copy a in 
    Array.set na x v; 
    na

  let return x = [| x |]
  let fmap a f = map f a
  let bind a f = fold_right begin 
    fun x acc -> Array.concat [(f x) ; acc]
  end a neutral

  let ( >>= ) = bind 
  let ( >>| ) = fmap

end

include Array
include AbstractArray
