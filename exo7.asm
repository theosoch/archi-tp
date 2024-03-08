.global _start

message: .asciz "DTCXQXQWURQWXGBRCUUGTCNGZGTEKEGUWKXCPV"
.align
dec: .word 2

_start:
    adr r0, message
    adr r8, dec
    ldr r8, [r8]

    b loop

loop:
    ldrb r1, [r0]
    cmp r1, #0
    beq loopend

    mov r2, #'A'
    sub r3, r1, r2
    add r3, r3, #26
    sub r3, r3, r8

    cmp r3, #26
    subhs r3, r3, #26
    
    add r3, r3, r2
    strb r3, [r0], #1

    b loop

loopend:
    b _end