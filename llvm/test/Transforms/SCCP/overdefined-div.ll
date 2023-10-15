; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -passes=sccp -S | FileCheck %s

; Test that SCCP has basic knowledge of when div can nuke overdefined values.

; 0 / X = 0 even if X is overdefined.
define i32 @test1(i32 %foo) {
; CHECK-LABEL: define i32 @test1
; CHECK-SAME: (i32 [[FOO:%.*]]) {
; CHECK-NEXT:    ret i32 0
;
  %tinkywinky = udiv i32 0, %foo
  ret i32 %tinkywinky
}

define i32 @test2(i32 %foo) {
; CHECK-LABEL: define i32 @test2
; CHECK-SAME: (i32 [[FOO:%.*]]) {
; CHECK-NEXT:    ret i32 0
;
  %tinkywinky = sdiv i32 0, %foo
  ret i32 %tinkywinky
}

define i32 @test3(i32 %foo) {
; CHECK-LABEL: define i32 @test3
; CHECK-SAME: (i32 [[FOO:%.*]]) {
; CHECK-NEXT:    [[TINKYWINKY:%.*]] = udiv i32 [[FOO]], 0
; CHECK-NEXT:    ret i32 [[TINKYWINKY]]
;
  %tinkywinky = udiv i32 %foo, 0
  ret i32 %tinkywinky
}

define i32 @test4(i32 %foo) {
; CHECK-LABEL: define i32 @test4
; CHECK-SAME: (i32 [[FOO:%.*]]) {
; CHECK-NEXT:    [[TINKYWINKY:%.*]] = sdiv i32 [[FOO]], 0
; CHECK-NEXT:    ret i32 [[TINKYWINKY]]
;
  %tinkywinky = sdiv i32 %foo, 0
  ret i32 %tinkywinky
}