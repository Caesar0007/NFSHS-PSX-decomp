# W84-R10 receipt (regional-variant matching)

Rows: `scratchpad/w84/R10_rows.tsv` (20 rows). All gates below run from
`C:\Temp\nfs4-decomp` with
`python regiondiff/tools/verify_region.py <REGION> <candidate> <fns> --lane-as=recon/<unit>.<ext>`.

## Part 1 — rows already carrying a candidate from an earlier wave: RE-MEASURED GREEN

| row | fns | status |
|---|---|---|
| USA frontend/common/front | Front_AppendOpponentData__FPiR9tFEStream, Front_GetInGameVars__Fv, Front_InitMissions__FR9tFEStream, Front_InitTrack__FR9tFEStream, Front_InitialMemCardCheck__Fv, Front_SecondaryMemCardCheck__Fv | REGION-PASS 205/63/85/117/25/53 insns |
| USA frontend/common/femenuextended | MenuNFS4_DrawTextBox__FiR4RECTissbT5 | REGION-PASS (301) |
| USA regiononly/func_8009B57C | func_8009B57C | REGION-PASS (192) |
| USA frontend/common/screentrackrecords | DrawOneRecord__19tScreenTrackRecordsibi | REGION-PASS (156) |
| USA game/psx/draw | AllocatePrimitivesBuffer__Fv, Draw_SetViewMemBudget__Fii, Draw_StartRenderingView__Fi | REGION-PASS (39/11/60) |
| AU regiononly/func_800EECDC | func_800EECDC | REGION-PASS (16) |
| AU regiononly/func_800A7888 | func_800A7888 | REGION-PASS (8) |

Exact command lines used:
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/front.cpp Front_AppendOpponentData__FPiR9tFEStream,Front_GetInGameVars__Fv,Front_InitMissions__FR9tFEStream,Front_InitTrack__FR9tFEStream,Front_InitialMemCardCheck__Fv,Front_SecondaryMemCardCheck__Fv --lane-as=recon/frontend/common/front.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/femenuextended.cpp MenuNFS4_DrawTextBox__FiR4RECTissbT5 --lane-as=recon/frontend/common/femenuextended.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_8009B57C.cpp func_8009B57C
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/screentrackrecords.cpp DrawOneRecord__19tScreenTrackRecordsibi --lane-as=recon/frontend/common/screentrackrecords.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/psx/draw.cpp AllocatePrimitivesBuffer__Fv,Draw_SetViewMemBudget__Fii,Draw_StartRenderingView__Fi --lane-as=recon/game/psx/draw.cpp
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/regiononly/func_800EECDC.cpp func_800EECDC
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/regiononly/func_800A7888.cpp func_800A7888
```

## Part 2 — the 6 genuinely-TODO rows (work in progress below)

- USA frontend/common/fecars: AdjustPosition__16tListIteratorCar7tPlayers (380 w), GetCarFromID__11tCarManagers (28 w)
- USA frontend/common/screenmemcard: Cleanup__14tScreenMemcard (36 w), DrawForeground__14tScreenMemcard (67 w)
- USA frontend/common/feapp: Redraw__14tFEApplication (360 w), RunDemoVideo__14tFEApplication (184 w)

### GetCarFromID__11tCarManagers (USA, fecars) — REGION-PASS (28 insns) ✅

Seed measured first: FAIL 26 diffs (ours 20 / oracle 28).

Regional delta: retail refreshes the record's `fAvailable` from the manager's
availability table right before returning it:
```c
this->fCars[i].fAvailable = this->fAvailableCars[carID];
return &this->fCars[i];
```
(`this+520` = `fAvailableCars[0]`: 8 + 2*32*4 + 2*32*4; `+7` in tCarInfo = `fAvailable`.)
The byte store inside the loop is also what kills the base build's LICM — retail
reloads `fNumCars` and `fCars` every iteration and strength-reduces `fCars[i]` to a
byte-offset giv in `$a1` while `this` stays in `$a0`.

Falsified angles (both 12 diffs, ours 30 insns):
- `fAvailableCars[(signed char)this->fCars[i].fCarID]` — 12 diffs
- `fAvailableCars[this->fCars[i].fCarID]` (no cast) — 12 diffs
  Both give the loaded field TWO source-level uses, so combine stops folding
  `lbu + sll 24 + sra 24` into the oracle's single `lb`, and the extra temp
  displaces the address reg ($7/$8 instead of oracle $3/$7).
  Indexing with the PARAM `carID` works because cse substitutes the compared
  register on the equal path (oracle's `addu v0,a0,v0` uses the `lb` result).

Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/fecars.cpp GetCarFromID__11tCarManagers --lane-as=recon/frontend/common/fecars.cpp`

### Cleanup__14tScreenMemcard (USA, screenmemcard) — REGION-PASS (36 insns) ✅

Seed measured first: FAIL 11 diffs (ours 25 / oracle 36).

