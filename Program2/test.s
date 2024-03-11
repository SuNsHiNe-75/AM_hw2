TEST_S:
    ADD r0,r1 @ e0800001
    SUBEQ r0,r1 @ 00400001
    SUBEQ r0,r1 
    LDREQ r0,[r1] @ 05910000
    BL printf
    PUSH {r0}
    CMPLT r0,r1 @ B1500001
    MOV r0, #0
    MUL r1, r2, r3
    LDMIA r0!, {r2-r9}
    PUSH {r0, r1}
    