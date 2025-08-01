; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S < %s -passes=loop-vectorize -force-vector-width=4 | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"
target triple = "aarch64--linux-gnu"

define void @test0(ptr noalias %M3, ptr noalias %A, ptr noalias %B) {
; CHECK-LABEL: define void @test0
; CHECK-SAME: (ptr noalias [[M3:%.*]], ptr noalias [[A:%.*]], ptr noalias [[B:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[INDEX]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = add i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[INDEX]], 3
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds i16, ptr [[A]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i16, ptr [[TMP4]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i16>, ptr [[TMP5]], align 2
; CHECK-NEXT:    [[TMP6:%.*]] = add <4 x i16> [[WIDE_LOAD]], splat (i16 10)
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds i64, ptr [[B]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i64, ptr [[B]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i64, ptr [[B]], i64 [[TMP2]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i64, ptr [[B]], i64 [[TMP3]]
; CHECK-NEXT:    [[TMP11:%.*]] = load i64, ptr [[TMP7]], align 8
; CHECK-NEXT:    [[TMP12:%.*]] = load i64, ptr [[TMP8]], align 8
; CHECK-NEXT:    [[TMP13:%.*]] = load i64, ptr [[TMP9]], align 8
; CHECK-NEXT:    [[TMP14:%.*]] = load i64, ptr [[TMP10]], align 8
; CHECK-NEXT:    [[TMP15:%.*]] = ashr exact i64 [[TMP11]], 32
; CHECK-NEXT:    [[TMP16:%.*]] = ashr exact i64 [[TMP12]], 32
; CHECK-NEXT:    [[TMP17:%.*]] = ashr exact i64 [[TMP13]], 32
; CHECK-NEXT:    [[TMP18:%.*]] = ashr exact i64 [[TMP14]], 32
; CHECK-NEXT:    [[TMP19:%.*]] = getelementptr inbounds i16, ptr [[M3]], i64 [[TMP15]]
; CHECK-NEXT:    [[TMP20:%.*]] = getelementptr inbounds i16, ptr [[M3]], i64 [[TMP16]]
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds i16, ptr [[M3]], i64 [[TMP17]]
; CHECK-NEXT:    [[TMP22:%.*]] = getelementptr inbounds i16, ptr [[M3]], i64 [[TMP18]]
; CHECK-NEXT:    [[TMP23:%.*]] = extractelement <4 x i16> [[TMP6]], i32 0
; CHECK-NEXT:    store i16 [[TMP23]], ptr [[TMP19]], align 2
; CHECK-NEXT:    [[TMP24:%.*]] = extractelement <4 x i16> [[TMP6]], i32 1
; CHECK-NEXT:    store i16 [[TMP24]], ptr [[TMP20]], align 2
; CHECK-NEXT:    [[TMP25:%.*]] = extractelement <4 x i16> [[TMP6]], i32 2
; CHECK-NEXT:    store i16 [[TMP25]], ptr [[TMP21]], align 2
; CHECK-NEXT:    [[TMP26:%.*]] = extractelement <4 x i16> [[TMP6]], i32 3
; CHECK-NEXT:    store i16 [[TMP26]], ptr [[TMP22]], align 2
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP27:%.*]] = icmp eq i64 [[INDEX_NEXT]], 16
; CHECK-NEXT:    br i1 [[TMP27]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br label [[FOR_INC1286_LOOPEXIT:%.*]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[IF_THEN1165_US:%.*]]
; CHECK:       if.then1165.us:
; CHECK-NEXT:    [[INDVARS_IV1783:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT1784:%.*]], [[IF_THEN1165_US]] ]
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds i16, ptr [[A]], i64 [[INDVARS_IV1783]]
; CHECK-NEXT:    [[L_A:%.*]] = load i16, ptr [[GEP_A]], align 2
; CHECK-NEXT:    [[CONV1177_US:%.*]] = zext i16 [[L_A]] to i32
; CHECK-NEXT:    [[ADD1178_US:%.*]] = add nsw i32 [[CONV1177_US]], 10
; CHECK-NEXT:    [[CONV1179_US:%.*]] = trunc i32 [[ADD1178_US]] to i16
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr inbounds i64, ptr [[B]], i64 [[INDVARS_IV1783]]
; CHECK-NEXT:    [[L_B:%.*]] = load i64, ptr [[GEP_B]], align 8
; CHECK-NEXT:    [[IDXPROM1181_US:%.*]] = ashr exact i64 [[L_B]], 32
; CHECK-NEXT:    [[ARRAYIDX1185_US:%.*]] = getelementptr inbounds i16, ptr [[M3]], i64 [[IDXPROM1181_US]]
; CHECK-NEXT:    store i16 [[CONV1179_US]], ptr [[ARRAYIDX1185_US]], align 2
; CHECK-NEXT:    [[INDVARS_IV_NEXT1784]] = add nuw nsw i64 [[INDVARS_IV1783]], 1
; CHECK-NEXT:    [[EXITCOND1785:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT1784]], 16
; CHECK-NEXT:    br i1 [[EXITCOND1785]], label [[FOR_INC1286_LOOPEXIT]], label [[IF_THEN1165_US]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       for.inc1286.loopexit:
; CHECK-NEXT:    ret void
;
entry:
  br label %if.then1165.us

if.then1165.us:                                   ; preds = %if.then1165.us, %entry
  %indvars.iv1783 = phi i64 [ 0, %entry ], [ %indvars.iv.next1784, %if.then1165.us ]
  %gep.A  = getelementptr inbounds i16, ptr %A, i64 %indvars.iv1783
  %l.A = load i16, ptr %gep.A
  %conv1177.us = zext i16 %l.A to i32
  %add1178.us = add nsw i32 %conv1177.us, 10
  %conv1179.us = trunc i32 %add1178.us to i16
  %gep.B  = getelementptr inbounds i64, ptr %B, i64 %indvars.iv1783
  %l.B = load i64, ptr %gep.B
  %idxprom1181.us = ashr exact i64 %l.B, 32
  %arrayidx1185.us = getelementptr inbounds i16, ptr %M3, i64 %idxprom1181.us
  store i16 %conv1179.us, ptr %arrayidx1185.us, align 2
  %indvars.iv.next1784 = add nuw nsw i64 %indvars.iv1783, 1
  %exitcond1785 = icmp eq i64 %indvars.iv.next1784, 16
  br i1 %exitcond1785, label %for.inc1286.loopexit, label %if.then1165.us

for.inc1286.loopexit:                             ; preds = %if.then1165.us
  ret void
}

define void @test1(ptr noalias %M3, ptr noalias %A, ptr noalias %B, ptr noalias %C) {
; CHECK-LABEL: define void @test1
; CHECK-SAME: (ptr noalias [[M3:%.*]], ptr noalias [[A:%.*]], ptr noalias [[B:%.*]], ptr noalias [[C:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP1:%.*]] = add i64 [[INDEX]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = add i64 [[INDEX]], 2
; CHECK-NEXT:    [[TMP3:%.*]] = add i64 [[INDEX]], 3
; CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr [[C]], align 4
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x i32> poison, i32 [[TMP4]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x i32> [[BROADCAST_SPLATINSERT]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds i16, ptr [[A]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds i16, ptr [[TMP5]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i16>, ptr [[TMP6]], align 2
; CHECK-NEXT:    [[TMP7:%.*]] = trunc <4 x i32> [[BROADCAST_SPLAT]] to <4 x i16>
; CHECK-NEXT:    [[TMP8:%.*]] = add <4 x i16> [[WIDE_LOAD]], [[TMP7]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds i64, ptr [[B]], i64 [[TMP0]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds i64, ptr [[B]], i64 [[TMP1]]
; CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds i64, ptr [[B]], i64 [[TMP2]]
; CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds i64, ptr [[B]], i64 [[TMP3]]
; CHECK-NEXT:    [[TMP13:%.*]] = load i64, ptr [[TMP9]], align 8
; CHECK-NEXT:    [[TMP14:%.*]] = load i64, ptr [[TMP10]], align 8
; CHECK-NEXT:    [[TMP15:%.*]] = load i64, ptr [[TMP11]], align 8
; CHECK-NEXT:    [[TMP16:%.*]] = load i64, ptr [[TMP12]], align 8
; CHECK-NEXT:    [[TMP17:%.*]] = ashr exact i64 [[TMP13]], 32
; CHECK-NEXT:    [[TMP18:%.*]] = ashr exact i64 [[TMP14]], 32
; CHECK-NEXT:    [[TMP19:%.*]] = ashr exact i64 [[TMP15]], 32
; CHECK-NEXT:    [[TMP20:%.*]] = ashr exact i64 [[TMP16]], 32
; CHECK-NEXT:    [[TMP21:%.*]] = getelementptr inbounds i16, ptr [[M3]], i64 [[TMP17]]
; CHECK-NEXT:    [[TMP22:%.*]] = getelementptr inbounds i16, ptr [[M3]], i64 [[TMP18]]
; CHECK-NEXT:    [[TMP23:%.*]] = getelementptr inbounds i16, ptr [[M3]], i64 [[TMP19]]
; CHECK-NEXT:    [[TMP24:%.*]] = getelementptr inbounds i16, ptr [[M3]], i64 [[TMP20]]
; CHECK-NEXT:    [[TMP25:%.*]] = extractelement <4 x i16> [[TMP8]], i32 0
; CHECK-NEXT:    store i16 [[TMP25]], ptr [[TMP21]], align 2
; CHECK-NEXT:    [[TMP26:%.*]] = extractelement <4 x i16> [[TMP8]], i32 1
; CHECK-NEXT:    store i16 [[TMP26]], ptr [[TMP22]], align 2
; CHECK-NEXT:    [[TMP27:%.*]] = extractelement <4 x i16> [[TMP8]], i32 2
; CHECK-NEXT:    store i16 [[TMP27]], ptr [[TMP23]], align 2
; CHECK-NEXT:    [[TMP28:%.*]] = extractelement <4 x i16> [[TMP8]], i32 3
; CHECK-NEXT:    store i16 [[TMP28]], ptr [[TMP24]], align 2
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP29:%.*]] = icmp eq i64 [[INDEX_NEXT]], 16
; CHECK-NEXT:    br i1 [[TMP29]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br label [[FOR_INC1286_LOOPEXIT:%.*]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[IF_THEN1165_US:%.*]]
; CHECK:       if.then1165.us:
; CHECK-NEXT:    [[INDVARS_IV1783:%.*]] = phi i64 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INDVARS_IV_NEXT1784:%.*]], [[IF_THEN1165_US]] ]
; CHECK-NEXT:    [[FPTR:%.*]] = load i32, ptr [[C]], align 4
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr inbounds i16, ptr [[A]], i64 [[INDVARS_IV1783]]
; CHECK-NEXT:    [[L_A:%.*]] = load i16, ptr [[GEP_A]], align 2
; CHECK-NEXT:    [[CONV1177_US:%.*]] = zext i16 [[L_A]] to i32
; CHECK-NEXT:    [[ADD1178_US:%.*]] = add nsw i32 [[CONV1177_US]], [[FPTR]]
; CHECK-NEXT:    [[CONV1179_US:%.*]] = trunc i32 [[ADD1178_US]] to i16
; CHECK-NEXT:    [[GEP_B:%.*]] = getelementptr inbounds i64, ptr [[B]], i64 [[INDVARS_IV1783]]
; CHECK-NEXT:    [[L_B:%.*]] = load i64, ptr [[GEP_B]], align 8
; CHECK-NEXT:    [[IDXPROM1181_US:%.*]] = ashr exact i64 [[L_B]], 32
; CHECK-NEXT:    [[ARRAYIDX1185_US:%.*]] = getelementptr inbounds i16, ptr [[M3]], i64 [[IDXPROM1181_US]]
; CHECK-NEXT:    store i16 [[CONV1179_US]], ptr [[ARRAYIDX1185_US]], align 2
; CHECK-NEXT:    [[INDVARS_IV_NEXT1784]] = add nuw nsw i64 [[INDVARS_IV1783]], 1
; CHECK-NEXT:    [[EXITCOND1785:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT1784]], 16
; CHECK-NEXT:    br i1 [[EXITCOND1785]], label [[FOR_INC1286_LOOPEXIT]], label [[IF_THEN1165_US]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       for.inc1286.loopexit:
; CHECK-NEXT:    ret void
;
entry:
  br label %if.then1165.us

if.then1165.us:                                   ; preds = %if.then1165.us, %entry
  %indvars.iv1783 = phi i64 [ 0, %entry ], [ %indvars.iv.next1784, %if.then1165.us ]
  %fptr = load i32, ptr %C, align 4
  %gep.A  = getelementptr inbounds i16, ptr %A, i64 %indvars.iv1783
  %l.A = load i16, ptr %gep.A
  %conv1177.us = zext i16 %l.A to i32
  %add1178.us = add nsw i32 %conv1177.us, %fptr
  %conv1179.us = trunc i32 %add1178.us to i16
  %gep.B  = getelementptr inbounds i64, ptr %B, i64 %indvars.iv1783
  %l.B = load i64, ptr %gep.B
  %idxprom1181.us = ashr exact i64 %l.B, 32
  %arrayidx1185.us = getelementptr inbounds i16, ptr %M3, i64 %idxprom1181.us
  store i16 %conv1179.us, ptr %arrayidx1185.us, align 2
  %indvars.iv.next1784 = add nuw nsw i64 %indvars.iv1783, 1
  %exitcond1785 = icmp eq i64 %indvars.iv.next1784, 16
  br i1 %exitcond1785, label %for.inc1286.loopexit, label %if.then1165.us

for.inc1286.loopexit:                             ; preds = %if.then1165.us
  ret void
}
