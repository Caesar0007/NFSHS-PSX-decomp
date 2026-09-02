# W84-R09 receipt — regional-variant matching (10 rows)

Gate (all rows): `python regiondiff/tools/verify_region.py <REGION> <candidate> <fns> [--lane-as=recon/<unit>.<ext>]`

## Row status

| # | function | region | class | status |
|---|---|---|---|---|
| 1 | Physics_Real__FP8Car_tObj | USA | CHANGED | **REGION-PASS (1273 insns)** � sealed this wave |
| 2 | InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem | USA | CHANGED | **REGION-PASS (354 insns)** — sealed this wave |
| 3 | main | AU | CHANGED | **REGION-PASS (237 insns)** — re-confirmed |
| 4 | DoLanguageScreen__Fv | UK-SW | CHANGED | **FAIL 4** (was FAIL 6) — one scheduling pair left |
| 5 | Movie_Play__Fc | AU | CHANGED | **REGION-PASS (136 insns)** — re-confirmed |
| 6 | func_80012F40 | JPN | REGION-ONLY | **REGION-PASS (106 insns)** — re-confirmed |
| 7 | Device_VerifyType__Fi | JPN | CHANGED | **REGION-PASS (47 insns)** — re-confirmed |
| 8 | Front_InitialMemCardCheck__Fv | AU | CHANGED | **REGION-PASS (42 insns)** — re-confirmed |
| 9 | AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails | USA | CHANGED | **REGION-PASS (8 insns)** — re-confirmed |
| 10 | func_800DCED0 | AU | REGION-ONLY | **REGION-PASS (2 insns)** — re-confirmed |

