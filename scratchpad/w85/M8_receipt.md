# W85-M8 receipt — CarIO_ReadInCarTextureData__FPcP8Car_tObjii (R-JPN)

Row: `regiondiff/recon/NFS4-R-JPN/game/psx/cario.cpp`, CHANGED, JPN.
Gate:
```
python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/game/psx/cario.cpp \
    CarIO_ReadInCarTextureData__FPcP8Car_tObjii,CarIO_UpdateCarTextureData__FPcP8Car_tObji \
    --lane-as=recon/game/psx/cario.cpp
```

## RESULT

| function | inherited (W84-R16) | now |
|---|---|---|
| `CarIO_ReadInCarTextureData__FPcP8Car_tObjii` | FAIL 228 (494/494 count-exact) | **REGION-PASS (494 insns)** |
| `CarIO_UpdateCarTextureData__FPcP8Car_tObji` | REGION-PASS 304 | **REGION-PASS (304 insns)** (unchanged, re-verified) |

Both rows of this candidate now REGION-PASS; gated 3x, identical each time.
**No pins, no volatile, no asm, no post-compile moves added.** Base tree, tools,
MANIFEST and the progress board untouched; the only file changed is the
candidate. (`update_region_progress.py` deliberately NOT run — the W85 GUIDE
forbids touching the PROGRESS board.)

Base-tree control re-verified unaffected:
`python tools/verify_asm.py recon/game/psx/cario.cpp CarIO_ReadInCarTextureData__FPcP8Car_tObjii,CarIO_UpdateCarTextureData__FPcP8Car_tObji`
-> `PASS (491 insns)` / `PASS (298 insns)`.

## THE FIX (two dials, neither of which works alone)

In the PALETTE licence-plate block of `CarIO_ReadInCarTextureData`:

1. `plate0` is a **BLOCK-SCOPE `short`** declared in that block (was a single
   function-scope carrier shared with the other licence-plate block), and
2. its **read is placed BEFORE the `clut` read** (was after `cx`/`cy`).

Landed form (each of the two licence-plate blocks now declares its own
`short plate0;`, and the function-scope carrier is gone):

```c
      if (shape != (shapetbl *)0x0) {
        int license;
        u_short clut;
        int cx;
        int cy;
        short plate0;

        license = 0;
        plate0 = CarIO_licensePlate[carType][0];
        clut = CarIO_carPixMap[palIndex].clut;
        cx = (clut & 0x3f) << 4;
        cy = (int)(clut >> 6);
        if (carType < 0x16 && plate0 >= 0) {
```

