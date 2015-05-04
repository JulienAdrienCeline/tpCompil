 _________________________________
| 																|
| Julien Caballol									|
| Adrien Detraz										|
| Céline de Roland								|
|																	|
| TP de compilation, M1 STIC ISC	|
|_________________________________|

 --------------
| SEMANTIQUE : |
 --------------

	Le cahier des charges :
	-----------------------

		Nous avons écrit un langage "à la Python", avec indentations significatives (Attention, il faut mettre un espace seulement par étage -> on n' accepte pas les tabulations ou les décalages de plus d'un espace à chaque fois)
		Nous avons 3 types : entier, booleen, string
		Les variables n'ont pas besoin d'être déclarées, et peuvent changer de type si on les réaffecte
		Nous proposons en plus le mot clé print pour afficher une expression (exemple : print 3 + b)
		Nous proposons une structure conditionnelle if 
			(exemple: 
				if(3 < 12):      // Attention : pas d'espace entre if et (
				 print b )
		Nous proposons la notion de closure

	Les étapes :
	------------

		1) Définition de l'AST (fichier ast.ml)
		2) On parse un programme grammaticalement correct pour créer son AST (fichier parser.ml)
		3) Semantique.ml lit l'AST et fait ce que doit faire le programme (fichier semantique.ml)

	Comment faire ?
	---------------

		Videz le dossier tests
		Dans le dossier tests, placez le fichier exemple.py de votre choix (utilisez les exemples de exemples/semantique ou exemples/compilation ou écrivez vos propres programmes)
		Entrez la commande sh build_sans_compilation.sh 
		Observez les résultats (fichiers resultat_???.txt dans le dossier tests)

 ---------------
| COMPILATION : |
 ---------------

	Modifications du cahier des charges :
	-------------------------------------

		Nous avons 1 seul type : entier pour les expressions, nous utilisons également les booléens pour les conditions
		Nous ne proposons pas la notion de closure, les defs doivent se situer à l'indentation 0

	Les étapes :
	------------

		1) Définition de l'AST (fichier ast.ml)
		2) On parse un programme grammaticalement correct pour créer son AST (fichier parser.ml)
		3) On prévoit la présence des labels et des phis et on les ajoute à l'AST (fichier phis_and_labels.ml)
		4) On écrit le programme en assembleur llvm (fichiers llvm.ml et compiler.ml)

	Comment faire ?
	---------------

		Videz le dossier tests
		Dans le dossier tests, placez le fichier exemple.py de votre choix (utilisez les exemples de exemples/compilation ou écrivez vos propres programmes)
		Entrez la commande sh build_avec_compilation.sh 
		ATTENTION : si vous êtes en 64bits, veuillez changer la ligne 12, -march=x86 en -march=x86-64
		Observez les résultats (fichiers resultat_???.* dans le dossier tests)
