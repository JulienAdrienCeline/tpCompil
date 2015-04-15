# 1 "calc_parser.ml"
open Calc_ast
let parser int = n:''[0-9]+'' -> int_of_string n
let parser ident = id:''[a-zA-Z][a-zA-Z0-9]*'' -> id
type priority = Atom | Prod | Sum 
let parser expr (p:priority) = 
  n:int                             when p = Atom -> Int n
| "(" e:(expr Prod) ")"             when p = Atom -> e
| e1:(expr Atom) "*" e2:(expr Prod) when p = Prod -> Mul(e1,e2)
| e1:(expr Atom) "/" e2:(expr Prod) when p = Prod -> Div(e1,e2)
| "-" e:(expr Prod)                 when p = Prod -> Opp(e)
| e1:(expr Prod) "+" e2:(expr Sum)  when p = Sum -> Add(e1,e2)
| e1:(expr Prod) "-" e2:(expr Sum)  when p = Sum -> Sub(e1,e2)
| e:(expr Atom)                     when p = Prod -> e
| e:(expr Prod)                     when p = Sum -> e
| name:ident 
  args:{"(" i:(expr Sum) is:{ "," i':(expr Sum) -> i'}* ")" -> i::is}?[[]] 
                                    when p = Atom -> Call(name,args)