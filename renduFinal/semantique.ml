open Ast
open Parser
open Ast_printer

let int_of_bool : bool -> int = 
function 
	true -> 1 
	| false -> 0

let bool_of_val : valeur -> bool = 
function
	  String s -> true
	| Boolean b -> b
	| Int n -> (n != 0)

type variables = (ident * valeur) list

let concatOrReplace (v1:variables) (v2:variables) =
	List.fold_left (fun listVar (id,v) -> 
		let var' = List.remove_assoc id listVar in
		(id, v)::var'
	) v1 v2;

type functions = (fonction_name * (params * programme)) list

let additionner : (valeur*valeur) -> valeur = 
function 
	(Int n, Int m) -> Int(n+m)
	| (String n, String m) -> String(String.concat "" [n; m])
	| (Boolean n, Boolean m) -> Int((int_of_bool n)+(int_of_bool m))
	| (String n, Int m) -> String(String.concat "" [n; (string_of_int m)])
	| (Int n, String m) -> String(String.concat "" [(string_of_int n); m])
	| (String n, Boolean m) -> String(String.concat "" [n; (string_of_bool m)])
	| (Boolean n, String m) -> String(String.concat "" [(string_of_bool n); m])
	| (Int n, Boolean m) -> Int(n+(int_of_bool m))
	| (Boolean n, Int m) -> Int((int_of_bool n)+m)

let soustraire : (valeur*valeur)->valeur = 
function 
	(Int n, Int m) -> Int(n-m)
	| (Boolean n, Boolean m) -> Int((int_of_bool n)-(int_of_bool m))
	| (Int n, Boolean m) -> Int(n-(int_of_bool m))
	| (Boolean n, Int m) -> Int((int_of_bool n)-m)
	| _ -> failwith "Illegal substraction"

let multiplier : (valeur*valeur)->valeur = 
function 
	(Int n, Int m) -> Int(n*m)
	| (Boolean n, Boolean m) -> Int((int_of_bool n)*(int_of_bool m))
	| (Int n, Boolean m) -> Int(n*(int_of_bool m))
	| (Boolean n, Int m) -> Int((int_of_bool n)*m)
	| _ -> failwith "Illegal multiplication"

let diviser : (valeur*valeur)->valeur = 
function 
	(Int n, Int m) -> Int(n/m)
	| (Boolean n, Boolean m) -> Int((int_of_bool n)/(int_of_bool m))
	| (Int n, Boolean m) -> Int(n/(int_of_bool m))
	| (Boolean n, Int m) -> Int((int_of_bool n)/m)
	| _ -> failwith "Illegal division"

let greaterThan : (valeur*valeur)->valeur = 
function 
	(Int n, Int m) -> Boolean(n>m)
	| (String n, String m) -> Boolean((int_of_string n)>(int_of_string m))
	| (Boolean n, Boolean m) -> Boolean((int_of_bool n)>(int_of_bool m))
	| (String n, Int m) ->Boolean((int_of_string n) > m)
	| (Int n, String m) -> Boolean(n > (int_of_string m))
	| (String n, Boolean m) -> Boolean((int_of_string n) > (int_of_bool m))
	| (Boolean n, String m) -> Boolean((int_of_bool n) > (int_of_string m))
	| (Int n, Boolean m) -> Boolean(n>(int_of_bool m))
	| (Boolean n, Int m) -> Boolean((int_of_bool n)>m)

let lessThan (e1,e2) = greaterThan (e2,e1)

let equal : (valeur*valeur) -> valeur = 
function 
	(Int n, Int m) -> Boolean(n = m)
	| (String n, String m) -> Boolean(n = m)
	| (Boolean n, Boolean m) -> Boolean(n = m)
	| (String n, Int m) -> Boolean((int_of_string n) = m)
	| (Int n, String m) -> Boolean(n = (int_of_string m))
	| (String n, Boolean m) -> Boolean((int_of_string n) = (int_of_bool m))
	| (Boolean n, String m) -> Boolean((int_of_bool n) = (int_of_string m))
	| (Int n, Boolean m) -> Boolean(n = (int_of_bool m))
	| (Boolean n, Int m) -> Boolean((int_of_bool n) = m)

let oppose : valeur->valeur = 
function 
	Int n -> Int(-n)
	|Boolean n -> Boolean(not n)
	|_ -> failwith "Not a Number"

let rec evalExpr (var:variables) (func:functions) : expression -> valeur = 
function
	  Valeur v -> v
	| Id id -> List.assoc id var 
	| Op_bin(e1,Add,e2) -> additionner((evalExpr var func e1),(evalExpr var func e2))
	| Op_bin(e1,Sub,e2) -> soustraire((evalExpr var func e1),(evalExpr var func e2))
	| Op_bin(e1,Mul,e2) -> multiplier((evalExpr var func e1),(evalExpr var func e2))
	| Op_bin(e1,Div,e2) -> diviser((evalExpr var func e1),(evalExpr var func e2))
	| Op_bin(e1,GreaterThan,e2) -> greaterThan((evalExpr var func e1),(evalExpr var func e2))
	| Op_bin(e1,LessThan,e2) -> lessThan((evalExpr var func e1),(evalExpr var func e2))
	| Op_bin(e1,Equal,e2) -> equal((evalExpr var func e1),(evalExpr var func e2))
	| Opp(e) -> oppose(evalExpr var func e)
	| Call(f_name, args) -> 
			let f = List.assoc f_name func in
			match f with
				(params,prog) ->
					let args = List.map (evalExpr var func) args in
					let var' = concatOrReplace var (List.combine params args) in 
					evalProg (var',func) prog

and evalInstr (var:variables) (func:functions) : instruction -> (variables * functions) = 
function 
	  Affectation(id,expr) -> 
				let var' = List.remove_assoc id var in
				((id, evalExpr var func expr)::var' , func)
	| Print expr -> 
				let v = evalExpr var func expr in
				(match v with
					  Boolean b ->
							Printf.printf "%b\n" b; (var, func)
					| Int n ->
							Printf.printf "%i\n" n; (var, func)
					| String s ->
							Printf.printf "%s\n" s; (var, func))
	| Expr expr -> let _ = (evalExpr var func expr) in (var, func)
	| Instr_complexe Def(f_name,params,sousprog) -> 
				let func' = List.remove_assoc f_name func in
				(var, (f_name,(params,sousprog))::func')
	| _ -> failwith "Illegal instruction (unexpected return keyword)"

and evalProg ((var:variables),(func:functions)) : programme -> valeur = 
function
	  (Return expr)::suite -> evalExpr var func expr
	| (Instr_complexe If(expr,sousprog))::suite -> 
			let v = bool_of_val (evalExpr var func expr) in
			(match v with
				  true -> evalProg (var,func) (List.concat [sousprog ; suite]) (* Les variables déclarées dans un if ne seront pas locales au if *)
				| false -> evalProg (var,func) suite) 
	| instr::suite -> evalProg (evalInstr var func instr) suite
	| _ -> Int 0

