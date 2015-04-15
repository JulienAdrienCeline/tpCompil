# 1 "calc_main.ml"
open Calc_ast
open Calc_parser

let parser instr = 
  name:ident 
  params:{"(" i:ident is:{ "," i':ident -> i'}* ")" -> i::is}?[[]] 
  "=" def:(expr Sum) 
  -> { name; params; def }

let parser program = instr*

let blank = Decap.blank_regexp "[ \t\n\r]*"
let _ = Decap.handle_exception (fun () ->
		     let p = Decap.parse_channel program blank stdin in
		     Calc_semantics.run [] p) ()
