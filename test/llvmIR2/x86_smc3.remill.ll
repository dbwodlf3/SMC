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
  ;%4 = eax
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  ;%5 = eip
  %6 = load i32, i32* %4, align 4
  ;%6 = eax 
  %7 = add i32 %1, 1
  ; %1 + 1
  store i32 %7, i32* %5, align 4
  ;eip = %1 + 1
  %8 = add i32 %6, 1
  ;%8 = eax + 1
  store i32 %8, i32* %4, align 4, !tbaa !0
  ;eax = eax+1
  %9 = and i32 %8, 255
  ; %9 = eax & 255
  %10 = tail call i32 @llvm.ctpop.i32(i32 %9) #3
  ;  @llvm.ctpop 함수는 -> llvm.ctpop을 모든 정수 비트 너비 또는 정수 요소가있는 벡터에서 사용할 수 있습니다. 
  ;                     -> 변수 또는 벡터의 각 요소 내에서 1을 계산합니다.
  %11 = trunc i32 %10 to i8
  %12 = and i8 %11, 1
  %13 = xor i8 %12, 1
  %14 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  store i8 %13, i8* %14, align 1, !tbaa !4
  ; %14 = %13의 값
  %15 = xor i32 %8, %6
  ; eax | eax + 1
  %16 = lshr i32 %15, 4
  %17 = trunc i32 %16 to i8
  %18 = and i8 %17, 1
  %19 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  store i8 %18, i8* %19, align 1, !tbaa !18
  %20 = icmp eq i32 %8, 0
  %21 = zext i1 %20 to i8
  %22 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  store i8 %21, i8* %22, align 1, !tbaa !19
  %23 = lshr i32 %8, 31
  %24 = trunc i32 %23 to i8
  %25 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  store i8 %24, i8* %25, align 1, !tbaa !20
  %26 = lshr i32 %6, 31
  %27 = xor i32 %23, %26
  %28 = add nuw nsw i32 %27, %23
  %29 = icmp eq i32 %28, 2
  %30 = zext i1 %29 to i8
  %31 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  store i8 %30, i8* %31, align 1, !tbaa !21
  %32 = tail call %struct.Memory* @__remill_missing_block(%struct.State* nonnull %0, i32 %7, %struct.Memory* %2)
  ret %struct.Memory* %32
}

; Function Attrs: nounwind readnone
declare i32 @llvm.ctpop.i32(i32) #1

; Function Attrs: noduplicate noinline nounwind optnone
declare %struct.Memory* @__remill_missing_block(%struct.State* dereferenceable(3376), i32, %struct.Memory*) #2

attributes #0 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { noduplicate noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!0 = !{!1, !1, i64 0}
!1 = !{!"int", !2, i64 0}
!2 = !{!"omnipotent char", !3, i64 0}
!3 = !{!"Simple C++ TBAA"}
!4 = !{!5, !2, i64 2067}
!5 = !{!"_ZTS5State", !2, i64 16, !6, i64 2064, !2, i64 2080, !7, i64 2088, !9, i64 2112, !12, i64 2208, !13, i64 2480, !14, i64 2608, !15, i64 2736, !2, i64 2760, !2, i64 2768, !16, i64 3280}
!6 = !{!"_ZTS10ArithFlags", !2, i64 0, !2, i64 1, !2, i64 2, !2, i64 3, !2, i64 4, !2, i64 5, !2, i64 6, !2, i64 7, !2, i64 8, !2, i64 9, !2, i64 10, !2, i64 11, !2, i64 12, !2, i64 13, !2, i64 14, !2, i64 15}
!7 = !{!"_ZTS8Segments", !8, i64 0, !2, i64 2, !8, i64 4, !2, i64 6, !8, i64 8, !2, i64 10, !8, i64 12, !2, i64 14, !8, i64 16, !2, i64 18, !8, i64 20, !2, i64 22}
!8 = !{!"short", !2, i64 0}
!9 = !{!"_ZTS12AddressSpace", !10, i64 0, !11, i64 8, !10, i64 16, !11, i64 24, !10, i64 32, !11, i64 40, !10, i64 48, !11, i64 56, !10, i64 64, !11, i64 72, !10, i64 80, !11, i64 88}
!10 = !{!"long", !2, i64 0}
!11 = !{!"_ZTS3Reg", !2, i64 0, !1, i64 4}
!12 = !{!"_ZTS3GPR", !10, i64 0, !11, i64 8, !10, i64 16, !11, i64 24, !10, i64 32, !11, i64 40, !10, i64 48, !11, i64 56, !10, i64 64, !11, i64 72, !10, i64 80, !11, i64 88, !10, i64 96, !11, i64 104, !10, i64 112, !11, i64 120, !10, i64 128, !11, i64 136, !10, i64 144, !11, i64 152, !10, i64 160, !11, i64 168, !10, i64 176, !11, i64 184, !10, i64 192, !11, i64 200, !10, i64 208, !11, i64 216, !10, i64 224, !11, i64 232, !10, i64 240, !11, i64 248, !10, i64 256, !11, i64 264}
!13 = !{!"_ZTS8X87Stack", !2, i64 0}
!14 = !{!"_ZTS3MMX", !2, i64 0}
!15 = !{!"_ZTS14FPUStatusFlags", !2, i64 0, !2, i64 1, !2, i64 2, !2, i64 3, !2, i64 4, !2, i64 5, !2, i64 6, !2, i64 7, !2, i64 8, !2, i64 9, !2, i64 10, !2, i64 11, !2, i64 12, !2, i64 13, !2, i64 14, !2, i64 15, !2, i64 16, !2, i64 17, !2, i64 18, !2, i64 19, !2, i64 20}
!16 = !{!"_ZTS13SegmentCaches", !17, i64 0, !17, i64 16, !17, i64 32, !17, i64 48, !17, i64 64, !17, i64 80}
!17 = !{!"_ZTS13SegmentShadow", !2, i64 0, !1, i64 8, !1, i64 12}
!18 = !{!5, !2, i64 2069}
!19 = !{!5, !2, i64 2071}
!20 = !{!5, !2, i64 2073}
!21 = !{!5, !2, i64 2077}