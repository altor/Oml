(** Représentation des traitement de fichiers **)
module AbstractFile : sig

  val open_in : string -> in_channel
  val open_in_bin : string -> in_channel
  val open_in_gen : open_flag list -> int -> string -> in_channel
  val openf_in : ?chmod:int -> string -> string -> in_channel
  val close_in : in_channel -> unit
  val input_char : in_channel -> char
  val next : in_channel -> char
  val input_line : in_channel -> string
  val next_line : in_channel -> string
  val input_byte : in_channel -> int
  val next_byte : in_channel -> int
  val open_out : string -> out_channel
  val open_out_bin : string -> out_channel
  val open_out_gen : open_flag list -> int -> string -> out_channel
  val openf_out : ?chmod:int -> string -> string -> out_channel
  val close_out : out_channel -> unit
  val flush : out_channel -> unit
  val output_char : out_channel -> char -> unit
  val push_char : out_channel -> char -> unit
  val output_string : out_channel -> string -> unit
  val push_string : out_channel -> string -> unit
  val output_byte : out_channel -> int -> unit
  val push_byte : out_channel -> int -> unit
  val to_char_array : string -> char array
  val to_line_array : string -> string array
  val to_byte_array : string -> int array
  val to_char_list : string -> char list
  val to_line_list : string -> string list
  val to_byte_list : string -> int list
  val words : string -> string list
  val content : string -> string
  val set_char : ?create:bool -> string -> char -> unit
  val set_string : ?create:bool -> string -> string -> unit
  val set_byte : ?create:bool -> string -> int -> unit
  val append_char : ?create:bool -> string -> char -> unit
  val append_string : ?create:bool -> string -> string -> unit
  val append_byte : ?create:bool -> string -> int -> unit
  val file_exists : string -> bool
  val exists : string -> bool
  val mkdir : ?chmod:int -> string -> unit
  val rmdir : string -> unit

end = struct
  include OmlIO
end

include AbstractFile
