# 1 "calc_expr_sem.ml"
open Calc_ast
let rec eval : globals -> locals -> expr -> int 
= fun genv lenv -> function
  Int n -> n
| Add(n,m) -> eval genv lenv n + eval genv lenv m
| Sub(n,m) -> eval genv lenv n - eval genv lenv m
| Mul(n,m) -> eval genv lenv n * eval genv lenv m
| Div(n,m) -> eval genv lenv n / eval genv lenv m
| Opp(n)   -> - eval genv lenv n 
| Call(id, args) -> try List.assoc id lenv with Not_found ->
                    let f = List.assoc id genv in
                    let args = List.map (eval genv lenv) args in
                    let lenv = List.combine f.params args in
                    eval genv lenv f.def
