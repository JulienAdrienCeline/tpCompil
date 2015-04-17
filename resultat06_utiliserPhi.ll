declare i32 @printf(i8*,...) nounwind

;str
@str0 = constant [4 x i8] c"%d\0a\00"

define i32 @main(i32 %argc, i8** %argv) {
 label1:
   %var1 = add i32 5,5
   %slt = icmp slt i32 6, 5
   br i1 %slt, label %label2, label %label3
 label2:
   %var2 = add i32 10,10
   br label %label3
 label3:
	 %join = phi i32 [%var1 , %label1], [%var2, %label2] 
   %call0 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str0, i32 0, i32 0), i32 %join)
	 ret i32 0
}
