# W75-A17 — libcd belt (report)

Targets: `_st_dma` (syslib/psx/libcd/stcdint), `CD_cw` (syslib/psx/libcd/drv),
`_read_issue` (syslib/psx/libcd/cdread).
Repo `C:\Temp\nfs4-decomp`. **No git commit/push/stage. `tools/build.py` never edited
(its uncommitted foreign edit untouched). No memory file edited. No TEXT_MOVES / RA_SINK
row added (user policy 2026-08-23 honoured).**

STEP 0 done: `reference_mips_isa_asm.md` (full), `reference_psx_cpp_reconstruction_methodology.md`
(full, 1018 lines), `reference_asm_pattern_catalog.md` tail (§18–§23 + waves 41–56), and each
target's in-TU receipts.

---

## HEADLINE

| fn | baseline | final | outcome |
|---|---|---|---|
| **`CD_cw`** (drv.c) | 4 @259/259 | **PASS 259/259** | **SEALED**, `drv.c` **13/13 PASS**, gated ×2 |
| **`_st_dma`** (stcdint.c) | 25 @107/106 | **21 @107/106** | −4, first movement in 4 waves, gated ×2 |
| **`_read_issue`** (cdread.c) | 3 @121/122 | 3 (unchanged) | route-solved to **1 diff**, blocked by a NEW gate-invisible hazard; nothing landed |

Zero PASS→FAIL anywhere. TU gates (twice each, final): `drv.c 13/13`, `stcdint.c 2/3`,
`cdread.c 5/6`.

---

## 1. `CD_cw` — SEALED (4 → 16 → PASS)

Both prior certificates (W72 "pass-0 candidate" / W74 "prune_preferences") were built on the
**wrong pseudo**: they priced allocno **201**, which in the current numbering is the INLINED
`_memcpy8` destination. The parameter loop's saved count-address pointer is allocno **130**.
`tools/qty272.py` (the .greg conflict lists) settles it in one call — no instrumented cc1 needed:

```
130 (count ptr) refs 3 / live  9 / pri 3333  rank 15  conflicts {72 74 75 76 77 80, $v0,$v1}
77  (`ip`)      refs 6 / live 27 / pri 4444  rank 10  home $a1
80  (`i`)                                    rank  2  home $a0
```
`130`'s ascending scan: `$v0/$v1` hard-barred, `$a0` barred by `80`, **`$a1` barred by `77`** → `$a2`.
No preference is involved (130's prefs field is empty). It conflicts with `ip` **because the
W64-A5 read-only fence that demotes `ip` sits AFTER the parameter loop and holds `ip` live across
it**. Retail's `ip` is also `$a1` — it just dies at `sb $0,1($a1)`, so retail reuses `$a1`.

**FIX = a two-part CELL (neither half works alone):**
1. delete the `ip` read-only fence and buy the same ordering on the other side — widen the existing
   zero-insn `tbl` read-only fence from **2 to 6 operands** (refs 4 → 8, crossing the `floor_log2`
   step): `tbl` 5714 → 17142, `ip` 4444 → 12500 with live 27 → 8. → **16 @259/259**.
2. the 16 is a NEW rotation: with a short live range `ip` finds `$a0` free (it does not conflict
   with `i`) and takes it, pushing the `com<<2` index onto `$a1`. Cure = a **20B zero-insn
   hard-register denial of `$a0` strictly inside `ip`'s live range and outside `i`'s**:
   `__asm__("" : : : "$4");` right after the `ip` identity fence. → **0**.

Ladders (all gated):
* tbl fence operand ladder with the ip fence dropped: 3 ops 28 · 4 ops 28 · 5 ops 28 · **6 ops 16**
  · 7 ops 16 · 8 ops 16 · 10 ops 16.
* same ladder with the ip fence *moved* above the loop instead of dropped: identical (3/4 → 28,
  6/8 → 16) ⇒ W64-A5's "position is the dial" was basin-local.
* `$a0`-denial sweep from the 16 basin: `"$4"` after the ip identity fence **0** · after
  `ip->sync = 0` **0** · before the ready-flag guard **0** · BEFORE `ip = &Intr` 16 (INERT —
  outside ip's live range, the 22B-1 law) · `"$4","$5"` at the three inside positions 8 ·
  `"$5"` alone at all three 16 (INERT).
* FALSIFIED: demoting `ip` by an EARLIER BIRTH (move `ip = &Intr` + its identity fence to just
  after `CD_sync(0,0)`) — 11 @258/259 in every variant (fence kept 15, fence before the loop 11,
  fence at the tbl fence 11, no extra fence 11, 2-operand fence 11); the earlier birth also costs
  an instruction.
* control: "move the ip fence above the loop, no tbl boost" reproduces W64-A5's 28 exactly.

**NEW LAWS (in-TU receipt at `drv.c` CD_cw):**
* **(a) A read-only (live-extending) DEMOTE fence is also a CONFLICT GENERATOR.** When the demoted
  value's register is one the oracle REUSES later, the fence's own live extension is what blocks the
  reuse. Prefer buying the ordering by PROMOTING THE RIVAL (a ref-only, live-neutral dial).
* **(b) Read the pseudo number off a FRESH dump.** Two waves of certificates rested on a stale
  pseudo id. A **conflict list is a stronger instrument than a preference argument** — check
  conflicts first, preferences second.
* **(c) The 20B denial DOES reach a global allocno whose scan simply finds a free lower-numbered
  register** (unlike 22B-2's adjacent-def/use QTY). Gate on "is the register free at this allocno's
  turn", not on "is there a tie".

---

## 2. `_st_dma` — 25 → 21 (count still 107/106)

`tools/qty272.py --all` on block 8 (the tail) — every value there is a **block-local QTY**,
pri = `floor_log2(refs)*refs*10000/live`:

```
control:  idx (ch<<4)  refs 2 live 4 pri 5000 -> $a1     base 0x1F801080  refs 2 live 7 pri 2857 -> $a2
```
**LANDED:** a named `idx` local **plus a zero-insn READ-ONLY fence on it** — live 4 → 12,
pri 5000 → 2500, which pushes `idx` BELOW the base constant. The base then takes `$a1`, and because
`p` (global allocno 80, prefs `$a1`) ties to it, retail's dest-is-the-BASE
`lui $a1;ori $a1 … addu $a1,$v0,$a1` appears. **−4 diffs, zero insns added.**

Every w62/w64/w72/w74 spelling that was measured byte-identical touched only the EXPRESSION; none
of them moved the QTY table, which is what actually decides the region.

**RE-CLASSIFICATION of the old cluster (b):** the `-dR` (sched2) dump proves the tail emission order
is decided **post-reload**, where the dependence graph is over HARD REGISTERS — so the BCR/address
order is **downstream of the register handout**, not an independent sched1 DAG tie (the w62/w64/w72/w74
receipts all attacked it as a source/statement-order problem). It already followed once, for the
base/`p` pair.

**RESIDUAL 21**, one named defect + two consequences: the dv-chain (`ch*4`,`+3`) holds `$v0` and
`idx` holds `$a2`, retail has them SWAPPED. Priced exactly: dv refs 2/live 2/pri 10000, idx refs
3/live 12/pri 2500; for idx to reach `$v0` it needs `floor_log2(r)*r/live > 1`, i.e. refs ≥ 8 at
live 12.

FALSIFIED at this basin (all gated + reverted): fence-operand ladder on idx n=1 **21** (shipped),
n=2 33, n=3 33, n=4 33, n=5 33, n=6..10 46 @108 · identity fence 32 @108 · identity+read-only 40
@108 · two fence SITES 40 @108 · fence after `p`/after `dp`/after the stores 21 (inert) · plain
named idx 25 · idx assigned before `dv` 22 @108 · named `base` + identity fence 29 · fences on `p`
before `dp` 41 @109 · void barrier before `dp` 21 · `dp` before `p` 21 · named `bcr` hoisted above
`dp`/above the RMW/after `dv=*dp` 21 (inert, cse re-sinks) · `bcr` + read-only fence 32 @108 ·
`bit` moved below `idx` 35 · every dv-demotion (read-only fence on dv at `p` / at `dp` / 2 operands
/ split `sh` variable at three positions) 32 @108 (+1 insn).

**The 20B clobber angle is now MEASURED AND CLOSED here**: a bare zero-ref clobber strictly inside
the dv chain's live range — the one position w72/w74 never covered — is INERT at 21 for `"$2"`,
`"$2","$3"`, `"$4"`, `"$5"`, `"$6"`, for a split `t3 = dv+3` with the clobber between the halves,
before the `bit` fences, and at the `idx` statement (**8 positions/masks, all byte-identical to the
control**). That is the 22B-2 law at a new site.

**PER-FN FLAG + RUNG AXES CLOSED** (via the scratch harness, so build.py stayed untouched):
* flags: `-fno-delayed-branch` 35 · `-fno-schedule-insns` 33 @109 · `-fno-schedule-insns2` 42 @108 ·
  `-fno-expensive-optimizations` 47 · `-fno-rerun-cse-after-loop` 58 @112 · `-fforce-addr` 50 @108 ·
  `-fno-peephole` / `-fno-cse-follow-jumps` / `-fno-thread-jumps` / `-fno-force-mem` /
  `-fno-function-cse` / `-fno-caller-saves` / `-fno-defer-pop` / `-mno-gpopt` / `-G4` / `-G8` all 25.
* rungs: 2.6.0 25 · 2.6.3 25 · 2.7.2 25 (wired) · 2.7.2-970404 81 @103 · 2.8.0 74 @104 · 2.8.1 77
  @103 · 2.91.66 123 · 2.95.2 143 @95; 2.6.3/2.6.0 + `-fno-delayed-branch` 35.
* ⚠️ NOTE FOR THE ORCHESTRATOR: `stcdint.c`/`drv.c` are on the `cc1_272` lane, and
  `CC1_272 == CC1_PSYQ40 == C:/Temp/nfs3-clean/psyq400/COMPILER/CC1PSX.EXE`. **The brief's "check
  RAW40 / does whole-fn 4.0 codegen match retail" scope test is therefore ALREADY SATISFIED for
  these two TUs — their whole TU is PsyQ-4.0 codegen today.** RAW40 only adds the post-maspsx
  macro-form splice, which those TUs do not use (they bypass maspsx entirely).

**NEXT ANGLE (named, unmeasured):** every SOURCE dial for the dv/idx swap is spent. What is not
spent is `find_free_reg`'s per-QTY scan — `qty272` gives the priority table but not the scan.
Point the instrumented cc1 (`C:/Temp/nfs4-instr-cc1`, `[find_free_reg]`/`[qty_compare]` +
W75-A20's new `[reload_pick]`) at a **cc1_272-lane** function for the first time and read why `$v0`
is offered to the dv chain before `idx`.

---

## 3. `_read_issue` — ROUTE-SOLVED to 1 diff, NOT landed (a new hazard blocks it)

### 3a. The `CdControl(9,0,0)` residual is a COMPILER-VERSION identity
W75-A20 named the pass (`reload_cse_regs`); the consequence is the point. `reload_cse_regs` is
called **unconditionally at `optimize > 0`** (gcc-2.8.1 `toplev.c:3501` — there is no flag) and
**does not exist in gcc-2.7.2 at all**. Retail's `addu $a2,$zero,$zero` is what a 2.7.2 build
emits. MEASURED PROOF: under the PsyQ-4.0 RAW40 route **both** named residuals — the
`addu $a2,$a1,$zero` rewrite **and** the missing `li $a0,6` reorg duplicate — disappear with no
source change. ⇒ CDREAD.OBJ is a 2.7.2 object like its libcd siblings (`drv.c`, `stcdint.c`, both
wired `cc1_272`); this TU's 2.8 lane is a recon-source artifact.

### 3b. Per-fn ladder RE-PROBED with the W74-A19 LM/.loc strip fix in place
(the fix that invalidated every earlier sub-2.8 ver-splice number — the brief's explicit ask)

```
wired(2.8.1) 3 | 2.8.0 7 | TU-own 7 | 2.7.2-970404 18 @120 | psyq40 35 | 2.7.2 35 |
2.6.3 35 @127 | 2.6.0 35 @127 | 2.95.2 39 | 2.91.66 41 @119 | RAW40 23 @117
```
No maspsx-lane rung beats the wired 2.8.1 (the sub-2.8 rungs pay the AT-MACRO class for the
un-anchored `_cdr` regions plus maspsx's `.set noreorder` nops). RAW40 pays only the first half.

### 3c. The RAW40 route, priced end-to-end (the W74-A14 "three-part job", now measured)
```
RAW40 alone .......................................... 23 @117/122
+ ERROR-TAIL fenced anchor (the proven `_read_int` recipe) 16 @122/122  (count-EXACT)
+ SHELL-OPEN fenced anchor with the VSync SPLIT OUT FIRST   5 @121/122
+ `cb = (int)_read_int` hoisted before the tail anchor AND
  IDENTITY-FENCED                                          1 @121/122
```
Shell-anchor variants at 16: split-VSync **5** · field anchor 15 · plain identity anchor 15 @119 ·
anchor before `CdControlF` 17 @119 · no fence 16 · read-only fence 18 @124. `cb` variants: plain
hoist before the anchor / before the barrier / before `CdPosToInt` all **5 (inert)** — only the
identity-fenced hoist reaches 1.

### 3d. 🔴🔴 WHY NOTHING IS LANDED — NEW HAZARD (gate-invisible, produces a BROKEN object)
**A zero-insn `__asm__` fence can be chosen by reorg as a DELAY-SLOT FILLER.** In the RAW40/272
route the merged `.s` reads
```
.set noreorder / jal CdLastPos / #APP <empty asm> #NO_APP / .set reorder
```
— gcc counted the empty asm as the filler, it emits nothing, and `jal CdPosToInt` silently lands in
the delay slot. On R3000 a jump in a jump's delay slot is **undefined**. `verify_asm`/`tugate` cannot
see it: the instruction stream still matches, one `nop` short — **that missing `nop` IS the residual
1 diff.** Removing the barrier does not help; any other zero-insn fence in range is taken instead
(barrier variants all 1 @121: `"memory"` clobber, `"$1"` clobber, read-only fence on `sect`, barrier
above the call, both, none).

**NEW STANDING CHECK — `tools/slotcheck.py <obj> [fn]`** (promoted this wave): flags any
branch/jump sitting in a branch/jump delay slot. **TREE-WIDE SCAN RUN: 521 objects in
`build/recon`, 0 flagged** — the shipped tree is clean; the hazard is specific to the
(zero-insn asm × 272/RAW40 reorder route) combination. Run it after ANY new 272/RAW40 wiring.

### 3e. Next angle (named, costed)
Land the RAW40 route once the fence device can be made non-slottable: (a) find the gcc-2.8
length/eligibility path that lets an empty asm into a MIPS delay slot and give the fences a form
that fails it; or (b) rebuild the two anchors WITHOUT identity fences (needs the
`-mno-split-addresses` half of the composition instead, per the `_read_int` combine_regs law); or
(c) a route-level post-pass that re-nops a slot whose filler assembled to zero bytes.

---

## TOOLS / ARTEFACTS

* **`tools/slotcheck.py`** (NEW, promoted) — illegal-delay-slot scanner; validated against a known
  positive (the RAW40 `_read_issue` object) before the tree-wide negative was trusted (W43 law).
* `scratchpad/w75/a17_mkbuild.py` — builds a **scratch-only** patched copy of `build.py` +
  `verify_asm.py` (`a17_build.py` / `a17_vasm.py`) with three env-driven hooks, so **nothing under
  `tools/` is modified**: (1) per-fn (rung × extra-flags) splice on the **cc1_272 lane**
  (`A17_REL`/`A17_SPEC`), (2) the same composition on the **maspsx lane**
  (`A17M_REL`/`A17M_SPEC`, plus `psyq40`/`own` pseudo-rungs), (3) env-driven
  `PER_FN_RAW40_SPLICE` (`A17R_REL`/`A17R_FNS`). This is the "make the two splice tables compose"
  spec from the `_read_int` receipt, in probe form.
* `scratchpad/w75/a17_srcprobe.py` — CRLF-safe apply→gate→**always restore** source-probe runner
  (in-place on the real path, per the W44 rule; takes an `env`/`vasm` override).
* `scratchpad/w75/a17_sweep.py`, `a17_msweep.py`, `a17_ri_land.py`; results in
  `a17_*_res*.json`, side-by-sides in `a17_*_sbs*.txt`.

## HAZARDS FIRED (all caught)
* **CRLF**: all three TUs are CRLF; the first probe batch matched 0 anchors with `\n` search
  strings (the recurring class). The harness now translates line endings per file.
* `verify_asm` prints only 12 diff lines by default — `VA_MAX` raises it; a 25-diff function looked
  like 12 until then.
* `sbs.py`/difflib alignment can render two `jal T` lines as adjacent — always confirm a
  suspicious slot against `objdump`, not the side-by-side (that is how the illegal slot surfaced).
