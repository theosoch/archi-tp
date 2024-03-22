.global _start

tab: .byte 0xc2, 0b11000011, 9, 252, 0xFF, 0x81, 0b10, 63, 0b11000101, 219
fintab:
.align

_start:

main:
    adr r2, tab
    adr r3, fintab

    mov r4, #0

    b main_loop

main_loop:
    cmp r2, r3
    beq main_loop_end

    ldrb r1, [r2], #1

    bl ispalindrome

    cmp r0, #1
    addeq r4, #1

    b main_loop

main_loop_end:
    mov r0, r4

    b _end

ispalindrome:
    stmfd sp!, {r2-r5}

    mov r2, r1
    mov r3, #0
    mov r4, #4

    b ispalindrome_loop

ispalindrome_loop:
    cmp r4, #0
    beq ispalindrome_loop_end

    and r5, r2, #1
    mov r3, r3, lsl #1
    cmp r5, #1
    addeq r3, r3, #1

    mov r2, r2, lsr #1

    sub r4, r4, #1

    b ispalindrome_loop

ispalindrome_loop_end:
    mov r0, #0
    cmp r2, r3
    moveq r0, #1

    ldmfd sp!, {r2-r5}
    mov pc, lr