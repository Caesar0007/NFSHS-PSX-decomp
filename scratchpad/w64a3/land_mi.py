#!/usr/bin/env python3
"""W64-A3 landing #1: relocate MoveImage's opacity fence off the BODY-thread
head (reorg.c:685-712 stop_search_p returns 1 at any asm -> guard2 could never
steal retail's `sll v0,s1,16` into its delay slot).  9 -> 4, count EXACT 46/46.
Asserting, byte-mode, LF-preserving.  Run from repo root."""
import os
import sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
P = ROOT / "recon/syslib/psx/libgpu/SYS.c"
raw = P.read_bytes()
assert b"\r\n" not in raw, "SYS.c must stay LF"
t = raw.decode("utf-8")

FENCE = (
    '    __asm__("" : "=r"(p) : "0"(p));              /* zero-insn opacity fence: keeps cse from\n'
    '                                                   * folding p back to the bare symbol address\n'
    '                                                   * (which re-emits `sw $r,sym` $at macros). */\n'
)
S1 = "    p[1] = (u_long)((y << 16) | (x & 0xffff));   /* dst xy */\n"

NEW_FENCE = (
    '    /* W64-A3 -- FENCE POSITION IS THE CFG DIAL (reorg.c:685-712 stop_search_p).\n'
    '     * This opacity fence still pins the payload ANCHOR (see the note above), but it\n'
    '     * must NOT sit at the head of the BODY thread: `stop_search_p` returns 1 at ANY\n'
    '     * asm insn, so guard2 (`bnez h,BODY`) could never reach the `sll $v0,$s1,16` that\n'
    '     * retail steals into its delay slot -- with no target-thread candidate reorg\n'
    '     * inverted guard2 and folded the whole `li -1; j` block away (45 insns vs 46).\n'
    '     * Fence placed AFTER the dst-xy store instead: statement order (and therefore the\n'
    '     * whole register handout, which already matches retail) is untouched, the anchor\n'
    '     * is still laundered, and reorg gets its steal back.  9 -> 4, count EXACT 46/46.\n'
    '     * Measured alternatives, same basin: fence after p[0] 28 * after p[2] 29 (47 insns)\n'
    '     * * dropped entirely 28 * read-only fence after the stores 28. */\n'
    '    __asm__("" : "=r"(p) : "0"(p));\n'
)

assert t.count(FENCE) == 1, "fence anchor %d" % t.count(FENCE)
assert t.count(S1) == 1, "p[1] anchor %d" % t.count(S1)
t2 = t.replace(FENCE, "").replace(S1, S1 + NEW_FENCE)
assert t2 != t
out = t2.encode("utf-8")
assert len(out) > len(raw) - 400
tmp = P.with_suffix(".c.w64a3tmp")
tmp.write_bytes(out)
os.replace(tmp, P)
print("landed; bytes %d -> %d" % (len(raw), len(out)))
