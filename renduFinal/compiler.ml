open Ast
open Parser
open Llvm
open Ast_printer
open Phis_and_labels

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
	| Id(Id_name id) -> (
			try 
			search_local monEnv id 
			with Not_found -> try 
				let g = search_global (get_global monEnv) id in
				emit_load monEnv g
      with Not_found ->
				failwith ("Unbound variable: "^id) )
	 | Call(Fn_name fonction_name, arguments) -> ( 
			try 
			search_local monEnv fonction_name 
			with Not_found -> try 
				let g = search_global (get_global monEnv) fonction_name in
				let args = List.map (function x -> evalExpr globEnv monEnv x) arguments in
				emit_call monEnv g args
      with Not_found ->
				failwith ("Unbound function: "^fonction_name) )

	| _ -> failwith("Expression Not Implemented Yet")

let rec evalProg (myTree:tree) (globEnv:genv) (monEnv:env) : programme -> unit = function
	| [] -> ()
	| (Expr Call(Fn_name fonction_name, arguments))::suite ->  
			(try 
				let g = search_global globEnv fonction_name in
				let args = List.map (function x -> evalExpr globEnv monEnv x) arguments in
				let _ = emit_call_void monEnv g args in
				evalProg myTree globEnv monEnv suite
     			 with Not_found ->
				failwith ("Unbound function: "^fonction_name) )
	| (Affectation(Id_name id, expr))::suite ->
			let v = evalExpr globEnv monEnv expr in
			let al = emit_alloca monEnv v.ty in
			let _ = emit_store monEnv v al in
			let lo = emit_load monEnv al in
			let _ = emit_in_scope monEnv [(id, lo)] (fun () -> ()) in
			evalProg myTree globEnv monEnv suite
	| (Phi(Id_name id, src1, src2))::suite -> 
			let ls = my_find_phis monEnv id myTree src1 src2 in
			if ((List.length ls) > 1) then (
				let ph = my_emit_phi monEnv id ls in
				let _ = emit_in_scope monEnv [(id, ph)] (fun () -> ()) in ()
			);
			evalProg myTree globEnv monEnv suite
	| (Label lb)::suite -> evalProg myTree globEnv monEnv suite
	| (Print expr)::suite ->
			let v = evalExpr globEnv monEnv expr in
			let printf = search_global globEnv "@printf" in
			let strConst = declare_string_constant globEnv "str" "%d\n" in
			let _ = emit_call monEnv printf [strConst; v] in
			evalProg myTree globEnv monEnv suite
	| (Instr_complexe If(expr,Label(lbtrue)::sousprog))::(Label lbfin)::suite ->
			let macomparaison = evalExpr globEnv monEnv expr in
			let _ = emit_cond_br monEnv macomparaison lbtrue lbfin in 
			let _ = emit_block monEnv lbtrue in
			let _ = evalProg myTree globEnv monEnv sousprog in
			let _ = emit_br monEnv lbfin in
			let _ = emit_block monEnv lbfin in 
			evalProg myTree globEnv monEnv suite
	| (Instr_complexe Def(Fn_name fonction_name, params, Label(lbinit)::programme))::suite ->
			let p = List.map (function (Id_name x) -> ( x , Int 32)) params in
			let _ = register_function globEnv fonction_name Void p in		
			let deb = start_function globEnv fonction_name in
			let deb = register_params_in_scope deb lbinit in
			let _ = emit_br deb lbinit in
			let _ = emit_block deb lbinit in
			let _ = evalProg myTree globEnv deb programme in
			let _ = emit_ret_void deb in
			let _ = end_function deb in
			evalProg myTree globEnv monEnv suite
	| _ -> failwith "Instruction Not Implemented Yet"

