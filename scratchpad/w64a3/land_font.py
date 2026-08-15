#!/usr/bin/env python3
"""W64-A3 landing #4: FONT.c FntFlush receipt (comment-only)."""
import os
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
P = ROOT / "recon/syslib/psx/libgpu/FONT.c"
raw = P.read_bytes()
assert b"\r\n" not in raw, "FONT.c must stay LF"
t = raw.decode("utf-8")

TAIL = (" *   colour-init order (r,g then maxx then b) on the (a) half = 6.  Both halves remain what\n"
        " *   the W52/W53 receipts say they are. */\n")
NEW = (
    " *   colour-init order (r,g then maxx then b) on the (a) half = 6.  Both halves remain what\n"
    " *   the W52/W53 receipts say they are.\n"
    " *\n"
    " *   W64-A3 -- FntPrint RE-VERIFIED PASS 240/240 (the W63 TEXT_MOVES row is wired and\n"
    " *   holding).  FntFlush's PLACEMENT axis re-probed in THIS 2-diff basin, all reverted:\n"
    " *   a void-tail fence immediately after `dr = &fs->draw_mode;` 2 (inert) * `dr` assigned\n"
    " *   just before the call instead of at the top 2 (inert) * `TermPrim(dr)` hoisted above\n"
    " *   the whole field-load block 27 (200 insns) * an identity launder on `dr` right before\n"
    " *   the call 45 (200 insns) * a void-tail fence right before the call 9 (198 insns).\n"
    " *   MECHANISM (so the next belt starts from the right place, not from spellings): the\n"
    " *   `dr` pseudo is SPILLED, so its def emits an output reload into $a2 plus the store,\n"
    " *   and reload1.c's choose_reload_regs then satisfies the call-argument input reload by\n"
    " *   INHERITING $a2 (it still validly contains the pseudo).  Retail did not inherit, i.e.\n"
    " *   in retail $a2 was no longer valid at that point.  Nothing in this block writes $a2\n"
    " *   (all eight following field loads are long-lived and take callee-saved registers), so\n"
    " *   the named angle is unchanged and precise: manufacture a SHORT-LIVED value between the\n"
    " *   spill and the call that the allocator must put in $a2 -- the 14C intruder-eviction\n"
    " *   device -- and the inheritance is invalidated for free.  There is no such value in the\n"
    " *   source today, and a hard-register clobber fence is pin-adjacent (user sign-off). */\n"
)
assert t.count(TAIL) == 1, "anchor count %d" % t.count(TAIL)
out = t.replace(TAIL, NEW).encode("utf-8")
tmp = P.with_suffix(".c.w64a3tmp")
tmp.write_bytes(out)
os.replace(tmp, P)
print("landed; bytes %d -> %d" % (len(raw), len(out)))
