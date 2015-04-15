open Calc_ast
open Calc_expr_sem
let run : program -> unit = fun p ->
  let _ =
    List.fold_left (fun genv instr ->
      if instr.params = [] then (
	(* evaluation si ce n'est pas une fonction *)
	let n = eval genv [] instr.def in
	Printf.printf "%s = %d\n%!" instr.name n;
	(* on efface une eventuelle ancienne valeur de l'environnement *)
	(instr.name, { instr with def = Int n })
	::List.filter (fun (n, _) -> n <> instr.name) genv)
      else
	(instr.name, instr)::genv) [] p
  in
  (* on jette l'environnement final *)
  ()
