; ModuleID = 'hello.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@.str = private unnamed_addr constant [36 x i8] c"dans la fonction, a^2 - 12 vaut %d\0A\00", align 1
@.str1 = private unnamed_addr constant [24 x i8] c"a est plus petit que 13\00", align 1
@.str2 = private unnamed_addr constant [24 x i8] c"a est plus grand que 13\00", align 1
@.str3 = private unnamed_addr constant [16 x i8] c"hello world %s\0A\00", align 1

; Function Attrs: nounwind
define i8* @compToTreize(i32 %a) #0 {
  %1 = mul nsw i32 %a, %a
  %2 = add nsw i32 %1, -12
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str, i32 0, i32 0), i32 %2) #1
  %4 = icmp slt i32 %a, 13
  %. = select i1 %4, i8* getelementptr inbounds ([24 x i8]* @.str1, i32 0, i32 0), i8* getelementptr inbounds ([24 x i8]* @.str2, i32 0, i32 0)
  ret i8* %.
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #0

; Function Attrs: nounwind
define i32 @main() #0 {
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str, i32 0, i32 0), i32 312) #1
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str3, i32 0, i32 0), i8* getelementptr inbounds ([24 x i8]* @.str2, i32 0, i32 0)) #1
  ret i32 0
}

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
