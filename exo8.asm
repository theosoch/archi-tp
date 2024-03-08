.global _start

chaine1: .asciz "JLkd2nj345bnzApdd0j9"
.align
chaine2: .fill 255,1
.align

_start:
    adr r0, chaine1
    adr r1, chaine2

    b loop

loop:
    ldrb r2, [r0], #1
    cmp r2, #0
    beq loopend

    cmp r2, #'0'
    strlob r2, [r1], #1
    cmphs r2, #'9'
    strhib r2, [r1], #1

    b loop

loopend:
    b _end
