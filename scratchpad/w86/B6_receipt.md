# W86-B6 receipt — regional row sealing (12 rows) — **ALL 12 REGION-PASS**

Gate: `python regiondiff/tools/verify_region.py <REGION> <cand> <fns> --lane-as=recon/<unit>.<ext>`
Rules honoured: never overwrote an existing candidate (front.cpp / weather.cpp
were edited IN PLACE); every previously-SEALED fn of every touched candidate
re-gated; no git, no `tools/*.py` or `regiondiff/tools/*.py` edits, no board /
MANIFEST / memory edits, no base-tree (`recon/**`) edits, no asm/volatile/pins
added.

## Row ledger — final

| # | region | unit | fn | words | result |
|---|---|---|---|---|---|
| 1 | USA | frontend/common/screenpost | DrawBackground__24tScreenPinkSlipStandings | 265 | **REGION-PASS** |
| 2 | USA | frontend/common/screenpost | DrawBackground__26tScreenTournamentStandings | 561 | **REGION-PASS** |
| 3 | USA | frontend/common/screenpost | DrawMoney__Fiiilii | 78 | **REGION-PASS** |
| 4 | USA | frontend/common/front | Front_InitOpponentCars__FR9tFEStream | 357 | **REGION-PASS** |
| 5 | USA | frontend/common/front | PlayerNameMixedCase__Fi | 27 | **REGION-PASS** |
| 6 | USA | frontend/common/front | PlayerName__Fi | 35 | **REGION-PASS** |
| 7 | USA | frontend/common/screenaudio | DrawBackground__12tScreenAudio | 154 | **REGION-PASS** |
| 8 | USA | frontend/common/screenaudio | DrawForeground__12tScreenAudio | 68 | **REGION-PASS** |
| 9 | AU | game/psx/weather | Weather_InitSplats__Fv | 69 | **REGION-PASS** |
| 10 | AU | game/psx/trsproj | TrsProj_SetViewTrsProjEnviro__FP13DRender_tView | 21 | **REGION-PASS** |
| 11 | USA | eaclib/psx/eacpsxz/savegp | savegp | 5 | **REGION-PASS** |
| 12 | AU | eaclib/psx/eacpsxz/savegp | savegp | 5 | **REGION-PASS** |

Co-hosted rows re-gated (iron rule), all still REGION-PASS:
`Front_AppendOpponentData__FPiR9tFEStream`, `Front_GetInGameVars__Fv`,
`Front_InitMissions__FR9tFEStream`, `Front_InitTrack__FR9tFEStream`,
`Front_InitialMemCardCheck__Fv`, `Front_SecondaryMemCardCheck__Fv` (USA front.cpp)
and `Weather_DoSplats__FiP18Weather_tSplatInfo` (AU weather.cpp).
A manifest sweep over all rows whose `candidate` is one of the five touched files
confirms no other row is hosted by them.

Candidates: seeded fresh (did not exist) — USA `frontend/common/screenpost.cpp`,
USA `frontend/common/screenaudio.cpp`, AU `game/psx/trsproj.cpp`,
USA+AU `eaclib/psx/eacpsxz/savegp.c`.  Edited in place (already existed) —
USA `frontend/common/front.cpp`, AU `game/psx/weather.cpp`.

Helper written (scratchpad only, not a tool edit): `scratchpad/w86/b6_wdiff.py`
— index-aligned word diff of a base oracle `.s` against a regional oracle `.s`.
Needed because `verify_region` truncates its diff print at 6 pairs while
`AUDIT_LO16.txt` truncates at 4 insns per fn; the two full listings are
count-exact for every row here, so an index-aligned word compare recovers the
COMPLETE delta set (and cleanly separates the reloc words —
`jal`/`j`/`%hi`/`%lo`/`%gp_rel` — that the gate masks on both sides).

---

## Class A — the retail +1 text-id shift (rows 1,2,3,5,6,7,8)

The retail string table gained one entry ahead of the ids these functions use,
so every `TextSys_Word*` id (and every id-carrying `addiu rX,rY,K` base) is
exactly +1.  All are plain `li`/`addiu` immediates, un-relocated, so they are
authoritative under REGION-PASS.

**32B-5 CSE trap check performed on every function** (a per-jal constant audit
cannot see a `li` shared by two semantic uses).  Method: count source-level
occurrences of each literal and compare against the per-insn count recovered by
`b6_wdiff.py`.  Every id matched 1:1 or matched a known giv/loop base, and in
this class *all* ids shift together (the whole table moved), so a shared `li`
would in any case have been correct to patch.  Recorded per function below.

