#OCaML Mini Library

##Motivations

L'objectif de cette bibliothèque n'est pas de fournir la solution absolue à l'absence de bibliothèque standard pour le langage Objective-CaML. Je suis parfaitement au courant qu'il existe déjà des outils réellement convaincant (Batteries, Core) et mon but n'est pas de rivaliser avec leurs complétudes (et leurs implémentations élégantes). Je vois en effet cette expérience comme un exercice d'implémentation (et je ne le fais donc que pour mon propre intérêt).

##Installation

Une fois le dépôt clôné, vous disposez d'un Makefile. 

*    `make` (ou `make all`) : construit le fichier `.cma`, les modules compilés et un toplevel qui charge la bibliothèque OML.
*    `make oml` : construit les modules d'OML, de manière séparée. 

##Utilisation 

###Usage du toplevel OCaMLOML
Vous pouvez (une fois la commande `make` effectuée) utiliser le toplevel d'OML. Au moyen de la commande `./ocamloml`.

###Compilation d'un fichier avec OML
Il suffit de compiler le fichier en chargant la bibliothèque `oml.o oml.cma` (se référer aux documentations relatives à la compilation) et ajouter la directive `-custom`.  
Par exemple : `ocamlc -custom oml.o oml.cma mon_module.ml`    
Par défaut, la librairie `Unix` est déjà chargée dans `oml.cma`.

###Etendre les fonctionnalités
Pour étendre les modules de CaML (et charger les modules complémentaires) il suffit de faire `open Oml` et l'espace nom `Oml.etc` est tué.

##Documentation 

###Modules ajoutés
Liste des modules ajoutés à OCaML (qui ne dépendent d'aucun module parent).

*   [Oml.Bool](https://github.com/nukiFW/Oml/blob/master/doc/bool.md)
*   [Oml.Database](https://github.com/nukiFW/Oml/blob/master/doc/database.md)
*   [Oml.File](https://github.com/nukiFW/Oml/blob/master/doc/file.md)
*   [Oml.Float](https://github.com/nukiFW/Oml/blob/master/doc/float.md)
*   [Oml.Int](https://github.com/nukiFW/Oml/blob/master/doc/int.md)
*   [Oml.IO](https://github.com/nukiFW/Oml/blob/master/doc/io.md)
*   [Oml.Poly](https://github.com/nukiFW/Oml/blob/master/doc/poly.md)


###Modules étendus
Les modules étendus sont des modules qui étendent les fonctionnalités standards d'OCaML. Par soucis de concision, les fonctions qui ne sont pas modifiées ne seront pas documenté (vous pouvez vous réferrer à la documentation du langage pour les fonctions initiales).

*   [Oml.Array](https://github.com/nukiFW/Oml/blob/master/doc/array.md)
*   [Oml.Char](https://github.com/nukiFW/Oml/blob/master/doc/char.md)
*   [Oml.Marshal](https://github.com/nukiFW/Oml/blob/master/doc/marshal.md)
*   [Oml.List](https://github.com/nukiFW/Oml/blob/master/doc/list.md)
*   [Oml.String](https://github.com/nukiFW/Oml/blob/master/doc/string.md)   



##Conclusion
L'objectif d'**OML** n'est pas de fournir la "meilleure bibliothèque du monde" pour le langage OCaML, mais de s'inspirer des outils Ruby et Erlang pour accélerer mon processus de développement. Il est évident qu'il existe des solutions plus performantes (et qui offrent plus d'outils) mais ça n'en reste pas moins une expérience amusante.