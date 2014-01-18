#Oml.Marshal
Ce module propose une extension (pour plus de confort, avis personnel ;) ) sur la sérialisation des objets en CaML. Comme pour les autres modules, les anciennes fonctions du modules sont conservées (et consultables sur la documentation de OCaML).

##Fonctions ajoutés

L'objectif de ces fonctions est de raccourcir la procédure de sérialisation d'un objet CaML (en reprenant la philosophie du module `File`).

*    **Oml.Marshal.dump**  
     `?flags:string -> string -> 'a -> unit`  
     Ecrit l'objet (`'a`) dans le fichier (nommé par l'argument `string`).  
     **Arguments des flags**  
     *    `"n"` : Ne conserve pas le partage
     *    `"f"` | `"c"` | `"l"` : L'objet contient une fonction
     *    `"u"` | `"b"` | `"+"` : Compatibilité pour des entiers sur 32Bits.  
    Comme pour les fichiers, on peut cumuler des attributs `"nf+"` ou "cu". 


*    **Oml.Marshal.load**  
     `string -> 'a`
     Renvoi l'objet sérialisé dans le fichier passé en argument.  
     **Exemple**:
     ```ocaml
     Marshal.dump "test.txt" 99;;
     Marshal.dump "autreTest.txt" (Some 10);;
     let a : int = Marshal.load "test.txt";;
     let b : int option = Marshal.load "autreTest.txt";;
     ```  
     Il faut forcer le type lors de la déserialisation, sinon le type de retour correspond à `'a <poly>`.


*    **Oml.Marshal.serialize**  
     `?flags:string -> 'a -> string`  
     Transforme l'objet (`'a`) en chaine de caractère.  
     **Arguments des flags**  
     *    `"n"` : Ne conserve pas le partage
     *    `"f"` | `"c"` | `"l"` : L'objet contient une fonction
     *    `"u"` | `"b"` | `"+"` : Compatibilité pour des entiers sur 32Bits.  
    Comme pour les fichiers, on peut cumuler des attributs `"nf+"` ou "cu".

*    **Oml.Marshal.unserialize**  
     `?offset:int -> string -> 'a`  
     Déserialize la chaine passée en argument, l'offset correspond au caractère à partir duquel il faut évaluer la désérialisation. Par défaut, il vaut `0` (Commence au début de la chaine). Comme pour `Oml.Marshal.load` il vaut mieux forcer le typage pour éviter d'avoir des `'a <poly>` comme retour.