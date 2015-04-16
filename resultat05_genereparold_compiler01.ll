declare i32 @printf(i8*,...) nounwind
;compToTreize
define i32 @compToTreize(i32 %a) nounwind {
   %slt = icmp slt i32 %a, 13
   br i1 %slt, label %label1, label %label2
 label1:
   %add = add i32 %a, 13
   ret i32 %add
 label2:
   %sub = sub i32 %a, 13
   ret i32 %sub
}

;str
@str = constant [30 x i8] c"Les r\c3\a9sultats sont %d et %d\0a\00"

define i32 @main(i32 %argc, i8** %argv) {
   %call = call i32 @compToTreize(i32 15)
   %call0 = call i32 @compToTreize(i32 7)
   %call1 = call i32 (i8*,...)* @printf(i8* getelementptr([30 x i8]* @str, i32 0, i32 0), i32 %call, i32 %call0)
ret i32 0
}
