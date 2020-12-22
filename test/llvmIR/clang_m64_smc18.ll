; ModuleID = 'smc18.c'
source_filename = "smc18.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [20 x i8] c"This is not excuted\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [8 x i8], align 1
  store i32 0, i32* %1, align 4
  %3 = getelementptr inbounds [8 x i8], [8 x i8]* %2, i64 0, i64 0
  store i8 -72, i8* %3, align 1
  %4 = getelementptr inbounds [8 x i8], [8 x i8]* %2, i64 0, i64 1
  store i8 1, i8* %4, align 1
  %5 = getelementptr inbounds [8 x i8], [8 x i8]* %2, i64 0, i64 2
  store i8 0, i8* %5, align 1
  %6 = getelementptr inbounds [8 x i8], [8 x i8]* %2, i64 0, i64 3
  store i8 0, i8* %6, align 1
  %7 = getelementptr inbounds [8 x i8], [8 x i8]* %2, i64 0, i64 4
  store i8 0, i8* %7, align 1
  %8 = getelementptr inbounds [8 x i8], [8 x i8]* %2, i64 0, i64 5
  store i8 -51, i8* %8, align 1
  %9 = getelementptr inbounds [8 x i8], [8 x i8]* %2, i64 0, i64 6
  store i8 -128, i8* %9, align 1
  %10 = getelementptr inbounds [8 x i8], [8 x i8]* %2, i64 0, i64 7
  store i8 0, i8* %10, align 1
  %11 = bitcast [8 x i8]* %2 to i8*
  %12 = call i32 @getMemoryPermission(i8* %11)
  %13 = getelementptr inbounds [8 x i8], [8 x i8]* %2, i64 0, i64 0
  %14 = bitcast i8* %13 to void (...)*
  call void (...) %14()
  %15 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @getMemoryPermission(i8*) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 4096, i32* %4, align 4
  %5 = load i8*, i8** %3, align 8
  %6 = ptrtoint i8* %5 to i64
  %7 = load i32, i32* %4, align 4
  %8 = sext i32 %7 to i64
  %9 = urem i64 %6, %8
  %10 = load i8*, i8** %3, align 8
  %11 = sub i64 0, %9
  %12 = getelementptr i8, i8* %10, i64 %11
  store i8* %12, i8** %3, align 8
  %13 = load i8*, i8** %3, align 8
  %14 = load i32, i32* %4, align 4
  %15 = sext i32 %14 to i64
  %16 = call i32 @mprotect(i8* %13, i64 %15, i32 7) #3
  %17 = icmp eq i32 %16, -1
  br i1 %17, label %18, label %19

18:                                               ; preds = %1
  store i32 -1, i32* %2, align 4
  br label %20

19:                                               ; preds = %1
  store i32 0, i32* %2, align 4
  br label %20

20:                                               ; preds = %19, %18
  %21 = load i32, i32* %2, align 4
  ret i32 %21
}

declare dso_local i32 @printf(i8*, ...) #1

; Function Attrs: nounwind
declare dso_local i32 @mprotect(i8*, i64, i32) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.0-2~ubuntu18.04.2 (tags/RELEASE_900/final)"}
