; ModuleID = 'lifted_code'
source_filename = "lifted_code"
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu-elf"

%struct.State = type { %struct.ArchState, [32 x %union.VectorReg], %struct.ArithFlags, %union.anon, %struct.Segments, %struct.AddressSpace, %struct.GPR, %struct.X87Stack, %struct.MMX, %struct.FPUStatusFlags, %union.anon, %union.FPU, %struct.SegmentCaches }
%struct.ArchState = type { i32, i32, %union.anon }
%union.VectorReg = type { %union.vec512_t }
%union.vec512_t = type { %struct.uint64v8_t }
%struct.uint64v8_t = type { [8 x i64] }
%struct.ArithFlags = type { i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8 }
%struct.Segments = type { i16, %union.SegmentSelector, i16, %union.SegmentSelector, i16, %union.SegmentSelector, i16, %union.SegmentSelector, i16, %union.SegmentSelector, i16, %union.SegmentSelector }
%union.SegmentSelector = type { i16 }
%struct.AddressSpace = type { i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg }
%struct.Reg = type { %union.anon.1, i32 }
%union.anon.1 = type { i32 }
%struct.GPR = type { i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg, i64, %struct.Reg }
%struct.X87Stack = type { [8 x %struct.anon.3] }
%struct.anon.3 = type { i64, double }
%struct.MMX = type { [8 x %struct.anon.4] }
%struct.anon.4 = type { i64, %union.vec64_t }
%union.vec64_t = type { %struct.uint64v1_t }
%struct.uint64v1_t = type { [1 x i64] }
%struct.FPUStatusFlags = type { i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, [4 x i8] }
%union.anon = type { i64 }
%union.FPU = type { %struct.anon.13 }
%struct.anon.13 = type { %struct.FpuFXSAVE, [96 x i8] }
%struct.FpuFXSAVE = type { %union.SegmentSelector, %union.SegmentSelector, %union.FPUAbridgedTagWord, i8, i16, i32, %union.SegmentSelector, i16, i32, %union.SegmentSelector, i16, %union.anon.1, %union.anon.1, [8 x %struct.FPUStackElem], [16 x %union.vec128_t] }
%union.FPUAbridgedTagWord = type { i8 }
%struct.FPUStackElem = type { %union.anon.11, [6 x i8] }
%union.anon.11 = type { %struct.float80_t }
%struct.float80_t = type { [10 x i8] }
%union.vec128_t = type { %struct.uint128v1_t }
%struct.uint128v1_t = type { [1 x i128] }
%struct.SegmentCaches = type { %struct.SegmentShadow, %struct.SegmentShadow, %struct.SegmentShadow, %struct.SegmentShadow, %struct.SegmentShadow, %struct.SegmentShadow }
%struct.SegmentShadow = type { %union.anon, i32, i32 }
%struct.Memory = type opaque

; Function Attrs: noinline nounwind
define %struct.Memory* @sub_0(%struct.State* noalias dereferenceable(3376), i32, %struct.Memory* noalias) local_unnamed_addr #0 {
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0, i32 0
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 9, i32 0, i32 0
  %8 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  %10 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  %11 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  %12 = load i32, i32* %7, align 4
  %13 = load i32, i32* %6, align 4
  br label %14

; <label>:14:                                     ; preds = %14, %3
  %15 = phi i32 [ %13, %3 ], [ %25, %14 ]
  %16 = phi %struct.Memory* [ %2, %3 ], [ %24, %14 ]
  %17 = tail call i32 @__remill_read_memory_32(%struct.Memory* %16, i32 134512753) #3
  %18 = tail call i32 @__remill_read_memory_32(%struct.Memory* %16, i32 134512757) #3
  %19 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %16, i32 134512753, i32 %18) #3
  %20 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %19, i32 134512757, i32 %17) #3
  %21 = tail call i32 @__remill_read_memory_32(%struct.Memory* %20, i32 134512749) #3
  %22 = tail call i32 @__remill_read_memory_32(%struct.Memory* %20, i32 134512761) #3
  %23 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %20, i32 134512761, i32 %21) #3
  %24 = tail call %struct.Memory* @__remill_write_memory_32(%struct.Memory* %23, i32 134512749, i32 %22) #3
  %25 = add i32 %15, 1
  %26 = icmp eq i32 %15, 1
  br i1 %26, label %27, label %14

