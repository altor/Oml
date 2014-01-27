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
Transforme un entier CaML en un flottant pour la base de données.


**Oml.Database.to_char**  
`char -> Database.field`  
Transforme un entier CaML en un caractère pour la base de données.


**Oml.Database.to_bool**  
`bool -> Database.field`  
Transforme un entier CaML en un booléen pour la base de données.


**Oml.Database.to_string**  
`string -> Database.field`  
Transforme un entier CaML en une chaine de caractère pour la base de données.
