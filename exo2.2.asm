.global _start
_start:
    mov r0, #0
    mov r2, #1

loop:
    cmp r2, r1
    bhs loopend
    mov r2, r2, lsl #1
    add r0, r0, #1
    b loop

loopend: