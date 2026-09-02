# W86-B9 receipt — regional row sealing (11/11 rows REGION-PASS)

Gate: `python regiondiff/tools/verify_region.py <REGION> <cand> <fns> --lane-as=recon/<unit>.<ext>`

Rules honoured: no candidate overwritten (every existing candidate edited **in place**; the one
new candidate is a path that did not exist); every previously-SEALED fn of each touched candidate
re-gated **in the same command** as the row fns; no git, no `tools/*.py` / `regiondiff/tools/*.py`
edits, no board/MANIFEST/memory edits, no base-tree (`recon/**`, `src/**`, `configs/**`) edits,
no pins, no new `volatile`/asm (the one asm TU touched, `savegp.c`, is a §3.25 class-3 HAND-ASM
module — SYM SLD says the original source is `C:\LIB\PSX\SAVEGP.ASM` — transcribed verbatim in the
base tree; only a literal displacement changed).

## Row table

| # | region | unit | function | before | after |
|---|---|---|---|---|---|
| 1 | AU | game/common/render | Render_CreatePauseMenuViews__Fv | FAIL 2 | **REGION-PASS (19)** |
| 2 | AU | game/common/nfs3 | NFS4_LoadingIcon__Fv | FAIL 4 | **REGION-PASS (73)** |
| 3 | USA | frontend/common/fetourn | AdvanceToNextTrack__18tTournamentManager | FAIL 6 | **REGION-PASS (273)** |
| 4 | USA | frontend/common/fetourn | TextValue__23tListIteratorTournament7tPlayer | FAIL 2 | **REGION-PASS (22)** |
| 5 | USA | frontend/common/fetourn | UpdateTrackList__18tTournamentManagerss | FAIL 2 | **REGION-PASS (52)** |
| 6 | USA | frontend/common/fetourn | ValidCar__18tTournamentManagerR8tCarInfo | FAIL 2 | **REGION-PASS (94)** |
| 7 | USA | frontend/common/fecars | ValidCar__16tListIteratorCar7tPlayerc | FAIL 2 | **REGION-PASS (243)** |
| 8 | USA | frontend/common/screenmemcard | DrawBackground__14tScreenMemcard | FAIL 4 | **REGION-PASS (410)** |
| 9 | USA | frontend/common/screenmemcard | DrawMemCardStuff__14tScreenMemcards | FAIL 18 | **REGION-PASS (343)** |
| 10 | USA | frontend/common/screenmemcard | Initialize__14tScreenMemcard | FAIL 4 | **REGION-PASS (106)** |
| 11 | JPN | eaclib/psx/eacpsxz/savegp | savegp | TODO | **REGION-PASS (5)** |

Board not regenerated (`update_region_progress.py`) — the W86 GUIDE prohibits board edits.
Regression control was done instead by re-gating each candidate's full SEALED set (below).

## Three delta CLASSES found (all three are real retail deltas, none is a codegen residual)

### Class A — PAL vertical-extent constants (AU rows)
Not the text-id family at all: the AU/PAL build raises the visible screen height 0xF0 -> 0x100
and shifts a dependent Y by the same +0x10.

* **`Render_CreatePauseMenuViews__Fv`** — AUDIT_LO16 insn 3 `240200f0` -> `24020100`.
  `Draw_SetView(0,0x100,0x140,0x100,0x140,0xf0,0,0,1)` -> 6th arg `0x100`.
  32B-5 check: `0x100` already appears as args 2 and 4, so this was the CSE-shared-constant risk
  case — the oracle nevertheless keeps a **separate** `li $v0,0x100` at insn 3 and the edited
  build reproduces it at an unchanged 19 insns, so no `li` collapsed.
* **`NFS4_LoadingIcon__Fv`** — insn 43 `240700f0`->`24070100`, insn 55 `240600d2`->`240600e2`.
  `Draw_DirectSetEnvironment(0,0,0x200,0xf0,...)` -> `0x100`;
  `movfxya(shp,0x1e2 - shp->width,0xd2)` -> `0xe2`.

