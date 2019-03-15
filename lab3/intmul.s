@ vim:ft=armv6
@
@ TODO: Fix mutiply 2 negative numbers not working
@
.syntax unified

.arch armv6
.fpu vfp

#ifndef INTADD
#include "intadd.s"
#endif

#define INTMUL
.global intmul
intmul: @ int x, int y -> int result
    push {v1, v2, r6, r7, lr}
    @add sp, sp, #4
    mov r6, a1
    mov r7, a2
    mov a1, sp
    mov a2, #4
    bl  intadd
    mov sp, a1
    mov a1, r6
    mov a2, r7

detsign:
    cmp a1, #0
    blt nota1
    cmp a2, #0
    blt nota2 
nota1:
    @sub a1, a1, #1
    mov r7, a2
    mov a2, #1
    bl  intsub
    mov a2, r7
    mvn a1, a1
    mov a3, #1 
    b   end_detsign
nota2:
    @sub a2, a2, #1
    mov r6, a1
    mov a1, a2
    mov a2, #1
    bl  intsub
    mov a2, a1
    mov a1, r6
    mvn a2, a2
    mov a4, #1
end_detsign:
    eor v2, a3, a4      @ Indicates whether res should be +/- 

    @@ Gen Counter Val @@ Determine number of times to shift
    mov a3, #1          @ Value to compare
    mov v1, #0          @ !!Counter!! Don't overwrite
gencounter_loop:
    cmp a3, a2
    bgt gencounter_greater
    beq gencounter_end
    lsl a3, a3, #1 
    @add v1, v1, #1
    mov r6, a1
    mov r7, a2
    mov a1, v1
    mov a2, #1
    bl  intadd
    mov v1, a1
    mov a1, r6
    mov a2, r7
    b   gencounter_loop
gencounter_greater:
    @sub v1, v1, #1      @ Sub 1 from counter since must shift over for gt cond. 
    mov r6, a1
    mov r7, a2
    mov a1, v1
    mov a2, #1
    bl  intsub
    mov v1, a1
    mov a1, r6
    mov a2, r7
gencounter_end:
    @@@@@@@@@@@@@@@@@@@@@

                        @ Setup multiplication
    mov a3, a1 
    mov a1, #0
mult:                   @ Find lsb value of a2 
    and a4, a2, #1
    cmp a4, #1
    bne step_mult
    @add a1, a1, a3
    mov r7, a2
    mov a2, a3
    bl  intadd
    mov a2, r7
step_mult:
    lsl a3, a3, #1
    lsr a2, a2, #1
    @sub v1, v1, #1
    mov r6, a1
    mov r7, a2
    mov a1, v1
    mov a2, #-1         @ intsub does not work here for some reason
    bl  intadd
    mov v1, a1
    mov a1, r6
    mov a2, r7

    cmp v1, #0
    bge mult 
end_mult:
    cmp v2, #1
    beq ret
    mvn a1, a1
    @add a1, a1, #1
    mov r7, a2
    mov a2, #1
    bl  intadd
    mov a2, r7
ret:
    @sub sp, sp, #4
    mov r6, a1
    mov r7, a2
    mov a1, sp
    mov a2, #4
    bl  intsub
    mov sp, a1
    mov a1, r6
    mov a2, r7
    pop {v1, v2, r6, r7, pc}
end:
.end
    
