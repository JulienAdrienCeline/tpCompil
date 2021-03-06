;fonction bidon qui retourne la valeur du paramètre qu'on lui a passé
define fastcc i32 @definir(i32 %a) {

	ret i32 %a
}

declare i32 @printf(i8*,...) nounwind

define i32 @main(i32 %argc, i8** %argv) {

	%ptrv = alloca i32, align 1														;; Allouer la mémoire nécessaire dans la pile
	store i32 15, i32* %ptrv															;; Enregistrer la valeur dans la mémoire allouée
	%v = load i32* %ptrv																	;; Accéder à la valeur enregistrée

	%resV = call i32 @definir(i32 %v)
	%res = call i32 @definir(i32 15)

	%ptr = alloca [4 x i8], align 1                               
	store [4 x i8] c"%d\0A\00", [4 x i8]* %ptr
	%val = load [4 x i8]* %ptr
	%eptr = getelementptr [4 x i8]* %ptr, i32 0, i32 0

	call i32 (i8*, ...)* @printf(i8* %eptr, i32 15)				;; Affiche bien 15 sur pc de Céline et pc de Julien
	call i32 (i8*, ...)* @printf(i8* %eptr, i32 %v)				;; Affiche bien 15 sur pc de Céline et pc de Julien
	call i32 (i8*, ...)* @printf(i8* %eptr, i32 %res)			;; Affiche 15 sur pc de Julien, n'importe quoi sur pc de Céline
	call i32 (i8*, ...)* @printf(i8* %eptr, i32 %resV)		;; Affiche 15 sur pc de Julien, le même n'importe quoi qu'au dessus sur pc de Céline

	ret i32 0
}
