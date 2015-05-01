type ident = Id_name of string
type fonction_name = Fn_name of string
type params = ident list
type valeur =
  |Int of int
  |String of string
  |Boolean of bool

type op_bin = Add | Sub | Mul | Div | GreaterThan | LessThan | Equal

type expression = 
  |Id of ident 
  |Valeur of valeur
  |Op_bin of expression * op_bin * expression
  |Opp of expression
  |Call of fonction_name * arguments
and arguments = expression list


type instruction =
  |Affectation of ident * expression 
  |Instr_complexe of instr_complexe
  |Return of expression
  |Print of expression
  |Expr of expression
	|Label of string
	|Phi of (ident * string * string) (* nom_variable nom_labelsource1 nom_labelsource2 *)

and instr_complexe =
  |Def of fonction_name * params * programme
  |If of expression * programme

and programme = instruction list

