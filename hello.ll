; ModuleID = 'hello.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@.str = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str1 = private unnamed_addr constant [14 x i8] c"Hello World!\0A\00", align 1

; Function Attrs: nounwind
define i8* @example(i8* nocapture readonly %header, i8* nocapture readonly %word) #0 {
  %1 = tail call i32 @strlen(i8* %header) #3
  %2 = tail call i32 @strlen(i8* %word) #3
  %3 = add i32 %1, 2
  %4 = add i32 %3, %2
  %5 = tail call noalias i8* @malloc(i32 %4) #2
  %6 = tail call i8* @strncat(i8* %5, i8* %header, i32 %1) #2
  %7 = tail call i8* @strncat(i8* %5, i8* %word, i32 %4) #2
  %8 = tail call i8* @strncat(i8* %5, i8* getelementptr inbounds ([2 x i8]* @.str, i32 0, i32 0), i32 %4) #2
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
  %1 = getelementptr inbounds i8** %argv, i32 1
  %2 = load i8** %1, align 4, !tbaa !1
  %3 = tail call i32 @strlen(i8* %2) #3
  %4 = add i32 %3, 15
  %5 = tail call noalias i8* @malloc(i32 %4) #2
  %strlen = tail call i32 @strlen(i8* %5)
  %endptr = getelementptr i8* %5, i32 %strlen
  tail call void @llvm.memcpy.p0i8.p0i8.i32(i8* %endptr, i8* getelementptr inbounds ([14 x i8]* @.str1, i32 0, i32 0), i32 14, i32 1, i1 false)
  %6 = tail call i8* @strncat(i8* %5, i8* %2, i32 %4) #2
  %7 = tail call i8* @strncat(i8* %5, i8* getelementptr inbounds ([2 x i8]* @.str, i32 0, i32 0), i32 %4) #2
  %8 = tail call i32 (i8*, ...)* @printf(i8* %5) #2
  tail call void @free(i8* %5) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #0

; Function Attrs: nounwind
declare void @free(i8* nocapture) #0

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture, i8* nocapture readonly, i32, i32, i1) #2

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
