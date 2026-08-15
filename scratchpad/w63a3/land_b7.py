#!/usr/bin/env python3
"""W63-A3 landing 2: FntPrint sentinel -- cse constant-sharing breaker (identity launder)."""
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
P = ROOT / "recon/syslib/psx/libgpu/FONT.c"
t = P.read_text(encoding="utf-8", newline="")

OLD = """        while (len--, len != -1) {
            WriteChar(*bufPtr++);
        }
"""
NEW = """        /* MATCH (W63-A3): retail materializes the loop sentinel FRESH
         * (`addiu $a2,$zero,-1`) where every natural spelling of this countdown
         * gives us a COPY of the peel's -1 (`addu $a2,$v0,$zero`) -- cse's
         * constant-sharing: at the sentinel's DEF a register already holds -1, and
         * cse substitutes it (the launder protects USES, so a sentinel declared
         * INSIDE the guard is still copied).  Cure = give the sentinel its own
         * pseudo BEFORE the peel test, then identity-launder it so cse can neither
         * fold it back nor feed it to the peel's own compare -- both -1s are then
         * materialized independently, exactly retail's instruction set.
         * FALSIFIED first (all gate-measured, this basin): the plain comma-peel
         * (2), explicit peel with two literal -1 (2), laundered sentinel declared
         * inside the guard (2), void-tail fence between peel and loop (2),
         * read-only fence on len (2), peel spelled `len >= 0` (3, loses retail's
         * own `li $v0,-1`), un-laundered sentinel before the peel (5), laundered
         * sentinel used in BOTH tests (7), double launder (64).
         * The residual after this edit is a PURE ONE-LINE RELOCATION (`li $6,-1`
         * belongs after the peel branch, not before it) -- probe-verified TWICE as
         * PASS 240/240 with the PER_FN_TEXT_MOVES row below (scratchpad/w63a3):
         *     "recon/syslib/psx/libgpu/FONT.c": {
         *         "FntPrint": [
         *             {"take":  r"\\tli\\t\\$6,-1[^\\n]*\\n",
         *              "after": r"\\tbeq\\t\\$5,\\$2,\\$L\\d+\\n"},
         *         ],
         *     }
         * (the FONT.c entry already exists for FntFlush -- ADD this key to it;
         * a duplicate rel key would silently shadow the earlier entry, 12F). */
        {
            int neg1 = -1;
            __asm__("" : "=r"(neg1) : "0"(neg1));   /* cse constant-sharing breaker */
            len--;
            if (len != -1) {
                do {
                    WriteChar(*bufPtr++);
                    len--;
                } while (len != neg1);
            }
        }
"""
assert t.count(OLD) == 1, t.count(OLD)
t2 = t.replace(OLD, NEW)
P.write_text(t2, encoding="utf-8", newline="")
d = P.read_bytes()
assert d.count(b"\r") == 0, "CRLF leaked"
assert all(b >= 32 or b in (9, 10) for b in d), "control byte"
assert not any(b > 127 for b in d), "non-ascii"
print("landed B7, bytes", len(d))
