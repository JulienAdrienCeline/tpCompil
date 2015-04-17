a = 2 + 3
print a
print 10 + 8

declare i32 @printf(i8*,...) nounwind
;str
@str = constant [4 x i8] c"%d\0a\00"

;str
@str0 = constant [4 x i8] c"%d\0a\00"

define i32 @main(i32 %argc, i8** %argv) {
   %add = add i32 2, 3
   %alloc = alloca i32
   store i32 %add, i32* %alloc
   %load = load i32* %alloc
   %call = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str, i32 0, i32 0), i32 %load)
   %add0 = add i32 10, 8
   %call0 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str0, i32 0, i32 0), i32 %add0)
ret i32 0
}
