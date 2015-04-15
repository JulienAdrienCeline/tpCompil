open Ast
open Parser
open Llvm

let _ = Decap.handle_exception (fun () ->
  let p = Decap.parse_channel (programme 0) blank stdin in 
	let genv = start_emit_file () in
	let compToTreize = register_function genv "compToTreize" (Ptr (Int 8)) [("a", Ptr (Int 8))] in
	let compToTreizeEnv = start_function genv "compToTreize" in
	let compToTreizeEnd = end_function compToTreizeEnv in
	let _ = declare_extern genv "@printf" (Int 32) ~var_args:true [Ptr (Int 8)] in
	end_emit_file genv stdout
	)()
