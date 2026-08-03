# WAVE-46 a10 — GCC LANE ROUND 2 — REQUIRED-DELTA RECEIPTS

**Status: LIVE (stub committed early — poll this path).**
Consumers: a1 (DrawGouraudShape / FontUpsideDownBlit), a2 (hce arm-0 find_reg preference),
a3 (PrimMenu qty table), a5 (BuildNumbers pSprt / Wingman / BuildTach), a9 (CreateLicense
PRECOMPUTE_REGISTER_PARAMETERS).

Predecessor receipts (READ THEM FIRST, still fully valid): `scratch/w45_a10_receipts.md`
— §0 allocsim model, §1 DrawGouraudShape delta, §2 hce delta, §3 Font all-local proof
(`QTY_CMP_PRI == allocno_compare`), §4 DrawQuad, §5 BuildNumbers, §6 how-to-run, §7 cc1 build recipe.

---

## STATUS BOARD (updated live)

| deliverable | state |
|---|---|
| 1. instrumented cc1 rebuild (+ committed patches/script) | IN PROGRESS |
| 2. ECOFF reconfigure | pending |
| 3. local-alloc QTY-identity replica in allocsim | pending |
| 4. calls.c PRECOMPUTE_REGISTER_PARAMETERS trigger (a9) | pending |
| 5. new trace points (find_free_reg, reload1 6277/7362) | pending |
| 6. on-demand receipts (a1/a2/a3/a5) | OPEN — post requests, they get served here |

## HOW TO REQUEST A RECEIPT
Post (in your report / or just rely on this file): the FN NAME, the TU, and the wanted
register assignment (`--want "pN=tM"` form or "retail puts X in $a0, ours puts Y").
If your worktree has the `-dg`/`-dl` dumps already, say where; otherwise I generate them.

## HOW TO RUN THE INSTRUMENT YOURSELF (unchanged from w45 §6)
```bash
python tools/rtl_dump.py   <cpp>  -dg -dl      # C++ lane  -> scratch/rtl/
python tools/rtl_dump_c.py <c>    -dg -dl      # C lane
python tools/allocsim.py <greg> <lreg> "<fn-signature>"
python tools/reqdelta.py <greg> <lreg> "<fn>" --want "p82=t2,p166=t3"
python tools/allocsim.py <greg> <lreg> "<fn>" --what-if 90:refs=7
python tools/pseudoid.py <lreg> "<fn>" 90 82 166
```
