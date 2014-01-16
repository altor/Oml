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
     **Alias : ** `Oml.File.next`


*    **Oml.File.input_line**  
     `in_channel -> string`  
     Consomme une ligne du fichier (passé en argument).  
     **Alias : ** `Oml.File.next_line`


*    **Oml.File.input_byte**  
     `in_channel -> int`  
     Consomme un byte du fichier (passé en argument).  
     **Alias : ** `Oml.File.next_byte`

###Ecriture de fichiers