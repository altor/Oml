(**
   Module de déscription des structures énumérables
   Janvier 2013
**)

module type ENUM = sig 

  (** Type usuel **)
  type 'a t 

  (** Initialisateurs  **)
  val make : int -> 'a -> 'a t
  val init : int -> (int -> 'a) -> 'a t
  val copy : 'a t -> 'a t
  val reverse : 'a t -> 'a t
  val range : int -> int -> int t
  val of_string : string -> char t
  val of_array : 'a array -> 'a t
  val of_list : 'a list -> 'a t

  (** Conversions  **)
  val to_string : char t -> string
  val to_array : 'a t -> 'a array 
  val to_list : 'a t -> 'a list

  (** Itérateurs  **)
  val each : ('a -> unit) -> 'a t -> unit
  val each_with_index : (int -> 'a -> unit) -> 'a t -> unit
  val map : ('a -> 'a) -> 'a t -> 'a t
  val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b t -> 'a
  val fold_right : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b

  (** Filtres **)
  val filter : ('a -> bool) -> 'a t -> 'a t
  val any : ('a -> bool) -> 'a t -> bool
  val all : ('a -> bool) -> 'a t -> bool
  val elem : 'a -> 'a t -> bool

  (** Tris **)
  val sort : ('a -> 'a -> int) -> 'a t -> 'a t

  (** Elements constituants **)
  val head : 'a t -> 'a 
  val last : 'a t -> 'a 
  val tail : 'a t -> 'a t
  val firsts : 'a t -> 'a t

  (** Accesseurs & mutateurs **)
  val at : 'a t -> int -> 'a 
  val set : 'a t -> int -> 'a -> 'a t

  (** Effets particuliers **)
  val neutral : 'a t 
  val return : 'a -> 'a t 
  val bind : 'a t -> ('a -> 'b) -> 'b t  

end 


(**
   Déscription des listes
**)


module OmlList = struct
  type 'a t = 'a list

  let neutral = []

  let at l i = 
    let len = List.length l in 
    if (len - 1) < i then 
      raise (Invalid_argument "index out of bounds")
    else List.nth l i 

  let init i f = 
    let rec init acc = function 
      | -1 -> acc 
      | x -> init ((f x) :: acc) (x - 1)
    in init neutral (i - 1)

  let make i v = init i (fun _ -> v)

  let fold_left = List.fold_left
  let fold_right = List.fold_right
  
  let each f = 
    let rec each = function 
      | [] -> ()
      | x :: xs -> 
	f x;
	each xs
    in each

  let each_with_index f = 
    let rec each i = function 
      | [] -> ()
      | x :: xs -> 
	f i x;
	each (i + 1) xs
    in each 0

  let map = List.map

  let copy l = fold_right (fun x a -> x :: a) l neutral
  let reverse l = fold_left (fun a x -> x :: a) neutral l

  let range a b =
    let f = if a < b then pred else succ in 
    let rec range acc = function 
      | x when x = (f a) -> acc
      | x -> range (x :: acc) (f x)
    in range neutral b

  let of_string s = 
    let rec ofs acc = function 
      | -1 -> acc 
      | x -> ofs (s.[x] :: acc) (x - 1)
    in ofs neutral (String.length s - 1)

  let of_array a = 
    Array.fold_right (fun x a -> x :: a) a neutral

  let of_list = copy

  let to_string l =
    let len = List.length l in 
    let nst = String.create len in 
    each_with_index (fun i x -> nst.[i] <- x) l;
    nst 

  let to_list = copy
  let to_array l = 
    Array.init (List.length l) (fun x -> at l x) 

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
  let firsts l = 
    init (List.length l - 1) (fun x -> at l x)

  let set l i v =
    init (List.length l) begin fun x ->
      if x = i then v else (at l x)
    end

  let return x = x :: neutral
  let bind l f = 
    fold_right (fun x a -> (f x) :: a) l neutral
    
end

(** Création d'un foncteur pour désabstraire le type t**)
module FunctorList (OMLComp : ENUM with type 'a t = 'a list) =
struct
  include List
  include OMLComp
end