### Re-confirmation commands run (all PASS)
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/aiscript.cpp AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails --lane-as=recon/game/common/aiscript.cpp
python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/game/psx/device.cpp Device_VerifyType__Fi --lane-as=recon/game/psx/device.cpp
python regiondiff/tools/verify_region.py AU  regiondiff/recon/NFS4-R-AU/frontend/common/front.cpp Front_InitialMemCardCheck__Fv --lane-as=recon/frontend/common/front.cpp
python regiondiff/tools/verify_region.py AU  regiondiff/recon/NFS4-R-AU/frontend/psx/movie.cpp Movie_Play__Fc --lane-as=recon/frontend/psx/movie.cpp
python regiondiff/tools/verify_region.py AU  regiondiff/recon/NFS4-R-AU/game/common/nfs3.cpp main --lane-as=recon/game/common/nfs3.cpp
python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/regiononly/func_80012F40.cpp func_80012F40
python regiondiff/tools/verify_region.py AU  regiondiff/recon/NFS4-R-AU/regiononly/func_800DCED0.cpp func_800DCED0
```

## Work log (open rows)

### Row 4 — DoLanguageScreen__Fv @UK-SW (frontend/psx/psxfront) — 6 -> 4 diffs
Gate: `python regiondiff/tools/verify_region.py UK-SW regiondiff/recon/NFS4-R-UK-SW/frontend/psx/psxfront.cpp DoLanguageScreen__Fv --lane-as=recon/frontend/psx/psxfront.cpp`
Regional delta: the UK-SW build compiles a REAL language-select screen where the
USA base has a 2-line stub (`if (language==0xFF) language=0;`) — the candidate is
effectively a REGION-ONLY body (182 insns) already reconstructed by an earlier wave.

Fixes landed this wave (6 -> 4):
1. **Load loop as an explicit walking pointer** `shapeBase = shapes; for(;i<7;i++) *shapeBase++ = locateshapez(...)`
   instead of `shapes[i] = ...`. The oracle keeps ONE pseudo in `$s4` for both the
   load-loop induction variable and the later draw-loop base; the index form made
   gcc create a separate giv, so any later `shapeBase = shapes` re-assignment lost
   the `$s4`/`$s5` allocation to `flash` (28 diffs when the reset was moved early).
2. **`i = 0;` hoisted above `shapeBase = shapes;`** (loop written `i = 0; shapeBase = shapes; for(; i<7; i++)`)
   — oracle emits `addu s1,s3,zero` before `addiu s4,sp,48`. (-2)
3. **`shapeBase = shapes;` AFTER the `movfxya` call**, not before — measured:
   after=4, before/before-settrans/before-Quick_DD/&shapes[0]=8. With it after the
   call, reorg's forward scan fills the `jal movfxya` delay slot with `addiu s4,sp,48`
   exactly like retail (before the call, the backward scan grabs `addu a2,s5,zero`). (-2)

Remaining 4 diffs = ONE placement pair, `addu a0,zero,zero; addu s1,a0,zero`
(VSync's 0-argument + `i = 0` sharing the constant). Ours schedules the pair AFTER
the `lw v0,68(sp); li s2,4; lh v1,4(v0)` group; retail schedules it BEFORE. Falsified:
- statement order `i=0` first / last / between (a,b,c,e,f): position and copy DIRECTION
  trade off exactly — `i=0` first gives the right slot but `addu s1,zero,zero; addu a0,s1,zero`
  (i owns the constant); `VSync(0); i=0;` gives the oracle's direction but 3 insns late. All 4 diffs.
- `VSync` moved before the width computation (d): 10-14 diffs (loses the `subu` delay slot).
- shared zero temp `vsyncWait` (g,h,i): gcc coalesces the temp with whichever copy
  target comes first — same two outcomes, 4 diffs; the extra local caused NO cascade.
- dropping the `anchorShape` temp (j), `anchorShape` inside the inner block (l),
  `shapeOffset` after `x` (k): 4 / 4 / 7.
- block-scope nudges: extra do{}while(0) level (n) 6; `i=0` at outer levels (o,q) 4;
  FLATTENING the existing do{}while(0) nest (m,r) 44-46 — the nest is load-bearing
  (catalog A-37 block-scope pseudo numbering), do not "tidy" it.
- real `for (i = 0; i < 2; )` loop instead of the label/goto draw loop: not viable
  (the body still ends `goto language_draw_loop;`; a full conversion also changes the
  matched test-at-top + unconditional-`j`-back topology, catalog B-57).
Mechanism (from gcc-2.8.1 sched.c `priority()`/`rank_for_schedule` + reorg.c
`fill_simple_delay_slots`, read this wave): all five insns in that stretch have
priority 1, so the order is the LUID (source-statement) order, and cse's
copy-propagation always gives the constant to the FIRST-assigned pseudo. Position
(needs `i = 0` first) and copy direction (needs the VSync argument first) are
therefore in direct conflict under this compiler for every source order tried.
Backups: scratchpad/w84/psxfront_UKSW_best6.cpp (prior state), psxfront_UKSW_best4.cpp (current).


### Row 2 — InstanceGroup__5Chunk... @USA (game/common/chunk) — TODO -> REGION-PASS (354 insns)
Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/chunk.cpp InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem --lane-as=recon/game/common/chunk.cpp`
Seed: verbatim copy of `recon/game/common/chunk.cpp` -> measured FAIL 77 (ours 329 / oracle 354).

Regional delta (the +25 insns, retail @8008C1BC): a **census pass** the matched base
build does not have — after the CHUNK_COMMMODE if/else (BOTH arms reach it; the
non-COMMMODE arm ends `j .L8008C1BC`), walk `objInstanceBuf` and increment a global
counter once per type-5 instance:
```c
if (this->objInstanceBuf != 0) {
  inst = (Trk_SimpleInst *)(this->objInstanceBuf + 1);
  numElements = this->objInstanceBuf->m_num_elements;
  for (i = 0; i < numElements; i++) {
    if (*((char *)inst + 2) == '\x05') RDAT_8013E7B8 = RDAT_8013E7B8 + 1;
    inst = (Trk_SimpleInst *)((int)inst + (int)*(short *)inst);
  }
}
```
The counter is `RDAT_8013E7B8` (mechanical name; region VA 0x8013E7B8, absolute
lui/lw + lui/sw so not gp-rel/not TU-owned; no caller or string in this region's
INDEX.tsv identifies it, so identity stays TBD per the no-auto-naming rule).
jump.c threads the `objInstanceBuf == 0` exit of the clamp guard straight past the
census block to the geometry section — that is why the first `beqz` targets .L8008C220.

