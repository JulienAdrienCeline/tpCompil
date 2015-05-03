open Ast
open Parser
open Ast_printer
open Phis_and_labels

let _ = Decap.handle_exception (fun () ->
  let p = Decap.parse_channel (programme 0) blank stdin in 
	let i = countLabels p in
	let resInitial = init_tree i p in
	match resInitial with
		(firstLabel, myTree, newP) ->
		let res = makeLabels firstLabel myTree newP in
		(match res with
			(newTree , newProg) ->
				let newTreeWithPhis = makePhis newTree in
				let newProgWithPhis = ajouter_phis newTreeWithPhis newProg in
				let _ = printAll newProgWithPhis in
				let _ = printTree newTreeWithPhis in
				()
		)
	)()
