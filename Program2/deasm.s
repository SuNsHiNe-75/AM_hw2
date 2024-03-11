	.cpu arm926ej-s
	.fpu softvfp

	.text
	.align	2
	.global	main
main:
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	stmfd 	sp!, {r4-r11}

	BL Deassembly
	.include "test.s"
Deassembly:
	mov r5, lr @ for reserving "lr" pointing to test.s
	mov r7, #-4 @ for "PC".
LOOP:
	ldr r4, [r5]
	ldr r6, =Deassembly @ "EOF"
	cmp r5, r6
	beq RETURN

	add r5, r5, #4

@ Output of "PC"
	ldr r0, =_PC
	add r7, r7, #4
	mov r1, r7
	bl printf

	b COND

@ for detecting SOME bits in advance.
PreDeterBit:
	mov r3, #0x0c000000
	and r2, r4, #0x0c000000
	cmp r3, r2
	beq out_Undef

	mov r3, #0x00000000
	ldr r8, =0x0e000010
	and r2, r4, r8
	cmp r3, r2
	beq dataProcessing

	mov r3, #0x00000010
	cmp r3, r2
	beq dataProcessing

	mov r3, #0x02000000
	ldr r8, =0x0e000000
	and r2, r4, r8
	cmp r3, r2
	beq dataProcessing

	mov r3, #0x04000000
	and r2, r4, #0x0c000000
	cmp r3, r2
	beq dataMovement

	mov r3, #0x0a000000
	and r2, r4, #0x0e000000
	cmp r3, r2
	beq branch

	b out_Undef

dataProcessing:
	mov r3, #0x00000090
	and r2, r4, #0x00000090
	cmp r3, r2
	beq out_Undef

	mov r3, #0x03000000
	and r2, r4, #0x03b00000
	cmp r3, r2
	beq out_Undef

	mov r3, #0x00000000
	and r2, r4, #0x01e00000
	cmp r3, r2
	beq out_AND

	mov r3, #0x00200000
	cmp r3, r2
	beq out_EOR

	mov r3, #0x00400000
	cmp r3, r2
	beq out_SUB

	mov r3, #0x00600000
	cmp r3, r2
	beq out_RSB

	mov r3, #0x00800000
	cmp r3, r2
	beq out_ADD

	mov r3, #0x00a00000
	cmp r3, r2
	beq out_ADC

	mov r3, #0x00c00000
	cmp r3, r2
	beq out_SBC

	mov r3, #0x00e00000
	cmp r3, r2
	beq out_RSC

	mov r3, #0x01000000
	cmp r3, r2
	beq out_TST

	mov r3, #0x01200000
	cmp r3, r2
	beq out_TEQ

	mov r3, #0x01400000
	cmp r3, r2
	beq out_CMP

	mov r3, #0x01600000
	cmp r3, r2
	beq out_CMN

	mov r3, #0x01800000
	cmp r3, r2
	beq out_ORR

	mov r3, #0x01a00000
	cmp r3, r2
	beq out_MOV

	mov r3, #0x01c00000
	cmp r3, r2
	beq out_BIC

	mov r3, #0x01e00000
	cmp r3, r2
	beq out_MVN

dataMovement:
	mov r3, #0x00000010
	and r2, r4, #0x00000010
	cmp r3, r2
	beq out_Undef

	ldr r3, =0x07f000f0
	and r2, r4, r3
	cmp r3, r2
	beq out_Undef

	mov r3, #0x00500000
	and r2, r4, #0x00500000
	cmp r3, r2
	beq out_LDRB

	mov r3, #0x00400000
	cmp r3, r2
	beq out_STRB

	mov r3, #0x00100000
	cmp r3, r2
	beq out_LDR

	mov r3, #0x00000000
	cmp r3, r2
	beq out_STR

branch:
	mov r3, #0x00000000
	and r2, r4, #0x01000000
	cmp r3, r2
	beq out_B

	mov r3, #0x01000000
	cmp r3, r2
	beq out_BL

@ for determining "Condition".
COND:
	mov r3, #0x00000000
	and r2, r4, #0xf0000000
	cmp r3, r2
	beq out_EQ

	mov r3, #0x10000000
	cmp r3, r2
	beq out_NE

	mov r3, #0x20000000
	cmp r3, r2
	beq out_CSHS

	mov r3, #0x30000000
	cmp r3, r2
	beq out_CCLO

	mov r3, #0x40000000
	cmp r3, r2
	beq out_MI

	mov r3, #0x50000000
	cmp r3, r2
	beq out_PL

	mov r3, #0x60000000
	cmp r3, r2
	beq out_VS

	mov r3, #0x70000000
	cmp r3, r2
	beq out_VC

	mov r3, #0x80000000
	cmp r3, r2
	beq out_HI

	mov r3, #0x90000000
	cmp r3, r2
	beq out_LS

	mov r3, #0xa0000000
	cmp r3, r2
	beq out_GE

	mov r3, #0xb0000000
	cmp r3, r2
	beq out_LT

	mov r3, #0xc0000000
	cmp r3, r2
	beq out_GT

	mov r3, #0xd0000000
	cmp r3, r2
	beq out_LE

	mov r3, #0xe0000000
	cmp r3, r2
	beq out_AL

	mov r3, #0xf0000000
	cmp r3, r2
	beq out_NV

