declare i32 @printf(i8*,...) nounwind
;str
@str = constant [4 x i8] c"%d\0a\00"

;str
@str0 = constant [4 x i8] c"%d\0a\00"

;str
@str1 = constant [4 x i8] c"%d\0a\00"

define i32 @main(i32 %argc, i8** %argv) {
   br label %label1
 label1:
   %alloc = alloca i32													;; a = 3
   store i32 3, i32* %alloc
   %load = load i32* %alloc

   %alloc0 = alloca i32													;; b = 9
   store i32 9, i32* %alloc0
   %load0 = load i32* %alloc0

   %slt = icmp slt i32 6, %load0								;; if (6 < b)
   br i1 %slt, label %label2, label %label3
 label2:																				;; cas true de if (6 < b)
   %alloc1 = alloca i32													;; a = 6
   store i32 6, i32* %alloc1
   %load1 = load i32* %alloc1

   %slt0 = icmp slt i32 %load0, 12							;; if (b < 12)
   br i1 %slt0, label %label4, label %label5
 label4:																				;; cas true de if ( b < 12 )
   %alloc2 = alloca i32
   store i32 12, i32* %alloc2
   %load2 = load i32* %alloc2										;; b = 12

   br label %label5
 label5:																				;; cas suivant de if (b < 12)
   %phi = phi i32 [%load2, %label4],[%load0, %label2]  ;; j'ai redéfini b dans label4, donc je le recherche, mais pas comme il faut
   br label %label3
 label3:																				;; cas suivant de if (6 < b)
   %phi0 = phi i32 [%load, %label1],[%load1,%label5] ;; j'ai redéfini a dans label2, donc je le recherche, mais il manque un cas
	 %phi2 = phi i32 [%load0, %label1], [%phi,%label5] ;; j'ai redéfini b dans label5, donc je devrais le rechercher
   %call0 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str0, i32 0, i32 0), i32 %phi0)
   %call1 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str1, i32 0, i32 0), i32 %phi2)
ret i32 0
}
