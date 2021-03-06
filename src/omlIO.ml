(** Inpout Output module **)
module AbstractIO : sig

  
  val stdin : in_channel
  val stdout : out_channel 
  val stderr : out_channel 

  val show : 'a -> unit
  val dump : 'a -> unit 
  val newline : ?error:bool -> unit -> unit
  val println : ?error:bool -> string -> unit 
  val print_int : ?error:bool -> int -> unit 
  val print : ?error:bool -> string -> unit
  val print_string : ?error:bool -> string -> unit 
  val print_bool : ?error:bool -> bool -> unit 
  val print_float : ?error:bool -> float -> unit
  val print_char : ?error:bool -> char -> unit
  val format : ('a, out_channel, unit) format -> 'a
  val printf : ('a, out_channel, unit) format -> 'a
  val sformat : ('a, unit, string) format -> 'a
  val sprintf :  ('a, unit, string) format -> 'a

  val scanf : ('a, 'b, 'c, 'd) Scanf.scanner
  val scan : ('a, Scanf.Scanning.in_channel, 'b, 'c -> 'd, 'a -> 'e, 'e) format6 -> 'c -> 'd
  val read_line : unit -> string 
  val get : unit -> string 
  val read_int : unit -> int
  val get_int : unit -> int
  val read_float : unit -> float
  val get_float : unit -> float
  val read_bool : unit -> bool 
  val get_bool : unit -> bool 
  val read_char : unit -> char
  val get_char : unit -> char

  val default_chmod : int
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

  let stdin = Pervasives.stdin
  let stdout = Pervasives.stdout
  let stderr = Pervasives.stderr

  let show = OmlPoly.print
  let dump = show
  
  let newline ?(error = false) = 
    if error then
      Pervasives.prerr_newline
    else Pervasives.print_newline

  let println ?(error = false) =
    if error then
      Pervasives.prerr_endline
    else Pervasives.print_endline

  let print_string ?(error = false) = 
    if error then
      Pervasives.prerr_string
    else Pervasives.print_string
  
  let print = print_string

  let print_int ?(error = false) =
    if error then
      Pervasives.prerr_int
    else Pervasives.print_int
  
  let print_string ?(error = false) = 
    if error then
      Pervasives.prerr_string
    else Pervasives.print_string
  
  let print_bool ?(error = false) b = 
    let f = if error 
      then Pervasives.prerr_string 
      else Pervasives.print_string in 
    match b with
    | true -> f "true"
    | false -> f "false"
  
  let print_float ?(error = false) = 
  if error then
      Pervasives.prerr_float
    else Pervasives.print_float
   
  let print_char ?(error = false) = 
    if error then
      Pervasives.prerr_char
    else Pervasives.print_char
 
  let format = Printf.printf
  let sformat = Printf.sprintf
  let printf = format
  let sprintf = sformat
    
  let scanf = Scanf.scanf
  let scan r f = 
    let res = scanf r f in 
    scanf "%[^\r\n]\n" (fun _ -> ());
    res 

  let read_line () = 
    scanf "%[^\r\n]\n" (fun x -> x)
  let get = read_line 
  let read_int () =  scan " %d" (fun x -> x)
  let get_int = read_int
  let read_float () = scan " %g" (fun x -> x)
  let get_float = read_float
  let read_bool () = 
    let b = get () in 
    if (String.lowercase b) = "false" then false 
    else true
  let get_bool = read_bool
  let read_char () =
    scan " %c" (fun x -> x)
  let get_char = read_char

  let default_chmod = 0o777
  let open_flags s = 
    let rec op acc = function 
      | -1 -> acc
      | x -> begin
	match s.[x] with 
	| '+' -> op (Open_creat :: acc) (x - 1)
	| '-' -> op (Open_trunc :: acc) (x - 1)
	| 'b' -> op (Open_binary :: acc) (x - 1)
	| 'r' -> op (Open_rdonly :: acc) (x - 1)
	| 'w' -> op (Open_wronly :: acc) (x - 1)
	| 'a' -> op (Open_append :: acc) (x - 1)
	| 'x' -> op (Open_excl :: acc) (x - 1)
	| 'f' -> op (Open_nonblock :: acc) (x - 1)
	| 't' -> op (Open_text :: acc) (x - 1)
	| _ -> raise (Invalid_argument "Unknown format")
      end
    in op [] (String.length s - 1)
     
  let open_in = Pervasives.open_in
  let open_in_bin = Pervasives.open_in_bin
  let open_in_gen = Pervasives.open_in_gen

  let openf_in ?(chmod=default_chmod) file format =
    let flags = open_flags format in 
    open_in_gen flags chmod file

  let close_in = Pervasives.close_in
  let input_char = Pervasives.input_char
  let input_line = Pervasives.input_line 
  let input_byte = Pervasives.input_byte

  let next = input_char
  let next_line = input_line
  let next_byte = input_byte

  let open_out = Pervasives.open_out
  let open_out_bin = Pervasives.open_out_bin
  let open_out_gen = Pervasives.open_out_gen

  let openf_out ?(chmod=default_chmod) file format =
    let flags = open_flags format in 
    open_out_gen flags chmod file

  let close_out = Pervasives.close_out
  let flush = Pervasives.flush
  let output_char = Pervasives.output_char
  let output_string = Pervasives.output_string
  let output_byte = Pervasives.output_byte
  
  let push_char = output_char
  let push_string = output_string
  let push_byte = output_byte

  let build_array f file = 
    let chan = open_in file in 
    let rec tca acc = 
      try 
	let c = [|f chan|] in 
	tca (Array.append acc c)
      with 
      | End_of_file ->
	close_in chan;
	acc
    in tca [||]

  let build_list f file = 
    let chan = open_in file in 
    let rec tcl acc = 
      try 
	let c = f chan in 
	tcl (c :: acc)
      with
      | End_of_file ->
	close_in chan;
	List.rev acc
    in tcl []

  let content s = 
    let chan = open_in s in 
    let rec content acc = 
      try 
	let c = input_char chan in 
	let a = Printf.sprintf "%s%c" acc c in 
	content a
      with 
      | End_of_file -> acc
    in content ""

  let to_char_array = build_array next
  let to_line_array = build_array next_line
  let to_byte_array = build_array next_byte
  let to_char_list = build_list next 
  let to_line_list = build_list next_line
  let to_byte_list = build_list next_byte

  let words s = Str.split (Str.regexp " ") (content s)

  let set f create file v =
    let mode = if create then "w-+" else "w-" in 
    let chan = openf_out file mode in 
    f chan v;
    close_out chan

  let append f create file v =
    let mode = if create then "wa+" else "wa" in 
    let chan = openf_out file mode in 
    f chan v;
    close_out chan

  let set_char ?(create=false) = set push_char create
  let set_string ?(create=false) = set push_string create
  let set_byte ?(create=false) = set push_byte create
  let append_char ?(create=false) = append push_char create
  let append_string ?(create=false) = append push_string create
  let append_byte ?(create=false) = append push_byte create

  let file_exists = Sys.file_exists
  let exists = file_exists
  let mkdir ?(chmod = default_chmod) name = 
    Unix.mkdir name chmod
  let rmdir name = Unix.rmdir name 

end

include AbstractIO
