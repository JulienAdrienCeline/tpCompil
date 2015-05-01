open Ast
open Parser
open Llvm
open Ast_printer

(* Arbre ternaire, à chaque if on crée un noeud (= un label), chaque label a un fils true, un fils false et un fils suite *)
(* Le fils est un noeud (= un label) ou NoFils si c'était une feuille *)
type fils =
	Fils of label
	| NoFils
type tree = {
	filsTrue: (label , fils) Hashtbl.t; (* où va-t-on si la condition est vérifiée *)
	filsFalse: (label , fils) Hashtbl.t; (* où va-t-on si la condition n'est pas vérifiée *)
	filsSuite: (label , fils) Hashtbl.t; (* où ira-t-on après si la condition est vérifiée *)
	variables: (label , (string list)) Hashtbl.t; (* quels noms de variables existent dans un label donné *)
}

(* On pourra prévoir au départ le nombre de noeuds nécessaire, en comptant les if dans le programme *)
(* => permettra d'initialiser les Hashtbl à la bonne taille *)
let rec countIf : programme -> int = function
	| Instr_complexe(If(_,sousprog))::suite -> 1 + (countIf sousprog) + (countIf suite)
	| Instr_complexe(Def(_,_,sousprog))::suite -> (countIf sousprog) + (countIf suite)
	|	anyInstr::suite -> (countIf suite)
	| [] -> 0
let countLabels prog = 1 + 2 * (countIf prog)

(* On initialise les Hashtbl à la bonne taille, et on place le label racine de l'arbre au début du programme *)
let init_tree i p =
  let myTree = {
    filsTrue = Hashtbl.create i;
    filsFalse = Hashtbl.create i;
		filsSuite = Hashtbl.create i;
		variables = Hashtbl.create i;
  }
  in
	let lbInit = new_label () in
	let p = Ast.Label(lbInit)::p in
	let _ = Hashtbl.add myTree.filsTrue lbInit NoFils in
	let _ = Hashtbl.add myTree.filsFalse lbInit NoFils in
	let _ = Hashtbl.add myTree.filsSuite lbInit NoFils in
	let _ = Hashtbl.add myTree.variables lbInit [] in
	(lbInit, myTree , p)

(* On construit l'arbre en suivant notre algo de graphe. *)
let rec makeLabels curentLabel myTree : programme -> (tree * programme) = function
	(* Si on rencontre l'affectation d'une nouvelle variable, il faut l'ajouter au scope du label courant *)
	| Affectation(Id_name id, expr)::suite ->
			let variablesDuLabelCourant = Hashtbl.find myTree.variables curentLabel in
			let _ = try List.find (fun name -> (name = id)) variablesDuLabelCourant with Not_found -> 
				let _ = Hashtbl.replace myTree.variables curentLabel (id::variablesDuLabelCourant) in
				""
			in
			let mlSuite = makeLabels curentLabel myTree suite in
			(match mlSuite with
				(newTree, newSuite) -> 
					(newTree, Affectation(Id_name id, expr)::newSuite)
			)
	(* If(Condition) then BlockTrue EndIf BlockSuite *)
	| Instr_complexe(If(a,sousprog))::suite -> 
			(* On construit les labels de début du BlockTrue et du BlockSuite *)
			let lbTrue = new_label () in
			let lbSuite = new_label () in
			let variablesDuLabelCourant = Hashtbl.find myTree.variables curentLabel in
			let _ = Hashtbl.add myTree.filsTrue lbTrue NoFils in
			let _ = Hashtbl.add myTree.filsFalse lbTrue NoFils in
			let _ = Hashtbl.add myTree.filsSuite lbTrue NoFils in
			let _ = Hashtbl.add myTree.variables lbTrue variablesDuLabelCourant in
			let _ = Hashtbl.add myTree.filsTrue lbSuite NoFils in
			let _ = Hashtbl.add myTree.filsFalse lbSuite NoFils in
			let _ = Hashtbl.add myTree.filsSuite lbSuite NoFils in
			let _ = Hashtbl.add myTree.variables lbSuite variablesDuLabelCourant in
			(* Si la condition n'est pas vérifiée, on ira directement au BlockSuite *)
			let _ = Hashtbl.replace myTree.filsFalse curentLabel (Fils lbSuite) in (* rouge *)
			(* Si la condition est vérifiée, on ira BlockTrue *)
			let _ = Hashtbl.replace myTree.filsTrue curentLabel (Fils lbTrue) in (* verte *)
			(* Si la condition est vérifiée, après avoir fait le BlockTrue on fera le BlockSuite *)
			let _ = Hashtbl.replace myTree.filsSuite lbTrue (Fils lbSuite) in (* noire *)
			(* Si le block courant avait déjà une suite prévue, il faut faire cette suite après avoir parcouru le BlockSuite *)
			let filsSuiteDuLabelCourant = Hashtbl.find myTree.filsSuite curentLabel in
			(match filsSuiteDuLabelCourant with
				NoFils -> ()
				| Fils(lbSuiteDuLabelCourant) ->
						let _ = Hashtbl.replace myTree.filsSuite curentLabel NoFils in (* supprimer ancienne noire *)
						let _ = Hashtbl.replace myTree.filsSuite lbSuite (Fils lbSuiteDuLabelCourant) in (* la remettre au bout de la rouge *)
						()
			);
			(* Les enfants connaissent les variables de leur parent *)
			(* On refait le travail à l'intérieur du BlockTrue et du BlockSuite *)
			let mlSousProg = makeLabels lbTrue myTree sousprog in
			(match mlSousProg with 
				(newTree, newSousprog) -> 
					let mlSuite = makeLabels lbSuite newTree suite in
					(match mlSuite with
						(newNewTree, newSuite) ->
					 		(newNewTree, 
								Instr_complexe(If(a,Label(lbTrue)::newSousprog))
								::(Label(lbSuite)::newSuite)
							)
					)
			)
	(* autres instructions : l'arbre reste inchangé, on continue *)
	| Instr_complexe(Def(b,c,sousprog))::suite -> 
			let mlSousProg = makeLabels curentLabel myTree sousprog in
			(match mlSousProg with 
				(newTree, newSousprog) -> 
					let mlSuite = makeLabels curentLabel newTree suite in
					(match mlSuite with
						(newNewTree, newSuite) ->
					 		(newNewTree, Instr_complexe(Def(b,c,newSousprog))::newSuite)
					)
			)
	|	anyInstr::suite -> 
		let mlSuite = makeLabels curentLabel myTree suite in
		(match mlSuite with
			(newTree, newSuite) -> 
				(newTree, anyInstr::newSuite)
		)
	(* fin de récursion, il n'y a plus aucune instruction à évaluer, l'arbre et le programmes sont complets *)
	| [] -> (myTree, [])


(* Fonctions d'affichage pour débug *)
let string_of_fils : fils -> string = function
	| Fils(f) -> f
	| NoFils -> "NoFils"
let string_of_binome : (label * fils) -> string = function
	| (lb, f) -> String.concat "" ["("; lb ; " , " ; (string_of_fils f) ; ")"]
let print_tbl table = 
	Hashtbl.iter ( fun lb f -> Printf.printf "%s " (string_of_binome (lb,f)) ) table
let string_of_list aList =
	String.concat "" [ "[ " ; String.concat " ; " aList ; " ]" ]
let print_vars table =
	Hashtbl.iter ( fun lb aList -> Printf.printf "( %s : %s)" lb (string_of_list aList) ) table
let printTree myTree =
	Printf.printf "filsTrue : ";
	print_tbl myTree.filsTrue;
	Printf.printf "\n";
	Printf.printf "filsFalse : ";
	print_tbl myTree.filsFalse;
	Printf.printf "\n";
	Printf.printf "filsSuite : ";
	print_tbl myTree.filsSuite;
	Printf.printf "\n";
	Printf.printf "variables : ";
	print_vars myTree.variables;
	Printf.printf "\n"
	

(* Exécution du programme *)
let _ = Decap.handle_exception (fun () ->
  let p = Decap.parse_channel (programme 0) blank stdin in 
	let i = countLabels p in
	let _ = Printf.printf "%d labels\n" i in
	let _ = printAll p in
	let resInitial = init_tree i p in
	match resInitial with
		(firstLabel, myTree, newP) ->
		let _ = printTree myTree in
		let res = makeLabels firstLabel myTree newP in
		(match res with
			(newTree , newProg) ->
				let _ = printAll newProg in
				let _ = printTree newTree in
				()
		)
	)()
