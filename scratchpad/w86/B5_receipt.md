# W86-B5 receipt — regional row sealing (5 rows) — **ALL 5 SEALED**

Gate: `python regiondiff/tools/verify_region.py <REGION> <cand> <fns> --lane-as=recon/<unit>.<ext>`
Rows: `scratchpad/w86/B5_rows.tsv`. All three candidates PRE-EXISTED — edited IN PLACE,
never overwritten. No git, no tools/, no board/MANIFEST/memory edits.

| # | region | unit | function | before | after |
|---|---|---|---|---|---|
| 1 | USA | frontend/common/feapp | MainLoop__14tFEApplicationP5tMenu | FAIL 4 | **REGION-PASS (1123)** |
| 2 | USA | frontend/common/feapp | DrawHelpIcons__14tFEApplication | FAIL 10 | **REGION-PASS (254)** |
| 3 | AU | frontend/common/screencarselect | SetDialog__25tScreenCarSelectTwoPlayer | FAIL 6 | **REGION-PASS (48)** |
| 4 | AU | frontend/common/screencarselect | SetDialog__25tScreenPinkSlipsCarSelect | FAIL 22 | **REGION-PASS (164)** |
| 5 | JPN | frontend/common/fetools | FeTools_init__Fv | FAIL 4 | **REGION-PASS (58)** |

All five were pure IMMEDIATE deltas (every seed was already count-exact: ours == oracle
instruction count), i.e. the audit_lo16 hidden-changed class. No structural/logic delta,
no new devices, no reshape — so no risk of collateral codegen motion.

## Iron rule: every previously-SEALED fn of every candidate I touched, re-gated

| candidate | previously-SEALED fns | after my edits |
|---|---|---|
| `regiondiff/recon/NFS4-R-USA/frontend/common/feapp.cpp` | Redraw__14tFEApplication (360), RunDemoVideo__14tFEApplication (184) | both REGION-PASS |
| `regiondiff/recon/NFS4-R-AU/frontend/common/screencarselect.cpp` | DrawCar__FR8tCarInfossffcbUl7tPlayer (125) | REGION-PASS |
| `regiondiff/recon/NFS4-R-JPN/frontend/common/fetools.cpp` | s_lower__FPc (8), s_upper__FPc (8) | both REGION-PASS |

That is 10/10 rows across the three (region, unit) pairs — the complete row set of each
candidate file per REGION_PROGRESS.txt — all REGION-PASS in the final consolidated run.

---

## The 32B-5 CSE-shared-constant trap: how each row was cleared of it

The trap: a per-jal constant audit cannot see a `li` that CSE has made serve TWO semantic
uses; patching the single found site then breaks the other use (+1 `li`, count drift).
Discriminator used on every row: **count the oracle's own `li`/`addiu` sites for the
constant class and compare against the number of SOURCE uses.** Where site count ==
source-use count, no sharing exists and the per-site patch is safe. I read each region
oracle slice in full rather than trusting the (4-line-capped) audit listing.

* Row 5 (FeTools_init): 3 source `Font_LoadFont` calls, 3 distinct `li $a2` in the oracle
  (256 / 256 / 352) — including two IDENTICAL 256s that were NOT merged. No sharing.
* Row 2 (DrawHelpIcons): 4 source `TextSys_Word(0xfc)` uses (sprintf, FETextRender,
  textpixels, strlen — the last two inside ONE expression, the obvious merge candidate),
  and the diff showed exactly 4 `li a0,252` sites. 4 == 4 -> no sharing; shifting the
  whole class was safe.
* Row 4 (PinkSlips SetDialog): audit said 11 changed words; enumerating the source gave
  exactly 11 candidates (2 geometry + 9 text ids) and the oracle carries 9 distinct text
  constants (681/684/682/688/690/686/814/816/641) + `li v1,64` / `li v1,-64`. 11 == 11.
* Rows 1/3: single-use constants, nothing to share.

---

## Row 1 — USA `MainLoop__14tFEApplicationP5tMenu` — SEALED (FAIL 4 -> PASS, 1123 insns)

Seed diff (measure-first, unedited candidate):
```
- addiu a0,s1,661   + addiu a0,s1,662     (audit insn 941)
- li a0,663         + li a0,664           (audit insn 973)
```
Both are `TextSys_Word` arguments in the pink-slips memcard block — the retail
string-table **+1 shift**. `addiu a0,s1,661` is the per-player pair base
(`TextSys_Word(player + 0x295)`), so only the addend moves; the induction on `player`
is unchanged.

