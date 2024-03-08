; racine = 0;
; while ( (racine+1)2 ≤ N )
;     racine = racine + 1;

.global _start
_start:
    mov r0, #0

loop:
    add r2, r0, #1
    mul r3, r2, r2
    cmp r3, r1
    bhi loopend

    add r0, r0, #1

    b loop

loopend: