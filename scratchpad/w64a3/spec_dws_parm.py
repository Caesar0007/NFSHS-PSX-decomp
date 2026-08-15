# W64-A3: _dws/_drs parm (save,copy) emission ORDER, 4 diffs in each.
# HYPOTHESIS (new): ours emits `sw $s2 / addu $s2,$a1` FIRST because our
# `addu $s1,$a0,$zero` is NOT the rect PARM COPY at all -- it is the BODY
# statement `saved = rect;` (assign_parms' own rect copy was coalesced away),
# so it necessarily follows the data parm copy.  Retail's $s1<-$a0 IS the parm
# copy.  Cure: drop the `saved` alias and use `rect` directly.
SRC = 'recon/syslib/psx/libgpu/SYS.c'
FNS = ['_dws', '_drs']

# ---- _dws unique chunks -------------------------------------------------
W_DECL = "    int readyMask;\n    RECT *saved;\n"
W_HEAD = """    saved = rect;
    var_s4 = 0;                                  /* GP0 cmd selector (0 = 0xA0 load) */
    _gpu_arm_timeout();
    saved->w = CLAMP(saved->w, 0, GEnv.screenW);
    saved->h = CLAMP(saved->h, 0, GEnv.screenH);
    to_write = (saved->w * saved->h + 1) / 2;
"""
W_HEAD_R = """    var_s4 = 0;                                  /* GP0 cmd selector (0 = 0xA0 load) */
    _gpu_arm_timeout();
    rect->w = CLAMP(rect->w, 0, GEnv.screenW);
    rect->h = CLAMP(rect->h, 0, GEnv.screenH);
    to_write = (rect->w * rect->h + 1) / 2;
"""
W_GP = """    *GPU_GP0 = var_s4 ? 0xb0000000u : 0xa0000000u;
    *GPU_GP0 = *(u_long *)saved;
    *GPU_GP0 = *((u_long *)saved + 1);
"""
W_GP_R = """    *GPU_GP0 = var_s4 ? 0xb0000000u : 0xa0000000u;
    *GPU_GP0 = *(u_long *)rect;
    *GPU_GP0 = *((u_long *)rect + 1);
"""

# ---- _drs unique chunks -------------------------------------------------
R_DECL = "    int sendMask;\n    RECT *saved;\n"
R_HEAD = """    saved = rect;
    _gpu_arm_timeout();
    saved->w = CLAMP(saved->w, 0, GEnv.screenW);
    saved->h = CLAMP(saved->h, 0, GEnv.screenH);
    to_read = (saved->w * saved->h + 1) / 2;
"""
R_HEAD_R = """    _gpu_arm_timeout();
    rect->w = CLAMP(rect->w, 0, GEnv.screenW);
    rect->h = CLAMP(rect->h, 0, GEnv.screenH);
    to_read = (rect->w * rect->h + 1) / 2;
"""
R_GP = """    *GPU_GP0 = 0xc0000000;                       /* VRAM -> CPU copy */
    *GPU_GP0 = *(u_long *)saved;
    *GPU_GP0 = *((u_long *)saved + 1);
"""
R_GP_R = """    *GPU_GP0 = 0xc0000000;                       /* VRAM -> CPU copy */
    *GPU_GP0 = *(u_long *)rect;
    *GPU_GP0 = *((u_long *)rect + 1);
"""

SPEC = [
    ("P1 _dws drop `saved`",
     [(W_DECL, "    int readyMask;\n"), (W_HEAD, W_HEAD_R), (W_GP, W_GP_R)]),
    ("P2 _drs drop `saved`",
     [(R_DECL, "    int sendMask;\n"), (R_HEAD, R_HEAD_R), (R_GP, R_GP_R)]),
    ("P3 both drop `saved`",
     [(W_DECL, "    int readyMask;\n"), (W_HEAD, W_HEAD_R), (W_GP, W_GP_R),
      (R_DECL, "    int sendMask;\n"), (R_HEAD, R_HEAD_R), (R_GP, R_GP_R)]),
    ("P4 _dws `saved` declared FIRST",
     [(W_DECL, "    int readyMask;\n"),
      ("    int to_write;\n", "    RECT *saved;\n    int to_write;\n")]),
    ("P5 _drs `saved` declared FIRST",
     [(R_DECL, "    int sendMask;\n"),
      ("    int to_read;\n", "    RECT *saved;\n    int to_read;\n")]),
    ("P6 _dws data->named local first",
     [(W_HEAD, "    saved = rect;\n    data = data;\n" + W_HEAD[len("    saved = rect;\n"):])]),
]