Second fix (77 -> 50 -> PASS): with the census block added the count was EXACT
(354/354) but every `mem`/`simGroup` use was a uniform **$s3 <-> $s4 swap** (25 diff
pairs). Cause: the base TU's redundant local copy `SimpleMem *groupMem = mem;`.
The extra 25-insn block lengthens the mem pseudo's live range, and with the extra
copy pseudo present the priority tie flipped `mem`->$s3 / `simGroup`->$s4 (oracle:
`mem`->$s4, `simGroup`->$s3). **Deleting `groupMem` and using the `mem` parameter
directly** took 50 -> 0 in one edit. (Catalog A: uniform 2-register swap with an
exact count = one allocation decision; the dial here was removing a pseudo, not
adding one.) No volatile/asm added; the two base `__asm__("" : : "r"(i))` fences in
the sim-object counting loop were inherited from the base TU seed and left untouched.
Backup of the 50-diff state: scratchpad/w84/chunk_USA_50.cpp


### Row 1 � Physics_Real__FP8Car_tObj @USA (game/common/physics) � TODO -> REGION-PASS (1273 insns)
Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/physics.cpp Physics_Real__FP8Car_tObj --lane-as=recon/game/common/physics.cpp`
Seed: verbatim copy of `recon/game/common/physics.cpp` -> measured FAIL 15 (ours 1272 / oracle 1273).

Regional delta = ONE guard, a single source line (the whole 1273-insn body is
otherwise identical to the matched base):
```
base   : lw v1,56(v0) ; li v0,128 ; bne v1,v0   ->  PHYSICS_SGGE == 0x80
retail : lw v0,56(v0) ; andi v0,v0,128 ; beqz   ->  (PHYSICS_SGGE & 0x80U) != 0
```
i.e. the SGGE cheat-flag word `GameSetup_gData[14]` is tested BY BIT in the retail
builds and BY EQUALITY in the matched base. (The same word's two other tests in this
function, `PHYSICS_SGGE & 8U`, are already bit tests in both builds and matched from
the seed; the regional m2c confirms all three at region VA 0x801144DC ==
GameSetup_gData+0x38.) The bit test also costs +1 insn, which is exactly the 1272 vs
1273 count gap, and it re-colours the call result `$a0`->`$v1` for free.
One-line fix -> 15 diffs -> 0.

Coverage note: MANIFEST rows 121/140 list this variant as `AU+FR-DE+JPN+UK-ES-IT+UK-SW+USA`
(one byte-variant across all six regionals), so the USA seal covers every region for
both Physics_Real and Chunk::InstanceGroup.


## Final verification sweep (all 10 rows, re-run at end of wave)
```
Physics_Real__FP8Car_tObj:                    REGION-PASS (1273 insns) [NFS4-R-USA]
InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem: REGION-PASS (354 insns) [NFS4-R-USA]
main:                                         REGION-PASS (237 insns) [NFS4-R-AU]
DoLanguageScreen__Fv:                         FAIL 4 diffs (ours 182 / oracle 182) [NFS4-R-UK-SW]
Movie_Play__Fc:                               REGION-PASS (136 insns) [NFS4-R-AU]
func_80012F40:                                REGION-PASS (106 insns) [NFS4-R-JPN]
Device_VerifyType__Fi:                        REGION-PASS (47 insns) [NFS4-R-JPN]
Front_InitialMemCardCheck__Fv:                REGION-PASS (42 insns) [NFS4-R-AU]
AIScript_Assign__FP10AIScript_tPA7_...:       REGION-PASS (8 insns) [NFS4-R-USA]
func_800DCED0:                                REGION-PASS (2 insns) [NFS4-R-AU]
```
9/10 REGION-PASS; the 10th improved 6 -> 4 diffs (count already exact 182/182).

## Compliance
- Touched ONLY my rows' candidate files under `regiondiff/recon/**` plus
  `scratchpad/w84/**` (receipt, backups, and three read-only helper scripts:
  `r09_side.py` side-by-side dumper, `r09_variants.py` variant measurer, `v_*.py`).
- No git operations, no `tools/*.py` or `regiondiff/tools/*.py` edits, no base-tree
  edits, no MANIFEST/PROGRESS edits, no memory-dir edits;
  `update_region_progress.py` NOT run (per wave guide).
- No volatile, no `__asm__`, no `register ... asm("$N")` pins and no post-compile
  moves were INTRODUCED. The two `__asm__("" : : "r"(i))` fences and the
  `(volatile Trk_SimObject *)` cast inside chunk.cpp's sim-object counting loop came
  in with the verbatim base-TU seed and were left untouched (removing them is a
  base-tree question, out of scope for a regional row).
