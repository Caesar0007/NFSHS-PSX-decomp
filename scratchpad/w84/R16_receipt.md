# W84-R16 receipt (regional-variant matching)

Rows: `scratchpad/w84/R16_rows.tsv` (14 rows).
Gate: `python regiondiff/tools/verify_region.py <REGION> <candidate> <fn> --lane-as=recon/<unit>.<ext>`

## Status board (live)

**12 / 14 REGION-PASS. 2 near-misses, both reduced to a single named gcc
decision with the mechanism proven (not "floors" -- open, with the exact
inequality/allocation that has to flip).**

| # | function | region | class | status |
|---|---|---|---|---|
| 1 | CarIO_ReadInCarTextureData__FPcP8Car_tObjii | JPN | CHANGED | FAIL 228 (494/494 count-exact; 1 reload-temp/allocation decision) |
| 2 | CarIO_UpdateCarTextureData__FPcP8Car_tObji | JPN | CHANGED | **REGION-PASS 304** |
| 3 | CalculateDimensions__11tDialogHelp | JPN | CHANGED | **REGION-PASS 350** |
| 4 | Draw__11tDialogHelp | JPN | CHANGED | FAIL 17 (140/139; 1 LICM hoist decision) |
| 5 | Track_DeInit__Fv | USA | CHANGED | **REGION-PASS 55** |
| 6 | Track_Init__FPc | USA | CHANGED | **REGION-PASS 291** |
| 7 | Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii | AU | CHANGED | **REGION-PASS 235** |
| 8 | Car_DoPostCollisionStuff__FP8Car_tObj | USA | CHANGED | **REGION-PASS 180** (pre-sealed, re-verified) |
| 9 | iSNDdmtransfer | USA | CHANGED | **REGION-PASS 129** (pre-sealed, re-verified) |
| 10 | Initialize__14tScreenMemcard | AU | CHANGED | **REGION-PASS 107** (pre-sealed, re-verified) |
| 11 | Init__14tCreditManageri | AU | CHANGED | **REGION-PASS 54** (pre-sealed, re-verified) |
| 12 | func_8004DD24 | FR-DE | REGION-ONLY | **REGION-PASS 37** (pre-sealed, re-verified) |
| 13 | func_800A7844 | USA | REGION-ONLY | **REGION-PASS 8** (pre-sealed, re-verified) |
| 14 | func_800DCC98 | JPN | REGION-ONLY | **REGION-PASS 2** (pre-sealed, re-verified) |

Files touched (ONLY my rows' candidates + this receipt; no git ops, no base
tree, no tool edits, no memory edits):
`regiondiff/recon/NFS4-R-USA/game/common/track.cpp` (new),
`regiondiff/recon/NFS4-R-JPN/game/psx/cario.cpp` (new),
`regiondiff/recon/NFS4-R-JPN/frontend/common/fedialog.cpp` (new),
`regiondiff/recon/NFS4-R-AU/game/psx/fe3dmenu.cpp` (new).
Rows 8-14's pre-existing candidates were re-verified UNCHANGED.

## New reusable finding (for the catalog)

**The `-dL` loop dump works on CC1PLPSX and reads out loop.c's LICM budget
directly.** `mipsel-none-elf-cpp -x c -D__cplusplus=1 -nostdinc -undef -Dmips
-D__mips__ -D__psx__ -I<recon> <tu>.cpp -o t.i` then
`CC1PLPSX -quiet -O2 -G<n> -dL t.i -o t.s` writes `t.i.loop`, one block per
function: `Loop from A to B: N real insns.` plus per-movable
`Insn I: regno R (life L), savings S {moved to J | not desirable | matches K}`.
Replaying `threshold*savings*life >= insn_count` (gcc-2.8.1 loop.c:1640) with
`threshold -= 3` after every move, over every loop in 5 dumped TUs, pins this
build's `threshold = 1 + n_non_fixed_regs` to **29..33 (best fit 31)** -- so a
LICM constant-hoist floor is now a NUMBER you can compute instead of a guess,
and the `matches` line tells you when `combine_movables` fused two identical
constants (which is what doubles savings AND life and flips the verdict).

Seeded (verbatim copies of the base TU) at session start:
- `regiondiff/recon/NFS4-R-USA/game/common/track.cpp` <- `recon/game/common/track.cpp`
- `regiondiff/recon/NFS4-R-JPN/game/psx/cario.cpp` <- `recon/game/psx/cario.cpp`
- `regiondiff/recon/NFS4-R-JPN/frontend/common/fedialog.cpp` <- `recon/frontend/common/fedialog.cpp`
- `regiondiff/recon/NFS4-R-AU/game/psx/fe3dmenu.cpp` <- `recon/game/psx/fe3dmenu.cpp`

