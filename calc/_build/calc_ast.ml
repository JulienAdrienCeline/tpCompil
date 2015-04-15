(* Ast de la calculatrice *)
type ident = string
(* Les prédicats de comparaison *)
type pred = Geq | Greater | Leq | Less | Eq | Neq
(* Les opérations binaires *)
type opBin = Add | Sub | Mul | Div
type expr =
| Int of int                   (* constante *)
| Bin of expr * opBin * expr   (* opération *)
| Opp of expr                  (* opposée   *)
| Call of ident * expr list    (* appel à une def *)
| If of expr * pred * expr * expr * expr (* test *)
| Def of ident * expr * expr   (* local definition *)
type def = { name : ident;     (* nom du symbole *)
             params : ident list;  (* paramètres *)
             def : expr } (* corps de la définition *)
type program = def list
