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
   %alloc = alloca i32
   store i32 3, i32* %alloc
   %load = load i32* %alloc			;;a


   %alloc0 = alloca i32
   store i32 9, i32* %alloc0
   %load0 = load i32* %alloc0			;;b

   %slt = icmp slt i32 6, %load0
   br i1 %slt, label %label2, label %label3
 label2:
   %alloc1 = alloca i32
   store i32 6, i32* %alloc1
   %load1 = load i32* %alloc1				;;a

   %slt0 = icmp slt i32 %load0, 12
   br i1 %slt0, label %label4, label %label5
 label4:
   %alloc2 = alloca i32
   store i32 12, i32* %alloc2
   %load2 = load i32* %alloc2					;;b

   %slt1 = icmp slt i32 %load1, 10
   br i1 %slt1, label %label6, label %label7
 label6:
   %alloc3 = alloca i32
   store i32 30, i32* %alloc3
   %load3 = load i32* %alloc3					;;a

   %alloc4 = alloca i32
   store i32 8, i32* %alloc4
   %load4 = load i32* %alloc4					;;c
   br label %label7
 label7:
   %phi = phi i32 [%load3, %label6],[%load1, %label2],[%load, %label1] ;;a
   %phi0 = phi i32 [%load4, %label6]		;;c
   br label %label5
 label5:
   %phi1 = phi i32 [%load2, %label4],[%load0, %label1]		;;b

   %alloc5 = alloca i32
   store i32 4, i32* %alloc5
   %load5 = load i32* %alloc5
   br label %label3
 label3:
   %phi2 = phi i32 [%phi, %label7],[%load3, %label6],[%load1, %label2],[%load, %label1]
   %phi3 = phi i32 [%load5, %label5]
   %call0 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str0, i32 0, i32 0), i32 %phi2)
   %call1 = call i32 (i8*,...)* @printf(i8* getelementptr([4 x i8]* @str1, i32 0, i32 0), i32 %phi1)
ret i32 0
}
