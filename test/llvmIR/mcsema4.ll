; ModuleID = './smc3.x86.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu-elf"

%union.anon = type { i64 }
%_fp_hw_type = type <{ [8 x i8], [48 x i8], [5 x i8] }>
%seg_1fc8__got_type = type <{ [12 x i8], i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32 }>
%err_string_type = type <{ i32 }>
%__bss_start_type = type <{ [4 x i8] }>
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

@DR0 = external dso_local global i64, align 8
@DR1 = external dso_local global i64, align 8
@DR2 = external dso_local global i64, align 8
@DR3 = external dso_local global i64, align 8
@DR4 = external dso_local global i64, align 8
@DR5 = external dso_local global i64, align 8
@DR6 = external dso_local global i64, align 8
@DR7 = external dso_local global i64, align 8
@gCR0 = external dso_local global %union.anon, align 1
@gCR1 = external dso_local global %union.anon, align 1
@gCR2 = external dso_local global %union.anon, align 1
@gCR3 = external dso_local global %union.anon, align 1
@gCR4 = external dso_local global %union.anon, align 1
@_fp_hw = dso_local constant %_fp_hw_type <{ [8 x i8] c"\03\00\00\00\01\00\02\00", [48 x i8] c"Error while changing page permissions of foo()\0A\00", [5 x i8] c"%d \0A\00" }>
@seg_1fc8__got = internal global %seg_1fc8__got_type <{ [12 x i8] c"\D0\1E\00\00\00\00\00\00\00\00\00\00", i32 ptrtoint (i32 (i32, i32, i32)* @mprotect to i32), i32 ptrtoint (i32 (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)* @printf to i32), i32 ptrtoint (i32 (i32)* @exit to i32), i32 ptrtoint (i32 (i32)* @strlen to i32), i32 ptrtoint (i32 (i32, i32, i32, i32, i32, i32, i32, i32)* @__libc_start_main to i32), i32 ptrtoint (i32 (i32, i32, i32)* @write to i32), i32 ptrtoint (i32 (i32)* @_ITM_deregisterTMCloneTable to i32), i32 ptrtoint (i32 (i32)* @__cxa_finalize to i32), i32 ptrtoint (i32 ()* @__gmon_start__ to i32), i32 ptrtoint (void ()* @main to i32), i32 ptrtoint (i32 (i32, i32)* @_ITM_registerTMCloneTable to i32) }>
@err_string = dso_local local_unnamed_addr global %err_string_type <{ i32 add (i32 ptrtoint (%_fp_hw_type* @_fp_hw to i32), i32 8) }>
@__bss_start = dso_local local_unnamed_addr global %__bss_start_type zeroinitializer
@0 = internal global i1 false
@1 = internal constant void ()* @__mcsema_attach_call
@2 = internal constant %struct.Memory* (%struct.State*, i32, %struct.Memory*)* @main_wrapper
@3 = internal constant %struct.Memory* (%struct.State*, i32, %struct.Memory*)* @__x86.get_pc_thunk.dx_wrapper
@4 = internal constant %struct.Memory* (%struct.State*, i32, %struct.Memory*)* @change_page_permissions_of_address_wrapper
@5 = internal constant %struct.Memory* (%struct.State*, i32, %struct.Memory*)* @.init_proc_wrapper
@6 = internal constant %struct.Memory* (%struct.State*, i32, %struct.Memory*)* @.term_proc_wrapper
@7 = internal constant %struct.Memory* (%struct.State*, i32, %struct.Memory*)* @__x86.get_pc_thunk.cx_wrapper
@8 = internal constant %struct.Memory* (%struct.State*, i32, %struct.Memory*)* @__x86.get_pc_thunk.bx_wrapper
@9 = internal constant %struct.Memory* (%struct.State*, i32, %struct.Memory*)* @get_permission_wrapper
@10 = internal constant %struct.Memory* (%struct.State*, i32, %struct.Memory*)* @callback_sub_870___libc_csu_init_wrapper
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 101, void ()* @__mcsema_constructor, i8* null }]
@11 = internal constant %struct.Memory* (%struct.State*, i32, %struct.Memory*)* @callback_sub_8d0___libc_csu_fini_wrapper
@llvm.global_dtors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 101, void ()* @__mcsema_destructor, i8* null }]

; Function Attrs: nounwind readnone speculatable willreturn
declare !remill.function.type !1272 i32 @llvm.ctpop.i32(i32) #0

; Function Attrs: noduplicate noinline nounwind optnone
declare !remill.function.type !1272 dso_local %struct.Memory* @__remill_error(%struct.State* dereferenceable(3376), i32, %struct.Memory*) local_unnamed_addr #1

; Function Attrs: noduplicate noinline nounwind optnone
declare !remill.function.type !1272 dso_local %struct.Memory* @__remill_function_call(%struct.State* dereferenceable(3376), i32, %struct.Memory*) local_unnamed_addr #2

; Function Attrs: noduplicate noinline nounwind optnone
declare !remill.function.type !1272 dso_local %struct.Memory* @__remill_jump(%struct.State* dereferenceable(3376), i32, %struct.Memory*) local_unnamed_addr #2

; Function Attrs: noinline
declare !remill.function.type !1273 extern_weak i32 @__cxa_finalize(i32) #3

; Function Attrs: noinline
declare !remill.function.type !1273 extern_weak i32 @printf(i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32) #3

; Function Attrs: noinline
declare !remill.function.type !1273 extern_weak i32 @strlen(i32) #3

; Function Attrs: noinline
declare !remill.function.type !1273 extern_weak i32 @exit(i32) #3

; Function Attrs: noinline
declare !remill.function.type !1273 extern_weak i32 @mprotect(i32, i32, i32) #3

; Function Attrs: noinline
declare !remill.function.type !1273 extern_weak i32 @__libc_start_main(i32, i32, i32, i32, i32, i32, i32, i32) #3

; Function Attrs: noinline
declare !remill.function.type !1273 extern_weak i32 @__gmon_start__() #3

; Function Attrs: noinline
declare !remill.function.type !1273 extern_weak i32 @write(i32, i32, i32) #3

; Function Attrs: noinline
declare !remill.function.type !1273 extern_weak i32 @_ITM_deregisterTMCloneTable(i32) #3

