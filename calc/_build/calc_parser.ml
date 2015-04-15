open Calc_ast

let parser int = n:''[0-9]+''                      -> int_of_string n
let parser ident = id:''[a-zA-Z][a-zA-Z0-9]*''     -> id
let parser pred = "<=" -> Leq | ">=" -> Geq | "<" -> Less
                | ">" -> Greater | "=" -> Eq | "<>" -> Neq
let parser sum = e:prod -> e | e1:prod "+" e2:sum  -> Bin(e1,Add,e2)
                             | e1:prod "-" e2:sum  -> Bin(e1,Sub,e2)
      and prod = e:atom -> e | e1:atom "*" e2:prod -> Bin(e1,Mul,e2)
                             | e1:atom "/" e2:prod -> Bin(e1,Div,e2)
                             | "-" e:prod          -> Opp(e)
and atom = n:int -> Int n | "(" e:sum ")" -> e
 | name:ident
   args:{"(" i:sum is:{ "," i':sum -> i'}* ")"     -> i::is}?[[]]
                                                   -> Call(name,args)
and top =
      e:sum -> e
    | e0:sum p:pred e0':sum "?" e1:top ":" e2:top -> If(e0,p,e0',e1,e2)
    | name:ident "=" e1:sum e2:top -> Def(name,e1,e2)
