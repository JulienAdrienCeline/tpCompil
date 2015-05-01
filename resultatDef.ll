declare i32 @printf(i8*,...) nounwind
;str
@str = constant [4 x i8] c"%d\0a\00"

;fac
define void @fac() nounwind {
   %call = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str, i32 0, i32 0), i32 5)
   ret void
}

define i32 @main(i32 %argc, i8** %argv) {
 label1:
   call void @fac()
ret i32 0
}
