# W61-A7 receipts — belt: `recon/syslib/psx/libcd/**` (drv / cdread / toc / cdcont)

Gate: `python tools/verify_asm.py` + `tools/tugate.py`, lanes exactly as wired in
`tools/build.py` (drv.c/toc.c/cdcont.c = cc1_272, cdread.c = default + the per-fn
2.8.1 version splice + the per-fn `-mno-split-addresses` splice for CdRead).
Every number below was re-gated by me. `iso9660.c` never opened.

---

## 0. BASELINE (my own, re-gated at wave start) → FINAL

| TU | baseline | final |
|---|---|---|
| cdcont.c | 18/19 · CdControl **4** | unchanged |
| cdread.c | 3/6 · _read_int 15, _read_issue 22, CdRead **38** | 3/6 · _read_int 15, _read_issue 22, **CdRead 23** |
| drv.c | 8/13 · CD_datasync 8, CD_ready 8, CD_sync 8, CD_init_80108140 10, CD_cw **84** | 8/13 · same four, **CD_cw 75** |
| toc.c | 1/2 · CdGetToc2 **56** | 1/2 · **CdGetToc2 4** (count EXACT 137/137) |
| stcdint.c | 1/3 · _st_dma 25, StCdInterrupt 36 | unchanged (probed only) |
| streamhelp.c | 5/6 · data_ready_callback 9 | unchanged |
| TYPE / cddebug / cdread2 / cdtables / event / stream | all PASS | unchanged |

Belt FAIL total **323 → 247 (−76)**.  **ZERO PASS→FAIL** anywhere; every TU gated
twice; `tools/tu_order_audit.py` = **0 inversions** after every commit.

Commits: `libcd/drv.c: CD_cw 84 -> 75 …` · `libcd/toc.c: CdGetToc2 56 -> 4 …` ·
`libcd/cdread.c: CdRead 38 -> 23 …`.

---

## 1. `CdGetToc2` 56 → 4, count EXACT 137/137 (toc.c)

The briefing's named angle was "the FULL Rage Racer body + the $s5 magic fence as a
JOINT cell".  The joint cell is real but only **one third** of the RR body is
load-bearing, and two dials nobody had swept did the rest.

| step | lever | result |
|---|---|---|
| a | **the magic local's ASSIGNMENT position** (w60-a4 swept only the FENCE position): `magic = 0x66666667;` as the first statement of the function puts its `lui/ori` in the block that ENDS with the loop-entry test, so sched1 feeds the halves into that block's load-delay nops and the pair straddles the branch. Moving the assignment down to just before the loop puts it in the preheader. | 56 → **40**, count becomes EXACT 137/137 |
| b | **RR's guarded do-while** (`if (first <= last) { magic = …; do {…} while (first <= last); }`) — makes the preheader a real basic block, so `i = 1` lands in retail's `bnez` DELAY SLOT and the two magic halves stay together after the branch | 10 → **4** |
| c | **a reqdelta272-PRICED +2-ref dial on `track_first`** (see below) | 40 → **10** |

### 1.1 The dial that did the heavy lifting (the wave's transferable result)

`tools/qty272.py` on the 40-diff basin showed the two rivals:

```
rank pseudo refs live pri     home
  2    169    11   30  1.1000  $s0     <- the loop cursor  (retail: $s1)
  3     74    15   60  0.7500  $s1     <- track_first      (retail: $s0)
```

`python tools/reqdelta272.py … --flip 74 169` printed, without any guessing:

```
to put the mover FIRST: refs 15->17 (+2, CROSSES a floor_log2 step)  OR  live 60->40
```

Adding `track_first` as a **second operand of the already-present in-loop read-only
fence** buys exactly +2 (in-loop ⇒ ×2 loop depth) → 40 → 10, and the whole 14-diff
two-register swap resolves.  The two rivals do **not** conflict, so `track_first`
then shares `$s0` with the by-then-dead result-buffer pointer and the cursor is
pushed to `$s1` — retail's handout register for register.

**LAW (new, transferable):** on the 272 lane a uniform 2-register swap whose rivals
are GLOBAL allocnos is a *priced* dial now — run `qty272` → `reqdelta272 --flip` →
buy the printed refs with fence operands.  Two independent instances landed this
wave (this one and CdRead below); in both the printed requirement was exact.

