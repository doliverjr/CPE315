@ vim:ft=armv6
.syntax unified

@ CPE315 Lab 3 Integer Calculator
@ Justin Nguyen

.arch armv6
.fpu vfp 

#ifndef INTADD
#include "intadd.s"
#endif

#ifndef INTSUB
#include "intsub.s"
#endif

#ifndef INTMUL
#include "intmul.s"
#endif

@ struct *inputs
@ [this_sp, #0] -> int num1
@ [this_sp, #4] -> int num2
calc: @ struct *inputs -> bool repeat
    @ Set up (save used vars, lr, then args)
    push {v1, r6, r7, lr}
    mov v1, a1
    @sub sp, sp, #8     @ Set up buffer + scanf save variable
    mov a1, r6
    mov a2, r7
    mov a1, sp
    mov a2, #8
    bl  intsub
    mov sp, a1
    mov a1, r6
    mov a2, r7
                        @ Scan Num 1
    ldr a1, =prompt1
    bl  printf
    ldr a1, =scanint
    mov a2, sp
    bl  scanf 
    ldr a1, [sp, #0]
    str a1, [v1, #0]
                        @ Scan Num 2
    ldr a1, =prompt2
    bl printf
    ldr a1, =scanint
    mov a2, sp
    bl scanf
    ldr a1, [sp, #0]
    str a1, [v1, #4] 
                        @ Scan Operation
    ldr a1, =promptop
    bl printf
    ldr a1, =scanchar
    mov a2, sp
    bl scanf
    ldrb a3, [sp, #0]   @ Load Operator into compare reg
    ldr a1, [v1, #0]
    ldr a2, [v1, #4]
    cmp a3, #43         @ Ascii "+" 
    beq addop
    cmp a3, #45         @ Ascii "-" 
    beq subop
    cmp a3, #42         @ Ascii "*"
    beq multop
badop:
    ldr a1, =promptbad
    bl printf
    b  promptloop
addop:
    bl intadd
    mov a2, a1
    b printres
subop:
    bl intsub
    mov a2, a1
    b printres
multop:
    bl intmul
    mov a2, a1
printres:
    ldr a1, =promptres
    bl printf
promptloop: 
    ldr a1, =promptrep
    bl printf
    ldr a1, =scanchar
    mov a2, sp
    bl scanf
    ldrb r0, [sp, #0]
    @add sp, sp, #8
    mov r6, a1
    mov r7, a2
    mov a1, sp
    mov a2, #8
    bl  intadd
    mov sp, a1
    mov a1 ,r6
    mov a2, r7
    pop {v1, r6, r7, pc}
endcalc: 


.global main
main:
    push {lr}
    sub sp, sp, #12     @ Allocate buffer + struct *inputs  !8 aligned!
loop:
    mov a1, sp          @ Load argument 1 for calc
    bl calc
if:
    cmp r0, #121        @ Ascii "y" 
    bne endif
    b   loop    
endif: 
    @add sp, sp, #12 
    mov r6, a1
    mov r7, a2
    mov a1, sp
    mov a2, #12
    bl  intadd
    mov sp, a1
    mov a1 ,r6
    mov a2, r7
    pop {pc}
end:


prompt1:
    .asciz "Enter Number 1: "
prompt2:
    .asciz "Enter Number 2: "
promptop:
    .asciz "Enter Operation: "
promptres:
    .asciz "Result is: %d\n" 
promptbad:
    .asciz "Invalid Operation Entered.\n"
promptrep:
    .asciz "Again? "
scanchar:
    .asciz " %c"
    .space 1
scanint:
    .asciz " %d"
    .space 1
.end
