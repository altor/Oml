module AbstractDB : sig

  exception Type_error
  exception Uknown_field
  exception Table_already_created
  exception Uknown_table
  exception No_record

  type field_header = [
    `Int 
  | `Float 
  | `Char
  | `Bool
  | `String 
  ]
  
  type field = [
    `Int of int 
  | `Float of float 
  | `Char of char 
  | `Bool of bool 
  | `String of string 
  ] 
    
  type database
  type record
  type table
    
  val int : field_header
  val char : field_header
  val string : field_header
  val float : field_header
  val bool : field_header

  val to_int : int -> field 
  val to_char : char -> field
  val to_float : float -> field 
  val to_string : string -> field 
  val to_bool : bool -> field 

  val of_int : field -> int 
  val of_float : field -> float
  val of_char : field -> char
  val of_bool : field -> bool 
  val of_string : field -> string 


  val create : string -> database
  val load : string -> database 
  val create_table : database -> string -> (string * field_header) list -> table
  val create_record : database -> table -> field list -> record
  val table_exists : database -> string -> bool
  val table_length : table -> int
  val field  : record -> string -> field
  val values : record -> field list
  val ids : record -> string list
  val zip_values : record -> (string * field) list
  val records : table -> record list
  val query : (record -> bool) -> table -> record list
  val find_one : (record -> bool) -> table -> record
  val delete_if : database -> table -> (record -> bool) -> table 
  val keep_if : database -> table -> (record -> bool) -> table
  val drop_table : database -> table -> table
  val remove_table : database -> table -> unit  
  val get_table : database -> string -> table
  val get_last : table -> record
  val get_last_field : table -> string -> field

end = struct

  exception Type_error
  exception Uknown_field
  exception Table_already_created
  exception Uknown_table
  exception No_record

  type field_header = [
    `Int 
  | `Float 
  | `Char
  | `Bool 
  | `String 
  ]

  
  type field = [
    `Int of int 
  | `Float of float 
  | `Char of char 
  | `Bool of bool 
  | `String of string 
  ] 

  type record = {
    table_header : (string * field_header) list;
    values : field list
  }

  type table = {
    name : string; 
    header : (string * field_header) list;
    mutable size : int; 
    mutable entries : record list
  }

  type database = {
    file : string;
    mutable tables : table list
  }

  let dump_db record = 
    let flags = [Open_wronly;Open_creat;Open_trunc] in
    let chan = open_out_gen flags 0o777 record.file in 
    Marshal.to_channel chan record [];
    close_out chan

  let int      = `Int
  let char     = `Char 
  let float    = `Float 
  let bool     = `Bool 
  let string   = `String 

  let to_int x    = `Int x
  let to_char x   = `Char x
  let to_float x  = `Float x 
  let to_bool x   = `Bool x
  let to_string x = `String x 

  let of_int = function 
    | `Int x -> x 
    | _ -> raise Type_error 


  let of_char = function 
    | `Char x -> x 
    | _ -> raise Type_error

  let of_float = function 
    | `Float x -> x 
    | _ -> raise Type_error


  let of_bool = function 
    | `Bool x -> x 
    | _ -> raise Type_error


  let of_string = function 
    | `String x -> x 
    | _ -> raise Type_error


  let rec check_image = function 
    | [], [] -> ()
    | (_, `Int) :: xs, (`Int _) :: ys 
    | (_, `Float) :: xs, (`Float _) :: ys
    | (_, `Bool) :: xs, (`Bool _) :: ys
    | (_, `Char) :: xs, (`Char _) :: ys
    | (_, `String) :: xs, (`String _) :: ys
      -> check_image (xs, ys)
    | _ -> raise Type_error

  let table_exists db name = 
    let filter = List.filter (fun table -> table.name = name) db.tables 
    in List.length filter > 0

  let create_table db name header =  
    if (table_exists db name) then 
      raise Table_already_created
    else begin 
      let record = {
	name = name;
	size = 0; 
	header = header;
	entries = []
      } in
      db.tables <- record :: db.tables;
      dump_db db;
      record
    end

  let table_length table = table.size

  let create_record db table values =
    check_image (table.header, values); 
    let record = {
      table_header = table.header;
      values = values
    } in 
    table.size <- table.size + 1;
    table.entries <- record :: table.entries;
    dump_db db;
    record

  let ids r = 
    List.map begin 
      fun x -> fst x
    end r.table_header
 
  let values r = r.values
  let zip_values r = 
    let rec aux acc = function 
      | x :: xs, y :: ys -> aux ((x, y)::acc) (xs, ys)
      | [], _ | _, [] ->  acc 
    in aux [] (ids r, values r)

  let field r name = 
    let rec aux = function 
      | x :: _ , y :: _ when x = name -> y
      | _ :: x , _ :: y -> aux (x, y)
      | [], _ | _, [] -> raise Uknown_field
    in aux (ids r, values r)

  let records t = t.entries
  let query f table =  List.filter f table.entries
  let find_one f table =
    let sub = query f table in 
    if List.length sub > 0 then 
      List.hd sub 
    else raise No_record

  let keep_if db table f = 
    table.entries <- List.filter f table.entries;
    dump_db db; 
    table

  let delete_if db table f = 
    let inv f x = not (f x) in 
    keep_if db table (inv f)

  let create file = 
    let record = {
      file = file; 
      tables = []
    } in 
    dump_db record;
    record

  let load file = 
    let chan = Pervasives.open_in file in 
    Marshal.from_channel chan

  let get_table db name = 
    if not (table_exists db name)
    then raise Uknown_table 
    else begin 
      let f = List.filter (fun x -> x.name = name) db.tables in 
      List.hd f
    end 

  let drop_table db table = 
    table.entries <- [];
    dump_db db; 
    table

  let remove_table db table = 
    db.tables <- begin 
      List.filter (fun x -> x.name != table.name) db.tables
    end;
    dump_db db 

    let get_last table = 
      if table.size = 0 then 
	raise No_record 
      else (List.hd table.entries)


  let get_last_field table name = 
    field (get_last table) name

end

include AbstractDB
