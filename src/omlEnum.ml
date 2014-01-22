module type ENUM = sig 

  (* Type usuel *)
  include OmlMonad.BASE

  (* Construction d'énumération *)
  val make : int -> 'a -> 'a t
  val init : int -> (int -> 'a) -> 'a t
  val copy : 'a t -> 'a t
  val reverse : 'a t -> 'a t
  val range : int -> int -> int t
  val of_string : string -> char t 
  val of_array : 'a array -> 'a t
  val of_list : 'a list -> 'a t

  (* Conversions *)
  val to_list : 'a t -> 'a list 
  val to_array : 'a t -> 'a array 
  val to_string : char t -> string

  (* Iterateurs *)
  val each : ('a -> unit) -> 'a t -> unit
  val each_with_index : (int -> 'a -> unit) -> 'a t -> unit
  val map : ('a -> 'b) -> 'a t -> 'b t
  val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b t -> 'a
  val fold_right : ('a -> 'b -> 'b) -> 'a t -> 'b -> 'b
  val sum : int t -> int
  val prod : int t -> int
  val sumf : float t -> float
  val prodf : float t -> float

  (* Filtres *)
  val filter : ('a -> bool) -> 'a t -> 'a t
  val any : ('a -> bool) -> 'a t -> bool
  val all : ('a -> bool) -> 'a t -> bool
  val elem : 'a -> 'a t -> bool

  (* Tris *)
  val sort : ('a -> 'a -> int) -> 'a t -> 'a t

  (* Elements constituants *)
  val head : 'a t -> 'a 
  val last : 'a t -> 'a 
  val tail : 'a t -> 'a t
  val firsts : 'a t -> 'a t

  (* Accesseurs & mutateurs *)
  val at : 'a t -> int -> 'a 
  val set' : 'a t -> int -> 'a -> 'a t

end
