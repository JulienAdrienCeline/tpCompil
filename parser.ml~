open Ast

let locate str pos str' pos' =
	Lexing.(
    let s = Input.lexing_position str pos in
    let e = Input.lexing_position str' pos' in
    (s, e))

#define LOCATE locate

let column (debut,fin) =
  Lexing.(debut.pos_cnum-debut.pos_bol)
 
let test_pos' contrainte pos = 
  match pos with
	j when j=contrainte -> true
      | _ -> false

let test_pos contrainte pos = test_pos' contrainte (column pos)

let parser int = n:''[0-9]+''                      -> int_of_string n
let parser bool = n:''(true)|(false)''             -> bool_of_string n
let parser string= '"' - n:''[^"]*'' - '"'	   -> n

let parser valeur= value:int->Int value|
		   value:bool->Boolean value|
		   value:string->String value 

let parser ident = id:''[a-zA-Z][a-zA-Z0-9]*''     -> Id_name(id)
let parser function_name = id:''[a-zA-Z][a-zA-Z0-9]*''     -> Fn_name(id)

let parser expression = a:add -> a

and add = m:mul->m | e1:add "+" e2:mul  -> Op_bin(e1,Add,e2)
                   | e1:add "-" e2:mul  -> Op_bin(e1,Sub,e2)
	    
and mul = e:pred -> e | e1:mul "*" e2:pred -> Op_bin(e1,Mul,e2)
                      | e1:mul "/" e2:pred -> Op_bin(e1,Div,e2)
                      | "-" e:mul          -> Opp(e)
and pred = a:priomax -> a
	   |e1:priomax "<" e2:priomax -> Op_bin(e1,LessThan,e2) 
	   | e1:priomax ">" e2:priomax -> Op_bin(e1,GreaterThan,e2) |
	   | e1:priomax "==" e2:priomax -> Op_bin(e1,Equal,e2)

and priomax = n:valeur -> Valeur n 
 | "(" e:expression ")" -> e
 | i:ident -> Id(i)
 | id:function_name "()" 
	-> Call(id,[])
 |id:function_name "(" arg:expression args:{"," v:expression -> v}* ")" 
	-> Call(id,arg::args)

let parser keydef = "def " -> ()
and keyif = "if(" -> () 
and keyreturn = "return " -> ()
and keyprint =  "print " -> ()

and instr_def i = 
 id:function_name "():" ->> p:(programme (i+1)) 	
	-> Def(id,[],p)
 |id:function_name "(" arg:ident args:{"," v:ident -> v}* "):" ->> p:(programme (i+1)) 	
	-> Def(id,arg::args,p)

and instr_if i =
 e:expression "):" ->>  p:(programme (i+1)) 
	-> If(e,p)
		  
and instruction i = 
|k:keyif iif:(instr_if i) 
	-> if test_pos i _loc_k then Instr_complexe(iif) else raise (Decap.Give_up "Illegal indent") 
|k:keydef idef:(instr_def i) 
	-> if test_pos i _loc_k then Instr_complexe(idef) else raise (Decap.Give_up "Illegal indent") 
|id:ident "=" e:expression
	-> if test_pos i _loc_id then Affectation(id,e) else raise (Decap.Give_up "Illegal indent") 
|k:keyreturn e:expression
	-> if test_pos i _loc_k then Return(e) else raise (Decap.Give_up "Illegal indent") 
|k:keyprint e:expression
	-> if test_pos i _loc_k then Print(e) else raise (Decap.Give_up "Illegal indent") 
|expr:expression -> if test_pos i _loc_expr then Expr(expr) else raise (Decap.Give_up "Illegal indent")  
		   
and programme i = 
 | EMPTY -> []
 | instr:(instruction i)  liste_instructions:(programme i)
	-> instr::liste_instructions 

let blank = Decap.blank_regexp ''\([ \t\n\r]*\|#[^\n]*\n\)*''

