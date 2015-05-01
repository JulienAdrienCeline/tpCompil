open Ast
open Llvm

type llvminstruction = 
	LabelLlvm of label
	| Phi of string

type allinstruction =
	AstInstruction of instruction
	| LlvmInstruction of llvminstruction

type labprogramme = allinstruction list

let transform : programme -> labprogramme = function
	| anyInstr::suite -> AstInstruction(anyInstr)::