Regional delta: retail drains the music stream before the screen goes away —
```c
this->tScreen::Cleanup();
while (AudioMus_Buffered() < AudioMus_Threshold()) {
  FeAudio_systemtask(0);
}
```
Callee identity recovered by masked content-match of the regional slice against the
base image (scratchpad `resolve.py`, masks j/jal targets + lui/addiu/gp-rel immediates):
`8007AA48` = AudioMus_Buffered (base 80079FDC), `8007A9C4` = AudioMus_Threshold
(base 80079F58), `80015A70` = FeAudio_systemtask (base 80015948).  Note the regional
AudioMus struct fields sit 4 bytes LOWER than base (0x8c/0xa4 vs base 0x90/0xa8) —
a regional data-layout shift, harmless here.
`void FeAudio_systemtask(int);` had to be declared locally in the candidate
(screenmemcard_externs.h is base-tree and carries no such prototype).

Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/screenmemcard.cpp Cleanup__14tScreenMemcard --lane-as=recon/frontend/common/screenmemcard.cpp`

### DrawForeground__14tScreenMemcard (USA, screenmemcard) — FAIL 16 (count EXACT 67/67)

Seed measured first: FAIL 34 diffs (ours 39 / oracle 67).

Regional delta (the whole 28-instruction block is new):
```c
if ((short)fadeRaw >= 100) {
  FETextRender_MenuTextPositionedJustify(638,480,220,1,1,4);
  PSXDrawSquare(0,480,220,-textpixels(TextSys_Word(638)) + -5,7);
}
```
Callee identity by the same masked content-match: `800212E0` =
FETextRender_MenuTextPositionedJustify (base 80021180), `800B9F18` = TextSys_Word
(base 800B9250), `800E4A2C` = textpixels (base 800E3E20), `8004F12C` = PSXDrawSquare
(base 8004EC44), `8004EB60` = DrawShapeExtended (base 8004E678, unchanged).

Residual = ONE register-assignment decision (count exact, 16 diffs, all downstream):
- oracle: `fadeRaw`->$a1, clamp value `fade`->$a0 (caller-saved), copied `move s1,a0`
  into $s1 in the guard's `bnez` delay slot, sign-extended in the loop preheader.
- ours: `fade`->$s1 outright (it is the pseudo live across the new calls, so global
  alloc hands it a callee-saved reg and the copy is coalesced away); `fadeRaw`->$a0;
  `k=0` then fills the delay slot.

Progress + falsified angles:
- naive single `fadeRaw` local: 17 diffs, ours 66 (one insn SHORT — no copy at all)
- guard re-spelling `(short)((int)(ushort)fScreenFadeVal*2)` at the join: 17 diffs /
  68 — cse cannot reach across the clamp join, it RELOADS (`lhu`+`sll 17`)
- 🔑 **spelling the doubled expression TWICE in the ENTRY block** (`fade = expr - 0x80;`
  FIRST, then `fadeRaw = expr;`) makes cse rewrite the second as a COPY of the first
  pseudo -> the oracle's `addu <r>,v0,zero` appears and the count becomes EXACT 67/67
  (16 diffs).  Order matters: `fadeRaw` first gives no copy.
- separate carrier for the loop argument (`short fadeArg = (short)fade;` and
  `int fadeArg = fade;`, before the guard): BOTH coalesce away — 16 diffs either way.
  gcc will not keep a second call-crossing pseudo while `fade` dies at the copy.
  (Removed again; the shipped candidate uses the plain `(short)fade` argument.)
- declaration ORDER swap (`fadeRaw` before `fade`): 16 diffs, no change.

FINAL SHIPPED FORM: two entry-block spellings of the doubled expression
(`fade = (int)(ushort)fScreenFadeVal*2 + -0x80;` then
`fadeRaw = (int)(ushort)fScreenFadeVal*2;`), guard `if ((short)fadeRaw >= 100)`,
loop argument `(short)fade`.  Left in its best-gated state: FAIL 16, count exact.

Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/screenmemcard.cpp DrawForeground__14tScreenMemcard --lane-as=recon/frontend/common/screenmemcard.cpp`

### AdjustPosition__16tListIteratorCar7tPlayers (USA, fecars) — REGION-PASS (380 insns) ✅

Seed measured first: FAIL 192 diffs (ours 382 / oracle 380).

Two regional deltas, both pure statement placement:
1. 🔑 the `oldValue` / `carInfo` / `oldCountry` SNAPSHOT moved from the top of the
   function (before the list-filter chain) to INSIDE the `if (firstCar < lastCar)`
   guard, i.e. AFTER the two clamps — retail snapshots the post-clamp value.
   That alone took 192 -> 5 diffs (381/380).
