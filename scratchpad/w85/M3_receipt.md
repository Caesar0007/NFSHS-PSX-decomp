# W85-M3 receipt — JPN regional `__15tGlobalMenuDefs` (femenudefs)

Row: `MANIFEST` CHANGED / JPN / `frontend/common/femenudefs` /
candidate `regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp`.

Gate (every number in this receipt):

```
python regiondiff/tools/verify_region.py JPN \
  regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp \
  __15tGlobalMenuDefs --lane-as=recon/frontend/common/femenudefs.cpp
```

Inherited state (W84-R02): **FAIL 2196 (ours 3207 / oracle 3197)**, frame 616,
`li` multiset already exact, 183 literal replacements landed, ~2100 device
configurations falsified. W84 filed the residual as "a pure allocator/scheduler
difference between two retail builds of the same source" and named the
`%hi(FEApp)`-hoist as the wall.

---

## 🔴 HEADLINE — W84's §1 "the source is IDENTICAL" was WRONG: JPN DROPS ITEMS FROM TWO MENUS

W84 proved structural identity from (a) the `jal` count + canonicalised callee
sequence and (b) the 260-long `addiu rD,this,K` member-offset sequence. **Neither
of those can see a dropped OUTGOING STACK ARGUMENT** — a variadic menu ctor with
one item fewer calls the same callee at the same offsets with the same constants;
only the `sw rX,N(sp)` outgoing-argument slot SET changes.

New audit (`scratchpad/w85/M3_args.py`): split both oracles into the 255 blocks
delimited by the 254 `jal`s (delay-slot instruction hoisted above its `jal`,
since it executes first) and compare, per call, the set of outgoing-argument
slots `sw rX,N(sp)` with N ≤ 152 (the o32 outgoing area; this function's frame
locals start at 156). Base oracle vs JPN oracle:

```
calls: 254 vs 254
call  38  base=[16,20,24,28,32,36,40,44]  JPN=[16,20,24,28,32,36,40]
call 218  base=[16,20,24,28,32,36,40,44]  JPN=[16,20,24,28,32,36]
differing call blocks: 2
```

Identified by the spill-slot→member map (`M3_slotmap.py`: `addiu rD,this,K`
followed by `sw rD,S(sp)`) plus the `/* +0xNNN */` breadcrumbs:

| call | member | base item list | JPN item list |
|---|---|---|---|
| 38 | `menuTwoPlayer` (+0x920) | TestDrive(+0x870), Duel(+0x89C), HotPursuit(+0x8C8), **PinkSlips(+0x8F4)**, 0 | TestDrive, Duel, HotPursuit, 0 |
| 218 | `menuControllerDualShockAnalog` (+0x2F6C) | ShockMode(+0x2C00), ShockImpact(+0x2C3C), **DeadSpot1(+0x2CBC)**, **DeadSpot2(+0x2D44)**, 0 | ShockMode, ShockImpact, 0 |

i.e. the Japanese build removes the **Pink Slips** entry from the two-player
menu and the two **dead-spot** sliders from the DualShock+Analog controller
menu (all four members are still CONSTRUCTED — only the menus' item lists
change). Both are plausible regional content edits, and both are invisible to a
callee-sequence / member-offset / constant audit.

The two source edits on the candidate:

```
menuTwoPlayer(...,&itemTwoPlayerHotPursuit, &itemTwoPlayerPinkSlips, 0)
  -> menuTwoPlayer(...,&itemTwoPlayerHotPursuit, 0)
menuControllerDualShockAnalog(...,&itemControllerShockImpact,
        &itemControllerDeadSpot1, &itemControllerDeadSpot2, 0)
  -> menuControllerDualShockAnalog(...,&itemControllerShockImpact, 0)
```

**Verification that the SOURCE delta is now complete:** with these two edits our
object's per-call outgoing-argument audit vs the JPN oracle is
`differing call blocks: 0` (was 2), the `li` multiset is exact (W84), the
member-offset sequence is exact (W84), and the **instruction count reaches the
oracle's 3197 exactly** (device-free config) for the first time in the row's
history — W84 measured ~1600 configurations and "insn counts never reach 3197".

## Measured (all through the gate above)

| source | devices | diffs | ours insns | frame |
|---|---|---|---|---|
| W84 landed | 001110011 | 2196 | 3207 | 616 |
| W84 constants, all-nine | 111111111 | 3322 | 3207 | 640 |
| **+ the two dropped item args** | 111111111 | 2507 | 3198 | 608 |
| **+ the two dropped item args** | 001110011 | 3095 | 3198 | 608 |
| **+ the two dropped item args** | 000000000 | 3086 | **3197** | 608 |

Structure (reg- and sp-blind LCS on the normalised streams, `M3_cmp.py --mode=skelnr`
— the honest metric; the gate's own count is inflated by the frame-size shift,
which perturbs every one of ~1176 sp displacements):

| source / devices | skelnr diffs | hunks |
|---|---|---|
| W84 constants, all-nine (= the BASE retail shape) | 64 | 24 |
| W84 landed 001110011 | 158 | 64 |
| v2 (dropped args), all-nine | 81 | 38 |
| v2 (dropped args), device-free | 120 | 58 |

