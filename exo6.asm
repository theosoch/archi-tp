.global _start

.equ N, 10
tab: .word 22, -12, 0, 9, 5, -1, 5, 43, 10, -10
.align

_start:
    adr r8, tab

    mov r0, #0
    mov r1, #N
    sub r1, r1, #1

    b loop

loop:
    cmp r0, r1
    bhs loopend

    mov r2, r0

    mov r3, r0
    add r3, r3, #1

    b loop2

loop2:
    cmp r3, #N
    bhs loop2end

    ldr r4, [r8, r3, lsl #2]
    ldr r5, [r8, r2, lsl #2]

    cmp r4, r5
    movlt r2, r3

    add r3, r3, #1

    b loop2
loop2end:
    cmp r2, r0

    ldrne r4, [r8, r0, lsl #2]
    ldrne r5, [r8, r2, lsl #2]
    
    movne r6, r4
    strne r5, [r8, r0, lsl #2]
    strne r6, [r8, r2, lsl #2]

    add r0, r0, #1

    b loop

loopend:
    b _end