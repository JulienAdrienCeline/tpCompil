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
	for i=1 to i do  
		let lb = new_label () in
		let _ = Hashtbl.add myTree.filsTrue lb NoFils in
		let _ = Hashtbl.add myTree.filsFalse lb NoFils in
		let _ = Hashtbl.add myTree.filsSuite lb NoFils in
		()
	done;
  myTree 

let rec makeLabels : programme -> programme = function
	| Instr_complexe(If(a,sousprog))::suite -> Instr_complexe(If(a,Label(new_label ())::sousprog))::(makeLabels suite)
	| Instr_complexe(Def(b,c,sousprog))::suite -> Instr_complexe(Def(b,c,(makeLabels sousprog)))::(makeLabels suite)
	|	anyInstr::suite -> anyInstr::(makeLabels suite)
	| [] -> []

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

(* let rec makeTree : (tree * programme) -> (myTree, prog) = function
	| (unArbre, []) -> (unArbre,[])
	| (unArbre, Instr_complexe(If(_,sousprog))::suite) -> 
			let unNouvelArbre = {
				filsTrue = 
			} in
			let resSousProg = makeTree (unNouvelArbre,sousprog) in
			(match resSousProg with
				(unAutreArbre,[]) -> 
					makeTree (unAutreArbre,suite))
	| (unArbre, anyInstr::suite) -> makeTree (unArbre,suite) *)
	

let _ = Decap.handle_exception (fun () ->
  let p = Decap.parse_channel (programme 0) blank stdin in 
	let i = countLabels p in
	let _ = Printf.printf "%d labels\n" i in
	let _ = printAll p in
	let myTree = init_tree i in
	let _ = printTree myTree in
	let p = makeLabels p in
	let _ = printAll p in
	()
	)()