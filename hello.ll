; ModuleID = 'hello.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@.str = private unnamed_addr constant [37 x i8] c"a est plus petit que 13 et z vaut %d\00", align 1
@.str1 = private unnamed_addr constant [50 x i8] c"a est plus grand que 13 et z vaut %d et n vaut %d\00", align 1
@.str2 = private unnamed_addr constant [17 x i8] c"x = %d ; y = %d\0A\00", align 1

; Function Attrs: nounwind readnone
define i32 @f(i32 %a, i32 %b) #0 {
  %1 = add nsw i32 %b, %a
  %2 = sub nsw i32 %a, %b
  %3 = mul nsw i32 %1, %2
  ret i32 %3
}

; Function Attrs: nounwind readnone
define i32 @carre(i32 %a) #0 {
  %1 = mul nsw i32 %a, %a
  %2 = shl nuw i32 %1, 1
  %3 = add i32 %2, -24
  %4 = add i32 %a, -16
  %5 = add i32 %4, %a
  %6 = mul nsw i32 %3, %5
  ret i32 %6
}

; Function Attrs: nounwind
define i32 @compToTreize(i32 %a) #1 {
  %1 = icmp slt i32 %a, 13
  br i1 %1, label %2, label %5

; <label>:2                                       ; preds = %0
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str, i32 0, i32 0), i32 1276614272) #2
  %4 = add nsw i32 %a, 13
  br label %8

; <label>:5                                       ; preds = %0
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([50 x i8]* @.str1, i32 0, i32 0), i32 384, i32 7078272) #2
  %7 = add nsw i32 %a, -13
  br label %8

; <label>:8                                       ; preds = %5, %2
  %b.0 = phi i32 [ %4, %2 ], [ %7, %5 ]
  ret i32 %b.0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
define i32 @main() #1 {
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str, i32 0, i32 0), i32 1276614272) #2
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([50 x i8]* @.str1, i32 0, i32 0), i32 384, i32 7078272) #2
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i32 20, i32 12) #2
  ret i32 0
}

attributes #0 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
