# W84-C4 — `_st_dma` (recon/syslib/psx/libcd/stcdint.c), FAIL 1  →  UNCHANGED, file restored

STATUS: **no improvement landed.** `recon/syslib/psx/libcd/stcdint.c` is byte-identical
to its pre-session state (md5 `ad16a2d6a954d2ce3f40035343a26423`, verified against
`scratchpad/w84/C4_stcdint_backup.c` after every experiment and at the end).
Whole-TU gate at the end == baseline:

```
python tools/verify_asm.py recon/syslib/psx/libcd/stcdint.c StCdInterrupt,_st_copy_words,_st_dma
  StCdInterrupt:  PASS (583 insns)
  _st_copy_words: PASS (11 insns)
  _st_dma:        FAIL 1 diffs (ours 107 / oracle 106)   -li v0,1
```

The deliverable is a **new, source-derived mechanism + a much sharper floor
certificate** than the in-file W76 note, plus five falsified angles with numbers.

Tools written (scratchpad only, no tools/*.py touched):
`C4_dump.py` (cc1_272-lane RTL dumps), `C4_try.py`, `C4_try2.py`, `C4_sweep.py`.

---

## 1. DIFF CHARACTERISATION

`tools/sbs.py recon/syslib/psx/libcd/stcdint.c _st_dma`:

```
   18 and v0,v0,v1        |   18 and v0,v0,v1
   19 beqz v0,T           |   19 beqz v0,T        <- busy-wait ENTRY GUARD
   20 li v0,1        X    |                        <- OURS: slot = COPY of target's 1st insn
   21 lui a2,1           |   20 lui a2,1          <- ORACLE: slot = the preheader constant
   22 beq a0,a2,T        |   21 beq a0,a2,T
   ...
   31 li v0,1            |   30 li v0,1           <- the `mode == 1` constant (both builds)
```

One pure insertion; the other 106 insns are identical. The slot is filled by **cc1
itself** (raw `.s`, `scratchpad/w84/rtl/stcdint.s`):

```
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L86
	li	$2,0x00000001		# 1
	.set	macro
	.set	reorder
	li	$6,0x00010000		# 65536
$L75:
```

so this is `gcc/reorg.c`, not the assembler. Oracle = `li $6,0x10000` **MOVED** into
that slot (net −1 insn); ours = `li $2,1` **COPIED** into it (net +1).

## 2. MECHANISM (new; derived from gcc source + the RTL dumps)

Dumps: `python scratchpad/w84/C4_dump.py -dd -dR` → `scratchpad/w84/rtl/stcdint.i.{dbr,sched2}`
(cc1_272 recipe: PsyQ 4.0 CC1PSX `-quiet -O2 -G0 -mgas -fno-strength-reduce`).
Source read: `C:/Temp/gcc-2.8.1-src/extracted/reorg.c` + `.../config/mips/mips.md`.

sched2 RTL around the guard:

```
(jump_insn 228 ... (eq (reg v0) (const_int 0)) (label_ref 76))  <- guard
(insn 246 (set (reg:SI 6 a2) (const_int 65536)))                <- preheader = fall-through 1st insn
(insn 249 (set (reg:SI 3 v1) (const_int 16777216)))             <- preheader, REDUNDANT (reorg deletes it)
(note 28 NOTE_INSN_LOOP_BEG) (code_label 40) (jump_insn 46 ...) ... (jump_insn 37 back-edge)
(code_label 76 = $L86) (insn 79 (set (reg v0) (const_int 1))) (jump_insn 80 (ne s1 v0) -> 105)
```

`dbr_schedule` order = `fill_simple(non-jumps)` → `fill_simple(jumps)` → `fill_eager` → `relax`.

**(a) `fill_simple_delay_slots` can never fill this slot — two independent bars.**
* Its FORWARD half is dead for conditional jumps: the accept test is gated on
  `target == 0`, and `target = JUMP_LABEL(insn) != 0` (reorg.c:3232).
* Its BACKWARD scan dies on the VOLATILE busy read. `mark_referenced_resources`
  does `res->volatil = MEM_VOLATILE_P (x);` (reorg.c:327), and
  `resource_conflicts_p` returns 1 unconditionally when `res1->volatil ||
  res2->volatil`. So the moment the scan walks *past* `lw $2,528486536($5)`,
  `needed.volatil == 1` and **every earlier trial is rejected**. The only two
  insns nearer than the volatile load are `and $2,$2,$3` (sets `$v0`, which the
  branch needs) and `lbu $17,68($sp)` — and a load can never go in a MIPS delay
  slot: `mips.md:73` marks `(eq_attr "type" ... "load" ...)` as `dslot = yes`,
  while `define_delay` (mips.md:119) requires `dslot == "no"` **and** `length == 1`.
  (This also explains why *neither* build puts `lbu s1,68(sp)` in the slot.)

**(b) `fill_eager_delay_slots` DOES try the oracle's insn — and one test refuses it.**
`mostly_true_jump` returns 0 here (`rare_fallthrough - rare_dest == 0`, then
`case EQ: return 0`), so the **fall-through thread is tried FIRST**, i.e. cc1
offers itself exactly `insn 246 (a2 = 65536)`. It is rejected by the single test
`! insn_sets_resource_p (trial, &opposite_needed, 1)` — `$a2` is reported LIVE at
the branch target.

**(c) WHY `$a2` is reported live — this is the correction to the W76 note.**
`mark_target_live_regs(insn 79)`:
* `find_basic_block(insn 79)` (reorg.c:2237) scans backwards for a `BARRIER`.
  There is **none** anywhere between the function head and `$L86` — the loop's
  back-edge is a *conditional* branch, so no barrier follows it. `insn == 0` ⇒
  **it returns block 0**.
* The live-set walk therefore starts at the FIRST INSN OF THE FUNCTION and walks
  *through `insn 246` itself*. `update_live_status` marks `$a2` live **and clears
  its pending-dead bit**, so the `code_label 40` kill can no longer remove it.
  ⇒ **any register the preheader constant could land in is marked live by its own
  defining insn.** The refusal is structural, not an `$a2`/argument-register/pin accident.
* Two further independent reasons `$a2` is in the block-0 live-in set: it is the
  3rd incoming argument (`blocks`), and it is the seat of the pinned `dv`.
* The only escape left is the forward "set-before-used" rescue. On the
  **gcc-2.7.2** lane it stops at the first conditional jump — `jump_insn 80`
  (`bne $17,$2`), ONE insn past the target. What actually kills `$a2` is
  `dv = ch*4` (`sll a2,s0,2`) at index 61, far past it. gcc-2.8's
  `find_dead_or_set_registers` (reorg.c:2485) *does* follow both arms of ONE
  conditional jump (`jump_count += 4`) and would reach it — see §4.

⇒ **Only two escapes exist, and both are now measured:**
* **(E-a)** get the `0x10000` materialisation emitted in the ENTRY block, *after*
  the volatile busy read, where the backward scan can MOVE it into the slot;
* **(E-b)** kill the constant's register between the target label and the first
  conditional jump after it (gcc-2.7.2's whole forward-rescue window).

## 3. EXPERIMENTS — every angle × numeric result

All gated whole-TU; `StCdInterrupt` and `_st_copy_words` held PASS in every row
except where noted; every edit reverted.

### 3.1 The `dv` PIN is NOT the cause (falsifies the W76 framing)
| edit | `_st_dma` | slot |
|---|---|---|
| `register int dv __asm__("$6")` → `int dv;` | FAIL 47 (107/106) | **unchanged**: `li v0,1` still inserted before `lui a2,1` |

The +1 `li v0,1` row is present verbatim without the pin ⇒ the delay-slot residual
is pin-independent, and removing the pin only re-damages the seat (the W76 cell).

### 3.2 E-a: get the constant into the entry block (named-limit family)
`int limit;` + `limit = 0x10000;` + `if (i == limit)`. This **does** move
`li $6,0x10000` out of the preheader into the entry block (contradicting the W76
note's "entry-block li lands ABOVE the branch and is STILL not taken" only in its
*reason* — it lands at entry index 10, not adjacent to the branch):

| variant | `_st_dma` | where `li $6` lands |
|---|---|---|
| `p1_first` (limit assigned before `mode`) | FAIL 3 (107/106) | entry idx 10 |
| `p2_mid` (between `mode` and `i=0`) | FAIL 3 (107/106) | entry idx 10 |
| `p3_last` (after `i=0`) | FAIL 3 (107/106) | entry idx 10 |
| `p6_from_mode` (`0x10000 + (mode & 0)`) | FAIL 3 (107/106) | entry idx 10 (folded) |
| `p7_from_ch` (`0x10000 + (ch & 0)`) | FAIL 3 (107/106) | entry idx 10 (folded) |
| `p8_forinit` (`for (i=0, limit=0x10000; ...)`) | FAIL 3 (107/106) | entry idx 10 |
| `p9_unsigned` (`unsigned limit`) | FAIL 3 (107/106) | entry idx 10 |
| `p4_incond` (`... && (limit = 0x10000) != 0`) | FAIL 1 (107/106) | back in the preheader (== base) |
| `p5_comma` (`(limit = 0x10000), busy`) | FAIL 21 (107/106) | entry, `$a1` seat, cascade |

The 3-diff rows are exactly base + `lui a2,1` moved to index 10 (`-lui a2,1 /
-li v0,1 / +lui a2,1`); every other insn still matches. **Source POSITION of the
assignment is completely inert** — sched2 ignores it.

### 3.3 WHY entry-block placement can't reach the branch — the sched2 instrument
`-dR` prints the scheduler's priorities and ready lists (new instrument for this
function). Entry block (`p3_last`):

```
;; insn[  23]: priority = 1   (lbu $17,68($sp)   = mode)
;; insn[  29]: priority = 1   (li $6,65536       = limit)   <- the oracle's slot insn
;; insn[ 228]: priority = 2   (and $2,$2,$3)
;; ready list at T-2: 10 (1) 23 (1) 26 (1) 29 (1) 228 (2), now 228 23 29 26 10
;; ready list at T-3: 23 (1) 29 (1) 26 (1) 10 (1) 227 (1), now 23 227 29 26 10
;; launching 226 before 23 with no stalls at T-4
;; insn 226 has a greater potential hazard, now 226 227 29 26 10
```

Reading it: the scheduler runs **backwards** (T-1 = last insn). T-2 places the
`and`; the load `lw`(226) then needs one gap, so **T-3 is a single load-delay
filler slot**, and T-4 is the load. Consequences, all confirmed by the trace:
* `li $6` has **priority 1** — its only LOG_LINK is a `REG_DEP_ANTI` on the
  prologue `s3 = a2` (anti-deps carry `insn_cost` 0), so it can never outrank
  anything. Raising its priority needs a genuine DATA predecessor, i.e. an
  arithmetic insn = +1 insn (that is what the `& 0` variants tried; gcc folds them).
* The T-3 filler slot goes to `lbu`(23) and T-4 to `lw`(226) because of
  `schedule_select`'s hazard promotion (`insn 226 has a greater potential
  hazard`) — the same mechanism as the SPCH_Init certificate. **The one position
  after the volatile read is structurally reserved for a load-class insn**, and
  the oracle keeps `lbu s1,68(sp)` there (retail index 17). So `li $6` cannot
  occupy it without evicting `lbu`, which costs 2 diffs to save 1.
⇒ **E-a is closed**: with `lbu` present, at most ONE insn fits between the
volatile read and the `and`, and the scheduler gives it to the load.

### 3.4 E-b: kill the constant's register in the rescue window
Three constructions, all diagnostics (expected to damage other rows):
| construction | `_st_dma` | guard slot |
|---|---|---|
| `diag = ch*4;` (pinned `$6`) hoisted before the `mode` test | FAIL 46 (106/106) | `li v0,1` — INCONCLUSIVE: the `sll $6,$16,2` was swallowed into the `bne`'s own delay slot by `fill_simple` *before* `fill_eager` ran, so it was never in the window |
| `diag = debug_cause;` (load, not slot-eligible) in the window | FAIL 47 (107/106) | `li v0,1` — INCONCLUSIVE: the load was dead-code-eliminated |
| whole `dv = ch*4; bit = 1<<(dv+3);` block hoisted above the `mode` test | FAIL 41 (**105**/106) | `sll $6,$16,2` — the TARGET thread changed, so the fill took the new first insn; not the fall-through steal |
E-b cannot be constructed without putting extra insns into the `$L86` block, and
the oracle's `$L86` block is exactly `li v0,1; bne s1,v0` (2 insns, same as ours).
⇒ **E-b is unusable even if reachable.**

