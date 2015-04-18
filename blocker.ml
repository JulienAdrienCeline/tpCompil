open Ast
open Parser
open Llvm
open Ast_printer

(* Ce fichier aura pour but de définir à l'avance le graph des labels et des phis à mettre 
=> on obtiendra une sorte de deuxième ast, dans laquelle on ajoutera les phis *)

type idvar = string (* nom d'une variable dans le programme source *)
type idllvm = string (* nom d'une variable dans le programme llvm *)
type nomlab = string (* nom d'un label *)

type noeud = {

	listVars: (idvar list); (* liste des noms sources des variables *)
	listPhis: (idvar * ((idllvm * nomlab) list)) list; (* liste des origines possibles de chaque variable de listVars) *)
	filsTrue: noeud; (* quoi faire si true ;; flèche verte *)
	filsFalse: noeud; (* où aller si on entre pas dans le filsTrue ;; flèche rouge *)
	filsSuite: noeud; (* bloc qui suit dans l'ordre llvm ;; flèche noire *)
}