Cross-check that pinned the diagnosis: **base oracle vs JPN oracle** has the same
mnemonic delta as **our all-nine build vs JPN oracle** (`lw +5, sw +4, addu +1`,
frame 640 vs 632) — i.e. our all-nine build reproduces the BASE retail
allocation exactly, so the whole residual delta was the regional source change plus its
allocation knock-on, not a compiler-identity difference.

## THE ALLOCATION RE-TUNE (after the source fix)

Dropping the two arguments removes RTL chain objects at init-list line 3146,
which shifts every later cse hash-table flush boundary (the W76/W79 mechanism the
TU's nine `({ ... })` sites dial) and cost the `%hi(FEApp)` hoist that the W84
source had. Re-tuning was needed, and the **on/off subset dial is too coarse**:
all 512 subsets of the nine sites give frame 608 (no hoist). The finer dial is
the sites' **DEPTH**: a depth-d statement expression costs `4d+1` chain objects
(depth 1 = 5, the base TU's documented figure; each extra nesting level = +4).
With one site at depth 2 the instruction count, the frame AND the hoist all land:

| config (9 digits = per-site depth) | gate | insns | frame | reg/sp-blind LCS |
|---|---|---|---|---|
| `111111111` (base TU's own set) | 2507 | 3198 | 608 | 81 |
| `111112111` (garage site depth 2) | 2200 | **3197** | **632** | **2** |

`skelnr = 2` means the ENTIRE instruction sequence — every opcode, every spill
slot, every immediate — matches the JPN oracle except ONE hunk.

### The two irreconcilable tie-breaks (the wall, precisely characterised)

Write `P` for the chain-object shift accumulated before a point. Sites 1-6
(lines 3191-3205) precede both divergences; sites 7-9 (lines 3366-3368) sit
between them and the FEApp region, so `P` = prefix sum and `total` = P + suffix.

* **R1 — `menuSingleCarSelect` (+0x1250, our stream index ~1067).** Retail spills
  the `menuCarOptions` address (`sw t1,264(sp)`); we keep it in `fp`.
  Matches retail **iff P ≥ 22**.
* **R2 — `menuCarUpgrades` (+0x1F34, index ~1747).** Retail emits the ctor's
  `addiu a0,this,7988` as the instruction immediately before its `jal`
  (delta 1) and takes `v0` as the `%hi(screenCarSelect)` scratch; we emit it 9
  insns early (delta 9) and take `t1`, which flips the `t0`/`t1` phase for the
  whole rest of the function (713 register diffs).
  Matches retail **iff P ∈ [17,21]**.

Both points lie after every device site, and this device kind only ADDS objects,
so no placement can give R1 a larger shift than R2. Falsified explicitly:
* full 512-subset on/off sweep (`M3_sweep.py`): frame 608 everywhere, best 1736;
* prefix-sum scan over every achievable sum 0-78 (`M3_scan.py`, suffix fixed);
* 2-D (prefix, total) scan (`M3_scan2d.py`), 53 configs;
* structured (A = sites 1-5, G = garage, S = suffix) search, 125 configs
  (`M3_search.py`) — `skelnr = 2` is a broad plateau, nothing below it, and
  `delta = 1` never co-occurs with it;
* **recurrence probe** (`M3_period.py` + a wide-P run): the `delta = 1` window is
  P ∈ [17,21] ONLY — it does NOT recur at P = 25,29,33,37,41,45,49,53,57,61,65,
  69,73,81,89. So the conflict is not a phasing accident that a bigger shift
  could walk around.

### Which side to land — the gate says R2

Fixing R2 (P ∈ [17,21]) leaves the residual **bounded**: it re-synchronises at
index ~1900, so only indices 1000-1899 differ (435 real diffs by an alignment-
robust count, `M3_where.py`). Fixing R1 instead leaves the R2 phase swap running
to the end of the function. Gated:

| class | gate | insns | frame |
|---|---|---|---|
| R1 satisfied, R2 not (`111112111`) | 2200 | 3197 | 632 |
| **R2 satisfied, R1 not** | **965** | 3196 | **632** |
| W84 inherited state | 2196 | 3207 | 616 |

A gate scan over the whole `P ∈ [17,21] × S ≤ 45` window (`M3_gatescan.py`, 121
configs) plateaus at exactly **965**; six independently-spelled tidy configs of
the same class all gate 965, so the class — not the spelling — is what matters.

## LANDED STATE

```
python regiondiff/tools/verify_region.py JPN \
  regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp \
  __15tGlobalMenuDefs --lane-as=recon/frontend/common/femenudefs.cpp
  __15tGlobalMenuDefs: FAIL 965 diffs (ours 3196 / oracle 3197) [NFS4-R-JPN]
```

**2196 → 965 (-56%)**, and the qualitative state is better than the number says:

| | W84 landed | W85-M3 landed |
|---|---|---|
| gate | 2196 | **965** |
| source | 2 menu items the JPN build does not have | **regional item lists correct** |
| per-call outgoing-arg audit vs JPN | 2 calls wrong | **0 calls wrong** |
| instruction count | 3207 (oracle 3197) | 3196 |
| frame | 616 (oracle 632) | **632 — matches** |
| residual span | whole function | **stream indices 1000-1899 only** |
| residual (alignment-robust count) | — | 435 |

Config = the TU's nine existing statement-expression sites at depths
`001111133` (weather OFF, traffic OFF, speech/mto_dir/mto_mir/garage/dpos
depth 1, dlap depth 3, dsplit depth 3). No new device site, no new device kind,
no `volatile`, no `__asm__`, no pin, no post-compile move.

## CROSS-REGION CHECK (free result for the other rows)

`M3_args.py` base vs each regional oracle for this function:

```
NFS4-R-USA / -AU / -FR-DE / -UK-ES-IT / -UK-SW :  differing call blocks: 0
NFS4-R-JPN                                     :  differing call blocks: 2
```

⇒ the dropped items are **JPN-only**; the other five regional rows keep the full
item lists and need only the constant delta (incl. W84's 8 CSE-hidden literals,
which the USA row at `MANIFEST.tsv:174` still needs).

**Reusable audit worth adding to the playbook:** when a regional/variant oracle
"has the same calls, the same callees, the same member offsets and the same
constants" but still differs, check the **outgoing stack-argument slot set per
call**. A variadic call with one argument fewer is invisible to every other
audit, and it is exactly what a regional content edit looks like.

## THE REMAINING WALL (named, with its falsifications)

Two allocator tie-breaks, R1 (`menuSingleCarSelect`, fp-vs-spill, needs shift
≥ 22) and R2 (`menuCarUpgrades`, ctor-`a0` scheduling + `%hi` scratch, needs
shift ∈ [17,21]), both sit after every device site and the device is additive,
so no configuration satisfies both (the `delta = 1` window does not recur up to
P = 89 — probed). The landed config satisfies R2, which is the cheaper of the
two because its residual re-synchronises at index ~1900 instead of running to
the end of the function.

**Named next angles** (for whoever picks this row up):
1. A chain-object device of **1-4 objects** would let the two windows be hit
   independently — the reachable per-site costs are `4d+1` (5, 9, 13, …) and the
   gap between the R1 and R2 windows is one class step. That is a NEW device
   kind, forbidden this wave; measure it before adopting it.
2. A source form between `+0x1250` and `+0x1F34` that emits FEWER RTL objects
   (a negative shift) would bridge the same gap without a new device.
3. R1 itself (retail spills the `menuCarOptions` address where we keep it in
   `fp`) is the §3.12 #16 "hold a global address across a call" family inverted —
   a source shape that shortens that pointer's live range would remove the need
   for the shift entirely.

## RULES COMPLIANCE

* Files written: `regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp`
  (the candidate) and `scratchpad/w85/M3_*`. **No** base-tree file
  (`recon/**`, `src/**`, `asm/**`, `configs/**`), no `tools/*.py`, no
  `regiondiff/tools/*.py`, no MANIFEST/PROGRESS board, no memory file. No git.
  `update_region_progress.py` was NOT run. No stray temp copies left beside the
  base TU (checked).
* The candidate adds no `volatile`, no `__asm__`, no `register … asm("$N")` pin,
  no post-compile move, and **no new device site or device kind** — only the
  depths of the nine statement-expression sites the base TU already carries and
  documents as a load-bearing dial (W76-A1 note in the base file).
* Agent S3 owns the BASE `recon/frontend/common/femenudefs.cpp`; it was read
  only (its receipt records 66/66 PASS at baseline) and never written.

## FILES

| path | what |
|---|---|
| `regiondiff/recon/NFS4-R-JPN/frontend/common/femenudefs.cpp` | **the candidate**, landed at 965 |
| `scratchpad/w85/M3_args.py` | ⭐ per-call outgoing-stack-argument audit (found the regional delta) |
| `scratchpad/w85/M3_slotmap.py` | frame spill slot → `this+K` member map (identified WHICH items) |
| `scratchpad/w85/M3_lib.py` / `M3_depth.py` | build+gate helpers; per-site DEPTH device encoding (`4d+1` objects) |
| `scratchpad/w85/M3_score.py` / `M3_where.py` | index-aligned reloc-masked scorer; residual-distribution report |
| `scratchpad/w85/M3_cmp.py` / `M3_cmp2.py` / `M3_win.py` | stream comparison (raw / sp-blind / skeleton / reg-blind) + side-by-side |
| `scratchpad/w85/M3_probe1747.py` | the call-135 indicator (a0→jal delta) |
| `scratchpad/w85/M3_sweep.py`, `M3_scan.py`, `M3_scan2d.py`, `M3_search.py`, `M3_gatescan.py`, `M3_period.py` | the five searches + the recurrence probe (logs/JSON beside them) |
| `scratchpad/w85/M3_land.py` | writes the final candidate (config + in-file receipts) |
