open Ast
open Ast_printer
open Parser
open Llvm
let _ = Decap.handle_exception (fun () ->
  let p = Decap.parse_channel (programme 0) blank stdin in 
	printAll p )()
