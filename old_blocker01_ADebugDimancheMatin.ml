open Ast
open Parser
open Llvm
open Ast_printer

(* Ce fichier aura pour but de définir à l'avance le graph des labels et des phis à mettre 
=> on obtiendra une sorte de deuxième ast, dans laquelle on ajoutera les phis *)

type block =
	NoB
	| Label of label

type allLabels = label list

type filsFalse = (label * block) list

type filsTrue = (label * block) list

type filsSuite = (label * block) list

type phisFromFalse = (label * ((string * label) list)) list
type phisFromSuite = (label * ((string * label) list)) list

type vars = (label * (string list)) list (* pour chaque label ses variables *)

let printALab : label -> unit = fun aLab -> Printf.printf "%s ; " aLab

let string_of_block : block -> string = function
	NoB -> "NOB"
	| Label l -> l

let printAPairLbBlock: (label * block) -> unit = function
	(aLab, aBlock) -> Printf.printf "(%s , %s) ; " aLab (string_of_block aBlock)
	| _ -> failwith "probleme"

let printAPairStLab: (string * label) -> unit = function
	(aStr, aLab) -> Printf.printf "(%s , %s)" aStr aLab
	| _ -> failwith "probleme"

let printAListStLab: (label * ((string * label) list)) = function
	(aLab, aListOfPairStLab) ->
		Printf.printf "%s : " aLab;
		List.iter printAPairStLab aListOfPairStLab;
		Printf.printf "\n"
	| _ -> failwith "probleme"
	
let printPhis: (label * ((string * label) list)) list -> unit = fun aListOfListStLab ->
	(List.iter printAListStLab aListOfListStLab);
	Printf.printf "\n"

let printAllLabs : label list -> unit = fun aListOfLabs ->
	(List.iter printALab aListOfLabs);
	Printf.printf "\n"

let printAllFils : (label * block) list = fun aListOfPairLbBlock ->
	(List.iter printAPairLbBlock aListOfPairLbBlock);
	Printf.printf "\n"

let printAll (allLabels:allLabels) (filsFalse:filsFalse) (filsTrue:filsTrue) (filsSuite:filsSuite) (phisFromFalse:phisFromFalse) (phisFromSuite::phisFromSuite) =
	Printf.printf "\n LABELS \n";
	printAllLabs allLabels;
	Printf.printf "\n FILS FALSE \n";
	printAllFils filsFalse;
	Printf.printf "\n FILS TRUE \n";
	printAllFils filsTrue;
	Printf.printf "\n FILS SUITE \n";
	printAllFils filsSuite;
	Printf.printf "\n PHIS FALSE \n";
	printPhis phisFromFalse;
	Printf.printf "\n PHIS SUITE \n";
	printPhis phisFromSuite;
	()