### 1.2 Residual 4, mechanism named
The hoisted `$s5` magic is not SHARED with the division's own expansion: we emit
`lui v0,26214; ori v0,v0,26215; mult s0,v0` inside the loop where retail has the bare
`mult s0,s5`.  The fenced `magic` pseudo is set in the PREHEADER block and the
division's constant is loaded in the LOOP-BODY block; gcc-2.7.2's cse works per
extended basic block and the loop body has several predecessors, so cse never learns
that the live `$s5` already holds the constant — and loop.c does not hoist the
division's own const load.  Proof: dropping the magic local entirely gives **18 diffs
at 135 insns** (no hoist at all, and the frame loses a callee-saved register).
FALSIFIED for the sharing, all INERT at 4 @139: fence moved after the division;
`track_first / 10` spelled twice; a split `tens = track_first / 10;` statement.
FALSIFIED and WORSE: the explicit multiply-high `(int)(((long long)track_first *
magic) >> 32)` = **73 @140** — 2.7.2 expands the DImode form as a FULL 64-bit
multiply (`mfhi` AND `mflo` + an extra shift pair), not the `smulsi3_highpart`
retail uses, so the §14b "reconstruct the magic literally" recipe does NOT apply on
this compiler.
**NEXT ANGLE:** make loop.c hoist the DIVISION's own const load (retail's actual
mechanism) — a `-dL` loop-dump job on the lane binary (W60-A1 proved CC1PSX takes it).

---

## 2. `CD_cw` 84 → 75 (drv.c) — the 8th callee-saved register found

The named gap was "72-byte/7-reg frame vs retail 56/8".  The missing register is the
**command-name table base**: retail hoists `CD_comstr` into the loop PREHEADER
(`lui s5; addiu s5` right after the loop-entry test) and therefore carries EIGHT
callee-saved registers.  CD_cw was the ONLY caller of the shared `get_alarm()`, whose
single `CD_comstr[CD_com]` use gives cse no common subexpression, so no invariant
pseudo exists to hoist and the base is re-materialized inside the arg block.

Three cooperating pieces (the alarm inlined privately, exactly like CD_sync/CD_ready):
1. a `cmdNames` local (the hoist);
2. the `syncIdx` / `readyName` split locals — **falsified against the SHARED
   get_alarm() in w53-a9 (90→93), they land once the copy is private to CD_cw**;
3. the `alarm` VARIABLE + `if (alarm != 0) return -1;` funnel instead of a direct
   `return -1` — that is retail's extra `addu v0,zero,zero; bnez v0` pair.

Plus the **non-volatile alias read** on the tail test (`*(const unsigned char *)&Intr.sync
== 5`, the CD_get_intr lever-3 device) which drops the redundant `andi v0,v0,255`.

Measured ladder: inline+cmdNames 120 · +identity fence on cmdNames 112 · +alarm funnel
79 · +alias read 77 · **fence REMOVED 75** (the fence materializes the `la` before the
loop ENTRY test = `$s3`, instead of in the preheader = `$s5`, and rotates the whole
s3/s4/s5 band — it is a NET LOSS once the structure is right).
FALSIFIED in this basin: explicit `statusNames` local **79** · `cmdNames = CD_comstr`
moved to the last preamble statement **75 (inert)** · identity fence on `ip` **94** ·
separate loop counter `j` for the parameter loop **93** · dropping the store-flag
breaker **86**.

