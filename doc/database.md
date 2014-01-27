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








