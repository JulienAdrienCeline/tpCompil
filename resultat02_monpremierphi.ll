;compToTreize
define fastcc i32 @compToTreize(i32 %a) {
	%ptr = alloca [4 x i8], align 1                               
	store [4 x i8] c"%d\0A\00", [4 x i8]* %ptr
	%val = load [4 x i8]* %ptr
	%eptr = getelementptr [4 x i8]* %ptr, i32 0, i32 0
	%test17 = icmp sgt i32 %a, 13
	br i1 %test17, label %true44, label %false12
	true44:
		call i32 (i8*, ...)* @printf(i8* %eptr, i32 111) 
		br label %final17
 	false12:
		call i32 (i8*, ...)* @printf(i8* %eptr, i32 666)
		br label %final17
	final17:
		ret i32 %a
}

declare i32 @printf(i8*,...) nounwind

define i32 @main(i32 %argc, i8** %argv) {
	%res = call i32 @compToTreize(i32 15)
	ret i32 0
}
