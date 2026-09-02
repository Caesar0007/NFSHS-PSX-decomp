# W84 R13 receipt — regional-variant matching

Gate (all rows): `python regiondiff/tools/verify_region.py <REGION> <candidate> <fn[,fns]> [--lane-as=recon/<unit>.<ext>]`

## Status board

| # | function | region | status |
|---|---|---|---|
| 1 | AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef | USA | **REGION-PASS (96 insns)** |
| 2 | AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj | USA | **REGION-PASS (85 insns)** |
| 3 | AudioClc_SoundCars__Fv | USA | **REGION-PASS (180 insns)** |
| 4 | AudioClc_SoundCloseCar__Fii | USA | reconstructed, **0 diffs vs its TRUE oracle**; gate blocked by a corpus name shift |
| 5 | AudioClc_SoundPlayersCar__Fi | USA | reconstructed, **0 diffs vs its TRUE oracle**; gate blocked by a corpus name shift |
| 6 | Stats_ExtrapolateOpponentTimes__Fi | USA | **REGION-PASS (490 insns)** |
| 7 | Redraw__14tFEApplication | AU | **REGION-PASS (363 insns)** |
| 8 | videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii | USA | MATCHES 43/43 — gate blocked by oracle-slice over-run |
| 9 | SetCurrentController__23tScreenControllerConfigb | JPN | **REGION-PASS (183 insns)** |
| 10 | ShakeIt__23tScreenControllerConfig | JPN | **REGION-PASS (2 insns)** |
| 11 | FntPrint | USA | MATCHES 240/240 — gate blocked by oracle-slice over-run |
| 12 | func_80012FC4 | FR-DE | **REGION-PASS (107 insns)** |
| 13 | func_800BB0A8 | JPN | **REGION-PASS (57 insns)** |
| 14 | func_8004DCB4 | AU | **REGION-PASS (37 insns)** |
| 15 | func_800A7824 | USA | **REGION-PASS (8 insns)** |
| 16 | func_800DCC90 | JPN | **REGION-PASS (2 insns)** |

## Per-row detail

### 1/2/3 — audioclc.cpp (USA) — REGION-PASS
Candidate: `regiondiff/recon/NFS4-R-USA/game/common/audioclc.cpp` (copy of
`recon/game/common/audioclc.cpp` + three regional deltas).
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/audioclc.cpp AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef,AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj,AudioClc_SoundCars__Fv --lane-as=recon/game/common/audioclc.cpp
  AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef: REGION-PASS (96 insns)
  AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj: REGION-PASS (85 insns)
  AudioClc_SoundCars__Fv: REGION-PASS (180 insns)
