@ vim:ft=armv6
.syntax unified

.arch armv6
.fpu vfp

#define INTADD
.global intadd
intadd: @ int x, int y -> int result 
    push {v1, lr}       @ v1 -> carry
while:
    cmp a2, #0
    beq endwhile
    and v1, a1, a2
    eor a1, a1, a2
    lsl a2, v1, #1
    b   while
endwhile:
    pop {v1, pc}
end:
.end
