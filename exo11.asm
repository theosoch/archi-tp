.global _start

sevseg_digit_tab: .byte 0b0111111, 0b0000110, 0b1011011, 0b1001111, 0b1100110, 0b1101101, 0b1111101, 0b0000111, 0b1111111, 0b1101111
.align

positions_tambour: .word 0x3000, 0x2100, 0x0101, 0x0003, 0x0006, 0x000c, 0x0808, 0x1800, 0x3000

cuve_pleine: .byte 0
.align

_start:
    b main

main:
    b main_loop

main_loop:
    ldr r5, =0xff200020
    ldr r6, [r5]
    mov r6, r6, lsr #16
    mov r6, r6, lsl #16
    str r6, [r5]

    mov r1, #0
    bl afficher_temperature

    bl get_machine_power_state
    
    cmp r0, #1
    bleq get_machine_prog

    cmp r0, #0b001
    bleq porg_machine_0

    cmp r0, #0b010
    bleq porg_machine_1

    cmp r0, #0b100
    bleq porg_machine_2

    b main_loop

main_loop_end:
    b _end






get_machine_power_state:
    stmfd sp!, {r1-r2}

    ldr r1, =0xff200050
    ldr r2, [r1]

    and r0, r2, #1

    ldmfd sp!, {r1-r2}
    mov pc, lr






get_machine_prog:
    stmfd sp!, {r1-r2}

    ldr r1, =0xff200040
    ldr r2, [r1]

    and r0, r2, #0b111

    ldmfd sp!, {r1-r2}
    mov pc, lr






porg_machine_0:
    stmfd sp!, {r1-r4, lr}

    mov r1, #3
    bl afficher_temperature

    bl remplir

    mov r2, #0
    mov r3, #1

    mov r4, #0
    b porg_machine_0_lavage_loop

porg_machine_0_lavage_loop:
    cmp r4, #2
    beq porg_machine_0_lavage_loop_end

    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_0_essorage_loop_end

    mov r1, #0
    bl tourner_tambour

    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_0_essorage_loop_end

    mov r1, #1
    bl tourner_tambour

    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_0_essorage_loop_end

    add r4, r4, #1
    b porg_machine_0_lavage_loop

porg_machine_0_lavage_loop_end:
    mov r2, #1
    mov r3, #3

    mov r4, #0
    b porg_machine_0_essorage_loop
porg_machine_0_essorage_loop:
    cmp r4, #2
    beq porg_machine_0_essorage_loop_end
    
    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_0_essorage_loop_end

    mov r1, #0
    bl tourner_tambour

    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_0_essorage_loop_end

    mov r1, #1
    bl tourner_tambour

    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_0_essorage_loop_end

    add r4, r4, #1
    b porg_machine_0_essorage_loop

porg_machine_0_essorage_loop_end:
    bl vider

    ldmfd sp!, {r1-r4, lr}
    mov pc, lr






porg_machine_1:
    stmfd sp!, {r1-r4, lr}

    mov r1, #6
    bl afficher_temperature

    bl remplir

    mov r2, #0
    mov r3, #2

    mov r4, #0
    b porg_machine_1_lavage_loop

porg_machine_1_lavage_loop:
    cmp r4, #3
    beq porg_machine_1_lavage_loop_end

    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_1_essorage_loop_end

    mov r1, #0
    bl tourner_tambour

    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_1_essorage_loop_end

    mov r1, #1
    bl tourner_tambour

    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_1_essorage_loop_end

    add r4, r4, #1
    b porg_machine_1_lavage_loop

porg_machine_1_lavage_loop_end:
    mov r2, #1
    mov r3, #3

    mov r4, #0
    b porg_machine_1_essorage_loop
porg_machine_1_essorage_loop:
    cmp r4, #2
    beq porg_machine_1_essorage_loop_end
    
    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_1_essorage_loop_end

    mov r1, #0
    bl tourner_tambour

    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_1_essorage_loop_end

    mov r1, #1
    bl tourner_tambour

    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_1_essorage_loop_end

    add r4, r4, #1
    b porg_machine_1_essorage_loop

porg_machine_1_essorage_loop_end:
    bl vider

    ldmfd sp!, {r1-r4, lr}
    mov pc, lr