```
(final state of the candidate — i.e. these three still pass with the rows 4/5
edits and the new `func_8007593C` in the same TU.)
**Regional delta (1,2)** — both azimuth calculators gain a mono guard: the whole
body is wrapped in `if (gStereoMode != 0) { ... } return 0;` (+6 / +7 insns).
The guard global was identified WITHOUT the base symbol table: the regional
`MPause_MusicLogic` slice writes `*(s32*)0x8013D968` = 1/0/1 for the three
`MPause_GameSetupWords[59]` cases, which is exactly base `gStereoMode`
(audiocmn.obj @0x8013c674); the regional `Audio_InitDriver` slice reads it too.

**Falsified angle (1,2):** the early-out spelling `if (gStereoMode == 0) return 0;`
is count-exact (96/96, 85/85) but inverts BOTH the guard polarity and the block
order — 6 diffs each (`bnez` vs oracle `beqz`, and the `j`/`move v0,zero` pair
emitted before the body instead of after). Wrapping the body in
`if (gStereoMode != 0) { ...; return X; } return 0;` (methodology §3.12 #7
branch-polarity lever) drops both to 0.

**Regional delta (3)** — `AudioClc_SoundCars` gains one small-data store on each
screen path, immediately after `AudioClc_GetClosestCars` and before
`AudioClc_SoundPlayersCar(0)`:
* split screen (`commMode == 1`, player-0 half only): `NEW = 0;`
* single screen: `NEW = func_8007593C();` (a new region-only 61-insn helper).

The store target is a NEW 4-byte small-data global that audioclc.obj gains
immediately BEFORE `AudioClc_gCameraVelocity`. Proof without the region link
map: base `AudioClc_SoundPlayersCar` reads gCameraVelocity at
`%gp_rel(...)` = **+0xBC**, the regional slice (oracle `func_80075F28.s`) reads
the same value at **+0xC0**, and the new store lands at **+0xBC** — i.e. one
4-byte slot was inserted ahead of it. Regional `&gCameraVelocity` is
address-taken absolutely in SoundCars as `0x8013D8FC`, so region `$gp` =
0x8013D83C and the new global's region VA = **0x8013D8F8** → mechanical name
`RDAT_8013D8F8` + `[INFERRED]` comment (§8.3 no-auto-naming). Declared as a
tentative definition placed before `AudioClc_gCameraVelocity` so it lands in
small-common and the store is gp-relative (§3.12 #6) — an absolute `lui`+`sw`
would be +1 insn and break the count.

### 4/5 — 🔴 CORPUS DEFECT: the NFS4-R-USA audioclc name map is SHIFTED BY ONE

**The finding.** In `MANIFEST.tsv` / `oracles/NFS4-R-USA/INDEX.tsv`, three
consecutive audioclc entries carry the wrong names. Correct mapping:

| region VA | insns | INDEX says | what it ACTUALLY is |
|---|---|---|---|
| 8007593C | 61 | `AudioClc_SoundCloseCar__Fii` (base 80075028) | a **NEW region-only** helper (no base counterpart) |
| 80075A30 | 318 | `AudioClc_SoundPlayersCar__Fi` (base 80075508) | `AudioClc_SoundCloseCar__Fii` (base 80075028, 312 insns) |
| 80075F28 | 465 | `func_80075F28` (REGION-ONLY) | `AudioClc_SoundPlayersCar__Fi` (base 80075508, 461 insns) |

**Five independent proofs** (none of them an address lookup):
1. *Prologue identity.* `oracles/.../AudioClc_SoundPlayersCar__Fi.s` opens
   `addiu $sp,-0x48 / sw $s7,0x3C / addu $s7,$a1,$zero / sll $v1,$s7,3 /
   subu $v1,$v1,$s7 / sll $v1,$v1,3 / lui;addiu / sw $s3,0x2C / addu $s3,$v1,$v0`
   — instruction-for-instruction the base `AudioClc_SoundCloseCar__Fii` prologue
   (`AudioClc_gClosest + closestIndex*56`). `func_80075F28.s` opens
   `addiu $sp,-80 / sw $a0,80($sp) / lui $a0 / lui $v0 / lw $t0,80($sp)` — the
   base `AudioClc_SoundPlayersCar__Fi` prologue.
2. *Arity.* The 61-insn function reads no argument register; SoundCloseCar takes 2
   (`__Fii`) and SoundPlayersCar takes 1 (`__Fi`). `80075A30` reads `$a1`,
   `80075F28` reads `$a0`.
3. *Call sites.* The regional `AudioClc_SoundCars` calls `func_80075F28(0)` /
   `func_80075F28(1)` exactly where the base calls `AudioClc_SoundPlayersCar(0/1)`,
   and `func_80075A30(0,0)`/`(0,1)`/`(1,2)`/`(1,3)` exactly where the base calls
   `AudioClc_SoundCloseCar`. The 61-insn function is called ONCE, in a position
   the base has no call at all.
4. *Sizes.* base 312 -> 318 (+6, the mono guard) and base 461 -> 465 (+4, the same
   guard), whereas the INDEX pairing would demand 312 -> 61 and 461 -> 318.
5. *Address arithmetic.* 8007593C + 61*4 = 80075A30 + 318*4 = 80075F28: the three
   are contiguous, i.e. one extra function was INSERTED and the two following ones
   kept their (grown) bodies — exactly a one-slot shift of an order-based matcher.

**Consequence for the gate.** `verify_region.py` resolves the oracle by FILE NAME,
so it cannot be pointed at the right oracle for these two rows without either
fixing MANIFEST/INDEX/oracle filenames (orchestrator's call — I may not edit them)
or naming a function dishonestly in the deliverable candidate. I did neither.

**What I did instead.** The candidate
`regiondiff/recon/NFS4-R-USA/game/common/audioclc.cpp` carries the three functions
under their TRUE names, and each was measured against its TRUE oracle with the
gate's own normalizer + HI16/LO16/GPREL16/26 reloc masking
(`scratchpad/w84/r13/pairdiff.py`, a read-only re-implementation of
`verify_region.py`'s comparison — no tool was edited):

```
python scratchpad/w84/r13/dumpfn.py  build/recon/game/common/audioclc__region_gate.cpp.o <FN> > ours.txt
python scratchpad/w84/r13/pairdiff.py ours.txt <oracle-stream> build/recon/game/common/audioclc__region_gate.cpp.o <FN>

  func_8007593C                vs oracles/NFS4-R-USA/AudioClc_SoundCloseCar__Fii.s  -> TOTAL 0 diffs (61/61)
  AudioClc_SoundCloseCar__Fii  vs oracles/NFS4-R-USA/AudioClc_SoundPlayersCar__Fi.s -> TOTAL 0 diffs (318/318)
  AudioClc_SoundPlayersCar__Fi vs oracles/NFS4-R-USA/func_80075F28.s                -> TOTAL 0 diffs (465/465)
