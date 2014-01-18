(** Action INPUT/OUTPUT **)
module OmlIO : sig

  external show : 'a -> unit = "polymorphic_print"

  val stdin : in_channel
  val stdout : out_channel
  val stderr : out_channel

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

end = struct

  external show : 'a -> unit = "polymorphic_print"

  let stdin = Pervasives.stdin
  let stdout = Pervasives.stdout
  let stderr = Pervasives.stderr

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

end
