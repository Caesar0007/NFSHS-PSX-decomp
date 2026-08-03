#!/usr/bin/env python3
"""Land the w46-a2 res==1 arm (0-diff form) into memcard.c."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import a2_probe as pr

NL = pr.NL
NEW = NL.join([
"        /* MATCH (w46 -- THE SEAL, 2 -> 0): three cooperating pieces, all of them",
"         * consequences of ONE mechanism -- gcc-2.8 sched.c gives the FIRST insn",
"         * after a NOTE_INSN_LOOP_BEG a dependence on EVERY insn before it",
"         * (sched.c:2085 `if (loop_notes)' -- a full barrier), while flow.c counts",
"         * every ref inside the note pair with loop_depth weight.  The w45 form",
"         * needed the ref weight (see below) but paid the barrier BETWEEN the two",
"         * stores, which is what emitted `sw a1,0x34(a0)' five slots early.",
"         *",
"         * (1) SOURCE ORDER bReady-then-tick is MANDATORY and is NOT a scheduling",
"         *     choice: the two stores may-alias (same symbol, variable index), so",
"         *     sched2 can never swap them -- emission order == RTL order == source",
"         *     order.  Measured: every tick-first spelling emits `sw v1' first",
"         *     (the exact mirror of the old miss), every bReady-first spelling",
"         *     emits `sw a1' first.  8 spanning-wrapper depths x 2 orders confirm.",
"         * (2) THE REF DIAL still has to fire, because the two block-local QTYs",
"         *     fight for the low register: local-alloc.c's QTY_CMP_PRI =",
"         *     floor_log2(refs)*refs*size/(death-birth).  Un-dialled, the base qty",
"         *     is the COMBINED {high, lo_sum} pair (local-alloc.c:1444 combine_regs",
"         *     ties them because the `high' pseudo dies in the lo_sum insn), so it",
"         *     carries 2+3 = 5 refs and outranks the 2-ref timerhz value: base",
"         *     takes the lower reg ($v1) and timerhz is pushed to $a0 -- retail is",
"         *     $a0 base / $v1 timerhz.  Doubling timerhz's refs crosses the",
"         *     floor_log2 step at 4 (flr2 1->2) and inverts the pair.  Hence the",
"         *     do{}while(0) at DEPTH 2 (depth 0/1 = 14 diffs; 2, 3 and 4 all seal).",
"         * (3) The barrier is made HARMLESS by hoisting BOTH the address and the",
"         *     value out of the wrapper, so the only insn the note can pin is the",
"         *     tick store itself -- which is last in retail anyway.  `t' hoists the",
"         *     timerhz load (without it: 212 insns, 19 diffs); `g' hoists the addu.",
"         *     `g' MUST NOT carry the field offset: the natural",
"         *     `int *slot = &gMemCardInfo.existencecheckticks[idx]' makes fold",
"         *     reassociate base+0x40+idx*4 into (base+0x40) and re-bases BOTH",
"         *     stores off it (`addiu a0,a0,64' + `sw a1,-12(a0)', 4 diffs, count",
"         *     still exact).  The struct-cast view keeps the pointer at",
"         *     base+idx*4 = retail's $v0 and leaves 0x34/0x40 in the two store",
"         *     displacements.  g->existencecheckticks[0] IS",
"         *     gMemCardInfo.existencecheckticks[card-1], byte for byte.",
"         *     (Catalog w13 `struct-cast base+offset displacement' idiom.)",
"         * Basin note: decl order of idx/g/t is free (all 3 orders seal); inlining",
"         * idx into g seals too.  ~50 further spellings measured this wave, listed",
"         * in scratch/w46_a2_receipts.md.  DO NOT `simplify' g back to a plain",
"         * &array[idx] pointer, and do not drop either hoist. */",
"        status = 2;",
"        { int idx = card + -1;",
"          fMemCardInfo_def *g =",
"              (fMemCardInfo_def *)((char *)&gMemCardInfo + idx * 4);",
"          int t = timerhz;",
"        gMemCardInfo.bReady = cmd;",
"          do { do {",
"          g->existencecheckticks[0] = t;",
"          } while (0); } while (0);",
"        pCI->status = -1;",
"        }",
]) + NL

orig = pr.read()
a, b = pr.bounds(orig)
pr.write(orig[:a] + NEW + orig[b:])
print("landed", len(NEW))