Edits (`regiondiff/recon/NFS4-R-USA/frontend/common/feapp.cpp`):
* `memcardDialog->SetString(TextSys_Word(player + 0x295))` -> `+ 0x296`
* `sprintf(string,TextSys_Word(0x297),PlayerName(0),1)` -> `0x298`

## Row 2 — USA `DrawHelpIcons__14tFEApplication` — SEALED (FAIL 10 -> PASS, 254 insns)

Seed diff: 4 x `li a0,252 -> 253` + 1 x `li a0,253 -> 254` (audit insns 25/149/160/163
plus the 5th word the capped listing omitted). Same +1 table shift; note it moves 0xfd
into 0xfe, so the two classes had to be shifted in the right ORDER (the 0xfd site first,
then the four 0xfc sites) or the second pass would have double-shifted the first.

Edits: `TextSys_Word(0xfd)` (the HasOptionsMenu-arm FETextRender) -> `0xfe`; then all four
`TextSys_Word(0xfc)` uses (sprintf / FETextRender / textpixels / strlen) -> `0xfd`.
No other function in the TU references 0xfc/0xfd, so the class is function-local.

## Row 3 — AU `SetDialog__25tScreenCarSelectTwoPlayer` — SEALED (FAIL 6 -> PASS, 48 insns)

Seed diff:
```
- li v0,60    + li v0,64        (audit insn 17)
- li v0,-60   + li v0,-64       (audit insn 18)
- li a0,680   + li a0,681       (audit insn 19)
```
Two deltas of different KIND in one function: the AU-family build moves the two-player
car dialog's Y offset 0x3c -> 0x40 (a real layout constant, not a text id) AND applies
the +1 string-table shift to `TextSys_Word(0x2a8)`.

Edit: `(player == 0) ? -0x3c : 0x3c` -> `? -0x40 : 0x40`; `TextSys_Word(0x2a8)` -> `0x2a9`.
Both ternary arms are separate `li`s in the oracle, so moving them together is correct.

## Row 4 — AU `SetDialog__25tScreenPinkSlipsCarSelect` — SEALED (FAIL 22 -> PASS, 164 insns)

11 changed words (the gate prints at most 6 diff pairs, so the full set came from reading
`oracles/NFS4-R-AU/SetDialog__25tScreenPinkSlipsCarSelect.s` end-to-end):

| source | base | AU region |
|---|---|---|
| `SetPosition(0, player? -0x3c : 0x3c, ...)` | 60 / -60 | 64 / -64 |
| `sprintf("",TextSys_Word(0x2a8),...)` | 680 | 681 |
| `wordnum = player + 0x2ab` (no card, early) | 683 | 684 |
| `wordnum = player + 0x2a9` (no card, >800 ticks) | 681 | 682 |
| `wordnum = player + 0x2af` (CardFailedNotFound) | 687 | 688 |
| `wordnum = player + 0x2b1` (CardFailedUnformatted) | 689 | 690 |
| `wordnum = player + 0x2ad` (CardFailed) | 685 | 686 |
| `wordnum = player + 0x32d` (NotEnoughCars) | 813 | 814 |
| `wordnum = player + 0x32f` (TooManyCars) | 815 | 816 |
| `wordnum = player + 0x280` (CardCurrentlyLoading) | 640 | 641 |

Every text id in the function shifts +1 — including the low `0x280` — which pins the
inserted-string threshold BELOW 0x280 for the AU family; combined with row 2 (0xfc shifts
in R-USA) the insertion is below 0xfc in USA too. Applied line-by-line with the shifted
values written directly (never a sequential textual `0x2a8->0x2a9` sweep, which would have
collided with the existing `0x2a9` site).

Edit style note: every changed constant carries an inline `/* REGIONAL ... (oracle <VA>) */`
breadcrumb naming the oracle instruction that proves it, so a later reader can re-derive
the delta without the audit file.

---

## Final consolidated gate (all 10 rows of the three candidates)

```
USA feapp:   MainLoop 1123 PASS | DrawHelpIcons 254 PASS | Redraw 360 PASS | RunDemoVideo 184 PASS
AU carselect: SetDialogTwoPlayer 48 PASS | SetDialogPinkSlips 164 PASS | DrawCar 125 PASS
JPN fetools:  FeTools_init 58 PASS | s_lower 8 PASS | s_upper 8 PASS
```

Board (`REGION_PROGRESS.txt`) intentionally NOT regenerated — board edits are prohibited
for this wave; the orchestrator should run `update_region_progress.py` to pick these up.
