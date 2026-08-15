# W65-A2 — THE ±1-SHIFT BRANCH BELT (class-d, the 17 cheap rows)

Repo `C:\Temp\nfs4-decomp`, base `14c766e6`. Instrument = `tools/brdist.py`
(the gate is blind here: `verify_asm` normalises every branch **target** to `T`,
law 04Q). Every number below was measured by me, twice, with `scratchpad/w65a2/pr.py`
(a loader that injects extra `PER_FN_*` rows **in memory** — `tools/build.py` was
never edited, never even opened for write).

---

## 0. SCOREBOARD — 12 of the 17 rows closed

`scratchpad/w64a21/BOARD_RECONCILIATION.md` §5 lists 27 class-d rows; 17 are the
±1-instruction shifts (the 10 large-delta whole-block rows are out of scope).
One of the 17 (`_padIntRecvHdr`) was already closed by w64-a7.

| # | VA | TU | function | brdist before | after | route |
|---|---|---|---|---|---|---|
| 1 | 0x8010C288 | libpad/MCXMAIN | `_padIntRecvHdr` | (1,6,7)(2,4,5) | **0** | w64-a7, already wired |
| 2 | 0x8010C314 | libpad/MCXMAIN | `_padIntRecvData` | (13,34,35) | **0** | label move — SPEC |
| 3 | 0x800F9A28 | libcd/streamhelp | `StGetNext` | (0,15,14) | **0** | label move — SPEC |
| 4 | 0x8003D364 | screencarselect | `DrawVideoWall__20tScreenCarSelectDuels` | (3,14,15) | **0** | label move — SPEC |
| 5 | 0x8003D4BC | screencarselect | `DrawOpponentVideoWall__20tScreenCarSelectDuels` | (3,13,14) | **0** | label move — SPEC |
| 6 | 0x8004923C | screencongrats | `CalculatePrizes__23tScreenTournamentTrophy` | (9,17,18) | **0** | label move — SPEC |
| 7 | 0x800696B0 | aiphysic | `AIPhysic_CalcAcceleration__FP8Car_tObji` | (27,5,6) | **0** | label move — SPEC |
| 8 | 0x8007C750 | audiotrk | `AudioTrk_AddCustomObject__…` | (48,14,13) | **0** | label move — SPEC |
| 9 | 0x800AA984 | physics | `Physics_CalculateCarAcceleration__FP8Car_tObj` | (25,71,72) | **0** | label move — SPEC |
| 10 | 0x800E2218 | weather | `Weather_ChangeDensityBasedOnTime__Fv` | (5,10,11) | **0** | label move — SPEC |
| 11 | 0x800813CC | camera | `Camera_UpdateHeliCam__Fii` | (26,4,3) | **0** | label move — SPEC 🔴 **fixes a REAL semantic bug** |
| 12 | 0x800718B4 | aistate | `CheckIfCarIsNearbyAndStop__…` | (9,15,16) | **0** | **SOURCE fix, LANDED `e3231dd9`** 🔴 **REAL bug** |
| 13 | 0x800F7034 | libgpu/FONT | `FntPrint` | (10,8,9) | (10,8,9) | maspsx law — §4.1 |
| 14 | 0x8010A0E4 | libpad/PADSEQD | `_dirSendAuto` | (1,32,33) | (1,32,33) | needs RETARGET — §4.2 |
| 15 | 0x800FB30C | libmcrd/LIBMCRD | `MemCardWriteData_cb` | (6,53,52) | (6,53,52) | needs RETARGET — §4.2 |
| 16 | 0x800379C0 | screenmain | `DrawBackground__11tScreenMain` | (9,11,12) | (9,11,12) | needs RETARGET — §4.2 |
| 17 | 0x800D42C8 | game/psx/hud | `Hud_BuildString__FPciiiib` | (2,154,155) | (2,154,155) | needs RETARGET — §4.2 |

