# 1 "calc_ast.ml"
type ident = string
type expr = Int of int
          | Add of expr * expr
          | Sub of expr * expr
          | Mul of expr * expr
          | Div of expr * expr
          | Opp of expr
          | Call of ident * expr list 
type instr = { name : ident;
               params : ident list;
               def : expr }
type program = instr list 
(* pour l'évaluation *)
type globals = (ident * instr) list
type locals  = (ident * int) list