```
(The intermediate `.o` is the one `verify_region.py` itself produced from the
candidate with `--lane-as=recon/game/common/audioclc.cpp`, so the compile is the
real pipeline including audioclc's `PER_FN_NO_THREAD_JUMPS` splice.)

⇒ **Once the three oracle filenames are corrected, all three should REGION-PASS
unchanged.** Suggested rename: `AudioClc_SoundCloseCar__Fii.s` -> `func_8007593C.s`,
`AudioClc_SoundPlayersCar__Fi.s` -> `AudioClc_SoundCloseCar__Fii.s`,
`func_80075F28.s` -> `AudioClc_SoundPlayersCar__Fi.s` (plus the MANIFEST/INDEX rows).

**Regional deltas reconstructed:**
* `AudioClc_SoundCloseCar` (+6): the azimuth select gains a leading
  `if (gStereoMode == 0) { azimuth = 0; }` arm before the `commMode == 1` test.
  Note the polarity is the OPPOSITE spelling from CalcAzimuth's — here retail lays
  the zero block out as the `bnez` fall-through, which is what the leading
  `== 0` arm produces.
* `AudioClc_SoundPlayersCar` (+4): the same leading arm; gcc cross-jump-merges its
  `azimuth = 0` with the existing `Camera_gInfo[playerIndex].mode == 0` arm, which
  is why retail only pays 4 instructions (`lui/lw/nop/beqz` into the shared block).
* `func_8007593C` (new, 61 insns): returns 128 when `commMode == 1`; otherwise
  accumulates `AudioClc_CalcDistance(&AudioClc_gRenderView, &car->N.position)` over
  the four `AudioClc_gClosest` entries (`total = 0xC00000`, each hit contributing
  `dst - 0x800000` when `dst <= 0x7FFFFF`) and returns `total / 0x10000` clamped
  into 0..128. Globals identified STRUCTURALLY, not by regional address: the walked
  table has stride 56 == `sizeof(AudioClc_tSource)` and its base sits 0xE0 below
  the view pointer handed to CalcDistance — the same gClosest[4]/gRenderView pair
  the base SoundCloseCar uses.

**Levers used on func_8007593C (67 insns / 43 diffs -> 61/61 / 0 diffs):**
1. *Pointer-walk -> INDEX form* (§3.12 #1). Written as `source = gClosest; ...
   source->car; ... source++`, loop.c hoisted THREE loop invariants into fresh
   callee-saved registers (`lui s5,%hi(gRenderView)`, `s3 = 0x7FFFFF`,
   `s4 = 0xFF800000`), growing the frame 0x20 -> 0x30 and adding 6 instructions;
   retail rematerializes all three inside the loop. Writing the access as
   `AudioClc_gClosest[i].car` made the table pointer a strength-reduction giv
   (its base init lands in the preheader AFTER `i = 0`, matching retail's
   `move $s2,$zero` / `addiu $s1,$v0,-2548` order) and stopped the hoist of the
   other three. 43 -> 4 diffs, count exact.
2. *Named split temp for the accumulation* (§5.0c). `total = (total - 0x800000) + dst;`
   reassociates to `dst + const` first (`addu v0,a0,v0; addu s0,s0,v0`), and the
   two-statement `total -= 0x800000; total += dst;` mutates in place twice
   (`addu s0,s0,v0; addu s0,s0,a0`). Retail keeps an intermediate:
   `addu v0,s0,v0; addu s0,v0,a0`. `int sum = total - 0x800000; total = sum + dst;`
   reproduces it. 4 -> 0.
3. *MIN/MAX macro double-expansion.* The tail computes `total / 0x10000`, clamps it
   to 128, tests `< 0`, and then RECOMPUTES the whole clamp. That is a
   `MAX(MIN(x,128),0)` macro pair expanded as
   `((MIN) < 0 ? 0 : (MIN))` — the MAX arm re-expands MIN, and its `128` block is
   cross-jump-merged with the `commMode == 1` early `return 128`. Spelling the
   ternaries out twice (not via a local) reproduces it exactly; the `slti v,129`
   fixes the comparison as `> 128`, and `bltz` (not `blez`) fixes MAX as
   `(a) < (b) ? (b) : (a)`.

### 6 — stats.cpp (USA) — REGION-PASS
Candidate: `regiondiff/recon/NFS4-R-USA/game/common/stats.cpp`.
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/stats.cpp Stats_ExtrapolateOpponentTimes__Fi --lane-as=recon/game/common/stats.cpp
  Stats_ExtrapolateOpponentTimes__Fi: REGION-PASS (490 insns)
```
**Regional delta** — retail drops the developer quick-finish key: the base
`quick_finish = Input_Interface(3,0) != 0;` becomes `quick_finish = 0;`
(-3 insns: the `jal Input_Interface` + arg setup + `sltu s3,zero,v0` go away).
Note gcc-2.8 does NOT fold the constant away — it keeps the 0 in a callee-saved
register (`move $s5,$zero`, then `beqz $s5` at every use, and the loop counter
is even seeded from it with `move $s2,$s5`), which is exactly what the oracle
does, so the one-line change is count-exact and diff-free. One edit, 85 -> 0.

### 7 — feapp.cpp (AU) — REGION-PASS
Candidate: `regiondiff/recon/NFS4-R-AU/frontend/common/feapp.cpp`.
```
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/frontend/common/feapp.cpp Redraw__14tFEApplication --lane-as=recon/frontend/common/feapp.cpp
  Redraw__14tFEApplication: REGION-PASS (363 insns)
```
**Regional delta** — two parts:
1. The two debug overlays are gone (`sprintf(buffer, D_80010044, largestunused())`
   + `FETextRender_FullText`, and `sprintf(buffer, D_80010048, AudioMus_Buffered(),
   AudioMus_Threshold())` + `FETextRender_FullText`), and with them the
   `char buffer[32]` frame slot (frame 0x70 -> 0x48). 180 -> 3 diffs.
2. Retail adds one extra frontend overlay primitive `func_8004DCB4(0, 8);`
   immediately after the `for (i = 1; i >= 0; i--)` player loop and before
   `this->fPlayer = saveFPlayer;` — the region-only helper that is my row 14
   (already REGION-PASS on its own). 3 -> 0.
The `Draw_StartRenderingView` / `Draw_GetDRAWENV` pair around the removed block
is unchanged; confirmed against `regiondiff/m2c/NFS4-R-AU/Redraw__14tFEApplication.c`.

### 8 — video.cpp (USA) `videodecode` — NO regional code delta; gate blocked by the oracle slice
Candidate: `regiondiff/recon/NFS4-R-USA/frontend/psx/video.cpp` (verbatim copy of
`recon/frontend/psx/video.cpp`, unedited — measure-first found nothing to change).
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/psx/video.cpp videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii --lane-as=recon/frontend/psx/video.cpp
  videodecode__FP11VIDEOSTRUCTP14STREAMCHUNKHDRii: FAIL 215 diffs (ours 43 / oracle 258)
```
**All 215 diffs are pure insertions past the end of the function.** Our 43
instructions align 1:1 with oracle instructions 0..42 with ZERO mismatches; the
oracle slice then continues with 207 padding `nop`s plus mis-disassembled data
(`dword 000000ff`, `lb at,308(zero)`, ...). The regional function really ends at
`0x80051740` (`jr $ra` / `addiu $sp,$sp,32`), i.e. 43 insns = 0xAC bytes, which is
EXACTLY the base size (`nonmatching videodecode..., 0xAC`).
⇒ `videodecode` has no regional code change at all (the CHANGED classification is
relocation-only, which the region gate masks by design). The row cannot reach
REGION-PASS until `oracles/NFS4-R-USA/videodecode__*.s` is re-cut to the true
function length (MANIFEST `words` says 258; truth is 43).

### 11 — FONT.c (USA) `FntPrint` — NO regional code delta; gate blocked by 3 slice padding nops
Candidate: `regiondiff/recon/NFS4-R-USA/syslib/psx/libgpu/FONT.c` (verbatim copy of
the USER-LIVE `recon/syslib/psx/libgpu/FONT.c`; the live file was NOT touched, and
`--lane-as` only makes/removes its own temp copy).
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/syslib/psx/libgpu/FONT.c FntPrint --lane-as=recon/syslib/psx/libgpu/FONT.c
  FntPrint: FAIL 3 diffs (ours 240 / oracle 243)
      + nop
      + nop
      + nop
```
Same class as row 8, smaller: the three diffs are the last three oracle entries,
i.e. the alignment `nop`s that sit AFTER the function's `jr $ra` / `addiu $sp,$sp,568`
and before the switch jump table. The base oracle proves they are not part of the
function — `asm/nonmatchings/.../FntPrint.s` is `0x3C0` (= 240 insns) and prints
`endlabel FntPrint` BEFORE the same three nops. The regional slice has no
`endlabel`, so it swallowed them.
⇒ `FntPrint`'s regional change is confined to relocated address fields (masked by
the region gate) — the instruction stream is identical to the matched base's.
This is a positive datum for the README's FntPrint/FntFlush vendor-identity note:
FntPrint's "CHANGED" is layout, not code.

### 9/10 — screencontroller.cpp (JPN) — REGION-PASS, pre-existing candidate
Candidate `regiondiff/recon/NFS4-R-JPN/frontend/common/screencontroller.cpp` already
existed in the tree (seeded by an earlier wave) and gates clean as-is; verified, not edited.
```
python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/frontend/common/screencontroller.cpp SetCurrentController__23tScreenControllerConfigb,ShakeIt__23tScreenControllerConfig --lane-as=recon/frontend/common/screencontroller.cpp
  SetCurrentController__23tScreenControllerConfigb: REGION-PASS (183 insns)
  ShakeIt__23tScreenControllerConfig: REGION-PASS (2 insns)
```

### 12-16 — the five REGION-ONLY rows — all REGION-PASS, pre-existing candidates
All five candidate TUs already existed under `regiondiff/recon/<REGION>/regiononly/`
and gate clean unedited. Verified individually:
```
python regiondiff/tools/verify_region.py FR-DE regiondiff/recon/NFS4-R-FR-DE/regiononly/func_80012FC4.cpp func_80012FC4   -> REGION-PASS (107 insns)
python regiondiff/tools/verify_region.py JPN   regiondiff/recon/NFS4-R-JPN/regiononly/func_800BB0A8.cpp  func_800BB0A8    -> REGION-PASS (57 insns)
python regiondiff/tools/verify_region.py AU    regiondiff/recon/NFS4-R-AU/regiononly/func_8004DCB4.cpp   func_8004DCB4    -> REGION-PASS (37 insns)
python regiondiff/tools/verify_region.py USA   regiondiff/recon/NFS4-R-USA/regiononly/func_800A7824.cpp  func_800A7824    -> REGION-PASS (8 insns)
python regiondiff/tools/verify_region.py JPN   regiondiff/recon/NFS4-R-JPN/regiononly/func_800DCC90.cpp  func_800DCC90    -> REGION-PASS (2 insns)
```

