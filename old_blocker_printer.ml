open Ast
open Llvm

type llvminstruction = 
	LabelLlvm of label
	| Phi of string

type allinstruction =
	AstInstruction of instruction
	| LlvmInstruction of llvminstruction

type labprogramme = allinstruction list

let printId : ident -> string = function
	| Id_name(s) -> String.concat "" ["Id_name( ";s;" )"]

let printFName : fonction_name -> string = function
	| Fn_name(s) -> String.concat "" ["Fn_name( ";s;" )"]

let printVal : valeur -> string = function
	  Int n -> String.concat "" ["Int( ";string_of_int n;" )"]
	| Boolean b -> String.concat "" ["Boolean( ";string_of_bool b;" )"]
	| String s -> String.concat "" ["String( ";s;" )"]

let printOpBin : Ast.op_bin -> string = function
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

let rec printInstr : allinstruction -> string = function
	|AstInstruction(Affectation(id,exp)) -> String.concat "" ["Affectation( "; printId id ; "," ; printExpr exp ; " )"]
  |AstInstruction(Instr_complexe(ic)) -> String.concat "" ["IC( " ; printIC ic ; " )"]
  |AstInstruction(Return(exp)) -> String.concat "" ["Return( " ; printExpr exp ; " )"]
  |AstInstruction(Print(exp)) -> String.concat "" ["Print( " ; printExpr exp ; " )"]
  |AstInstruction(Expr(exp)) -> String.concat "" ["Expr( "; printExpr exp ; " )"]
	|LlvmInstruction(LabelLlvm(l)) -> String.concat "" ["Label( "; l ; " )"]
	|LlvmInstruction(Phi(l)) -> String.concat "" ["Phi( "; l ; " )"]

and printParams : params -> string =
fun idList ->
	String.concat "," (List.map printId idList)

and printIC : instr_complexe -> string = function
  |Def(f_name,p,prog) -> String.concat "" ["Def( "; printFName f_name ; ", [" ; printParams p ; "],\n" ; printProg prog ; "\n)\n"] 
  |If(exp,prog) -> String.concat "" ["If( "; printExpr exp ; ",\n" ; printProg prog ; "\n)\n"]

and printProg : labprogramme -> string = 
	fun prog -> String.concat "" ["\n Programme(\n" ; String.concat "\n" (List.map printInstr prog) ; "\n)\n"]

let printAll : labprogramme -> unit = fun prog ->
	Printf.printf "%s" (printProg prog)