porg_machine_2:
    stmfd sp!, {r1-r4, lr}

    mov r1, #6
    bl afficher_temperature

    bl remplir

    mov r2, #1
    mov r3, #2

    mov r4, #0
    b porg_machine_2_essorage_loop

porg_machine_2_essorage_loop:
    cmp r4, #4
    beq porg_machine_2_essorage_loop_end
    
    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_2_essorage_loop_end

    mov r1, #0
    bl tourner_tambour

    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_2_essorage_loop_end

    mov r1, #1
    bl tourner_tambour

    bl get_machine_power_state
    cmp r0, #0
    beq porg_machine_2_essorage_loop_end

    add r4, r4, #1
    b porg_machine_2_essorage_loop

porg_machine_2_essorage_loop_end:
    bl vider

    ldmfd sp!, {r1-r4, lr}
    mov pc, lr






wait1:
    stmfd sp!, {r2}

    ldr r2, =0x2ffff
    b wait1_loop

wait1_loop:
    cmp r2, #0
    beq wait1_loop_end

    sub r2, r2, #1

    b wait1_loop

wait1_loop_end:
    ldmfd sp!, {r2}
    mov pc, lr





waitn:
    stmfd sp!, {r2, lr}
    
    mov r2, r8
    b waitn_loop

waitn_loop:
    cmp r2, #0
    beq waitn_loop_end

    bl wait1
    sub r2, r2, #1

    b waitn_loop

waitn_loop_end:
    ldmfd sp!, {r2, lr}
    mov pc, lr





remplir:
    stmfd sp!, {r2-r6, r8, lr}

    ldr r2, =0xff200000

    ldr r3, [r2]
    mov r4, #1024
    mov r8, #5

    sub r4, r4, #1

    b remplir_loop

remplir_loop:
    str r3, [r2]
    bl waitn

    cmp r3, r4
    bhs remplir_loop_end

    mov r3, r3, lsl #1
    add r3, r3, #1

    b remplir_loop

remplir_loop_end:
    adr r5, cuve_pleine
    mov r6, #1
    strb r6, [r5]

    ldmfd sp!, {r2-r6, r8, lr}
    mov pc, lr





vider:
    stmfd sp!, {r2-r5, r8, lr}

    ldr r2, =0xff200000

    ldr r3, [r2]
    mov r8, #5

    str r3, [r2]

    b vider_loop

vider_loop:
    str r3, [r2]
    bl waitn

    cmp r3, #0
    beq vider_loop_end

    mov r3, r3, lsr #1

    b vider_loop

vider_loop_end:
    adr r4, cuve_pleine
    mov r5, #0
    strb r5, [r4]

    ldmfd sp!, {r2-r5, r8, lr}
    mov pc, lr





afficher_temperature:
    stmfd sp!, {r2-r5}

    ldr r2, =0xff200030
    adr r3, sevseg_digit_tab

    ldrb r4, [r3, #0]
    ldrb r5, [r3, r1]
    
    mov r5, r5, lsl #8
    add r5, r5, r4
    str r5, [r2]

    ldmfd sp!, {r2-r5}
    mov pc, lr




tourner_tambour:
    stmfd sp!, {r4-r6, r7-r11, lr}

    ldr r4, =0xff200020
    adr r5, positions_tambour
    
    mov r6, r3

    mov r8, #4
    mov r8, r8, lsr r2
    add r8, r8, #1

    b tourner_tambour_loop

tourner_tambour_loop:
    cmp r6, #0
    beq tourner_tambour_loop_end

    mov r9, #0
    b tourner_tambour_tour_loop

tourner_tambour_tour_loop:
    cmp r9, #9
    beq tourner_tambour_tour_loop_end

    mov r10, #8
    sub r10, r10, r9

    cmp r1, #0
    ldreq r11, [r5, r9, lsl #2]
    ldrne r11, [r5, r10, lsl #2]

    str r11, [r4]
    bl waitn

    add r9, r9, #1
    b tourner_tambour_tour_loop

tourner_tambour_tour_loop_end:
    sub r6, r6, #1
    b tourner_tambour_loop

tourner_tambour_loop_end:
    ldmfd sp!, {r4-r6, r7-r11, lr}
    mov pc, lr