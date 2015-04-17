; ModuleID = 'hello.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str1 = private unnamed_addr constant [9 x i8] c"%d ; %d\0A\00", align 1

; Function Attrs: nounwind
define i8* @example(i8* nocapture readonly %header, i8* nocapture readonly %word) #0 {
  %1 = tail call i32 @strlen(i8* %header) #2
  %2 = tail call i32 @strlen(i8* %word) #2
  %3 = add i32 %1, 2
  %4 = add i32 %3, %2
  %5 = tail call noalias i8* @malloc(i32 %4) #3
  %6 = tail call i8* @strncat(i8* %5, i8* %header, i32 %1) #3
  %7 = tail call i8* @strncat(i8* %5, i8* %word, i32 %4) #3
  %8 = tail call i8* @strncat(i8* %5, i8* getelementptr inbounds ([2 x i8]* @.str, i32 0, i32 0), i32 %4) #3
  ret i8* %5
}

; Function Attrs: nounwind readonly
declare i32 @strlen(i8* nocapture) #1

; Function Attrs: nounwind
declare noalias i8* @malloc(i32) #0

; Function Attrs: nounwind
declare i8* @strncat(i8*, i8* nocapture readonly, i32) #0

; Function Attrs: nounwind
define i32 @main(i32 %argc, i8** nocapture readonly %argv) #0 {
  %1 = icmp sgt i32 %argc, 2
  br i1 %1, label %2, label %15

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds i8** %argv, i32 1
  %4 = load i8** %3, align 4, !tbaa !1
  %5 = tail call i32 @strlen(i8* %4) #2
  %6 = getelementptr inbounds i8** %argv, i32 2
  %7 = load i8** %6, align 4, !tbaa !1
  %8 = tail call i32 @strlen(i8* %7) #2
  %9 = icmp sgt i32 %argc, 3
  br i1 %9, label %10, label %15

; <label>:10                                      ; preds = %2
  %11 = getelementptr inbounds i8** %argv, i32 3
  %12 = load i8** %11, align 4, !tbaa !1
  %13 = tail call i32 @strlen(i8* %12) #2
  %14 = add i32 %13, %8
  br label %15

; <label>:15                                      ; preds = %2, %10, %0
  %a.0 = phi i32 [ 0, %0 ], [ %5, %10 ], [ %5, %2 ]
  %b.0 = phi i32 [ 0, %0 ], [ %14, %10 ], [ %8, %2 ]
  %16 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str1, i32 0, i32 0), i32 %a.0, i32 %b.0) #3
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #0

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
