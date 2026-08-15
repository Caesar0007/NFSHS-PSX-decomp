# W64-A6 — libcd-B belt (vendor gate-parity) receipts, 2026-08-15

Base HEAD at start `fbc974f7`. Commits: `9047f7de` (CdRead), `0015e5ac` (streamhelp),
`b8ac5d34` (stcdint), `e5e092c3` (cdread receipts).
Every TU gated **2x** after every landing; `tu_order_audit` 0 inversions; zero PASS→FAIL.
Control-byte / line-ending scan after every scripted edit (all clean: 0 NUL, cdread.c and
streamhelp.c pure LF, stcdint.c pure CRLF, all unchanged from their base regimes).

## 0. RE-GATED BASELINES vs the briefing (all 7 rows accurate this time)

| TU | fn | briefed | re-gated baseline | FINAL | Δ |
|---|---|---|---|---|---|
| cdread.c | `CdRead` | 83.24 / 14 | 14 (105/103) | **5 (104/103)** | **−9** |
| cdread.c | `_read_int` | 97.20 / 15 | 15 (158/157) | 15 | — |
| cdread.c | `_read_issue` | 96.15 / 8 | 8 (122/122) | 8 | — |
| stcdint.c | `StCdInterrupt` | 97.38 / 27 | 27 (576/583) | 27 | — |
| stcdint.c | `_st_dma` | 92.74 / 25 | 25 (107/106) | 25 | — |
| streamhelp.c | `StGetNext` | 99.89 (verify) | **PASS (46)** | PASS | — |
| streamhelp.c | `data_ready_callback` | 89.43 / 9 | 9 (34/35) | 9 | — |

**Net −9 diffs, 0 regressions.** TU gates unchanged: cdread 3/6, stcdint 1/3, streamhelp 5/6.

---

## 1. LANDED — `CdRead` 14 → 5 (three levers, three independent mechanisms)

### (1) REMOVE the w52-a2 identity fence on the `busy` anchor  → 14 → 11
`__asm__("" : "=r"(busy) : "0"(busy));` sat between assign_parms' `addu $s2,$a2,$zero`
parm copy and the function's first `beqz`. **reorg.c `stop_search_p` returns 1 at ANY
asm**, so reorg's backward scan could never reach the parm copy, and retail carries
exactly that copy in that branch's delay slot. Removing the fence does NOT lose the
single-`la` anchor form in this basin.
🔑 **This is the w64 instance of 13F: an inherited fence can BE the blocker.** The fence
was landed two waves ago for a different reason and had become pure cost.
Priced: fence removed 11 · fence → read-only 14 (inert) · fence moved inside the `if` n/a.

### (2) NAME THE DEFAULT ARM'S CONSTANT BEFORE ITS ANCHOR  → 11 → 7
```c
default: { int sz = 0x246; volatile CdrEnv *d = &_cdr; __asm__(...); d->w10 = sz; }
```
reorg fills the `beq $v1,$v0` slot from a *thread*: retail takes the fall-through (the
default arm) and steals its `li $v0,582`; ours took the branch TARGET's `li $v0,585`.
**Cause (09L):** the default arm's first insn was the anchor's `lui $v1`, and `$v1` is the
register the `beq` READS, so `insn_sets_resource_p` barred it and reorg abandoned that
thread. Naming the constant first puts an *eligible* `li` at the head of the thread.
Priced: `sz` named-first **7** · `sz` named **and fenced** 15 (an asm at the thread head
bars the whole thread again — the same stop_search_p law as lever 1, in the other
direction) · default-arm anchor deleted 16 @99 · non-volatile store in the default arm 11
(inert) · void fence at the head of the `case 0x20` arm 10 @105.
🔑 This retires the whole w63 "PRE-SET THE DEFAULT / arm-order rewrite" falsification list
(26/21/39): the arm ORDER was already right — **sotn's matched twin has the identical
arm order** — the reachable dial was the arm's INTERNAL statement order.

### (3) NAMED BOOLEAN + zero-insn READ-ONLY FENCE on the return  → 7 → 5
`{ int r = _read_issue(0) > 0; __asm__("" : : "r"(r)); return r; }` pins the
`slt $v0,$zero,$v0` above the frame restores (sched2 sinks ours below them).
Priced: read-only fence **5** · identity fence 5 · plain `return f()>0` 7 · Yoda 7 ·
`if(...)return 1;return 0;` 7 · `>= 1` 7 · void barrier before the return 7.

### RESIDUAL 5, named + priced (see the in-source block)
* **(c) 3 diffs — the `jal CdSyncCallback` delay slot.** Retail carries the `sw $s4,0($s0)`
  (`w00 = sectors`) store there. gcc's reorg **refuses a volatile MEM** (§3.25-3c), and
  every non-volatile-cast spelling that unblocks reorg ALSO lets gcc re-order the w04/w00
  store pair (flipping the `s3`/`s4` parm homes). 13 spellings measured, best 8 @103:
  w00 nonvol 16 · w04 nonvol 10 · both 10 · w0c nonvol 10 · w00+w0c 10 · order-swapped
  both-nonvol 14 · w00 vol first + w04 nonvol 8 · non-volatile `e` throughout 15 @102 ·
  `(char*)e+0` cast 16 · barrier+nonvol 7/7/8 (a barrier between the stores preserves the
  order but IS the reorg barrier → the two requirements are mutually exclusive with any asm).
  ⇒ **ORCHESTRATOR CANDIDATE, 1 TEXT_MOVES row (15D):** take `sw $19,0($16)` into the
  following `jal`'s slot with `drop_nop`. Semantically identical; objdump-verify per the
  `_padInitDirSeq` rule.
* **(d) 2 diffs — `CdControlB(9,0,0)`'s 3rd argument** (`addu $a2,$a1,$zero` vs
  `addu $a2,$zero,$zero`) = the **11B cse-constant-sharing-across-two-identical-literal-args**
  class, where the identity fence is explicitly *not* the cure. Re-measured INERT at 5:
  casts on both args / on the 3rd only / two named null locals / naming CdStatus's result;
  a void barrier before the call costs an instruction (6 @105).
  **The matched sotn twin writes the identical `CdControlB(CdlPause, NULL, NULL)`** — so
  this is not a source-shape question at all.

---

## 2. `data_ready_callback` 9 — CLOSED as a QUANTIFIED HARDNESS CERTIFICATE

The w63 NAMED ANGLE ("read `[find_free_reg]` on the fenced count-exact basin, do not
spell-probe") was executed. `qty272` on the fenced basin (cc1_272 lane, `-O2 -G0 -mgas`):

```
pseudo blk refs live sz calls   pri    home
   72   0    4    5   4   0   1.6000  $v1   (slot base)
   74   0    2    2   4   0   1.0000  $v0
   76   0    4    9   4   0   0.8888  $a0   <- `dst`, THE ANCHOR
   77/80/73/75/81 : pri <= 0.5, all reuse $v0/$v1
globals: only p82 (refs 3 / live 5) -> $a0 after 76 dies
```

* The **movstrsi hypothesis is FALSIFIED**: the block-move expander reserves no hard reg;
  `dst` is an ordinary **block-local qty**, served 3rd, and `$a0` is simply the **first free**
  register in find_free_reg's ascending numeric scan (MIPS has no `REG_ALLOC_ORDER`).
* Retail's `$a2` is the **third** free register ⇒ reaching it needs **two more values
  simultaneously live across the anchor's 9-insn window**. The function has exactly two
  (`$v0` = the lwl/lwr value, `$v1` = the slot base).
* **This is an AVAILABILITY loss, and 15A bounds every fence/ref/live dial out of that
  class by construction.** Measured anyway (all reverted, fenced basin = 10):
  hoist the `_ds_word1` load 24 · hoist `StFunc1` 18 · hoist `StRingIdx1` 22 ·
  w1+StFunc1 28 · w1+StRingIdx1 28 · unfenced with both hoists 23.
* ⇒ **Keep the un-anchored form (9).** Re-open only with a device that adds a live value
  at ZERO instructions.

---

## 3. `StCdInterrupt` 27 / `_st_dma` 25 — five axes closed, measured, no source change

* **StCdInterrupt, a SECOND void barrier:** `tools/fencesweep.py` over **all 116 statement
  positions** finds nothing under 27 (best non-baseline 28 ×5, 29 ×7). The same sweep is
  what produced the w63 36→27 landing, so its emptiness is a real negative.
* **Compiler ladder re-run in the NEW basin (04Z), both fns:**
  StCdInterrupt 2.6.0 66 / 2.6.3 66 / **2.7.2 27 (wired)** / 2.7.2-970404 756 / 2.8.0 756 /
  2.8.1 756. `_st_dma` 2.6.0 25 / 2.6.3 25 / **2.7.2 25 (wired)** / 970404 81 / 2.8.0 74 /
  2.8.1 77. `_st_copy_words` PASS on every rung.
* **`_st_dma`: every landed fence is LOAD-BEARING** (the w64 CdRead fence-removal lesson does
  NOT transfer): drop the `bv` read-only fence 43 · drop both `bit` identity fences 39 ·
  keep only ONE `bit` fence 31 · add a THIRD 25 (saturated) · drop the `dp` identity fence 39
  · drop the 1st `__volatile__` barrier 37 @105 · drop BOTH 41 @105. Only the **second**
  `__volatile__` barrier is inert (25).
* **`_st_dma` cluster (b) is a STRONG floor** (rubric: ≥3 alternate source forms
  byte-identical): **six** distinct spellings of the channel-address / BCR emission order all
  compile to **exactly 25 @107** — `int base` + index-first sum, `int base` + base-first sum,
  literal index-first sum, `p` before `dp`, a named `bcr` hoisted above the DPCR RMW, and
  base+bcr together. Fencing the `bcr` temp instead costs 2 insns (53 @109). Naming the
  0x10000 busy-wait limit is slightly worse (27) and does NOT move retail's `lui $a2,1`
  into the guard's delay slot.

---

## 4. `_read_int` 15 / `_read_issue` 8 — two more axes closed

* **Fence-removal (the w64 CdRead lever, tested here and it does NOT transfer).**
  `_read_int`: drop the `exp` fence 24 @157 · the DMA-arm `cur` fence 17 · the PIO-arm
  `cur` fence 37 @160 · ALL FOUR 48 @159. Only the trailing `g` fence in the PIO arm is
  INERT (15).
  `_read_issue`: drop the pre-anchor void barrier 9 @121 · the post-CdFlush barrier 9 @121 ·
  the `mp` identity fence 15 @121 · the in-arm barrier 11 @121 · the error-label barrier
  11 @121 · the tail `g` identity fence 14 @122. **Every w63 device is load-bearing.**
* **Per-fn `-mno-split-addresses`** (the mechanism that seals CdRead) applied to the rest of
  the TU: `_read_int` 47 @162 · `_read_issue` 32 @126 · `_read_data_int` PASS→3 ·
  `CdReadSync` PASS→2 · `_read_sync` PASS. ⇒ the two split `lui/addiu` pairs in `_read_int`
  are NOT reachable that way; the wiring must stay CdRead-only.
* `_read_issue` residual 8 = (a) the same 11B cse-shared-live-zero on `CdControl(9,0,0)`'s
  3rd arg (2), and (b) 6 diffs around `CdControlF(6,0)` where retail DUPLICATES its
  `li $a0,6` into the preceding `beqz` slot (a reorg eager-steal duplicate) and carries
  `lw $v0,4($s0)` in the call's own slot. Per 13B a fence can only BLOCK a steal, never
  supply one ⇒ this needs a filler hoisted into reorg's scan range, or a TEXT_MOVES row.

---

## 5. CORPUS VERDICT (read-only; the mid-wave 5-new-repo sweep, CAPPED and honest)

**sotn-decomp `src/main/psxsdk/libcd/cdread.c` (fully matched) — diffed line-by-line
against our CdRead, as briefed. NO un-lifted delta remains:**
| sotn | ours | verdict |
|---|---|---|
| `D_80032DBC.mode = mode; switch (D_80032DBC.mode & …)` | `g->w0c = mode; sel = g->w0c & 0x30;` | store-then-read-back — already ours (w63) |
| arm order `case 0 / case CdlModeSize1 / default` | `case 0 / case 0x20 / default` | **IDENTICAL — corroborates that the w63 arm-order rewrites were the wrong lever** |
| `mode |= CdlModeSize1; unk4 = buf; sectors = sectors; sync =; ready =; unk1C = VSync(-1);` | `w0c |= 0x20; w04 = buf; w00 = sectors; w28 =; w2c =; w1c = VSync(-1);` | **IDENTICAL ORDER** — strengthens residual (c): the order is right, `volatile` is the blocker |
| `if (CdStatus() & (Play|Seek|Read)) CdControlB(CdlPause, NULL, NULL);` | `if (CdStatus() & 0xE0) CdControlB(9,0,0);` | identical ⇒ residual (d) is not a source-shape question |
| `return cd_read_retry(false) > 0;` | `return _read_issue(0) > 0;` | identical |
No `$Id` RCS string in sotn's libcd; the CFG check stands in (function-for-function,
guard-for-guard identity, per 15F).

**The five new repos carry NO twin for any of my seven functions** (capped sweep, honest):
* `mgs_reversing` — has **no libcd reimplementation**. `source/libfs/cdbios.c` is EA-style
  *game-side* CD task code that CALLS libcd (`CdReadyCallback`, `CdlLOC` helpers); `libdg`/
  `libgv`/`libgcl`/`libfs` are MGS's own engine libs, not the PsyQ SDK. Semantic search for
  ring mechanics (`StGetNext`, `StCdInterrupt`, sector-buffer DMA) finds only two CALL sites
  (`game/movie.c`, `takabe/ending2.c`).
* `VandalHearts-PcPort` / `vh` — `platform/pc/src/libcd.c` defines `CdRead(int,unsigned*,int)`
  but it is a **modern SDL/stdio PC backend** (raw 2352-byte image, `fseek`/`fread`, wall-clock
  seek simulation). Zero relationship to PsyQ codegen. `src/core/cd.c` is game code.
* `TOMB5`, `KAIN2`, `Resident-Evil-2-Starter-Kit` — **no libcd/libds symbols at all.**
* `ff7-decomp` — `src/main/psxsdk.c` DOES carry `StCdInterrupt2`, `data_ready_callback`,
  `StGetNext`, `StRingStatus`, `init_ring_status`, `StFreeRing`, `StUnSetRing`, `CdRead2`,
  `cd_read` … but **all 515 entries in that file are `INCLUDE_ASM`** — no matched source.
* `chrono-cross`, `lom`, `parasite-eve-2` — carry only the `libcd.h` / `libds.h` HEADERS
  (declarations, no bodies). `CTR-in-C` — Ghidra reference output CALLING `StCdInterrupt`.
* `psyz` `libcd/c_004.c` / `c_009.c` / `c_011.c` / `cdread.c` and `libapi/a66.c` remain
  `INCLUDE_ASM` (re-confirmed; agrees with the w63 A18 table).

⇒ **The corpus is exhausted for this belt.** sotn's CdRead was the only twin and it is now
fully mined.

---

## 6. TOOLS

* `scratchpad/w64a6/vprobe6.py` — **promote-worthy.** Generic JSON-driven VARIANT prober:
  applies N (old,new) byte substitutions to the REAL TU path (so `PER_TU_FLAGS` still apply),
  gates any set of functions per variant, asserts `count(anchor)==1` (this caught two
  would-be splices), restores in `finally`. 60 variants measured this wave with it; it is
  the sibling of `tools/fencesweep.py` for *spelling* sweeps rather than *position* sweeps.
* `scratchpad/w64a6/vsbs6.py` — apply ONE named variant, dump `side_by_side`, restore.
  (Reading the losing variant's asm is what diagnosed the CdRead store-reorder.)
* `tools/fencesweep.py` (promoted last wave) used again; `tools/qty272.py` used for the
  data_ready_callback certificate.

## 7. HAZARDS ENCOUNTERED (all caught by the mandated checks)

* **Heredoc / non-ASCII bytes-literal:** a receipt paragraph containing `⇒` and `->` arrows
  inside a `b"""…"""` heredoc raised `SyntaxError: bytes can only contain ASCII literal
  characters` — the file was untouched because the write happens after the assert. All
  subsequent patches written with the Write tool, ASCII-only.
* **Comment-anchor off-by-one:** the first stcdint patch appended AFTER the closing `*/`
  instead of before it → the TU stopped compiling; caught immediately by `tugate` and
  reverted from the per-TU backup. Second firing on cdread.c: a block comment whose lines
  start with `" * "` (one space), not `"     * "` — the assert caught it (count 0).
* **Duplicate-anchor skip:** four `__asm__("" : : "i"(0));` lines in cdread.c are
  byte-identical; the prober's `count==1` assert refused them until the generator was
  changed to widen each anchor with preceding context until unique.
* `git log -1` after a commit showed a **peer's** commit (concurrent belts) — verified own
  SHA by `git log --oneline -5`.
