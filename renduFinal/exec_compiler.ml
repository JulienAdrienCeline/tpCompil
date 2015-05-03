open Ast
open Parser
open Llvm
open Ast_printer
open Phis_and_labels
open Compiler

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
					let genv = start_emit_file () in
					let _ = declare_extern genv "@printf" (Int 32) ~var_args:true [Ptr (Int 8)] in
					let mainEnv = start_init_code genv in
					let _ = emit_br mainEnv firstLabel in
					let _ = emit_block mainEnv firstLabel in
					let _ = evalProg newTreeWithPhis genv mainEnv newProgWithPhis in
					let _ = end_init_code mainEnv in 
					end_emit_file genv stdout;
					()
			)
	)()
