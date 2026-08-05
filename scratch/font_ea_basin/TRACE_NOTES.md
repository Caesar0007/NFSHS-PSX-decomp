# Font 8004efb4 — instrumented-cc1 trace run on the EA-natural basin (2026-08-05)

Ordered by user: "run the instrumented-cc1 [qty_order]/[find_free_reg] trace targeting e3/e4".
Instrument: C:/Temp/nfs4-instr-cc1/cc1plus-ecoff.exe (w46-a10 build), recipe scratch/w46_a10_receipts.md.
Inputs: mine/psxfront_e3.i / _e5.i (gate-identical preprocessing, bodies from scratch/font_ea_basin/).
Flags: -quiet -O2 -G4 -mgas -msplit-addresses -funsigned-char -fno-exceptions -fno-rtti.
Traces: C:/Temp/nfs4-instr-cc1/trace_e3.txt / trace_e5.txt (Font section ~80 lines each).

## FIDELITY: 100%
Lab cc1plus output for Font on e3 == real CC1PLPSX byte-for-byte (79/79 insns, 0 mismatches).
The traces are RECEIPTS for the gate compilation, not illustrations.

## THE ALLOCATION, DECODED (regs: 2=v0 3=v1 4=a0 5=a1 6=a2 7=a3 8..15=t0..t7 24=t8 16=s0)

e3 (param-mutation body): PASS 1 (suggested) allocates u(qty24)->a3, src(15)->a2, x(0)->a0,
**y(qty10/pseudo81, refs10, sg=1 COPY-sugg) -> a1**. Pass 2 then: prim(qty6/87, refs26,
pri 7536)->t0, the mega-CSE qty16/150(refs17)->v1, tpage-load qty23->a2(after src dies), etc.
Everything downstream of y-on-a1 rotates one reg off retail.

e5 (fresh `ytop` var, y single-read): the COPY-sugg dies (only 3 [qty_sugg] lines) BUT
qty10 is now pseudo 91 (the ytop chain) and STILL allocates in pass 1 with sugg 1 -> a1:
combine substituted hard a1 into the subu, and the OPERAND-TIE suggestion (qty_phys_sugg)
re-created the a1 bond. e3 and e5 emit BYTE-IDENTICAL Font asm.

## 🔴 LAW (trace-proven): the ytop-chain/a1 tie is SPELLING-INVARIANT in this basin.
Whether the chain head is a mutated param (copy-sugg) or a fresh var consuming the arrival
reg (operand-tie sugg), local-alloc's SUGGESTED PASS hands it a1 BEFORE any ordinary qty
competes. No source spelling of `first = y - yoff` escapes both channels.

## RETAIL'S ALLOCATION, REVERSE-ENGINEERED (consistent with every window in the trace)
Retail needs ytop's pass-1 a1 attempt to FAIL (or the qty to be unsuggested), so that:
1. p128 (2nd src+0xc read, pri ~2592, window ~[84,138)) allocates first in pass 2,
   scan 2/3/4 blocked -> takes a1  (retail `lw a1,12(a2)` — the old p128 razor).
2. ytop (pri ~1093, window ~[28,154)) then scans: a1 blocked by p128-inside-window,
   a2/a3 blocked (src/u live into the window), t0-t7 blocked (dv/prim/pal/masks/yoff/
   height/width) -> first free = reg 24 = **t8**. Exactly retail.

## REMAINING UNKNOWN (the one question left)
What condition makes the pass-1 suggested try fail/not exist in retail's compile of the
SAME chain-head insn (`subu t8,a1,t4` — src1 IS the dying a1 there too). Candidates to
settle by READING the patched local-alloc.c (scratch/instr, branch w46-a10):
- exact qty_phys_sugg recording conditions (when is the operand-tie NOT recorded);
- find_free_reg(just_try_suggested) window semantics at the birth luid (born==death
  boundary parity — could retail's ytop window OVERLAP the hard-a1 range [0,born)?);
- qty_combine effects on the chain qty's birth (a merge that widens the window into
  the hard-a1 live range would block the pass-1 try and produce EXACTLY retail);
- scheduling (sched1 runs before local-alloc; luid layout differences move windows).
NOT candidates any more: every source-level spelling dial (falsified across e1..e5 +
the 48-basin's full receipt).

## STATE
e3/e4 stay the SYM/SLD-true reference bodies at 124@82 (gate), shipping 48-body unchanged.
Next concrete step: local-alloc.c condition read + a targeted instrument print at the
just_try_suggested rejection site, then re-run this exact lane (fidelity is proven, the
loop is minutes per iteration).
