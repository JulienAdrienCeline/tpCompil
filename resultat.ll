declare i32 @printf(i8*,...) nounwind
;str
@str = constant [4 x i8] c"%d\0a\00"

;str
@str0 = constant [4 x i8] c"%d\0a\00"

;str
@str1 = constant [4 x i8] c"%d\0a\00"

define i32 @main(i32 %argc, i8** %argv) {
   br label %label1
 label1:
   %alloc = alloca i32
   store i32 3, i32* %alloc
   %load = load i32* %alloc
   %alloc0 = alloca i32
   store i32 9, i32* %alloc0
   %load0 = load i32* %alloc0
   %call = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str, i32 0, i32 0), i32 %load)
   %slt = icmp slt i32 6, %load0
   br i1 %slt, label %label2, label %label3
 label2:
   %alloc1 = alloca i32
   store i32 6, i32* %alloc1
   %load1 = load i32* %alloc1
   %slt0 = icmp slt i32 %load0, 12
   br i1 %slt0, label %label4, label %label5
 label4:
   %alloc2 = alloca i32
   store i32 12, i32* %alloc2
   %load2 = load i32* %alloc2
   br label %label5
 label5:
   %phi = phi i32 [%load1, %label2],[%load, %label1]
   br label %label3
 label3:
   %phi0 = phi i32 [%load1, %label2],[%load, %label1]
   %call0 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str0, i32 0, i32 0), i32 %phi0)
   %call1 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str1, i32 0, i32 0), i32 %load2)
ret i32 0
}
