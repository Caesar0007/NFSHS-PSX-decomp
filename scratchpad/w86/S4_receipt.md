# W86-S4 receipt — SYM/SLD-exact C, frontend/common tail

Assignment: screenpinkslips, screentracks, screentrackrecords, screentrophyroom,
screenusername, statchk, stattool (+ any remaining frontend/common TU not held by
S1-S3).

Method: methodology §0 rule 8 + §3.8b. Per function pull the SYM `8c Function
start` block (`tools/symblk.py <mangled>`; SYM = nfs4-f-v3.txt == the byte-identical
`C:\Temp\nfs4-psx\nfs4-psx-sym.txt`), then make the C carry exactly the SYM's
variables (name / type / scope / order), fold away named locals the SYM does not
record, and whole-TU re-gate (`tools/tugate.py`) after every change. Iron rule:
every previously-PASS fn stays PASS; anything that regresses is reverted and the
cost recorded.

Baseline gate (all seven TUs, before any edit):
screenpinkslips 8/8 · screentracks 10/10 · screentrackrecords 7/7 ·
screentrophyroom 9/9 · screenusername 6/6 · statchk 5/5 · stattool 11/11 — all PASS.

---

## screenusername.cpp — 6/6 PASS before and after

SYM blocks pulled for all five C++ members (the 6th is the `extern "C"` dtor
thunk, no SYM block).

### Applied

1. **`DrawVerticalLine` / `DrawHorizontalLine`: `int depth` FOLDED AWAY (hard
   fiction removed, PASS kept).** Both SYM blocks list ONLY the four REGPARMs
   (`this`/`x`/`y`/`gridpos`, `$a0..$a3`) and no locals at all, so the
   `SYM-CODEGEN-CARRIER: depth` local contradicted the SYM (30D-3 hard-fiction
   class). Folding the carrier's expression back into its three uses is
   codegen-neutral **provided the sll/sra spelling is preserved**:
   `(((int)(uint)(ushort)gridpos << 16) >> 16)` = PASS 32/32 and 33/33;
   simplifying it to `(int)gridpos` costs 17 diffs (measured, reverted).
   Net: two hard fictions removed at zero cost.

