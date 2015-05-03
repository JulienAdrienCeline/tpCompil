t = 5 > 2
f = 3 > 4
print t
print f

declare i32 @printf(i8*,...) nounwind
;str
@str = constant [4 x i8] c"%d\0a\00"

;str
@str0 = constant [4 x i8] c"%d\0a\00"

define i32 @main(i32 %argc, i8** %argv) {
   %sgt = icmp sgt i32 5, 2
   %alloc = alloca i1
   store i1 %sgt, i1* %alloc
   %load = load i1* %alloc
   %sgt0 = icmp sgt i32 3, 4
   %alloc0 = alloca i1
   store i1 %sgt0, i1* %alloc0
   %load0 = load i1* %alloc0
   %call = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str, i32 0, i32 0), i1 %load)
   %call0 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str0, i32 0, i32 0), i1 %load0)
ret i32 0
}
