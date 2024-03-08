.global _start
_start:
    add r4, r2, #1

    mov r5, #0
    sub r5, r5, #1
    mov r5, r5, lsl r4
    mvn r5, r5

    mov r6, r1
    and r6, r6, r5

    mov r0, r6, lsr r3

    b _end