### row 3 — DrawMoney__Fiiilii (78 insns, 3 words)
`TextSys_Word(0x86/0x87/0x88)` -> `0x87/0x88/0x89`; three distinct `switch`
arms, one `li` each (insns 24/32/41).  No sharing possible.

### rows 5,6 — PlayerName__Fi (35) / PlayerNameMixedCase__Fi (27), 2 words each
`TextSys_Word(player + 0x50)` -> `+ 0x51` and `TextSys_Word(0x4e)` -> `0x4f`
in both functions (PlayerName insns 25/26, MixedCase insns 17/18).

### rows 7,8 — screenaudio (154 / 68 insns, 2 words each)
DrawForeground: `0x27d` -> `0x27e` at BOTH uses
(`FETextRender_MenuTextPositionedJustify` arg0 and `TextSys_Word` inside
`textpixels`) — insns 41 and 51 are two SEPARATE `li $a0`, not one shared
constant.  DrawBackground: `TextSys_WordX(0x1dc)`/`TextSys_WordY(0x1dc)` ->
`0x1dd` (insns 118/119, likewise two separate `li`).

### row 1 — DrawBackground__24tScreenPinkSlipStandings (265 insns, 18 words)
Ids shifted: `0xd5->0xd6`, `0x2c1->0x2c2` (x2), `0x2f6->0x2f7` (x2),
`0x2f7->0x2f8`, `0x2f8->0x2f9`, `0x2fb->0x2fc` (x2), `0x2fc->0x2fd` (x4),
`0x2fe->0x2ff` (loop giv base `li $s1`), `0x30d->0x30e`, `0x313->0x314`
(second-loop giv base `li $s3`), `0x31e->0x31f`, `799->800`.
Occurrence audit: 18 source sites map to the 18 differing `li`/`addiu` insns
(11,35,50,61,70,90,93,117,124,130,149,150,155,165,168,171,213,227); the two
`0x2fe + i` and two `0x314 + i` spellings share their giv base by design.
UNCHANGED (verified against the region words): shape ids `0x27`/`0x28`/`0x1d`,
the `0x282828` tint and the geometry constants.

### row 2 — DrawBackground__26tScreenTournamentStandings (561 insns, 39 words)
Ids shifted: `0xd5->0xd6`, `0x257->0x258` (`i + 599` -> `i + 600`),
`0x2f6->0x2f7` (x4), `0x2f7->0x2f8`, `0x2f8->0x2f9`, `0x2fa->0x2fb` (x4),
`0x2fb->0x2fc` (x5), `0x2fc->0x2fd` (x4), `0x2fd->0x2fe` (x2),
`0x2fe->0x2ff` (the `line` row counter's init), `0x31b/0x31c/0x31d` ->
`0x31c/0x31d/0x31e`, `0x312/0x313/0x314/0x315` -> `0x313/0x314/0x315/0x316`
(x3 each: the label `TextSys_Word`, its `TextSys_WordY`, and the `DrawMoney`
`TextSys_WordY`).
Occurrence audit matched exactly (0x2f6 4, 0x2fa 4, 0x2fb 5, 0x2fc 4, 0x2fd 2,
0x312/0x313/0x314/0x315 3 each) = the 39 differing words.
🔴 **NOT shifted, and deliberately left alone**: the `i += 0x13` tournament-name
offset applied to the `TextValue(...)` result — its word is IDENTICAL in the
regional image even though the value feeds `TextSys_Word`, so the shift is
already carried by the iterator's return.  Blanket-patching every integer
literal would have broken this one; the word-level diff is what caught it.
Also unchanged: `0x27`/`0x28`/`0x1d`, `AudioCmn_PlayFESFX(0x15)`,
`kRGBVals[textDefinitions[0xb][5]]`, `0x232323`/`0x282828`, `300`, `0x1e`, `0x96`.

None of these functions needed a codegen device: the SEALED base body plus the
constant substitution is count-exact and REGION-PASS on the first gate.

---

## Class B — real value deltas (rows 4, 9, 10)

### row 4 — Front_InitOpponentCars__FR9tFEStream (357 insns, 1 word) — NOT a +1 shift
insn 170 `24040019 -> 2404000d`: the argument of the single
`FECheat_IsCheatEnabled(...)` call inside the tournament loop is **25 -> 13**.
Independently reached here from the word diff, and **confirmed by W86-B9** as the
retail **`tCheatCode` ENUM RENUMBERING** (B9 measured the same 25->13 in
fetourn/fecars plus `cheat_AllCops` 12 -> 11).  Explicitly NOT the +1 text-id
class.  Everything else in the 357-insn body is reloc-only.

Applied with **B9's recipe** (aligned on the orchestrator's note) — a
candidate-local post-include override, base headers untouched:

