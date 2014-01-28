(* Déscritpion des exceptions *)
exception Type_error

(* Déscription des éléments relatifs aux champs *)
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
  method private bos x = (String.lowercase x = "false" || x = "0")
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
    | _ -> raise Type_error
  method float = 
    match attr_value with 
    | `Int x -> self#foi x
    | `Float x -> x
    | `Char x -> self#foc x
    | `Bool x -> self#fob x 
    | `String x -> self#fos x
    | _ -> raise Type_error
  method char = 
    match attr_value with 
    | `Int x -> self#coi x
    | `Float x -> self#cof x
    | `Char x -> x
    | `Bool x -> self#cob x 
    | `String x -> self#cos x
    | _ -> raise Type_error
  method bool = 
    match attr_value with 
    | `Int x -> self#boi x
    | `Float x -> self#bof x
    | `Char x -> self#boc x
    | `Bool x -> x 
    | `String x -> self#bos x
    | _ -> raise Type_error
  method string = 
    match attr_value with 
    | `Int x -> self#soi x
    | `Float x -> self#sof x
    | `Char x -> self#soc x
    | `Bool x -> self#sob x 
    | `String x -> x
    | _ -> raise Type_error
 
  (* Accesseur *)
  method value = attr_value
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
    List.assoc label (self#values_with_labels)
  method get_prototypes = prototypes
  method get_prototype label = 
    List.find (fun x -> (fst x) = label) prototypes
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
  (* Itération *)
  method iter f  = List.iter f record_list
  method iteri f = List.iteri f record_list
  method each = self#iter
  method each_with_index = self#iteri
  method map f = self#cloneset (List.map f record_list)
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
  (* Initialisation de la base de données *) 
  initializer
    self#init_file
  method private init_file = 
    let chan =
      Pervasives.open_out_gen flags 0o777 file
    in Pervasives.close_out chan
  (* Création d'une table (dans la base de données) *)
  method tables = table_list
  method get_table name = 
    List.find (fun x -> x#name = name) table_list
  method create_table name prototypes =
    table_list <- (new table (name, prototypes)) :: table_list;
    self#dump

  (* Sauvegarde de la base de données  *)
  method dump = 
    let chan = open_out file in 
    Marshal.to_channel chan self [];
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
  method insert table_name record = 
    (self#get_table table_name)#insert record;
    self#dump
  method drop table_name = 
    (self#get_table table_name)#drop;
    self#dump
end
  
(* Api de conversion *) 
let int id = (id, `Int)
let float id = (id, `Float) 
let bool id = (id, `Bool)
let char id = (id, `Char)
let string id = (id, `String)



