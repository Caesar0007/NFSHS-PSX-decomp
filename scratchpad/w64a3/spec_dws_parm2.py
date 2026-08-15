# W64-A3 round 2 on the _dws/_drs parm-copy ORDER.
# P1 (drop `saved` entirely) regressed 38/42 => `saved` IS retail's shape.
# Refined hypothesis: retail keeps the rect PARM pseudo live past `saved = rect`
# (so assign_parms' own copy survives at the top and `saved` coalesces into it),
# while ours propagates $a0 straight into `saved` and emits the copy at the BODY
# position -- after the data parm copy.  Keeping ONE late use of `rect` itself
# should hold the parm pseudo live at zero insn cost.
SRC = 'recon/syslib/psx/libgpu/SYS.c'
FNS = ['_dws', '_drs']

W_GP = """    *GPU_GP0 = var_s4 ? 0xb0000000u : 0xa0000000u;
    *GPU_GP0 = *(u_long *)saved;
    *GPU_GP0 = *((u_long *)saved + 1);
"""
W_GP_R = """    *GPU_GP0 = var_s4 ? 0xb0000000u : 0xa0000000u;
    *GPU_GP0 = *(u_long *)rect;
    *GPU_GP0 = *((u_long *)rect + 1);
"""
W_GP_R1 = """    *GPU_GP0 = var_s4 ? 0xb0000000u : 0xa0000000u;
    *GPU_GP0 = *(u_long *)rect;
    *GPU_GP0 = *((u_long *)saved + 1);
"""
W_HEAD = """    saved->w = CLAMP(saved->w, 0, GEnv.screenW);
    saved->h = CLAMP(saved->h, 0, GEnv.screenH);
    to_write = (saved->w * saved->h + 1) / 2;
"""
W_HEAD_R = """    rect->w = CLAMP(rect->w, 0, GEnv.screenW);
    rect->h = CLAMP(rect->h, 0, GEnv.screenH);
    to_write = (rect->w * rect->h + 1) / 2;
"""

R_GP = """    *GPU_GP0 = 0xc0000000;                       /* VRAM -> CPU copy */
    *GPU_GP0 = *(u_long *)saved;
    *GPU_GP0 = *((u_long *)saved + 1);
"""
R_GP_R = """    *GPU_GP0 = 0xc0000000;                       /* VRAM -> CPU copy */
    *GPU_GP0 = *(u_long *)rect;
    *GPU_GP0 = *((u_long *)rect + 1);
"""
R_HEAD = """    saved->w = CLAMP(saved->w, 0, GEnv.screenW);
    saved->h = CLAMP(saved->h, 0, GEnv.screenH);
    to_read = (saved->w * saved->h + 1) / 2;
"""
R_HEAD_R = """    rect->w = CLAMP(rect->w, 0, GEnv.screenW);
    rect->h = CLAMP(rect->h, 0, GEnv.screenH);
    to_read = (rect->w * rect->h + 1) / 2;
"""

SPEC = [
    ("M1 _dws rect at the GP0 payload",      [(W_GP, W_GP_R)]),
    ("M2 _dws rect at payload word 0 only",  [(W_GP, W_GP_R1)]),
    ("M3 _dws rect for the clamps only",     [(W_HEAD, W_HEAD_R)]),
    ("M4 _drs rect at the GP0 payload",      [(R_GP, R_GP_R)]),
    ("M5 _drs rect for the clamps only",     [(R_HEAD, R_HEAD_R)]),
    ("M6 _dws read-only fence on rect at top",
     [("    saved = rect;\n    var_s4 = 0;",
       '    saved = rect;\n    __asm__("" : : "r"(rect));\n    var_s4 = 0;')]),
]
