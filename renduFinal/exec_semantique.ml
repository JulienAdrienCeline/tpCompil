open Ast
open Parser
open Ast_printer
open Semantique

let _ = Decap.handle_exception (fun () ->
  let p = Decap.parse_channel (programme 0) blank stdin in 
	let r = evalProg ([],[]) p in
	match r with 
		Boolean b ->
				Printf.printf "OK sémantique : retour %b \n" b; ()
		| Int n ->
				Printf.printf "OK sémantique : retour %i \n" n; ()
		| String s ->
				Printf.printf "OK sémantique : retour %s \n" s; ()
	)()
