open Ast
open Parser
open Llvm

let _ = Decap.handle_exception (fun () ->
  let _ = Decap.parse_channel (programme 0) blank stdin in 
	let genv = start_emit_file () in
	let _ = register_function genv "compToTreize" (Int 32) [("a", Int 32)] in
	let compToTreizeEnv = start_function genv "compToTreize" in
	(* emit_icmp env pred e1 e2 *) (* => %pred_i = icmp pred ... *)
	let macomparaison = emit_icmp compToTreizeEnv "slt" { ty = Int 32; access = "%a" } { ty = Int 32; access = "13" } in
	let lbtrue = new_label () in
	let lbfalse = new_label () in
	let lbfin = new_label () in
	let _ = emit_cond_br compToTreizeEnv macomparaison lbtrue lbfalse in
	let _ = emit_block compToTreizeEnv lbtrue in
	let _ = emit_op_bin compToTreizeEnv "add" { ty = Int 32; access = "%a" } { ty = Int 32; access = "13" } in
	let _ = emit_br compToTreizeEnv lbfin in
	let _ = emit_block compToTreizeEnv lbfalse in
	let _ = emit_op_bin compToTreizeEnv "sub" { ty = Int 32; access = "%a" } { ty = Int 32; access = "13" } in
	let _ = emit_br compToTreizeEnv lbfin in
	let _ = emit_block compToTreizeEnv lbfin in
	let _ = emit_ret compToTreizeEnv { ty = Int 32; access = "12" } in
	let _ = end_function compToTreizeEnv in
	let _ = declare_extern genv "@printf" (Int 32) ~var_args:true [Ptr (Int 8)] in
	end_emit_file genv stdout
	)()