@ for OUTPUT.
out_AND:
	ldr r0, =_AND
	bl printf
	b LOOP
out_EOR:
	ldr r0, =_EOR
	bl printf
	b LOOP
out_SUB:
	ldr r0, =_SUB
	bl printf
	b LOOP
out_RSB:
	ldr r0, =_RSB
	bl printf
	b LOOP
out_ADD:
	ldr r0, =_ADD
	bl printf
	b LOOP
out_ADC:
	ldr r0, =_ADC
	bl printf
	b LOOP
out_SBC:
	ldr r0, =_SBC
	bl printf
	b LOOP
out_RSC:
	ldr r0, =_RSC
	bl printf
	b LOOP
out_TST:
	ldr r0, =_TST
	bl printf
	b LOOP
out_TEQ:
	ldr r0, =_TEQ
	bl printf
	b LOOP
out_CMP:
	ldr r0, =_CMP
	bl printf
	b LOOP
out_CMN:
	ldr r0, =_CMN
	bl printf
	b LOOP
out_ORR:
	ldr r0, =_ORR
	bl printf
	b LOOP
out_MOV:
	ldr r0, =_MOV
	bl printf
	b LOOP
out_BIC:
	ldr r0, =_BIC
	bl printf
	b LOOP
out_MVN:
	ldr r0, =_MVN
	bl printf
	b LOOP

out_LDRB:
	ldr r0, =_LDRB
	bl printf
	b LOOP
out_STRB:
	ldr r0, =_STRB
	bl printf
	b LOOP
out_LDR:
	ldr r0, =_LDR
	bl printf
	b LOOP
out_STR:
	ldr r0, =_STR
	bl printf
	b LOOP

out_B:
	ldr r0, =_B
	bl printf
	b LOOP
out_BL:
	ldr r0, =_BL
	bl printf
	b LOOP

out_Undef:
	ldr r0, =_Undef
	bl printf
	b LOOP

out_EQ:
	ldr r0, =EQ
	bl printf
	b PreDeterBit
out_NE:
	ldr r0, =NE
	bl printf
	b PreDeterBit
out_CSHS:
	ldr r0, =CSHS
	bl printf
	b PreDeterBit
out_CCLO:
	ldr r0, =CCLO
	bl printf
	b PreDeterBit
out_MI:
	ldr r0, =MI
	bl printf
	b PreDeterBit
out_PL:
	ldr r0, =PL
	bl printf
	b PreDeterBit
out_VS:
	ldr r0, =VS
	bl printf
	b PreDeterBit
out_VC:
	ldr r0, =VC
	bl printf
	b PreDeterBit
out_HI:
	ldr r0, =HI
	bl printf
	b PreDeterBit
out_LS:
	ldr r0, =LS
	bl printf
	b PreDeterBit
out_GE:
	ldr r0, =GE
	bl printf
	b PreDeterBit
out_LT:
	ldr r0, =LT
	bl printf
	b PreDeterBit
out_GT:
	ldr r0, =GT
	bl printf
	b PreDeterBit
out_LE:
	ldr r0, =LE
	bl printf
	b PreDeterBit
out_AL:
	ldr r0, =AL
	bl printf
	b PreDeterBit
out_NV:
	ldr r0, =NV
	bl printf
	b PreDeterBit

RETURN:
	ldmfd 	sp!, {r4-r11}
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr

@ .asciz--------

test_instr: 
	.asciz "%x "

EQ:
	.asciz "EQ "
NE:
	.asciz "NE "
CSHS:
	.asciz "CS/HS "
CCLO:
	.asciz "CC/LO "
MI:
	.asciz "MI "
PL:
	.asciz "PL "
VS:
	.asciz "VS "
VC:
	.asciz "VC "
HI:
	.asciz "HI "
LS:
	.asciz "LS "
GE:
	.asciz "GE "
LT:
	.asciz "LT "
GT:
	.asciz "GT "
LE:
	.asciz "LE "
AL:
	.asciz "AL "
NV:
	.asciz "NV "

_ADD:
	.asciz "ADD\n"
_SUB:
	.asciz "SUB\n"
_EOR:
	.asciz "EOR\n"
_AND:
	.asciz "AND\n"
_RSB:
	.asciz "RSB\n"
_ADC:
	.asciz "ADC\n"
_SBC:
	.asciz "SBC\n"
_RSC:
	.asciz "RSC\n"
_TST:
	.asciz "TST\n"
_TEQ:
	.asciz "TEQ\n"
_CMP:
	.asciz "CMP\n"
_CMN:
	.asciz "CMN\n"
_ORR:
	.asciz "ORR\n"
_MOV:
	.asciz "MOV\n"
_BIC:
	.asciz "BIC\n"
_MVN:
	.asciz "MVN\n"

_LDRB:
	.asciz "LDRB\n"
_STRB:
	.asciz "LDRB\n"
_LDR:
	.asciz "LDR\n"
_STR:
	.asciz "STR\n"

_B:
	.asciz "B\n"
_BL:
	.asciz "BL\n"

_Undef:
	.asciz "Undef\n"

_PC:
	.asciz "%3d  "

    .end
    
    