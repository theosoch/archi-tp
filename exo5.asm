.global _start

a: .byte 8
b: .byte 12
somme: .fill 1,1
.align
_start:
    adr r0, a
    adr r1, b
    adr r2, somme

    ldrb r3, [r0]
    ldrb r4, [r1]
    add r5, r3, r4
    strb r5, [r2]