@ vim:ft=armv6
.syntax unified

.arch armv6
.fpu vfp

#ifndef INTADD
#include "intadd.s"
#endif

#define INTSUB
.global intsub
intsub: @ int x, int y -> int result 
    push {lr}
    mvn a2, a2
    mov a3, a1
    mov a1, #1
    bl  intadd 
    mov a2, a3
    bl  intadd
    pop {pc}
end:
.end
