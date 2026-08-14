# W60-A5 receipts — syslib libmath + libc

Gate = `tools/verify_asm.py` / `tools/tugate.py` (sole authority). Polarity: `-` ours, `+` oracle.
Every number below re-gated by me. Briefing %s were stale in BOTH directions
(FIXDFSI "89.29%" = 6 diffs, SPRINTF "98.00%" = 60, DIVDF3 "93.72%" = 27).

## Ledger

| TU / fn | baseline | final | lever |
|---|---|---|---|
| libc/BSEARCH `bsearch` | 4 | **PASS 48/48** | prologue emission-ORDER row (PER_FN_TEXT_MOVES) |
| libmath/DIVSF3 `__divsf3` | 38 | **14** | split `int v8 = 0x1000000;` decl from init |
| libmath/DIVDF3 `__divdf3` | 27 | **25** | exponent update moved BEFORE its `_add_mant_d` call |
| libmath/FIXDFSI `__fixdfsi` | 6 | **5** | in-place shift + opacity fence (copy restored) |
| libmath/MULSF3 `__mulsf3` | 8 | 8 | PROBED-BLOCKED (6 fence/shape variants) |
| libmath/MULDF3 `__muldf3` / `_mul_mant_d` | 12 / 14 | 12 / 14 | rung axis closed (8-rung ladder) |
| libc/SPRINTF `sprintf` | 60 | 60 | not re-ground (W59-A13 exhausted the axes) |
| libc/QSORT | PASS 2/2 | PASS 2/2 | intra-TU order inversion cleared |
| libmath/ADDDF3, TRUDFSF2 | — | — | **SKIPPED-USER-LIVE** (dirty in the tree) |

Belt totals: **+1 PASS, −31 diffs, 3 intra-TU order inversions cleared, 0 PASS→FAIL**
(whole libmath + libc re-gated at the end: libmath 12/18 TUs fully PASS, libc 25/27).

---

## PRIORITY 1 — default-lane `PER_FN_CC1_VER_SPLICE` (WIRED + VALIDATED, table empty)

**What it is.** The default-lane twin of `PER_FN_CC1_VER_SPLICE_272`, spec'd at `a661dd36`.
In `tools/build.py`:

* table `PER_FN_CC1_VER_SPLICE = {rel_posix: {ladder_ver: {fn names}}}`
* `_apply_cc1_ver_splice(rel_posix, s_file, i_file, cc1_flags)` — recompiles the SAME
  preprocessed `.i` with a `windows-gcc-psx` ladder rung, extracts each named fn's
  `.ent … .end` region (`_extract_fn_region`), uniquifies its `$L<N>` labels
  (`_uniquify_local_labels` + the shared `_SPLICE_COUNTER`), substitutes it into the
  normal `.s` in place. The whole `.s` still goes through maspsx.
* called from `compile_c` immediately **before** `_apply_fn_splice` (a fn in both tables
  would end up with the flag-splice region — documented, don't do it).
* missing rung ⇒ `_warn_alt_fallback` + skip, so CI without the ladder still builds.

The trio is now complete: per-TU `cc1_ver` = whole TU, same maspsx route · per-TU `cc1_alt`
= whole TU **and** the 272 recipe (direct GNU as, reorder mode) · `PER_FN_CC1_VER_SPLICE`
= one fn, same maspsx route.

**Mechanism validation (MULDF3.c, whole-TU gate per rung).** Splicing the rung that equals
the TU's own cc1 (`2.8.1`) reproduces the un-spliced build exactly (14 / 12), and every
other rung moves ONLY the named fn (`__muldf3` held at 12 under all eight rungs) ⇒ faithful
and surgical. The 2.7.2 rung accepts the default lane's flag set
(`-quiet -O2 -G4 -g1 -mgpOPT -fgnu-linker`) and emits ordinary `.set noreorder` / `#nop`
cc1 output that maspsx consumes normally.

**Adoption: the spec's MULDF3 win is FALSIFIED (04Z again).** `_mul_mant_d` whole-TU ladder
through the mechanism:

| rung | `_mul_mant_d` | `__muldf3` |
|---|---|---|
| default (2.8.1) | **14** | 12 |
| 2.8.0 / 2.8.1-explicit | 14 | 12 |
| 2.7.2 | 19 | 12 |
| 2.7.2-970404 / 2.6.3 / 2.6.0 | 21 | 12 |
| 2.95.2 | 80 | 12 |
| 2.91.66 | 86 | 12 |

The spec ("_mul_mant_d wants 2.7.2, expect −2") was read off the PRE-landing basin — the
same commit's own 05E volatile-view + named-temp landing took `_mul_mant_d` 18→14 and moved
the table. No rung wins ⇒ the table ships EMPTY with the measured ladder recorded in-source.
MULDF3 stays a pure default-lane TU.

Probe driver: `scratchpad/w60a5/ladder_probe.py` (atomic temp + `os.replace` rewrite of the
rung string, `finally`-restore — build.py-concurrency-safe window).

---

## PRIORITY 2 — FAILs

### libc/BSEARCH `bsearch` 4 → PASS 48/48 (commit `95c8c9f1`)

NOT a coloring residual — every home register already matched retail. The delta was the
prologue EMISSION ORDER of one pair: retail defines `key, base, n, LO, w`; ours
`key, base, n, w, LO` (the `sw sN` saves are anti-dep-tied to their defs, so pair order IS
def order).

**Mechanism (gcc-2.8.1 `sched.c`, read not guessed):** `rank_for_schedule` sorts by
`INSN_PRIORITY`, then by dependence class vs the last scheduled insn, then by `INSN_LUID`
= ORIGINAL ORDER; and the launch boost is dead post-reload (`birthing_insn_p`:
`if (reload_completed == 1) return 0;`). All five prologue defs tie on priority and class,
so the order IS the RTL order — and `assign_parms` emits EVERY parm copy before the first
body insn, so no C source can put a body statement between two parm copies. The single gcc
deferral that exists (a narrower-than-ABI parm routed through `conversion_insns`) is still
pre-body AND measures far worse.

FALSIFIED first (all whole-TU gated, current basin):

* rung ladder @ `no_schedule_insns`: 2.6.0 8 | 2.6.3 8 | 2.7.2-970404 16 | **2.7.2 4 (wired)** | 2.8.0 8 | 2.8.1 16
* flags: `+no_schedule_insns2` 30 | `+no_strength_reduce` 4 (inert)
* narrow-parm lever (the CdReadyHandler device): `unsigned short w` 29 | `unsigned char w` 29
* fences: identity-on-`w` 8 | identity-on-`cmp` 20 | read-only-on-`lo` 8; the existing tail
  fence's operands are load-bearing (drop `lo` 18 | drop `w` 12)
* body shapes: `lo` split decl/init 4 | `lo` inside the `if` 18 | `c` at fn scope 4 | `for(;;)+break` 4

⇒ wired as a `PER_FN_TEXT_MOVES` **schedule-relocation** row (same class as physics.cpp's
DoBarrierCheck mflo row): move the `sw $18,24($sp); addu $18,$0,$0` pair back above the `w`
parm copy. **ORCHESTRATOR:** if you judge a schedule-relocation row to be scaffolding, drop
the row — the fn returns to a clean 4-diff near-miss with the mechanism named above (that
note is also in-source).

### libmath/DIVSF3 `__divsf3` 38 → 14 (commit `0fdc2252`) — the wave's biggest single lever

The standing receipt called the residual a "callee-saved seat rotation … not a floor". It
was ONE declaration: **splitting `int v8 = 0x1000000;` into a bare decl + an assignment in
the loop preheader.** The fused decl-with-init starts the mask's live range at the top of
the else-block, dropping its allocno priority (`floor_log2(refs)*refs/live`) below both
exponent values, and all three rotate one seat: ours `v8/v2/v3 = $a3/$t1/$t0` → retail
`$v1/$t0/$a3`. The `lui`'s emitted POSITION is identical either way — purely the live-range
START.

**GENERALIZABLE LAW (catalog candidate):** on a block-local constant whose only real use is
a loop, `decl-with-init` is an allocno **DEMOTE you did not ask for**. Split the decl from
the init and assign it in the preheader. (Inverse-facing sibling of the W38 "init the
long-lived accumulator FIRST to demote it" dial.)

Falsified at 38 before it: identity fence on `v8` 38 | identity fence on `v3` 38 |
read-only fence on `v3` 38 | read-only fence on `v2` 38 | `do{}while(0)` depth wrapper on
`v8 >>= 1` 38. 04Z re-ladder after the landing: 2.7.2 14 (wired, optimal) | cc1_272 14 |
2.6.0/2.6.3/2.8.0/2.8.1 18 | 2.7.2-970404 23 | 2.95.2 71.

Residual 14 = two named clusters (both in-source):
* **(a) the RESULT FUNNEL**, shared with `__mulsf3` — retail stages `result` through $a2
  with a copy IN from each err arm and a copy OUT to $v0; ours coalesces both away.
  Falsified here: explicit default-then-override funnel 14 (no change). This is the **06E
  non-propagated reg-reg-copy instrument gap with THREE members** (MULSF3, DIVSF3,
  FLTSISF's old one) — crack it once, transfer it three times.
* **(b) two speculative pre-guard materializations** retail does (`lui $v0,20224` before the
  sign test, `sll $v0,$a3,23` in the overflow test's delay slot). Falsified: named temp for
  the shift before the guard 19; combined with the funnel/default-first shapes 19/14.

### libmath/DIVDF3 `__divdf3` 27 → 25 (commits `2f420741` + fixup `57243295`)

Residual (c) of the standing receipt half-cleared: **the exponent update belongs BEFORE its
`_add_mant_d` call.** reorg's backward scan can only steal an insn that PRECEDES the jal;
written after the call, `exp += 1` / `exp = 0` are unreachable to it and the a0 arg-setup
gets stolen instead. Moved, retail's `addiu $s1,$s1,1` / `addu $s1,$zero,$zero` land in the
two delay slots. (Arm 1 carries the whole win; arm 2's move is oracle-evidenced and
gate-neutral — kept for faithfulness.)

Falsified at 25 for residual (b), the arg-load order: named temp for arg4 `t[0]` 27 | named
temp for arg5 `t[1]` 25 | pointer local for `q` at the top of the arm 25. Re-confirmed for
residual (a) at this basin: `if/else` instead of the ternary 69 (head) / 73 (tail) / 73
(both), inverted `if/else` 70 — **the ternary IS retail's shape**; the residual really is
cse carrying the live mask constant into the arm, exactly as the standing note says.

### libmath/FIXDFSI `__fixdfsi` 6 → 5 (commit `b02e87bf`)

Landed the first half of the W53-A12 named angle: retail shifts IN PLACE
(`srav $v1,$v1,$v0`) then copies at the join (`addu $v0,$v1,$zero`). In-place mutation alone
is not enough — local-alloc's `combine_regs` ties the srav's dest to the return pseudo and
`delete_noop_moves` eats the copy. The zero-insn **opacity fence**
`__asm__("" : "=r"(v8) : "0"(v8))` gives the shifted value an end-point cse/combine cannot
equate with its source, so the copy survives (the w47-a2 cure).

Residual 5 = pure jump.c **BLOCK PLACEMENT**, and ours is 1 insn SHORTER (62 vs 63): retail
lays `[tests][shift; j Ltail][ret0][Ltail]` with the shift as fall-through; gcc canonicalizes
to `bnez`-to-shift with the ret0 block inline (no `j`). Both builds cross-jump the two
`return 0` sites into ONE block — only its POSITION differs.
Falsified on the fence base: if/else with `return 0` as the else arm 5 (byte-identical to the
early-return form — jump.c canonicalizes the two), explicit `goto zero;` with the label
physically BETWEEN shift and tail 5, same + void-tail fence 7, 04T `return (unsigned)v8;` 5,
guards swapped 9, guards merged into one `||` 5, void-tail fence at the tail head 5. The same
set measures 6/6/8/6/6/6 WITHOUT the fence ⇒ the placement is invariant in BOTH basins.
Named next angle in-source (jump.c's "conditional jumping around an unconditional jump").

### libmath/MULSF3 `__mulsf3` 8 — PROBED-BLOCKED

Same RESULT FUNNEL class as DIVSF3's residual (a). The standing receipt had falsified the
READ-ONLY fence; I falsified the **identity/opacity** fence family too — before the return 8 |
in the normal arm 8 | in the err arm 9 | in both arms 9 | all three 9 — plus splitting the
final `|` into two statements 8. Route: the 06E instrument, not more spellings.

### libmath/MULDF3 — rung axis closed

Ladder table above; `__muldf3` is invariant at 12 across all 8 rungs, `_mul_mant_d`'s best
rung is the default. No wiring change.

### libc/SPRINTF `sprintf` 60 — not re-ground

Re-gated at 60 @ 545/545 (count-exact). W59-A13 already closed the lane/flag axis and the
format-pointer spelling family. The two clusters I could see are (i) the same prologue
emission-ORDER class as bsearch (`sw s2` + `addu s2,zero,zero` vs `li s3,48` in the beqz
slot — and the constants' order is already analysed in-source at lines 86-90) and (ii) the
rodata 3-word block copy's scratch-register class, which the in-source receipt shows
`-mno-split-addresses` fixes at the cost of +1 insn (an orchestrator judgement call, still
open). The one genuinely un-tried item named in-source remains RR's `u8 *argState[2]`
pointer-ARRAY spelling of the va_list cursor.

---

## Intra-TU ORDER inversions — all 3 cleared (MSC02 class, link-visible, gate-invisible)

Procedure per briefing: baseline PASS set → whole-block move into `configs/symbol_addrs.txt`
VA order (file-scope data left in place, forward decls added) → rebuild → tugate PASS set
IDENTICAL → `tu_order_audit.py` silent → commit per TU.

| TU | retail order | commit | gate before → after |
|---|---|---|---|
| libc/QSORT.c | `qsort` 0x800E5D8C < `_swap` 0x800E5EDC | `ddeb1d82` | 2/2 PASS → 2/2 PASS |
| libmath/MULDF3.c | `__muldf3` 0x800F62E4 < `_mul_mant_d` 0x800F65F8 | (with the reorder commit) | 12/14 → 12/14 |
| libmath/DIVDF3.c | `__divdf3` 0x800F5DD4 < `_comp_mant` 0x800F60B4 | `a228a803` | 1/2 PASS, 27 → same |

**NEW FACT (contradicts the W54 hazard note "gcc-2.8 HOISTS file-scope `__asm__` above all
functions"):** on this lane a file-scope `__asm__` block emits at its SOURCE POSITION.
DIVDF3's `_comp_mant` is a file-scope asm transcription and moving it below `__divdf3` put
it at 0x2dc in the object (`objdump -t` verified). ⇒ **file-scope-asm functions ARE
order-fixable**, which unblocks that whole sub-class of the 274-inversion backlog.

`tu_order_audit.py` now reports 72 inversions tree-wide; **zero** in libmath or libc.

---

## Laws / catalog candidates from this run

1. **DECL-WITH-INIT IS AN UNREQUESTED ALLOCNO DEMOTE** (DIVSF3 38→14). A block-local
   constant whose only real use is a loop: `int m = K;` at block top starts its live range
   there and drops its `floor_log2(refs)*refs/live` rank below longer-lived neighbours,
   rotating the whole seat assignment. Split decl from init and assign in the preheader.
   The emitted position of the materialization does NOT change — only the live-range START.
2. **REORG CAN ONLY STEAL WHAT PRECEDES THE JAL** (DIVDF3 27→25). An update statement the
   oracle shows in a call's delay slot must sit BEFORE the call in source; after it, the
   arg-setup gets stolen instead. (Sharpens the w47-a2 "PRE-SET THE DEFAULT BEFORE THE TEST"
   row from tests to calls.)
3. **THE PROLOGUE PARM-COPY ORDER IS `INSN_LUID`, AND `assign_parms` PRECEDES THE BODY**
   (bsearch). gcc-2.8.1 `sched.c`: `rank_for_schedule` falls through to `INSN_LUID`, and
   `birthing_insn_p` returns 0 once `reload_completed` ⇒ no launch boost at sched2. So an
   oracle that interleaves a body statement between two parm copies is not reachable from C
   — recognise it and stop sweeping spellings.
4. **FILE-SCOPE `__asm__` IS NOT HOISTED on this lane** — see the inversion section.
5. **The opacity fence is the `delete_noop_moves` cure, the read-only fence is not**
   (FIXDFSI 6→5 where a read-only fence had been falsified; and MULSF3 where neither works,
   bounding the device).

## Process / hazards hit

* **Recurring gotcha #1 fired:** a receipt block ending in `*/` closed its HOST comment and
  turned the rest of a standing note into code (DIVDF3). It shipped because I chained
  `tugate | grep -v … && git commit` — **the pipe swallows the tool's exit code**. Fixed in
  the next commit (`57243295`). RULE: never gate through a pipe in a `&&` chain; check
  `${PIPESTATUS[0]}`.
* `tools/sbsx.py` has a path bug (`parents[2]` instead of the repo root) — it can only run
  from a directory one level deeper. Working copy at `scratchpad/w60a5/sbsx.py`; a one-line
  fix in `tools/` is an orchestrator call.
* C89 in these lanes: a declaration after a statement inside a block is a hard parse error
  under CC1PSX 2.7.2 — several probe variants died on this, not on the lever.
* All edits byte-checked (CRLF preserved, zero control bytes) after every scripted write;
  probe harnesses use byte-mode temp + size assert + `os.replace` with `finally` restore.

## Tools left in `scratchpad/w60a5/`

* `ladder_probe.py` — ladder the `PER_FN_CC1_VER_SPLICE` rung for one fn, whole-TU gated.
* `tuflag_probe.py` — swap a TU's `PER_TU_FLAGS` dict literal, gate, restore.
* `vprobe.py` — apply (old,new) byte-exact substitutions to a recon TU, gate, restore.
  (Line-ending safe; reports anchor-count mismatches instead of splicing blindly.)
* `sbsx.py` — repo-root-fixed copy of `tools/sbsx.py`.
* `*.json` — every probe batch run above, so each falsification is replayable.
