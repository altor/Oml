(*
  Ce module permet de traiter des bases de données embarquées
  (au moyen de fichiers) pour des applications ne pouvant pas 
  se connecter à un serveur pour les besoins de l'application.
*)

(* Description des exceptions *)
exception Type_error
exception Unknown_database of string
exception Unknown_table of string
exception Unknown_field of string

(* Description des éléments relatifs aux champs *)
type field_type = [
  `Int 
| `Float 
| `Bool 
| `Char 
| `String 
] 
type field_header =
  (string * field_type)

type abstract_field = [
  `Int of int 
| `Float of float 
| `Bool of bool
| `Char of char 
| `String of string
]

(* Purification des données à sauvegarder *)
type pure_field = abstract_field
type pure_record = {
  record_header : field_header list; 
  record_values : pure_field list;
}
type pure_table = {
  table_name : string;
  table_header : field_header list;
  record_list : pure_record list
}
type pure_database = {
  database_file : string;
  database_table_list : pure_table list
}

(* Représentation d'un champ d'enregistrement *)
class field(field_in) = 
object(self) 
  val mutable attr_value : abstract_field = field_in
  (* Information de typage *)
  method private field_image : field_type = match attr_value with 
  | `Int _     -> `Int 
  | `Float _   -> `Float 
  | `Bool _    -> `Bool
  | `Char _    -> `Char
  | `String _  -> `String
  method is_int    = self#field_image = `Int
  method is_float  = self#field_image = `Float
  method is_bool   = self#field_image = `Bool
  method is_char   = self#field_image = `Char
  method is_string = self#field_image = `String
  method check_image hd = self#field_image = hd
  (* outil de conversion *)
  (* Entiers *)
  method private iof = int_of_float
  method private ioc = int_of_char 
  method private iob x = if x then 1 else 0
  method private ios = int_of_string
  (* Floats *)
  method private foi = float_of_int
  method private foc x = self#foi(self#ioc x)
  method private fob x = if x then 1. else 0.
  method private fos = float_of_string
  (* Bools *)
  method private boi x = not (x = 0)
  method private bof x = not (x = 0.)
  method private boc x = not (x = '0')
  method private bos x = not (String.lowercase x = "false" || x = "0")
  (* Char *)
  method private coi = char_of_int
  method private cof x = self#coi(self#iof x)
  method private cob x = if x then '1' else '0'
  method private cos x = 
    if (String.length x) >= 0 
    then x.[0] 
    else '0'
  (* String *)
  method private soi = string_of_int
  method private sof = string_of_float
  method private sob x = if x then "true" else "false"
  method private soc = String.make 1

  (* Conversions explicite *)
  method int = 
    match attr_value with 
    | `Int x -> x
    | `Float x -> self#iof x
    | `Char x -> self#ioc x
    | `Bool x -> self#iob x 
    | `String x -> self#ios x
  method float = 
    match attr_value with 
    | `Int x -> self#foi x
    | `Float x -> x
    | `Char x -> self#foc x
    | `Bool x -> self#fob x 
    | `String x -> self#fos x
  method char = 
    match attr_value with 
    | `Int x -> self#coi x
    | `Float x -> self#cof x
    | `Char x -> x
    | `Bool x -> self#cob x 
    | `String x -> self#cos x
  method bool = 
    match attr_value with 
    | `Int x -> self#boi x
    | `Float x -> self#bof x
    | `Char x -> self#boc x
    | `Bool x -> x 
    | `String x -> self#bos x
  method string = 
    match attr_value with 
    | `Int x -> self#soi x
    | `Float x -> self#sof x
    | `Char x -> self#soc x
    | `Bool x -> self#sob x 
    | `String x -> x
 
  (* Accesseur *)
  method value = attr_value
  method purify:abstract_field = self#value
end

(* Représentation d'un enregistrement *) 
class record(proto_in, values_in) = 
object(self)
  val prototypes : field_header list =  proto_in
  val mutable attr_values : field list    = values_in
  initializer (self#check_image)
  (* Vérifie la fiabilité d'un champ *)
  method private check_image = 
    let rec check = function 
      | [], [] -> ()
      | (_,x)::xs, y::ys when y#check_image x -> check(xs, ys)
      | _ -> raise Type_error
    in check (prototypes, attr_values)
  (* Accès aux valeurs des champ *)
  method labels = List.map (fun x -> fst x) prototypes
  method values = attr_values
  method values_with_labels = 
    List.combine (self#labels) attr_values
  method field label =
    try List.assoc label (self#values_with_labels)
    with 
    | Not_found -> raise (Unknown_field label)
  method get_prototypes = prototypes
  method get_prototype label = 
    List.find (fun x -> (fst x) = label) prototypes
  method purify = {
    record_header = prototypes;
    record_values = List.map (fun x -> x#purify) attr_values
  }
end

(* Représentation d'un ensemble de réponses **)
class subset(proto_in, components) = 
object(self)
  val prototypes : field_header list = proto_in
  val mutable record_list : record list = components
  val mutable size = List.length components
  method private cloneset l = new subset(prototypes, l)
 
 (* Accès aux données *)
  method with_fields fields = 
    let rec filter_values r proto values = function 
      | [] -> new record(proto, values)
      | x::xs -> 
	let nproto = (r#get_prototype x)::proto
	and nvalue = (r#field x)::values in 
	filter_values r nproto nvalue xs
    in 
    let prototypes' = 
      List.filter (fun x -> List.mem (fst x) fields) prototypes in 
    let filter r = filter_values r [] [] fields in 
    let sublist = List.map (filter) record_list in 
    new subset(prototypes', sublist)

  method get_prototypes = prototypes
  method records = record_list
  method last    = List.hd record_list
  method first   = List.hd (List.rev record_list)
  method find  f = List.find f record_list
  method count   = size
  method count_where f = (self#query f)#count
  method sort_with f  = 
    self#cloneset (List.sort f record_list)
  method query f = 
    self#cloneset (List.find_all f record_list)
  method to_subset = self#cloneset record_list
  (* Itération *)
  method iter f  = List.iter f record_list
  method iteri f = List.iteri f record_list
  method each = self#iter
  method each_with_index = self#iteri
  method map f = self#cloneset (List.map f record_list)
  method fold_left : 'a. ('a -> record -> 'a) -> 'a -> 'a =
    (fun f acc -> List.fold_left f acc record_list)
  method fold_right : 'a. (record -> 'a -> 'a) -> 'a -> 'a =
    (fun f acc -> List.fold_right f record_list acc)
  (* Transformation *)
  method keep_if f = 
    record_list <- (List.filter f record_list);
    size <- List.length record_list
  method delete_if f = 
    let inverse x = not (f x) in 
    self#keep_if inverse 
  method drop = 
    record_list <- [];
    size <- 0
  method insert obj = 
    record_list <- obj :: record_list; 
    size <- succ size
end 

(* Représentation d'une table *)
class table(name_in, proto_in) =
object(self)
  inherit subset(proto_in, [])
  val view_name : string = name_in 
  method name = view_name
  method purify = {
    table_name = view_name;
    table_header = prototypes;
    record_list = List.map (fun x -> x#purify) record_list
  }
  method overkill_transform v =
    record_list <- v;
    size <- List.length record_list
    
end

(* Représentation d'une base de données *)
class database(file_in) =
object(self)  
  val file : string = file_in
  val mutable table_list : table list = []
  val flags = [
    Pervasives.Open_trunc;
    Pervasives.Open_creat;
    Pervasives.Open_wronly
  ]
  method tables = table_list
  method get_table name = 
    try List.find (fun x -> x#name = name) table_list
    with 
    | Not_found -> raise (Unknown_table name)
  method create_table name prototypes =
    table_list <- (new table (name, prototypes)) :: table_list;
    self#dump
  method append_table table = 
    table_list <- table :: table_list;
    self#dump
  method append_tables tables = 
    table_list <- tables @ table_list;
    self#dump
  method table_exists name = 
    try 
      ignore (List.find (fun x -> x#name = name) table_list);
      true 
    with 
    | _ -> false

  (* Sauvegarde de la base de données  *)
  method dump = 
    let chan = open_out_gen flags 0o777 file in 
    Marshal.to_channel chan self#purify [Marshal.Closures];
    close_out chan
  method backup = self#dump
  method save = self#dump

  (* 
     Traitement "paranoïaque" des requêtes.
     Sauvegarde automatiquement la base de données 
     a chaque modification des tables
  *)
  method delete_if table_name f = 
    (self#get_table table_name)#delete_if f;
    self#dump
  method keep_if table_name f = 
    (self#get_table table_name)#keep_if f; 
    self#dump
  method insert table_name values = 
    let t = self#get_table table_name in 
    let r = new record(t#get_prototypes, values) in
    t#insert r;
    self#dump
  method append_record table_name record = 
    (self#get_table table_name)#insert record
  method drop table_name = 
    (self#get_table table_name)#drop;
    self#dump
  (* Routine de purification *)
  method purify = {
    database_file = file;
    database_table_list = List.map (fun x -> x#purify) table_list
  }
end

(* Conversion d'une base de données en pure en objet *)
let unpurify_field f = new field(f)
let unpurify_record f = 
  new record begin
    f.record_header, 
    List.map (fun x -> unpurify_field x) f.record_values
  end
let unpurify_table f = 
  let tbl = new table(f.table_name, f.table_header) in 
  let nonpurerecords = 
    List.map (fun x -> unpurify_record x) f.record_list
  in tbl#overkill_transform nonpurerecords; 
  tbl
let unpurify_db f =
  let db = new database(f.database_file) in
  let tb = List.map begin
    fun x -> unpurify_table x
  end f.database_table_list in
  db#append_tables tb;
  db
  
(* Api de conversion *) 
let int id = (id, `Int)
let float id = (id, `Float) 
let bool id = (id, `Bool)
let char id = (id, `Char)
let string id = (id, `String)

let to_int x = new field(`Int x) 
let to_bool x = new field(`Bool x) 
let to_float x = new field(`Float x)
let to_char x = new field(`Char x) 
let to_string x = new field(`String x)

(*
  API générale de l'application.
  Point d'entrée de l'outil.
*)
let load file =
  try 
    let channel = open_in file in 
    let db : pure_database = Marshal.from_channel channel in 
    close_in channel; 
    unpurify_db db
  with 
    _ -> raise (Unknown_database file)

let create file = new database(file)
let create_table name proto = new table(name, proto)
let create_record proto values = new record (proto, values)
  
(*
  Cette fonction ne vérifie pas l'existence propre d'une DB. 
  Un fichier n'étant pas une base de données sera considéré 
  comme une base de données valide.
*)
let database_exists = Sys.file_exists