### Class B — retail CHEAT-ENUM renumbering (fetourn + fecars)
Two distinct `li $a0` constants that are *not* +1 shifts and are **not** text ids:

* `cheat_FinishedTournament` **25 -> 13** (`24840019`/`24040019` -> `2484000d`/`2404000d`),
  three sites in fetourn (`AdvanceToNextTrack` x2 via `this->fTier + cheat_FinishedTournament`,
  `ValidCar` x1).
* `cheat_AllCops` **12 -> 11** (`2404000c` -> `2404000b`), one site in `fecars::ValidCar`.

Applied as a candidate-local override right after the TU's `#include` (base headers untouched —
`cheat_FinishedTournament` is a macro in `fetourn_types.h`, `cheat_AllCops` an enum in
`fecheats_types.h` *and* a macro in `fecars_externs.h`; a post-include `#undef`/`#define` covers
both spellings and cannot disturb the already-parsed enum):

```c
#undef cheat_FinishedTournament
#define cheat_FinishedTournament 13     /* fetourn.cpp, [REGIONAL USA] */

#undef cheat_AllCops
#define cheat_AllCops 11                /* fecars.cpp,  [REGIONAL USA] */
```

**Cross-row note for other B agents:** AUDIT_LO16 shows the *same* `24040019 -> 2404000d` word in
`Front_InitOpponentCars__FR9tFEStream` (AU, insn 170) — that row is the same
`cheat_FinishedTournament` 25->13 delta, not a text-id shift. Do not "+1" it.

### Class C — the +1 retail string-table shift (fetourn + screenmemcard)
Every one of these is a TextSys word id materialised as `li`/`addiu`, all +1:

| site | base | region |
|---|---|---|
| fetourn `UpdateTrackList` track-name base | `0xD5` | `0xD6` |
| fetourn `TextValue` tournament-name base | `0x341` | `0x342` |
| fetourn `AdvanceToNextTrack` fCompletedText base | `0x3D9` | `0x3DA` |
| screenmemcard `DrawMemCardStuff` (9 sites) | `0x27B 0x27D 0x27F 0x284 0x288 0x2BF` | +1 each |
| screenmemcard `DrawBackground` | `0x27C`, `player + 0x293` | `0x27D`, `+0x294` |
| screenmemcard `Initialize` | `0x287`, `0x289` | `0x288`, `0x28A` |

**32B-5 trap, handled explicitly.** `DrawMemCardStuff` is exactly the shape the trap warns about:
AUDIT_LO16 prints only **4** of its **9** changed words (the report caps at 4 entries/fn) and the
gate prints only **6** of the 9 pairs (12 of 18 diff lines) — so neither source enumerates the work.
Recovery used the R02 recipe in reverse: recover the *class* (TextSys word id assigned to
`fMemCardMessageTextSys`) and **re-scan every site of that class in the function**, which gives
exactly 9 constant sites — `0x27F`/`0x27B` in the ticks ternary, `0x288`, `0x27D`, `0x284`,
`0x27F`/`0x27B` again as the two `!=` compares, `0x284` again, and the trailing `0x2BF` —
matching the audit's 9-word count. Three of the six literals (`0x27B`, `0x27F`, `0x284`) appear at
**two** sites each; the gate output proves they are materialised independently (distinct
`li $a0`/`li $v0` pairs), so no `li` is CSE-shared and all 9 could be patched per-site. Edits were
applied by exact line number (not `replace_all`) so no site was patched twice and no cross-function
literal was caught; instruction counts are unchanged (410/343/106) which is the negative control
for an accidental `li` collapse.

