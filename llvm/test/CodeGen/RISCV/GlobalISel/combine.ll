; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -global-isel -verify-machineinstrs -O0 < %s \
; RUN:   | FileCheck %s --check-prefixes=RV32,RV32-O0
; RUN: llc -mtriple=riscv64 -global-isel -verify-machineinstrs -O0 < %s \
; RUN:   | FileCheck %s --check-prefixes=RV64,RV64-O0
; RUN: llc -mtriple=riscv32 -global-isel -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=RV32,RV32-OPT
; RUN: llc -mtriple=riscv64 -global-isel -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=RV64,RV64-OPT

define i32 @constant_to_rhs(i32 %x) {
; RV32-O0-LABEL: constant_to_rhs:
; RV32-O0:       # %bb.0:
; RV32-O0-NEXT:    mv a1, a0
; RV32-O0-NEXT:    li a0, 1
; RV32-O0-NEXT:    add a0, a0, a1
; RV32-O0-NEXT:    ret
;
; RV64-O0-LABEL: constant_to_rhs:
; RV64-O0:       # %bb.0:
; RV64-O0-NEXT:    mv a1, a0
; RV64-O0-NEXT:    li a0, 1
; RV64-O0-NEXT:    addw a0, a0, a1
; RV64-O0-NEXT:    ret
;
; RV32-OPT-LABEL: constant_to_rhs:
; RV32-OPT:       # %bb.0:
; RV32-OPT-NEXT:    addi a0, a0, 1
; RV32-OPT-NEXT:    ret
;
; RV64-OPT-LABEL: constant_to_rhs:
; RV64-OPT:       # %bb.0:
; RV64-OPT-NEXT:    addiw a0, a0, 1
; RV64-OPT-NEXT:    ret
  %a = add i32 1, %x
  ret i32 %a
}

define i32 @mul_to_shift(i32 %x) {
; RV32-LABEL: mul_to_shift:
; RV32:       # %bb.0:
; RV32-NEXT:    slli a0, a0, 2
; RV32-NEXT:    ret
;
; RV64-LABEL: mul_to_shift:
; RV64:       # %bb.0:
; RV64-NEXT:    slliw a0, a0, 2
; RV64-NEXT:    ret
  %a = mul i32 %x, 4
  ret i32 %a
}