Measured interaction (this is the whole point — the two dials are only decisive
TOGETHER, which is why R16's one-axis-at-a-time sweep missed it):

| | fn-scope carrier | block-scope carrier |
|---|---|---|
| read after `cy` (R16 form) | **228** | **312** |
| read before `clut` | **228** | **REGION-PASS** |

Three orderings inside the block-scope basin all PASS: plate0 first
(`b1+p1`), `license = 0` then plate0 (`b1+p2`, landed), and plate0 first with
`license = 0` last (`b1+s3`). Dropping the now-unused function-scope carrier
and giving the FIRST block its own block-scope `short plate0;` too keeps the
PASS (`b1+p2+b5+h1` — the landed file).

## MECHANISM (proven with `-dg`/`-dl`, not inferred)

The 228 was ONE allocation with a ~200-line blast radius.

* Index-aligned side-by-side (count-exact, so index alignment is valid):
  renaming ours `$t1->$t0, $t2->$t1` collapsed 205 differing lines to a single
  18-instruction window (stream indices 347-364 plus the `lh …(t0)` vs
  `lh …(v1)` row reads at 374/375/400/407/408). Block 1 was already an EXACT
  match modulo that rotation.
* `CC1PLPSX -quiet -O2 -G8 -dg`, ours vs the base TU:

  | | spill pool (`Spilling reg N.`) | pseudos `in 8` |
  |---|---|---|
  | base `recon/game/psx/cario.cpp` (PASS 491) | 8, 9 = `$t0,$t1` | none |
  | JPN candidate (FAIL 228) | 9, 10 = `$t1,$t2` | **395** |

* Pseudo 395 = `&CarIO_licensePlate[carType]`, the row base of the palette
  block. `395 conflicts: … 2 3 4 5 6 7 29` — v0,v1,a0-a3 all unavailable
  across its range, so global-alloc took `$t0`; `$t0` then leaves the zero-use
  reload-scratch set and the pool rotates for all 494 insns.
* `tools/allocsim.py` reproduces the handout **MATCH 32/32 (order IDENTICAL)**
  and `tools/reqdelta.py --want p395=v1` finds **no single- or two-dial
  refs/live delta** that reaches it: the blocker is local-alloc's hard-reg
  usage in that block, not the global allocno priority — i.e. the dial had to
  be the SCHEDULE, which is what the two source dials move.
* Register handout, before -> after (after == retail):

  | pseudo | FAIL 228 | retail / now |
  |---|---|---|
  | palIndex<<4, elem addr | v1 | v0 |
  | carPixMap base | v0 | a0 |
  | clut | v1 | a0 |
  | carType*12 chain | v0 | v1 |
  | licensePlate row base | **t0** | **v1** |
  | plate0 | a0 | a0 (reuses clut's reg) |

* Why the two dials work: gcc-2.8.1 `sched.c` schedules the block BACKWARD with
  `INSN_PRIORITY` = longest path from the block start (only loads add depth),
  ties broken by `INSN_LUID`. With one function-scope carrier, sched1 issued the
  row-base add BEFORE the clut load and then used the plate0 load as the clut
  load's delay-slot filler, so the clut value and the row base were live at the
  same time. A fresh block pseudo whose read precedes the clut chain gives
  retail's order — clut load first, row-base add as its delay-slot filler,
  plate0 load deferred past `cx`/`cy` — so the clut dies into `$a0` before
  plate0 is loaded, the row base takes `$v1`, and nothing occupies `$t0`.

## FALSIFIED (every row a real gate run; all from the 228 basin)

STATEMENT / DECLARATION POSITION with the FUNCTION-SCOPE carrier — all inert,
confirming R16 (sched1 re-sorts the whole block):

| variant | what | result |
|---|---|---|
| p0 | plate0 read after `cy` (R16 baseline spelling) | 228 |
| p1 | plate0 read FIRST (before `license = 0`) | 228 |
| p2 | plate0 read between `license = 0` and `clut` | 228 |
| p3 | plate0 read between `clut` and `cx` | 228 |
| p4 | plate0 read between `cx` and `cy` | 228 |
| s1 | `license = 0` moved LAST (just before the `if`) | 228 |
| s2 | `license = 0` after `cy`, plate0 last | 228 |
| s3 | plate0 first, `license = 0` last | 228 |
| d0..d5 | `short plate0;` at all 6 positions in the fn decl list | 228 each |

SHAPE / TYPE / GUARD / ADDRESS SPELLING:

| variant | what | result |
|---|---|---|
| b1 | block-scope `short plate0` in the PALETTE block, read still last | **312** |
| b5 | block-scope `short plate0` in the FIRST block only | **312** |
| e1/e2 | two fn-scope shorts (separate carrier per block), both decl orders | **312** |
| b2 | named `short *lp` row pointer for all six palette accesses | 228 |
| b3 | named `short *lp` for the two guard reads only | 228 |
| f4 | named `short *lp` for the coordinate reads only | 228 |
| c1 | `clut` declared `int` | 228 |
| c2 | `clut` declared `u_int` | 228 |
| c7 | `cx`/`cy` via explicit `(int)clut` casts | 228 |
| c4 | nested `if (carType<0x16) { if (plate0>=0)` instead of `&&` | 228 |
| c5 | `plate0 = *CarIO_licensePlate[carType]` | 228 |
| f1 | `*(short*)((char*)CarIO_licensePlate + carType*12)` | 228 |
| f2 | index-term-first address spelling (W60-A6 lever) | 228 |
| f5 | `(&CarIO_carPixMap[palIndex])->clut` | 228 |
| b4 | `cy` computed before `cx` | **302** |
| c3 | `&&` operands swapped | **337** @493 |
| c6 | Yoda `plate0 == i` | **230** |
| b1+s1 / b1+c7 / b1+f1 / b1+c4 | block scope, read still after `cy` | 312 each |
| b1+p3 | block scope, read between `clut` and `cx` | **226** (the dial is partial: the read must precede the clut read) |

## REUSABLE LAWS FOR THE CATALOG

1. **DECLARATION SCOPE AND STATEMENT POSITION ARE ONE DIAL, NOT TWO.** Both were
   measured inert (228) or worse (312) on their own; together they are the
   match. A one-axis-at-a-time sweep of `{scope} x {position}` will report
   "everything is inert" and file a floor. Sweep the PRODUCT whenever a
   candidate lever is "declaration scope" (methodology 3.12 #15) — the
   companion axis is where the variable is first WRITTEN, because a fresh
   block pseudo only changes sched1's ready order if its defining insn moves.
2. **"ONE PSEUDO IN $t0" IS A DIAGNOSABLE, NAMEABLE DEFECT.** When a count-exact
   residual is a uniform reload-scratch rotation, diff the `-dg`
   `Register dispositions` histograms of the FAILing source against a PASSing
   sibling: a single extra `in <regno>` entry names the pseudo whose allocation
   causes the whole rotation, and `tools/allocsim.py` + `tools/reqdelta.py`
   then say whether the fix is a global-alloc dial (refs/live) or — when
   reqdelta finds nothing because the blocker is local-alloc's hard-reg use —
   a SCHEDULE dial, which is a source-shape question.
3. **REGIONAL ROWS SEEDED FROM A BASE TU INHERIT THE BASE'S REGISTER BUDGET.**
   The R-JPN delta added exactly one live value to a block that had no spare
   caller-saved register; the base TU passes only because that value does not
   exist there. When a regional delta adds a value to an existing block, expect
   the residual to be an allocation cascade, not the delta itself, and look for
   the spelling that lets the new value SHARE a register with a dying one
   (here: plate0 reusing the clut's `$a0`).

## INSTRUMENTS BUILT (scratchpad only — no `tools/` edits)

* `scratchpad/w85/M8_dump.py` — compiles a regiondiff candidate through
  `build.py` with the base TU's lane (temp copy beside the base TU, exactly like
  `verify_region`), objdumps one function, writes `M8_ours.txt`/`M8_oracle.txt`;
  `--rtl` additionally runs the real CC1PLPSX with `-dg -dl` into
  `scratchpad/w85/m8rtl/`. (This is the missing piece that lets the whole
  `-dg`/`allocsim`/`reqdelta` toolchain be pointed at a REGIONAL candidate.)
* `scratchpad/w85/M8_probe.py` + `scratchpad/w85/variants/*.py` — one-file
  source variants applied to a frozen baseline, each gated in ~0.6 s;
  variants compose (`M8_probe.py b1 p2 b5 h1`), which is how the product sweep
  above was run.
* `scratchpad/w85/M8_measure.py` — index-aligned ours-vs-oracle classification
  into REGONLY vs STRUCT diffs (valid while the streams are count-exact).
* Artefacts: `M8_base_cand.cpp` (frozen 228 baseline), `M8_final.cpp` (the
  landed body), `M8_sbs.txt`, `m8rtl/`, `m8rtl_base/`.

## NOTES / OUT OF SCOPE

* Two inherited `__asm__` devices remain in this candidate at lines 387
  (`CarIO_CopyToShape`) and 768 (`CarIO_CreateLicense`). They are verbatim
  copies of base-TU content in functions that are NOT rows of this candidate
  (no JPN manifest row covers them), so clearing them belongs to the base-tree
  device sweep, not to this regional row. My two rows added no device of any
  kind.
* `recon/game/psx/cario.cpp` shows as modified in `git status`, but not by me —
  I never wrote to the base tree (verified: `grep -c plate0 recon/game/psx/cario.cpp`
  = 0, no stray temp files in `recon/game/psx/`). Another W85 agent is working
  that TU; its base gate still PASSes for both of my functions.