; Function Attrs: noinline
declare !remill.function.type !1273 extern_weak i32 @_ITM_registerTMCloneTable(i32, i32) #3

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_500_deregister_tm_clones(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_538:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 5, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %8 = add i32 %1, 233
  %9 = add i32 %1, 5
  %10 = load i32, i32* %6, align 8, !tbaa !1275
  %11 = add i32 %10, -4
  %12 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %13 = load i32, i32* %12, align 8, !tbaa !1275
  %14 = add i32 %13, %11
  %15 = inttoptr i32 %14 to i32*
  store i32 %9, i32* %15
  store i32 %11, i32* %6, align 4, !tbaa !1278
  %16 = tail call %struct.Memory* @sub_5e9___x86_get_pc_thunk_dx(%struct.State* nonnull %0, i32 %8, %struct.Memory* %2)
  %17 = load i32, i32* %5, align 4
  %18 = add i32 %17, 6851
  store i32 %18, i32* %5, align 4, !tbaa !1278
  %19 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  %20 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  %21 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  %22 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  %23 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  %24 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  %25 = add i32 %17, 6919
  store i32 %25, i32* %4, align 4, !tbaa !1278
  store i32 %25, i32* %3, align 4, !tbaa !1278
  store i8 0, i8* %19, align 1, !tbaa !1280
  store i8 1, i8* %20, align 1, !tbaa !1294
  store i8 0, i8* %21, align 1, !tbaa !1295
  store i8 1, i8* %22, align 1, !tbaa !1296
  store i8 0, i8* %23, align 1, !tbaa !1297
  store i8 0, i8* %24, align 1, !tbaa !1298
  %26 = load i32, i32* %6, align 8, !tbaa !1275
  %27 = load i32, i32* %12, align 8, !tbaa !1275
  %28 = add i32 %27, %26
  %29 = inttoptr i32 %28 to i32*
  %30 = load i32, i32* %29
  store i32 %30, i32* %7, align 4, !tbaa !1278
  %31 = add i32 %26, 4
  store i32 %31, i32* %6, align 4, !tbaa !1278
  ret %struct.Memory* %16
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_490__write(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_490:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %4 = load i32, i32* inttoptr (i32 add (i32 ptrtoint (%seg_1fc8__got_type* @seg_1fc8__got to i32), i32 32) to i32*)
  store i32 %4, i32* %3, align 4, !tbaa !1278
  %5 = tail call fastcc %struct.Memory* @ext_202c_write(%struct.State* nonnull %0, %struct.Memory* %2)
  ret %struct.Memory* %5
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_4a0____cxa_finalize(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_4a0:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %5 = load i32, i32* %3, align 4
  %6 = add i32 %5, ptrtoint (i32 (i32)* @__cxa_finalize to i32)
  %7 = inttoptr i32 %6 to i32*
  %8 = load i32, i32* %7
  store i32 %8, i32* %4, align 4, !tbaa !1278
  %9 = icmp eq i32 %8, 1190
  br i1 %9, label %block_4a6, label %11

block_4a6:                                        ; preds = %block_4a0
  %10 = tail call %struct.Memory* @sub_4a8____gmon_start__(%struct.State* nonnull %0, i32 1192, %struct.Memory* %2)
  ret %struct.Memory* %10

11:                                               ; preds = %block_4a0
  %12 = tail call %struct.Memory* @__remill_jump(%struct.State* nonnull %0, i32 %8, %struct.Memory* %2)
  ret %struct.Memory* %12
}

; Function Attrs: nofree noinline nounwind
define dso_local %struct.Memory* @sub_85d___x86_get_pc_thunk_cx(%struct.State* noalias nocapture dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias returned %2) local_unnamed_addr #5 !remill.function.type !1274 !remill.function.tie !1299 {
block_85d:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 5, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %6 = load i32, i32* %4, align 4
  %7 = inttoptr i32 %6 to i32*
  %8 = load i32, i32* %7
  store i32 %8, i32* %3, align 4, !tbaa !1278
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %10 = load i32, i32* %9, align 8, !tbaa !1275
  %11 = add i32 %10, %6
  %12 = inttoptr i32 %11 to i32*
  %13 = load i32, i32* %12
  store i32 %13, i32* %5, align 4, !tbaa !1278
  %14 = add i32 %6, 4
  store i32 %14, i32* %4, align 4, !tbaa !1278
  ret %struct.Memory* %2
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_404__init_proc(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 !remill.function.tie !1300 {
block_404:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %7 = load i32, i32* %4, align 4
  %8 = load i32, i32* %5, align 8, !tbaa !1275
  %9 = add i32 %8, -4
  %10 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %11 = load i32, i32* %10, align 8, !tbaa !1275
  %12 = add i32 %11, %9
  %13 = inttoptr i32 %12 to i32*
  store i32 %7, i32* %13
  %14 = add i32 %8, -12
  %15 = icmp ult i32 %9, 8
  %16 = zext i1 %15 to i8
  %17 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  store i8 %16, i8* %17, align 1, !tbaa !1280
  %18 = and i32 %14, 255
  %19 = tail call i32 @llvm.ctpop.i32(i32 %18) #11, !range !1301
  %20 = trunc i32 %19 to i8
  %21 = and i8 %20, 1
  %22 = xor i8 %21, 1
  %23 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  store i8 %22, i8* %23, align 1, !tbaa !1294
  %24 = xor i32 %9, %14
  %25 = lshr i32 %24, 4
  %26 = trunc i32 %25 to i8
  %27 = and i8 %26, 1
  %28 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  store i8 %27, i8* %28, align 1, !tbaa !1295
  %29 = icmp eq i32 %14, 0
  %30 = zext i1 %29 to i8
  %31 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  store i8 %30, i8* %31, align 1, !tbaa !1296
  %32 = lshr i32 %14, 31
  %33 = trunc i32 %32 to i8
  %34 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  store i8 %33, i8* %34, align 1, !tbaa !1297
  %35 = lshr i32 %9, 31
  %36 = xor i32 %32, %35
  %37 = add nuw nsw i32 %36, %35
  %38 = icmp eq i32 %37, 2
  %39 = zext i1 %38 to i8
  %40 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  store i8 %39, i8* %40, align 1, !tbaa !1298
  %41 = add i32 %1, 236
  %42 = add i32 %1, 9
  %43 = add i32 %8, -16
  %44 = add i32 %11, %43
  %45 = inttoptr i32 %44 to i32*
  store i32 %42, i32* %45
  store i32 %43, i32* %5, align 4, !tbaa !1278
  %46 = tail call %struct.Memory* @sub_4f0___x86_get_pc_thunk_bx(%struct.State* nonnull %0, i32 %41, %struct.Memory* %2)
  %47 = load i32, i32* %4, align 4
  %48 = load i32, i32* %6, align 4
  %49 = add i32 %47, 7099
  store i32 %49, i32* %4, align 4, !tbaa !1278
  %50 = add i32 %47, 7143
  %51 = inttoptr i32 %50 to i32*
  %52 = load i32, i32* %51
  store i32 %52, i32* %3, align 4, !tbaa !1278
  store i8 0, i8* %17, align 1, !tbaa !1280
  %53 = and i32 %52, 255
  %54 = tail call i32 @llvm.ctpop.i32(i32 %53) #11, !range !1301
  %55 = trunc i32 %54 to i8
  %56 = and i8 %55, 1
  %57 = xor i8 %56, 1
  store i8 %57, i8* %23, align 1, !tbaa !1294
  %58 = icmp eq i32 %52, 0
  %59 = zext i1 %58 to i8
  store i8 %59, i8* %31, align 1, !tbaa !1296
  %60 = lshr i32 %52, 31
  %61 = trunc i32 %60 to i8
  store i8 %61, i8* %34, align 1, !tbaa !1297
  store i8 0, i8* %40, align 1, !tbaa !1298
  store i8 0, i8* %28, align 1, !tbaa !1295
  %62 = select i1 %58, i32 21, i32 16
  %63 = add i32 %62, %48
  br i1 %58, label %block_422, label %block_41d

block_41d:                                        ; preds = %block_404
  %64 = add i32 %63, 139
  %65 = add i32 %63, 5
  %66 = load i32, i32* %5, align 8, !tbaa !1275
  %67 = add i32 %66, -4
  %68 = load i32, i32* %10, align 8, !tbaa !1275
  %69 = add i32 %68, %67
  %70 = inttoptr i32 %69 to i32*
  store i32 %65, i32* %70
  store i32 %67, i32* %5, align 4, !tbaa !1278
  %71 = tail call %struct.Memory* @sub_4a8____gmon_start__(%struct.State* nonnull %0, i32 %64, %struct.Memory* %46)
  br label %block_422

block_422:                                        ; preds = %block_41d, %block_404
  %72 = phi %struct.Memory* [ %46, %block_404 ], [ %71, %block_41d ]
  %73 = load i32, i32* %5, align 4
  %74 = add i32 %73, 8
  %75 = icmp ugt i32 %73, -9
  %76 = icmp ult i32 %74, 8
  %77 = or i1 %75, %76
  %78 = zext i1 %77 to i8
  store i8 %78, i8* %17, align 1, !tbaa !1280
  %79 = and i32 %74, 255
  %80 = tail call i32 @llvm.ctpop.i32(i32 %79) #11, !range !1301
  %81 = trunc i32 %80 to i8
  %82 = and i8 %81, 1
  %83 = xor i8 %82, 1
  store i8 %83, i8* %23, align 1, !tbaa !1294
  %84 = xor i32 %74, %73
  %85 = lshr i32 %84, 4
  %86 = trunc i32 %85 to i8
  %87 = and i8 %86, 1
  store i8 %87, i8* %28, align 1, !tbaa !1295
  %88 = icmp eq i32 %74, 0
  %89 = zext i1 %88 to i8
  store i8 %89, i8* %31, align 1, !tbaa !1296
  %90 = lshr i32 %74, 31
  %91 = trunc i32 %90 to i8
  store i8 %91, i8* %34, align 1, !tbaa !1297
  %92 = lshr i32 %73, 31
  %93 = xor i32 %90, %92
  %94 = add nuw nsw i32 %93, %90
  %95 = icmp eq i32 %94, 2
  %96 = zext i1 %95 to i8
  store i8 %96, i8* %40, align 1, !tbaa !1298
  %97 = add i32 %73, 12
  %98 = load i32, i32* %10, align 8, !tbaa !1275
  %99 = add i32 %98, %74
  %100 = inttoptr i32 %99 to i32*
  %101 = load i32, i32* %100
  store i32 %101, i32* %4, align 4, !tbaa !1278
  %102 = add i32 %98, %97
  %103 = inttoptr i32 %102 to i32*
  %104 = load i32, i32* %103
  store i32 %104, i32* %6, align 4, !tbaa !1278
  %105 = add i32 %73, 16
  store i32 %105, i32* %5, align 4, !tbaa !1278
  ret %struct.Memory* %72
}

; Function Attrs: nofree noinline nounwind
define dso_local %struct.Memory* @sub_4f0___x86_get_pc_thunk_bx(%struct.State* noalias nocapture dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias returned %2) local_unnamed_addr #5 !remill.function.type !1274 !remill.function.tie !1302 {
block_4f0:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %6 = load i32, i32* %4, align 4
  %7 = inttoptr i32 %6 to i32*
  %8 = load i32, i32* %7
  store i32 %8, i32* %3, align 4, !tbaa !1278
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %10 = load i32, i32* %9, align 8, !tbaa !1275
  %11 = add i32 %10, %6
  %12 = inttoptr i32 %11 to i32*
  %13 = load i32, i32* %12
  store i32 %13, i32* %5, align 4, !tbaa !1278
  %14 = add i32 %6, 4
  store i32 %14, i32* %4, align 4, !tbaa !1278
  ret %struct.Memory* %2
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_870___libc_csu_init(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_870:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 9, i32 0, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 11, i32 0, i32 0
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %8 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 15, i32 0, i32 0
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %10 = load i32, i32* %8, align 4
  %11 = load i32, i32* %7, align 8, !tbaa !1275
  %12 = add i32 %11, -4
  %13 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %14 = load i32, i32* %13, align 8, !tbaa !1275
  %15 = add i32 %14, %12
  %16 = inttoptr i32 %15 to i32*
  store i32 %10, i32* %16
  %17 = load i32, i32* %6, align 4
  %18 = add i32 %11, -8
  %19 = add i32 %14, %18
  %20 = inttoptr i32 %19 to i32*
  store i32 %17, i32* %20
  %21 = load i32, i32* %5, align 4
  %22 = add i32 %11, -12
  %23 = add i32 %14, %22
  %24 = inttoptr i32 %23 to i32*
  store i32 %21, i32* %24
  %25 = load i32, i32* %4, align 4
  %26 = add i32 %11, -16
  %27 = add i32 %14, %26
  %28 = inttoptr i32 %27 to i32*
  store i32 %25, i32* %28
  %29 = add i32 %1, -896
  %30 = add i32 %1, 9
  %31 = add i32 %11, -20
  %32 = add i32 %14, %31
  %33 = inttoptr i32 %32 to i32*
  store i32 %30, i32* %33
  store i32 %31, i32* %7, align 4, !tbaa !1278
  %34 = tail call %struct.Memory* @sub_4f0___x86_get_pc_thunk_bx(%struct.State* nonnull %0, i32 %29, %struct.Memory* %2)
  %35 = load i32, i32* %4, align 4
  %36 = load i32, i32* %9, align 4
  %37 = add i32 %35, 5967
  store i32 %37, i32* %4, align 4, !tbaa !1278
  %38 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  %39 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  %40 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  %41 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  %42 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  %43 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  %44 = load i32, i32* %7, align 4
  %45 = add i32 %44, 28
  %46 = inttoptr i32 %45 to i32*
  %47 = load i32, i32* %46
  store i32 %47, i32* %8, align 4, !tbaa !1278
  %48 = add i32 %35, 5715
  store i32 %48, i32* %5, align 4, !tbaa !1278
  %49 = add i32 %36, -1141
  %50 = add i32 %36, 24
  %51 = add i32 %44, -16
  %52 = load i32, i32* %13, align 8, !tbaa !1275
  %53 = add i32 %52, %51
  %54 = inttoptr i32 %53 to i32*
  store i32 %50, i32* %54
  store i32 %51, i32* %7, align 4, !tbaa !1278
  %55 = tail call %struct.Memory* @sub_404__init_proc(%struct.State* nonnull %0, i32 %49, %struct.Memory* %34)
  %56 = load i32, i32* %4, align 4
  %57 = add i32 %56, -256
  %58 = load i32, i32* %9, align 4
  store i32 %57, i32* %3, align 4, !tbaa !1278
  %59 = load i32, i32* %5, align 4
  %60 = sub i32 %59, %57
  %61 = ashr i32 %60, 2
  %62 = icmp eq i32 %61, 0
  %63 = select i1 %62, i32 52, i32 15
  %64 = add i32 %63, %58
  br i1 %62, label %block_870.block_8c5_crit_edge, label %block_8a0

block_870.block_8c5_crit_edge:                    ; preds = %block_870
  %65 = load i32, i32* %7, align 4
  br label %block_8c5

block_8c5:                                        ; preds = %block_8a8, %block_870.block_8c5_crit_edge
  %66 = phi i32 [ %65, %block_870.block_8c5_crit_edge ], [ %171, %block_8a8 ]
  %67 = phi %struct.Memory* [ %55, %block_870.block_8c5_crit_edge ], [ %166, %block_8a8 ]
  %68 = lshr i32 %66, 31
  %69 = add i32 %66, 12
  %70 = icmp ugt i32 %66, -13
  %71 = icmp ult i32 %69, 12
  %72 = or i1 %70, %71
  %73 = zext i1 %72 to i8
  store i8 %73, i8* %38, align 1, !tbaa !1280
  %74 = and i32 %69, 255
  %75 = tail call i32 @llvm.ctpop.i32(i32 %74) #11, !range !1301
  %76 = trunc i32 %75 to i8
  %77 = and i8 %76, 1
  %78 = xor i8 %77, 1
  store i8 %78, i8* %39, align 1, !tbaa !1294
  %79 = xor i32 %69, %66
  %80 = lshr i32 %79, 4
  %81 = trunc i32 %80 to i8
  %82 = and i8 %81, 1
  store i8 %82, i8* %40, align 1, !tbaa !1295
  %83 = icmp eq i32 %69, 0
  %84 = zext i1 %83 to i8
  store i8 %84, i8* %41, align 1, !tbaa !1296
  %85 = lshr i32 %69, 31
  %86 = trunc i32 %85 to i8
  store i8 %86, i8* %42, align 1, !tbaa !1297
  %87 = xor i32 %85, %68
  %88 = add nuw nsw i32 %87, %85
  %89 = icmp eq i32 %88, 2
  %90 = zext i1 %89 to i8
  store i8 %90, i8* %43, align 1, !tbaa !1298
  %91 = add i32 %66, 16
  %92 = load i32, i32* %13, align 8, !tbaa !1275
  %93 = add i32 %92, %69
  %94 = inttoptr i32 %93 to i32*
  %95 = load i32, i32* %94
  store i32 %95, i32* %4, align 4, !tbaa !1278
  %96 = add i32 %66, 20
  %97 = add i32 %92, %91
  %98 = inttoptr i32 %97 to i32*
  %99 = load i32, i32* %98
  store i32 %99, i32* %5, align 4, !tbaa !1278
  %100 = add i32 %66, 24
  %101 = add i32 %92, %96
  %102 = inttoptr i32 %101 to i32*
  %103 = load i32, i32* %102
  store i32 %103, i32* %6, align 4, !tbaa !1278
  %104 = add i32 %66, 28
  %105 = add i32 %92, %100
  %106 = inttoptr i32 %105 to i32*
  %107 = load i32, i32* %106
  store i32 %107, i32* %8, align 4, !tbaa !1278
  %108 = add i32 %92, %104
  %109 = inttoptr i32 %108 to i32*
  %110 = load i32, i32* %109
  store i32 %110, i32* %9, align 4, !tbaa !1278
  %111 = add i32 %66, 32
  store i32 %111, i32* %7, align 4, !tbaa !1278
  ret %struct.Memory* %67

block_8a0:                                        ; preds = %block_870
  store i32 0, i32* %6, align 4, !tbaa !1278
  %112 = add i32 %64, 8
  store i32 %61, i32* %5, align 4, !tbaa !1278
  %113 = load i32, i32* %7, align 4
  br label %block_8a8

block_8a8:                                        ; preds = %block_8a8.block_8a8_crit_edge, %block_8a0
  %114 = phi i32 [ 0, %block_8a0 ], [ %169, %block_8a8.block_8a8_crit_edge ]
  %115 = phi i32 [ %56, %block_8a0 ], [ %177, %block_8a8.block_8a8_crit_edge ]
  %116 = phi i32 [ %112, %block_8a0 ], [ %176, %block_8a8.block_8a8_crit_edge ]
  %117 = phi i32 [ %113, %block_8a0 ], [ %171, %block_8a8.block_8a8_crit_edge ]
  %118 = phi %struct.Memory* [ %55, %block_8a0 ], [ %166, %block_8a8.block_8a8_crit_edge ]
  %119 = add i32 %117, -4
  %120 = icmp ult i32 %117, 4
  %121 = zext i1 %120 to i8
  store i8 %121, i8* %38, align 1, !tbaa !1280
  %122 = and i32 %119, 255
  %123 = tail call i32 @llvm.ctpop.i32(i32 %122) #11, !range !1301
  %124 = trunc i32 %123 to i8
  %125 = and i8 %124, 1
  %126 = xor i8 %125, 1
  store i8 %126, i8* %39, align 1, !tbaa !1294
  %127 = xor i32 %119, %117
  %128 = lshr i32 %127, 4
  %129 = trunc i32 %128 to i8
  %130 = and i8 %129, 1
  store i8 %130, i8* %40, align 1, !tbaa !1295
  %131 = icmp eq i32 %119, 0
  %132 = zext i1 %131 to i8
  store i8 %132, i8* %41, align 1, !tbaa !1296
  %133 = lshr i32 %119, 31
  %134 = trunc i32 %133 to i8
  store i8 %134, i8* %42, align 1, !tbaa !1297
  %135 = lshr i32 %117, 31
  %136 = xor i32 %133, %135
  %137 = add nuw nsw i32 %136, %135
  %138 = icmp eq i32 %137, 2
  %139 = zext i1 %138 to i8
  store i8 %139, i8* %43, align 1, !tbaa !1298
  %140 = load i32, i32* %8, align 4
  %141 = add i32 %117, -8
  %142 = load i32, i32* %13, align 8, !tbaa !1275
  %143 = add i32 %142, %141
  %144 = inttoptr i32 %143 to i32*
  store i32 %140, i32* %144
  %145 = add i32 %117, 36
  %146 = inttoptr i32 %145 to i32*
  %147 = load i32, i32* %146
  %148 = add i32 %117, -12
  %149 = add i32 %142, %148
  %150 = inttoptr i32 %149 to i32*
  store i32 %147, i32* %150
  %151 = add i32 %117, 32
  %152 = inttoptr i32 %151 to i32*
  %153 = load i32, i32* %152
  %154 = add i32 %117, -16
  %155 = add i32 %142, %154
  %156 = inttoptr i32 %155 to i32*
  store i32 %153, i32* %156
  %157 = shl i32 %114, 2
  %158 = add i32 %115, -256
  %159 = add i32 %158, %157
  %160 = add i32 %116, 19
  %161 = add i32 %117, -20
  %162 = add i32 %142, %161
  %163 = inttoptr i32 %162 to i32*
  store i32 %160, i32* %163
  store i32 %161, i32* %7, align 4, !tbaa !1278
  %164 = inttoptr i32 %159 to i32*
  %165 = load i32, i32* %164
  store i32 %165, i32* %9, align 4, !tbaa !1278
  %166 = tail call %struct.Memory* @__remill_function_call(%struct.State* nonnull %0, i32 %165, %struct.Memory* %118)
  %167 = load i32, i32* %6, align 4
  %168 = load i32, i32* %9, align 4
  %169 = add i32 %167, 1
  store i32 %169, i32* %6, align 4, !tbaa !1278
  %170 = load i32, i32* %7, align 4
  %171 = add i32 %170, 16
  %172 = load i32, i32* %5, align 4
  %173 = sub i32 %172, %169
  %174 = icmp eq i32 %173, 0
  %175 = select i1 %174, i32 10, i32 -19
  %176 = add i32 %175, %168
  br i1 %174, label %block_8c5, label %block_8a8.block_8a8_crit_edge

block_8a8.block_8a8_crit_edge:                    ; preds = %block_8a8
  %177 = load i32, i32* %4, align 4
  br label %block_8a8
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_4a8____gmon_start__(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_4a8:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %5 = load i32, i32* %3, align 4
  %6 = add i32 %5, ptrtoint (i32 ()* @__gmon_start__ to i32)
  %7 = inttoptr i32 %6 to i32*
  %8 = load i32, i32* %7
  store i32 %8, i32* %4, align 4, !tbaa !1278
  %9 = icmp eq i32 %8, 1198
  br i1 %9, label %block_4ae, label %11

block_4ae:                                        ; preds = %block_4a8
  %10 = tail call %struct.Memory* @sub_4b0__start(%struct.State* nonnull %0, i32 1200, %struct.Memory* %2)
  ret %struct.Memory* %10

11:                                               ; preds = %block_4a8
  %12 = tail call %struct.Memory* @__remill_jump(%struct.State* nonnull %0, i32 %8, %struct.Memory* %2)
  ret %struct.Memory* %12
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_590___do_global_dtors_aux(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_590:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 15, i32 0, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %7 = load i32, i32* %5, align 4
  %8 = load i32, i32* %4, align 8, !tbaa !1275
  %9 = add i32 %8, -4
  %10 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %11 = load i32, i32* %10, align 8, !tbaa !1275
  %12 = add i32 %11, %9
  %13 = inttoptr i32 %12 to i32*
  store i32 %7, i32* %13
  store i32 %9, i32* %5, align 4, !tbaa !1278
  %14 = load i32, i32* %3, align 4
  %15 = add i32 %8, -8
  %16 = add i32 %11, %15
  %17 = inttoptr i32 %16 to i32*
  store i32 %14, i32* %17
  %18 = add i32 %1, -160
  %19 = add i32 %1, 9
  %20 = add i32 %8, -12
  %21 = add i32 %11, %20
  %22 = inttoptr i32 %21 to i32*
  store i32 %19, i32* %22
  store i32 %20, i32* %4, align 4, !tbaa !1278
  %23 = tail call %struct.Memory* @sub_4f0___x86_get_pc_thunk_bx(%struct.State* nonnull %0, i32 %18, %struct.Memory* %2)
  %24 = load i32, i32* %3, align 4
  %25 = load i32, i32* %6, align 4
  %26 = add i32 %24, 6703
  store i32 %26, i32* %3, align 4, !tbaa !1278
  %27 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  %28 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  %29 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  %30 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  %31 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  %32 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  %33 = load i32, i32* %4, align 4
  %34 = add i32 %33, -4
  %35 = lshr i32 %34, 31
  %36 = add i32 %24, 6771
  %37 = inttoptr i32 %36 to i8*
  %38 = load i8, i8* %37
  store i8 0, i8* %27, align 1, !tbaa !1280
  %39 = zext i8 %38 to i32
  %40 = tail call i32 @llvm.ctpop.i32(i32 %39) #11, !range !1301
  %41 = trunc i32 %40 to i8
  %42 = and i8 %41, 1
  %43 = xor i8 %42, 1
  store i8 %43, i8* %28, align 1, !tbaa !1294
  store i8 0, i8* %29, align 1, !tbaa !1295
  %44 = icmp eq i8 %38, 0
  %45 = zext i1 %44 to i8
  store i8 %45, i8* %30, align 1, !tbaa !1296
  %46 = lshr i8 %38, 7
  store i8 %46, i8* %31, align 1, !tbaa !1297
  store i8 0, i8* %32, align 1, !tbaa !1298
  %47 = select i1 %44, i32 18, i32 57
  %48 = add i32 %47, %25
  br i1 %44, label %block_5ab, label %block_5d2

block_5b5:                                        ; preds = %block_5ab
  %49 = add i32 %33, -16
  %50 = icmp ult i32 %34, 12
  %51 = zext i1 %50 to i8
  store i8 %51, i8* %27, align 1, !tbaa !1280
  %52 = and i32 %49, 255
  %53 = tail call i32 @llvm.ctpop.i32(i32 %52) #11, !range !1301
  %54 = trunc i32 %53 to i8
  %55 = and i8 %54, 1
  %56 = xor i8 %55, 1
  store i8 %56, i8* %28, align 1, !tbaa !1294
  %57 = xor i32 %34, %49
  %58 = lshr i32 %57, 4
  %59 = trunc i32 %58 to i8
  %60 = and i8 %59, 1
  store i8 %60, i8* %29, align 1, !tbaa !1295
  %61 = icmp eq i32 %49, 0
  %62 = zext i1 %61 to i8
  store i8 %62, i8* %30, align 1, !tbaa !1296
  %63 = lshr i32 %49, 31
  %64 = trunc i32 %63 to i8
  store i8 %64, i8* %31, align 1, !tbaa !1297
  %65 = xor i32 %63, %35
  %66 = add nuw nsw i32 %65, %35
  %67 = icmp eq i32 %66, 2
  %68 = zext i1 %67 to i8
  store i8 %68, i8* %32, align 1, !tbaa !1298
  %69 = add i32 %24, 6763
  %70 = inttoptr i32 %69 to i32*
  %71 = load i32, i32* %70
  %72 = add i32 %33, -20
  %73 = load i32, i32* %10, align 8, !tbaa !1275
  %74 = add i32 %73, %72
  %75 = inttoptr i32 %74 to i32*
  store i32 %71, i32* %75
  %76 = add i32 %137, -277
  %77 = add i32 %137, 14
  %78 = add i32 %33, -24
  %79 = add i32 %73, %78
  %80 = inttoptr i32 %79 to i32*
  store i32 %77, i32* %80
  store i32 %78, i32* %4, align 4, !tbaa !1278
  %81 = tail call %struct.Memory* @sub_4a0____cxa_finalize(%struct.State* nonnull %0, i32 %76, %struct.Memory* %23)
  %82 = load i32, i32* %4, align 4
  %83 = load i32, i32* %6, align 4
  %84 = add i32 %83, 3
  %85 = add i32 %82, 16
  %86 = icmp ugt i32 %82, -17
  %87 = icmp ult i32 %85, 16
  %88 = or i1 %86, %87
  %89 = zext i1 %88 to i8
  store i8 %89, i8* %27, align 1, !tbaa !1280
  %90 = and i32 %85, 255
  %91 = tail call i32 @llvm.ctpop.i32(i32 %90) #11, !range !1301
  %92 = trunc i32 %91 to i8
  %93 = and i8 %92, 1
  %94 = xor i8 %93, 1
  store i8 %94, i8* %28, align 1, !tbaa !1294
  %95 = xor i32 %82, 16
  %96 = xor i32 %95, %85
  %97 = lshr i32 %96, 4
  %98 = trunc i32 %97 to i8
  %99 = and i8 %98, 1
  store i8 %99, i8* %29, align 1, !tbaa !1295
  %100 = icmp eq i32 %85, 0
  %101 = zext i1 %100 to i8
  store i8 %101, i8* %30, align 1, !tbaa !1296
  %102 = lshr i32 %85, 31
  %103 = trunc i32 %102 to i8
  store i8 %103, i8* %31, align 1, !tbaa !1297
  %104 = lshr i32 %82, 31
  %105 = xor i32 %102, %104
  %106 = add nuw nsw i32 %105, %102
  %107 = icmp eq i32 %106, 2
  %108 = zext i1 %107 to i8
  store i8 %108, i8* %32, align 1, !tbaa !1298
  br label %block_5c6

block_5d2:                                        ; preds = %block_5c6, %block_590
  %109 = phi %struct.Memory* [ %23, %block_590 ], [ %147, %block_5c6 ]
  %110 = load i32, i32* %5, align 4
  %111 = add i32 %110, -4
  %112 = inttoptr i32 %111 to i32*
  %113 = load i32, i32* %112
  store i32 %113, i32* %3, align 4, !tbaa !1278
  %114 = load i32, i32* %10, align 8, !tbaa !1275
  %115 = add i32 %114, %110
  %116 = inttoptr i32 %115 to i32*
  %117 = load i32, i32* %116
  store i32 %117, i32* %5, align 4, !tbaa !1278
  %118 = add i32 %110, 4
  %119 = add i32 %114, %118
  %120 = inttoptr i32 %119 to i32*
  %121 = load i32, i32* %120
  store i32 %121, i32* %6, align 4, !tbaa !1278
  %122 = add i32 %110, 8
  store i32 %122, i32* %4, align 4, !tbaa !1278
  ret %struct.Memory* %109

block_5ab:                                        ; preds = %block_590
  %123 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0
  %124 = add i32 %24, 6743
  %125 = inttoptr i32 %124 to i32*
  %126 = load i32, i32* %125
  store i32 %126, i32* %123, align 4, !tbaa !1278
  store i8 0, i8* %27, align 1, !tbaa !1280
  %127 = and i32 %126, 255
  %128 = tail call i32 @llvm.ctpop.i32(i32 %127) #11, !range !1301
  %129 = trunc i32 %128 to i8
  %130 = and i8 %129, 1
  %131 = xor i8 %130, 1
  store i8 %131, i8* %28, align 1, !tbaa !1294
  %132 = icmp eq i32 %126, 0
  %133 = zext i1 %132 to i8
  store i8 %133, i8* %30, align 1, !tbaa !1296
  %134 = lshr i32 %126, 31
  %135 = trunc i32 %134 to i8
  store i8 %135, i8* %31, align 1, !tbaa !1297
  store i8 0, i8* %32, align 1, !tbaa !1298
  store i8 0, i8* %29, align 1, !tbaa !1295
  %136 = select i1 %132, i32 27, i32 10
  %137 = add i32 %136, %48
  br i1 %132, label %block_5c6, label %block_5b5

block_5c6:                                        ; preds = %block_5ab, %block_5b5
  %138 = phi i32 [ %34, %block_5ab ], [ %85, %block_5b5 ]
  %139 = phi i32 [ %137, %block_5ab ], [ %84, %block_5b5 ]
  %140 = phi %struct.Memory* [ %23, %block_5ab ], [ %81, %block_5b5 ]
  %141 = add i32 %139, -198
  %142 = add i32 %139, 5
  %143 = add i32 %138, -4
  %144 = load i32, i32* %10, align 8, !tbaa !1275
  %145 = add i32 %144, %143
  %146 = inttoptr i32 %145 to i32*
  store i32 %142, i32* %146
  store i32 %143, i32* %4, align 4, !tbaa !1278
  %147 = tail call %struct.Memory* @sub_500_deregister_tm_clones(%struct.State* nonnull %0, i32 %141, %struct.Memory* %140)
  %148 = load i32, i32* %3, align 4
  %149 = add i32 %148, 68
  %150 = inttoptr i32 %149 to i8*
  store i8 1, i8* %150
  br label %block_5d2
}

; Function Attrs: nofree noinline nounwind
define dso_local %struct.Memory* @sub_4e2(%struct.State* noalias nocapture dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias returned %2) local_unnamed_addr #5 !remill.function.type !1274 {
block_4e2:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %6 = load i32, i32* %4, align 4
  %7 = inttoptr i32 %6 to i32*
  %8 = load i32, i32* %7
  store i32 %8, i32* %3, align 4, !tbaa !1278
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %10 = load i32, i32* %9, align 8, !tbaa !1275
  %11 = add i32 %10, %6
  %12 = inttoptr i32 %11 to i32*
  %13 = load i32, i32* %12
  store i32 %13, i32* %5, align 4, !tbaa !1278
  %14 = add i32 %6, 4
  store i32 %14, i32* %4, align 4, !tbaa !1278
  ret %struct.Memory* %2
}

; Function Attrs: nofree noinline nounwind
define dso_local %struct.Memory* @sub_8d0___libc_csu_fini(%struct.State* noalias nocapture dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias returned %2) local_unnamed_addr #5 !remill.function.type !1274 {
block_8d0:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %5 = load i32, i32* %4, align 8, !tbaa !1275
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %7 = load i32, i32* %6, align 8, !tbaa !1275
  %8 = add i32 %7, %5
  %9 = inttoptr i32 %8 to i32*
  %10 = load i32, i32* %9
  store i32 %10, i32* %3, align 4, !tbaa !1278
  %11 = add i32 %5, 4
  store i32 %11, i32* %4, align 4, !tbaa !1278
  ret %struct.Memory* %2
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_7a5_get_permission(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 !remill.function.tie !1303 {
block_7a5:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 15, i32 0, i32 0
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %8 = load i32, i32* %6, align 4
  %9 = load i32, i32* %5, align 8, !tbaa !1275
  %10 = add i32 %9, -4
  %11 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %12 = load i32, i32* %11, align 8, !tbaa !1275
  %13 = add i32 %12, %10
  %14 = inttoptr i32 %13 to i32*
  store i32 %8, i32* %14
  store i32 %10, i32* %6, align 4, !tbaa !1278
  %15 = load i32, i32* %4, align 4
  %16 = add i32 %9, -8
  %17 = add i32 %12, %16
  %18 = inttoptr i32 %17 to i32*
  store i32 %15, i32* %18
  %19 = add i32 %9, -12
  %20 = icmp ult i32 %16, 4
  %21 = zext i1 %20 to i8
  %22 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  store i8 %21, i8* %22, align 1, !tbaa !1280
  %23 = and i32 %19, 255
  %24 = tail call i32 @llvm.ctpop.i32(i32 %23) #11, !range !1301
  %25 = trunc i32 %24 to i8
  %26 = and i8 %25, 1
  %27 = xor i8 %26, 1
  %28 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  store i8 %27, i8* %28, align 1, !tbaa !1294
  %29 = xor i32 %16, %19
  %30 = lshr i32 %29, 4
  %31 = trunc i32 %30 to i8
  %32 = and i8 %31, 1
  %33 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  store i8 %32, i8* %33, align 1, !tbaa !1295
  %34 = icmp eq i32 %19, 0
  %35 = zext i1 %34 to i8
  %36 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  store i8 %35, i8* %36, align 1, !tbaa !1296
  %37 = lshr i32 %19, 31
  %38 = trunc i32 %37 to i8
  %39 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  store i8 %38, i8* %39, align 1, !tbaa !1297
  %40 = lshr i32 %16, 31
  %41 = xor i32 %37, %40
  %42 = add nuw nsw i32 %41, %40
  %43 = icmp eq i32 %42, 2
  %44 = zext i1 %43 to i8
  %45 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  store i8 %44, i8* %45, align 1, !tbaa !1298
  %46 = add i32 %1, -693
  %47 = add i32 %1, 12
  %48 = add i32 %9, -16
  %49 = add i32 %12, %48
  %50 = inttoptr i32 %49 to i32*
  store i32 %47, i32* %50
  store i32 %48, i32* %5, align 4, !tbaa !1278
  %51 = tail call %struct.Memory* @sub_4f0___x86_get_pc_thunk_bx(%struct.State* nonnull %0, i32 %46, %struct.Memory* %2)
  %52 = load i32, i32* %4, align 4
  %53 = load i32, i32* %7, align 4
  %54 = add i32 %52, 6167
  store i32 %54, i32* %4, align 4, !tbaa !1278
  %55 = load i32, i32* %5, align 4
  %56 = load i32, i32* %6, align 4
  %57 = add i32 %56, 8
  %58 = inttoptr i32 %57 to i32*
  %59 = load i32, i32* %58
  %60 = add i32 %55, -16
  %61 = load i32, i32* %11, align 8, !tbaa !1275
  %62 = add i32 %61, %60
  %63 = inttoptr i32 %62 to i32*
  store i32 %59, i32* %63
  %64 = add i32 %53, 83
  %65 = add i32 %53, 17
  %66 = add i32 %55, -20
  %67 = add i32 %61, %66
  %68 = inttoptr i32 %67 to i32*
  store i32 %65, i32* %68
  store i32 %66, i32* %5, align 4, !tbaa !1278
  %69 = tail call %struct.Memory* @sub_804_change_page_permissions_of_address(%struct.State* nonnull %0, i32 %64, %struct.Memory* %51)
  %70 = load i32, i32* %5, align 4
  %71 = load i32, i32* %7, align 4
  %72 = add i32 %70, 16
  %73 = lshr i32 %72, 31
  %74 = load i32, i32* %3, align 4
  %75 = add i32 %74, 1
  %76 = icmp ne i32 %74, -1
  %77 = zext i1 %76 to i8
  store i8 %77, i8* %22, align 1, !tbaa !1280
  %78 = and i32 %75, 255
  %79 = tail call i32 @llvm.ctpop.i32(i32 %78) #11, !range !1301
  %80 = trunc i32 %79 to i8
  %81 = and i8 %80, 1
  %82 = xor i8 %81, 1
  store i8 %82, i8* %28, align 1, !tbaa !1294
  %83 = xor i32 %74, 16
  %84 = xor i32 %83, %75
  %85 = lshr i32 %84, 4
  %86 = trunc i32 %85 to i8
  %87 = and i8 %86, 1
  store i8 %87, i8* %33, align 1, !tbaa !1295
  %88 = icmp eq i32 %75, 0
  %89 = zext i1 %88 to i8
  store i8 %89, i8* %36, align 1, !tbaa !1296
  %90 = lshr i32 %75, 31
  %91 = trunc i32 %90 to i8
  store i8 %91, i8* %39, align 1, !tbaa !1297
  %92 = lshr i32 %74, 31
  %93 = xor i32 %92, 1
  %94 = xor i32 %90, %92
  %95 = add nuw nsw i32 %94, %93
  %96 = icmp eq i32 %95, 2
  %97 = zext i1 %96 to i8
  store i8 %97, i8* %45, align 1, !tbaa !1298
  %98 = select i1 %88, i32 8, i32 60
  %99 = add i32 %98, %71
  br i1 %88, label %block_7ca, label %block_7fe

block_7fe:                                        ; preds = %block_7a5
  %100 = load i32, i32* %6, align 4
  %101 = add i32 %100, -4
  %102 = inttoptr i32 %101 to i32*
  %103 = load i32, i32* %102
  store i32 %103, i32* %4, align 4, !tbaa !1278
  %104 = load i32, i32* %11, align 8, !tbaa !1275
  %105 = add i32 %104, %100
  %106 = inttoptr i32 %105 to i32*
  %107 = load i32, i32* %106
  store i32 %107, i32* %6, align 4, !tbaa !1278
  %108 = add i32 %100, 4
  %109 = add i32 %104, %108
  %110 = inttoptr i32 %109 to i32*
  %111 = load i32, i32* %110
  store i32 %111, i32* %7, align 4, !tbaa !1278
  %112 = add i32 %100, 8
  store i32 %112, i32* %5, align 4, !tbaa !1278
  ret %struct.Memory* %69

block_7ca:                                        ; preds = %block_7a5
  %113 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0, i32 0
  %114 = load i32, i32* %4, align 4
  %115 = add i32 %114, 64
  %116 = inttoptr i32 %115 to i32*
  %117 = load i32, i32* %116
  store i32 %117, i32* %3, align 4, !tbaa !1278
  %118 = add i32 %70, 4
  %119 = icmp ult i32 %72, 12
  %120 = zext i1 %119 to i8
  store i8 %120, i8* %22, align 1, !tbaa !1280
  %121 = and i32 %118, 255
  %122 = tail call i32 @llvm.ctpop.i32(i32 %121) #11, !range !1301
  %123 = trunc i32 %122 to i8
  %124 = and i8 %123, 1
  %125 = xor i8 %124, 1
  store i8 %125, i8* %28, align 1, !tbaa !1294
  %126 = xor i32 %72, %118
  %127 = lshr i32 %126, 4
  %128 = trunc i32 %127 to i8
  %129 = and i8 %128, 1
  store i8 %129, i8* %33, align 1, !tbaa !1295
  %130 = icmp eq i32 %118, 0
  %131 = zext i1 %130 to i8
  store i8 %131, i8* %36, align 1, !tbaa !1296
  %132 = lshr i32 %118, 31
  %133 = trunc i32 %132 to i8
  store i8 %133, i8* %39, align 1, !tbaa !1297
  %134 = xor i32 %132, %73
  %135 = add nuw nsw i32 %134, %73
  %136 = icmp eq i32 %135, 2
  %137 = zext i1 %136 to i8
  store i8 %137, i8* %45, align 1, !tbaa !1298
  %138 = load i32, i32* %11, align 8, !tbaa !1275
  %139 = add i32 %138, %70
  %140 = inttoptr i32 %139 to i32*
  store i32 %117, i32* %140
  %141 = add i32 %99, -858
  %142 = add i32 %99, 15
  %143 = add i32 %70, -4
  %144 = add i32 %138, %143
  %145 = inttoptr i32 %144 to i32*
  store i32 %142, i32* %145
  store i32 %143, i32* %5, align 4, !tbaa !1278
  %146 = tail call %struct.Memory* @sub_470__strlen(%struct.State* nonnull %0, i32 %141, %struct.Memory* %69)
  %147 = load i32, i32* %5, align 4
  %148 = load i32, i32* %7, align 4
  %149 = add i32 %147, 16
  %150 = lshr i32 %149, 31
  %151 = load i32, i32* %3, align 4
  %152 = add i32 %151, 1
  store i32 %152, i32* %113, align 4, !tbaa !1278
  %153 = load i32, i32* %4, align 4
  %154 = add i32 %153, 64
  %155 = inttoptr i32 %154 to i32*
  %156 = load i32, i32* %155
  store i32 %156, i32* %3, align 4, !tbaa !1278
  %157 = add i32 %147, 12
  %158 = icmp ult i32 %149, 4
  %159 = zext i1 %158 to i8
  store i8 %159, i8* %22, align 1, !tbaa !1280
  %160 = and i32 %157, 255
  %161 = tail call i32 @llvm.ctpop.i32(i32 %160) #11, !range !1301
  %162 = trunc i32 %161 to i8
  %163 = and i8 %162, 1
  %164 = xor i8 %163, 1
  store i8 %164, i8* %28, align 1, !tbaa !1294
  %165 = xor i32 %149, %157
  %166 = lshr i32 %165, 4
  %167 = trunc i32 %166 to i8
  %168 = and i8 %167, 1
  store i8 %168, i8* %33, align 1, !tbaa !1295
  %169 = icmp eq i32 %157, 0
  %170 = zext i1 %169 to i8
  store i8 %170, i8* %36, align 1, !tbaa !1296
  %171 = lshr i32 %157, 31
  %172 = trunc i32 %171 to i8
  store i8 %172, i8* %39, align 1, !tbaa !1297
  %173 = xor i32 %171, %150
  %174 = add nuw nsw i32 %173, %150
  %175 = icmp eq i32 %174, 2
  %176 = zext i1 %175 to i8
  store i8 %176, i8* %45, align 1, !tbaa !1298
  %177 = add i32 %147, 8
  %178 = load i32, i32* %11, align 8, !tbaa !1275
  %179 = add i32 %178, %177
  %180 = inttoptr i32 %179 to i32*
  store i32 %152, i32* %180
  %181 = add i32 %147, 4
  %182 = add i32 %178, %181
  %183 = inttoptr i32 %182 to i32*
  store i32 %156, i32* %183
  %184 = add i32 %178, %147
  %185 = inttoptr i32 %184 to i32*
  store i32 2, i32* %185
  %186 = add i32 %148, -841
  %187 = add i32 %148, 24
  %188 = add i32 %147, -4
  %189 = add i32 %178, %188
  %190 = inttoptr i32 %189 to i32*
  store i32 %187, i32* %190
  store i32 %188, i32* %5, align 4, !tbaa !1278
  %191 = tail call %struct.Memory* @sub_490__write(%struct.State* nonnull %0, i32 %186, %struct.Memory* %146)
  %192 = load i32, i32* %5, align 4
  %193 = load i32, i32* %7, align 4
  %194 = add i32 %192, 16
  %195 = lshr i32 %194, 31
  %196 = add i32 %192, 4
  %197 = icmp ult i32 %194, 12
  %198 = zext i1 %197 to i8
  store i8 %198, i8* %22, align 1, !tbaa !1280
  %199 = and i32 %196, 255
  %200 = tail call i32 @llvm.ctpop.i32(i32 %199) #11, !range !1301
  %201 = trunc i32 %200 to i8
  %202 = and i8 %201, 1
  %203 = xor i8 %202, 1
  store i8 %203, i8* %28, align 1, !tbaa !1294
  %204 = xor i32 %194, %196
  %205 = lshr i32 %204, 4
  %206 = trunc i32 %205 to i8
  %207 = and i8 %206, 1
  store i8 %207, i8* %33, align 1, !tbaa !1295
  %208 = icmp eq i32 %196, 0
  %209 = zext i1 %208 to i8
  store i8 %209, i8* %36, align 1, !tbaa !1296
  %210 = lshr i32 %196, 31
  %211 = trunc i32 %210 to i8
  store i8 %211, i8* %39, align 1, !tbaa !1297
  %212 = xor i32 %210, %195
  %213 = add nuw nsw i32 %212, %195
  %214 = icmp eq i32 %213, 2
  %215 = zext i1 %214 to i8
  store i8 %215, i8* %45, align 1, !tbaa !1298
  %216 = load i32, i32* %11, align 8, !tbaa !1275
  %217 = add i32 %216, %192
  %218 = inttoptr i32 %217 to i32*
  store i32 1, i32* %218
  %219 = add i32 %193, -913
  %220 = add i32 %193, 13
  %221 = add i32 %192, -4
  %222 = add i32 %216, %221
  %223 = inttoptr i32 %222 to i32*
  store i32 %220, i32* %223
  store i32 %221, i32* %5, align 4, !tbaa !1278
  %224 = tail call %struct.Memory* @sub_460__exit(%struct.State* nonnull %0, i32 %219, %struct.Memory* %191)
  %225 = load i32, i32* %7, align 4
  %226 = tail call %struct.Memory* @__remill_error(%struct.State* nonnull %0, i32 %225, %struct.Memory* %224)
  ret %struct.Memory* %226
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_430(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_430:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %5 = load i32, i32* %3, align 4
  %6 = add i32 %5, 4
  %7 = inttoptr i32 %6 to i32*
  %8 = load i32, i32* %7
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %10 = load i32, i32* %9, align 8, !tbaa !1275
  %11 = add i32 %10, -4
  %12 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %13 = load i32, i32* %12, align 8, !tbaa !1275
  %14 = add i32 %13, %11
  %15 = inttoptr i32 %14 to i32*
  store i32 %8, i32* %15
  store i32 %11, i32* %9, align 4, !tbaa !1278
  %16 = add i32 %5, 8
  %17 = inttoptr i32 %16 to i32*
  %18 = load i32, i32* %17
  store i32 %18, i32* %4, align 4, !tbaa !1278
  %19 = icmp eq i32 %18, 1084
  br i1 %19, label %block_43c, label %21

block_43c:                                        ; preds = %block_430
  %20 = tail call %struct.Memory* @__remill_error(%struct.State* nonnull %0, i32 1084, %struct.Memory* %2)
  ret %struct.Memory* %20

21:                                               ; preds = %block_430
  %22 = tail call %struct.Memory* @__remill_jump(%struct.State* nonnull %0, i32 %18, %struct.Memory* %2)
  ret %struct.Memory* %22
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_440__mprotect(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_440:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %4 = load i32, i32* inttoptr (i32 add (i32 ptrtoint (%seg_1fc8__got_type* @seg_1fc8__got to i32), i32 12) to i32*)
  store i32 %4, i32* %3, align 4, !tbaa !1278
  %5 = tail call fastcc %struct.Memory* @ext_2014_mprotect(%struct.State* nonnull %0, %struct.Memory* %2)
  ret %struct.Memory* %5
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_5e0_frame_dummy(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_5e0:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 15, i32 0, i32 0
  %5 = load i32, i32* %4, align 4
  %6 = load i32, i32* %3, align 8, !tbaa !1275
  %7 = add i32 %6, -4
  %8 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %9 = load i32, i32* %8, align 8, !tbaa !1275
  %10 = add i32 %9, %7
  %11 = inttoptr i32 %10 to i32*
  store i32 %5, i32* %11
  store i32 %6, i32* %3, align 4, !tbaa !1278
  %12 = inttoptr i32 %10 to i32*
  %13 = load i32, i32* %12
  store i32 %13, i32* %4, align 4, !tbaa !1278
  %14 = add i32 %1, -160
  %15 = tail call %struct.Memory* @sub_540_register_tm_clones(%struct.State* nonnull %0, i32 %14, %struct.Memory* %2)
  ret %struct.Memory* %15
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_480____libc_start_main(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_480:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %4 = load i32, i32* inttoptr (i32 add (i32 ptrtoint (%seg_1fc8__got_type* @seg_1fc8__got to i32), i32 28) to i32*)
  store i32 %4, i32* %3, align 4, !tbaa !1278
  %5 = tail call fastcc %struct.Memory* @ext_2028___libc_start_main(%struct.State* nonnull %0, %struct.Memory* %2)
  ret %struct.Memory* %5
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_4b0__start(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_4b0:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 5, i32 0, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0, i32 0
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 9, i32 0, i32 0
  %8 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 15, i32 0, i32 0
  %10 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  store i32 0, i32* %9, align 4, !tbaa !1278
  %11 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  %12 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  %13 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  %14 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  %15 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  %16 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  %17 = load i32, i32* %8, align 8, !tbaa !1275
  %18 = add i32 %17, 4
  %19 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %20 = load i32, i32* %19, align 8, !tbaa !1275
  %21 = add i32 %20, %17
  %22 = inttoptr i32 %21 to i32*
  %23 = load i32, i32* %22
  store i32 %23, i32* %7, align 4, !tbaa !1278
  store i32 %18, i32* %5, align 4, !tbaa !1278
  %24 = and i32 %18, -16
  store i8 0, i8* %11, align 1, !tbaa !1280
  %25 = and i32 %18, 240
  %26 = tail call i32 @llvm.ctpop.i32(i32 %25) #11, !range !1301
  %27 = trunc i32 %26 to i8
  %28 = and i8 %27, 1
  %29 = xor i8 %28, 1
  store i8 %29, i8* %12, align 1, !tbaa !1294
  %30 = icmp eq i32 %24, 0
  %31 = zext i1 %30 to i8
  store i8 %31, i8* %13, align 1, !tbaa !1296
  %32 = lshr i32 %18, 31
  %33 = trunc i32 %32 to i8
  store i8 %33, i8* %14, align 1, !tbaa !1297
  store i8 0, i8* %15, align 1, !tbaa !1298
  store i8 0, i8* %16, align 1, !tbaa !1295
  %34 = load i32, i32* %3, align 4
  %35 = add i32 %24, -4
  %36 = add i32 %35, %20
  %37 = inttoptr i32 %36 to i32*
  store i32 %34, i32* %37
  %38 = add i32 %24, -8
  %39 = add i32 %38, %20
  %40 = inttoptr i32 %39 to i32*
  store i32 %35, i32* %40
  %41 = load i32, i32* %6, align 4
  %42 = add i32 %24, -12
  %43 = add i32 %42, %20
  %44 = inttoptr i32 %43 to i32*
  store i32 %41, i32* %44
  %45 = add i32 %1, 50
  %46 = add i32 %1, 16
  %47 = add i32 %24, -16
  %48 = add i32 %47, %20
  %49 = inttoptr i32 %48 to i32*
  store i32 %46, i32* %49
  store i32 %47, i32* %8, align 4, !tbaa !1278
  %50 = tail call %struct.Memory* @sub_4e2(%struct.State* nonnull %0, i32 %45, %struct.Memory* %2)
  %51 = load i32, i32* %4, align 4
  %52 = load i32, i32* %10, align 4
  %53 = add i32 %51, 6920
  store i32 %53, i32* %4, align 4, !tbaa !1278
  %54 = icmp ugt i32 %51, -6921
  %55 = icmp ult i32 %53, 6920
  %56 = or i1 %54, %55
  %57 = zext i1 %56 to i8
  store i8 %57, i8* %11, align 1, !tbaa !1280
  %58 = and i32 %53, 255
  %59 = tail call i32 @llvm.ctpop.i32(i32 %58) #11, !range !1301
  %60 = trunc i32 %59 to i8
  %61 = and i8 %60, 1
  %62 = xor i8 %61, 1
  store i8 %62, i8* %12, align 1, !tbaa !1294
  %63 = xor i32 %53, %51
  %64 = lshr i32 %63, 4
  %65 = trunc i32 %64 to i8
  %66 = and i8 %65, 1
  store i8 %66, i8* %16, align 1, !tbaa !1295
  %67 = icmp eq i32 %53, 0
  %68 = zext i1 %67 to i8
  store i8 %68, i8* %13, align 1, !tbaa !1296
  %69 = lshr i32 %53, 31
  %70 = trunc i32 %69 to i8
  store i8 %70, i8* %14, align 1, !tbaa !1297
  %71 = lshr i32 %51, 31
  %72 = xor i32 %69, %71
  %73 = add nuw nsw i32 %72, %69
  %74 = icmp eq i32 %73, 2
  %75 = zext i1 %74 to i8
  store i8 %75, i8* %15, align 1, !tbaa !1298
  %76 = add i32 %51, 1040
  %77 = load i32, i32* %8, align 8, !tbaa !1275
  %78 = add i32 %77, -4
  %79 = load i32, i32* %19, align 8, !tbaa !1275
  %80 = add i32 %79, %78
  %81 = inttoptr i32 %80 to i32*
  store i32 %76, i32* %81
  %82 = add i32 %51, 944
  store i32 %82, i32* %3, align 4, !tbaa !1278
  %83 = add i32 %77, -8
  %84 = add i32 %79, %83
  %85 = inttoptr i32 %84 to i32*
  store i32 %82, i32* %85
  %86 = load i32, i32* %5, align 4
  %87 = add i32 %77, -12
  %88 = add i32 %79, %87
  %89 = inttoptr i32 %88 to i32*
  store i32 %86, i32* %89
  %90 = load i32, i32* %7, align 4
  %91 = add i32 %77, -16
  %92 = add i32 %79, %91
  %93 = inttoptr i32 %92 to i32*
  store i32 %90, i32* %93
  %94 = add i32 %51, 6968
  %95 = inttoptr i32 %94 to i32*
  %96 = load i32, i32* %95
  %97 = add i32 %77, -20
  %98 = add i32 %79, %97
  %99 = inttoptr i32 %98 to i32*
  store i32 %96, i32* %99
  %100 = add i32 %52, -64
  %101 = add i32 %52, 33
  %102 = add i32 %77, -24
  %103 = add i32 %79, %102
  %104 = inttoptr i32 %103 to i32*
  store i32 %101, i32* %104
  store i32 %102, i32* %8, align 4, !tbaa !1278
  %105 = tail call %struct.Memory* @sub_480____libc_start_main(%struct.State* nonnull %0, i32 %100, %struct.Memory* %50)
  %106 = load i32, i32* %10, align 4
  %107 = tail call %struct.Memory* @__remill_error(%struct.State* nonnull %0, i32 %106, %struct.Memory* %105)
  ret %struct.Memory* %107
}

; Function Attrs: nofree noinline nounwind
define dso_local %struct.Memory* @sub_8d4__term_proc(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #5 !remill.function.type !1274 !remill.function.tie !1304 {
block_8d4:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %6 = load i32, i32* %3, align 4
  %7 = load i32, i32* %4, align 8, !tbaa !1275
  %8 = add i32 %7, -4
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %10 = load i32, i32* %9, align 8, !tbaa !1275
  %11 = add i32 %10, %8
  %12 = inttoptr i32 %11 to i32*
  store i32 %6, i32* %12
  %13 = add i32 %7, -12
  %14 = icmp ult i32 %8, 8
  %15 = zext i1 %14 to i8
  %16 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  store i8 %15, i8* %16, align 1, !tbaa !1280
  %17 = and i32 %13, 255
  %18 = tail call i32 @llvm.ctpop.i32(i32 %17) #11, !range !1301
  %19 = trunc i32 %18 to i8
  %20 = and i8 %19, 1
  %21 = xor i8 %20, 1
  %22 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  store i8 %21, i8* %22, align 1, !tbaa !1294
  %23 = xor i32 %8, %13
  %24 = lshr i32 %23, 4
  %25 = trunc i32 %24 to i8
  %26 = and i8 %25, 1
  %27 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  store i8 %26, i8* %27, align 1, !tbaa !1295
  %28 = icmp eq i32 %13, 0
  %29 = zext i1 %28 to i8
  %30 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  store i8 %29, i8* %30, align 1, !tbaa !1296
  %31 = lshr i32 %13, 31
  %32 = trunc i32 %31 to i8
  %33 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  store i8 %32, i8* %33, align 1, !tbaa !1297
  %34 = lshr i32 %8, 31
  %35 = xor i32 %31, %34
  %36 = add nuw nsw i32 %35, %34
  %37 = icmp eq i32 %36, 2
  %38 = zext i1 %37 to i8
  %39 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  store i8 %38, i8* %39, align 1, !tbaa !1298
  %40 = add i32 %1, -996
  %41 = add i32 %1, 9
  %42 = add i32 %7, -16
  %43 = add i32 %10, %42
  %44 = inttoptr i32 %43 to i32*
  store i32 %41, i32* %44
  store i32 %42, i32* %4, align 4, !tbaa !1278
  %45 = tail call %struct.Memory* @sub_4f0___x86_get_pc_thunk_bx(%struct.State* nonnull %0, i32 %40, %struct.Memory* %2)
  %46 = load i32, i32* %4, align 4
  %47 = add i32 %46, 8
  %48 = icmp ugt i32 %46, -9
  %49 = icmp ult i32 %47, 8
  %50 = or i1 %48, %49
  %51 = zext i1 %50 to i8
  store i8 %51, i8* %16, align 1, !tbaa !1280
  %52 = and i32 %47, 255
  %53 = tail call i32 @llvm.ctpop.i32(i32 %52) #11, !range !1301
  %54 = trunc i32 %53 to i8
  %55 = and i8 %54, 1
  %56 = xor i8 %55, 1
  store i8 %56, i8* %22, align 1, !tbaa !1294
  %57 = xor i32 %47, %46
  %58 = lshr i32 %57, 4
  %59 = trunc i32 %58 to i8
  %60 = and i8 %59, 1
  store i8 %60, i8* %27, align 1, !tbaa !1295
  %61 = icmp eq i32 %47, 0
  %62 = zext i1 %61 to i8
  store i8 %62, i8* %30, align 1, !tbaa !1296
  %63 = lshr i32 %47, 31
  %64 = trunc i32 %63 to i8
  store i8 %64, i8* %33, align 1, !tbaa !1297
  %65 = lshr i32 %46, 31
  %66 = xor i32 %63, %65
  %67 = add nuw nsw i32 %66, %63
  %68 = icmp eq i32 %67, 2
  %69 = zext i1 %68 to i8
  store i8 %69, i8* %39, align 1, !tbaa !1298
  %70 = add i32 %46, 12
  %71 = load i32, i32* %9, align 8, !tbaa !1275
  %72 = add i32 %71, %47
  %73 = inttoptr i32 %72 to i32*
  %74 = load i32, i32* %73
  store i32 %74, i32* %3, align 4, !tbaa !1278
  %75 = add i32 %71, %70
  %76 = inttoptr i32 %75 to i32*
  %77 = load i32, i32* %76
  store i32 %77, i32* %5, align 4, !tbaa !1278
  %78 = add i32 %46, 16
  store i32 %78, i32* %4, align 4, !tbaa !1278
  ret %struct.Memory* %45
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_460__exit(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_460:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %4 = load i32, i32* inttoptr (i32 add (i32 ptrtoint (%seg_1fc8__got_type* @seg_1fc8__got to i32), i32 20) to i32*)
  store i32 %4, i32* %3, align 4, !tbaa !1278
  %5 = tail call fastcc %struct.Memory* @ext_2020_exit(%struct.State* nonnull %0, %struct.Memory* %2)
  ret %struct.Memory* %5
}

; Function Attrs: nofree noinline nounwind
define dso_local %struct.Memory* @sub_5e9___x86_get_pc_thunk_dx(%struct.State* noalias nocapture dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias returned %2) local_unnamed_addr #5 !remill.function.type !1274 !remill.function.tie !1305 {
block_5e9:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %6 = load i32, i32* %4, align 4
  %7 = inttoptr i32 %6 to i32*
  %8 = load i32, i32* %7
  store i32 %8, i32* %3, align 4, !tbaa !1278
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %10 = load i32, i32* %9, align 8, !tbaa !1275
  %11 = add i32 %10, %6
  %12 = inttoptr i32 %11 to i32*
  %13 = load i32, i32* %12
  store i32 %13, i32* %5, align 4, !tbaa !1278
  %14 = add i32 %6, 4
  store i32 %14, i32* %4, align 4, !tbaa !1278
  ret %struct.Memory* %2
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_470__strlen(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_470:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %4 = load i32, i32* inttoptr (i32 add (i32 ptrtoint (%seg_1fc8__got_type* @seg_1fc8__got to i32), i32 24) to i32*)
  store i32 %4, i32* %3, align 4, !tbaa !1278
  %5 = tail call fastcc %struct.Memory* @ext_2024_strlen(%struct.State* nonnull %0, %struct.Memory* %2)
  ret %struct.Memory* %5
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_450__printf(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_450:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %4 = load i32, i32* inttoptr (i32 add (i32 ptrtoint (%seg_1fc8__got_type* @seg_1fc8__got to i32), i32 16) to i32*)
  store i32 %4, i32* %3, align 4, !tbaa !1278
  %5 = tail call fastcc %struct.Memory* @ext_2018_printf(%struct.State* nonnull %0, %struct.Memory* %2)
  ret %struct.Memory* %5
}

; Function Attrs: noinline noreturn nounwind
define dso_local noalias nonnull %struct.Memory* @sub_5ed_main(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #6 !remill.function.type !1274 !remill.function.tie !1306 {
block_5ed:
  %GS_BASE = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 5, i32 0, i32 0, !remill_register !1307
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 5, i32 0, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0, i32 0
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %8 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 15, i32 0, i32 0
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %10 = load i32, i32* %7, align 4
  %11 = add i32 %10, 4
  store i32 %11, i32* %5, align 4, !tbaa !1278
  %12 = and i32 %10, -16
  %13 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  %14 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  %15 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  %16 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  %17 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  %18 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  %19 = inttoptr i32 %10 to i32*
  %20 = load i32, i32* %19
  %21 = add i32 %12, -4
  %22 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %23 = load i32, i32* %22, align 8, !tbaa !1275
  %24 = add i32 %23, %21
  %25 = inttoptr i32 %24 to i32*
  store i32 %20, i32* %25
  %26 = load i32, i32* %8, align 4
  %27 = add i32 %12, -8
  %28 = add i32 %23, %27
  %29 = inttoptr i32 %28 to i32*
  store i32 %26, i32* %29
  store i32 %27, i32* %8, align 4, !tbaa !1278
  %30 = load i32, i32* %4, align 4
  %31 = add i32 %12, -12
  %32 = add i32 %23, %31
  %33 = inttoptr i32 %32 to i32*
  store i32 %30, i32* %33
  %34 = add i32 %12, -16
  %35 = add i32 %23, %34
  %36 = inttoptr i32 %35 to i32*
  store i32 %11, i32* %36
  %37 = add i32 %12, -96
  %38 = icmp ult i32 %34, 80
  %39 = zext i1 %38 to i8
  store i8 %39, i8* %13, align 1, !tbaa !1280
  %40 = and i32 %37, 240
  %41 = tail call i32 @llvm.ctpop.i32(i32 %40) #11, !range !1301
  %42 = trunc i32 %41 to i8
  %43 = and i8 %42, 1
  %44 = xor i8 %43, 1
  store i8 %44, i8* %14, align 1, !tbaa !1294
  %45 = xor i32 %34, 16
  %46 = xor i32 %45, %37
  %47 = lshr exact i32 %46, 4
  %48 = trunc i32 %47 to i8
  %49 = and i8 %48, 1
  store i8 %49, i8* %18, align 1, !tbaa !1295
  %50 = icmp eq i32 %37, 0
  %51 = zext i1 %50 to i8
  store i8 %51, i8* %15, align 1, !tbaa !1296
  %52 = lshr i32 %37, 31
  %53 = trunc i32 %52 to i8
  store i8 %53, i8* %16, align 1, !tbaa !1297
  %54 = lshr i32 %34, 31
  %55 = xor i32 %52, %54
  %56 = add nuw nsw i32 %55, %54
  %57 = icmp eq i32 %56, 2
  %58 = zext i1 %57 to i8
  store i8 %58, i8* %17, align 1, !tbaa !1298
  %59 = add i32 %1, -253
  %60 = add i32 %1, 23
  %61 = add i32 %12, -100
  %62 = add i32 %23, %61
  %63 = inttoptr i32 %62 to i32*
  store i32 %60, i32* %63
  store i32 %61, i32* %7, align 4, !tbaa !1278
  %64 = tail call %struct.Memory* @sub_4f0___x86_get_pc_thunk_bx(%struct.State* nonnull %0, i32 %59, %struct.Memory* %2)
  %65 = load i32, i32* %4, align 4
  %66 = load i32, i32* %9, align 4
  %67 = add i32 %65, 6596
  store i32 %67, i32* %4, align 4, !tbaa !1278
  %68 = load i32, i32* %GS_BASE, align 4
  %69 = add i32 %68, 20
  %70 = inttoptr i32 %69 to i32*
  %71 = load i32, i32* %70
  %72 = load i32, i32* %8, align 4
  %73 = add i32 %72, -12
  %74 = inttoptr i32 %73 to i32*
  store i32 %71, i32* %74
  %75 = add i32 %72, -36
  %76 = inttoptr i32 %75 to i32*
  store i32 22, i32* %76
  %77 = add i32 %72, -32
  %78 = inttoptr i32 %77 to i32*
  store i32 0, i32* %78
  %79 = add i32 %72, -28
  %80 = inttoptr i32 %79 to i32*
  store i32 25, i32* %80
  %81 = add i32 %72, -24
  %82 = inttoptr i32 %81 to i32*
  store i32 7, i32* %82
  %83 = add i32 %72, -20
  %84 = inttoptr i32 %83 to i32*
  store i32 429, i32* %84
  %85 = add i32 %72, -16
  %86 = inttoptr i32 %85 to i32*
  store i32 6, i32* %86
  %87 = add i32 %72, -56
  %88 = inttoptr i32 %87 to i32*
  store i32 0, i32* %88
  %89 = load i32, i32* %7, align 4
  %90 = add i32 %65, -23
  store i32 %90, i32* %3, align 4, !tbaa !1278
  %91 = add i32 %89, -16
  %92 = load i32, i32* %22, align 8, !tbaa !1275
  %93 = add i32 %92, %91
  %94 = inttoptr i32 %93 to i32*
  store i32 %90, i32* %94
  %95 = add i32 %66, 417
  %96 = add i32 %66, 81
  %97 = add i32 %89, -20
  %98 = add i32 %92, %97
  %99 = inttoptr i32 %98 to i32*
  store i32 %96, i32* %99
  store i32 %97, i32* %7, align 4, !tbaa !1278
  %100 = tail call %struct.Memory* @sub_7a5_get_permission(%struct.State* nonnull %0, i32 %95, %struct.Memory* %64)
  %101 = load i32, i32* %7, align 4
  %102 = load i32, i32* %9, align 4
  %103 = add i32 %101, 16
  %104 = load i32, i32* %8, align 4
  %105 = add i32 %104, -52
  %106 = inttoptr i32 %105 to i32*
  store i32 3, i32* %106
  %107 = add i32 %104, -72
  %108 = inttoptr i32 %107 to i32*
  store i32 0, i32* %108
  %109 = load i32, i32* %4, align 4
  %110 = add i32 %109, -6136
  %111 = add i32 %104, -76
  %112 = inttoptr i32 %111 to i32*
  store i32 %110, i32* %112
  %113 = add i32 %109, -6157
  %114 = add i32 %104, -48
  %115 = inttoptr i32 %114 to i32*
  store i32 %113, i32* %115
  %116 = add i32 %104, -68
  %117 = inttoptr i32 %116 to i32*
  store i32 0, i32* %117
  %118 = add i32 %102, 69
  br label %block_69a

block_773:                                        ; preds = %block_771, %block_773
  %119 = phi i32 [ %109, %block_771 ], [ %184, %block_773 ]
  %120 = phi i32 [ %103, %block_771 ], [ %168, %block_773 ]
  %121 = phi i32 [ %346, %block_771 ], [ %183, %block_773 ]
  %122 = phi i32 [ %104, %block_771 ], [ %169, %block_773 ]
  %123 = phi %struct.Memory* [ %238, %block_771 ], [ %165, %block_773 ]
  %124 = add i32 %122, -80
  %125 = inttoptr i32 %124 to i32*
  %126 = load i32, i32* %125
  %127 = add i32 %122, -56
  %128 = inttoptr i32 %127 to i32*
  store i32 %126, i32* %128
  %129 = add i32 %120, -8
  %130 = icmp ult i32 %120, 8
  %131 = zext i1 %130 to i8
  store i8 %131, i8* %13, align 1, !tbaa !1280
  %132 = and i32 %129, 255
  %133 = tail call i32 @llvm.ctpop.i32(i32 %132) #11, !range !1301
  %134 = trunc i32 %133 to i8
  %135 = and i8 %134, 1
  %136 = xor i8 %135, 1
  store i8 %136, i8* %14, align 1, !tbaa !1294
  %137 = xor i32 %129, %120
  %138 = lshr i32 %137, 4
  %139 = trunc i32 %138 to i8
  %140 = and i8 %139, 1
  store i8 %140, i8* %18, align 1, !tbaa !1295
  %141 = icmp eq i32 %129, 0
  %142 = zext i1 %141 to i8
  store i8 %142, i8* %15, align 1, !tbaa !1296
  %143 = lshr i32 %129, 31
  %144 = trunc i32 %143 to i8
  store i8 %144, i8* %16, align 1, !tbaa !1297
  %145 = lshr i32 %120, 31
  %146 = xor i32 %143, %145
  %147 = add nuw nsw i32 %146, %145
  %148 = icmp eq i32 %147, 2
  %149 = zext i1 %148 to i8
  store i8 %149, i8* %17, align 1, !tbaa !1298
  %150 = inttoptr i32 %127 to i32*
  %151 = load i32, i32* %150
  %152 = add i32 %120, -12
  %153 = load i32, i32* %22, align 8, !tbaa !1275
  %154 = add i32 %153, %152
  %155 = inttoptr i32 %154 to i32*
  store i32 %151, i32* %155
  %156 = add i32 %119, -5800
  store i32 %156, i32* %3, align 4, !tbaa !1278
  %157 = add i32 %120, -16
  %158 = add i32 %153, %157
  %159 = inttoptr i32 %158 to i32*
  store i32 %156, i32* %159
  %160 = add i32 %121, -803
  %161 = add i32 %121, 24
  %162 = add i32 %120, -20
  %163 = add i32 %153, %162
  %164 = inttoptr i32 %163 to i32*
  store i32 %161, i32* %164
  store i32 %162, i32* %7, align 4, !tbaa !1278
  %165 = tail call %struct.Memory* @sub_450__printf(%struct.State* nonnull %0, i32 %160, %struct.Memory* %123)
  %166 = load i32, i32* %7, align 4
  %167 = load i32, i32* %9, align 4
  %168 = add i32 %166, 16
  %169 = load i32, i32* %8, align 4
  %170 = add i32 %169, -80
  %171 = inttoptr i32 %170 to i32*
  store i32 0, i32* %171
  %172 = add i32 %169, -36
  %173 = inttoptr i32 %172 to i32*
  %174 = load i32, i32* %173
  store i32 %174, i32* %6, align 4, !tbaa !1278
  %175 = add i32 %169, -24
  %176 = inttoptr i32 %175 to i32*
  %177 = load i32, i32* %176
  %178 = mul i32 %177, %174
  %179 = inttoptr i32 %170 to i32*
  %180 = load i32, i32* %179
  %181 = add i32 %180, %178
  %182 = inttoptr i32 %170 to i32*
  store i32 %181, i32* %182
  %183 = add i32 %167, -24
  %184 = load i32, i32* %4, align 4
  br label %block_773

block_6d7:                                        ; preds = %block_6ac, %block_6be
  %185 = phi i32 [ %331, %block_6ac ], [ %216, %block_6be ]
  %186 = phi %struct.Memory* [ %318, %block_6ac ], [ %186, %block_6be ]
  %187 = inttoptr i32 %353 to i32*
  %188 = load i32, i32* %187
  %189 = add i32 %188, -11
  %190 = icmp eq i32 %189, 0
  %191 = lshr i32 %189, 31
  %192 = lshr i32 %188, 31
  %193 = xor i32 %191, %192
  %194 = add nuw nsw i32 %193, %192
  %195 = icmp eq i32 %194, 2
  %196 = icmp ne i32 %191, 0
  %197 = xor i1 %196, %195
  %198 = or i1 %190, %197
  %199 = select i1 %198, i32 -25, i32 6
  %200 = add i32 %199, %185
  br i1 %198, label %block_6be, label %block_6dd

block_767:                                        ; preds = %block_74f, %block_734
  %201 = phi i32 [ %263, %block_734 ], [ %316, %block_74f ]
  %202 = phi i32 [ %266, %block_734 ], [ %313, %block_74f ]
  %203 = phi %struct.Memory* [ %238, %block_734 ], [ %238, %block_74f ]
  %204 = add i32 %202, 4
  %205 = add i32 %201, 1
  %206 = inttoptr i32 %270 to i32*
  store i32 %205, i32* %206
  br label %block_76b

block_6be:                                        ; preds = %block_6d7
  %207 = inttoptr i32 %352 to i32*
  %208 = load i32, i32* %207
  %209 = add i32 %208, %188
  %210 = inttoptr i32 %111 to i32*
  %211 = load i32, i32* %210
  %212 = add i32 %211, %188
  %213 = inttoptr i32 %209 to i8*
  %214 = load i8, i8* %213
  %215 = inttoptr i32 %212 to i8*
  store i8 %214, i8* %215
  %216 = add i32 %200, 25
  %217 = inttoptr i32 %353 to i32*
  %218 = load i32, i32* %217
  %219 = add i32 %218, 1
  %220 = inttoptr i32 %353 to i32*
  store i32 %219, i32* %220
  br label %block_6d7

block_69a:                                        ; preds = %block_681, %block_5ed
  %221 = phi i32 [ %118, %block_5ed ], [ %341, %block_681 ]
  %222 = phi %struct.Memory* [ %100, %block_5ed ], [ %222, %block_681 ]
  %223 = inttoptr i32 %116 to i32*
  %224 = load i32, i32* %223
  %225 = add i32 %224, -6
  %226 = icmp eq i32 %225, 0
  %227 = lshr i32 %225, 31
  %228 = lshr i32 %224, 31
  %229 = xor i32 %227, %228
  %230 = add nuw nsw i32 %229, %228
  %231 = icmp eq i32 %230, 2
  %232 = icmp ne i32 %227, 0
  %233 = xor i1 %232, %231
  %234 = or i1 %226, %233
  %235 = select i1 %234, i32 -25, i32 6
  %236 = add i32 %235, %221
  br i1 %234, label %block_681, label %block_6a0

block_76b:                                        ; preds = %block_721, %block_767
  %237 = phi i32 [ %272, %block_721 ], [ %204, %block_767 ]
  %238 = phi %struct.Memory* [ %318, %block_721 ], [ %203, %block_767 ]
  %239 = inttoptr i32 %270 to i32*
  %240 = load i32, i32* %239
  %241 = add i32 %240, -1
  %242 = icmp eq i32 %241, 0
  %243 = lshr i32 %241, 31
  %244 = lshr i32 %240, 31
  %245 = xor i32 %243, %244
  %246 = add nuw nsw i32 %245, %244
  %247 = icmp eq i32 %246, 2
  %248 = icmp ne i32 %243, 0
  %249 = xor i1 %248, %247
  %250 = or i1 %242, %249
  %251 = select i1 %250, i32 -55, i32 6
  %252 = add i32 %251, %237
  br i1 %250, label %block_734, label %block_771

block_734:                                        ; preds = %block_76b
  %253 = inttoptr i32 %268 to i32*
  %254 = load i32, i32* %253
  %255 = add i32 %254, %240
  store i32 %240, i32* %5, align 4, !tbaa !1278
  %256 = inttoptr i32 %111 to i32*
  %257 = load i32, i32* %256
  %258 = add i32 %257, %240
  store i32 %258, i32* %6, align 4, !tbaa !1278
  %259 = inttoptr i32 %255 to i8*
  %260 = load i8, i8* %259
  %261 = inttoptr i32 %258 to i8*
  store i8 %260, i8* %261
  %262 = inttoptr i32 %270 to i32*
  %263 = load i32, i32* %262
  %264 = icmp eq i32 %263, 1
  %265 = select i1 %264, i32 27, i32 51
  %266 = add i32 %265, %252
  br i1 %264, label %block_74f, label %block_767

block_721:                                        ; preds = %block_6a4
  %267 = add i32 %327, 19
  %268 = add i32 %104, -40
  %269 = inttoptr i32 %268 to i32*
  store i32 %267, i32* %269
  %270 = add i32 %104, -60
  %271 = inttoptr i32 %270 to i32*
  store i32 0, i32* %271
  %272 = add i32 %325, 74
  br label %block_76b

block_6dd:                                        ; preds = %block_6d7
  %273 = inttoptr i32 %111 to i32*
  %274 = load i32, i32* %273
  %275 = add i32 %274, 2
  %276 = inttoptr i32 %275 to i8*
  %277 = load i8, i8* %276
  %278 = inttoptr i32 %107 to i32*
  %279 = load i32, i32* %278
  %280 = trunc i32 %279 to i8
  %281 = shl i8 %280, 2
  %282 = add i8 %277, %281
  %283 = inttoptr i32 %275 to i8*
  store i8 %282, i8* %283
  %284 = inttoptr i32 %111 to i32*
  %285 = load i32, i32* %284
  %286 = add i32 %285, 5
  %287 = inttoptr i32 %286 to i8*
  %288 = load i8, i8* %287
  %289 = zext i8 %288 to i32
  %290 = inttoptr i32 %107 to i32*
  %291 = load i32, i32* %290
  %292 = shl i32 %291, 2
  store i32 %292, i32* %5, align 4, !tbaa !1278
  %293 = add i32 %292, %289
  store i32 %293, i32* %6, align 4, !tbaa !1278
  %294 = trunc i32 %293 to i8
  %295 = inttoptr i32 %286 to i8*
  store i8 %294, i8* %295
  %296 = inttoptr i32 %111 to i32*
  %297 = load i32, i32* %296
  %298 = add i32 %297, 12
  %299 = inttoptr i32 %111 to i32*
  store i32 %298, i32* %299
  %300 = inttoptr i32 %107 to i32*
  %301 = load i32, i32* %300
  %302 = add i32 %301, 1
  %303 = inttoptr i32 %107 to i32*
  store i32 %302, i32* %303
  %304 = add i32 %200, -57
  br label %block_6a4

block_74f:                                        ; preds = %block_734
  %305 = inttoptr i32 %111 to i32*
  %306 = load i32, i32* %305
  %307 = add i32 %306, 1
  %308 = inttoptr i32 %307 to i8*
  %309 = load i8, i8* %308
  %310 = zext i8 %309 to i32
  store i32 1, i32* %5, align 4, !tbaa !1278
  %311 = add nsw i32 %310, -45
  store i32 %311, i32* %6, align 4, !tbaa !1278
  %312 = trunc i32 %311 to i8
  %313 = add i32 %266, 24
  %314 = inttoptr i32 %307 to i8*
  store i8 %312, i8* %314
  %315 = inttoptr i32 %270 to i32*
  %316 = load i32, i32* %315
  br label %block_767

block_6a4:                                        ; preds = %block_6a0, %block_6dd
  %317 = phi i32 [ %347, %block_6a0 ], [ %304, %block_6dd ]
  %318 = phi %struct.Memory* [ %222, %block_6a0 ], [ %186, %block_6dd ]
  %319 = inttoptr i32 %107 to i32*
  %320 = load i32, i32* %319
  %321 = inttoptr i32 %105 to i32*
  %322 = load i32, i32* %321
  %323 = icmp eq i32 %320, %322
  %324 = select i1 %323, i32 125, i32 8
  %325 = add i32 %324, %317
  %326 = inttoptr i32 %114 to i32*
  %327 = load i32, i32* %326
  br i1 %323, label %block_721, label %block_6ac

block_6ac:                                        ; preds = %block_6a4
  %328 = add i32 %327, 7
  %329 = inttoptr i32 %352 to i32*
  store i32 %328, i32* %329
  %330 = inttoptr i32 %353 to i32*
  store i32 0, i32* %330
  %331 = add i32 %325, 43
  br label %block_6d7

block_681:                                        ; preds = %block_69a
  %332 = inttoptr i32 %114 to i32*
  %333 = load i32, i32* %332
  %334 = add i32 %333, %224
  store i32 %224, i32* %5, align 4, !tbaa !1278
  %335 = inttoptr i32 %111 to i32*
  %336 = load i32, i32* %335
  %337 = add i32 %336, %224
  store i32 %337, i32* %6, align 4, !tbaa !1278
  %338 = inttoptr i32 %334 to i8*
  %339 = load i8, i8* %338
  %340 = inttoptr i32 %337 to i8*
  store i8 %339, i8* %340
  %341 = add i32 %236, 25
  %342 = inttoptr i32 %116 to i32*
  %343 = load i32, i32* %342
  %344 = add i32 %343, 1
  %345 = inttoptr i32 %116 to i32*
  store i32 %344, i32* %345
  br label %block_69a

block_771:                                        ; preds = %block_76b
  %346 = add i32 %252, 2
  br label %block_773

block_6a0:                                        ; preds = %block_69a
  %347 = add i32 %236, 4
  %348 = inttoptr i32 %111 to i32*
  %349 = load i32, i32* %348
  %350 = add i32 %349, 7
  %351 = inttoptr i32 %111 to i32*
  store i32 %350, i32* %351
  %352 = add i32 %104, -44
  %353 = add i32 %104, -64
  br label %block_6a4
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_804_change_page_permissions_of_address(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 !remill.function.tie !1308 {
block_804:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 5, i32 0, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0, i32 0
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %8 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 15, i32 0, i32 0
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %10 = load i32, i32* %8, align 4
  %11 = load i32, i32* %7, align 8, !tbaa !1275
  %12 = add i32 %11, -4
  %13 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %14 = load i32, i32* %13, align 8, !tbaa !1275
  %15 = add i32 %14, %12
  %16 = inttoptr i32 %15 to i32*
  store i32 %10, i32* %16
  store i32 %12, i32* %8, align 4, !tbaa !1278
  %17 = load i32, i32* %4, align 4
  %18 = add i32 %11, -8
  %19 = add i32 %14, %18
  %20 = inttoptr i32 %19 to i32*
  store i32 %17, i32* %20
  %21 = add i32 %11, -28
  %22 = icmp ult i32 %18, 20
  %23 = zext i1 %22 to i8
  %24 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  store i8 %23, i8* %24, align 1, !tbaa !1280
  %25 = and i32 %21, 255
  %26 = tail call i32 @llvm.ctpop.i32(i32 %25) #11, !range !1301
  %27 = trunc i32 %26 to i8
  %28 = and i8 %27, 1
  %29 = xor i8 %28, 1
  %30 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  store i8 %29, i8* %30, align 1, !tbaa !1294
  %31 = xor i32 %18, 16
  %32 = xor i32 %31, %21
  %33 = lshr i32 %32, 4
  %34 = trunc i32 %33 to i8
  %35 = and i8 %34, 1
  %36 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  store i8 %35, i8* %36, align 1, !tbaa !1295
  %37 = icmp eq i32 %21, 0
  %38 = zext i1 %37 to i8
  %39 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  store i8 %38, i8* %39, align 1, !tbaa !1296
  %40 = lshr i32 %21, 31
  %41 = trunc i32 %40 to i8
  %42 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  store i8 %41, i8* %42, align 1, !tbaa !1297
  %43 = lshr i32 %18, 31
  %44 = xor i32 %40, %43
  %45 = add nuw nsw i32 %44, %43
  %46 = icmp eq i32 %45, 2
  %47 = zext i1 %46 to i8
  %48 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  store i8 %47, i8* %48, align 1, !tbaa !1298
  %49 = add i32 %1, 89
  %50 = add i32 %1, 12
  %51 = add i32 %11, -32
  %52 = add i32 %14, %51
  %53 = inttoptr i32 %52 to i32*
  store i32 %50, i32* %53
  store i32 %51, i32* %7, align 4, !tbaa !1278
  %54 = tail call %struct.Memory* @sub_85d___x86_get_pc_thunk_cx(%struct.State* nonnull %0, i32 %49, %struct.Memory* %2)
  %55 = load i32, i32* %5, align 4
  %56 = load i32, i32* %9, align 4
  %57 = add i32 %55, 6072
  store i32 %57, i32* %5, align 4, !tbaa !1278
  %58 = load i32, i32* %8, align 4
  %59 = add i32 %58, -12
  %60 = inttoptr i32 %59 to i32*
  store i32 4096, i32* %60
  %61 = add i32 %58, 8
  %62 = inttoptr i32 %61 to i32*
  %63 = load i32, i32* %62
  %64 = inttoptr i32 %59 to i32*
  %65 = load i32, i32* %64
  %66 = urem i32 %63, %65
  store i32 %66, i32* %6, align 4, !tbaa !1278
  %67 = sub i32 %63, %66
  %68 = inttoptr i32 %61 to i32*
  store i32 %67, i32* %68
  %69 = inttoptr i32 %59 to i32*
  %70 = load i32, i32* %69
  store i32 %70, i32* %3, align 4, !tbaa !1278
  %71 = load i32, i32* %7, align 4
  %72 = add i32 %71, -4
  %73 = icmp ult i32 %71, 4
  %74 = zext i1 %73 to i8
  store i8 %74, i8* %24, align 1, !tbaa !1280
  %75 = and i32 %72, 255
  %76 = tail call i32 @llvm.ctpop.i32(i32 %75) #11, !range !1301
  %77 = trunc i32 %76 to i8
  %78 = and i8 %77, 1
  %79 = xor i8 %78, 1
  store i8 %79, i8* %30, align 1, !tbaa !1294
  %80 = xor i32 %72, %71
  %81 = lshr i32 %80, 4
  %82 = trunc i32 %81 to i8
  %83 = and i8 %82, 1
  store i8 %83, i8* %36, align 1, !tbaa !1295
  %84 = icmp eq i32 %72, 0
  %85 = zext i1 %84 to i8
  store i8 %85, i8* %39, align 1, !tbaa !1296
  %86 = lshr i32 %72, 31
  %87 = trunc i32 %86 to i8
  store i8 %87, i8* %42, align 1, !tbaa !1297
  %88 = lshr i32 %71, 31
  %89 = xor i32 %86, %88
  %90 = add nuw nsw i32 %89, %88
  %91 = icmp eq i32 %90, 2
  %92 = zext i1 %91 to i8
  store i8 %92, i8* %48, align 1, !tbaa !1298
  %93 = add i32 %71, -8
  %94 = load i32, i32* %13, align 8, !tbaa !1275
  %95 = add i32 %94, %93
  %96 = inttoptr i32 %95 to i32*
  store i32 7, i32* %96
  %97 = add i32 %71, -12
  %98 = add i32 %94, %97
  %99 = inttoptr i32 %98 to i32*
  store i32 %70, i32* %99
  %100 = inttoptr i32 %61 to i32*
  %101 = load i32, i32* %100
  %102 = add i32 %71, -16
  %103 = add i32 %94, %102
  %104 = inttoptr i32 %103 to i32*
  store i32 %101, i32* %104
  store i32 %57, i32* %4, align 4, !tbaa !1278
  %105 = add i32 %56, -976
  %106 = add i32 %56, 52
  %107 = add i32 %71, -20
  %108 = add i32 %94, %107
  %109 = inttoptr i32 %108 to i32*
  store i32 %106, i32* %109
  store i32 %107, i32* %7, align 4, !tbaa !1278
  %110 = tail call %struct.Memory* @sub_440__mprotect(%struct.State* nonnull %0, i32 %105, %struct.Memory* %54)
  %111 = load i32, i32* %3, align 4
  %112 = add i32 %111, 1
  %113 = icmp ne i32 %111, -1
  %114 = zext i1 %113 to i8
  store i8 %114, i8* %24, align 1, !tbaa !1280
  %115 = and i32 %112, 255
  %116 = tail call i32 @llvm.ctpop.i32(i32 %115) #11, !range !1301
  %117 = trunc i32 %116 to i8
  %118 = and i8 %117, 1
  %119 = xor i8 %118, 1
  store i8 %119, i8* %30, align 1, !tbaa !1294
  %120 = xor i32 %111, 16
  %121 = xor i32 %120, %112
  %122 = lshr i32 %121, 4
  %123 = trunc i32 %122 to i8
  %124 = and i8 %123, 1
  store i8 %124, i8* %36, align 1, !tbaa !1295
  %125 = icmp eq i32 %112, 0
  %126 = zext i1 %125 to i8
  store i8 %126, i8* %39, align 1, !tbaa !1296
  %127 = lshr i32 %112, 31
  %128 = trunc i32 %127 to i8
  store i8 %128, i8* %42, align 1, !tbaa !1297
  %129 = lshr i32 %111, 31
  %130 = xor i32 %129, 1
  %131 = xor i32 %127, %129
  %132 = add nuw nsw i32 %131, %130
  %133 = icmp eq i32 %132, 2
  %134 = zext i1 %133 to i8
  store i8 %134, i8* %48, align 1, !tbaa !1298
  br i1 %125, label %block_84c, label %block_853

block_84c:                                        ; preds = %block_804
  store i32 -1, i32* %3, align 4, !tbaa !1278
  br label %block_858

block_853:                                        ; preds = %block_804
  store i32 0, i32* %3, align 4, !tbaa !1278
  br label %block_858

block_858:                                        ; preds = %block_853, %block_84c
  %135 = load i32, i32* %8, align 4
  %136 = add i32 %135, -4
  %137 = inttoptr i32 %136 to i32*
  %138 = load i32, i32* %137
  store i32 %138, i32* %4, align 4, !tbaa !1278
  %139 = load i32, i32* %13, align 8, !tbaa !1275
  %140 = add i32 %139, %135
  %141 = inttoptr i32 %140 to i32*
  %142 = load i32, i32* %141
  store i32 %142, i32* %8, align 4, !tbaa !1278
  %143 = add i32 %135, 4
  %144 = add i32 %139, %143
  %145 = inttoptr i32 %144 to i32*
  %146 = load i32, i32* %145
  store i32 %146, i32* %9, align 4, !tbaa !1278
  %147 = add i32 %135, 8
  store i32 %147, i32* %7, align 4, !tbaa !1278
  ret %struct.Memory* %110
}

; Function Attrs: noinline nounwind
define dso_local %struct.Memory* @sub_540_register_tm_clones(%struct.State* noalias dereferenceable(3376) %0, i32 %1, %struct.Memory* noalias %2) local_unnamed_addr #4 !remill.function.type !1274 {
block_582:
  %3 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 1, i32 0, i32 0
  %4 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 3, i32 0, i32 0
  %5 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 5, i32 0, i32 0
  %6 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 7, i32 0, i32 0
  %7 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 13, i32 0, i32 0
  %8 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 15, i32 0, i32 0
  %9 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 6, i32 33, i32 0, i32 0
  %10 = add i32 %1, 169
  %11 = add i32 %1, 5
  %12 = load i32, i32* %7, align 8, !tbaa !1275
  %13 = add i32 %12, -4
  %14 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 5, i32 1, i32 0, i32 0
  %15 = load i32, i32* %14, align 8, !tbaa !1275
  %16 = add i32 %15, %13
  %17 = inttoptr i32 %16 to i32*
  store i32 %11, i32* %17
  store i32 %13, i32* %7, align 4, !tbaa !1278
  %18 = tail call %struct.Memory* @sub_5e9___x86_get_pc_thunk_dx(%struct.State* nonnull %0, i32 %10, %struct.Memory* %2)
  %19 = load i32, i32* %6, align 4
  %20 = add i32 %19, 6787
  store i32 %20, i32* %6, align 4, !tbaa !1278
  %21 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 1
  %22 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 3
  %23 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 5
  %24 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 7
  %25 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 9
  %26 = getelementptr inbounds %struct.State, %struct.State* %0, i32 0, i32 2, i32 13
  %27 = load i32, i32* %8, align 4
  %28 = load i32, i32* %7, align 8, !tbaa !1275
  %29 = add i32 %28, -4
  %30 = load i32, i32* %14, align 8, !tbaa !1275
  %31 = add i32 %30, %29
  %32 = inttoptr i32 %31 to i32*
  store i32 %27, i32* %32
  %33 = add i32 %19, 6855
  store i32 %33, i32* %5, align 4, !tbaa !1278
  %34 = load i32, i32* %4, align 4
  %35 = add i32 %28, -8
  %36 = add i32 %30, %35
  %37 = inttoptr i32 %36 to i32*
  store i32 %34, i32* %37
  store i32 0, i32* %3, align 4, !tbaa !1278
  store i8 0, i8* %21, align 1, !tbaa !1275
  store i8 1, i8* %22, align 1, !tbaa !1275
  store i8 0, i8* %23, align 1, !tbaa !1275
  store i8 1, i8* %24, align 1, !tbaa !1275
  store i8 0, i8* %25, align 1, !tbaa !1275
  store i8 0, i8* %26, align 1, !tbaa !1275
  %38 = add i32 %28, -8
  %39 = inttoptr i32 %38 to i32*
  %40 = load i32, i32* %39
  store i32 %40, i32* %4, align 4, !tbaa !1278
  %41 = load i32, i32* %14, align 8, !tbaa !1275
  %42 = add i32 %41, %29
  %43 = inttoptr i32 %42 to i32*
  %44 = load i32, i32* %43
  store i32 %44, i32* %8, align 4, !tbaa !1278
  %45 = add i32 %41, %28
  %46 = inttoptr i32 %45 to i32*
  %47 = load i32, i32* %46
  store i32 %47, i32* %9, align 4, !tbaa !1278
  %48 = add i32 %28, 4
  store i32 %48, i32* %7, align 4, !tbaa !1278
  ret %struct.Memory* %18
}

; Function Attrs: noinline
declare !remill.function.type !1309 void @__mcsema_attach_call() #3

; Function Attrs: naked nobuiltin noinline nounwind
define dso_local dllexport void @main() #7 !remill.function.type !1310 !remill.function.tie !1311 {
  tail call void asm sideeffect "pushl $0;pushl $$0x5ed;jmpl *$1;", "*m,*m,~{dirflag},~{fpsr},~{flags}"(%struct.Memory* (%struct.State*, i32, %struct.Memory*)** nonnull @2, void ()** nonnull @1) #11
  ret void
}

; Function Attrs: noreturn nounwind
define internal noalias nonnull %struct.Memory* @main_wrapper(%struct.State* %0, i32 %1, %struct.Memory* %2) #8 {
  %4 = load volatile i1, i1* @0, align 1
  br i1 %4, label %__mcsema_early_init.exit, label %5

5:                                                ; preds = %3
  store volatile i1 true, i1* @0, align 1
  br label %__mcsema_early_init.exit

__mcsema_early_init.exit:                         ; preds = %5, %3
  %6 = tail call %struct.Memory* @sub_5ed_main(%struct.State* %0, i32 %1, %struct.Memory* %2)
  unreachable
}

; Function Attrs: noinline nounwind
define internal fastcc %struct.Memory* @ext_202c_write(%struct.State* %0, %struct.Memory* %1) unnamed_addr #9 {
  %3 = tail call %struct.Memory* @__remill_function_call(%struct.State* %0, i32 ptrtoint (i32 (i32, i32, i32)* @write to i32), %struct.Memory* %1)
  ret %struct.Memory* %3
}

; Function Attrs: noinline nounwind
define internal fastcc %struct.Memory* @ext_2014_mprotect(%struct.State* %0, %struct.Memory* %1) unnamed_addr #9 {
  %3 = tail call %struct.Memory* @__remill_function_call(%struct.State* %0, i32 ptrtoint (i32 (i32, i32, i32)* @mprotect to i32), %struct.Memory* %1)
  ret %struct.Memory* %3
}

; Function Attrs: noinline nounwind
define internal fastcc %struct.Memory* @ext_2028___libc_start_main(%struct.State* %0, %struct.Memory* %1) unnamed_addr #9 {
  %3 = tail call %struct.Memory* @__remill_function_call(%struct.State* %0, i32 ptrtoint (i32 (i32, i32, i32, i32, i32, i32, i32, i32)* @__libc_start_main to i32), %struct.Memory* %1)
  ret %struct.Memory* %3
}

; Function Attrs: noinline nounwind
define internal fastcc %struct.Memory* @ext_2020_exit(%struct.State* %0, %struct.Memory* %1) unnamed_addr #9 {
  %3 = tail call %struct.Memory* @__remill_function_call(%struct.State* %0, i32 ptrtoint (i32 (i32)* @exit to i32), %struct.Memory* %1)
  ret %struct.Memory* %3
}

; Function Attrs: noinline nounwind
define internal fastcc %struct.Memory* @ext_2024_strlen(%struct.State* %0, %struct.Memory* %1) unnamed_addr #9 {
  %3 = tail call %struct.Memory* @__remill_function_call(%struct.State* %0, i32 ptrtoint (i32 (i32)* @strlen to i32), %struct.Memory* %1)
  ret %struct.Memory* %3
}

; Function Attrs: noinline nounwind
define internal fastcc %struct.Memory* @ext_2018_printf(%struct.State* %0, %struct.Memory* %1) unnamed_addr #9 {
  %3 = tail call %struct.Memory* @__remill_function_call(%struct.State* %0, i32 ptrtoint (i32 (i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32)* @printf to i32), %struct.Memory* %1)
  ret %struct.Memory* %3
}

; Function Attrs: naked nobuiltin noinline nounwind
define dso_local dllexport void @__x86.get_pc_thunk.dx() #7 !remill.function.type !1310 !remill.function.tie !1312 {
  tail call void asm sideeffect "pushl $0;pushl $$0x5e9;jmpl *$1;", "*m,*m,~{dirflag},~{fpsr},~{flags}"(%struct.Memory* (%struct.State*, i32, %struct.Memory*)** nonnull @3, void ()** nonnull @1) #11
  ret void
}

; Function Attrs: nofree nounwind
define internal %struct.Memory* @__x86.get_pc_thunk.dx_wrapper(%struct.State* nocapture %0, i32 %1, %struct.Memory* returned %2) #10 {
  %4 = load volatile i1, i1* @0, align 1
  br i1 %4, label %__mcsema_early_init.exit, label %5

5:                                                ; preds = %3
  store volatile i1 true, i1* @0, align 1
  br label %__mcsema_early_init.exit

__mcsema_early_init.exit:                         ; preds = %5, %3
  %6 = tail call %struct.Memory* @sub_5e9___x86_get_pc_thunk_dx(%struct.State* %0, i32 %1, %struct.Memory* %2)
  ret %struct.Memory* %6
}

; Function Attrs: naked nobuiltin noinline nounwind
define dso_local dllexport void @change_page_permissions_of_address() #7 !remill.function.type !1310 !remill.function.tie !1313 {
  tail call void asm sideeffect "pushl $0;pushl $$0x804;jmpl *$1;", "*m,*m,~{dirflag},~{fpsr},~{flags}"(%struct.Memory* (%struct.State*, i32, %struct.Memory*)** nonnull @4, void ()** nonnull @1) #11
  ret void
}

; Function Attrs: nounwind
define internal %struct.Memory* @change_page_permissions_of_address_wrapper(%struct.State* %0, i32 %1, %struct.Memory* %2) #11 {
  %4 = load volatile i1, i1* @0, align 1
  br i1 %4, label %__mcsema_early_init.exit, label %5

5:                                                ; preds = %3
  store volatile i1 true, i1* @0, align 1
  br label %__mcsema_early_init.exit

__mcsema_early_init.exit:                         ; preds = %5, %3
  %6 = tail call %struct.Memory* @sub_804_change_page_permissions_of_address(%struct.State* %0, i32 %1, %struct.Memory* %2)
  ret %struct.Memory* %6
}

; Function Attrs: naked nobuiltin noinline nounwind
define dso_local dllexport void @.init_proc() #7 !remill.function.type !1310 !remill.function.tie !1314 {
  tail call void asm sideeffect "pushl $0;pushl $$0x404;jmpl *$1;", "*m,*m,~{dirflag},~{fpsr},~{flags}"(%struct.Memory* (%struct.State*, i32, %struct.Memory*)** nonnull @5, void ()** nonnull @1) #11
  ret void
}

