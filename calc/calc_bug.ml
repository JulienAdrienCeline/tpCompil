open Calc_ast

let parser int = n:''[0-9]+''                      -> int_of_string n
let parser ident = id:''[a-zA-Z][a-zA-Z0-9]*''     -> id
let parser pred = "<=" -> Leq | ">=" -> Geq | "<" -> Less | ">" -> Greater | "=" -> Eq | "<>" -> Neq
let parser sum = e:prod -> e | e1:prod "+" e2:sum  -> Add(e1,e2)
                             | e1:prod "-" e2:sum  -> Sub(e1,e2)
      and prod = e:atom -> e | e1:atom "*" e2:prod -> Mul(e1,e2)
                             | e1:atom "/" e2:prod -> Div(e1,e2)
                             | "-" e:prod          -> Opp(e)
and atom = n:int -> Int n | "(" e:sum ")" -> e
 | e0:sum p:pred e0':sum "?" e1:sum ":" e2:sum -> If(e0,p,e0',e1,e2)
 | name:ident
   args:{"(" i:sum is:{ "," i':sum -> i'}* ")"     -> i::is}?[[]]
                                                   -> Call(name,args)
