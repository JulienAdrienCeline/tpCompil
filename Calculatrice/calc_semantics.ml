# 1 "calc_semantics.ml"
open Calc_ast
open Calc_expr_sem
let rec run : globals -> program -> unit
 = fun genv -> function
   [] -> ()
 | instr::instrs ->
   if instr.params = [] then (
     let n = eval genv [] instr.def in
     Printf.printf "%s=%d\n" instr.name n
   );
   let genv = (instr.name, instr)::genv in
   run genv instrs
