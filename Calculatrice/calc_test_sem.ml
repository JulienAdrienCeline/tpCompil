# 1 "calc_test_sem.ml"
open Calc_ast

let x = Call("x",[]) and y = Call("y",[]) and z = Call("z",[])
let test = [
  { name = "a"; params = []; def = Add(Int 2, Int 3) };
  { name = "f"; params = ["x";"y"]; def = Add(Mul(x,x),Mul(y,y)) };
  { name = "g"; params = ["x";"y";"z"]; 
    def = Call("f", [Call("f",[x;y]) ; Call("f",[y;z]) ]) };
  { name = "b"; params = []; 
    def = Call("f",[Call("a",[]);Call("a",[])]) };
  { name = "c"; params = []; 
    def = Call("g",[Call("a",[]);Call("b",[]);Call("a",[])]) };
]
let _ = Calc_semantics.run [] test