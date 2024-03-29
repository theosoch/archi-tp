.global _start

.equ X_ALIVE, 'o'
.equ X_DEAD, ' '

grille:
.ascii "                "
.ascii "                "
.ascii "                "
.ascii "                "
.ascii "                "
.ascii "                "
.ascii "                "
.ascii "                "
.ascii "                "
.ascii "                "
.ascii "    ooo         "
.ascii "      o         "
.ascii "     o          "
.ascii "                "
.ascii "                "
.ascii "                "
.align

offset_tab: .int -17, -16, -15, -1, 1, 15, 16, 17
.align

population: .fill 16*16, 1, 0
.align

_start:
    b main

main:
    b main_loop

main_loop:
    adr r1, grille
    bl calcul

    adr r1, grille
    bl generation

    b main_loop

voisines:
    stmfd sp!, {r2-r5, lr}

    mov r0, #0
    adr r2, offset_tab
    add r3, r2, #36

    b voisines_loop

voisines_loop:
    cmp r2, r3
    beq voisines_loop_end

    ldr r4, [r2], #4
    add r4, r1, r4
    ldrb r5, [r4]

    cmp r5, #X_ALIVE
    addeq r0, r0, #1

    b voisines_loop

voisines_loop_end:
    ldmfd sp!, {r2-r5, lr}
    mov pc, lr

calcul:
    stmfd sp!, {r2-r3, lr}

    adr r2, population
    add r3, r2, #256

    b calcul_loop

calcul_loop:
    cmp r2, r3
    beq calcul_loop_end

    bl voisines
    strb r0, [r2], #1

    add r1, r1, #1

    b calcul_loop

calcul_loop_end:
    ldmfd sp!, {r2-r3, lr}
    mov pc, lr

generation:
    stmfd sp!, {r2-r9, lr}

    mov r2, r1

    add r3, r2, #256
    adr r4, population

    mov r8, #X_ALIVE
    mov r9, #X_DEAD

    b generation_loop

generation_loop:
    cmp r2, r3
    beq generation_loop_end

    ldrb r5, [r2]
    ldrb r6, [r4]

    cmp r6, #3
    streqb r8, [r2]
    beq generation_loop_cmp_end
    
    cmp r6, #2
    strneb r9, [r2]
    bne generation_loop_cmp_end
    
generation_loop_cmp_end:
    add r2, r2, #1
    add r4, r4, #1

    b generation_loop

generation_loop_end:
    ldmfd sp!, {r2-r9, lr}
    mov pc, lr