---

## Files touched (all under my rows' candidate paths + scratchpad)

Candidates seeded/edited:
* `regiondiff/recon/NFS4-R-USA/game/common/audioclc.cpp` (new; base copy + deltas)
* `regiondiff/recon/NFS4-R-USA/game/common/stats.cpp` (new; base copy + 1 line)
* `regiondiff/recon/NFS4-R-AU/frontend/common/feapp.cpp` (new; base copy + deltas)
* `regiondiff/recon/NFS4-R-USA/frontend/psx/video.cpp` (new; verbatim base copy)
* `regiondiff/recon/NFS4-R-USA/syslib/psx/libgpu/FONT.c` (new; verbatim copy of the
  USER-LIVE base TU — the live file itself was never opened for writing)

Scratch analysis helpers (read-only tooling, `scratchpad/w84/r13/`):
`dumpfn.py`, `align.py`, `pairdiff.py`, `mkmeasure.py`, plus the dumped streams.
`pairdiff.py` re-implements `verify_region.py`'s normalizer + reloc masking so the
mis-named rows could still be measured. (`mkmeasure.py` / `audioclc_measure.cpp`
were a first attempt that renamed the functions to the oracle FILE names so the
real gate could run; it is kept only as a record of why that route is unusable —
`build.py`'s `PER_FN_NO_THREAD_JUMPS` splice is keyed on the FUNCTION NAME, so
renaming SoundCloseCar to `AudioClc_SoundPlayersCar__Fi` hands it the wrong
`-fno-thread-jumps` lane and injects a spurious 1-diff load-delay `nop`, while the
real SoundPlayersCar loses the splice and shows a spurious 2-insn schedule swap.
`pairdiff.py` on the honestly-named build has neither.) **No file under `tools/`,
`regiondiff/tools/`, `recon/`, `src/`, `asm/`, `configs/`, `MANIFEST.tsv`,
`REGION_PROGRESS.txt` or the memory dir was modified**, and no git command was run.
`update_region_progress.py` was NOT run (per the wave guide).

## Summary

* **11 rows REGION-PASS** (3 audioclc, stats, feapp, 2 screencontroller, 5 region-only
  — of which 6 were already-passing pre-existing candidates I verified unchanged).
* **3 rows reconstructed to 0 diffs against their true oracle** but ungateable until
  the audioclc name shift is fixed in the corpus (rows 4 and 5 — plus, as a bonus,
  the `func_80075F28` REGION-ONLY row that belongs to another agent, which is really
  `AudioClc_SoundPlayersCar__Fi` and is also at 0 diffs in my candidate).
* **2 rows have no regional code delta at all** (`videodecode`, `FntPrint`); their
  gate failures are entirely oracle-slice over-run (215 and 3 trailing padding words).

## Corpus issues found (for the orchestrator)

1. **audioclc USA name shift by one** — 3 oracle files / MANIFEST rows / INDEX rows
   mis-named (detail in the 4/5 section). Fixing the names should turn 3 rows green.
2. **`oracles/NFS4-R-USA/videodecode__*.s` over-runs the function by 215 words**
   (MANIFEST `words` = 258; the true function is 43 words = 0xAC, identical to base).
3. **`oracles/NFS4-R-USA/FntPrint.s` over-runs by 3 alignment nops** (no `endlabel`;
   the base `asm/nonmatchings` .s puts `endlabel FntPrint` before the same 3 nops).
   MANIFEST `words` for FntPrint says 138 while the slice holds 243 + 3 — the `words`
   column is unreliable for at least these rows.
