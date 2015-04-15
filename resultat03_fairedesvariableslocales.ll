;compToTreize
define fastcc i32 @compToTreize(i32 %a) {
	%ptr = alloca [4 x i8], align 1      									;; Allouer la mémoire nécessaire dans la pile                         
	store [4 x i8] c"%d\0A\00", [4 x i8]* %ptr						;; Enregistrer ce qu'on veut dans la mémoire allouée
	%eptr = getelementptr [4 x i8]* %ptr, i32 0, i32 0		;; Transformer le pointeur en i8*
	
	%ptrv = alloca i32, align 1														;; Allouer la mémoire nécessaire dans la pile
	store i32 58, i32* %ptrv															;; Enregistrer la valeur dans la mémoire allouée
	%v = load i32* %ptrv																	;; Accéder à la valeur enregistrée

	call i32 (i8*, ...)* @printf(i8* %eptr, i32 %v) 
	ret i32 %a
}

declare i32 @printf(i8*,...) nounwind

define i32 @main(i32 %argc, i8** %argv) {
	%res = call i32 @compToTreize(i32 15)									;; Et pourquoi ici pas besoin de alloca -> store -> load ??
	ret i32 0
}
