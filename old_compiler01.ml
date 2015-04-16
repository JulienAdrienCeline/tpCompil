open Ast
open Parser
open Llvm

let _ = Decap.handle_exception (fun () ->
  let _ = Decap.parse_channel (programme 0) blank stdin in 
	let genv = start_emit_file () in
	let _ = declare_extern genv "@printf" (Int 32) ~var_args:true [Ptr (Int 8)] in

	(* Je commence la fonction compToTreize *)
	let _ = register_function genv "compToTreize" (Int 32) [("a", Int 32)] in
	let compToTreizeEnv = start_function genv "compToTreize" in

	(* Dans la fonction je fais un if (condition) then block1 else block2 *)
		(* Je commence par évaluer la condition *)
			(* emit_icmp env pred e1 e2 *) (* => %pred_i = icmp pred ... *)
			let macomparaison = emit_icmp compToTreizeEnv "slt" { ty = Int 32; access = "%a" } { ty = Int 32; access = "13" } in
		(* Je définis les 2 labels : quoi faire si true, quoi faire si false *)
			let lbtrue = new_label () in
			let lbfalse = new_label () in
		(* J'émets le branchement conditionnel pour aller sur true ou sur false *)
			let _ = emit_cond_br compToTreizeEnv macomparaison lbtrue lbfalse in
		(* Je définis le block true *)
			let _ = emit_block compToTreizeEnv lbtrue in
			let resT = emit_op_bin compToTreizeEnv "add" { ty = Int 32; access = "%a" } { ty = Int 32; access = "13" } in
			let _ = emit_ret compToTreizeEnv resT in
		(* Je définis le block false *)
			let _ = emit_block compToTreizeEnv lbfalse in
			let resF = emit_op_bin compToTreizeEnv "sub" { ty = Int 32; access = "%a" } { ty = Int 32; access = "13" } in
			let _ = emit_ret compToTreizeEnv resF in
			

	(* Je termine la fonction compToTreize *)
			let _ = end_function compToTreizeEnv in

	(* Je démarre la fonction main *)
			let mainEnv = start_init_code genv in

	(* Je vais appeler ma fonction dans le main *)
			let fn = search_global genv "compToTreize" in
			let resPg = emit_call mainEnv fn [{ ty = Int 32; access = "15" }] in (* ==> résultat : 2 *)
			let resPp = emit_call mainEnv fn [{ ty = Int 32; access = "7" }] in (* ==> résultat : 20 *)

	(* Je vais afficher le résultat *)
			let printf = search_global genv "@printf" in
			let strConst = declare_string_constant genv "str" "Les résultats sont %d et %d\n" in
			let _ = emit_call mainEnv printf [strConst; resPg; resPp] in

	(* Je termine la fonction main *)
			let _ = end_init_code mainEnv in

	end_emit_file genv stdout
	)()
