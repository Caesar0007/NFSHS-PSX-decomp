# W64-A3: MoveImage residual after D1 = 2, a pure sched2 tie between the
# src-word load (`lw $a1,0($s0)`) and the GEnv_drv load (`lui/lw $a3`).
# sched.c ties break on LUID => split the p[0] statement so the src load's
# RTL position precedes the drv load's.
SRC = 'recon/syslib/psx/libgpu/SYS.c'
FNS = ['MoveImage']

DECL = "    short *r = (short *)rect;\n    u_long *p;\n"
ANCHOR = "    p = &_move_prim[2];\n"
S0 = "    p[0] = *(u_long *)rect;                      /* src xy */\n"
S1 = "    p[1] = (u_long)((y << 16) | (x & 0xffff));   /* dst xy */\n"
FENCE = '    __asm__("" : "=r"(p) : "0"(p));\n'
S2 = "    p[2] = *((u_long *)rect + 1);                /* wh */\n"
RET = "    return GEnv_drv->que_push((QueFunc)GEnv_drv->dma_chain, p - 2, 0x14, 0);\n"
RET_D = "    return drv->que_push((QueFunc)drv->dma_chain, p - 2, 0x14, 0);\n"
ASSIGN = "    drv = GEnv_drv;\n"

D = "    short *r = (short *)rect;\n    u_long *p;\n    GpuTbl *drv;\n"
DS = ("    short *r = (short *)rect;\n    u_long *p;\n    u_long srcxy;\n"
      "    GpuTbl *drv;\n")

SPEC = [
    # E1: src word read into a named local BEFORE drv, store still first
    ("E1 srcxy then drv, p[0]=srcxy",
     [(DECL, DS), (ANCHOR, ANCHOR + "    srcxy = *(u_long *)rect;\n" + ASSIGN),
      (S0, "    p[0] = srcxy;                                 /* src xy */\n"),
      (RET, RET_D)]),
    # E2: drv then srcxy (control for the order effect)
    ("E2 drv then srcxy",
     [(DECL, DS), (ANCHOR, ANCHOR + ASSIGN + "    srcxy = *(u_long *)rect;\n"),
      (S0, "    p[0] = srcxy;                                 /* src xy */\n"),
      (RET, RET_D)]),
    # E3: D1 + store p[1] before p[0]  (04Z re-probe of a 14-basin falsification)
    ("E3 D1 + p[1] store first",
     [(DECL, D), (ANCHOR, ANCHOR + ASSIGN), (RET, RET_D),
      (S0 + S1, S1 + S0)]),
    # E4: D1 + read-only fence on drv right after its assignment (ref dial)
    ("E4 D1 + ro-fence on drv",
     [(DECL, D), (ANCHOR, ANCHOR + ASSIGN + '    __asm__("" : : "r"(drv));\n'),
      (RET, RET_D)]),
    # E5: D1 but drv read only ONCE in the call (dma_chain via drv, que_push via drv)
    #     control: same as D1 -- instead try the reverse single-read shape
    ("E5 D1 + src read via r[] halves? (int cast)",
     [(DECL, D), (ANCHOR, ANCHOR + ASSIGN), (RET, RET_D),
      (S0, "    p[0] = *(u_long *)r;                          /* src xy */\n")]),
    # E6: srcxy local WITHOUT the drv local (isolate the split's own effect)
    ("E6 srcxy only, no drv local",
     [(DECL, "    short *r = (short *)rect;\n    u_long *p;\n    u_long srcxy;\n"),
      (ANCHOR, ANCHOR + "    srcxy = *(u_long *)rect;\n"),
      (S0, "    p[0] = srcxy;                                 /* src xy */\n")]),
]