## Per-row detail

### 5+6. Track_DeInit__Fv / Track_Init__FPc -- R-USA -- REGION-PASS (both)
Candidate `regiondiff/recon/NFS4-R-USA/game/common/track.cpp`.
Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/track.cpp Track_DeInit__Fv,Track_Init__FPc --lane-as=recon/game/common/track.cpp`
- MEASURE (unedited seed): `Track_DeInit__Fv FAIL 2` (ours 53 / oracle 55), `Track_Init__FPc FAIL 8` (ours 283 / oracle 291). Every diff was oracle-only -> pure ADDITIONS, no codegen fight.
- Regional delta (one line): retail adds a REGION-ONLY helper pair around the
  chunk-visibility allocation -- `func_800A7788(newGpCell + 42)` +
  `func_800BB2F4(RDAT_801144E0[0])` at the tail of Track_Init (plus a third
  head zero-store of the new gp cell), and `func_800A77C0()` between
  `BWorldSm_DeInit()` and `DeInitArtResources()` in Track_DeInit.
- Identification: `func_8007F38C`/`func_800BA0D0` = BWorldSm_DeInit /
  DeInitArtResources (base 0x8007E968 / 0x800B9408, consistent regional
  shift); `func_800A77C0`, `func_800A7788`, `func_800BB2F4` are REGION-ONLY
  rows in `oracles/NFS4-R-USA/INDEX.tsv` (callers column names Track_Init /
  Track_DeInit), so they are declared `extern "C"` and called, not invented.
- gp cell named `RDAT_8013E7B8` = R-USA gp base 0x8013D83C + 0xF7C (gp base
  derived from the sibling candidate `game/common/copspeak.cpp`'s
  `RDAT_8013E3B8 = gp+0xB7C`). TU-owned tentative def -> `.comm` -> gp-rel
  (methodology 3.12 #6), matching the oracle's `sw zero,3964($gp)`.
- The absolute cell used the **unsized-array** shape `extern int
  RDAT_801144E0[];` + `[0]` (3.12 #5): the oracle loads it with a SEPARATE
  %hi scratch (`lui $v0; lw $a0,17632($v0)`); a scalar `extern int` would
  have folded to the self-temp `lui $a0; lw $a0`.
- Result: REGION-PASS 55 / REGION-PASS 291, first gate after the edit.

### 1. CarIO_ReadInCarTextureData__FPcP8Car_tObjii -- R-JPN -- FAIL 228 diffs (ours 494 / oracle 494, COUNT-EXACT)
Candidate `regiondiff/recon/NFS4-R-JPN/game/psx/cario.cpp`.
Gate: `VA_MAX=30 python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/game/psx/cario.cpp CarIO_ReadInCarTextureData__FPcP8Car_tObjii --lane-as=recon/game/psx/cario.cpp`
- MEASURE (unedited seed): FAIL 225 (ours 491 / oracle 494).
- Regional delta (shared with row 2): retail JPN guards BOTH licence-plate
  blocks with a NON-NEGATIVE plate index. `CarIO_licensePlate[carType][0]` is
  read into a `short` local before the recolour test and the arms run only
  when it is `>= 0`:
  `if (carType < 0x16 && plate0 >= 0) { if (i == plate0) ... }`.
  The oracle's `lhu` + `sll/sra` pair (instead of a plain `lh` array read) is
  the tell that the value lives in a HImode pseudo, i.e. a `short` LOCAL, not
  a direct array reference -- a direct `CarIO_licensePlate[carType][0] >= 0`
  would have emitted `lh`.
- After both guards the instruction stream is COUNT-EXACT (494/494) and every
  opcode matches; the residual is ONE allocation decision, uniform:
  ours `t1`->oracle `t0`, ours `t2`->oracle `t1` (37 hits, the reload temps
  shifted by one) because in the PALETTE block ours needs a THIRD register:
  ours {clut=$v1, plateBase=$t0, plate0=$a0}, oracle {clut=$a0,
  plateBase=$v1, plate0=$a0}. Retail's `plate0` load is scheduled AFTER `clut`
  dies (`andi`/`sll`/`srl` first) so plate0 REUSES clut's register; our sched1
  pairs the two `lhu` loads, overlapping the ranges and consuming $t0, which
  pushes reload's round-robin temps from t0/t1 to t1/t2.
- Falsified angles (each measured):
  * block-scope `short plate0;` in each of the two blocks: FAIL 312 with a
    full s0..s4 allocation ROTATION on top. Moving the declaration to
    FUNCTION scope (one carrier) removed the whole s-rotation: 312 -> 228.
    (methodology 3.12 #15 "declaration scope is load-bearing".)
  * declaration POSITION inside the function decl list (3 positions tried):
    228 every time -- neutral.
  * nested `if (carType < 0x16) { if (plate0 >= 0)` instead of `&&`: 228, no
    change.
  * moving the `plate0 = ...` STATEMENT (before `clut`, between `clut` and
    `cx`, after `cy`): 228 every time -- sched1 reorders it regardless.
  * loading plate0 INSIDE the `carType < 0x16` guard: FAIL 317 and one insn
    SHORT (493) -- strictly worse; retail loads it unconditionally.
  Left in its best-gated state (228 diffs, count-exact, one allocation
  decision). No pins, no volatile, no asm.

### 2. CarIO_UpdateCarTextureData__FPcP8Car_tObji -- R-JPN -- REGION-PASS (304 insns)
Same candidate/TU as row 1; same regional delta applied to both of this
function's licence-plate blocks (the `pmx->clut` block and the `palIndex`
palette block).
- MEASURE (unedited seed): FAIL 20 (ours 298 / oracle 304).
- 1st guard: 20 -> 10. 2nd guard: 10 -> REGION-PASS 304/304.
Gate: `python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/game/psx/cario.cpp CarIO_UpdateCarTextureData__FPcP8Car_tObji --lane-as=recon/game/psx/cario.cpp`

### 3. CalculateDimensions__11tDialogHelp -- R-JPN -- REGION-PASS (350 insns)
Candidate `regiondiff/recon/NFS4-R-JPN/frontend/common/fedialog.cpp`.
- MEASURE (unedited seed): FAIL 35 (ours 359 / oracle 350).
- Regional delta, two parts:
  (a) every help text ID is +1 vs the base build (0x59->0x5a, 0x52->0x53,
      0x53->0x54, 0x56->0x57, 0x55->0x56, 0x54->0x55, 0x57->0x58,
      0x58->0x59, and both `AddItem(0x56,8)` -> 0x57): one extra entry earlier
      in the Japanese string table. 9 `li $a1,K` sites (the two identical
      `AddItem(0x56,8)` calls are cross-jump-merged into one).
  (b) no two-controller widening: the `helpcontrollers == 3` arm and its 0x46
      text inset are gone -- the JPN build always does
      `lefttext = 0x28; width += 0x28;` (that is the whole -9 instruction
      delta).
Gate: `python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/frontend/common/fedialog.cpp CalculateDimensions__11tDialogHelp --lane-as=recon/frontend/common/fedialog.cpp`

### 7. Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii -- R-AU -- REGION-PASS (235 insns)
Candidate `regiondiff/recon/NFS4-R-AU/game/psx/fe3dmenu.cpp`.
- MEASURE (unedited seed): FAIL 5 (ours 234 / oracle 235).
- Regional delta: (a) retail lifts the menu view 8 pixels -- `posY = posY - 8;`
  before the showroom override (the oracle's `addiu $s0,$s0,-8` rides the
  `showRoomFlag` branch delay slot, so it applies on both paths);
  (b) the projection-correction matrix entry `correct.m[4]` is `0xad80`
  (44416) instead of the base build's `0x8980` (35200).
- REGION-PASS on the first gate after the edit.
Gate: `python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/game/psx/fe3dmenu.cpp Draw_MenuRenderingView__FP8Car_tObjP13DRender_tViewiiiUliffii --lane-as=recon/game/psx/fe3dmenu.cpp`

### 4. Draw__11tDialogHelp -- R-JPN -- FAIL 17 diffs (ours 140 / oracle 139); ONE LICM decision
Candidate `regiondiff/recon/NFS4-R-JPN/frontend/common/fedialog.cpp`.
Gate: `VA_MAX=60 python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/frontend/common/fedialog.cpp Draw__11tDialogHelp --lane-as=recon/frontend/common/fedialog.cpp`
- MEASURE (unedited seed): FAIL 94 (ours 187 / oracle 139).
- Regional delta: the Japanese build DROPS the whole `helpcontrollers` fan-out
  in the per-item loop -- no pad-35 arm, no special two-button arm, no
  0xa0/0x50/0x40 test. Only the plain pad-65 `FeTools_DrawPSXButton(0x41,
  cont[i], left+0x14, (i-1)*0xf + top + 0x13)` survives. With the single use
  left, gcc narrows `lw`+`andi 0xffff` to the oracle's one `lhu 176(v0)`.
  94 -> 40.
- 2nd edit: the shorter body makes gcc ROTATE the item `for` loop (bottom
  test), while retail keeps top-test + unconditional `j` back-edge. Spelled
  exit-in-the-middle (`while (1) { if (i >= numItems) break; ... i++; }`) per
  catalog B / methodology 3.12 #15a-inverse. 40 -> 17.
- RESIDUAL = exactly ONE gcc decision: the constant `1` (`textState_Selected`,
  the 5th stack argument of the two FETextRender_FullText call sites) is
  LOOP-INVARIANT-HOISTED into `$s7` (frame 144 vs 136, +`sw/li/lw s7`),
  where retail rematerializes `li v0,1` in each arm.
  PROVEN mechanism, not a guess -- `-dL` loop dump of the real CC1PLPSX
  (`cpp -x c ... | CC1PLPSX -quiet -O2 -G0 -dL`) prints for this function:
      Loop from 83 to 390: 112 real insns.
      Insn 282: regno 172 (life 1), savings 1 not desirable
      Insn 310: regno 183 (life 2), move-insn savings 2  moved to 416
      Insn 362: regno 199 (life 1), done move-insn matches 310
  i.e. `combine_movables` MATCHES the two `li 1` movables (insn 362 matches
  310), summing them to savings 2 / life 2, and `move_movables` then fires on
  `threshold * savings * life >= insn_count` (gcc-2.8.1 loop.c:1640).
  Solving that inequality across every loop in 5 dumped TUs pins
  `threshold = (loop_has_call?1:2)*(1+n_non_fixed_regs)` to 29..33 (best fit
  31), so the hoist needs `4*T >= 112`; retail's identical loop must have had
  `insn_count >= 4*T+1` (i.e. 5..21 more pre-combine RTL insns) or the two
  constants must not have matched.
- Falsified angles (each measured):
  * `int control = this->cont[i];` (base form, to add an insn): 140/17, no
    change -- gcc still narrows to `lhu`.
  * dropping the two inherited `__asm__("")` allocation fences in the head:
    139/**20** -- instruction count becomes exact but the tick load loses
    retail's `lw v0,-4744(v0)` + `addu a0,v0,zero` split (2 new diffs) and the
    `$s7` hoist SURVIVES. Reverted; the fences are base-TU user work.
  * `this->variant = i;` probe (+1 real insn in the loop): 141/18, hoist
    survives -> `T >= 29`, so a 1-insn budget nudge is NOT enough.
  Left in its best-gated state (17 diffs). No pins, no volatile, no asm added.

### 8. Car_DoPostCollisionStuff__FP8Car_tObj -- R-USA -- REGION-PASS (180 insns)
Pre-existing candidate `regiondiff/recon/NFS4-R-USA/game/common/cars.cpp`
re-verified unchanged.
`python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/cars.cpp Car_DoPostCollisionStuff__FP8Car_tObj --lane-as=recon/game/common/cars.cpp`

### 9. iSNDdmtransfer -- R-USA -- REGION-PASS (129 insns)
Pre-existing candidate `regiondiff/recon/NFS4-R-USA/eaclib/psx/sndpsxz/sdma.c`
re-verified unchanged.
`python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/eaclib/psx/sndpsxz/sdma.c iSNDdmtransfer --lane-as=recon/eaclib/psx/sndpsxz/sdma.c`

### 10. Initialize__14tScreenMemcard -- R-AU -- REGION-PASS (107 insns)
Pre-existing candidate re-verified unchanged.
`python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/common/screenmemcard.cpp Initialize__14tScreenMemcard --lane-as=recon/frontend/common/screenmemcard.cpp`

### 11. Init__14tCreditManageri -- R-AU -- REGION-PASS (54 insns)
Pre-existing candidate re-verified unchanged.
`python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/common/fecredits.cpp Init__14tCreditManageri --lane-as=recon/frontend/common/fecredits.cpp`

### 12/13/14. func_8004DD24 (FR-DE) / func_800A7844 (USA) / func_800DCC98 (JPN)
REGION-ONLY, pre-existing candidates re-verified unchanged:
REGION-PASS 37 / REGION-PASS 8 / REGION-PASS 2 insns.
`python regiondiff/tools/verify_region.py FR-DE regiondiff/recon/NFS4-R-FR-DE/regiononly/func_8004DD24.cpp func_8004DD24`
`python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_800A7844.cpp func_800A7844`
`python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/regiononly/func_800DCC98.cpp func_800DCC98`
