a = 3
print a
if(6 < 7):
 print 6
print a

declare i32 @printf(i8*,...) nounwind
;str
@str = constant [4 x i8] c"%d\0a\00"

;str
@str0 = constant [4 x i8] c"%d\0a\00"

define i32 @main(i32 %argc, i8** %argv) {
   br label %label1
 label1:
   %alloc = alloca i32
   store i32 3, i32* %alloc
   %load = load i32* %alloc
   %call = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str, i32 0, i32 0), i32 %load)
   %slt = icmp slt i32 6, 7
   br i1 %slt, label %label2, label %label3
 label2:
   %alloc0 = alloca i32
   store i32 6, i32* %alloc0
   %load0 = load i32* %alloc0
   br label %label3
 label3:
   %phi = phi i32 [%load0, %label2],[%load, %label1]
   %call0 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str0, i32 0, i32 0), i32 %phi)
ret i32 0
}
