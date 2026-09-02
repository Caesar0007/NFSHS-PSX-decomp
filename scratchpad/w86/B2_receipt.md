# W86-B2 receipt — regional row sealing

Agent: W86-B2. Rows: `scratchpad/w86/B2_rows.tsv` (7 rows).
Gate: `python regiondiff/tools/verify_region.py <REGION> <cand> <fns> --lane-as=recon/<unit>.<ext>`
Rules honoured: no git, no tool/memory/board edits, candidates never overwritten
(seeded only where absent), source-level C/C++ only, no asm/volatile/pins.

---

## ROW 1-3 — AU `game/psx/flare` (Flare_LensFlare / Flare_Moon / Flare_Sun) — **SEALED**

Candidate: `regiondiff/recon/NFS4-R-AU/game/psx/flare.cpp` (did NOT exist — seeded
verbatim from `recon/game/psx/flare.cpp`).

Measure-first (unedited seed):

```
Flare_LensFlare__FP7DVECTORP15Draw_FlareCache: FAIL 2  (409/409)  li v0,240 -> 256
Flare_Moon__FP7SVECTORP15Draw_FlareCache:      FAIL 4  (46/46)    li a2,120 -> 128 ; li a2,60 -> 64
Flare_Sun__FP7SVECTORP15Draw_FlareCache:       FAIL 8  (187/187)  li a2,120/60 -> 128/64 ; li v1,120/60 -> 128/64
```

Counts already EXACT everywhere ⇒ pure constant class, matching
`AUDIT_LO16.txt` (AU) word-for-word:
`Flare_LensFlare insn 53: 240200f0 -> 24020100`,
`Flare_Sun insn 9/10/39/46: 24060078/2406003c/24030078/2403003c -> ...0080/...0040`,
`Flare_Moon insn 1/7: 24060078/2406003c -> 24060080/24060040`.

**Root cause (named, not a blind patch): the PAL vertical resolution.** AU / FR-DE /
UK-ES-IT / UK-SW are 256-line PAL builds; the base (NTSC) is 240. Every changed word
is a screen-height derivative: 240→256, 240/2=120→128, 240/4=60→64.

Edits (4 sites, all source-level literals, each commented as REGIONAL):
- `Flare_LensFlare`: `dy = 0xf0 - sy;` → `0x100 - sy`
- `Flare_Sun`: `pshift = 0x78/0x3c` → `0x80/0x40`; `vertRezBy2 = 0x78/0x3c` → `0x80/0x40`
- `Flare_Moon`: `pshift = 0x78/0x3c` → `0x80/0x40`

32B-5 (CSE-shared-constant) check: each literal is written once per semantic use and
lives in a distinct named local (`pshift`, `vertRezBy2`, `dy`); the audit's word count
(1 / 4 / 2) equals the number of edited sites and the post-edit diff is 0 with the
instruction count unchanged — no shared `li` was disturbed.

Gate after edit:

```
Flare_LensFlare__FP7DVECTORP15Draw_FlareCache: REGION-PASS (409 insns) [NFS4-R-AU]
Flare_Moon__FP7SVECTORP15Draw_FlareCache:      REGION-PASS (46 insns)  [NFS4-R-AU]
Flare_Sun__FP7SVECTORP15Draw_FlareCache:       REGION-PASS (187 insns) [NFS4-R-AU]
```

No previously-sealed fn in this candidate (new file); MANIFEST has exactly these 3
flare rows, all now PASS.

---

## ROW 4-5 — USA `frontend/common/screentrackrecords` (DrawBackground / DrawRecords) — **SEALED**

Candidate: `regiondiff/recon/NFS4-R-USA/frontend/common/screentrackrecords.cpp`
(EXISTED — holds the already-SEALED `DrawOneRecord__19tScreenTrackRecordsibi`;
edited in place, never overwritten).

