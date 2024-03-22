.global _start

.equ X_ALIVE, 'o'
.equ X_DEAD, ' '

grille:
.ascii "  o  o          "
.ascii "  ooo    ooo  o "
.ascii "o o     ooo o   "
.ascii "    o o o o o  o"
.ascii "o    ooo o      "
.ascii "       o oo     "
.ascii "     ooo        "
.ascii "       o  o o o "
.ascii " o   o     o    "
.ascii "o   oo ooo o    "
.ascii "o     oo        "
.ascii "     o   o     o"
.ascii "oo o  o     o o "
.ascii "    oo    o     "
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

    b generation_loop_1

generation_loop_1:
    cmp r2, r3
    beq generation_loop_1_end

    ldrb r5, [r2]
    ldrb r6, [r4]

    cmp r5, r8
    bleq generation_loop_1_if_alive_1
    cmp r5, r9
    bleq generation_loop_1_if_dead_1

    add r2, r2, #1
    add r4, r4, #1

    b generation_loop_1

generation_loop_1_if_alive_1:
    stmfd sp!, {lr}

    cmp r6, #2
    cmpne r6, #3
    strneb r9, [r2]

    ldmfd sp!, {lr}
    mov pc, lr

generation_loop_1_if_dead_1:
    stmfd sp!, {lr}

    cmpeq r6, #3
    streqb r8, [r2]

    ldmfd sp!, {lr}
    mov pc, lr

generation_loop_1_end:
    ldmfd sp!, {r2-r9, lr}
    mov pc, lr