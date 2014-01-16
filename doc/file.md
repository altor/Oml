#Oml.File
Ce module sert des fonctions de traitement de fichier. Il est basé sur les fonctions du module `Pervasives` de OCaML. Certaines fonctions récurrentes ont été isolées (et il ne reprend donc pas toutes les fonctionnalités de traitement de fichier). Le module offre surtout une interface uniforme (et quelques fonctionnalités complémentaires utiles).

##Variables du module

*    `Oml.File.default_chmod` : `int (511)` Renvoi le chmod par défaut des fichiers.

##Fonctions du module

###Lecture de fichiers

*    **Oml.File.open_in**  
     `string -> in_channel`  
     Renvoi un fichier ouvert (à utiliser pour la lecture de fichier).


*    **Oml.File.open_in_bin**  
     `string -> in_channel`  
     Renvoi un fichier ouvert en mode binaire.


*    **Oml.File.open_in_gen**  
     `open_flag list -> int -> string -> in_channel`  
     Renvoi un fichier ouvert. Se réferer à la documentation de `Pervasives` pour plus d'informations.


*    **Oml.File.openf_in**  
     `string -> string -> in_channel`  
     Renvoi un fichier ouvert selon un format. Le second argument est un mode d'ouverture.  
     ```ocaml
      r : Read only 
      w : Write only 
      b : Open in binary mode
      + : Create if not exist
      - : Truncate if exist
      a : Append mode
      x : Fail if exist
      f : Open in NonBlockant mode
      t : Open in text mode
     ```
     Les caractères de mode sont cumulables (par exemple "rw+").


*    **Oml.File.close_in**  
     `in_channel -> unit`  
     Ferme un fichier ouvert en mode lecture.


*    **Oml.File.input_char**  
     `in_channel -> char`  
     Consomme un caractère du fichier (passé en argument).  
     **Alias :** `Oml.File.next`


*    **Oml.File.input_line**  
     `in_channel -> string`  
     Consomme une ligne du fichier (passé en argument).  
     **Alias :** `Oml.File.next_line`


*    **Oml.File.input_byte**  
     `in_channel -> int`  
     Consomme un byte du fichier (passé en argument).  
     **Alias :** `Oml.File.next_byte`

###Ecriture de fichiers

*    **Oml.File.open_out**  
     `string -> out_channel`  
     Renvoi un fichier ouvert (à utiliser pour l'écriture de fichier).


*    **Oml.File.open_out_bin**  
     `string -> in_channel`  
     Renvoi un fichier ouvert en mode binaire.


*    **Oml.File.open_out_gen**  
     `open_flag list -> int -> string -> out_channel`  
     Renvoi un fichier ouvert. Se réferer à la documentation de `Pervasives` pour plus d'informations.


*    **Oml.File.openf_out**  
     `string -> string -> out_channel`  
     Renvoi un fichier ouvert selon un format. Le second argument est un mode d'ouverture.  
     ```ocaml
      r : Read only 
      w : Write only 
      b : Open in binary mode
      + : Create if not exist
      - : Truncate if exist
      a : Append mode
      x : Fail if exist
      f : Open in NonBlockant mode
      t : Open in text mode
     ```
     Les caractères de mode sont cumulables (par exemple "a+").


*    **Oml.File.close_out**  
     `out_channel -> unit`  
     Ferme un fichier ouvert en mode écriture.


*    **Oml.File.flush**  
     `out_channel -> unit`  
     Vide un buffer.


*    **Oml.File.output_char**  
     `out_channel -> char -> unit`  
     Ecrit un caractère dans un fichier.  
     **Alias :** `Oml.File.push_char`


*    **Oml.File.output_string**  
     `out_channel -> string -> unit`  
     Ecrit une chaine caractères dans un fichier.  
     **Alias :** `Oml.File.push_string`


*    **Oml.File.output_byte**  
     `out_channel -> int -> unit`  
     Ecrit un byte dans un fichier.  
     **Alias :** `Oml.File.push_byte`

###Traitements directs
Ces fonctions concernent les fichiers qui n'ont pas a être ouvert, les fonctions ci-dessous ouvre le fichier et le ferme à la fin du traitement. Les fonctions évoquées plus haut feront plutôt office pour des traitements séquentiels, ces fonctions-ci porteront sur les traitement "all-in".


*    **Oml.File.content**  
     `string -> string`  
     Renvoi le contenu (sous forme de chaine) d'un fichier (dont le chemin est passé en argument sous forme de chaine de caractères).


*    **Oml.File.to_char_array**  
     `string -> char array`  
     Transforme un fichier (dont le chemin est passé en argument sous forme de chaine de caractères) en un tableau de caractères.


*    **Oml.File.to_line_array**  
     `string -> string array`  
     Transforme un fichier (dont le chemin est passé en argument sous forme de chaine de caractères) en un tableau de lignes (string).


*    **Oml.File.to_byte_array**  
     `string -> int array`  
     Transforme un fichier (dont le chemin est passé en argument sous forme de chaine de caractères) en un tableau de bytes.


*    **Oml.File.to_char_list**  
     `string -> char list`  
     Transforme un fichier (dont le chemin est passé en argument sous forme de chaine de caractères) en une liste de caractères.


*    **Oml.File.to_line_list**  
     `string -> string list`  
     Transforme un fichier (dont le chemin est passé en argument sous forme de chaine de caractères) en une liste de lignes (string).


*    **Oml.File.to_byte_liste**  
     `string -> int list`  
     Transforme un fichier (dont le chemin est passé en argument sous forme de chaine de caractères) en une liste de bytes.


*    **Oml.File.to_char_array**  
     `string -> char array`  
     Transforme un fichier (dont le chemin est passé en argument sous forme de chaine de caractères) en un tableau de caractères.


*    **Oml.File.to_line_array**  
     `string -> string array`  
     Transforme un fichier (dont le chemin est passé en argument sous forme de chaine de caractères) en un tableau de lignes (string).


*    **Oml.File.set_char**  
     `?create:bool -> string -> char -> unit`  
     Remplace le contenu d'un fichier par le caractère passé en argument. Si le label `create` (qui par défaut vaut `false`) est mis à `true`, le fichier sera créé s'il n'existe pas.


*    **Oml.File.set_string**  
     `?create:bool -> string -> string -> unit`  
     Remplace le contenu d'un fichier par la chaine de caractères passé en argument. Si le label `create` (qui par défaut vaut `false`) est mis à `true`, le fichier sera créé s'il n'existe pas.


*    **Oml.File.set_byte**  
     `?create:bool -> string -> int -> unit`  
     Remplace le contenu d'un fichier par le byte passé en argument. Si le label `create` (qui par défaut vaut `false`) est mis à `true`, le fichier sera créé s'il n'existe pas.


*    **Oml.File.append_char**  
     `?create:bool -> string -> char -> unit`  
     Ajoute le caractère passé en argument dans le fichier. Si le label `create` (qui par défaut vaut `false`) est mis à `true`, le fichier sera créé s'il n'existe pas.


*    **Oml.File.append_string**  
     `?create:bool -> string -> string -> unit`  
     Ajoute la chaine de caractères passé en argument dans le fichier. Si le label `create` (qui par défaut vaut `false`) est mis à `true`, le fichier sera créé s'il n'existe pas.


*    **Oml.File.append_byte**  
     `?create:bool -> string -> int -> unit`  
     Ajoute le byte passé en argument dans le fichier. Si le label `create` (qui par défaut vaut `false`) est mis à `true`, le fichier sera créé s'il n'existe pas.