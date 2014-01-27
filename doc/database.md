#Oml.Database
Ce module propose des outils de traitement pour une base de données très minimaliste, pouvant stocker des données pour des petites applications. Ce système de base de données est volontairement minimaliste pour ne pas être compliqué à manipuler. Pour plus de complexité, il vaudra mieux se tourner vers des vrais services éprouvés.

##Types proposés par le module 
Le module de base de données propose plusieurs types (dont certains sont abstraits) : 

###Déscription des champs 

```ocaml
type Database.field_header = 
   [ `Bool | `Char | `Float | `Int | `String ]
```
Ce type (`field_header`) permet de représenter les types des champs d'une table.

```ocaml
type field =
        [ `Bool of bool
        | `Char of char
        | `Float of float
        | `Int of int
        | `String of string ]
   
```
Le type `field` permet de représenter, de manière polymorphique, les données dans les tables. (Toute donnée est typée au moyen de cette étiquette). 

**Oml.AbstractDB.database**  
Représente une base de données.

**Oml.AbstractDB.table**  
Représente une table (stockée dans une base de données).

**Oml.AbstractDB.record**  
Représente un enregistrement dans une table.

##Fonctions de conversions
Pour stocker plusieurs valeurs dans une liste, on utilise des variantes polymorphiques. Ces fonctions permettent de décrire des données polymorphes : 

**Oml.Database.int**  
`Database.field_header`  
Renvoi l'étiquette pour décrire un champ entier.


**Oml.Database.float**  
` Database.field_header`  
Renvoi l'étiquette pour décrire un champ flottant.


**Oml.Database.char**  
`Database.field_header`  
Renvoi l'étiquette pour décrire un champ caractère.


**Oml.Database.bool**  
`Database.field_header`  
Renvoi l'étiquette pour décrire un champ booléen.


**Oml.Database.string**  
`Database.field_header`  
Renvoi l'étiquette pour décrire un champ chaine de caractère.


**Oml.Database.to_int**  
`int -> Database.field`  
Transforme un entier CaML en un entier pour la base de données.


**Oml.Database.to_float**  
`float -> Database.field`  
Transforme un flottant CaML en un flottant pour la base de données.


**Oml.Database.to_char**  
`char -> Database.field`  
Transforme un caractère CaML en un caractère pour la base de données.


**Oml.Database.to_bool**  
`bool -> Database.field`  
Transforme un booléen CaML en un booléen pour la base de données.


**Oml.Database.to_string**  
`string -> Database.field`  
Transforme une chaine CaML en une chaine de caractère pour la base de données.


**Oml.Database.of_int**  
`Database.field -> int`  
Transforme un entier de la base de données en un entier CaML.

**Oml.Database.of_float**  
`Database.field -> float`  
Transforme un flottant de la base de données en un flottant CaML.

**Oml.Database.of_char**  
`Database.field -> char`  
Transforme un caractère de la base de données en un caractère CaML.

**Oml.Database.of_bool**  
`Database.field -> bool`  
Transforme un booléen de la base de données en un booléen CaML.

**Oml.Database.of_string**  
`Database.field -> string`  
Transforme une chaine de caractères de la base de données en une chaine de caractère CaML.

##Fonctions de créations de données

**Oml.Database.create**  
`string -> database`  
Construit une base de données dans le fichier passé en argument.

**Oml.Database.create_table**  
`database -> string -> (string * field_header) list -> table`  
Construit la table :  
```ocaml
open Oml
let db = Database.create "UneBDD.txt"
let table = Database.create_table db "uneTable" [
  "id", Database.id;
  "nom", Database.string;
  "sexe", Database.char
]
```
Crée la table `uneTable` dans la base de données `UneBDD.txt`.

**Oml.Database.create_record**  
`database -> table -> field list -> record`  
Sauvegarde un record dans une table. Par exemple (cumulé à l'exemple précédent) : 
```ocaml
create_record db table [
  Database.to_int 1; 
  Database.to_string "Xavier";
  Database.to_char 'M'
]
```
Ajoutera le champ dans la base de données `UneBDD.txt` et dans la table `uneTable`.

##Récupération de données 

**Oml.Database.load**  
`string -> database`  
Charge et renvoi une base de données.


**Oml.Database.get_table**  
`database -> string -> table`  
Renvoi une table d'une base de données sur base de son nom.


**Oml.Database.table_exists**  
`database -> string -> bool`  
Prend une une base de données en argument, un nom de table (sous forme de chaine de caractères) et renvoi `true` si elle existe, `false` sinon.

**Oml.Database.table_length**  
`table -> int`  
Renvoi le nombre de records dans une table.


**Oml.Database.records**  
`table -> record list`  
Renvoi la liste des records d'une table.


**Oml.Database.values**  
`record -> field list`  
Renvoi la liste des valeurs stockée dans un record.


**Oml.Database.zip_values**  
`record -> (string * field) list`  
Renvoi la liste des valeurs associé au nom de leur clé, stockée dans un record.


**Oml.Database.field**  
`record -> string -> field`  
Renvoi la valeur d'un champ particulière (en fonction de son nom).


##Requêtes
Cette section permet aussi d'accéder à des valeurs mais au moyen de filtres un peu particuliers. 


**Oml.Database.query**  
`(record -> bool) -> table -> record list `  
Fonctionne comme `List.filter` mais pour une table (filtre les records en fonction d'une fonction anonyme).

**Oml.Database.find_one**  
`(record -> bool) -> table -> record `  
Idem que `query` mais renvoi le premier record qui respecte le prédicat.

**Oml.Database.max**  
`table -> string -> record`  
Renvoi le plus grand record (en utilisant le champ passé sous forme de chaine de caractères) d'une table.


**Oml.Database.min**  
`table -> string -> record`  
Renvoi le plus petit record (en utilisant le champ passé sous forme de chaine de caractères) d'une table.


**Oml.Database.get_last**  
`table -> record`  
Renvoi le dernier record sauvegardé dans une table.


**Oml.Database.get_last_field**  
`table -> string -> record`  
Renvoi le champ passé en argument du dernier record  sauvegardé dans une table.

##Delestage des tables


**Oml.Database.delete_if**  
`database -> table -> (record -> bool) -> table`  
Supprime tous les records d'une table qui respecte le prédicat passé en argument.


**Oml.Database.keep_if**  
`database -> table -> (record -> bool) -> table`  
Supprime tous les records d'une table qui ne respecte pas le prédicat passé en argument.


**Oml.Database.drop_table**  
`database -> table -> table`  
Supprime tous les records d'une table.


**Oml.Database.remove_table**  
`database -> table -> unit`  
Supprime la table de la base de données passée en argument.

##Exemple d'usage du module
Comme vous pouvez le voir, il semblerait qu'il manque des fonctionnalités, mais comme il est très facile de transformer une table en liste de records, je n'ai pas implémenté trop de fonctions. Voici un tout petit carnet d'adresse implémenter en très peu de temps qui présente une manière (à la sémantique douteuse) d'utiliser la base de données : 

```ocaml
(* Importation d'OML *)
open Oml

(* Initialisation de la base de données *)
let database, contacts  = 
  try 
    let db = Database.load "anuaire.omldb" in 
    (db, Database.get_table db "contacts")
   with 
  (* Si la base de données n'existe pas, on la crée *)
  | Sys_error _ -> 
    let db = Database.create "anuaire.omldb" in 
    (* Création de la table *)
    let table = 
      Database.create_table db "contacts" [
	"id",   Database.int;
	"nom",  Database.string;
	"mail", Database.string;
      ] in (db, table)
      
(* Procédure principale *)
let _ = 

  let supprimer () = 
    if (Database.table_length contacts) = 0 then 
      IO.printf "\nIl n y a aucun champ à supprimer"
    else begin
      IO.println "ID a supprimer ?>";
      let id = IO.read_int () in 
      ignore (Database.delete_if database contacts 
	(fun x -> Database.of_int(Database.field x "id") = id));
      () 
    end
  in 

  let ajouter () = 
    IO.println "Nom?";
    let nom = IO.get () in 
    IO.println "\nEmail?";
    let mail = IO.get () in 
    let id = 
      try Database.get_last_field contacts "id"
      with _ -> Database.to_int 0 
    in 
    let new_id = succ (Database.of_int id) in  
    (* Création d'un record *)
    ignore (Database.create_record database contacts [
      Database.to_int new_id;
      Database.to_string nom; 
      Database.to_string mail
    ])
	
    in let choice = ref 1 
       in while !choice < 3 do
         (* Affichage de la liste  *)
	 IO.newline ();
	 IO.newline ();
	 (* Itération sur la base de données *)
	 let records =
	   List.sort (fun x y -> 
	     let a = Database.of_int(Database.field x "id")
	     and b = Database.of_int(Database.field y "id")
	     in compare a b
	   ) (Database.records contacts) 
	 in
	 List.iter begin 
	   fun record -> 
	     let id = Database.of_int (Database.field record "id")
	     and no = Database.of_string (Database.field record "nom")
	     and ml = Database.of_string (Database.field record "mail")
	     in IO.printf "%d - %s - %s \n" id no ml
	 end records;
	 IO.newline ();
	 IO.newline ();
         (* Traitement de la sélection *)
	 IO.println "1.)Ajouter un contact?";
	 IO.println "2.)Supprimer un contact?";
	 IO.println "3.)Quitter?";
	 IO.newline ();
	 IO.println "Votre choix?>";
	 choice := IO.read_int ();
	 match !choice with 
	 | 1 -> ajouter () 
	 | 2 -> supprimer ()
	 | _ -> ()
       done
 
```
Comme vous pouvez le voir, je me sers de fonctionnalités déjà existante dans CaML pour plus de fonctionnalités.


