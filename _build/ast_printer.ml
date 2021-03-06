open Ast

let printId : ident -> string = function
	| Id_name(s) -> String.concat "" ["Id_name( ";s;" )"]

let printFName : fonction_name -> string = function
	| Fn_name(s) -> String.concat "" ["Fn_name( ";s;" )"]

let printVal : valeur -> string = function
	  Int n -> String.concat "" ["Int( ";string_of_int n;" )"]
	| Boolean b -> String.concat "" ["Boolean( ";string_of_bool b;" )"]
	| String s -> String.concat "" ["String( ";s;" )"]

let printOpBin : op_bin -> string = function
	| Add -> "Add"
	| Sub -> "Sub"
	| Mul -> "Mul"
	| Div -> "Div"
	| GreaterThan -> "GreaterThan"
	| LessThan -> "LessThan"
	| Equal-> "Equal"

let rec printArgs : arguments -> string = 
fun argList ->
	String.concat "," (List.map printExpr argList)

and printExpr : expression -> string = function
	|Id(id) -> String.concat "" ["Id( " ; printId id ; " )"]
  |Valeur(v) -> String.concat "" ["Valeur( " ; printVal v ; " )"]
  |Op_bin(e1,op,e2) -> String.concat "" ["Op_bin( " ; printExpr e1 ; "," ; printOpBin op ; "," ; printExpr e2 ; " )"]
  |Opp(expr) -> String.concat "" ["Opp( " ; printExpr expr ; " )"]
  |Call(f_name,args) -> String.concat "" ["Call( "; printFName f_name ; ", [" ; printArgs args ; "] )"]

let rec printInstr : instruction -> string = function
	|Affectation(id,exp) -> String.concat "" ["Affectation( "; printId id ; "," ; printExpr exp ; " )"]
  |Instr_complexe(ic) -> String.concat "" ["IC( " ; printIC ic ; " )"]
  |Return(exp) -> String.concat "" ["Return( " ; printExpr exp ; " )"]
  |Print(exp) -> String.concat "" ["Print( " ; printExpr exp ; " )"]
  |Expr(exp) -> String.concat "" ["Expr( "; printExpr exp ; " )"]
	|Label(l) -> String.concat "" ["Label( "; l ; " )"]
	|Phi(id, lb1, lb2) -> String.concat "" ["Phi( " ; printId id ; " -- " ; lb1 ; " -- " ; lb2 ; " )"]

and printParams : params -> string =
fun idList ->
	String.concat "," (List.map printId idList)

and printIC : instr_complexe -> string = function
  |Def(f_name,p,prog) -> String.concat "" ["Def( "; printFName f_name ; ", [" ; printParams p ; "],\n" ; printProg prog ; "\n)\n"] 
  |If(exp,prog) -> String.concat "" ["If( "; printExpr exp ; ",\n" ; printProg prog ; "\n)\n"]

and printProg : programme -> string = 
	fun prog -> String.concat "" ["\n Programme(\n" ; String.concat "\n" (List.map printInstr prog) ; "\n)\n"]

let printAll : programme -> unit = fun prog ->
	Printf.printf "%s" (printProg prog)

