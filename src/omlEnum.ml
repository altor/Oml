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
  val map : ('a -> 'b) -> 'a t -> 'b t
  val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b t -> 'a
  val fold_right : ('a -> 'b -> 'b) -> 'a t -> 'b -> 'b

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


(** Déscription des liste **)

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
  let each = List.iter
  let each_with_index = List.iteri
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


(** Déscription des tableaux  **)
module OmlArray = struct
  type 'a t = 'a array

  let neutral = [||]
    
  let init = Array.init
  let make = Array.make
  let copy = Array.copy

  let reverse a = 
    let len = Array.length a in 
    let nda = init len begin 
      fun x -> a.(len - x - 1) 
    end in nda

  let range a b = 
    let len = abs(a - b) in
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
    if len = 0 then neutral 
    else 
      let nda = make len s.[0] in 
      for i = 0 to (len - 1) do
	nda.(i) <- s.[i]
      done ;
      nda

  let of_list l = 
    if (List.length l) = 0 then neutral 
    else begin 
      let nda = Array.make (List.length l) (List.hd l) in 
      List.iteri (fun i x -> nda.(i) <- x) l;
      nda
    end

  let of_array = copy
  let to_array = copy

  let to_string a = 
    let len = Array.length a in 
    let nst = String.create len in 
    for i = 0 to (len - 1 ) do
      nst.[i] <- a.(i)
    done;
    nst

  let to_list a = 
    let rec tl acc = function 
      | -1 -> acc 
      | x -> tl (a.(x) :: acc) (x - 1) 
    in tl OmlList.neutral (Array.length a - 1)

  let each = Array.iter
  let each_with_index = Array.iteri
  let map = Array.map 
  let fold_left = Array.fold_left
  let fold_right = Array.fold_right
  
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
  let set a x v = 
    let na = copy a in 
    Array.set na x v; 
    na

  let return x = [|x|]
  let bind a f = map f a

end

(**
   Représentation des chaines de caractères
   Note : ce code présente une redondance mais il 
   n'est pas comptabile avec le type ENUM (qui prend 
   en argument un type polymorphe)
**)
module OmlString : sig

  val make : int -> char -> string
  val copy : string -> string
  val init : int -> (int -> char) -> string
  val reverse : string -> string
  val of_array : char array -> string 
  val of_list : char list -> string
  val to_list : string -> char list
  val to_array : string -> char array
  val each : (char -> unit) -> string -> unit
  val each_with_index : (int -> char -> unit) -> string -> unit
  val map : (char -> char) -> string -> string
  val fold_left : ('a -> char -> 'a) -> 'a -> string -> 'a

end = struct

  let make = String.make
  let copy = String.copy

  let init i f = 
    let s = String.create i in 
    for i = 0 to (i - 1) do
      s.[i] <- f i
    done;
    s

  let reverse s = 
    let len = String.length s in 
    init len (fun x -> s.[len - x - 1])

  let of_array a = init (Array.length a) (fun x -> a.(x))
  let of_list l = 
    let s = String.create (List.length l) in 
    let rec ol i = function 
      | [] -> s
      | x :: xs -> 
	s.[i] <- x;
	ol (i + 1) xs 
    in ol 0 l

  let to_list = OmlList.of_string
  let to_array = OmlArray.of_string
  let each = String.iter
  let each_with_index = String.iteri
  let map = String.map 

  let fold_left f a s = 
    let len = String.length s in 
    let rec foldl acc = function 
      | x when x = len -> acc 
      | x -> foldl (f acc s.[x]) (x+1)
    in foldl a 0

end

(** Création d'un foncteur pour désabstraire le type t**)
module FunctorList (OMLComp : ENUM with type 'a t = 'a list) =
struct
  include List
  include OMLComp
end

module FunctorArray (OMLComp : ENUM with type 'a t = 'a array) =
struct
  include Array
  include OMLComp
end
