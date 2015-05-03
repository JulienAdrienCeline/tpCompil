declare i32 @printf(i8*,...) nounwind
;str
@str = constant [4 x i8] c"%d\0a\00"

;str
@str0 = constant [4 x i8] c"%d\0a\00"

;fac
define void @fac(i32 %i, i32 %j) nounwind {
   br label %label2
 label2:
   %alloc = alloca i32
   store i32 5, i32* %alloc
   %load = load i32* %alloc
   %alloc0 = alloca i32
   store i32 12, i32* %alloc0
   %load0 = load i32* %alloc0
   %slt = icmp slt i32 %load, 10
   br i1 %slt, label %label3, label %label4
 label3:
   %call = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str, i32 0, i32 0), i32 %load0)
   br label %label4
 label4:
   %call0 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str0, i32 0, i32 0), i32 %load)
   ret void
}

;str
@str1 = constant [4 x i8] c"%d\0a\00"

;str
@str2 = constant [4 x i8] c"%d\0a\00"

;str
@str3 = constant [4 x i8] c"%d\0a\00"

;str
@str4 = constant [4 x i8] c"%d\0a\00"

define i32 @main(i32 %argc, i8** %argv) {
   br label %label1
 label1:
   %alloc = alloca i32
   store i32 3, i32* %alloc
   %load = load i32* %alloc
   %alloc0 = alloca i32
   store i32 9, i32* %alloc0
   %load0 = load i32* %alloc0
   call void @fac(i32 %load, i32 %load0)
   %slt = icmp slt i32 %load, 10
   br i1 %slt, label %label5, label %label6
 label5:
   %call = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str1, i32 0, i32 0), i32 %load)
   %slt0 = icmp slt i32 %load0, 10
   br i1 %slt0, label %label7, label %label8
 label7:
   %call0 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str2, i32 0, i32 0), i32 %load0)
   br label %label8
 label8:
   %slt1 = icmp slt i32 %load, 5
   br i1 %slt1, label %label9, label %label10
 label9:
   %call1 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str3, i32 0, i32 0), i32 %load)
   br label %label10
 label10:
   %call2 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str4, i32 0, i32 0), i32 %load)
   br label %label6
 label6:
ret i32 0
}
