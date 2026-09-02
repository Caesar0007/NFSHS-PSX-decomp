# W84-R01 receipt — femenudefs cluster (NFS4-R-USA) — ALL 3 ROWS REGION-PASS

Candidate (all three rows share one file):
`regiondiff/recon/NFS4-R-USA/frontend/common/femenudefs.cpp`
(seed = verbatim copy of `recon/frontend/common/femenudefs.cpp`, 3540 lines)

Gate command (used for every measurement below):
```
python regiondiff/tools/verify_region.py USA \
  regiondiff/recon/NFS4-R-USA/frontend/common/femenudefs.cpp \
  MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand,MenuExtended_LoadGame__FR12tMenuCommand,__15tGlobalMenuDefs \
  --lane-as=recon/frontend/common/femenudefs.cpp
```
(`VA_MAX=<n>` env var widens the printed diff.)

## FINAL

| row | class | seed gate | final gate |
|---|---|---|---|
| `MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand` | CHANGED | FAIL 91 (ours 138 / oracle 173) | **REGION-PASS (173 insns)** |
| `MenuExtended_LoadGame__FR12tMenuCommand` | CHANGED | FAIL 46 (ours 38 / oracle 54) | **REGION-PASS (54 insns)** |
| `__15tGlobalMenuDefs` | CHANGED | FAIL 592 (ours 3207 / oracle 3207) | **REGION-PASS (3207 insns)** |

Devices: **zero added.** The candidate carries only the devices the base TU already
had as committed (the `AwardPinkSlipsCarManagerArg` identity, the `playerNum`
statement-expression, the `"m"(FEApp)` fence in `GenericMenuLoadGame`, the W76/W82
CSE-flush notes in the ctor). No volatile, no new `__asm__`, no register pins, no
post-compilation moves, no base-tree edits.

## 0. MEASURE-FIRST — unedited seed (the diff IS the regional change)

Recorded above. The key seed reading: the **ctor's instruction count was already
EXACT (3207/3207)**, so the regional ctor is the *same source* with different
constants — not inserted/removed members. Both `MenuExtended_*` were short by
16 / 35 instructions, i.e. genuinely added retail code.

## 1. `MenuExtended_LoadGame` (base @8002D8D0 → USA @8002D950; 38 → 54)

Five independent source-level deltas:
1. **Word ids +1**: `TextSys_Word(0x2c0)`→`0x2c1`; yes/no words `0x321,0x322`→`0x322,0x323`.
2. **Dialog type**: `tDialogYesNo` → **`tDialogYesNoTri`**. The oracle calls
   `__12tDialogYesNo` and then stores `%hi/%lo(_vt_15tDialogYesNoTri)` into
   `0x60(s0)` (= `_vf`) — the inline `tDialogYesNoTri()` ctor shape that base
   `MenuExtended_GoToTwoPlayerSingleRace` already emits verbatim.
3. **`CURRENTPLAYER = screenMemcard->player;`** — regional `0x80051EF0` is
   `menuDefs(0x80051EE0)+0x10`; the base symbol at `menuDefs(0x80051A58)+0x10` is
   `CURRENTPLAYER` (`configs/symbol_addrs.txt` 0x80051A68). Declared locally in the
   candidate as `extern int CURRENTPLAYER;` (femenudefs_externs.h has no decl).
4. **Run() tested `== 1`** (oracle `sll;sra;li v1,1;bne`) instead of base `!= 0`
   (`sll;beqz`).
5. **New else-arm** `((tDialogBase *)&FEApp->MemCardDialog)->Hide();`
   (`lw a0,%lo(FEApp); addiu a0,a0,0x238`).

Falsified / corrected on the way:
* `NoInputMemCardDialog` for delta 5 → **FAIL 2** (`addiu a0,a0,720` vs oracle
  `568`). FEApp+0x238 is `MemCardDialog`; `NoInputMemCardDialog` is FEApp+0x2D0
  (0x98 further on; proven by base `Confirm__Fii` and base `AwardPinkSlipsCar`).
  Correcting the member → PASS.
* No carrier local / statement reordering was needed. The base
  `tMenuCommand();` 8-byte SYM-anonymous carrier is required in the regional
  build too (regional frame 208 = 16 + 168 `AreYouSure` + 8 anon + s0/s1/ra).

## 2. `MenuExtended_AwardPinkSlipsCar` (138 → 173)

Two deltas:
1. **Word ids +1**: `0x291,0x292`→`0x292,0x293` (yesnowords), `0x29a`→`0x29b`
   (sprintf format word), `0x274`→`0x275` (second dialog string).
2. **A new retail music-buffering wait loop** appended after the final
   `Hide(&FEApp->NoInputMemCardDialog)` and before the `command.type/nextMenu`
   tail:
```c
while (AudioMus_Buffered() < AudioMus_Threshold()) {
    FeAudio_systemtask(0);
    FEApp->Redraw();
    FETextRender_MenuTextPositionedJustify(0x27e,0x1e0,0xdc,1,textState_Selected,textType_ScreenInfo);
    PSXDrawSquare(0,0x1e0,0xdc,-textpixels(TextSys_Word(0x27e)) - 5,7);
}
```
   Callee identification (regional VAs are the REGION's layout — resolved by
   region→base delta bracketing against `oracles/NFS4-R-USA/INDEX.tsv`, never by
   looking a regional VA up in `configs/symbol_addrs.txt`):
   | region VA | base VA | delta | name | bracketing evidence |
   |---|---|---|---|---|
   | 8007AA48 | 80079FDC | 0xA6C | `AudioMus_Buffered` | same delta as `AudioMus_Fail` (0xA6C), between `AudioCmn_UnPause` and `AudioMus_Fail` |
   | 8007A9C4 | 80079F58 | 0xA6C | `AudioMus_Threshold` | idem; the `<` pair is the classic buffered-vs-threshold wait |
   | 80015A70 | 80015948 | 0x128 | `FeAudio_systemtask` | same delta as `GetCarFromID`; only fn start in the bracket |
   | 800212E0 | 80021180 | 0x160 | `FETextRender_MenuTextPositionedJustify` | 6-arg call with (0x27e,0x1e0,0xdc,1,1,4) |
   | 8004F12C | 8004EC44 | 0x4E8 | `PSXDrawSquare` | 5-arg call with (0,0x1e0,0xdc,-w-5,7) |
   | 800E4A2C | 800E3E20 | 0xC0C | `textpixels` | wraps `TextSys_Word(0x27e)` |
   The last four are exactly base `tScreen::DisplayLoadingText`'s statement pair
   (`fescreen.cpp:59-60`) with the word id at +1 (base 0x27d → regional 0x27e).
   Declarations copied verbatim from `fescreen_externs.h` into the candidate.
   The regional frame grew 504→512 and every local moved +8 purely because the
   new 6-arg / 5-arg calls need an 0x18-byte outgoing-arg area (base needed 0x10);
   nothing had to be done for that — it falls out of adding the calls.

Sealed first try after those two edits.

## 3. `__15tGlobalMenuDefs` — 592 → PASS, 3207/3207

**The whole regional delta is 184 constructor-argument constants.** Method:

1. Compared the BASE oracle (`asm/nonmatchings/front/__15tGlobalMenuDefs.s`) with
   the regional oracle **positionally** (both 3207 insns, one straight-line block).
   With relocation fields masked, only **116 of 3207** instructions differ in
   *skeleton* (mnemonic+regs), and they are confined to **one band, indices
   252–463**; everything else differs only in an immediate.
2. That band turned out to be a **CSE artifact, not a real codegen problem**: base
   `itemOnePlayerSpecialEvents(..., 100, 10)` (a Y coordinate) and
   `menuSpecialEvent(..., 100, ...)` (a help-word id) share the literal `100`,
   so gcc CSEs one long-lived pseudo spanning exactly indices ~252…~460 and the
   allocation in between changes. In the regional build the word id becomes
   **101**, the two constants stop being equal, the shared pseudo disappears and
   the whole t0/t1 band re-colors. **Bumping the constant fixed the band; no
   allocation work was needed at all.**
3. Wrote `scratchpad/w84/r01_argdiff.py` / `r01_patch_ctor.py`: walk both oracles
   tracking which integer constant reaches each argument slot of every `jal`
   (a1/a2/a3 = args 1–3, `16/20/24…(sp)` = args 4…N), diff per call, then map
   **call #N → initializer #N** (the ctor makes 254 calls; the first 249 are the
   249 top-level member initializers in declaration order, calls 250–254 are the
   ctor BODY's five `SetDimensions` calls), and rewrite that argument in the
   source preserving its radix. 184 edits, 0 unresolved.

Delta shape:
* **182 edits are `+1` on a menu text-word id** — argument 1 of every
  `tMenuItem*` ctor and argument 6 (the `short` help word) of every
  `tMenuNFS4` / `tMenuBlank` / `tOptionsMenu` / `tMenuOptions` ctor. Coordinates
  (`0x1e`, `10`, `0x32`, `34`, `120`, …), flags and `-1` sentinels are untouched
  — i.e. retail inserted exactly one string ahead of the whole menu word range.
* **2 edits are menu FLAG changes**, not word ids:
  * `menuTrophyInfo` arg1 `0x4000` → **`0x4010`**
  * `menuGoToCarDealer` arg1 `0x1200` → **`0x2200`**

Falsified angles (with numbers):
* "the region inserted/removed menu members" — **no**: 3207 == 3207 and the
  skeleton diff is 116 instructions in one band (would be hundreds of inserted
  instructions otherwise).
* "the [252,463] band is a register-allocation problem needing a carrier /
  statement-order device" — **no**: it is entirely downstream of the 100→101
  constant (see 2). The base TU's existing W76/W82 devices (CSE-flush note dial,
  the `&itemGarageCar` allocno carrier on `menuSingleCarSelect#0`) transfer
  unchanged and remain correct for the regional build; nothing was moved or added.

## 4. Files touched
* `regiondiff/recon/NFS4-R-USA/frontend/common/femenudefs.cpp` (the candidate — new file)
* `scratchpad/w84/R01_receipt.md`, `r01_sbs.py`, `r01_argdiff.py`, `r01_patch_ctor.py`

Nothing else. No git operations, no tool edits, no base-tree edits, no
`update_region_progress.py` run.
