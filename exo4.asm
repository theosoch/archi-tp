.global _start
_start:
    mov r5, r1
    
    add r4, r2, #1
    mov r6, #0
    sub r6, r6, #1

    mvn r7, r6
    and r6, r6, r7

    mov r6, r6, lsl r4

    sub r5, r5, r6
    mov r5, r5, lsl r3