Deliverables: `SPEC_text_moves_w65a2_ALL.json` (8 rows, per-row rationale inline),
`PROBE_final_list.json` (the **FINAL** per-fn row list including the already-wired
rows — the file to probe with, per the W65 brief), `pr.py` (the probe harness),
`tgt.py` / `dump2.py` / `brshow.py` (the analysis tools).

---

## 1. THE MECHANISM (one sentence, then the evidence)

A class-d ±1 row is **not a codegen difference**: the instruction stream is already
retail's (that is why the gate says PASS). What differs is *where cc1 put the merge
LABEL* relative to one instruction that the branch path does not need — a copy the
branch's own delay slot already performed, a redundant reload, a re-store. Retail's
label sits on one side of it, ours on the other, so the two branch **words** differ.
The w64-a7 `_padIntRecvHdr` precedent generalises: **the label is a movable line**
(15-series), and `PER_FN_TEXT_MOVES` moves lines.

Two directions occur, and the fix is symmetric:

* **retail's label is LATER** (ours targets a copy retail skips) — rows 2, 4, 5, 6, 7,
  9, 10, 11: move the label DOWN, past the copy;
* **retail's label is EARLIER** (retail re-executes a redundant reload that ours skips)
  — rows 3 and 8: move the label UP, in front of the load.

Both are semantics-neutral *by construction*: the moved line is a copy/reload whose
value is already live on the branch path (verified per row against the oracle) — **except**
row 11, where our build had genuinely lost an instruction from the branch path (§3).

### 1.1 A maspsx behaviour worth banking (row 9's enabler)

`maspsx/__init__.py::_handle_nop_before_next_instruction` emits any label it finds
**before** the load-delay `nop` it inserts (`if is_label(label): res.append(label);
self.skip_instructions = 1`). For row 9 that is exactly what retail wants — retail's
`.L800AAE34` *is* the nop — so moving the label to just after the `lw` lands it on the
nop, and no extra nop appears. For row 13 the same rule is what makes the row
*unreachable* (§4.1). Same law, opposite sign; check which side you are on before
writing an anchor.

---

## 2. GATES (every row, both directions)

Protocol per row: baseline `tools/tugate.py` → probe `pr.py brd` → probe `pr.py tu` →
repeat → `objdump -d -z` the produced object and read the branch word (15D). Anchors
are `$L`-number agnostic (a TU reorder renumbers every `$L`) and pinned by lookahead/
lookbehind on real instruction text; each was uniqueness-counted against the emitted
`.s` region before probing.

| TU | tugate before | tugate after (2×) | brdist after (2×) | objdump proof |
|---|---|---|---|---|
| MCXMAIN.c | 5/5 | 5/5 | 0 | `beqz` 0x41c → 0x4a8 (`lui`), the `move a0,s1` at 0x4a4 still present |
| streamhelp.c | 5/6 (`data_ready_callback` FAIL 9) | 5/6 | 0 | — |
| screencarselect.cpp | 59/59 | 59/59 | 1 (`DrawBackground__25…`, whole-block, not mine) | `beqz` 0x2b48 → 0x2b84 (`jal`), `addiu s0,s2,772` at 0x2b80 still present |
| screencongrats.cpp | 28/28 | 28/28 | 0 | `j` 0x1518 → 0x1560 (`lui`), `sw zero,108(s2)` at 0x155c still present |
| aiphysic.cpp | 41/42 (`OutOfControlPhysics` FAIL 5) | 41/42 | 0 | `beq` 0x724 → 0x73c (`lw ra`), `move v0,s0` at 0x738 still present |
| audiotrk.cpp | 6/6 | 6/6 | 0 | `j` 0x5a8 → 0x5dc (`lbu v1,20(s4)`) |
| physics.cpp | 21/22 (`Physics_Real` FAIL 4) | 21/22 | 0 | `j` 0x264c → 0x276c (the nop), exactly one nop emitted |
| weather.cpp | 24/25 (`DoWeather` FAIL 4) | 24/25 | 0 | `j` 0x4d8 → 0x504 (`lw v0,0(a0)`) |
| camera.cpp | 37/38 (`SplineCam` FAIL 13) | 37/38 | 1 (`SplineCam`, class a) | `bgez` word **0x04610002 == retail's** |
| aistate.cpp (source) | 52/52 | 52/52 | 0 | — |