; Function Attrs: nounwind
define internal %struct.Memory* @.init_proc_wrapper(%struct.State* %0, i32 %1, %struct.Memory* %2) #11 {
  %4 = load volatile i1, i1* @0, align 1
  br i1 %4, label %__mcsema_early_init.exit, label %5

5:                                                ; preds = %3
  store volatile i1 true, i1* @0, align 1
  br label %__mcsema_early_init.exit

__mcsema_early_init.exit:                         ; preds = %5, %3
  %6 = tail call %struct.Memory* @sub_404__init_proc(%struct.State* %0, i32 %1, %struct.Memory* %2)
  ret %struct.Memory* %6
}

; Function Attrs: naked nobuiltin noinline nounwind
define dso_local dllexport void @.term_proc() #7 !remill.function.type !1310 !remill.function.tie !1315 {
  tail call void asm sideeffect "pushl $0;pushl $$0x8d4;jmpl *$1;", "*m,*m,~{dirflag},~{fpsr},~{flags}"(%struct.Memory* (%struct.State*, i32, %struct.Memory*)** nonnull @6, void ()** nonnull @1) #11
  ret void
}

; Function Attrs: nofree nounwind
define internal %struct.Memory* @.term_proc_wrapper(%struct.State* %0, i32 %1, %struct.Memory* %2) #10 {
  %4 = load volatile i1, i1* @0, align 1
  br i1 %4, label %__mcsema_early_init.exit, label %5