```c
#include "front.h"
#undef cheat_FinishedTournament
#define cheat_FinishedTournament 13     /* front.cpp, [REGIONAL] was 25 */
```

so the call site keeps the retail enumerator NAME
(`FECheat_IsCheatEnabled(cheat_FinishedTournament)`) instead of a numeric cast.
The macro covers both spellings of the identifier (enum member in
`fecheats_types.h`/`nfs4_types.h`, macro in `fetourn_types.h`/
`screencarselect_types.h`) and cannot disturb the already-parsed enum.
Verified this is the function's ONLY `cheat_FinishedTournament` reference and
the base oracle's only `addiu $a0,$zero,0x19`, so nothing else shifts with it.
Re-gated after the switch from the cast form: still REGION-PASS 357/357, and
all 6 co-hosted SEALED front.cpp rows still REGION-PASS.

### row 10 — TrsProj_SetViewTrsProjEnviro (21 insns, 2 words)
`TrsProj_SetProjection(0,0,0x140,0x78)` -> `0x80` and the else arm
`(0,0,0x140,0xf0)` -> `0x100` (insns 10 and 14).  The projection viewport HEIGHT
is the PAL 256-line frame in the AU/FR-DE/UK-ES-IT/UK-SW group; the width
`0x140` (320) is unchanged.

### row 9 — Weather_InitSplats__Fv (69 insns, 2 words)
Same PAL constant pair in the splat spread height: `ySize = 0xf0` -> `0x100`
and the `gs[3] == commModeNetwork` arm's `0x78` -> `0x80` (insns 17/18).
Consistent with row 10 — the two rows are the same regional decision.
The base body's measured shape (exit-in-the-middle no-rotation loop, the
`result`/`gs`/`commModeNetwork` codegen carriers) was left untouched; only the
two constants changed, and the function stayed count-exact at 69/69.

### rows 11,12 — savegp (5 insns, 1 word each)
`savegp` is hand-written MIPS (`C:\LIB\PSX\SAVEGP.ASM`, SYM SLD `.ASM`)
transcribed verbatim as a file-scope `__asm__` in the sealed base TU — the
methodology §3.25 class-3 hand-asm lane, not a new device.  Its `$gp` reload
keeps the target address as a **linked literal** (`lui $gp,0x8012; lw
$gp,<disp>($gp)`) rather than a `%hi/%lo` pair, so the displacement is NOT
masked by the gate and must be transcribed per region:

* base   `lw $28,13544($28)` = 0x801234E8
* R-USA  `lw $gp,18392($gp)` = 0x801247D8  (insn 2: `8f9c34e8 -> 8f9c47d8`)
* R-AU   `lw $gp,18436($gp)` = 0x80124804  (insn 2: `8f9c34e8 -> 8f9c4804`)

Kept DECIMAL — maspsx `int()`-parses the `offset(base)` displacement base-10.
`initgp`'s `%hi/%lo(D_801234E8)` needs no change: it is a real reloc, masked on
both sides.  (JPN is a third distinct value, `800EB7D8`; that row is not in this
assignment and was left untouched.)

---

## Notes for the orchestrator

* `regiondiff/tools/update_region_progress.py` was **not** run — the W86 guide
  prohibits board edits.  All 12 rows plus the 7 co-hosted rows are verified
  green by direct `verify_region` invocation (transcript above); the board can
  be regenerated by whoever owns it.
* The `i += 0x13` finding in row 2 generalises: on a +1-text-shift row, do NOT
  blanket-bump every literal — an id that is *computed* from a shifted source
  (here a `TextValue` iterator result) keeps its offset.  Only the word-level
  base-vs-region diff distinguishes the two, which is why `b6_wdiff.py` (or an
  equivalent full-listing compare) should precede the edit on any row with more
  than a handful of delta words.
* Row 4's cheat-ordinal delta (25 -> 13) agrees with W86-B9's independent
  measurement of the retail `tCheatCode` renumbering (B9 also has
  `cheat_AllCops` 12 -> 11).  Any other regional row passing a `tCheatCode`
  should be checked against that renumbering, never against the base enum.
* Orchestrator's fleet notes, as applied here: the +1 substitutions were made
  as ONE simultaneous block replacement per region of source (never a sequence
  of ascending single-literal rewrites), which is why no id double-shifted
  despite overlapping runs such as `0x2fb->0x2fc` sitting next to
  `0x2fc->0x2fd` in the same function.  `VA_MAX=60` was used on the final
  front.cpp re-gate.  `FAIL n == 2 x (audit words)` held on every row
  (e.g. DrawBackground__26 FAIL 78 == 2 x 39), which is how the truncated
  audit/gate prints were reconciled against the full `b6_wdiff.py` listing.