2. `firstCar = 0;` moved from before the filter chain INTO the `filter & 0x89` arm
   (the other two arms already assign `fNumCars`).  gcc then emits it as a copy of
   the zero already held for `carInfo` (`move s5,s0`) and puts that copy in the
   `j` delay slot; with the function-scope `firstCar = 0;` the slot instead takes a
   duplicated `sll v0,s3,16` — exactly the one extra instruction (381 vs 380).

Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/fecars.cpp AdjustPosition__16tListIteratorCar7tPlayers,GetCarFromID__11tCarManagers --lane-as=recon/frontend/common/fecars.cpp`

## SUMMARY

**19 of 20 rows REGION-PASS; 1 documented near-miss (count-exact).**

| row | status |
|---|---|
| Front_AppendOpponentData / GetInGameVars / InitMissions / InitTrack / InitialMemCardCheck / SecondaryMemCardCheck (USA front) | REGION-PASS (re-measured) |
| Redraw__14tFEApplication (USA feapp) | REGION-PASS 360 ✅ NEW |
| RunDemoVideo__14tFEApplication (USA feapp) | REGION-PASS 184 ✅ NEW |
| AdjustPosition__16tListIteratorCar7tPlayers (USA fecars) | REGION-PASS 380 ✅ NEW |
| GetCarFromID__11tCarManagers (USA fecars) | REGION-PASS 28 ✅ NEW |
| MenuNFS4_DrawTextBox__FiR4RECTissbT5 (USA femenuextended) | REGION-PASS (re-measured) |
| func_8009B57C (USA regiononly) | REGION-PASS (re-measured) |
| DrawOneRecord__19tScreenTrackRecordsibi (USA screentrackrecords) | REGION-PASS (re-measured) |
| AllocatePrimitivesBuffer / Draw_SetViewMemBudget / Draw_StartRenderingView (USA draw) | REGION-PASS (re-measured) |
| Cleanup__14tScreenMemcard (USA screenmemcard) | REGION-PASS 36 ✅ NEW |
| DrawForeground__14tScreenMemcard (USA screenmemcard) | FAIL 16, count exact 67/67 (one allocation decision) |
| func_800EECDC (AU regiononly) | REGION-PASS (re-measured) |
| func_800A7888 (AU regiononly) | REGION-PASS (re-measured) |

Files touched (candidates only, nothing in the base tree, no git operations):
- `regiondiff/recon/NFS4-R-USA/frontend/common/fecars.cpp` (NEW seed + edits)
- `regiondiff/recon/NFS4-R-USA/frontend/common/feapp.cpp` (NEW seed + edits)
- `regiondiff/recon/NFS4-R-USA/frontend/common/screenmemcard.cpp` (NEW seed + edits)
- `scratchpad/w84/R10_receipt.md` (this file)

Helper (scratch only, outside the repo):
`%TEMP%/claude/.../scratchpad/resolve.py` — resolves a REGIONAL callee VA to its
BASE symbol by masked content-match (masks j/jal targets and lui/addiu/gp-rel
immediates, scans base .text, names the hit from configs/symbol_addrs.txt).
This is the safe way to identify regional callees WITHOUT looking a regional
address up in the base layout (the pipeline's stated trap).

### RunDemoVideo__14tFEApplication (USA, feapp) — REGION-PASS (184 insns) ✅

Seed measured first: FAIL (ours 168 / oracle 184 — frame 72 vs 96, 4 vs 7 saved regs).

Four regional deltas, all source-level:
1. VRAM blanking around the movie — a `RECT vramRect` local set to `{0,0,1024,512}`
   with `ClearImage(&vramRect,0,0,0); DrawSync(0);` BOTH before and after `play_movie`.
   (`800EE35C` = ClearImage, base 800EDA00; `800EE1D8` = DrawSync, base 800ED87C —
   the ClearImage delta +0x95C lands DrawSync exactly on its base symbol.)
2. `play_movie((u_char)currentVideo)` — retail plays the CURRENT index (a plain
   `lbu` of the static), base plays `currentVideo + 1`.
3. `currentVideo = 5 - currentVideo;` — a two-clip flip, replacing base's
   `(currentVideo + 1) % 3` magic-divide.
4. 🔑 **the UpdateMusic + AudioMus_Volume pair MOVED to the very end** of the
   function (after TransitionOn and the currentVideo update); base runs them
   right after LoadAllHelpShapes.  This was the last 48 diffs at count-exact
   184/184 — a pure statement-order delta.

`ClearImage`/`DrawSync` had to be declared locally in the candidate (feapp_externs.h
is base-tree and carries neither); spelled as the sibling FE owners do.

Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/feapp.cpp RunDemoVideo__14tFEApplication --lane-as=recon/frontend/common/feapp.cpp`

### Redraw__14tFEApplication (USA, feapp) — REGION-PASS (360 insns) ✅

Seed measured first: FAIL 177 diffs (ours 393 / oracle 360) — ours 33 insns LONGER.

Regional delta: retail DROPS the two debug-overlay lines the base build draws
right after `Draw_StartRenderingView`:
```c
sprintf(buffer,D_80010044,largestunused());
FETextRender_FullText(buffer,0x100,0xd7,textType_FramedInfo,textState_Selected,0);
sprintf(buffer,D_80010048,AudioMus_Buffered(),AudioMus_Threshold());
FETextRender_FullText(buffer,0x10,0xd7,textType_FramedInfo,textState_Hilighted,0);
```
plus the now-dead `char buffer[32]` (frame 112 -> 72).  That is the entire
33-instruction shortfall; everything else in the 360-instruction body is the
sealed base source unchanged, including the W60-A10 scratchpad-cell block.

Gate: `python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/feapp.cpp Redraw__14tFEApplication --lane-as=recon/frontend/common/feapp.cpp`