5:                                                ; preds = %3
  store volatile i1 true, i1* @0, align 1
  br label %__mcsema_early_init.exit

__mcsema_early_init.exit:                         ; preds = %5, %3
  %6 = tail call %struct.Memory* @sub_8d4__term_proc(%struct.State* %0, i32 %1, %struct.Memory* %2)
  ret %struct.Memory* %6
}

; Function Attrs: naked nobuiltin noinline nounwind
define dso_local dllexport void @__x86.get_pc_thunk.cx() #7 !remill.function.type !1310 !remill.function.tie !1316 {
  tail call void asm sideeffect "pushl $0;pushl $$0x85d;jmpl *$1;", "*m,*m,~{dirflag},~{fpsr},~{flags}"(%struct.Memory* (%struct.State*, i32, %struct.Memory*)** nonnull @7, void ()** nonnull @1) #11
  ret void
}

; Function Attrs: nofree nounwind
define internal %struct.Memory* @__x86.get_pc_thunk.cx_wrapper(%struct.State* nocapture %0, i32 %1, %struct.Memory* returned %2) #10 {
  %4 = load volatile i1, i1* @0, align 1
  br i1 %4, label %__mcsema_early_init.exit, label %5

5:                                                ; preds = %3
  store volatile i1 true, i1* @0, align 1
  br label %__mcsema_early_init.exit

