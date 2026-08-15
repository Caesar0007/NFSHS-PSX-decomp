# W64-A3: MoveImage residual 4 = the GEnv_drv `lui $a3; lw $a3` pair's sched2
# position (retail: right after `lw $a1,0($s0)`, before `addiu $a2,$zero,0x14`;
# ours: after `lw $v0,4($s0)`).  sched.c ties break on LUID => try to lower the
# load's RTL position by naming it.
SRC = 'recon/syslib/psx/libgpu/SYS.c'
FNS = ['MoveImage']

DECL = "    short *r = (short *)rect;\n    u_long *p;\n"
DECL_D = "    short *r = (short *)rect;\n    u_long *p;\n    GpuTbl *drv;\n"
ANCHOR = "    p = &_move_prim[2];\n"
S0 = "    p[0] = *(u_long *)rect;                      /* src xy */\n"
S1 = "    p[1] = (u_long)((y << 16) | (x & 0xffff));   /* dst xy */\n"
FENCE = '    __asm__("" : "=r"(p) : "0"(p));\n'
S2 = "    p[2] = *((u_long *)rect + 1);                /* wh */\n"
RET = "    return GEnv_drv->que_push((QueFunc)GEnv_drv->dma_chain, p - 2, 0x14, 0);\n"
RET_D = "    return drv->que_push((QueFunc)drv->dma_chain, p - 2, 0x14, 0);\n"
ASSIGN = "    drv = GEnv_drv;\n"

SPEC = [
    ("D1 drv= after anchor",  [(DECL, DECL_D), (ANCHOR, ANCHOR + ASSIGN), (RET, RET_D)]),
    ("D2 drv= after p[0]",    [(DECL, DECL_D), (S0, S0 + ASSIGN), (RET, RET_D)]),
    ("D3 drv= after p[1]",    [(DECL, DECL_D), (S1, S1 + ASSIGN), (RET, RET_D)]),
    ("D4 drv= after fence",   [(DECL, DECL_D), (FENCE, FENCE + ASSIGN), (RET, RET_D)]),
    ("D5 drv= after p[2]",    [(DECL, DECL_D), (S2, S2 + ASSIGN), (RET, RET_D)]),
    ("D6 drv= decl-init top", [(DECL, "    short *r = (short *)rect;\n    u_long *p;\n"
                                      "    GpuTbl *drv = GEnv_drv;\n"), (RET, RET_D)]),
    # single-read forms without a local: split only the callee designator
    ("D7 dma_chain named after p[0]",
     [(DECL, "    short *r = (short *)rect;\n    u_long *p;\n    QueFunc dc;\n"),
      (S0, S0 + "    dc = (QueFunc)GEnv_drv->dma_chain;\n"),
      (RET, "    return GEnv_drv->que_push(dc, p - 2, 0x14, 0);\n")]),
]