Measure-first (as found): `DrawOneRecord` REGION-PASS 156, `DrawBackground`
FAIL 34 (364/364), `DrawRecords` FAIL 8 (120/120). Counts EXACT ⇒ pure
constant class — the retail **string-table +1 text-id shift** (the same shift
already applied to DrawOneRecord by the earlier agent, just never propagated
to the other two fns).

`VA_MAX=100` full diff → every diff is `li/addiu <id>` → `<id>+1`.

### 32B-5 CSE-shared-constant handling (the trap fired here)

`DrawRecords` shows only **4** changed words but the source has **5** text-id
sites: `TextSys_Word(k+599)`, `TextSys_WordX(0x249)`, `TextSys_WordY(k+599)`,
`TextSys_WordY(k+599)` (2nd), `TextSys_WordY(0x260)`. gcc CSEs **two of the
three `k+599` terms into ONE `addiu`**, so a per-instruction audit sees 2, not
3. Patching only the found sites would have left one semantic use on the old
id (compiles clean, silent wrong text). All **5** source sites were shifted.

`DrawBackground` was verified the other way: 17 changed words vs a hand census
of 17 TextSys sites (0x255 appears 4× in source AND 4× in asm — `$a0` is
call-clobbered so no sharing there; 0x24c appears 2×/2×). 1:1, no hidden share.

### Edits

DrawRecords: `k+599`→`k+600` (×3), `WordX(0x249)`→`0x24a`, `WordY(0x260)`→`0x261`.
DrawBackground (+1 on each): `WordX 0x248→0x249`, `WordY 0x256→0x257`,
`WordX 0x24f→0x250`, `WordY 0x25f→0x260`, `Word 0x251→0x252`,
`Front_GetTrackRaced()+0xd5→+0xd6`, `WordY 0x255→0x256` (×4),
`WordX(j+0x24c)→j+0x24d`, `Word(j+0x252)→j+0x253`, `Word 0x262→0x263`,
`WordX 0x249→0x24a`, `WordX 0x24c→0x24d` (×2), `WordY 0x260→0x261`.
(Applied via a two-pass sentinel rewrite so the +1 chain 0x248→0x249→0x24a
could not cascade onto an already-rewritten site.)

Gate (whole candidate, incl. re-gate of the previously-SEALED fn — iron rule):

```
DrawOneRecord__19tScreenTrackRecordsibi: REGION-PASS (156 insns) [NFS4-R-USA]
DrawBackground__19tScreenTrackRecords:   REGION-PASS (364 insns) [NFS4-R-USA]
DrawRecords__19tScreenTrackRecordss:     REGION-PASS (120 insns) [NFS4-R-USA]
```

No DATA_PROGRESS rows target this unit.

---

## ROW 6 — AU `frontend/common/femenuextended` (Draw__12tMenuOptions) — **SEALED**

Candidate: `regiondiff/recon/NFS4-R-AU/frontend/common/femenuextended.cpp`
(EXISTED — holds the already-SEALED `MenuNFS4_DrawTextBox__FiR4RECTissbT5`;
edited in place).

Measure-first: `FAIL 2 (182/182)` — `li v1,240` → `li v1,256`. AUDIT_LO16 (AU)
`insn 67: 240300f0 -> 24030100`. Same PAL 240→256 screen-height root cause as
the flare rows.

**32B-5 again:** the source spells `0xf0 - h` **THREE** times (the `y` centring
plus the two `fPlayer` split-screen offsets) but cse emits **ONE** `li v1,240`
for all three — the audit reports a single word. Shifting only the audited site
would have broken the sharing (+1 `li`, count drift) and left two arms on 240.
All three sites moved to `0x100` together.

```
MenuNFS4_DrawTextBox__FiR4RECTissbT5: REGION-PASS (302 insns) [NFS4-R-AU]
Draw__12tMenuOptions:                 REGION-PASS (182 insns) [NFS4-R-AU]
```

---

