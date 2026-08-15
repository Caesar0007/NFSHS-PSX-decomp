#!/usr/bin/env python3
"""W63-A3 landing 1: FntPrint void-tail fence that blocks reorg's eager steal."""
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
P = ROOT / "recon/syslib/psx/libgpu/FONT.c"
t = P.read_text(encoding="utf-8", newline="")

OLD = """    ch = *f;
    if (ch == 0)
        goto fnt_done;
    {
        percent = ch ^ (ch ^ '%');
    }
"""
NEW = """    ch = *f;
    if (ch == 0)
        goto fnt_done;
    /* MATCH (W63-A3, 3 -> 2 and the count became EXACT 240/240): retail leaves the
     * `beqz $a0` zero-check delay slot EMPTY; reorg steals `percent`'s `li $s4,37`
     * from the fall-through thread into it (fill_slots_from_thread), so ours ran one
     * instruction short.  A void-tail fence at the HEAD of that thread is the one
     * instrument that reaches reorg (stop_search_p returns 1 at any asm) and it is
     * zero-insn.  Placement variants all measure identically (2/240): fence before
     * this block, fence inside it, and a read-only fence on `ch`; the void-tail form
     * is kept because it neither adds a ref nor names a value. */
    __asm__("" : : "i"(0));
    {
        percent = ch ^ (ch ^ '%');
    }
"""
assert t.count(OLD) == 1, t.count(OLD)
t2 = t.replace(OLD, NEW)
assert len(t2) > len(t)
P.write_text(t2, encoding="utf-8", newline="")
d = P.read_bytes()
assert d.count(b"\r") == 0, "CRLF leaked"
assert all(b >= 32 or b in (9, 10) for b in d), "control byte"
assert not any(b > 127 for b in d), "non-ascii"
print("landed A1, bytes", len(d))