__mcsema_early_init.exit:                         ; preds = %5, %3
  %6 = tail call %struct.Memory* @sub_85d___x86_get_pc_thunk_cx(%struct.State* %0, i32 %1, %struct.Memory* %2)
  ret %struct.Memory* %6
}

; Function Attrs: naked nobuiltin noinline nounwind
define dso_local dllexport void @__x86.get_pc_thunk.bx() #7 !remill.function.type !1310 !remill.function.tie !1317 {
  tail call void asm sideeffect "pushl $0;pushl $$0x4f0;jmpl *$1;", "*m,*m,~{dirflag},~{fpsr},~{flags}"(%struct.Memory* (%struct.State*, i32, %struct.Memory*)** nonnull @8, void ()** nonnull @1) #11
  ret void
}

; Function Attrs: nofree nounwind
define internal %struct.Memory* @__x86.get_pc_thunk.bx_wrapper(%struct.State* nocapture %0, i32 %1, %struct.Memory* returned %2) #10 {
  %4 = load volatile i1, i1* @0, align 1
  br i1 %4, label %__mcsema_early_init.exit, label %5

5:                                                ; preds = %3
  store volatile i1 true, i1* @0, align 1
  br label %__mcsema_early_init.exit

__mcsema_early_init.exit:                         ; preds = %5, %3
  %6 = tail call %struct.Memory* @sub_4f0___x86_get_pc_thunk_bx(%struct.State* %0, i32 %1, %struct.Memory* %2)
  ret %struct.Memory* %6
}

; Function Attrs: naked nobuiltin noinline nounwind
define dso_local dllexport void @get_permission() #7 !remill.function.type !1310 !remill.function.tie !1318 {
  tail call void asm sideeffect "pushl $0;pushl $$0x7a5;jmpl *$1;", "*m,*m,~{dirflag},~{fpsr},~{flags}"(%struct.Memory* (%struct.State*, i32, %struct.Memory*)** nonnull @9, void ()** nonnull @1) #11
  ret void
}

; Function Attrs: nounwind
define internal %struct.Memory* @get_permission_wrapper(%struct.State* %0, i32 %1, %struct.Memory* %2) #11 {
  %4 = load volatile i1, i1* @0, align 1
  br i1 %4, label %__mcsema_early_init.exit, label %5

5:                                                ; preds = %3
  store volatile i1 true, i1* @0, align 1
  br label %__mcsema_early_init.exit

__mcsema_early_init.exit:                         ; preds = %5, %3
  %6 = tail call %struct.Memory* @sub_7a5_get_permission(%struct.State* %0, i32 %1, %struct.Memory* %2)
  ret %struct.Memory* %6
}

; Function Attrs: naked nobuiltin noinline nounwind
define internal void @callback_sub_870___libc_csu_init() #7 {
  tail call void asm sideeffect "pushl $0;pushl $$0x870;jmpl *$1;", "*m,*m,~{dirflag},~{fpsr},~{flags}"(%struct.Memory* (%struct.State*, i32, %struct.Memory*)** nonnull @10, void ()** nonnull @1) #11
  ret void
}

; Function Attrs: nounwind
define internal %struct.Memory* @callback_sub_870___libc_csu_init_wrapper(%struct.State* %0, i32 %1, %struct.Memory* %2) #11 {
  %4 = load volatile i1, i1* @0, align 1
  br i1 %4, label %__mcsema_early_init.exit, label %5

5:                                                ; preds = %3
  store volatile i1 true, i1* @0, align 1
  br label %__mcsema_early_init.exit

__mcsema_early_init.exit:                         ; preds = %5, %3
  %6 = tail call %struct.Memory* @sub_870___libc_csu_init(%struct.State* %0, i32 %1, %struct.Memory* %2)
  ret %struct.Memory* %6
}

; Function Attrs: nounwind
define internal void @__mcsema_constructor() #11 {
  %1 = load volatile i1, i1* @0, align 1
  br i1 %1, label %__mcsema_early_init.exit, label %2

2:                                                ; preds = %0
  store volatile i1 true, i1* @0, align 1
  br label %__mcsema_early_init.exit

__mcsema_early_init.exit:                         ; preds = %2, %0
  tail call void @callback_sub_870___libc_csu_init()
  ret void
}

; Function Attrs: naked nobuiltin noinline nounwind
define internal void @callback_sub_8d0___libc_csu_fini() #7 {
  tail call void asm sideeffect "pushl $0;pushl $$0x8d0;jmpl *$1;", "*m,*m,~{dirflag},~{fpsr},~{flags}"(%struct.Memory* (%struct.State*, i32, %struct.Memory*)** nonnull @11, void ()** nonnull @1) #11
  ret void
}

; Function Attrs: nofree nounwind
define internal %struct.Memory* @callback_sub_8d0___libc_csu_fini_wrapper(%struct.State* nocapture %0, i32 %1, %struct.Memory* returned %2) #10 {
  %4 = load volatile i1, i1* @0, align 1
  br i1 %4, label %__mcsema_early_init.exit, label %5

5:                                                ; preds = %3
  store volatile i1 true, i1* @0, align 1
  br label %__mcsema_early_init.exit

__mcsema_early_init.exit:                         ; preds = %5, %3
  %6 = tail call %struct.Memory* @sub_8d0___libc_csu_fini(%struct.State* %0, i32 %1, %struct.Memory* %2)
  ret %struct.Memory* %6
}

; Function Attrs: nounwind
define internal void @__mcsema_destructor() #11 {
  tail call void @callback_sub_8d0___libc_csu_fini()
  ret void
}

attributes #0 = { nounwind readnone speculatable willreturn }
attributes #1 = { noduplicate noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noduplicate noinline nounwind optnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline }
attributes #4 = { noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nofree noinline nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noinline noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { naked nobuiltin noinline nounwind }
attributes #8 = { noreturn nounwind }
attributes #9 = { noinline nounwind }
attributes #10 = { nofree nounwind }
attributes #11 = { nounwind }

!llvm.ident = !{!0, !0}
!llvm.module.flags = !{!1, !2, !3}
!llvm.dbg.cu = !{!4}

