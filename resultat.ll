;compToTreize
define fastcc i32 @compToTreize(i32 %a) {
   %slt = icmp slt i32 %a, 13
   br i1 %slt, label %label1, label %label2
 label1:
   %add = add i32 %a, 13
   br label %label3
 label2:
   %sub = sub i32 %a, 13
   br label %label3
 label3:
   ret i32 12
}

declare i32 @printf(i8*,...) nounwind
define i32 @main(i32 %argc, i8** %argv) {
ret i32 0
}
