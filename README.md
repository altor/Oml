#OCaML Mini Library

##Motivations

L'objectif ce cette bibliothèque n'est pas de fourni à la solution absolue à l'absence de bibliothèque standard pour le langage Objective-CaML. Je suis parfaitement au courant qu'il existe déjà des outils réellement convaincant (Batteries, Core) et mon but n'est pas de tenter de leur faire de l'ombre. Je vois en effet cette expérience comme un exercice d'implémentation (et je ne le fais donc que pour mon propre intérêt).

##Installation

Une fois le dépôt clôné, vous disposez d'un Makefile. 

*    `make` (ou `make all`) : construit le fichier `.cma` et un toplevel qui charge la bibliothèque OML.

*    `make oml` : construit les modules d'OML, de manière séparée. 

##Utilisation 

###Usage du toplevel OCaMLOML
Vous pouvez (une fois la commande `make` effectuée) utiliser le toplevel d'OML. Au moyen de la commande `./ocamloml` ou alors `ocaml oml.cma`.

###Compilation d'un fichier avec OML
Il suffit de compiler le fichier en chargant la bibliothèque `oml.cma` (se référer aux documentations relatives à la compilation).

##Documentation 

###Fonctions standards
###Modules ajoutés
###Modules étendus

##Conclusion