## ROW 7 — USA `frontend/common/fedialog` (CalculateDimensions__11tDialogHelp) — **SEALED**

Candidate: `regiondiff/recon/NFS4-R-USA/frontend/common/fedialog.cpp`
(did NOT exist — seeded verbatim from `recon/frontend/common/fedialog.cpp`;
the JPN variant of this fn lives in its own separate JPN candidate, untouched).

Measure-first: `FAIL 18 diffs (359/359)` — nine `li a1,N` → `N+1`, in source
order 89,82,83,86,85,84,87,88,86. Matches AUDIT_LO16 (USA) "9 words"
(`insn 32 24050059->2405005a`, `87 24050052->24050053`,
`92 24050053->24050054`, `110 24050056->24050057`, …).

**32B-5, third instance:** the function has **TEN** `AddItem(<helpTextId>, …)`
sites but only **NINE** `li a1` words — the two identical `AddItem(0x56,8)`
arms (`CanContinue()` / `HasFlag(4)`) are cross-jump-merged by gcc into one
call. All ten source sites shifted +1:
`0x59→0x5a, 0x52→0x53, 0x53→0x54, 0x56→0x57, 0x55→0x56, 0x54→0x55,
0x57→0x58, 0x58→0x59, 0x56→0x57 (×2)`. Applied with a sentinel two-pass
rewrite so the consecutive-id chain could not cascade (0x52→0x53 must not then
be re-read by the 0x53→0x54 rule). Button-mask second args unchanged (no diffs
there), confirming the shift is text-id-only.

```
CalculateDimensions__11tDialogHelp: REGION-PASS (359 insns) [NFS4-R-USA]
```

---

## SUMMARY

**7 / 7 assigned rows REGION-PASS.** Plus 2 previously-SEALED fns in touched
candidates re-gated and still PASS (`DrawOneRecord__19tScreenTrackRecordsibi`,
`MenuNFS4_DrawTextBox__FiR4RECTissbT5`).

Two root causes, both named rather than blind-patched:
1. **PAL vertical resolution 240→256** (AU/FR-DE/UK-ES-IT/UK-SW): flare ×3 and
   `Draw__12tMenuOptions`. Constants 240/120/60 → 256/128/64.
2. **Retail string-table +1 text-id shift**: screentrackrecords ×2 and
   fedialog `tDialogHelp::CalculateDimensions`.

**The 32B-5 CSE-shared-constant trap fired in 3 of the 5 shift rows** — in
every case the source had MORE semantic sites than the audit had words
(3 source / 2 words; 3 source / 1 word; 10 source / 9 words). Sharing came from
cse (`k+599`, `0xf0 - h`) and from a cross-jump merge of two identical calls
(`AddItem(0x56,8)`). Patching only the audited words would have compiled clean,
drifted the instruction count, and silently left live sites on the old value.
**Rule confirmed and worth banking: for a constant-shift row, census the SOURCE
sites of the shifted class and shift them ALL; use the audit's word count only
as a cross-check on how many the compiler kept, never as the edit list.**

Board note: per the W86 PROHIBITIONS I did **not** run
`regiondiff/tools/update_region_progress.py` (board regeneration). The
orchestrator should regenerate `REGION_PROGRESS.txt` — 7 rows move
TODO/FAIL → SEALED (3 AU flare, 2 USA screentrackrecords, 1 AU
Draw__12tMenuOptions, 1 USA CalculateDimensions__11tDialogHelp).

Files changed (candidates only, no base tree / tools / configs / git):
- `regiondiff/recon/NFS4-R-AU/game/psx/flare.cpp` (new)
- `regiondiff/recon/NFS4-R-USA/frontend/common/fedialog.cpp` (new)
- `regiondiff/recon/NFS4-R-USA/frontend/common/screentrackrecords.cpp` (edited in place)
- `regiondiff/recon/NFS4-R-AU/frontend/common/femenuextended.cpp` (edited in place)