`tools/tu_order_audit.py`: **508 objects, 0 inversions** (after the aistate landing).

**Production lane** (`tools/psyqproof.py`, EA code):
`CheckIfCarIsNearbyAndStop` REAL=0 RELOP=0 (109 w) · `AudioTrk_AddCustomObject` REAL=0
RELOP=0 (413 w) · `Physics_CalculateCarAcceleration` REAL=0 RELOP=0 (710 w) ·
`Weather_ChangeDensityBasedOnTime` REAL=0 RELOP=0 (54 w, -G8) · `CalculatePrizes`
REAL=0 RELOP=0 (144 w, -G0) · `AIPhysic_CalcAcceleration` REAL=**2** ·
`Camera_UpdateHeliCam` REAL=**172** RELOP=25.
🔑 The two non-zero rows are **pre-existing and unrelated to these rows**: PsyQ-lane
psyqproof compiles from the `.i` with `psq43 CC1PSX`+`ASPSX`, so no `PER_FN_TEXT_MOVES`
row (mine or the wired ones) reaches it. Both fns already carry wired maspsx-lane
splices with no production counterpart — the "shim-masked class (14A)" their own
in-source receipts name. AIPhysic's REAL=2 is literally the two words the wired w59-a3
copy+slot row synthesises (`10a20004` vs `10a20005`, `nop` vs `02001021`).
Note the corollary: for AudioTrk/Physics/Weather/CalculatePrizes the **production lane
was already emitting retail's branch word** — only the maspsx testing lane was wrong.

---

## 3. 🔴 TWO REAL BEHAVIOURAL BUGS FOUND BEHIND A GREEN GATE

The reconciliation doc predicted the whole-block rows would hide behavioural bugs.
They were in the ±1 belt.

### 3.1 `aistate.cpp CheckIfCarIsNearbyAndStop` — LANDED (`e3231dd9`)

