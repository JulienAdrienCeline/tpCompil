;compToTreize
define fastcc i32 @compToTreize(i32 %a) {
	%ptr = alloca [4 x i8], align 1                               
	store [4 x i8] c"%d\0A\00", [4 x i8]* %ptr
	%val = load [4 x i8]* %ptr
	%eptr = getelementptr [4 x i8]* %ptr, i32 0, i32 0
	call i32 (i8*, ...)* @printf(i8* %eptr, i32 %a) ;affiche n'importe quoi (eg: 1660053685) 
	ret i32 %a
}

declare i32 @printf(i8*,...) nounwind

define i32 @main(i32 %argc, i8** %argv) {
	%res = call i32 @compToTreize(i32 8)
	ret i32 0
}
