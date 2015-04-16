;fonction bidon qui retourne la valeur du paramètre qu'on lui a passé
define i32 @definir(i32 %a) {

	ret i32 %a
}

declare i32 @printf(i8*,...)

define i32 @main(i32 %argc, i8** %argv) {

	%ptrv = alloca i32, align 1														;; Allouer la mémoire nécessaire dans la pile
	store i32 15, i32* %ptrv															;; Enregistrer la valeur dans la mémoire allouée
	%v = load i32* %ptrv																	;; Accéder à la valeur enregistrée

	%resV = call i32 @definir(i32 %v)
	%res = call i32 @definir(i32 15)

	%ptr = alloca [4 x i8], align 1                               
	store [4 x i8] c"%d\0A\00", [4 x i8]* %ptr
	%val = load [4 x i8]* %ptr
	%eptr = getelementptr [4 x i8]* %ptr, i64 0, i64 0

	call i32 (i8*, ...)* @printf(i8* %eptr, i32 15) 							
	call i32 (i8*, ...)* @printf(i8* %eptr, i32 %v)								
	call i32 (i8*, ...)* @printf(i8* %eptr, i32 %res)	nounwind		;; attribut nounwind résoud nos problèmes
	call i32 (i8*, ...)* @printf(i8* %eptr, i32 %resV) nounwind		;; attribut nounwind résoud nos problèmes

	ret i32 0
}

attributes #2 = { nounwind }
