open Ast
open Parser
open Ast_printer

let _ = Decap.handle_exception (fun () ->
  let p = Decap.parse_channel (programme 0) blank stdin in 
	Printf.printf "OK parser : %d instructions \n" (List.length p);
	printAll p;
	)()
