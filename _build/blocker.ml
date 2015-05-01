open Ast
open Parser
open Llvm
open Ast_printer

type fils =
	Fils of label
	| NoFils

type tree = {
	filsTrue: (label , fils) Hashtbl.t;
	filsFalse: (label , fils) Hashtbl.t;
	filsSuite: (label , fils) Hashtbl.t;
}

let rec countIf : programme -> int = function
	| Instr_complexe(If(_,sousprog))::suite -> 1 + (countIf sousprog) + (countIf suite)
	| Instr_complexe(Def(_,_,sousprog))::suite -> (countIf sousprog) + (countIf suite)
	|	anyInstr::suite -> (countIf suite)
	| [] -> 0

let countLabels prog = 1 + 2 * (countIf prog)

let init_tree i =
  let myTree = {
    filsTrue = Hashtbl.create i;
    filsFalse = Hashtbl.create i;
		filsSuite = Hashtbl.create i;
  }
  in
  myTree 

let rec makeLabels myTree : programme -> (tree * programme) = function
	| Instr_complexe(If(a,sousprog))::suite -> 
			let lbTrue = new_label () in
			let lbSuite = new_label () in
			let _ = Hashtbl.add myTree.filsTrue lbTrue NoFils in
			let _ = Hashtbl.add myTree.filsFalse lbTrue NoFils in
			let _ = Hashtbl.add myTree.filsSuite lbTrue NoFils in
			let _ = Hashtbl.add myTree.filsTrue lbSuite NoFils in
			let _ = Hashtbl.add myTree.filsFalse lbSuite NoFils in
			let _ = Hashtbl.add myTree.filsSuite lbSuite NoFils in
			let mlSousProg = makeLabels myTree sousprog in
			(match mlSousProg with 
				(newTree, newSousprog) -> 
					let mlSuite = makeLabels newTree suite in
					(match mlSuite with
						(newNewTree, newSuite) ->
					 		(newNewTree, 
								Instr_complexe(If(a,Label(lbTrue)::newSousprog))
								::(Label(lbSuite)::newSuite)
							)
					)
			)
	| Instr_complexe(Def(b,c,sousprog))::suite -> 
			let mlSousProg = makeLabels myTree sousprog in
			(match mlSousProg with 
				(newTree, newSousprog) -> 
					let mlSuite = makeLabels newTree suite in
					(match mlSuite with
						(newNewTree, newSuite) ->
					 		(newNewTree, Instr_complexe(Def(b,c,newSousprog))::newSuite)
					)
			)
	|	anyInstr::suite -> 
		let mlSuite = makeLabels myTree suite in
		(match mlSuite with
			(newTree, newSuite) -> 
				(newTree, anyInstr::newSuite)
		)
	| [] -> (myTree, [])

let string_of_fils : fils -> string = function
	| Fils(f) -> f
	| NoFils -> "NoFils"

let string_of_binome : (label * fils) -> string = function
	| (lb, f) -> String.concat "" ["("; lb ; " , " ; (string_of_fils f) ; ")"]

let print_tbl table = 
	Hashtbl.iter ( fun lb f -> Printf.printf "%s " (string_of_binome (lb,f)) ) table

let printTree myTree =
	Printf.printf "filsTrue : ";
	print_tbl myTree.filsTrue;
	Printf.printf "\n";
	Printf.printf "filsFalse : ";
	print_tbl myTree.filsFalse;
	Printf.printf "\n";
	Printf.printf "filsSuite : ";
	print_tbl myTree.filsSuite;
	Printf.printf "\n"
	

let _ = Decap.handle_exception (fun () ->
  let p = Decap.parse_channel (programme 0) blank stdin in 
	let i = countLabels p in
	let _ = Printf.printf "%d labels\n" i in
	let _ = printAll p in
	let myTree = init_tree i in
	let _ = printTree myTree in
	let res = makeLabels myTree p in
	match res with
		(newTree , newProg) ->
			let _ = printAll newProg in
			let _ = printTree newTree in
			()
	)()