; <label>:27:                                     ; preds = %14
  %28 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 5, i32 0, i32 0
  %29 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  %30 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  %31 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  %32 = add i32 %12, 40
  %33 = mul i32 %13, -20
  %34 = add i32 %32, %33
  store i32 %21, i32* %28, align 4
  store i32 %34, i32* %7, align 4
  store i8 0, i8* %9, align 1, !tbaa !0
  store i8 1, i8* %29, align 1, !tbaa !17
  store i8 0, i8* %10, align 1, !tbaa !18
  store i8 1, i8* %30, align 1, !tbaa !19
  store i8 0, i8* %11, align 1, !tbaa !20
  store i8 0, i8* %31, align 1, !tbaa !21
  store i32 2, i32* %6, align 4
  store i32 1, i32* %4, align 4, !tbaa !22
  store i32 0, i32* %5, align 4, !tbaa !22
  %35 = add i32 %1, 65
  store i32 %35, i32* %8, align 4
  %36 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 2
  %37 = bitcast %union.anon* %36 to i32*
  store i32 128, i32* %37, align 8, !tbaa !22
  %38 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 0, i32 0
  store i32 4, i32* %38, align 16, !tbaa !23
  %39 = tail call %struct.Memory* @__remill_async_hyper_call(%struct.State* nonnull %0, i32 %35, %struct.Memory* %24)
  %40 = load i32, i32* %8, align 4
  %41 = tail call %struct.Memory* @__remill_missing_block(%struct.State* nonnull %0, i32 %40, %struct.Memory* %24)
  ret %struct.Memory* %41
}

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare i32 @__remill_read_memory_32(%struct.Memory*, i32) #1

; Function Attrs: noduplicate noinline nounwind optnone readnone
declare %struct.Memory* @__remill_write_memory_32(%struct.Memory*, i32, i32) #1

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_async_hyper_call(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_missing_block(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noduplicate noinline nounwind optnone readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noduplicate noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nobuiltin nounwind readnone }

!0 = !{!1, !2, i64 2065}
!1 = !{!"_ZTS5State", !2, i64 16, !4, i64 2064, !2, i64 2080, !5, i64 2088, !7, i64 2112, !11, i64 2208, !12, i64 2480, !13, i64 2608, !14, i64 2736, !2, i64 2760, !2, i64 2768, !15, i64 3280}
!2 = !{!"omnipotent char", !3, i64 0}
!3 = !{!"Simple C++ TBAA"}
!4 = !{!"_ZTS10ArithFlags", !2, i64 0, !2, i64 1, !2, i64 2, !2, i64 3, !2, i64 4, !2, i64 5, !2, i64 6, !2, i64 7, !2, i64 8, !2, i64 9, !2, i64 10, !2, i64 11, !2, i64 12, !2, i64 13, !2, i64 14, !2, i64 15}
!5 = !{!"_ZTS8Segments", !6, i64 0, !2, i64 2, !6, i64 4, !2, i64 6, !6, i64 8, !2, i64 10, !6, i64 12, !2, i64 14, !6, i64 16, !2, i64 18, !6, i64 20, !2, i64 22}
!6 = !{!"short", !2, i64 0}
!7 = !{!"_ZTS12AddressSpace", !8, i64 0, !9, i64 8, !8, i64 16, !9, i64 24, !8, i64 32, !9, i64 40, !8, i64 48, !9, i64 56, !8, i64 64, !9, i64 72, !8, i64 80, !9, i64 88}
!8 = !{!"long", !2, i64 0}
!9 = !{!"_ZTS3Reg", !2, i64 0, !10, i64 4}
!10 = !{!"int", !2, i64 0}
!11 = !{!"_ZTS3GPR", !8, i64 0, !9, i64 8, !8, i64 16, !9, i64 24, !8, i64 32, !9, i64 40, !8, i64 48, !9, i64 56, !8, i64 64, !9, i64 72, !8, i64 80, !9, i64 88, !8, i64 96, !9, i64 104, !8, i64 112, !9, i64 120, !8, i64 128, !9, i64 136, !8, i64 144, !9, i64 152, !8, i64 160, !9, i64 168, !8, i64 176, !9, i64 184, !8, i64 192, !9, i64 200, !8, i64 208, !9, i64 216, !8, i64 224, !9, i64 232, !8, i64 240, !9, i64 248, !8, i64 256, !9, i64 264}
!12 = !{!"_ZTS8X87Stack", !2, i64 0}
!13 = !{!"_ZTS3MMX", !2, i64 0}
!14 = !{!"_ZTS14FPUStatusFlags", !2, i64 0, !2, i64 1, !2, i64 2, !2, i64 3, !2, i64 4, !2, i64 5, !2, i64 6, !2, i64 7, !2, i64 8, !2, i64 9, !2, i64 10, !2, i64 11, !2, i64 12, !2, i64 13, !2, i64 14, !2, i64 15, !2, i64 16, !2, i64 17, !2, i64 18, !2, i64 19, !2, i64 20}
!15 = !{!"_ZTS13SegmentCaches", !16, i64 0, !16, i64 16, !16, i64 32, !16, i64 48, !16, i64 64, !16, i64 80}
!16 = !{!"_ZTS13SegmentShadow", !2, i64 0, !10, i64 8, !10, i64 12}
!17 = !{!1, !2, i64 2067}
!18 = !{!1, !2, i64 2069}
!19 = !{!1, !2, i64 2071}
!20 = !{!1, !2, i64 2073}
!21 = !{!1, !2, i64 2077}
!22 = !{!10, !10, i64 0}
!23 = !{!24, !25, i64 0}
!24 = !{!"_ZTS9ArchState", !25, i64 0, !10, i64 4, !2, i64 8}
!25 = !{!"_ZTSN14AsyncHyperCall4NameE", !2, i64 0}