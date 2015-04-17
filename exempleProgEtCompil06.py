print (6 < 7)
print (8 < 4)
print (3 == 4)
print (3 == 3)
print -16
print (-12) + (-8)

declare i32 @printf(i8*,...) nounwind
;str
@str = constant [4 x i8] c"%d\0a\00"

;str
@str0 = constant [4 x i8] c"%d\0a\00"

;str
@str1 = constant [4 x i8] c"%d\0a\00"

;str
@str2 = constant [4 x i8] c"%d\0a\00"

;str
@str3 = constant [4 x i8] c"%d\0a\00"

;str
@str4 = constant [4 x i8] c"%d\0a\00"

define i32 @main(i32 %argc, i8** %argv) {
   %slt = icmp slt i32 6, 7
   %call = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str, i32 0, i32 0), i1 %slt)
   %slt0 = icmp slt i32 8, 4
   %call0 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str0, i32 0, i32 0), i1 %slt0)
   %eq = icmp eq i32 3, 4
   %call1 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str1, i32 0, i32 0), i1 %eq)
   %eq0 = icmp eq i32 3, 3
   %call2 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str2, i32 0, i32 0), i1 %eq0)
   %sub = sub i32 0, 16
   %call3 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str3, i32 0, i32 0), i32 %sub)
   %sub0 = sub i32 0, 8
   %sub1 = sub i32 0, 12
   %add = add i32 %sub1, %sub0
   %call4 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str4, i32 0, i32 0), i32 %add)
ret i32 0
}