!0 = !{!"clang version 9.0.0 (tags/RELEASE_900/final)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 2, !"Dwarf Version", i32 4}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !5, producer: "clang version 9.0.0 (tags/RELEASE_900/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !6, retainedTypes: !70, imports: !73, nameTableKind: None)
!5 = !DIFile(filename: "/home/work/remill/remill/Arch/X86/Runtime/BasicBlock.cpp", directory: "/home/work/remill/remill-build/remill/Arch/X86/Runtime")
!6 = !{!7, !29, !38, !42, !48, !54, !58, !64}
!7 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "Name", scope: !9, file: !8, line: 68, baseType: !11, size: 32, elements: !14, identifier: "_ZTSN14AsyncHyperCall4NameE")
!8 = !DIFile(filename: "remill/Arch/Runtime/HyperCall.h", directory: "/home/work/remill")
!9 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "AsyncHyperCall", file: !8, line: 66, size: 8, flags: DIFlagTypePassByValue, elements: !10, identifier: "_ZTS14AsyncHyperCall")
!10 = !{}
!11 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !12, line: 172, baseType: !13)
!12 = !DIFile(filename: "libraries/llvm/lib/clang/9.0.0/include/stdint.h", directory: "/home/work/remill/remill-build")
!13 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!14 = !{!15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28}
!15 = !DIEnumerator(name: "kInvalid", value: 0, isUnsigned: true)
!16 = !DIEnumerator(name: "kX86Int1", value: 1, isUnsigned: true)
!17 = !DIEnumerator(name: "kX86Int3", value: 2, isUnsigned: true)
!18 = !DIEnumerator(name: "kX86IntO", value: 3, isUnsigned: true)
!19 = !DIEnumerator(name: "kX86IntN", value: 4, isUnsigned: true)
!20 = !DIEnumerator(name: "kX86Bound", value: 5, isUnsigned: true)
!21 = !DIEnumerator(name: "kX86IRet", value: 6, isUnsigned: true)
!22 = !DIEnumerator(name: "kX86SysCall", value: 7, isUnsigned: true)
!23 = !DIEnumerator(name: "kX86SysRet", value: 8, isUnsigned: true)
!24 = !DIEnumerator(name: "kX86SysEnter", value: 9, isUnsigned: true)
!25 = !DIEnumerator(name: "kX86SysExit", value: 10, isUnsigned: true)
!26 = !DIEnumerator(name: "kX86JmpFar", value: 11, isUnsigned: true)
!27 = !DIEnumerator(name: "kAArch64SupervisorCall", value: 12, isUnsigned: true)
!28 = !DIEnumerator(name: "kInvalidInstruction", value: 13, isUnsigned: true)
!29 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "RequestPrivilegeLevel", file: !30, line: 64, baseType: !31, size: 16, elements: !33, identifier: "_ZTS21RequestPrivilegeLevel")
!30 = !DIFile(filename: "remill/Arch/X86/Runtime/State.h", directory: "/home/work/remill")
!31 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !12, line: 207, baseType: !32)
!32 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!33 = !{!34, !35, !36, !37}
!34 = !DIEnumerator(name: "kRPLRingZero", value: 0, isUnsigned: true)
!35 = !DIEnumerator(name: "kRPLRingOne", value: 1, isUnsigned: true)
!36 = !DIEnumerator(name: "kRPLRingTwo", value: 2, isUnsigned: true)
!37 = !DIEnumerator(name: "kRPLRingThree", value: 3, isUnsigned: true)
!38 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "TableIndicator", file: !30, line: 71, baseType: !31, size: 16, elements: !39, identifier: "_ZTS14TableIndicator")
!39 = !{!40, !41}
!40 = !DIEnumerator(name: "kGlobalDescriptorTable", value: 0, isUnsigned: true)
!41 = !DIEnumerator(name: "kLocalDescriptorTable", value: 1, isUnsigned: true)
!42 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "FPUPrecisionControl", file: !30, line: 123, baseType: !31, size: 16, elements: !43, identifier: "_ZTS19FPUPrecisionControl")
!43 = !{!44, !45, !46, !47}
!44 = !DIEnumerator(name: "kPrecisionSingle", value: 0, isUnsigned: true)
!45 = !DIEnumerator(name: "kPrecisionReserved", value: 1, isUnsigned: true)
!46 = !DIEnumerator(name: "kPrecisionDouble", value: 2, isUnsigned: true)
!47 = !DIEnumerator(name: "kPrecisionExtended", value: 3, isUnsigned: true)
!48 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "FPURoundingControl", file: !30, line: 130, baseType: !31, size: 16, elements: !49, identifier: "_ZTS18FPURoundingControl")
!49 = !{!50, !51, !52, !53}
!50 = !DIEnumerator(name: "kFPURoundToNearestEven", value: 0, isUnsigned: true)
!51 = !DIEnumerator(name: "kFPURoundDownNegInf", value: 1, isUnsigned: true)
!52 = !DIEnumerator(name: "kFPURoundUpInf", value: 2, isUnsigned: true)
!53 = !DIEnumerator(name: "kFPURoundToZero", value: 3, isUnsigned: true)
!54 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "FPUInfinityControl", file: !30, line: 137, baseType: !31, size: 16, elements: !55, identifier: "_ZTS18FPUInfinityControl")
!55 = !{!56, !57}
!56 = !DIEnumerator(name: "kInfinityProjective", value: 0, isUnsigned: true)
!57 = !DIEnumerator(name: "kInfinityAffine", value: 1, isUnsigned: true)
!58 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "FPUTag", file: !30, line: 214, baseType: !31, size: 16, elements: !59, identifier: "_ZTS6FPUTag")
!59 = !{!60, !61, !62, !63}
!60 = !DIEnumerator(name: "kFPUTagNonZero", value: 0, isUnsigned: true)
!61 = !DIEnumerator(name: "kFPUTagZero", value: 1, isUnsigned: true)
!62 = !DIEnumerator(name: "kFPUTagSpecial", value: 2, isUnsigned: true)
!63 = !DIEnumerator(name: "kFPUTagEmpty", value: 3, isUnsigned: true)
!64 = distinct !DICompositeType(tag: DW_TAG_enumeration_type, name: "FPUAbridgedTag", file: !30, line: 221, baseType: !65, size: 8, elements: !67, identifier: "_ZTS14FPUAbridgedTag")
!65 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !12, line: 226, baseType: !66)
!66 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!67 = !{!68, !69}
!68 = !DIEnumerator(name: "kFPUAbridgedTagEmpty", value: 0, isUnsigned: true)
!69 = !DIEnumerator(name: "kFPUAbridgedTagValid", value: 1, isUnsigned: true)
!70 = !{!71}
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!72 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!73 = !{!74, !79, !86, !90, !97, !101, !106, !108, !116, !120, !124, !136, !140, !144, !148, !152, !157, !161, !165, !169, !173, !181, !185, !189, !191, !195, !199, !203, !209, !213, !217, !219, !227, !231, !239, !241, !245, !249, !253, !257, !262, !267, !272, !273, !274, !275, !277, !278, !279, !280, !281, !282, !283, !339, !343, !360, !363, !368, !376, !381, !385, !389, !393, !397, !399, !401, !405, !411, !415, !421, !427, !429, !433, !437, !441, !445, !456, !458, !462, !466, !470, !472, !476, !480, !484, !486, !488, !492, !500, !504, !508, !512, !514, !520, !522, !528, !532, !536, !540, !544, !548, !552, !554, !556, !560, !564, !568, !570, !574, !578, !580, !582, !586, !590, !594, !598, !599, !600, !601, !602, !603, !604, !605, !606, !607, !608, !612, !615, !617, !619, !621, !623, !625, !627, !629, !631, !633, !635, !637, !639, !640, !641, !642, !644, !646, !648, !650, !652, !654, !656, !658, !660, !662, !664, !667, !669, !673, !677, !682, !686, !688, !690, !692, !694, !696, !698, !700, !702, !704, !706, !708, !710, !712, !716, !722, !727, !731, !733, !735, !737, !739, !746, !750, !754, !758, !762, !766, !771, !775, !777, !781, !787, !791, !796, !798, !800, !804, !808, !812, !814, !816, !818, !820, !824, !826, !828, !832, !836, !840, !844, !848, !850, !852, !856, !860, !864, !868, !870, !872, !876, !880, !881, !882, !883, !884, !885, !891, !893, !895, !899, !901, !903, !905, !907, !909, !911, !913, !918, !922, !924, !926, !931, !933, !935, !937, !939, !941, !943, !946, !948, !950, !954, !958, !960, !962, !964, !966, !968, !970, !972, !974, !976, !978, !982, !986, !988, !990, !992, !994, !996, !998, !1000, !1002, !1004, !1006, !1008, !1010, !1012, !1014, !1016, !1020, !1024, !1028, !1030, !1032, !1034, !1036, !1038, !1040, !1042, !1044, !1046, !1050, !1054, !1058, !1060, !1062, !1064, !1068, !1072, !1076, !1078, !1080, !1082, !1084, !1086, !1088, !1090, !1092, !1094, !1096, !1098, !1100, !1104, !1108, !1112, !1114, !1116, !1118, !1120, !1124, !1128, !1130, !1132, !1134, !1136, !1138, !1140, !1144, !1148, !1150, !1152, !1154, !1156, !1160, !1164, !1168, !1170, !1172, !1174, !1176, !1178, !1180, !1184, !1188, !1192, !1194, !1198, !1202, !1204, !1206, !1208, !1210, !1212, !1214, !1219, !1221, !1224, !1229, !1231, !1237, !1239, !1241, !1243, !1248, !1250, !1256, !1258, !1260, !1261, !1262, !1263, !1264, !1265, !1266, !1267, !1268, !1269, !1270, !1271}
!74 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !75, entity: !76, file: !78, line: 58)
!75 = !DINamespace(name: "__gnu_debug", scope: null)
!76 = !DINamespace(name: "__debug", scope: !77)
!77 = !DINamespace(name: "std", scope: null)
!78 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/debug/debug.h", directory: "")
!79 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !80, file: !85, line: 52)
!80 = !DISubprogram(name: "abs", scope: !81, file: !81, line: 837, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!81 = !DIFile(filename: "/usr/include/stdlib.h", directory: "")
!82 = !DISubroutineType(types: !83)
!83 = !{!84, !84}
!84 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!85 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/bits/std_abs.h", directory: "")
!86 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !87, file: !89, line: 127)
!87 = !DIDerivedType(tag: DW_TAG_typedef, name: "div_t", file: !81, line: 62, baseType: !88)
!88 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !81, line: 58, flags: DIFlagFwdDecl, identifier: "_ZTS5div_t")
!89 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/cstdlib", directory: "")
!90 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !91, file: !89, line: 128)
!91 = !DIDerivedType(tag: DW_TAG_typedef, name: "ldiv_t", file: !81, line: 70, baseType: !92)
!92 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !81, line: 66, size: 128, flags: DIFlagTypePassByValue, elements: !93, identifier: "_ZTS6ldiv_t")
!93 = !{!94, !96}
!94 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !92, file: !81, line: 68, baseType: !95, size: 64)
!95 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !92, file: !81, line: 69, baseType: !95, size: 64, offset: 64)
!97 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !98, file: !89, line: 130)
!98 = !DISubprogram(name: "abort", scope: !81, file: !81, line: 588, type: !99, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!99 = !DISubroutineType(types: !100)
!100 = !{null}
!101 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !102, file: !89, line: 134)
!102 = !DISubprogram(name: "atexit", scope: !81, file: !81, line: 592, type: !103, flags: DIFlagPrototyped, spFlags: 0)
!103 = !DISubroutineType(types: !104)
!104 = !{!84, !105}
!105 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !99, size: 64)
!106 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !107, file: !89, line: 137)
!107 = !DISubprogram(name: "at_quick_exit", scope: !81, file: !81, line: 597, type: !103, flags: DIFlagPrototyped, spFlags: 0)
!108 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !109, file: !89, line: 140)
!109 = !DISubprogram(name: "atof", scope: !81, file: !81, line: 101, type: !110, flags: DIFlagPrototyped, spFlags: 0)
!110 = !DISubroutineType(types: !111)
!111 = !{!112, !113}
!112 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!113 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !114, size: 64)
!114 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !115)
!115 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!116 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !117, file: !89, line: 141)
!117 = !DISubprogram(name: "atoi", scope: !81, file: !81, line: 104, type: !118, flags: DIFlagPrototyped, spFlags: 0)
!118 = !DISubroutineType(types: !119)
!119 = !{!84, !113}
!120 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !121, file: !89, line: 142)
!121 = !DISubprogram(name: "atol", scope: !81, file: !81, line: 107, type: !122, flags: DIFlagPrototyped, spFlags: 0)
!122 = !DISubroutineType(types: !123)
!123 = !{!95, !113}
!124 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !125, file: !89, line: 143)
!125 = !DISubprogram(name: "bsearch", scope: !81, file: !81, line: 817, type: !126, flags: DIFlagPrototyped, spFlags: 0)
!126 = !DISubroutineType(types: !127)
!127 = !{!128, !71, !71, !129, !129, !132}
!128 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!129 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !130, line: 46, baseType: !131)
!130 = !DIFile(filename: "libraries/llvm/lib/clang/9.0.0/include/stddef.h", directory: "/home/work/remill/remill-build")
!131 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!132 = !DIDerivedType(tag: DW_TAG_typedef, name: "__compar_fn_t", file: !81, line: 805, baseType: !133)
!133 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !134, size: 64)
!134 = !DISubroutineType(types: !135)
!135 = !{!84, !71, !71}
!136 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !137, file: !89, line: 144)
!137 = !DISubprogram(name: "calloc", scope: !81, file: !81, line: 541, type: !138, flags: DIFlagPrototyped, spFlags: 0)
!138 = !DISubroutineType(types: !139)
!139 = !{!128, !129, !129}
!140 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !141, file: !89, line: 145)
!141 = !DISubprogram(name: "div", scope: !81, file: !81, line: 849, type: !142, flags: DIFlagPrototyped, spFlags: 0)
!142 = !DISubroutineType(types: !143)
!143 = !{!87, !84, !84}
!144 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !145, file: !89, line: 146)
!145 = !DISubprogram(name: "exit", scope: !81, file: !81, line: 614, type: !146, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!146 = !DISubroutineType(types: !147)
!147 = !{null, !84}
!148 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !149, file: !89, line: 147)
!149 = !DISubprogram(name: "free", scope: !81, file: !81, line: 563, type: !150, flags: DIFlagPrototyped, spFlags: 0)
!150 = !DISubroutineType(types: !151)
!151 = !{null, !128}
!152 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !153, file: !89, line: 148)
!153 = !DISubprogram(name: "getenv", scope: !81, file: !81, line: 631, type: !154, flags: DIFlagPrototyped, spFlags: 0)
!154 = !DISubroutineType(types: !155)
!155 = !{!156, !113}
!156 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !115, size: 64)
!157 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !158, file: !89, line: 149)
!158 = !DISubprogram(name: "labs", scope: !81, file: !81, line: 838, type: !159, flags: DIFlagPrototyped, spFlags: 0)
!159 = !DISubroutineType(types: !160)
!160 = !{!95, !95}
!161 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !162, file: !89, line: 150)
!162 = !DISubprogram(name: "ldiv", scope: !81, file: !81, line: 851, type: !163, flags: DIFlagPrototyped, spFlags: 0)
!163 = !DISubroutineType(types: !164)
!164 = !{!91, !95, !95}
!165 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !166, file: !89, line: 151)
!166 = !DISubprogram(name: "malloc", scope: !81, file: !81, line: 539, type: !167, flags: DIFlagPrototyped, spFlags: 0)
!167 = !DISubroutineType(types: !168)
!168 = !{!128, !129}
!169 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !170, file: !89, line: 153)
!170 = !DISubprogram(name: "mblen", scope: !81, file: !81, line: 919, type: !171, flags: DIFlagPrototyped, spFlags: 0)
!171 = !DISubroutineType(types: !172)
!172 = !{!84, !113, !129}
!173 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !174, file: !89, line: 154)
!174 = !DISubprogram(name: "mbstowcs", scope: !81, file: !81, line: 930, type: !175, flags: DIFlagPrototyped, spFlags: 0)
!175 = !DISubroutineType(types: !176)
!176 = !{!129, !177, !180, !129}
!177 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !178)
!178 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !179, size: 64)
!179 = !DIBasicType(name: "wchar_t", size: 32, encoding: DW_ATE_signed)
!180 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !113)
!181 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !182, file: !89, line: 155)
!182 = !DISubprogram(name: "mbtowc", scope: !81, file: !81, line: 922, type: !183, flags: DIFlagPrototyped, spFlags: 0)
!183 = !DISubroutineType(types: !184)
!184 = !{!84, !177, !180, !129}
!185 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !186, file: !89, line: 157)
!186 = !DISubprogram(name: "qsort", scope: !81, file: !81, line: 827, type: !187, flags: DIFlagPrototyped, spFlags: 0)
!187 = !DISubroutineType(types: !188)
!188 = !{null, !128, !129, !129, !132}
!189 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !190, file: !89, line: 160)
!190 = !DISubprogram(name: "quick_exit", scope: !81, file: !81, line: 620, type: !146, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!191 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !192, file: !89, line: 163)
!192 = !DISubprogram(name: "rand", scope: !81, file: !81, line: 453, type: !193, flags: DIFlagPrototyped, spFlags: 0)
!193 = !DISubroutineType(types: !194)
!194 = !{!84}
!195 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !196, file: !89, line: 164)
!196 = !DISubprogram(name: "realloc", scope: !81, file: !81, line: 549, type: !197, flags: DIFlagPrototyped, spFlags: 0)
!197 = !DISubroutineType(types: !198)
!198 = !{!128, !128, !129}
!199 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !200, file: !89, line: 165)
!200 = !DISubprogram(name: "srand", scope: !81, file: !81, line: 455, type: !201, flags: DIFlagPrototyped, spFlags: 0)
!201 = !DISubroutineType(types: !202)
!202 = !{null, !13}
!203 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !204, file: !89, line: 166)
!204 = !DISubprogram(name: "strtod", scope: !81, file: !81, line: 117, type: !205, flags: DIFlagPrototyped, spFlags: 0)
!205 = !DISubroutineType(types: !206)
!206 = !{!112, !180, !207}
!207 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !208)
!208 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !156, size: 64)
!209 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !210, file: !89, line: 167)
!210 = !DISubprogram(name: "strtol", scope: !81, file: !81, line: 176, type: !211, flags: DIFlagPrototyped, spFlags: 0)
!211 = !DISubroutineType(types: !212)
!212 = !{!95, !180, !207, !84}
!213 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !214, file: !89, line: 168)
!214 = !DISubprogram(name: "strtoul", scope: !81, file: !81, line: 180, type: !215, flags: DIFlagPrototyped, spFlags: 0)
!215 = !DISubroutineType(types: !216)
!216 = !{!131, !180, !207, !84}
!217 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !218, file: !89, line: 169)
!218 = !DISubprogram(name: "system", scope: !81, file: !81, line: 781, type: !118, flags: DIFlagPrototyped, spFlags: 0)
!219 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !220, file: !89, line: 171)
!220 = !DISubprogram(name: "wcstombs", scope: !81, file: !81, line: 933, type: !221, flags: DIFlagPrototyped, spFlags: 0)
!221 = !DISubroutineType(types: !222)
!222 = !{!129, !223, !224, !129}
!223 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !156)
!224 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !225)
!225 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !226, size: 64)
!226 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !179)
!227 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !228, file: !89, line: 172)
!228 = !DISubprogram(name: "wctomb", scope: !81, file: !81, line: 926, type: !229, flags: DIFlagPrototyped, spFlags: 0)
!229 = !DISubroutineType(types: !230)
!230 = !{!84, !156, !179}
!231 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !233, file: !89, line: 200)
!232 = !DINamespace(name: "__gnu_cxx", scope: null)
!233 = !DIDerivedType(tag: DW_TAG_typedef, name: "lldiv_t", file: !81, line: 80, baseType: !234)
!234 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !81, line: 76, size: 128, flags: DIFlagTypePassByValue, elements: !235, identifier: "_ZTS7lldiv_t")
!235 = !{!236, !238}
!236 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !234, file: !81, line: 78, baseType: !237, size: 64)
!237 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!238 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !234, file: !81, line: 79, baseType: !237, size: 64, offset: 64)
!239 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !240, file: !89, line: 206)
!240 = !DISubprogram(name: "_Exit", scope: !81, file: !81, line: 626, type: !146, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!241 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !242, file: !89, line: 210)
!242 = !DISubprogram(name: "llabs", scope: !81, file: !81, line: 841, type: !243, flags: DIFlagPrototyped, spFlags: 0)
!243 = !DISubroutineType(types: !244)
!244 = !{!237, !237}
!245 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !246, file: !89, line: 216)
!246 = !DISubprogram(name: "lldiv", scope: !81, file: !81, line: 855, type: !247, flags: DIFlagPrototyped, spFlags: 0)
!247 = !DISubroutineType(types: !248)
!248 = !{!233, !237, !237}
!249 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !250, file: !89, line: 227)
!250 = !DISubprogram(name: "atoll", scope: !81, file: !81, line: 112, type: !251, flags: DIFlagPrototyped, spFlags: 0)
!251 = !DISubroutineType(types: !252)
!252 = !{!237, !113}
!253 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !254, file: !89, line: 228)
!254 = !DISubprogram(name: "strtoll", scope: !81, file: !81, line: 200, type: !255, flags: DIFlagPrototyped, spFlags: 0)
!255 = !DISubroutineType(types: !256)
!256 = !{!237, !180, !207, !84}
!257 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !258, file: !89, line: 229)
!258 = !DISubprogram(name: "strtoull", scope: !81, file: !81, line: 205, type: !259, flags: DIFlagPrototyped, spFlags: 0)
!259 = !DISubroutineType(types: !260)
!260 = !{!261, !180, !207, !84}
!261 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!262 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !263, file: !89, line: 231)
!263 = !DISubprogram(name: "strtof", scope: !81, file: !81, line: 123, type: !264, flags: DIFlagPrototyped, spFlags: 0)
!264 = !DISubroutineType(types: !265)
!265 = !{!266, !180, !207}
!266 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!267 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !268, file: !89, line: 232)
!268 = !DISubprogram(name: "strtold", scope: !81, file: !81, line: 126, type: !269, flags: DIFlagPrototyped, spFlags: 0)
!269 = !DISubroutineType(types: !270)
!270 = !{!271, !180, !207}
!271 = !DIBasicType(name: "long double", size: 128, encoding: DW_ATE_float)
!272 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !233, file: !89, line: 240)
!273 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !240, file: !89, line: 242)
!274 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !242, file: !89, line: 244)
!275 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !276, file: !89, line: 245)
!276 = !DISubprogram(name: "div", linkageName: "_ZN9__gnu_cxx3divExx", scope: !232, file: !89, line: 213, type: !247, flags: DIFlagPrototyped, spFlags: 0)
!277 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !246, file: !89, line: 246)
!278 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !250, file: !89, line: 248)
!279 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !263, file: !89, line: 249)
!280 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !254, file: !89, line: 250)
!281 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !258, file: !89, line: 251)
!282 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !268, file: !89, line: 252)
!283 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !284, file: !285, line: 57)
!284 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "exception_ptr", scope: !286, file: !285, line: 79, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !287, identifier: "_ZTSNSt15__exception_ptr13exception_ptrE")
!285 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/bits/exception_ptr.h", directory: "")
!286 = !DINamespace(name: "__exception_ptr", scope: !77)
!287 = !{!288, !289, !293, !296, !297, !302, !303, !307, !313, !317, !321, !324, !325, !328, !332}
!288 = !DIDerivedType(tag: DW_TAG_member, name: "_M_exception_object", scope: !284, file: !285, line: 81, baseType: !128, size: 64)
!289 = !DISubprogram(name: "exception_ptr", scope: !284, file: !285, line: 83, type: !290, scopeLine: 83, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!290 = !DISubroutineType(types: !291)
!291 = !{null, !292, !128}
!292 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !284, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!293 = !DISubprogram(name: "_M_addref", linkageName: "_ZNSt15__exception_ptr13exception_ptr9_M_addrefEv", scope: !284, file: !285, line: 85, type: !294, scopeLine: 85, flags: DIFlagPrototyped, spFlags: 0)
!294 = !DISubroutineType(types: !295)
!295 = !{null, !292}
!296 = !DISubprogram(name: "_M_release", linkageName: "_ZNSt15__exception_ptr13exception_ptr10_M_releaseEv", scope: !284, file: !285, line: 86, type: !294, scopeLine: 86, flags: DIFlagPrototyped, spFlags: 0)
!297 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt15__exception_ptr13exception_ptr6_M_getEv", scope: !284, file: !285, line: 88, type: !298, scopeLine: 88, flags: DIFlagPrototyped, spFlags: 0)
!298 = !DISubroutineType(types: !299)
!299 = !{!128, !300}
!300 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !301, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!301 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !284)
!302 = !DISubprogram(name: "exception_ptr", scope: !284, file: !285, line: 96, type: !294, scopeLine: 96, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!303 = !DISubprogram(name: "exception_ptr", scope: !284, file: !285, line: 98, type: !304, scopeLine: 98, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!304 = !DISubroutineType(types: !305)
!305 = !{null, !292, !306}
!306 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !301, size: 64)
!307 = !DISubprogram(name: "exception_ptr", scope: !284, file: !285, line: 101, type: !308, scopeLine: 101, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!308 = !DISubroutineType(types: !309)
!309 = !{null, !292, !310}
!310 = !DIDerivedType(tag: DW_TAG_typedef, name: "nullptr_t", scope: !77, file: !311, line: 235, baseType: !312)
!311 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/x86_64-linux-gnu/c++/7.5.0/bits/c++config.h", directory: "")
!312 = !DIBasicType(tag: DW_TAG_unspecified_type, name: "decltype(nullptr)")
!313 = !DISubprogram(name: "exception_ptr", scope: !284, file: !285, line: 105, type: !314, scopeLine: 105, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!314 = !DISubroutineType(types: !315)
!315 = !{null, !292, !316}
!316 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !284, size: 64)
!317 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__exception_ptr13exception_ptraSERKS0_", scope: !284, file: !285, line: 118, type: !318, scopeLine: 118, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!318 = !DISubroutineType(types: !319)
!319 = !{!320, !292, !306}
!320 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !284, size: 64)
!321 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__exception_ptr13exception_ptraSEOS0_", scope: !284, file: !285, line: 122, type: !322, scopeLine: 122, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!322 = !DISubroutineType(types: !323)
!323 = !{!320, !292, !316}
!324 = !DISubprogram(name: "~exception_ptr", scope: !284, file: !285, line: 129, type: !294, scopeLine: 129, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!325 = !DISubprogram(name: "swap", linkageName: "_ZNSt15__exception_ptr13exception_ptr4swapERS0_", scope: !284, file: !285, line: 132, type: !326, scopeLine: 132, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!326 = !DISubroutineType(types: !327)
!327 = !{null, !292, !320}
!328 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt15__exception_ptr13exception_ptrcvbEv", scope: !284, file: !285, line: 144, type: !329, scopeLine: 144, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!329 = !DISubroutineType(types: !330)
!330 = !{!331, !300}
!331 = !DIBasicType(name: "bool", size: 8, encoding: DW_ATE_boolean)
!332 = !DISubprogram(name: "__cxa_exception_type", linkageName: "_ZNKSt15__exception_ptr13exception_ptr20__cxa_exception_typeEv", scope: !284, file: !285, line: 153, type: !333, scopeLine: 153, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!333 = !DISubroutineType(types: !334)
!334 = !{!335, !300}
!335 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !336, size: 64)
!336 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !337)
!337 = !DICompositeType(tag: DW_TAG_class_type, name: "type_info", scope: !77, file: !338, line: 88, flags: DIFlagFwdDecl)
!338 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/typeinfo", directory: "")
!339 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !286, entity: !340, file: !285, line: 73)
!340 = !DISubprogram(name: "rethrow_exception", linkageName: "_ZSt17rethrow_exceptionNSt15__exception_ptr13exception_ptrE", scope: !77, file: !285, line: 69, type: !341, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!341 = !DISubroutineType(types: !342)
!342 = !{null, !284}
!343 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !344, file: !359, line: 64)
!344 = !DIDerivedType(tag: DW_TAG_typedef, name: "mbstate_t", file: !345, line: 6, baseType: !346)
!345 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/mbstate_t.h", directory: "")
!346 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mbstate_t", file: !347, line: 21, baseType: !348)
!347 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__mbstate_t.h", directory: "")
!348 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !347, line: 13, size: 64, flags: DIFlagTypePassByValue, elements: !349, identifier: "_ZTS11__mbstate_t")
!349 = !{!350, !351}
!350 = !DIDerivedType(tag: DW_TAG_member, name: "__count", scope: !348, file: !347, line: 15, baseType: !84, size: 32)
!351 = !DIDerivedType(tag: DW_TAG_member, name: "__value", scope: !348, file: !347, line: 20, baseType: !352, size: 32, offset: 32)
!352 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !348, file: !347, line: 16, size: 32, flags: DIFlagTypePassByValue, elements: !353, identifier: "_ZTSN11__mbstate_tUt_E")
!353 = !{!354, !355}
!354 = !DIDerivedType(tag: DW_TAG_member, name: "__wch", scope: !352, file: !347, line: 18, baseType: !13, size: 32)
!355 = !DIDerivedType(tag: DW_TAG_member, name: "__wchb", scope: !352, file: !347, line: 19, baseType: !356, size: 32)
!356 = !DICompositeType(tag: DW_TAG_array_type, baseType: !115, size: 32, elements: !357)
!357 = !{!358}
!358 = !DISubrange(count: 4)
!359 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/cwchar", directory: "")
!360 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !361, file: !359, line: 139)
!361 = !DIDerivedType(tag: DW_TAG_typedef, name: "wint_t", file: !362, line: 20, baseType: !13)
!362 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/wint_t.h", directory: "")
!363 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !364, file: !359, line: 141)
!364 = !DISubprogram(name: "btowc", scope: !365, file: !365, line: 284, type: !366, flags: DIFlagPrototyped, spFlags: 0)
!365 = !DIFile(filename: "/usr/include/wchar.h", directory: "")
!366 = !DISubroutineType(types: !367)
!367 = !{!361, !84}
!368 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !369, file: !359, line: 142)
!369 = !DISubprogram(name: "fgetwc", scope: !365, file: !365, line: 727, type: !370, flags: DIFlagPrototyped, spFlags: 0)
!370 = !DISubroutineType(types: !371)
!371 = !{!361, !372}
!372 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !373, size: 64)
!373 = !DIDerivedType(tag: DW_TAG_typedef, name: "__FILE", file: !374, line: 5, baseType: !375)
!374 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/__FILE.h", directory: "")
!375 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !374, line: 4, flags: DIFlagFwdDecl, identifier: "_ZTS8_IO_FILE")
!376 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !377, file: !359, line: 143)
!377 = !DISubprogram(name: "fgetws", scope: !365, file: !365, line: 756, type: !378, flags: DIFlagPrototyped, spFlags: 0)
!378 = !DISubroutineType(types: !379)
!379 = !{!178, !177, !84, !380}
!380 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !372)
!381 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !382, file: !359, line: 144)
!382 = !DISubprogram(name: "fputwc", scope: !365, file: !365, line: 741, type: !383, flags: DIFlagPrototyped, spFlags: 0)
!383 = !DISubroutineType(types: !384)
!384 = !{!361, !179, !372}
!385 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !386, file: !359, line: 145)
!386 = !DISubprogram(name: "fputws", scope: !365, file: !365, line: 763, type: !387, flags: DIFlagPrototyped, spFlags: 0)
!387 = !DISubroutineType(types: !388)
!388 = !{!84, !224, !380}
!389 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !390, file: !359, line: 146)
!390 = !DISubprogram(name: "fwide", scope: !365, file: !365, line: 573, type: !391, flags: DIFlagPrototyped, spFlags: 0)
!391 = !DISubroutineType(types: !392)
!392 = !{!84, !372, !84}
!393 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !394, file: !359, line: 147)
!394 = !DISubprogram(name: "fwprintf", scope: !365, file: !365, line: 580, type: !395, flags: DIFlagPrototyped, spFlags: 0)
!395 = !DISubroutineType(types: !396)
!396 = !{!84, !380, !224, null}
!397 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !398, file: !359, line: 148)
!398 = !DISubprogram(name: "fwscanf", scope: !365, file: !365, line: 621, type: !395, flags: DIFlagPrototyped, spFlags: 0)
!399 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !400, file: !359, line: 149)
!400 = !DISubprogram(name: "getwc", scope: !365, file: !365, line: 728, type: !370, flags: DIFlagPrototyped, spFlags: 0)
!401 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !402, file: !359, line: 150)
!402 = !DISubprogram(name: "getwchar", scope: !365, file: !365, line: 734, type: !403, flags: DIFlagPrototyped, spFlags: 0)
!403 = !DISubroutineType(types: !404)
!404 = !{!361}
!405 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !406, file: !359, line: 151)
!406 = !DISubprogram(name: "mbrlen", scope: !365, file: !365, line: 307, type: !407, flags: DIFlagPrototyped, spFlags: 0)
!407 = !DISubroutineType(types: !408)
!408 = !{!129, !180, !129, !409}
!409 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !410)
!410 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !344, size: 64)
!411 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !412, file: !359, line: 152)
!412 = !DISubprogram(name: "mbrtowc", scope: !365, file: !365, line: 296, type: !413, flags: DIFlagPrototyped, spFlags: 0)
!413 = !DISubroutineType(types: !414)
!414 = !{!129, !177, !180, !129, !409}
!415 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !416, file: !359, line: 153)
!416 = !DISubprogram(name: "mbsinit", scope: !365, file: !365, line: 292, type: !417, flags: DIFlagPrototyped, spFlags: 0)
!417 = !DISubroutineType(types: !418)
!418 = !{!84, !419}
!419 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !420, size: 64)
!420 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !344)
!421 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !422, file: !359, line: 154)
!422 = !DISubprogram(name: "mbsrtowcs", scope: !365, file: !365, line: 337, type: !423, flags: DIFlagPrototyped, spFlags: 0)
!423 = !DISubroutineType(types: !424)
!424 = !{!129, !177, !425, !129, !409}
!425 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !426)
!426 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !113, size: 64)
!427 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !428, file: !359, line: 155)
!428 = !DISubprogram(name: "putwc", scope: !365, file: !365, line: 742, type: !383, flags: DIFlagPrototyped, spFlags: 0)
!429 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !430, file: !359, line: 156)
!430 = !DISubprogram(name: "putwchar", scope: !365, file: !365, line: 748, type: !431, flags: DIFlagPrototyped, spFlags: 0)
!431 = !DISubroutineType(types: !432)
!432 = !{!361, !179}
!433 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !434, file: !359, line: 158)
!434 = !DISubprogram(name: "swprintf", scope: !365, file: !365, line: 590, type: !435, flags: DIFlagPrototyped, spFlags: 0)
!435 = !DISubroutineType(types: !436)
!436 = !{!84, !177, !129, !224, null}
!437 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !438, file: !359, line: 160)
!438 = !DISubprogram(name: "swscanf", scope: !365, file: !365, line: 631, type: !439, flags: DIFlagPrototyped, spFlags: 0)
!439 = !DISubroutineType(types: !440)
!440 = !{!84, !224, !224, null}
!441 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !442, file: !359, line: 161)
!442 = !DISubprogram(name: "ungetwc", scope: !365, file: !365, line: 771, type: !443, flags: DIFlagPrototyped, spFlags: 0)
!443 = !DISubroutineType(types: !444)
!444 = !{!361, !361, !372}
!445 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !446, file: !359, line: 162)
!446 = !DISubprogram(name: "vfwprintf", scope: !365, file: !365, line: 598, type: !447, flags: DIFlagPrototyped, spFlags: 0)
!447 = !DISubroutineType(types: !448)
!448 = !{!84, !380, !224, !449}
!449 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !450, size: 64)
!450 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "__va_list_tag", file: !5, size: 192, flags: DIFlagTypePassByValue, elements: !451, identifier: "_ZTS13__va_list_tag")
!451 = !{!452, !453, !454, !455}
!452 = !DIDerivedType(tag: DW_TAG_member, name: "gp_offset", scope: !450, file: !5, baseType: !13, size: 32)
!453 = !DIDerivedType(tag: DW_TAG_member, name: "fp_offset", scope: !450, file: !5, baseType: !13, size: 32, offset: 32)
!454 = !DIDerivedType(tag: DW_TAG_member, name: "overflow_arg_area", scope: !450, file: !5, baseType: !128, size: 64, offset: 64)
!455 = !DIDerivedType(tag: DW_TAG_member, name: "reg_save_area", scope: !450, file: !5, baseType: !128, size: 64, offset: 128)
!456 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !457, file: !359, line: 164)
!457 = !DISubprogram(name: "vfwscanf", scope: !365, file: !365, line: 673, type: !447, flags: DIFlagPrototyped, spFlags: 0)
!458 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !459, file: !359, line: 167)
!459 = !DISubprogram(name: "vswprintf", scope: !365, file: !365, line: 611, type: !460, flags: DIFlagPrototyped, spFlags: 0)
!460 = !DISubroutineType(types: !461)
!461 = !{!84, !177, !129, !224, !449}
!462 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !463, file: !359, line: 170)
!463 = !DISubprogram(name: "vswscanf", scope: !365, file: !365, line: 685, type: !464, flags: DIFlagPrototyped, spFlags: 0)
!464 = !DISubroutineType(types: !465)
!465 = !{!84, !224, !224, !449}
!466 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !467, file: !359, line: 172)
!467 = !DISubprogram(name: "vwprintf", scope: !365, file: !365, line: 606, type: !468, flags: DIFlagPrototyped, spFlags: 0)
!468 = !DISubroutineType(types: !469)
!469 = !{!84, !224, !449}
!470 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !471, file: !359, line: 174)
!471 = !DISubprogram(name: "vwscanf", scope: !365, file: !365, line: 681, type: !468, flags: DIFlagPrototyped, spFlags: 0)
!472 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !473, file: !359, line: 176)
!473 = !DISubprogram(name: "wcrtomb", scope: !365, file: !365, line: 301, type: !474, flags: DIFlagPrototyped, spFlags: 0)
!474 = !DISubroutineType(types: !475)
!475 = !{!129, !223, !179, !409}
!476 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !477, file: !359, line: 177)
!477 = !DISubprogram(name: "wcscat", scope: !365, file: !365, line: 97, type: !478, flags: DIFlagPrototyped, spFlags: 0)
!478 = !DISubroutineType(types: !479)
!479 = !{!178, !177, !224}
!480 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !481, file: !359, line: 178)
!481 = !DISubprogram(name: "wcscmp", scope: !365, file: !365, line: 106, type: !482, flags: DIFlagPrototyped, spFlags: 0)
!482 = !DISubroutineType(types: !483)
!483 = !{!84, !225, !225}
!484 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !485, file: !359, line: 179)
!485 = !DISubprogram(name: "wcscoll", scope: !365, file: !365, line: 131, type: !482, flags: DIFlagPrototyped, spFlags: 0)
!486 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !487, file: !359, line: 180)
!487 = !DISubprogram(name: "wcscpy", scope: !365, file: !365, line: 87, type: !478, flags: DIFlagPrototyped, spFlags: 0)
!488 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !489, file: !359, line: 181)
!489 = !DISubprogram(name: "wcscspn", scope: !365, file: !365, line: 187, type: !490, flags: DIFlagPrototyped, spFlags: 0)
!490 = !DISubroutineType(types: !491)
!491 = !{!129, !225, !225}
!492 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !493, file: !359, line: 182)
!493 = !DISubprogram(name: "wcsftime", scope: !365, file: !365, line: 835, type: !494, flags: DIFlagPrototyped, spFlags: 0)
!494 = !DISubroutineType(types: !495)
!495 = !{!129, !177, !129, !224, !496}
!496 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !497)
!497 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !498, size: 64)
!498 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !499)
!499 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "tm", file: !365, line: 83, flags: DIFlagFwdDecl, identifier: "_ZTS2tm")
!500 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !501, file: !359, line: 183)
!501 = !DISubprogram(name: "wcslen", scope: !365, file: !365, line: 222, type: !502, flags: DIFlagPrototyped, spFlags: 0)
!502 = !DISubroutineType(types: !503)
!503 = !{!129, !225}
!504 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !505, file: !359, line: 184)
!505 = !DISubprogram(name: "wcsncat", scope: !365, file: !365, line: 101, type: !506, flags: DIFlagPrototyped, spFlags: 0)
!506 = !DISubroutineType(types: !507)
!507 = !{!178, !177, !224, !129}
!508 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !509, file: !359, line: 185)
!509 = !DISubprogram(name: "wcsncmp", scope: !365, file: !365, line: 109, type: !510, flags: DIFlagPrototyped, spFlags: 0)
!510 = !DISubroutineType(types: !511)
!511 = !{!84, !225, !225, !129}
!512 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !513, file: !359, line: 186)
!513 = !DISubprogram(name: "wcsncpy", scope: !365, file: !365, line: 92, type: !506, flags: DIFlagPrototyped, spFlags: 0)
!514 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !515, file: !359, line: 187)
!515 = !DISubprogram(name: "wcsrtombs", scope: !365, file: !365, line: 343, type: !516, flags: DIFlagPrototyped, spFlags: 0)
!516 = !DISubroutineType(types: !517)
!517 = !{!129, !223, !518, !129, !409}
!518 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !519)
!519 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !225, size: 64)
!520 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !521, file: !359, line: 188)
!521 = !DISubprogram(name: "wcsspn", scope: !365, file: !365, line: 191, type: !490, flags: DIFlagPrototyped, spFlags: 0)
!522 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !523, file: !359, line: 189)
!523 = !DISubprogram(name: "wcstod", scope: !365, file: !365, line: 377, type: !524, flags: DIFlagPrototyped, spFlags: 0)
!524 = !DISubroutineType(types: !525)
!525 = !{!112, !224, !526}
!526 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !527)
!527 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !178, size: 64)
!528 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !529, file: !359, line: 191)
!529 = !DISubprogram(name: "wcstof", scope: !365, file: !365, line: 382, type: !530, flags: DIFlagPrototyped, spFlags: 0)
!530 = !DISubroutineType(types: !531)
!531 = !{!266, !224, !526}
!532 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !533, file: !359, line: 193)
!533 = !DISubprogram(name: "wcstok", scope: !365, file: !365, line: 217, type: !534, flags: DIFlagPrototyped, spFlags: 0)
!534 = !DISubroutineType(types: !535)
!535 = !{!178, !177, !224, !526}
!536 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !537, file: !359, line: 194)
!537 = !DISubprogram(name: "wcstol", scope: !365, file: !365, line: 428, type: !538, flags: DIFlagPrototyped, spFlags: 0)
!538 = !DISubroutineType(types: !539)
!539 = !{!95, !224, !526, !84}
!540 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !541, file: !359, line: 195)
!541 = !DISubprogram(name: "wcstoul", scope: !365, file: !365, line: 433, type: !542, flags: DIFlagPrototyped, spFlags: 0)
!542 = !DISubroutineType(types: !543)
!543 = !{!131, !224, !526, !84}
!544 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !545, file: !359, line: 196)
!545 = !DISubprogram(name: "wcsxfrm", scope: !365, file: !365, line: 135, type: !546, flags: DIFlagPrototyped, spFlags: 0)
!546 = !DISubroutineType(types: !547)
!547 = !{!129, !177, !224, !129}
!548 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !549, file: !359, line: 197)
!549 = !DISubprogram(name: "wctob", scope: !365, file: !365, line: 288, type: !550, flags: DIFlagPrototyped, spFlags: 0)
!550 = !DISubroutineType(types: !551)
!551 = !{!84, !361}
!552 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !553, file: !359, line: 198)
!553 = !DISubprogram(name: "wmemcmp", scope: !365, file: !365, line: 258, type: !510, flags: DIFlagPrototyped, spFlags: 0)
!554 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !555, file: !359, line: 199)
!555 = !DISubprogram(name: "wmemcpy", scope: !365, file: !365, line: 262, type: !506, flags: DIFlagPrototyped, spFlags: 0)
!556 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !557, file: !359, line: 200)
!557 = !DISubprogram(name: "wmemmove", scope: !365, file: !365, line: 267, type: !558, flags: DIFlagPrototyped, spFlags: 0)
!558 = !DISubroutineType(types: !559)
!559 = !{!178, !178, !225, !129}
!560 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !561, file: !359, line: 201)
!561 = !DISubprogram(name: "wmemset", scope: !365, file: !365, line: 271, type: !562, flags: DIFlagPrototyped, spFlags: 0)
!562 = !DISubroutineType(types: !563)
!563 = !{!178, !178, !179, !129}
!564 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !565, file: !359, line: 202)
!565 = !DISubprogram(name: "wprintf", scope: !365, file: !365, line: 587, type: !566, flags: DIFlagPrototyped, spFlags: 0)
!566 = !DISubroutineType(types: !567)
!567 = !{!84, !224, null}
!568 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !569, file: !359, line: 203)
!569 = !DISubprogram(name: "wscanf", scope: !365, file: !365, line: 628, type: !566, flags: DIFlagPrototyped, spFlags: 0)
!570 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !571, file: !359, line: 204)
!571 = !DISubprogram(name: "wcschr", scope: !365, file: !365, line: 164, type: !572, flags: DIFlagPrototyped, spFlags: 0)
!572 = !DISubroutineType(types: !573)
!573 = !{!178, !225, !179}
!574 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !575, file: !359, line: 205)
!575 = !DISubprogram(name: "wcspbrk", scope: !365, file: !365, line: 201, type: !576, flags: DIFlagPrototyped, spFlags: 0)
!576 = !DISubroutineType(types: !577)
!577 = !{!178, !225, !225}
!578 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !579, file: !359, line: 206)
!579 = !DISubprogram(name: "wcsrchr", scope: !365, file: !365, line: 174, type: !572, flags: DIFlagPrototyped, spFlags: 0)
!580 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !581, file: !359, line: 207)
!581 = !DISubprogram(name: "wcsstr", scope: !365, file: !365, line: 212, type: !576, flags: DIFlagPrototyped, spFlags: 0)
!582 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !583, file: !359, line: 208)
!583 = !DISubprogram(name: "wmemchr", scope: !365, file: !365, line: 253, type: !584, flags: DIFlagPrototyped, spFlags: 0)
!584 = !DISubroutineType(types: !585)
!585 = !{!178, !225, !179, !129}
!586 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !587, file: !359, line: 248)
!587 = !DISubprogram(name: "wcstold", scope: !365, file: !365, line: 384, type: !588, flags: DIFlagPrototyped, spFlags: 0)
!588 = !DISubroutineType(types: !589)
!589 = !{!271, !224, !526}
!590 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !591, file: !359, line: 257)
!591 = !DISubprogram(name: "wcstoll", scope: !365, file: !365, line: 441, type: !592, flags: DIFlagPrototyped, spFlags: 0)
!592 = !DISubroutineType(types: !593)
!593 = !{!237, !224, !526, !84}
!594 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !595, file: !359, line: 258)
!595 = !DISubprogram(name: "wcstoull", scope: !365, file: !365, line: 448, type: !596, flags: DIFlagPrototyped, spFlags: 0)
!596 = !DISubroutineType(types: !597)
!597 = !{!261, !224, !526, !84}
!598 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !587, file: !359, line: 264)
!599 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !591, file: !359, line: 265)
!600 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !595, file: !359, line: 266)
!601 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !529, file: !359, line: 280)
!602 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !457, file: !359, line: 283)
!603 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !463, file: !359, line: 286)
!604 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !471, file: !359, line: 289)
!605 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !587, file: !359, line: 293)
!606 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !591, file: !359, line: 294)
!607 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !595, file: !359, line: 295)
!608 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !609, file: !611, line: 48)
!609 = !DIDerivedType(tag: DW_TAG_typedef, name: "int8_t", file: !12, line: 224, baseType: !610)
!610 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!611 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/cstdint", directory: "")
!612 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !613, file: !611, line: 49)
!613 = !DIDerivedType(tag: DW_TAG_typedef, name: "int16_t", file: !12, line: 205, baseType: !614)
!614 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!615 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !616, file: !611, line: 50)
!616 = !DIDerivedType(tag: DW_TAG_typedef, name: "int32_t", file: !12, line: 167, baseType: !84)
!617 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !618, file: !611, line: 51)
!618 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !12, line: 96, baseType: !95)
!619 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !620, file: !611, line: 53)
!620 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast8_t", file: !12, line: 234, baseType: !609)
!621 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !622, file: !611, line: 54)
!622 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast16_t", file: !12, line: 217, baseType: !613)
!623 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !624, file: !611, line: 55)
!624 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast32_t", file: !12, line: 186, baseType: !616)
!625 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !626, file: !611, line: 56)
!626 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_fast64_t", file: !12, line: 112, baseType: !618)
!627 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !628, file: !611, line: 58)
!628 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least8_t", file: !12, line: 232, baseType: !609)
!629 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !630, file: !611, line: 59)
!630 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least16_t", file: !12, line: 215, baseType: !613)
!631 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !632, file: !611, line: 60)
!632 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least32_t", file: !12, line: 184, baseType: !616)
!633 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !634, file: !611, line: 61)
!634 = !DIDerivedType(tag: DW_TAG_typedef, name: "int_least64_t", file: !12, line: 110, baseType: !618)
!635 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !636, file: !611, line: 63)
!636 = !DIDerivedType(tag: DW_TAG_typedef, name: "intmax_t", file: !12, line: 262, baseType: !95)
!637 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !638, file: !611, line: 64)
!638 = !DIDerivedType(tag: DW_TAG_typedef, name: "intptr_t", file: !12, line: 249, baseType: !95)
!639 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !65, file: !611, line: 66)
!640 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !31, file: !611, line: 67)
!641 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !11, file: !611, line: 68)
!642 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !643, file: !611, line: 69)
!643 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !12, line: 98, baseType: !131)
!644 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !645, file: !611, line: 71)
!645 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast8_t", file: !12, line: 235, baseType: !65)
!646 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !647, file: !611, line: 72)
!647 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast16_t", file: !12, line: 218, baseType: !31)
!648 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !649, file: !611, line: 73)
!649 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast32_t", file: !12, line: 187, baseType: !11)
!650 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !651, file: !611, line: 74)
!651 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_fast64_t", file: !12, line: 113, baseType: !643)
!652 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !653, file: !611, line: 76)
!653 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least8_t", file: !12, line: 233, baseType: !65)
!654 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !655, file: !611, line: 77)
!655 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least16_t", file: !12, line: 216, baseType: !31)
!656 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !657, file: !611, line: 78)
!657 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least32_t", file: !12, line: 185, baseType: !11)
!658 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !659, file: !611, line: 79)
!659 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint_least64_t", file: !12, line: 111, baseType: !643)
!660 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !661, file: !611, line: 81)
!661 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintmax_t", file: !12, line: 263, baseType: !131)
!662 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !663, file: !611, line: 82)
!663 = !DIDerivedType(tag: DW_TAG_typedef, name: "uintptr_t", file: !12, line: 256, baseType: !131)
!664 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !665, file: !666, line: 44)
!665 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", scope: !77, file: !311, line: 231, baseType: !131)
!666 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/ext/new_allocator.h", directory: "")
!667 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !668, file: !666, line: 45)
!668 = !DIDerivedType(tag: DW_TAG_typedef, name: "ptrdiff_t", scope: !77, file: !311, line: 232, baseType: !95)
!669 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !670, file: !672, line: 53)
!670 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "lconv", file: !671, line: 51, flags: DIFlagFwdDecl, identifier: "_ZTS5lconv")
!671 = !DIFile(filename: "/usr/include/locale.h", directory: "")
!672 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/clocale", directory: "")
!673 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !674, file: !672, line: 54)
!674 = !DISubprogram(name: "setlocale", scope: !671, file: !671, line: 122, type: !675, flags: DIFlagPrototyped, spFlags: 0)
!675 = !DISubroutineType(types: !676)
!676 = !{!156, !84, !113}
!677 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !678, file: !672, line: 55)
!678 = !DISubprogram(name: "localeconv", scope: !671, file: !671, line: 125, type: !679, flags: DIFlagPrototyped, spFlags: 0)
!679 = !DISubroutineType(types: !680)
!680 = !{!681}
!681 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !670, size: 64)
!682 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !683, file: !685, line: 64)
!683 = !DISubprogram(name: "isalnum", scope: !684, file: !684, line: 108, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!684 = !DIFile(filename: "/usr/include/ctype.h", directory: "")
!685 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/cctype", directory: "")
!686 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !687, file: !685, line: 65)
!687 = !DISubprogram(name: "isalpha", scope: !684, file: !684, line: 109, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!688 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !689, file: !685, line: 66)
!689 = !DISubprogram(name: "iscntrl", scope: !684, file: !684, line: 110, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!690 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !691, file: !685, line: 67)
!691 = !DISubprogram(name: "isdigit", scope: !684, file: !684, line: 111, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!692 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !693, file: !685, line: 68)
!693 = !DISubprogram(name: "isgraph", scope: !684, file: !684, line: 113, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!694 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !695, file: !685, line: 69)
!695 = !DISubprogram(name: "islower", scope: !684, file: !684, line: 112, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!696 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !697, file: !685, line: 70)
!697 = !DISubprogram(name: "isprint", scope: !684, file: !684, line: 114, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!698 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !699, file: !685, line: 71)
!699 = !DISubprogram(name: "ispunct", scope: !684, file: !684, line: 115, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!700 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !701, file: !685, line: 72)
!701 = !DISubprogram(name: "isspace", scope: !684, file: !684, line: 116, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!702 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !703, file: !685, line: 73)
!703 = !DISubprogram(name: "isupper", scope: !684, file: !684, line: 117, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!704 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !705, file: !685, line: 74)
!705 = !DISubprogram(name: "isxdigit", scope: !684, file: !684, line: 118, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!706 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !707, file: !685, line: 75)
!707 = !DISubprogram(name: "tolower", scope: !684, file: !684, line: 122, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!708 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !709, file: !685, line: 76)
!709 = !DISubprogram(name: "toupper", scope: !684, file: !684, line: 125, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!710 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !711, file: !685, line: 87)
!711 = !DISubprogram(name: "isblank", scope: !684, file: !684, line: 130, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!712 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !713, file: !715, line: 98)
!713 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !714, line: 7, baseType: !375)
!714 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/FILE.h", directory: "")
!715 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/cstdio", directory: "")
!716 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !717, file: !715, line: 99)
!717 = !DIDerivedType(tag: DW_TAG_typedef, name: "fpos_t", file: !718, line: 78, baseType: !719)
!718 = !DIFile(filename: "/usr/include/stdio.h", directory: "")
!719 = !DIDerivedType(tag: DW_TAG_typedef, name: "_G_fpos_t", file: !720, line: 30, baseType: !721)
!720 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/_G_config.h", directory: "")
!721 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !720, line: 26, flags: DIFlagFwdDecl, identifier: "_ZTS9_G_fpos_t")
!722 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !723, file: !715, line: 101)
!723 = !DISubprogram(name: "clearerr", scope: !718, file: !718, line: 757, type: !724, flags: DIFlagPrototyped, spFlags: 0)
!724 = !DISubroutineType(types: !725)
!725 = !{null, !726}
!726 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !713, size: 64)
!727 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !728, file: !715, line: 102)
!728 = !DISubprogram(name: "fclose", scope: !718, file: !718, line: 199, type: !729, flags: DIFlagPrototyped, spFlags: 0)
!729 = !DISubroutineType(types: !730)
!730 = !{!84, !726}
!731 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !732, file: !715, line: 103)
!732 = !DISubprogram(name: "feof", scope: !718, file: !718, line: 759, type: !729, flags: DIFlagPrototyped, spFlags: 0)
!733 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !734, file: !715, line: 104)
!734 = !DISubprogram(name: "ferror", scope: !718, file: !718, line: 761, type: !729, flags: DIFlagPrototyped, spFlags: 0)
!735 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !736, file: !715, line: 105)
!736 = !DISubprogram(name: "fflush", scope: !718, file: !718, line: 204, type: !729, flags: DIFlagPrototyped, spFlags: 0)
!737 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !738, file: !715, line: 106)
!738 = !DISubprogram(name: "fgetc", scope: !718, file: !718, line: 477, type: !729, flags: DIFlagPrototyped, spFlags: 0)
!739 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !740, file: !715, line: 107)
!740 = !DISubprogram(name: "fgetpos", scope: !718, file: !718, line: 731, type: !741, flags: DIFlagPrototyped, spFlags: 0)
!741 = !DISubroutineType(types: !742)
!742 = !{!84, !743, !744}
!743 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !726)
!744 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !745)
!745 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !717, size: 64)
!746 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !747, file: !715, line: 108)
!747 = !DISubprogram(name: "fgets", scope: !718, file: !718, line: 564, type: !748, flags: DIFlagPrototyped, spFlags: 0)
!748 = !DISubroutineType(types: !749)
!749 = !{!156, !223, !84, !743}
!750 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !751, file: !715, line: 109)
!751 = !DISubprogram(name: "fopen", scope: !718, file: !718, line: 232, type: !752, flags: DIFlagPrototyped, spFlags: 0)
!752 = !DISubroutineType(types: !753)
!753 = !{!726, !180, !180}
!754 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !755, file: !715, line: 110)
!755 = !DISubprogram(name: "fprintf", scope: !718, file: !718, line: 312, type: !756, flags: DIFlagPrototyped, spFlags: 0)
!756 = !DISubroutineType(types: !757)
!757 = !{!84, !743, !180, null}
!758 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !759, file: !715, line: 111)
!759 = !DISubprogram(name: "fputc", scope: !718, file: !718, line: 517, type: !760, flags: DIFlagPrototyped, spFlags: 0)
!760 = !DISubroutineType(types: !761)
!761 = !{!84, !84, !726}
!762 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !763, file: !715, line: 112)
!763 = !DISubprogram(name: "fputs", scope: !718, file: !718, line: 626, type: !764, flags: DIFlagPrototyped, spFlags: 0)
!764 = !DISubroutineType(types: !765)
!765 = !{!84, !180, !743}
!766 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !767, file: !715, line: 113)
!767 = !DISubprogram(name: "fread", scope: !718, file: !718, line: 646, type: !768, flags: DIFlagPrototyped, spFlags: 0)
!768 = !DISubroutineType(types: !769)
!769 = !{!129, !770, !129, !129, !743}
!770 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !128)
!771 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !772, file: !715, line: 114)
!772 = !DISubprogram(name: "freopen", scope: !718, file: !718, line: 238, type: !773, flags: DIFlagPrototyped, spFlags: 0)
!773 = !DISubroutineType(types: !774)
!774 = !{!726, !180, !180, !743}
!775 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !776, file: !715, line: 115)
!776 = !DISubprogram(name: "fscanf", scope: !718, file: !718, line: 377, type: !756, flags: DIFlagPrototyped, spFlags: 0)
!777 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !778, file: !715, line: 116)
!778 = !DISubprogram(name: "fseek", scope: !718, file: !718, line: 684, type: !779, flags: DIFlagPrototyped, spFlags: 0)
!779 = !DISubroutineType(types: !780)
!780 = !{!84, !726, !95, !84}
!781 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !782, file: !715, line: 117)
!782 = !DISubprogram(name: "fsetpos", scope: !718, file: !718, line: 736, type: !783, flags: DIFlagPrototyped, spFlags: 0)
!783 = !DISubroutineType(types: !784)
!784 = !{!84, !726, !785}
!785 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !786, size: 64)
!786 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !717)
!787 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !788, file: !715, line: 118)
!788 = !DISubprogram(name: "ftell", scope: !718, file: !718, line: 689, type: !789, flags: DIFlagPrototyped, spFlags: 0)
!789 = !DISubroutineType(types: !790)
!790 = !{!95, !726}
!791 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !792, file: !715, line: 119)
!792 = !DISubprogram(name: "fwrite", scope: !718, file: !718, line: 652, type: !793, flags: DIFlagPrototyped, spFlags: 0)
!793 = !DISubroutineType(types: !794)
!794 = !{!129, !795, !129, !129, !743}
!795 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !71)
!796 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !797, file: !715, line: 120)
!797 = !DISubprogram(name: "getc", scope: !718, file: !718, line: 478, type: !729, flags: DIFlagPrototyped, spFlags: 0)
!798 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !799, file: !715, line: 121)
!799 = !DISubprogram(name: "getchar", scope: !718, file: !718, line: 484, type: !193, flags: DIFlagPrototyped, spFlags: 0)
!800 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !801, file: !715, line: 124)
!801 = !DISubprogram(name: "gets", scope: !718, file: !718, line: 577, type: !802, flags: DIFlagPrototyped, spFlags: 0)
!802 = !DISubroutineType(types: !803)
!803 = !{!156, !156}
!804 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !805, file: !715, line: 126)
!805 = !DISubprogram(name: "perror", scope: !718, file: !718, line: 775, type: !806, flags: DIFlagPrototyped, spFlags: 0)
!806 = !DISubroutineType(types: !807)
!807 = !{null, !113}
!808 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !809, file: !715, line: 127)
!809 = !DISubprogram(name: "printf", scope: !718, file: !718, line: 318, type: !810, flags: DIFlagPrototyped, spFlags: 0)
!810 = !DISubroutineType(types: !811)
!811 = !{!84, !180, null}
!812 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !813, file: !715, line: 128)
!813 = !DISubprogram(name: "putc", scope: !718, file: !718, line: 518, type: !760, flags: DIFlagPrototyped, spFlags: 0)
!814 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !815, file: !715, line: 129)
!815 = !DISubprogram(name: "putchar", scope: !718, file: !718, line: 524, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!816 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !817, file: !715, line: 130)
!817 = !DISubprogram(name: "puts", scope: !718, file: !718, line: 632, type: !118, flags: DIFlagPrototyped, spFlags: 0)
!818 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !819, file: !715, line: 131)
!819 = !DISubprogram(name: "remove", scope: !718, file: !718, line: 144, type: !118, flags: DIFlagPrototyped, spFlags: 0)
!820 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !821, file: !715, line: 132)
!821 = !DISubprogram(name: "rename", scope: !718, file: !718, line: 146, type: !822, flags: DIFlagPrototyped, spFlags: 0)
!822 = !DISubroutineType(types: !823)
!823 = !{!84, !113, !113}
!824 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !825, file: !715, line: 133)
!825 = !DISubprogram(name: "rewind", scope: !718, file: !718, line: 694, type: !724, flags: DIFlagPrototyped, spFlags: 0)
!826 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !827, file: !715, line: 134)
!827 = !DISubprogram(name: "scanf", scope: !718, file: !718, line: 383, type: !810, flags: DIFlagPrototyped, spFlags: 0)
!828 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !829, file: !715, line: 135)
!829 = !DISubprogram(name: "setbuf", scope: !718, file: !718, line: 290, type: !830, flags: DIFlagPrototyped, spFlags: 0)
!830 = !DISubroutineType(types: !831)
!831 = !{null, !743, !223}
!832 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !833, file: !715, line: 136)
!833 = !DISubprogram(name: "setvbuf", scope: !718, file: !718, line: 294, type: !834, flags: DIFlagPrototyped, spFlags: 0)
!834 = !DISubroutineType(types: !835)
!835 = !{!84, !743, !223, !84, !129}
!836 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !837, file: !715, line: 137)
!837 = !DISubprogram(name: "sprintf", scope: !718, file: !718, line: 320, type: !838, flags: DIFlagPrototyped, spFlags: 0)
!838 = !DISubroutineType(types: !839)
!839 = !{!84, !223, !180, null}
!840 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !841, file: !715, line: 138)
!841 = !DISubprogram(name: "sscanf", scope: !718, file: !718, line: 385, type: !842, flags: DIFlagPrototyped, spFlags: 0)
!842 = !DISubroutineType(types: !843)
!843 = !{!84, !180, !180, null}
!844 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !845, file: !715, line: 139)
!845 = !DISubprogram(name: "tmpfile", scope: !718, file: !718, line: 159, type: !846, flags: DIFlagPrototyped, spFlags: 0)
!846 = !DISubroutineType(types: !847)
!847 = !{!726}
!848 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !849, file: !715, line: 141)
!849 = !DISubprogram(name: "tmpnam", scope: !718, file: !718, line: 173, type: !802, flags: DIFlagPrototyped, spFlags: 0)
!850 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !851, file: !715, line: 143)
!851 = !DISubprogram(name: "ungetc", scope: !718, file: !718, line: 639, type: !760, flags: DIFlagPrototyped, spFlags: 0)
!852 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !853, file: !715, line: 144)
!853 = !DISubprogram(name: "vfprintf", scope: !718, file: !718, line: 327, type: !854, flags: DIFlagPrototyped, spFlags: 0)
!854 = !DISubroutineType(types: !855)
!855 = !{!84, !743, !180, !449}
!856 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !857, file: !715, line: 145)
!857 = !DISubprogram(name: "vprintf", scope: !718, file: !718, line: 333, type: !858, flags: DIFlagPrototyped, spFlags: 0)
!858 = !DISubroutineType(types: !859)
!859 = !{!84, !180, !449}
!860 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !861, file: !715, line: 146)
!861 = !DISubprogram(name: "vsprintf", scope: !718, file: !718, line: 335, type: !862, flags: DIFlagPrototyped, spFlags: 0)
!862 = !DISubroutineType(types: !863)
!863 = !{!84, !223, !180, !449}
!864 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !865, file: !715, line: 175)
!865 = !DISubprogram(name: "snprintf", scope: !718, file: !718, line: 340, type: !866, flags: DIFlagPrototyped, spFlags: 0)
!866 = !DISubroutineType(types: !867)
!867 = !{!84, !223, !129, !180, null}
!868 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !869, file: !715, line: 176)
!869 = !DISubprogram(name: "vfscanf", scope: !718, file: !718, line: 420, type: !854, flags: DIFlagPrototyped, spFlags: 0)
!870 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !871, file: !715, line: 177)
!871 = !DISubprogram(name: "vscanf", scope: !718, file: !718, line: 428, type: !858, flags: DIFlagPrototyped, spFlags: 0)
!872 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !873, file: !715, line: 178)
!873 = !DISubprogram(name: "vsnprintf", scope: !718, file: !718, line: 344, type: !874, flags: DIFlagPrototyped, spFlags: 0)
!874 = !DISubroutineType(types: !875)
!875 = !{!84, !223, !129, !180, !449}
!876 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !232, entity: !877, file: !715, line: 179)
!877 = !DISubprogram(name: "vsscanf", scope: !718, file: !718, line: 432, type: !878, flags: DIFlagPrototyped, spFlags: 0)
!878 = !DISubroutineType(types: !879)
!879 = !{!84, !180, !180, !449}
!880 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !865, file: !715, line: 185)
!881 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !869, file: !715, line: 186)
!882 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !871, file: !715, line: 187)
!883 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !873, file: !715, line: 188)
!884 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !877, file: !715, line: 189)
!885 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !886, file: !890, line: 83)
!886 = !DISubprogram(name: "acos", scope: !887, file: !887, line: 53, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!887 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/mathcalls.h", directory: "")
!888 = !DISubroutineType(types: !889)
!889 = !{!112, !112}
!890 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/cmath", directory: "")
!891 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !892, file: !890, line: 102)
!892 = !DISubprogram(name: "asin", scope: !887, file: !887, line: 55, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!893 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !894, file: !890, line: 121)
!894 = !DISubprogram(name: "atan", scope: !887, file: !887, line: 57, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!895 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !896, file: !890, line: 140)
!896 = !DISubprogram(name: "atan2", scope: !887, file: !887, line: 59, type: !897, flags: DIFlagPrototyped, spFlags: 0)
!897 = !DISubroutineType(types: !898)
!898 = !{!112, !112, !112}
!899 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !900, file: !890, line: 161)
!900 = !DISubprogram(name: "ceil", scope: !887, file: !887, line: 159, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!901 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !902, file: !890, line: 180)
!902 = !DISubprogram(name: "cos", scope: !887, file: !887, line: 62, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!903 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !904, file: !890, line: 199)
!904 = !DISubprogram(name: "cosh", scope: !887, file: !887, line: 71, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!905 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !906, file: !890, line: 218)
!906 = !DISubprogram(name: "exp", scope: !887, file: !887, line: 95, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!907 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !908, file: !890, line: 237)
!908 = !DISubprogram(name: "fabs", scope: !887, file: !887, line: 162, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!909 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !910, file: !890, line: 256)
!910 = !DISubprogram(name: "floor", scope: !887, file: !887, line: 165, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!911 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !912, file: !890, line: 275)
!912 = !DISubprogram(name: "fmod", scope: !887, file: !887, line: 168, type: !897, flags: DIFlagPrototyped, spFlags: 0)
!913 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !914, file: !890, line: 296)
!914 = !DISubprogram(name: "frexp", scope: !887, file: !887, line: 98, type: !915, flags: DIFlagPrototyped, spFlags: 0)
!915 = !DISubroutineType(types: !916)
!916 = !{!112, !112, !917}
!917 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !84, size: 64)
!918 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !919, file: !890, line: 315)
!919 = !DISubprogram(name: "ldexp", scope: !887, file: !887, line: 101, type: !920, flags: DIFlagPrototyped, spFlags: 0)
!920 = !DISubroutineType(types: !921)
!921 = !{!112, !112, !84}
!922 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !923, file: !890, line: 334)
!923 = !DISubprogram(name: "log", scope: !887, file: !887, line: 104, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!924 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !925, file: !890, line: 353)
!925 = !DISubprogram(name: "log10", scope: !887, file: !887, line: 107, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!926 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !927, file: !890, line: 372)
!927 = !DISubprogram(name: "modf", scope: !887, file: !887, line: 110, type: !928, flags: DIFlagPrototyped, spFlags: 0)
!928 = !DISubroutineType(types: !929)
!929 = !{!112, !112, !930}
!930 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 64)
!931 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !932, file: !890, line: 384)
!932 = !DISubprogram(name: "pow", scope: !887, file: !887, line: 140, type: !897, flags: DIFlagPrototyped, spFlags: 0)
!933 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !934, file: !890, line: 421)
!934 = !DISubprogram(name: "sin", scope: !887, file: !887, line: 64, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!935 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !936, file: !890, line: 440)
!936 = !DISubprogram(name: "sinh", scope: !887, file: !887, line: 73, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!937 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !938, file: !890, line: 459)
!938 = !DISubprogram(name: "sqrt", scope: !887, file: !887, line: 143, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!939 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !940, file: !890, line: 478)
!940 = !DISubprogram(name: "tan", scope: !887, file: !887, line: 66, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!941 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !942, file: !890, line: 497)
!942 = !DISubprogram(name: "tanh", scope: !887, file: !887, line: 75, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!943 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !944, file: !890, line: 1080)
!944 = !DIDerivedType(tag: DW_TAG_typedef, name: "double_t", file: !945, line: 150, baseType: !112)
!945 = !DIFile(filename: "/usr/include/math.h", directory: "")
!946 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !947, file: !890, line: 1081)
!947 = !DIDerivedType(tag: DW_TAG_typedef, name: "float_t", file: !945, line: 149, baseType: !266)
!948 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !949, file: !890, line: 1084)
!949 = !DISubprogram(name: "acosh", scope: !887, file: !887, line: 85, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!950 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !951, file: !890, line: 1085)
!951 = !DISubprogram(name: "acoshf", scope: !887, file: !887, line: 85, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!952 = !DISubroutineType(types: !953)
!953 = !{!266, !266}
!954 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !955, file: !890, line: 1086)
!955 = !DISubprogram(name: "acoshl", scope: !887, file: !887, line: 85, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!956 = !DISubroutineType(types: !957)
!957 = !{!271, !271}
!958 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !959, file: !890, line: 1088)
!959 = !DISubprogram(name: "asinh", scope: !887, file: !887, line: 87, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!960 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !961, file: !890, line: 1089)
!961 = !DISubprogram(name: "asinhf", scope: !887, file: !887, line: 87, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!962 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !963, file: !890, line: 1090)
!963 = !DISubprogram(name: "asinhl", scope: !887, file: !887, line: 87, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!964 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !965, file: !890, line: 1092)
!965 = !DISubprogram(name: "atanh", scope: !887, file: !887, line: 89, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!966 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !967, file: !890, line: 1093)
!967 = !DISubprogram(name: "atanhf", scope: !887, file: !887, line: 89, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!968 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !969, file: !890, line: 1094)
!969 = !DISubprogram(name: "atanhl", scope: !887, file: !887, line: 89, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!970 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !971, file: !890, line: 1096)
!971 = !DISubprogram(name: "cbrt", scope: !887, file: !887, line: 152, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!972 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !973, file: !890, line: 1097)
!973 = !DISubprogram(name: "cbrtf", scope: !887, file: !887, line: 152, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!974 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !975, file: !890, line: 1098)
!975 = !DISubprogram(name: "cbrtl", scope: !887, file: !887, line: 152, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!976 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !977, file: !890, line: 1100)
!977 = !DISubprogram(name: "copysign", scope: !887, file: !887, line: 196, type: !897, flags: DIFlagPrototyped, spFlags: 0)
!978 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !979, file: !890, line: 1101)
!979 = !DISubprogram(name: "copysignf", scope: !887, file: !887, line: 196, type: !980, flags: DIFlagPrototyped, spFlags: 0)
!980 = !DISubroutineType(types: !981)
!981 = !{!266, !266, !266}
!982 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !983, file: !890, line: 1102)
!983 = !DISubprogram(name: "copysignl", scope: !887, file: !887, line: 196, type: !984, flags: DIFlagPrototyped, spFlags: 0)
!984 = !DISubroutineType(types: !985)
!985 = !{!271, !271, !271}
!986 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !987, file: !890, line: 1104)
!987 = !DISubprogram(name: "erf", scope: !887, file: !887, line: 228, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!988 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !989, file: !890, line: 1105)
!989 = !DISubprogram(name: "erff", scope: !887, file: !887, line: 228, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!990 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !991, file: !890, line: 1106)
!991 = !DISubprogram(name: "erfl", scope: !887, file: !887, line: 228, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!992 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !993, file: !890, line: 1108)
!993 = !DISubprogram(name: "erfc", scope: !887, file: !887, line: 229, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!994 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !995, file: !890, line: 1109)
!995 = !DISubprogram(name: "erfcf", scope: !887, file: !887, line: 229, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!996 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !997, file: !890, line: 1110)
!997 = !DISubprogram(name: "erfcl", scope: !887, file: !887, line: 229, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!998 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !999, file: !890, line: 1112)
!999 = !DISubprogram(name: "exp2", scope: !887, file: !887, line: 130, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!1000 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1001, file: !890, line: 1113)
!1001 = !DISubprogram(name: "exp2f", scope: !887, file: !887, line: 130, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!1002 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1003, file: !890, line: 1114)
!1003 = !DISubprogram(name: "exp2l", scope: !887, file: !887, line: 130, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!1004 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1005, file: !890, line: 1116)
!1005 = !DISubprogram(name: "expm1", scope: !887, file: !887, line: 119, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!1006 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1007, file: !890, line: 1117)
!1007 = !DISubprogram(name: "expm1f", scope: !887, file: !887, line: 119, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!1008 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1009, file: !890, line: 1118)
!1009 = !DISubprogram(name: "expm1l", scope: !887, file: !887, line: 119, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!1010 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1011, file: !890, line: 1120)
!1011 = !DISubprogram(name: "fdim", scope: !887, file: !887, line: 326, type: !897, flags: DIFlagPrototyped, spFlags: 0)
!1012 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1013, file: !890, line: 1121)
!1013 = !DISubprogram(name: "fdimf", scope: !887, file: !887, line: 326, type: !980, flags: DIFlagPrototyped, spFlags: 0)
!1014 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1015, file: !890, line: 1122)
!1015 = !DISubprogram(name: "fdiml", scope: !887, file: !887, line: 326, type: !984, flags: DIFlagPrototyped, spFlags: 0)
!1016 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1017, file: !890, line: 1124)
!1017 = !DISubprogram(name: "fma", scope: !887, file: !887, line: 335, type: !1018, flags: DIFlagPrototyped, spFlags: 0)
!1018 = !DISubroutineType(types: !1019)
!1019 = !{!112, !112, !112, !112}
!1020 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1021, file: !890, line: 1125)
!1021 = !DISubprogram(name: "fmaf", scope: !887, file: !887, line: 335, type: !1022, flags: DIFlagPrototyped, spFlags: 0)
!1022 = !DISubroutineType(types: !1023)
!1023 = !{!266, !266, !266, !266}
!1024 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1025, file: !890, line: 1126)
!1025 = !DISubprogram(name: "fmal", scope: !887, file: !887, line: 335, type: !1026, flags: DIFlagPrototyped, spFlags: 0)
!1026 = !DISubroutineType(types: !1027)
!1027 = !{!271, !271, !271, !271}
!1028 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1029, file: !890, line: 1128)
!1029 = !DISubprogram(name: "fmax", scope: !887, file: !887, line: 329, type: !897, flags: DIFlagPrototyped, spFlags: 0)
!1030 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1031, file: !890, line: 1129)
!1031 = !DISubprogram(name: "fmaxf", scope: !887, file: !887, line: 329, type: !980, flags: DIFlagPrototyped, spFlags: 0)
!1032 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1033, file: !890, line: 1130)
!1033 = !DISubprogram(name: "fmaxl", scope: !887, file: !887, line: 329, type: !984, flags: DIFlagPrototyped, spFlags: 0)
!1034 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1035, file: !890, line: 1132)
!1035 = !DISubprogram(name: "fmin", scope: !887, file: !887, line: 332, type: !897, flags: DIFlagPrototyped, spFlags: 0)
!1036 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1037, file: !890, line: 1133)
!1037 = !DISubprogram(name: "fminf", scope: !887, file: !887, line: 332, type: !980, flags: DIFlagPrototyped, spFlags: 0)
!1038 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1039, file: !890, line: 1134)
!1039 = !DISubprogram(name: "fminl", scope: !887, file: !887, line: 332, type: !984, flags: DIFlagPrototyped, spFlags: 0)
!1040 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1041, file: !890, line: 1136)
!1041 = !DISubprogram(name: "hypot", scope: !887, file: !887, line: 147, type: !897, flags: DIFlagPrototyped, spFlags: 0)
!1042 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1043, file: !890, line: 1137)
!1043 = !DISubprogram(name: "hypotf", scope: !887, file: !887, line: 147, type: !980, flags: DIFlagPrototyped, spFlags: 0)
!1044 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1045, file: !890, line: 1138)
!1045 = !DISubprogram(name: "hypotl", scope: !887, file: !887, line: 147, type: !984, flags: DIFlagPrototyped, spFlags: 0)
!1046 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1047, file: !890, line: 1140)
!1047 = !DISubprogram(name: "ilogb", scope: !887, file: !887, line: 280, type: !1048, flags: DIFlagPrototyped, spFlags: 0)
!1048 = !DISubroutineType(types: !1049)
!1049 = !{!84, !112}
!1050 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1051, file: !890, line: 1141)
!1051 = !DISubprogram(name: "ilogbf", scope: !887, file: !887, line: 280, type: !1052, flags: DIFlagPrototyped, spFlags: 0)
!1052 = !DISubroutineType(types: !1053)
!1053 = !{!84, !266}
!1054 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1055, file: !890, line: 1142)
!1055 = !DISubprogram(name: "ilogbl", scope: !887, file: !887, line: 280, type: !1056, flags: DIFlagPrototyped, spFlags: 0)
!1056 = !DISubroutineType(types: !1057)
!1057 = !{!84, !271}
!1058 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1059, file: !890, line: 1144)
!1059 = !DISubprogram(name: "lgamma", scope: !887, file: !887, line: 230, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!1060 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1061, file: !890, line: 1145)
!1061 = !DISubprogram(name: "lgammaf", scope: !887, file: !887, line: 230, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!1062 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1063, file: !890, line: 1146)
!1063 = !DISubprogram(name: "lgammal", scope: !887, file: !887, line: 230, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!1064 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1065, file: !890, line: 1149)
!1065 = !DISubprogram(name: "llrint", scope: !887, file: !887, line: 316, type: !1066, flags: DIFlagPrototyped, spFlags: 0)
!1066 = !DISubroutineType(types: !1067)
!1067 = !{!237, !112}
!1068 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1069, file: !890, line: 1150)
!1069 = !DISubprogram(name: "llrintf", scope: !887, file: !887, line: 316, type: !1070, flags: DIFlagPrototyped, spFlags: 0)
!1070 = !DISubroutineType(types: !1071)
!1071 = !{!237, !266}
!1072 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1073, file: !890, line: 1151)
!1073 = !DISubprogram(name: "llrintl", scope: !887, file: !887, line: 316, type: !1074, flags: DIFlagPrototyped, spFlags: 0)
!1074 = !DISubroutineType(types: !1075)
!1075 = !{!237, !271}
!1076 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1077, file: !890, line: 1153)
!1077 = !DISubprogram(name: "llround", scope: !887, file: !887, line: 322, type: !1066, flags: DIFlagPrototyped, spFlags: 0)
!1078 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1079, file: !890, line: 1154)
!1079 = !DISubprogram(name: "llroundf", scope: !887, file: !887, line: 322, type: !1070, flags: DIFlagPrototyped, spFlags: 0)
!1080 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1081, file: !890, line: 1155)
!1081 = !DISubprogram(name: "llroundl", scope: !887, file: !887, line: 322, type: !1074, flags: DIFlagPrototyped, spFlags: 0)
!1082 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1083, file: !890, line: 1158)
!1083 = !DISubprogram(name: "log1p", scope: !887, file: !887, line: 122, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!1084 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1085, file: !890, line: 1159)
!1085 = !DISubprogram(name: "log1pf", scope: !887, file: !887, line: 122, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!1086 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1087, file: !890, line: 1160)
!1087 = !DISubprogram(name: "log1pl", scope: !887, file: !887, line: 122, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!1088 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1089, file: !890, line: 1162)
!1089 = !DISubprogram(name: "log2", scope: !887, file: !887, line: 133, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!1090 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1091, file: !890, line: 1163)
!1091 = !DISubprogram(name: "log2f", scope: !887, file: !887, line: 133, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!1092 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1093, file: !890, line: 1164)
!1093 = !DISubprogram(name: "log2l", scope: !887, file: !887, line: 133, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!1094 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1095, file: !890, line: 1166)
!1095 = !DISubprogram(name: "logb", scope: !887, file: !887, line: 125, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!1096 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1097, file: !890, line: 1167)
!1097 = !DISubprogram(name: "logbf", scope: !887, file: !887, line: 125, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!1098 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1099, file: !890, line: 1168)
!1099 = !DISubprogram(name: "logbl", scope: !887, file: !887, line: 125, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!1100 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1101, file: !890, line: 1170)
!1101 = !DISubprogram(name: "lrint", scope: !887, file: !887, line: 314, type: !1102, flags: DIFlagPrototyped, spFlags: 0)
!1102 = !DISubroutineType(types: !1103)
!1103 = !{!95, !112}
!1104 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1105, file: !890, line: 1171)
!1105 = !DISubprogram(name: "lrintf", scope: !887, file: !887, line: 314, type: !1106, flags: DIFlagPrototyped, spFlags: 0)
!1106 = !DISubroutineType(types: !1107)
!1107 = !{!95, !266}
!1108 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1109, file: !890, line: 1172)
!1109 = !DISubprogram(name: "lrintl", scope: !887, file: !887, line: 314, type: !1110, flags: DIFlagPrototyped, spFlags: 0)
!1110 = !DISubroutineType(types: !1111)
!1111 = !{!95, !271}
!1112 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1113, file: !890, line: 1174)
!1113 = !DISubprogram(name: "lround", scope: !887, file: !887, line: 320, type: !1102, flags: DIFlagPrototyped, spFlags: 0)
!1114 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1115, file: !890, line: 1175)
!1115 = !DISubprogram(name: "lroundf", scope: !887, file: !887, line: 320, type: !1106, flags: DIFlagPrototyped, spFlags: 0)
!1116 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1117, file: !890, line: 1176)
!1117 = !DISubprogram(name: "lroundl", scope: !887, file: !887, line: 320, type: !1110, flags: DIFlagPrototyped, spFlags: 0)
!1118 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1119, file: !890, line: 1178)
!1119 = !DISubprogram(name: "nan", scope: !887, file: !887, line: 201, type: !110, flags: DIFlagPrototyped, spFlags: 0)
!1120 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1121, file: !890, line: 1179)
!1121 = !DISubprogram(name: "nanf", scope: !887, file: !887, line: 201, type: !1122, flags: DIFlagPrototyped, spFlags: 0)
!1122 = !DISubroutineType(types: !1123)
!1123 = !{!266, !113}
!1124 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1125, file: !890, line: 1180)
!1125 = !DISubprogram(name: "nanl", scope: !887, file: !887, line: 201, type: !1126, flags: DIFlagPrototyped, spFlags: 0)
!1126 = !DISubroutineType(types: !1127)
!1127 = !{!271, !113}
!1128 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1129, file: !890, line: 1182)
!1129 = !DISubprogram(name: "nearbyint", scope: !887, file: !887, line: 294, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!1130 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1131, file: !890, line: 1183)
!1131 = !DISubprogram(name: "nearbyintf", scope: !887, file: !887, line: 294, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!1132 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1133, file: !890, line: 1184)
!1133 = !DISubprogram(name: "nearbyintl", scope: !887, file: !887, line: 294, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!1134 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1135, file: !890, line: 1186)
!1135 = !DISubprogram(name: "nextafter", scope: !887, file: !887, line: 259, type: !897, flags: DIFlagPrototyped, spFlags: 0)
!1136 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1137, file: !890, line: 1187)
!1137 = !DISubprogram(name: "nextafterf", scope: !887, file: !887, line: 259, type: !980, flags: DIFlagPrototyped, spFlags: 0)
!1138 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1139, file: !890, line: 1188)
!1139 = !DISubprogram(name: "nextafterl", scope: !887, file: !887, line: 259, type: !984, flags: DIFlagPrototyped, spFlags: 0)
!1140 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1141, file: !890, line: 1190)
!1141 = !DISubprogram(name: "nexttoward", scope: !887, file: !887, line: 261, type: !1142, flags: DIFlagPrototyped, spFlags: 0)
!1142 = !DISubroutineType(types: !1143)
!1143 = !{!112, !112, !271}
!1144 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1145, file: !890, line: 1191)
!1145 = !DISubprogram(name: "nexttowardf", scope: !887, file: !887, line: 261, type: !1146, flags: DIFlagPrototyped, spFlags: 0)
!1146 = !DISubroutineType(types: !1147)
!1147 = !{!266, !266, !271}
!1148 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1149, file: !890, line: 1192)
!1149 = !DISubprogram(name: "nexttowardl", scope: !887, file: !887, line: 261, type: !984, flags: DIFlagPrototyped, spFlags: 0)
!1150 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1151, file: !890, line: 1194)
!1151 = !DISubprogram(name: "remainder", scope: !887, file: !887, line: 272, type: !897, flags: DIFlagPrototyped, spFlags: 0)
!1152 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1153, file: !890, line: 1195)
!1153 = !DISubprogram(name: "remainderf", scope: !887, file: !887, line: 272, type: !980, flags: DIFlagPrototyped, spFlags: 0)
!1154 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1155, file: !890, line: 1196)
!1155 = !DISubprogram(name: "remainderl", scope: !887, file: !887, line: 272, type: !984, flags: DIFlagPrototyped, spFlags: 0)
!1156 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1157, file: !890, line: 1198)
!1157 = !DISubprogram(name: "remquo", scope: !887, file: !887, line: 307, type: !1158, flags: DIFlagPrototyped, spFlags: 0)
!1158 = !DISubroutineType(types: !1159)
!1159 = !{!112, !112, !112, !917}
!1160 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1161, file: !890, line: 1199)
!1161 = !DISubprogram(name: "remquof", scope: !887, file: !887, line: 307, type: !1162, flags: DIFlagPrototyped, spFlags: 0)
!1162 = !DISubroutineType(types: !1163)
!1163 = !{!266, !266, !266, !917}
!1164 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1165, file: !890, line: 1200)
!1165 = !DISubprogram(name: "remquol", scope: !887, file: !887, line: 307, type: !1166, flags: DIFlagPrototyped, spFlags: 0)
!1166 = !DISubroutineType(types: !1167)
!1167 = !{!271, !271, !271, !917}
!1168 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1169, file: !890, line: 1202)
!1169 = !DISubprogram(name: "rint", scope: !887, file: !887, line: 256, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!1170 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1171, file: !890, line: 1203)
!1171 = !DISubprogram(name: "rintf", scope: !887, file: !887, line: 256, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!1172 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1173, file: !890, line: 1204)
!1173 = !DISubprogram(name: "rintl", scope: !887, file: !887, line: 256, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!1174 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1175, file: !890, line: 1206)
!1175 = !DISubprogram(name: "round", scope: !887, file: !887, line: 298, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!1176 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1177, file: !890, line: 1207)
!1177 = !DISubprogram(name: "roundf", scope: !887, file: !887, line: 298, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!1178 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1179, file: !890, line: 1208)
!1179 = !DISubprogram(name: "roundl", scope: !887, file: !887, line: 298, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!1180 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1181, file: !890, line: 1210)
!1181 = !DISubprogram(name: "scalbln", scope: !887, file: !887, line: 290, type: !1182, flags: DIFlagPrototyped, spFlags: 0)
!1182 = !DISubroutineType(types: !1183)
!1183 = !{!112, !112, !95}
!1184 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1185, file: !890, line: 1211)
!1185 = !DISubprogram(name: "scalblnf", scope: !887, file: !887, line: 290, type: !1186, flags: DIFlagPrototyped, spFlags: 0)
!1186 = !DISubroutineType(types: !1187)
!1187 = !{!266, !266, !95}
!1188 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1189, file: !890, line: 1212)
!1189 = !DISubprogram(name: "scalblnl", scope: !887, file: !887, line: 290, type: !1190, flags: DIFlagPrototyped, spFlags: 0)
!1190 = !DISubroutineType(types: !1191)
!1191 = !{!271, !271, !95}
!1192 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1193, file: !890, line: 1214)
!1193 = !DISubprogram(name: "scalbn", scope: !887, file: !887, line: 276, type: !920, flags: DIFlagPrototyped, spFlags: 0)
!1194 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1195, file: !890, line: 1215)
!1195 = !DISubprogram(name: "scalbnf", scope: !887, file: !887, line: 276, type: !1196, flags: DIFlagPrototyped, spFlags: 0)
!1196 = !DISubroutineType(types: !1197)
!1197 = !{!266, !266, !84}
!1198 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1199, file: !890, line: 1216)
!1199 = !DISubprogram(name: "scalbnl", scope: !887, file: !887, line: 276, type: !1200, flags: DIFlagPrototyped, spFlags: 0)
!1200 = !DISubroutineType(types: !1201)
!1201 = !{!271, !271, !84}
!1202 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1203, file: !890, line: 1218)
!1203 = !DISubprogram(name: "tgamma", scope: !887, file: !887, line: 235, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!1204 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1205, file: !890, line: 1219)
!1205 = !DISubprogram(name: "tgammaf", scope: !887, file: !887, line: 235, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!1206 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1207, file: !890, line: 1220)
!1207 = !DISubprogram(name: "tgammal", scope: !887, file: !887, line: 235, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!1208 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1209, file: !890, line: 1222)
!1209 = !DISubprogram(name: "trunc", scope: !887, file: !887, line: 302, type: !888, flags: DIFlagPrototyped, spFlags: 0)
!1210 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1211, file: !890, line: 1223)
!1211 = !DISubprogram(name: "truncf", scope: !887, file: !887, line: 302, type: !952, flags: DIFlagPrototyped, spFlags: 0)
!1212 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1213, file: !890, line: 1224)
!1213 = !DISubprogram(name: "truncl", scope: !887, file: !887, line: 302, type: !956, flags: DIFlagPrototyped, spFlags: 0)
!1214 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1215, file: !1218, line: 58)
!1215 = !DIDerivedType(tag: DW_TAG_typedef, name: "fenv_t", file: !1216, line: 94, baseType: !1217)
!1216 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/fenv.h", directory: "")
!1217 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1216, line: 75, flags: DIFlagFwdDecl, identifier: "_ZTS6fenv_t")
!1218 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/fenv.h", directory: "")
!1219 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1220, file: !1218, line: 59)
!1220 = !DIDerivedType(tag: DW_TAG_typedef, name: "fexcept_t", file: !1216, line: 68, baseType: !32)
!1221 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1222, file: !1218, line: 62)
!1222 = !DISubprogram(name: "feclearexcept", scope: !1223, file: !1223, line: 71, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!1223 = !DIFile(filename: "/usr/include/fenv.h", directory: "")
!1224 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1225, file: !1218, line: 63)
!1225 = !DISubprogram(name: "fegetexceptflag", scope: !1223, file: !1223, line: 75, type: !1226, flags: DIFlagPrototyped, spFlags: 0)
!1226 = !DISubroutineType(types: !1227)
!1227 = !{!84, !1228, !84}
!1228 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1220, size: 64)
!1229 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1230, file: !1218, line: 64)
!1230 = !DISubprogram(name: "feraiseexcept", scope: !1223, file: !1223, line: 78, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!1231 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1232, file: !1218, line: 65)
!1232 = !DISubprogram(name: "fesetexceptflag", scope: !1223, file: !1223, line: 88, type: !1233, flags: DIFlagPrototyped, spFlags: 0)
!1233 = !DISubroutineType(types: !1234)
!1234 = !{!84, !1235, !84}
!1235 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1236, size: 64)
!1236 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1220)
!1237 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1238, file: !1218, line: 66)
!1238 = !DISubprogram(name: "fetestexcept", scope: !1223, file: !1223, line: 92, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!1239 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1240, file: !1218, line: 68)
!1240 = !DISubprogram(name: "fegetround", scope: !1223, file: !1223, line: 104, type: !193, flags: DIFlagPrototyped, spFlags: 0)
!1241 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1242, file: !1218, line: 69)
!1242 = !DISubprogram(name: "fesetround", scope: !1223, file: !1223, line: 107, type: !82, flags: DIFlagPrototyped, spFlags: 0)
!1243 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1244, file: !1218, line: 71)
!1244 = !DISubprogram(name: "fegetenv", scope: !1223, file: !1223, line: 114, type: !1245, flags: DIFlagPrototyped, spFlags: 0)
!1245 = !DISubroutineType(types: !1246)
!1246 = !{!84, !1247}
!1247 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1215, size: 64)
!1248 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1249, file: !1218, line: 72)
!1249 = !DISubprogram(name: "feholdexcept", scope: !1223, file: !1223, line: 119, type: !1245, flags: DIFlagPrototyped, spFlags: 0)
!1250 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1251, file: !1218, line: 73)
!1251 = !DISubprogram(name: "fesetenv", scope: !1223, file: !1223, line: 123, type: !1252, flags: DIFlagPrototyped, spFlags: 0)
!1252 = !DISubroutineType(types: !1253)
!1253 = !{!84, !1254}
!1254 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1255, size: 64)
!1255 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1215)
!1256 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1257, file: !1218, line: 74)
!1257 = !DISubprogram(name: "feupdateenv", scope: !1223, file: !1223, line: 128, type: !1252, flags: DIFlagPrototyped, spFlags: 0)
!1258 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1215, file: !1259, line: 61)
!1259 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/cfenv", directory: "")
!1260 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1220, file: !1259, line: 62)
!1261 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1222, file: !1259, line: 65)
!1262 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1225, file: !1259, line: 66)
!1263 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1230, file: !1259, line: 67)
!1264 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1232, file: !1259, line: 68)
!1265 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1238, file: !1259, line: 69)
!1266 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1240, file: !1259, line: 71)
!1267 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1242, file: !1259, line: 72)
!1268 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1244, file: !1259, line: 74)
!1269 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1249, file: !1259, line: 75)
!1270 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1251, file: !1259, line: 76)
!1271 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !77, entity: !1257, file: !1259, line: 77)
!1272 = !{!"base.helper.semantics"}
!1273 = !{!"base.external.cfgexternal"}
!1274 = !{!"base.lifted"}
!1275 = !{!1276, !1276, i64 0}
!1276 = !{!"omnipotent char", !1277, i64 0}
!1277 = !{!"Simple C++ TBAA"}
!1278 = !{!1279, !1279, i64 0}
!1279 = !{!"int", !1276, i64 0}
!1280 = !{!1281, !1276, i64 2065}
!1281 = !{!"_ZTS5State", !1276, i64 16, !1282, i64 2064, !1276, i64 2080, !1283, i64 2088, !1285, i64 2112, !1288, i64 2208, !1289, i64 2480, !1290, i64 2608, !1291, i64 2736, !1276, i64 2760, !1276, i64 2768, !1292, i64 3280}
!1282 = !{!"_ZTS10ArithFlags", !1276, i64 0, !1276, i64 1, !1276, i64 2, !1276, i64 3, !1276, i64 4, !1276, i64 5, !1276, i64 6, !1276, i64 7, !1276, i64 8, !1276, i64 9, !1276, i64 10, !1276, i64 11, !1276, i64 12, !1276, i64 13, !1276, i64 14, !1276, i64 15}
!1283 = !{!"_ZTS8Segments", !1284, i64 0, !1276, i64 2, !1284, i64 4, !1276, i64 6, !1284, i64 8, !1276, i64 10, !1284, i64 12, !1276, i64 14, !1284, i64 16, !1276, i64 18, !1284, i64 20, !1276, i64 22}
!1284 = !{!"short", !1276, i64 0}
!1285 = !{!"_ZTS12AddressSpace", !1286, i64 0, !1287, i64 8, !1286, i64 16, !1287, i64 24, !1286, i64 32, !1287, i64 40, !1286, i64 48, !1287, i64 56, !1286, i64 64, !1287, i64 72, !1286, i64 80, !1287, i64 88}
!1286 = !{!"long", !1276, i64 0}
!1287 = !{!"_ZTS3Reg", !1276, i64 0, !1279, i64 4}
!1288 = !{!"_ZTS3GPR", !1286, i64 0, !1287, i64 8, !1286, i64 16, !1287, i64 24, !1286, i64 32, !1287, i64 40, !1286, i64 48, !1287, i64 56, !1286, i64 64, !1287, i64 72, !1286, i64 80, !1287, i64 88, !1286, i64 96, !1287, i64 104, !1286, i64 112, !1287, i64 120, !1286, i64 128, !1287, i64 136, !1286, i64 144, !1287, i64 152, !1286, i64 160, !1287, i64 168, !1286, i64 176, !1287, i64 184, !1286, i64 192, !1287, i64 200, !1286, i64 208, !1287, i64 216, !1286, i64 224, !1287, i64 232, !1286, i64 240, !1287, i64 248, !1286, i64 256, !1287, i64 264}
!1289 = !{!"_ZTS8X87Stack", !1276, i64 0}
!1290 = !{!"_ZTS3MMX", !1276, i64 0}
!1291 = !{!"_ZTS14FPUStatusFlags", !1276, i64 0, !1276, i64 1, !1276, i64 2, !1276, i64 3, !1276, i64 4, !1276, i64 5, !1276, i64 6, !1276, i64 7, !1276, i64 8, !1276, i64 9, !1276, i64 10, !1276, i64 11, !1276, i64 12, !1276, i64 13, !1276, i64 14, !1276, i64 15, !1276, i64 16, !1276, i64 17, !1276, i64 18, !1276, i64 19, !1276, i64 20}
!1292 = !{!"_ZTS13SegmentCaches", !1293, i64 0, !1293, i64 16, !1293, i64 32, !1293, i64 48, !1293, i64 64, !1293, i64 80}
!1293 = !{!"_ZTS13SegmentShadow", !1276, i64 0, !1279, i64 8, !1279, i64 12}
!1294 = !{!1281, !1276, i64 2067}
!1295 = !{!1281, !1276, i64 2069}
!1296 = !{!1281, !1276, i64 2071}
!1297 = !{!1281, !1276, i64 2073}
!1298 = !{!1281, !1276, i64 2077}
!1299 = !{void ()* @__x86.get_pc_thunk.cx}
!1300 = !{void ()* @.init_proc}
!1301 = !{i32 0, i32 9}
!1302 = !{void ()* @__x86.get_pc_thunk.bx}
!1303 = !{void ()* @get_permission}
!1304 = !{void ()* @.term_proc}
!1305 = !{void ()* @__x86.get_pc_thunk.dx}
!1306 = !{void ()* @main}
!1307 = !{[8 x i8] c"GS_BASE\00"}
!1308 = !{void ()* @change_page_permissions_of_address}
!1309 = !{!"base.helper.mcsema"}
!1310 = !{!"base.entrypoint"}
!1311 = !{%struct.Memory* (%struct.State*, i32, %struct.Memory*)* @sub_5ed_main}
!1312 = !{%struct.Memory* (%struct.State*, i32, %struct.Memory*)* @sub_5e9___x86_get_pc_thunk_dx}
!1313 = !{%struct.Memory* (%struct.State*, i32, %struct.Memory*)* @sub_804_change_page_permissions_of_address}
!1314 = !{%struct.Memory* (%struct.State*, i32, %struct.Memory*)* @sub_404__init_proc}
!1315 = !{%struct.Memory* (%struct.State*, i32, %struct.Memory*)* @sub_8d4__term_proc}
!1316 = !{%struct.Memory* (%struct.State*, i32, %struct.Memory*)* @sub_85d___x86_get_pc_thunk_cx}
!1317 = !{%struct.Memory* (%struct.State*, i32, %struct.Memory*)* @sub_4f0___x86_get_pc_thunk_bx}
!1318 = !{%struct.Memory* (%struct.State*, i32, %struct.Memory*)* @sub_7a5_get_permission}