(* Je fabrique l'arbre des labels *)
let bloc (monLabel:label) (allLabels:allLabels) (filsFalse:filsFalse) (filsTrue:filsTrue) (filsSuite:filsSuite) (vars:vars) : 
	programme -> (allLabels * filsFalse * filsTrue * filsSuite * vars * labprogramme) = function
	| [] -> []
	| (Affectation(Id_name id, expr))::suite -> (
			let listOfVarsForTheLabel = List.assoc label vars in
			let _ = List.remove_assoc label vars in
			let vars = (label, id::listOfVarsForTheLabel)::vars in
			let evalSuite = bloc label allLabels filsFalse filsTrue filsSuite vars suite in
			match evalSuite with 
				(a, ff, ft, fs, v, lp) ->
					(a, ff, ft, fs, v, (AstInstruction (Affectation(Id_name id, expr)))::lp)
				| _ -> failwith "probleme")

	| (Instr_complexe If(expr,sousprog))::suite -> (
			(* Je crée deux nouveaux labels *)
			let lbTrue = new_label () in
			let lbFin = new_label () in
			let allLabels = lbTrue::lbFin::allLabels in
			
			(* Ces deux labels ont les mêmes variables que le précédent *)
			let listOfVarsForTheLabel = List.assoc label vars in
			let vars = (lbTrue, listOfVarsForTheLabel)::(lbFin, listOfVarsForTheLabel)::vars in
			let filsTrue = (label, Label lbTrue)::filsTrue in
			let filsFalse = (label, Label lbFin)::filsFalse in
			
			(* Ces deux labels n'ont pas de filsTrue, filsFalse *)
			let filsFalse = (lbTrue, NoB)::(lbFin, NoB)::filsFalse in
			let filsTrue = (lbTrue, NoB)::(lbFin, NoB)::filsTrue in
			(* On ne sait pas encore les phis pour ces deux labels *)
			let phisFromFalse = (lbTrue, [])::(lbFin, [])::[] in
			let phisFromSuite = (lbTrue, [])::(lbFin, [])::[] in

			(* Si le label courant avait déjà une suite, alors ce n'est plus la suite du label courant, mais la suite du label lbFin *)
			(* Le label true quand à lui, a pour suite le label fin *)
			let suivantDuCourant = List.assoc label filsSuite in
			let _ = List.remove_assoc label filsSuite in
			let filsSuite = (lbTrue, Label lbFin)::(lbFin, suivantDuCourant)::(label, NoB)::filsSuite in

			(* On évalue le bloc true et le bloc fin *)
			let evalTrue = bloc lbTrue allLabels filsFalse filsTrue filsSuite vars sousprog in
			match evalTrue with 
				(a, ff, ft, fs, v, btrue) -> (
					let evalSuite = bloc lbFin a ff ft fs v suite in
					match evalSuite with
						(a', ff', ft', fs', v', bsuite) ->
							(a', ff', ft', fs', v', 
								List.concat[
									[(AstInstruction (Instr_complexe If(expr,sousprog)))];
									[(LlvmInstruction (Label lbTrue))];
									btrue;
									[(LlvmInstruction (Label lbFin))];
									bsuite]
							)
						| _ -> failwith "probleme"
					)
				| _ -> failwith "probleme")

	| instr::suite -> (
			let evalSuite = bloc label allLabels filsFalse filsTrue filsSuite vars suite in
			match evalSuite with 
				(a, ff, ft, fs, v, lp) ->
					(a, ff, ft, fs, v, (AstInstruction instr)::lp)
				| _ -> failwith "probleme")

	| _ -> failwith "probleme"

let makePhisFalse (lbSource:label) (phisFromFalse:phisFromFalse) : label -> phisFromFalse = function
	NoB -> phisFromFalse
	| Label l ->
			let vars = List.assoc l vars in
			let phisFromFalseDeL = List.assoc l phisFromFalse in
			let _ = List.remove_assoc l phisFromFalse in
			List.iter (fun aVar -> (phisFromFalseDeL = (aVar, lbSource):: phisFromFalseDeL; ())) vars;
			(l, phisFromFalseDeL)::phisFromFalse
	| _ -> failwith "probleme"

let makePhisSuite (lbSource:label) (phisFromSuite:phisFromSuite) (vars:vars) : label -> phisFromSuite = function
	NoB -> phisFromSuite
	| Label l ->
			let vars = List.assoc l vars in
			let phisFromSuiteDeL = List.assoc l phisFromSuite in
			let _ = List.remove_assoc l phisFromSuite in
			List.iter (fun aVar -> (phisFromSuiteDeL = (aVar, lbSource):: phisFromSuiteDeL; ())) vars;
			(l, phisFromSuiteDeL)::phisFromSuite
	| _ -> failwith "probleme"


(* Une fois que l'arbre est terminé, je peux connaitre les parents directs de chaque label => prévoir les phis nécessaire *)
let makePhis (monLabel:label) (filsFalse:filsFalse) (filsTrue:filsTrue) (filsSuite:filsSuite) (vars:vars) (phisFromFalse:phisFromFalse) (phisFromSuite::phisFromSuite) =
	let filsSuiteDuLabelCourant = List.assoc label filsSuite in
	let phisFromSuite = makePhisSuite label phisFromSuite vars filsSuiteDuLabelCourant in

	let filsFalseDuLabelCourant = List.assoc label filsFalse in
	let phisFromFalse = makePhisFalse label phisFromFalse vars filsFalseDuLabelCourant in

	let filsTrueDuLabelCourant = List.assoc label filsTrue in

	match filsTrueDuLabelCourant with
		| NoB -> (phisFromFalse, phisFromSuite)
		| Label lbFilsTrue -> (
				match filsFalseDuLabelCourant with
					| Label lbFilsFalse -> (
							let evalTrue = makePhis lbFilsTrue filsFalse filsTrue filsSuite vars phisFromFalse phisFromSuite in
							match evalTrue with
								(newPhisFromFalse, newPhisFromSuite) -> (
									let evalFalse = makePhis lbFilsFalse filsFalse filsTrue filsSuite vars newPhisFromFalse newPhisFromSuite in
									evalFalse
								)
								| _ -> failwith "probleme"
					)
					| _ -> failwith "probleme"
		)
		| _ -> failwith "probleme"


let doBlock monProg =
	let lbFirst = new_label () in
	let allLabels = lbFirst::[] in
	let filsFalse = (lbFirst, NoB)::[] in
	let filsTrue = (lbFirst, NoB)::[] in
	let filsSuite = (lbFirst, NoB)::[] in
	let phisFromFalse = (lbFirst, [])::[] in
	let phisFromSuite = (lbFirst, [])::[] in
	let vars = (lbFirst, [])::[] in
	let eval = bloc lbFirst allLabels filsFalse filsTrue filsSuite vars monProg in
	let phisResult = makePhis lbFirst filsFalse filsTrue filsSuite vars phisFromFalse phisFromSuite
	match eval with 
		(a, ff, ft, fs, v, lp) -> (
			let lp = [(LlvmInstruction (Label lbFirst))]::lp in
			match phisResult with
				(pf, ps) -> (
					printAll a ff ft fs pf ps;
					lp
				)
				| _ -> failwith "probleme"
		)
		| _ -> failwith "probleme"
			(* let lp = [(LlvmInstruction (Label lbFirst))]::lp in *)
			
let _ = Decap.handle_exception (fun () ->
  let p = doBlock (Decap.parse_channel (programme 0) blank stdin) in 

	)()