### Row 11 — JPN `savegp` (new candidate)
`regiondiff/recon/NFS4-R-JPN/eaclib/psx/eacpsxz/savegp.c` seeded as a verbatim copy of the base TU
(the path did not exist; JPN had no `eaclib` tree). Single delta, AUDIT_LO16 insn 2
`8f9c34e8` -> `8f9c45c4`: the boot-`$gp` word moved 0x801234E8 -> 0x801245C4 in the JPN layout.
The oracle never re-symbolised this reload (it is a linked literal `lui $gp,0x8012; lw $gp,off($gp)`),
so the displacement is transcribed directly — decimal, as maspsx requires:
`lw $28, 13544($28)` -> `lw $28, 17860($28)`. The `lui 0x8012` is unchanged: both addresses share
the same high half, which is why only one word differs. `initgp`'s `%hi/%lo(D_801234E8)` operand is
left alone (a real relocation, masked on both sides by the gate).

## Re-gate evidence (regression control)

```
AU  render.cpp     : Render_CreatePauseMenuViews PASS 19 | Render_CreatePlayerViews PASS 59 | Render_InitTrackRender PASS 46
AU  nfs3.cpp       : NFS4_LoadingIcon PASS 73 | main PASS 237
USA fetourn.cpp    : AdvanceToNextTrack PASS 273 | TextValue PASS 22 | UpdateTrackList PASS 52 |
                     ValidCar__18tTournamentManagerR8tCarInfo PASS 94 | UpdateTrackFinishPoints PASS 129
USA fecars.cpp     : ValidCar__16tListIteratorCar7tPlayerc PASS 243 | AdjustPosition PASS 380 | GetCarFromID PASS 28
USA screenmemcard  : DrawBackground PASS 410 | DrawMemCardStuff PASS 343 | Initialize PASS 106 |
                     Cleanup PASS 36 | DrawForeground FAIL 2 (unchanged, NOT a B9 row)
JPN savegp.c       : savegp PASS 5
```

`DrawForeground__14tScreenMemcard` (USA) shares the screenmemcard candidate but is **not** a B9 row.
It was FAIL 2 before my edits and is FAIL 2 after — byte-for-byte the same residual (a single
`addu a1,v0,zero` ordering delta, i.e. a schedule/emission-order tie-break, not a constant). No
regression, and no attempt made on it since it is out of scope.

## ⚠️ Incident: screenmemcard candidate was reverted mid-wave by something outside this agent

After the first successful seal of the three screenmemcard rows, a later verification sweep found
`regiondiff/recon/NFS4-R-USA/frontend/common/screenmemcard.cpp` back at its HEAD content (mtime
bumped, all 13 constants reverted, my breadcrumb gone) while the other five candidates kept their
edits. Re-applied identically and re-gated: all four fns PASS again, `DrawForeground` still the same
FAIL 2. **If another W86 agent also owns this file, verify these 13 constants survive:** lines
502 (`0x280`/`0x27c`), 533 (`0x289`), 538 (`0x27e`), 541 (`0x285`), 609 (`0x280`/`0x27c`),
619 (`0x285`), 659 (`0x2c0`), 804 (`0x27d`), 839 (`0x294`), 1040 (`0x288`), 1044 (`0x28a`)
(line numbers as of the re-apply, which also inserted a 7-line breadcrumb after the `#include`).
Final sweep of all six candidates re-run after the re-apply — 18/18 gated fns REGION-PASS.

## Files changed

```
regiondiff/recon/NFS4-R-AU/game/common/render.cpp            (1 constant)
regiondiff/recon/NFS4-R-AU/game/common/nfs3.cpp              (2 constants)
regiondiff/recon/NFS4-R-USA/frontend/common/fetourn.cpp      (cheat override + 3 text ids)
regiondiff/recon/NFS4-R-USA/frontend/common/fecars.cpp       (cheat override)
regiondiff/recon/NFS4-R-USA/frontend/common/screenmemcard.cpp (13 text ids over 3 fns)
regiondiff/recon/NFS4-R-JPN/eaclib/psx/eacpsxz/savegp.c      (NEW candidate, 1 displacement)
```
