open Ast
open Parser
open Llvm
open Ast_printer

(* Ce fichier aura pour but de définir à l'avance le graph des labels et des phis à mettre 
=> on obtiendra une sorte de deuxième ast, dans laquelle on ajoutera les phis *)

(* Pour exemple.py, ça donnera quelque chose comme :
	1 :								-> defs : a,b,c,d
		-> true = 2
		-> suite = 3
	2 :								-> defs : a
		-> true = 4
		-> suite = 5
	4 :								-> defs : b
		-> true = 6
		-> suite = 7
	6 :								-> defs : a,c
		-> suite = 7
	7 :								-> defs : none ;; phis : a,c
		-> suite = 5
	5 :								-> defs : d ;; phis : b
		-> suite = 3		-> defs : none ;; phis : a,d
*)