### 2.1 RESIDUAL 75, three named clusters (ours 258 / oracle 259)
* **20 diffs = the frame, and it is NOT a register-count problem any more.**  We now
  save the same EIGHT registers retail saves; the frame is still 72 vs 56 because
  cc1 reports `vars= 16` where retail's is 0 (`.frame $sp,72,$31 # vars= 16, regs= 8/0,
  args= 24`; CD_sync/CD_ready are `vars= 0, regs= 10/0, args= 24`).  **ROOT CAUSE
  LOCATED (new, precise):** the `-dg`/`-dl` dumps show TWO pseudos that are *used but
  never set* — bare `(insn N (use (reg:SI 115)))` and `(use (reg:SI 206))`, both
  reported by the dump as `ST_REGS or none` (i.e. no allocatable class) and both in
  `SPILLED:` — reload gives each an 8-byte-aligned stack slot = the 16 bytes.  They are
  NOT from any `__asm__` in the function (removing the store-flag breaker leaves
  `vars= 16`), they sit immediately before `ip = &Intr` and before `CDREG0 = 0`, i.e.
  right after the two `for` loops' join points, and a separate counter for the second
  loop does not remove them.  **NEXT ANGLE:** identify which gcc-2.7.2 pass emits a
  dangling `(use (reg))` there (loop.c's `move_movables` is the prime suspect — the
  insn numbers are post-loop, and drv.c compiles `-fno-strength-reduce`) and remove its
  cause; killing those two pseudos is worth 20 diffs at once.
* **~8 diffs = preamble scheduling**: retail issues the `lbu` of `Intr.sync` (the loop
  test) BEFORE materializing the `"CD_cw"` string and puts the `cmdNames` `la` after the
  entry branch; ours does the reverse.  Pure line order in ONE basic block ⇒ a
  `PER_FN_TEXT_MOVES` candidate if a source dial is not found.
* **5 diffs = the guarded `Intr.ready = 0` store**: retail reuses the materialized base
  (`sb zero,1(a1)`), ours emits the assembler macro (`lui at; sb zero,0(at)`, +1 insn)
  because the guarded store is in another basic block and cc1 const-folds `ip` back to
  the symbol there.  The CD_flush identity-fence cure for exactly this shape is
  measured **94** here (it fixes those 2 diffs and rotates ~20 others).

### 2.2 Flag re-ladder (04Z, after the structural landing)
`no_strength_reduce` re-priced on the new basin with the whole TU: turning it OFF gives
CD_cw **119**, CD_get_intr **20** (from PASS), everything else unchanged ⇒ the wired
flag stays.

---

## 3. `CdRead` 38 → 23 (cdread.c) — the second reqdelta272 landing

`qty272` showed the mode-region anchor as global allocno 76 (refs 7 / live 12 /
pri 1.1667) and its `andi` selector temp as allocno 90 (refs 3 / live 4 / pri 0.75).
They CONFLICT, 76 is allocated first, and since both conflict with hard `$v0` the anchor
takes `$v1` and the selector is pushed to `$a0` — the exact inverse of retail.
`reqdelta272 --flip 90 76` printed `refs 3->4 (+1, CROSSES a floor_log2 step)`; naming
the selector (`sel`) and buying ONE reference with a zero-insn read-only fence flips the
order and the anchor takes `$a0` with the selector in `$v1`, exactly as retail.
**Class (a) of the w59-a7 residual is CLOSED.**

Side effect, receipted per the hard-floor-basin rule (the authoritative count improves,
so the branch is landed): with the anchor in `$a0` the three switch arms stop cross-jump
merging their `sw $v0,0x10(anchor)` tails — that IS retail's shape (09J "each arm carries
its own tail") — but reorg then leaves each arm's `j` delay slot EMPTY where retail has
the store in it, +5 insns (108 vs 103).  **The fence POSITION is not the cause:**
read-only fence after the `andi`, identity fence after the `andi`, and a read-only fence
inside the `case 0` arm before its store ALL measure **23 @108**; putting the extra ref
on the DEFAULT arm's existing identity fence instead is **INERT (38)** because the ref
also lengthens the selector's live range and cancels the priority gain.

Residual 23, named: (a′) the three arm `j` delay slots; (b) which arm's constant reorg
steals into the `beq` delay slot (retail pre-sets the DEFAULT's `li v0,0x246`, ours steals
case-0x20's `li v0,0x249`); (c) `CdControlB(9,0,0)`'s third argument (the cse-substituted
live zero — catalog 11B already records the identity fence as NOT the cure) + the
`slt v0,zero,v0` scheduling; (d) the prologue `sw s2,24(sp)` / `addu s2,a2,zero` pair
placement — the SAME sched1 tie as CdControl's, a 2-line `PER_FN_TEXT_MOVES` candidate.

---

## 4. Probed, no landing (all re-gated, so nobody re-runs them)

* **`_read_int` 15 (ours 158 / oracle 157)** — clusters: two split-address
  materializations where retail SELF-temps (`lui v1; addiu v1,v1` vs our `lui v0;
  addiu v1,v0`), and two delay-slot steal choices (retail puts a store in the `j` slot
  and `li v0,1` in a load-delay gap, ours the reverse).  **`-mno-split-addresses`
  per-fn: 47 (WORSE).  `-fno-delayed-branch` per-fn: 67 (WORSE).**
* **`_read_issue` 22 (ours 120 / oracle 122, 2 SHORT)** — retail carries two more `nop`s
  than we do (we fill delay slots retail leaves empty) plus the same
  `addu a2,a1,zero` cse-substituted live zero.  **`-mno-split-addresses` per-fn: 38
  (WORSE).  `-fno-delayed-branch` per-fn: 66 (WORSE).**
* **`CD_init_80108140` 10 (count EXACT 120/120)** — the in-source receipt asked for the
  named-result-temp family to be RE-PROBED in the post-anchor basin: `st = CD_sync(0,0);
  if (st != 2)` is **INERT (10)**.  The residual is (i) retail's un-propagated result copy
  `addu a0,v0,zero` (06E / "old-gcc no-copy-prop") and, downstream of it, (ii) which
  branch steals `li v0,-1` into its delay slot.  The A5 DEAD-PSEUDO STAGING LAW says the
  cure is to assign the result into the variable that ALREADY owns `$a0` — CD_init has no
  such variable, so this needs the carrier to be created by another structural change.
* **`CdControl` 4 (cdcont.c)** — the bounded angle taken was the allocator instrument:
  `qty272` shows the `li 1` compare constant is a **LOCAL-ALLOC qty** (blk 0, refs 2,
  live 2, `$v0`), not a global allocno, so neither `reqdelta272` nor any priority dial can
  reach it — retail's `$t0` requires the qty to conflict with `$v0,$v1,$a0-$a3`, i.e. the
  12A "hard-reg preference before the numeric scan" blocker.  Confirmed unreachable by
  the tools we have; the wanted device is 12A's zero-insn preference killer.
* **`_st_dma` 25 / `StCdInterrupt` 36 (stcdint.c)** — looked at only: `_st_dma`'s residual
  is an `a1/a2/v0` band rotation plus one statement-order move, all CALLER-saved ⇒
  local-alloc qtys ⇒ the same 12A blocker class as CdControl.  Not worked.

---

## 5. TOOLS / HAZARDS

* **`scratchpad/w61a7/vp.py`** — `tools/vprobe.py` + two extra in-memory hooks:
  `W61_NOSPLIT` (`PER_FN_NO_SPLIT_ADDRESSES`) and a GENERIC `W61_TABLE`
  (`{"<TABLE_NAME>": {rel: [fns]}}`) that updates ANY per-fn set-valued table in
  build.py — that is how the nosplit and no-delayed-branch wirings above were priced
  without touching `tools/`.  **Promotion candidate: fold `W61_TABLE` into
  `tools/vprobe.py`; it makes every future per-fn table probe a one-liner.**
* **`scratchpad/w61a7/ed.py`** — byte-level single-match replace whose OLD/NEW text comes
  from FILES (never argv, never a heredoc), asserting `count == 1` before writing and the
  exact length delta after, and printing the CRLF count before/after.  Every source edit
  this wave went through it.
* 🔴 **The 12K scripted-replace hazard fired once and was caught by `git diff --stat`:**
  an unguarded `str.replace` while REVERTING a probe rewrote the same text in
  `CD_sync` and `CD_ready` as well (`statusNames[syncIdx]` → `CD_intstr[syncIdx]`).  The
  gate did not notice (both stayed at 8).  **Reconfirmed rule: `git diff` the file after
  every scripted revert, not just after every scripted edit.**
* 🔴 **Heredoc backslash collapse fired again** (`\\n` inside a quoted `<<'PY'`): the
  assert caught it, the file was untouched.  All escape-bearing content after that went
  through the Write tool.
* **Mixed line endings**: `drv.c`/`cdread.c` are LF-only, `toc.c` is CRLF with 64 mixed
  lines; a receipt block ended `*/\r` so an LF-terminated pattern did not match.  `ed.py`
  prints the CRLF count each time; post-edit control-byte scans are clean on all three.
* **Pre-existing corruption (report, not mine to fix; a tree-wide scan says it is the ONLY
  instance):** `recon/syslib/psx/libcd/drv.c` lines 145/146 — a comment reads `C:\Temp`
  then a REAL LF then `age-racer-decomp\include\...`, i.e. the `\r` of
  `\rage-racer-decomp` was collapsed into a newline by a past heredoc (the 11E
  raw-escape-collapse class, same family as the queued libcd/toc.c lines 34/59/67).
  Harmless — it is inside a `/* */` block — but it should be repaired with that class.
  `grep -rln '^age-racer' recon/` finds this one file only, and there are ZERO lone CR
  bytes in drv.c / cdread.c / toc.c.
