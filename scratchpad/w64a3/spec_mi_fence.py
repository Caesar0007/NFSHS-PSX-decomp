# W64-A3: reorg stop_search_p (reorg.c:685-712) returns 1 at ANY asm insn.
# Our opacity fence sits at the HEAD of MoveImage's BODY thread, so guard2's
# fill_slots_from_thread can never reach the `sll v0,s1,16` retail steals into
# the bnez slot -- which is exactly why our guard2 gets inverted+redirected
# (45 insns, CFG != retail).  Move the fence off the thread head.
SRC = 'recon/syslib/psx/libgpu/SYS.c'
FNS = ['MoveImage']

FENCE = """    __asm__("" : "=r"(p) : "0"(p));              /* zero-insn opacity fence: keeps cse from
                                                   * folding p back to the bare symbol address
                                                   * (which re-emits `sw $r,sym` $at macros). */
"""
FSHORT = '    __asm__("" : "=r"(p) : "0"(p));   /* opacity fence, relocated (W64-A3) */\n'

S0 = "    p[0] = *(u_long *)rect;                      /* src xy */\n"
S1 = "    p[1] = (u_long)((y << 16) | (x & 0xffff));   /* dst xy */\n"
S2 = "    p[2] = *((u_long *)rect + 1);                /* wh */\n"

SPEC = [
    ("F1 fence after p[0] store",      [(FENCE, ""), (S0, S0 + FSHORT)]),
    ("F2 fence after p[1] store",      [(FENCE, ""), (S1, S1 + FSHORT)]),
    ("F3 fence after p[2] store",      [(FENCE, ""), (S2, S2 + FSHORT)]),
    ("F4 no fence at all",             [(FENCE, "")]),
    ("F5 read-only fence after stores",
     [(FENCE, ""), (S2, S2 + '    __asm__("" : : "r"(p));   /* W64-A3 */\n')]),
]
