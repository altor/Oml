module AbstractList : OmlEnum.ENUM with type 'a t = 'a list = struct
  
  type 'a t = 'a list
 
  let neutral = []
  let at = List.nth

  let init i f = 
    let rec init acc = function 
      | -1 -> acc
      |  x -> init ((f x) :: acc) (x - 1)
    in init neutral (i - 1)
  let make i v = init i (fun _ -> v)

  let fold_left  = List.fold_left
  let fold_right = List.fold_right
  let each = List.iter 
  let each_with_index = List.iteri
  let map = List.map 
  let sum   = fold_left (fun a x -> a + x) 0 
  let sumf  = fold_left (fun a x -> a +. x) 0.
  let prod  = fold_left (fun a x -> a * x) 1 
  let prodf = fold_left (fun a x -> a *. x) 1.

  let copy l = fold_right (fun x a -> x :: a) l neutral
  let reverse l = fold_left (fun a x -> x :: a) neutral l

  let range a b = 
    let f = if a < b then pred else succ in 
    let rec range acc = function 
      | x when x = (f a) -> acc
      | x -> range (x :: acc) (f x)
    in range neutral b

  let of_string s = init (String.length s) (fun x -> s.[x])
  let of_array a  = init (Array.length a) (fun x -> a.(x))
  let of_list = copy

  let to_list = copy
  let to_array l = Array.init (List.length l) (fun x -> at l x)
  let to_string l = 
    let len = List.length l in 
    let nst = String.create len in 
    each_with_index (fun i x -> nst.[i] <- x) l;
    nst

  let filter = List.filter

  let any f = 
    let rec any = function 
      | [] -> false
      | x :: xs when f x -> true
      | _ :: xs -> any xs
    in any
 
  let all f = 
    let rec all = function 
      | [] -> true 
      | x :: xs when f x -> all xs 
      | _ -> false
    in all

  let elem = List.mem
  let sort = List.sort
  let head = List.hd
  let tail = List.tl 
  let last l = at l (List.length l - 1)
  let firsts l = init (List.length l - 1) (fun x -> at l x)
  
  let set' l i v = init (List.length l) begin 
    fun x -> 
      if x = i then v else (at l x)
  end

  let bind l f = 
    let rec bind acc = function 
      | [] -> List.rev acc
      | x :: xs -> 
	let sub = List.rev_append (f x) acc in 
	bind sub xs
    in bind neutral l 
  
  let fmap l f = map f l
  let ( >>= ) = bind 
  let ( >>| ) = fmap
  let return x = x :: neutral

end

include List
include AbstractList