### 3.5 COMPILER-VINTAGE AXIS — re-run at the CURRENT (post-W76) basin
Whole-lane gate via `NFS4_FORCE_CC1_ALT`, plus a direct cc1-on-the-`.i` slot probe
for the retail candidates that are not wired into the ladder:

| rung | `_st_dma` | guard slot |
|---|---|---|
| 2.6.0 | FAIL 1 (107/106) | `li $2,1` (copy) |
| 2.6.3 | FAIL 1 (107/106) | `li $2,1` (copy) |
| **2.7.2 (wired)** | **FAIL 1 (107/106)** | `li $2,1` (copy) |
| 2.7.2-970404 | FAIL 47 (103/106); **StCdInterrupt FAIL 738 (541/583)** | `addu $3,$5,$6` (steal) |
| 2.8.0 | FAIL 50 (102/106) | `addu $3,$5,$6` (steal) |
| 2.8.1 | FAIL 50 (102/106) | `addu $3,$5,$6` (steal) |
| gcc-2.7.2-sn0001 / sn0002 / sn0003 (retail SN) | (slot probe) | `li $2,1` (copy) |
| gcc-2.7.2-970404-sn0004 (retail SN) | (slot probe) | `addu $3,$5,$6` (steal) |
| gcc-2.7.2-glover / gcc-glover (retail) | (slot probe) | `li $2,1` (copy) |
| gcc-2.8.0-psyq43 / gcc-psyq43 (retail) | (slot probe) | `addu $3,$5,$6` (steal) |

**The split is exactly the reorg change**: every rung ≤ 2.7.2 copies from the
target thread; every rung ≥ 2.7.2-970404 performs a steal — that is when
`find_dead_or_set_registers`'s "follow both arms of ONE conditional jump" arrived,
which is the only thing that can remove `$a2` from `opposite_needed` here.
But every stealing rung also carries the post-2.7.2 **address CSE** (`lui a2,8064;
addu v0,a1,a2` hoisted out of the busy loop instead of rematerialised), which the
oracle does NOT have — 970404 is 103 insns and destroys `StCdInterrupt` (738).
⇒ **no retail rung on disk gives 2.7.2 codegen + post-2.7.2 reorg.**

## 4. VERDICT / CERTIFICATE (sharper than W76's)

The residual is **not** a source-shape problem and **not** the `dv` pin. On the
wired gcc-2.7.2 lane it is provably unreachable:

1. `fill_simple`'s backward scan is barred by `resource_conflicts_p`'s
   unconditional `volatil` clause the instant it passes the (semantically
   required) volatile busy read; the only two insns nearer the branch are the
   branch's own input and a load, and MIPS `define_delay` forbids loads.
2. `fill_eager`'s fall-through steal — which cc1 *does* attempt first here — is
   barred because `find_basic_block` finds no `BARRIER` before `$L86`, falls back
   to block 0, and the live-set walk passes through the constant's own defining
   insn. This holds for **any** register and **any** placement of that constant.
3. The forward rescue that would undo (2) stops at the first conditional jump on
   gcc-2.7.2 and only exists from the 970404 snapshot on, where the address-CSE
   change simultaneously breaks the rest of the TU.

**NEXT NAMED ANGLES (unmeasured, for whoever picks this up):**
* **A retail cc1 in the 2.7.2 codegen family carrying the post-2.7.2 reorg** is
  the exact acquisition target (the same shape as the FntFlush vendor-identity
  certificate). Candidates not on disk: gcc 2.7.2.1/2.7.2.2/2.7.2.3 PSX builds,
  other SN Systems cc1 drops between the sn0003 and sn0004(970404) vintages.
  The discriminator is a 5-second probe: run cc1 on
  `scratchpad/w84/rtl/stcdint.i` and look at the insn after `beq $2,$0,$L86`
  (`li $2,1` = 2.7.2 reorg, anything else = post-2.7.2 reorg).
* **Per-fn `{cc1 version} × {flags}` splice**: if the 970404 rung's residual is
  purely the address CSE, a `-fno-...`/source rematerialisation lever (§3.12 #1
  index-form / rematerialise-don't-hoist) might bring 103 → 106 on that rung.
  Requires `build.py` PER_FN_CC1_VER_SPLICE wiring = orchestrator action, and the
  970404 lane must be per-FUNCTION (whole-TU it costs StCdInterrupt 738).
  Priced: unmeasured, but the 47-diff distance is a fresh basin, not a plateau.
* Not worth re-running: source position of the limit assignment (7 spellings,
  all inert), `& 0`-style fake dependences (folded), the `dv` pin (independent),
  the whole 2.6.x–2.8.1 ladder (table above).
