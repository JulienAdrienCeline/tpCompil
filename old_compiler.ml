open Ast
open Parser
open Llvm

let _ = Decap.handle_exception (fun () ->
  let p = Decap.parse_channel (programme 0) blank stdin in 
	let genv = start_emit_file () in
	let x = declare_global genv "x" (Int 32) "20" in
	let y = declare_global genv "y" (Int 32) "5" in
	let max = register_function genv "max" (Int 32) [("a", Int 32); ("b", Int 32)] in
	let maxenv = start_function genv "max" in
	let maxret = emit_ret maxenv { ty = Int 32; access = "12" } in
	let maxend = end_function maxenv in
	let _ = declare_extern genv "@printf" (Int 32) ~var_args:true [Ptr (Int 8)] in
	end_emit_file genv stdout
	)()