2. **`DrawBackground`: `int fadeWord` replaced by the SYM's INLINED ACCESSOR.**
   The `8c` block has no `fadeWord`; what it does have is a NESTED block opened
   at the function's first statement (`$8004b1ac`, same address as the function
   block) whose only record is
   `REG this $2 v0 PTR STRUCT size 128 dims 0 tag tOptionsMenu`.
   That is retail inlining a `tOptionsMenu` accessor at `fade = ...`, with the
   int result truncated into the SHORT `fade` (SYM `REG fade $5 a1`) — exactly
   the `lw $v0,116($v0)` + `addu $a1,$v0,$zero` pair the W85-S5 note describes.
   Modelled as an inline `int tOptionsMenu::GetScreenFade() { return fScreenFade; }`
   (the SYM records the inlined `this`, not the method's name).
   Result: hard fiction removed, nested SYM block reproduced, PASS 394/394 kept.

   Shared-header note (coordination): the inline was added to BOTH
   `recon/frontend/common/screendisplay_types.h` (the definition this TU actually
   sees — 5 includers) and `recon/nfs4_types.h` (the canonical record). An
   *uncalled* inline member emits nothing, so it is codegen-neutral; proven, not
   assumed:
   - `tools/bulkcompile.py` over recon/game/common (91/91), recon/frontend/common
     (48/48), recon/frontend/psx (13/13), recon/game/psx (32/32) — 0 failures.
   - every screendisplay_types.h includer re-gated: screendisplay 3/3,
     screenmain 13/13, screenmemcard 15/15, screenusername 6/6 — all PASS.
   - nfs4_types.h before/after A/B on three unrelated includers:
     physics 22/22 and front 43/43 identical either way; femenu 73/73 after.
   No other symbol named `GetScreenFade` exists in the tree.

### Measured and NOT applied (cost recorded)

3. **The three clamp funnels `fadeboxv` / `gridposv` / `textfadev` stay.** They
   are absent from the SYM local list, but removing all three and assigning the
   SYM destinations (`fadebox`, `gridpos`, `this->fTextFade`) directly in every
   arm costs **106 diffs** — re-measured in today's PASS basin, not inherited
   from the W61/W71 pricing (04Z basin-relativity). Reverted; the source comment
   now carries the re-priced number.

4. **`__asm__("" : : "r"(this))` device kept** — W72-A7 priced it at 59 diffs and
   the W85 device-purity wave did not clear it; out of scope for this lane
   (SYM-invisible soft fiction, and no *variable* is minted by it).

5. **`DrawBackground` declaration order corrected to the SYM's** (APPLIED, PASS
   kept). The `8c` record sequence is DECLARATION ORDER, not a class grouping —
   proven on `StatChk_IsRecordLapTime`, whose records interleave
   AUTO/REG/…/AUTO/REG/REG. SYM order here is
   `i, k, x, y, gray, fade, fadebox, gridpos, row, col, output`; the file had
   `output` 7th. Moved to last; the three SYM-absent funnels stay after it, so
   every recorded local is now in the recorded order. (W72-A7 had measured "SYM
   declaration order" as neutral in the 70-diff basin — it is neutral here too,
   and neutral means it should be the SYM's.)

---

## statchk.cpp — 5/5 PASS before and after

SYM blocks pulled for all five EXT free functions. Two of the five already read
exactly as the SYM says (`StatChk_IsRecordLapTime`: 10 locals, names+types+ORDER
identical; `StatChk_IsTopTime`: 13 locals plus the nested-block `carInfo` — the
W68 note had already restored that one from the SYM).

🔑 **Order finding used across this whole lane:** the `8c` record sequence is
NOT class-grouped — `StatChk_IsRecordLapTime` interleaves AUTO/REG/REG/…/AUTO/REG,
so it is DECLARATION ORDER and can be checked against the C directly.

### Applied

1. **`StatChk_SaveRecordLapTime`: SYM declaration order restored.** SYM order is
   `RecordHolder` (AUTO sp+16), `DummyRaceResult` (AUTO sp+40), `TrackRecords`
   (REG $17 s1), `carInfo` (REG $18 s2); the file had
   `newBestLap, carInfo, TrackRecords, RecordHolder, DummyRaceResult`. Reordered,
   with the SYM-absent `newBestLap` carrier quarantined last. PASS kept.

2. **`StatChk_ClearNewRecords`: `int *pRec` FOLDED AWAY.** The SYM records
   exactly one local, `REG i $3 v1 INT`; the walk-pointer was a hard fiction
   carrying a "split `la NewRecords` + `addiu 0x1C`" note. Rewritten as the
   down-counting index loop `for (i = 7; -1 < i; i = i + -1) NewRecords[i] = 0;`
   — one local, the SYM's, and PASS kept.

### Measured and NOT applied

3. `newBestLap` (SaveRecordLapTime) — removing it (`NewBestLap = 1;` direct) is
   **6 diffs**, re-measured in the SYM-ordered basin. Kept, comment updated.
4. `uRecSz` (SaveTopTime) — the W71-A18 seal is built on it; the source comment
   already carries the in-basin price (126 diffs @412/416 for the direct
   `sizeof`). Untouched.
5. Everything else in `StatChk_SaveTopTime` already follows the SYM's 16-local
   order exactly, with `uRecSz` the only insertion.

---

## stattool.cpp — 11/11 PASS before and after

SYM blocks pulled for all 11 functions (incl. the file-local
`UserNameUpperCaseOneLetter`, `8c` @0x8004AAB4: param `c`, no locals — matches).

### Applied

1. **`Stattool_GetAllDefaultRecords`: SYM order restored** — SYM `i`(s2),
   `n`(s4), `s`(v0), `AllRecords`(s5); file had `AllRecords, s, i, n`. PASS kept.
2. **`Stattool_ReturnRecordLapTime`: SYM order restored** — SYM
   `RecordLapHolder`(AUTO sp+16), `TrackRecords`(REG s0); file had them swapped.
   PASS kept.

### Measured and NOT applied (all re-priced in today's PASS basin, 04Z)

3. `Stattool_GetAINameFromPersonality` — the SYM block has NO locals; folding the
   `namePtr` carrier into two direct returns costs **9 diffs** (matches the
   standing note). Kept.
4. `Stattool_ParseTime` — the SYM block has NO locals; folding `min`/`sec` into
   recomputed sprintf arguments costs **90 diffs**. Kept.
5. `Stattool_nCreateIndex` — the `one` carrier + its zero-instruction identity
   `__asm__` is SYM-absent; dropping both (plain `if (nNumber != 1)`) costs
   **2 diffs**, unchanged from the W57-A7 measurement. Kept; a pure-C replacement
   for the cse opacity is device-lane (D1-D3) work, not a declaration question.
6. `Stattool_CheckForHumanCar` — `nNumCars` is SYM-absent but is restored from the
   matched NFS2-PC-beta source (a named EA local, not an invention); `k` and
   `bHumanFlag` match the SYM in name, type and order. Left as-is.
7. `Stattool_SamNelsons…` (`previousLetter` CHAR REG s1),
   `Stattool_ReadDefaultRecords` (`filename` AUTO ARY CHAR[80]),
   `StatTool_UpperCaseIt…`, `Stattool_GetRecords`, `UserNameUpperCaseOneLetter` —
   already SYM-exact, no change.

---

## screentrackrecords.cpp — 7/7 PASS before and after

### Applied
1. **`DrawOneRecord`: SYM order** — SYM `sBuildOutput` (AUTO sp+32 ARY CHAR[80]),
   then `textState` (REG $19 s3 ENUM tMenuTextState); the file had them reversed.
2. **`DrawBackground`: SYM order + carrier quarantine** — the 17 recorded locals
   (string, string2, fade, linefadeval, maxitem, boxx, boxy, boxw, midy, j, Col,
   ColTextSel, ColTextBright, shape, lbx, tt, drawflags) now run in the SYM's own
   sequence; the two SYM-absent clamp carriers (`clampTmp`, `lineFadeCalc`), which
   used to sit between `fade` and `linefadeval`, moved to the end.
   The nested `int xx` (SYM block line 58) was already in its `for` block.

### 🔑 SYM finding recorded, measured, NOT landed
3. `DrawBackground`'s `8c` block carries **three 2-deep nested `90 Block start
   line = 10` groups, all at the same VA ($80042c24)** — the signature of an
   INLINE clamp helper defined near the top of the file and called three times,
   which is exactly the three fade clamps and would delete BOTH carriers.
   Probed as `static inline int TrackRecordClamp(int v,int lo,int hi)`:
   **60 diffs** (tt / linefadeval / maxitem call order) and **146** (tt / maxitem /
   linefadeval). Reverted; the source comment now carries the evidence and both
   measurements. The nested-block evidence stands — the open question is the
   helper's exact body and argument shape, not whether it existed.

---

## screenpinkslips.cpp — 8/8 PASS before and after

### Applied
1. **`DrawBackground`: the fn-static is in the SYM's middle** — SYM order is
   `r`(AUTO sp+32), `i`(s2), `j`(s1), `tv`(s3), `textState`(s0),
   `trackInfo`(AUTO sp+40), **`flareextra` (STAT)**, `shapeY`(AUTO sp+168).
   The file declared `static int flareextra;` first; moved to its recorded slot.
2. **`Initialize`: SYM order + carrier quarantine** — SYM `r`(sp+24),
   `moviename`(sp+32), `trackInfo`(sp+112); the `iVar1`/`tmp` carriers moved after.

Already SYM-exact: `GetShapeInfo` (trackInfo), `Cleanup`/`UpdateVideoWall` (no
locals — the latter's comment already says so), `DrawVideoWall` (i, j),
`ProcessInput` (trackInfo, then the `defs` carrier), and the nested-scope records
`flare_intensity` (block line 13) and `moviename` (block line 104).

### SYM finding recorded, NOT landed
3. `DrawBackground` carries TWO nested blocks (lines 11 and 39) whose only record
   is `REG this $2 v0 PTR STRUCT size 108 tag tMenu` — retail inlined a **tMenu**
   accessor for `fCurrentItem` at both `fMenu->fCurrentItem` sites. Unlike the
   `tOptionsMenu::GetScreenFade` case this removes NO fiction (the
   `currentItem`/`trackIndex` carriers are independent of it) and `tMenu` is a
   far more widely included struct, so it was left alone. Named angle for a
   later pass.

---

## screentracks.cpp — 10/10 PASS before and after

### Applied
1. **`DrawBackground`: SYM order + carrier quarantine** — SYM `r`(AUTO sp+16),
   `trackInfo`(AUTO sp+24), `shapeY`(REG $22 s6), `prim`(REG $30 fp),
   `state`(REG $3 v1); the file led with the SYM-absent `shapeX`/`videoY`, which
   are now after the recorded set.
2. **`ProcessInput`: SYM order** — the block records exactly one local
   (`AUTO trackInfo` sp+16); the `ptVar1` carrier moved after it.

Already SYM-exact: `Initialize` (trackInfo, r, moviename — order matched),
`GetShapeInfo`, `DrawVideoWall`, `UpdateBrightness` (`elapsed` LONG),
`UpdateVideoWall`, `Cleanup`, `SetBrightness` (no locals). The nested `RECT r`
inside the `VIDEOSTATE_SPOOLING` arm matches the SYM's second `AUTO r` (sp+72,
block line 39).

### SYM finding recorded, NOT landed
3. `DrawBackground`'s nested block at line 23 records
   `REG this $16 s0 PTR STRUCT size 56 tag tVideoWall` — an inlined **tVideoWall**
   member at the `fTransitionDirection != -1` test, i.e. the same $s0 pointer the
   `videoWall` carrier holds. Modelling it as an inline accessor could retire that
   carrier; not attempted (shared-header change + guessed accessor shape).

---

## screentrophyroom.cpp — 9/9 PASS before and after

### Applied
1. **`DrawBackground`: SYM order + carrier quarantine** — SYM `drawFlags3`(AUTO
   sp+32), `fModNumber`(REG $19 s3), `TROPHY_LEFTOFFSET`(REG $21 s5),
   `drawFlags`(AUTO sp+56), `i`(s1), `x`(a2), `y`(a3), `texttoshow`(a0); the
   SYM-absent `drawFlagsPtr` used to sit between `drawFlags` and `i` and is now
   after the recorded set.
2. **`Initialize`: SYM order + carrier quarantine** — the block records exactly
   ONE function-scope local, `REG i $17 s1 SHORT`; `curIdx` and `loopFe` moved
   after it.

Already SYM-exact: ctor/dtor, `GetShapeInfo` (no fn-scope locals; the `cur`
carrier is block-scoped), `ProcessInput`/`PreLoad`/`Cleanup` (no locals),
`LoadTrophy` (no locals; `tierIdx`/`tourn` carriers block-scoped), and the
loop-scoped `placement`/`tournIdx`/`place`/`tourney` carriers.

---

## Carrier-quarantine follow-up (after the W86-S5 relay)

The relay's rule — SYM locals in Def-record order, non-SYM carriers AFTER the SYM
set, block records as real nested blocks — was already the working method here.
Re-running S5/S2's `scratchpad/w86/s2_order.py` over the seven TUs afterwards left
four findings; two were real and were fixed, two are tool false positives:

* **FIXED** `StatChk_SaveTopTime` — `uRecSz` was interleaved between
  `nCheckTotalTime` and `k`; moved after `topPlacements` (the last SYM record).
  Gate PASS. (Its ASSIGNMENT position, before the topPlacements loop, is the
  load-bearing part per W71-A18 and was not touched.)
* **FIXED** `Stattool_CheckForHumanCar` — `nNumCars` led the list; moved after
  the SYM pair `k`, `bHumanFlag`. Gate PASS.
* **FALSE POSITIVE** `GetShapeInfo` in screenpinkslips and screentracks —
  reported "SYM block-scope but C fn-scope: trackInfo". The raw SYM shows a single
  `90 Block start line = 1` … `92 Block end line = 1` pair, i.e. the FUNCTION BODY
  block; `trackInfo` is function scope and the C is right. (These two functions
  have no second nested block, which is what confuses the depth heuristic.)
* **FALSE POSITIVE** `DrawBackground` in screentracks — reported on `r`, which is
  recorded TWICE (fn-scope AUTO sp+16 and nested AUTO sp+72 at block line 39);
  the C has exactly those two `r`s in exactly those scopes.

Final order/scope audit over the seven TUs: 0 real findings.

---

## Final state

| TU | fns | baseline | final |
|---|---|---|---|
| screenpinkslips.cpp | 8 | 8/8 PASS | **8/8 PASS** |
| screentracks.cpp | 10 | 10/10 PASS | **10/10 PASS** |
| screentrackrecords.cpp | 7 | 7/7 PASS | **7/7 PASS** |
| screentrophyroom.cpp | 9 | 9/9 PASS | **9/9 PASS** |
| screenusername.cpp | 6 | 6/6 PASS | **6/6 PASS** |
| statchk.cpp | 5 | 5/5 PASS | **5/5 PASS** |
| stattool.cpp | 11 | 11/11 PASS | **11/11 PASS** |
| **total** | **56** | **56/56** | **56/56** |

Hard fictions removed at zero gate cost: **4** (`depth` ×2 in screenusername,
`fadeWord` in screenusername, `pRec` in statchk).
Declaration order/scope corrected: **13 functions** across all 7 TUs.
Carriers that could NOT be removed, each re-priced in today's basin:
`fadeboxv`/`gridposv`/`textfadev` 106 · `newBestLap` 6 · `namePtr` 9 ·
`min`+`sec` 90 · `one`+its identity fence 2 · `uRecSz` 126 (standing) ·
`clampTmp`+`lineFadeCalc` 60 (inline-helper form).
Devices added: **0**. Devices removed: 0 (none were in this lane's scope).

## Shared-header change — COORDINATION NOTE for the orchestrator

Two headers were edited, both with the same one-line addition and both proven
codegen-neutral:

* `recon/frontend/common/screendisplay_types.h` — `struct tOptionsMenu` gains
  `int GetScreenFade() { return fScreenFade; }` (REQUIRED: screenusername.cpp
  calls it).
* `recon/nfs4_types.h` — the same inline on the canonical `tOptionsMenu`, so the
  two definitions do not diverge. It is UNCALLED there and emits nothing.

Evidence it is safe: `tools/bulkcompile.py` clean on all four recon dirs
(91+48+13+32, 0 failures); every `screendisplay_types.h` includer re-gated PASS;
an explicit before/after A/B of the nfs4_types.h edit on physics (22/22) and
front (43/43) is byte-identical; and the whole of `recon/frontend/common`
(48 TUs) gates PASS afterwards. No other `GetScreenFade` exists in the tree.

## Scope note — the "any remaining frontend/common TU" clause

`recon/frontend/common` holds 48 code TUs. W86-S2's receipt claims 8 of them
(femenuextended, femenuoptions, femission, fescreen, fetextrender, fetourn, fetv,
front); this receipt claims 7. The other 33 are presumably S1/S3's, and their
receipts had not landed when this lane finished, so NONE of them were edited —
a concurrent write would have destroyed the other agent's work.

Instead, a READ-ONLY sweep of `scratchpad/w86/s2_order.py` over all 48 TUs is
recorded here so the orchestrator can route what is left. TUs the audit still
flags (raw counts, NOT verified real — this lane's own experience is that roughly
half are the two false-positive classes documented above, a single
`90 Block start line = 1` function-body block and a name recorded in two scopes):

feapp 2 · feaudio 2 · fecars 4 · fecheats 2 · fecredits 2 · fedialog 4 ·
feinput 1 · felines 1 · fememcard 4 · femenu 1 · femenudefs 14 ·
femenuextended 9* · femenuoptions 13* · fetools 2 · fetourn 1* · fevideowall 1 ·
front 15* · screenaudio 1 · screencarselect 5 · screencongrats 1 ·
screencontroller 2 · screendisplay 1 · screenmemcard 4 · screenpost 2 ·
screentournselect 2 · screentrackinfo 1 · screentrophyinfo 1 ·
screentracks 1 (this lane's, confirmed FALSE POSITIVE — the twice-recorded `r`).

(* = TUs W86-S2 reports as already done, which is the reason to treat these raw
counts as a routing hint and not as a defect list.)

## Whole-tree regression sweep (final)

After all edits, `tools/tugate.py` was run over EVERY code TU in the tree:
* `recon/frontend/common` — 48 TUs, **0 non-PASS lines**
* `recon/game/common` + `recon/game/psx` + `recon/frontend/psx` — 137 TUs,
  **0 non-PASS lines**
* the three `recon/eaclib/psx/eacpsxz` TUs that include `nfs4_types.h`
  (memstd 13/13, trnspos 1/1, xform 4/4) — PASS

No git operations, no `tools/*.py` or `regiondiff/tools/*.py` edits, no board /
MANIFEST / memory edits, no new devices, no pins.