Retail `blez $s0` @0x80071A0C = word `0F00001A` → offset 0x000F → `.L80071A4C`, the
**epilogue**. `.L80071A48` (`sw $zero,0x0($s3)`) is reached **only** by the
`0xC0000 < distance` guard's `bnez` @0x80071930. So retail leaves `*status`
**untouched** on the `sum <= 0` path. The recon had `if (sum <= 0) goto LAB_STATUS0;`
— added by a w13-a5 note that claimed "oracle stores *status = 0 on the sum<=0 path
(blez -> sw zero)". That reading is backwards: the `blez` lands one word *past* that
store. Every caller (`Execute`'s two call sites) reads `status` afterwards, so the
recon was overwriting a live 1/2 with 0.

Fix: `if (sum <= 0) return;` — the word stream is unchanged (the store is still there
for the guard path), the branch word becomes retail's, and the behaviour is retail's.
Receipt written in-source **replacing** the wrong w13-a5 note so nobody re-adds it.

### 3.2 `camera.cpp Camera_UpdateHeliCam` — a WIRED build.py row makes the object wrong

Wired row 4 of the w63-a11 `PER_FN_TEXT_MOVES` block for this fn:

```
{"take": "\\tbgez\\t\\$3,\\$L\\d+\\n(?=\\tslt\\t\\$2,\\$3,\\$4\\n)", "after": "1:\\n\\t\\.set\\treorder\\n(?=…)",
 "drop_after": "…\\tslt\\t\\$2,\\$3,\\$4\\n\\t\\.set\\tmacro\\n\\t\\.set\\treorder\\n"}
```

It undoes reorg's **target-steal** by *deleting* the stolen `slt $2,$3,$4` copy out of
the `bgez $3` delay slot — but the branch still points at `$L702`, the label reorg
**planted past the steal**. Net effect in the shipped object:

```
ff8: bgez v1, 1008      <- z >= 0 : jumps past BOTH insns
ffc: nop
1000: negu v1,v1
1004: slt  v0,v1,a0     <- the |z| < |x| test -- NEVER EXECUTED on the z>=0 path
1008: beqz v0, ...      <- tests a STALE $v0
```

Retail's word is `bgez $v1, .L80081610` = **0x04610002**, landing **on the `slt`**.
So the heli-cam fallback picks the wrong arm (`fallback = ax + (z>>2)` vs
`z + (ax>>2)`) whenever `z >= 0` — i.e. half the time.

The fn's own in-source receipt predicted exactly this hazard ("PER_FN_TEXT_MOVES …
cannot change a branch TARGET"), and w63-a11 landed the half that it *can* do. The
label move is the missing half: put `$L702` in front of the `slt` and our `bgez` word
becomes 0x04610002, byte-identical to retail (objdump-verified). Gate 37/38 unchanged,
brdist row gone.

**This is the highest-priority orchestrator action in this report** — it is a live
correctness defect in the build, not a fidelity nicety.

**Standing lesson for the catalog:** any `PER_FN_TEXT_MOVES` row whose `take` is a
BRANCH line, or whose `drop_after` removes an insn out of a delay slot, must be paired
with a `brdist` run — deleting a stolen slot copy without re-pointing the branch is
silently semantics-changing and the gate cannot see it.

---

## 4. THE 5 ROWS NOT CLOSED — mechanisms, receipts, named angles

### 4.1 `FntPrint` (10,8,9) — a maspsx LAW, not a source or spec question

Site: `addu $19,$19,1 / lb $4,0($19) / $L115: / addu $2,$4,-48`. maspsx inserts the
load-delay nop and, per `_handle_nop_before_next_instruction`, emits `$L115:`
**before** it → our label is on the nop (idx 88); retail's `.L800F7198` is on the
`addiu` after it (idx 89), i.e. aspsx put the nop in the fall-through only.

FALSIFIED, both measured:
1. **Move a spare `#nop` in front of the label** (take the `#nop` at the other
   `lb $4,0($19)` site, which maspsx re-inserts anyway; anchors uniqueness-checked 1/1).
   → `{standard input}:422: Error: symbol '$L115' is already defined`. maspsx's
   `skip_instructions = 1` consumes the `#nop`, then the real label line is emitted a
   second time. maspsx output captured verbatim: `$L115:` / `nop # DEBUG: Reuse of '$4'`
   / `# #nop  # DEBUG: skipped` / `$L115:`.
2. **`slot: True` wrapping `lb` + label in `.set noreorder`** → assembles, `FntPrint`
   still PASS 240/240, brdist **unchanged (10,8,9)**: maspsx reads `.set` lines with
   `ignore_set=True`, so the hoist fires regardless. (First attempt of this variant was
   a no-op because the `after` lookahead still referenced the label that `take` had just
   removed — anchors must be written against the POST-REMOVAL text; noted, then fixed,
   then re-measured.)

**NAMED ANGLE (orchestrator/toolchain):** a maspsx option — or an entry in the existing
`tools/maspsx-*.patch` set — that emits an inserted load-delay nop **before** a
following label instead of after it. It is a 3-line change in
`_handle_nop_before_next_instruction`, it cannot change any instruction stream (only
which address a label denotes), and it is likely to close several rows at once; it must
be swept with `brdist` over all 461 units because it moves labels *tree-wide*.

### 4.2 The RETARGET class — 4 rows that need a mechanism build.py does not have

`_dirSendAuto` (1,32,33) · `MemCardWriteData_cb` (6,53,52) ·
`DrawBackground__11tScreenMain` (9,11,12) · `Hud_BuildString__FPciiiib` (2,154,155).

In each, retail's `.s` carries **two labels one word apart** and sends *different*
branches to each, while cc1 emitted **one** label that all of them share:

* `_dirSendAuto`: retail `.L8010A194`(44, `addu $a0,$s0,$zero`) **and** `.L8010A198`(45,
  `jal _padCmdParaMode`). The `beq` at 12 goes to 45 (its path already has `$a0==$s0`);
  the `beq` at 33 goes to 44 (a `jalr` on its path clobbered `$a0`). Ours has only `$L5`
  at 44 — moving it fixes branch 12 and **breaks** branch 33.
* `DrawBackground__11tScreenMain`: retail `.L80037B44`(97, `lui %hi(FEApp)`) and
  `.L80037B48`(98). The `bne`'s own delay slot is that `lui`, so retail skips it; the
  neighbouring `beq` (delay slot `move $4,$22`) needs it. Ours has one `$L662` at 97.
  This is reorg's **steal-from-target + `emit_label_before` redirect** — the same
  mechanism as camera §3.2, but here retail did it and we did not.
* `Hud_BuildString`: our `$L718` (idx 194) has **4** branch users; exactly one of them
  (`j`, idx 40) needs retail's `.L800D45D4` at 195. Moving the label would break the
  other three (they match retail today).
* `MemCardWriteData_cb`: inverse — *our* cc1 threaded. cc1 emitted `j $L122`
  (epilogue, 74) for the `case 0:` arm because the `beq $3,$0,$L105` delay slot
  `addu $2,$0,$0` already zeroed `$v0`; retail keeps `j .L800FB430` (73, the shared
  `$v0 = 0`). Semantically identical (both return 0 — the delay slot runs on both
  paths). `$L122` has 5 users, only this one wants 73.
  FALSIFIED: `-fno-thread-jumps` — first via `PER_FN_NO_THREAD_JUMPS` (**no effect**:
  LIBMCRD.c is a `cc1_272`-lane TU and that table is only consulted in the default 2.8
  lane), then correctly via `PER_FN_FLAG_SPLICE_272 {"-fno-thread-jumps": …}`, which
  **regressed** it: gate FAIL 3 (ours 80 / oracle 79) and brdist 1 → 4 rows
  `(0,45,44) (2,9,8) (3,62,61) (6,53,52)`.

**NAMED ANGLE (orchestrator):** a new per-fn mechanism, the natural sibling of
`PER_FN_TEXT_MOVES` and mechanically about as small:

```python
PER_FN_BRANCH_RETARGET = {
  "<rel>": {"<fn>": [
      # plant a FRESH label immediately after the line matched by `after`,
      # then re-point the single branch matched by `branch` at it.
      {"branch": r"\tbeq\t\$3,\$0,\$L\d+\n", "after": r"\taddu\t\$4,\$16,\$0\n"},
  ]},
}
```
Implementation sketch: allocate a unique name (`$Lw65_<n>`, same uniquifier the
splices already use), insert `"%s:\n" % name` after the `after` match, and
`re.sub` the `\$L\d+` operand of the *single* `branch` match to it — assert exactly
one match for each, exactly as `_apply_text_moves` does. That closes all four rows
above and, per its own receipt, is the mechanism `Camera_UpdateHeliCam`'s w62-a11
analysis already asked for ("a TEXT_MOVES extension with a label-relocation key").
It is strictly safer than the existing `drop_after`, because it never removes an
instruction.

---

## 5. FILES

`SPEC_text_moves_w65a2_ALL.json` — the 8 rows to wire (per-row `_note` = the full
rationale + measurements; strip `_`-keys when pasting).
`PROBE_final_list.json` — FINAL per-fn row list (wired + new) for `pr.py`.
`pr.py` — probe harness: `pr.py {gate|tu|brd} <TU> [fns]` with `$W65_SPEC` =
`{text_moves|text_moves_replace|no_thread_jumps|flag_splice_272|…}`; injects into
build.py **in memory**, reuses `verify_asm`/`tugate`/`brdist` sources verbatim (12H
anti-drift).
`tgt.py` — for brdist row N of a fn, prints the branch site plus BOTH target sites
(ours + oracle) side by side; this is the tool that made every classification above a
30-second read.
`dump2.py`, `brshow.py` — index-aligned ours/oracle dumps.
`bak/aistate.cpp.base` — pre-edit backup.
`tm_*.json`, `spec_*.json` — the per-row probe specs, kept as evidence.
