a = 2

declare i32 @printf(i8*,...) nounwind
define i32 @main(i32 %argc, i8** %argv) {
   %alloc = alloca i32
   store i32 2, i32* %alloc
   %load = load i32* %alloc
ret i32 0
}
