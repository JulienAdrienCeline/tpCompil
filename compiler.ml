open Ast
open Parser
open Llvm
open Ast_printer

let string_of_bool : bool -> string = 
function 
	true -> "1"
	| false -> "0"

let rec evalExpr (globEnv:genv) (monEnv:env) : expression -> value = function
	| Valeur(Int n) -> { ty = Int 32; access= string_of_int n }
	| Valeur(Boolean b) -> { ty = Int 1; access= string_of_bool b }
	| Op_bin(e1,Add,e2) -> emit_op_bin monEnv "add" (evalExpr globEnv monEnv e1) (evalExpr globEnv monEnv e2)
	| Op_bin(e1,Sub,e2) -> emit_op_bin monEnv "sub" (evalExpr globEnv monEnv e1) (evalExpr globEnv monEnv e2)
	| Op_bin(e1,Mul,e2) -> emit_op_bin monEnv "mul" (evalExpr globEnv monEnv e1) (evalExpr globEnv monEnv e2)
	| Op_bin(e1,Div,e2) -> emit_op_bin monEnv "sdiv" (evalExpr globEnv monEnv e1) (evalExpr globEnv monEnv e2)
	| Op_bin(e1,GreaterThan,e2) -> emit_icmp monEnv "sgt" (evalExpr globEnv monEnv e1) (evalExpr globEnv monEnv e2)
	| Op_bin(e1,LessThan,e2) -> emit_icmp monEnv "slt" (evalExpr globEnv monEnv e1) (evalExpr globEnv monEnv e2)
	| Op_bin(e1,Equal,e2) -> emit_icmp monEnv "eq" (evalExpr globEnv monEnv e1) (evalExpr globEnv monEnv e2)
	| Opp(e) -> emit_op_bin monEnv "sub" (evalExpr globEnv monEnv (Valeur(Int 0))) (evalExpr globEnv monEnv e)
	| Id(Id_name id) -> 
			try 
			search_local monEnv id 
			with Not_found -> try 
				let g = search_global (get_global monEnv) id in
				emit_load monEnv g
      with Not_found ->
				failwith ("Unbound variable: "^id)
	| _ -> failwith("Not Implemented Yet")


let rec evalProg (globEnv:genv) (monEnv:env) : programme -> unit = function
	| [] -> ()
	| (Affectation(Id_name id, expr))::suite ->
			let v = evalExpr globEnv monEnv expr in
			let al = emit_alloca monEnv v.ty in
			let _ = emit_store monEnv v al in
			let lo = emit_load monEnv al in
			let _ = emit_in_scope monEnv [(id, lo)] (fun () -> ()) in
			evalProg globEnv monEnv suite
	| (Print expr)::suite ->
			let v = evalExpr globEnv monEnv expr in
			let printf = search_global globEnv "@printf" in
			let strConst = declare_string_constant globEnv "str" "%d\n" in
			let _ = emit_call monEnv printf [strConst; v] in
			evalProg globEnv monEnv suite
	| _ -> failwith "Not Implemented Yet"

let _ = Decap.handle_exception (fun () ->
  let p = Decap.parse_channel (programme 0) blank stdin in 
	let genv = start_emit_file () in
	let _ = declare_extern genv "@printf" (Int 32) ~var_args:true [Ptr (Int 8)] in
	let mainEnv = start_init_code genv in
	let _ = evalProg genv mainEnv p in 
	let _ = end_init_code mainEnv in 
	end_emit_file genv stdout
	)()
