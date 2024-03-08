; .global _start
; _start:
;     mov r2, r1
;     mov r0, #1
;     mov r0, r0, lsl r2

.global _start
_start:
    mov r2, r1
    mov r0, #1

loop:
    cmp r2, #0
    beq loopend
    mov r0, r0, lsl #1
    sub r2, r2, #1
    b loop

loopend: