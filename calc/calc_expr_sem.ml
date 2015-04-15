open Calc_ast
type globals = (ident * def) list
type locals  = (ident * int) list
let pred = function Geq -> (>=) | Leq -> (<=) | Greater -> (>)
                  | Less -> (<) | Eq -> (=) | Neq -> (<>)
let bin = function Add -> (+) | Sub -> (-) | Mul -> ( * ) | Div -> (/)
let rec eval (genv:globals) (lenv:locals) : expr -> int = function
  Int n -> n
| Bin(n,p,m) -> bin p (eval genv lenv n) (eval genv lenv m)
| Opp(n)     -> - eval genv lenv n
| If(e0,p,e0',e1,e2) ->
  let e0 = eval genv lenv e0 in
  let e0' = eval genv lenv e0' in
  eval genv lenv (if pred p e0 e0' then e1 else e2)
| Def(name,e1,e2) ->
  let e1 = eval genv lenv e1 in
  eval genv ((name,e1)::lenv) e2
| Call(id, args) -> (try List.assoc id lenv with Not_found ->
                    let f = List.assoc id genv in
                    let args = List.map (eval genv lenv) args in
                    let lenv = List.combine f.params args in
                    eval genv lenv f.def)
