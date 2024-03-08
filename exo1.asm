; a = nb1;
; b = nb2;
; while (a != b) {
; if (a > b)
; b = b + nb2;
; else
; if (a < b)
; a = a + nb1;
; }
; // a est le ppcm

.global _start
_start:
    mov r3, r1
    mov r4, r2

loop:
    cmp r3, r4
    beq loopend

    addhi r4, r4, r2
    addlo r3, r3, r1

    b loop

loopend:
    mov r0, r3
    b _end