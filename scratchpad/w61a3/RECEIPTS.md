# W61-A3 — `recon/syslib/psx/libmcrd/LIBMCRD.c` + `recon/syslib/psx/2mbyte/2mbyte.c`

Gate: `python tools/tugate.py <file>` / `python tools/verify_asm.py <file> <Fn>`
(every number below re-gated by me; `-` = ours, `+` = oracle).

**TU: 21/26 → 22/26 PASS. Belt total 258 → 138 diffs (−120).**
`tu_order_audit.py` = **0 inversions** before and after. Zero PASS→FAIL.

| fn | baseline (re-gated) | final | lever |
|---|---|---|---|
| MemCardCmd_cb | 17 | **PASS 141/141** | block-local anchors + arm order + head-of-thread barrier |
| MemCardDeleteFile | 57 | **23** | reqdelta272 multi-pseudo rotation + 2nd anchor + fence position + exit-block placement |
| MemCardCreateFile | 68 | **30** | same recipe ported, priced in 5 steps |
| MemCardExist_cb | 47 | **41** | block-local anchors |
| MemCardGetDirentry | 69 | **44** | idx+fretry ref-step pair-lift + blez-side guard |
| 2mbyte `stup0` | briefing said 42.86% | **already 4/4 PASS** | briefing row is STALE (see §6) |

Commits (own file only, never `tools/`): `4ae2a04f`, `dddebd32`, `99084fea`, `a601c703`.

---

## 1. LAW — DIAL THE WHOLE ORDER, NOT ONE PAIR (DeleteFile 57 → 47)

w60-a2 filed "a THREE-way rotation, so a single-pseudo ref/live delta cannot
express it" as a floor-shaped named angle. Both halves were true and beside the
point: **a rotation is a total order**, so you dial every pseudo that has to
move, simultaneously, and you price the *order* rather than a pair.

`tools/reqdelta272.py` gives the whole ordered table with each neighbour's flip
cost under the real 2.7.2 rule `pri = floor_log2(refs)*refs/live` (no SIZE
term — 12A). Retail's order is `file > retry > chan > base`; ours was
`base > retry > file > chan`. Three read-only fences, sized off the table:

| pseudo | refs | pri before | dial | pri after | home |
|---|---|---|---|---|---|
| `file` | 2 → 4 | 0.222 | 2 operands, depth 0 | 0.889 | `$s0` |
| `retry` | 7 → 9 | 0.241 | 1 operand **inside the loop** (×2) | 0.466 | `$s1` |
| `chan` | 4 → 8 | 0.131 | 2 operands **inside the loop** | 0.393 | `$s2` |
| `base` | — | 0.246 | untouched | 0.246 | `$s3` |

**Predicted handout == measured handout**, read back off `qty272.py`. The
loop-depth weighting is exact: gcc's `REG_N_REFS` counts each reference once per
loop depth + 1, so one fence operand inside a single loop is worth **two** refs.
That is the granularity knob — it is how `chan` gets +4 from two operands.

w60-a2's falsifications (`PROMOTE file` alone = 67, `DEMOTE base` alone = inert)
are both *reproduced and explained*: promoting one pseudo out of a 3-cycle just
makes a different wrong order.

## 2. LAW — A FENCE'S POSITION IS A SECOND, INDEPENDENT DIAL (29 → 23)

The same `file` fence, same operand count, moved from *after* `strcat` to
*above* the busy guard, is worth 6 diffs. Above the guard it additionally forces
`assign_parms`' file copy into the prologue group (retail's
`sw $s0,56($sp); addu $s0,$a1,$zero` pair) instead of leaving it as the last
insn before the guard load — where reorg steals it into the `beqz` slot and
retail's `retry = 0` can never land there. One edit fixes the parm-copy order,
the save order *and* the delay slot.

## 3. THE SECOND ANCHOR — AND WHY IT MUST BE PLAIN (47 → 37 → 34)

Retail runs the head guard off one materialization (`$s3`) and hands it to a
SECOND pointer (`addu $s0,$s3,$zero` in the loop preheader, freeing `$s3` for
the hoisted `li 2`). A **plain** `p = base;` reproduces it, because
cse2-after-loop rewrites the hoisted `&mc.cmd` as a reg COPY of the live base.

An opacity fence on `p` is measurably WORSE (37 vs 34): it makes `*p`
may-alias `_mc_save_cb`, so sched1 can no longer hoist retail's `lw $v1,0($s0)`
above that store (8 diffs). **New sub-rule for the fence toolkit: an opacity
fence on a POINTER is also an ALIAS barrier, not just a value barrier.**

Cost of the plain form, and the rule that explains it:

> **A LOAD at a non-zero offset through a known-constant pointer constant-folds
> back to the `lui;lw` assembler macro; a STORE at a non-zero offset does not.**

That is why `p[3]` (the `_mc_present |= 1 << mc.chan` read) costs 2 diffs while
`p[0..2] = …` stay base-relative — and it is the general reason the fenced-anchor
idiom exists in this TU at all.

## 4. EXIT-BLOCK PLACEMENT, BOTH DIRECTIONS (12C generalised)

* **Push a block to the tail** (DeleteFile 34 → 29, CreateFile 39 → 34): retail's
  success exit is the LAST block before the epilogue. Written inline in the loop,
  gcc emits it right after the busy-return block and displaces `retry = 0`.
  Fix: `goto erased;` with `erased: return 0;` placed **after** `return rslt;`.
* **Pull a block forward** (CreateFile 34 → 30): retail's `return 7` sits with the
  other early exits, ours was at the tail. Fix: w60-a2's `if (0) { nocard: … }`
  device, placed exactly where retail's block is.

So the 12C device is bidirectional: the labelled block lands where you write it,
and `if (0) { }` / a post-`return` label are the two zero-insn spellings.

## 5. 🏆 THE BLOCK-LOCAL ANCHOR LAW — Cmd_cb 17 → PASS, Exist_cb 47 → 41

This is the wave's transferable result. It answers the whole class methodology
§4.6 de-prioritised as "local-alloc QTY handouts, outside the model".

**Symptom:** retail's per-arm registers are the exact MIRROR of ours
(`sw $v1,4($v0)` vs `sw $v0,4($v1)`) at every site that stores through the same
pointer variable, and no ref/live dial moves them (w60-a2 measured four
inert fence sizes here).

**Cause:** a single *function-scope* anchor referenced from three arms is a
GLOBAL allocno. `local_alloc` runs FIRST and has already handed each arm's own
block-local qty `$v0` before `global.c` places the anchor, which therefore lands
in `$v1` — and every store in the function comes out mirrored.

**Fix — change the anchor's SCOPE, not its refs.** Declaring the pointer inside
the arm makes it a block-local QTY whose `local_alloc` priority
(`refs/live = 3/3`) beats the value qty's (`2/4`), so it takes `$v0` and the
value falls to `$v1` = retail. Cmd_cb: −6 per arm, two arms. Exist_cb: −6.

> **RULE: scope is the lever that moves a pseudo between the two allocators.
> If retail's registers are the mirror of ours and several arms share one
> pointer variable, SPLIT the variable — do not dial it.**

`qty272.py` prints the local table directly (`-dl`'s `;; Register N in H.`), so
this class is no longer instrument-blind on the 272 lane.

### 5b. Cmd_cb's last two diffs — ARM ORDER + the HEAD-OF-THREAD BARRIER

* **Arm order (5 → 4).** Retail branches `beqz` with the ZERO arm as the branch
  target and the `li 3` arm as the fall-through ⇒ the source test is
  `if (cleared != 0) { rslt = 3; } else { rslt = 0; }`, not the natural `== 0`.
* **Head-of-thread barrier (4 → PASS).** reorg still filled the `beqz` slot from
  the FALL-THROUGH thread. `mostly_true_jump` (reorg.c) scores an EQ branch 0 =
  "unlikely", and `fill_eager_delay_slots` then tries the fall-through thread
  FIRST. A zero-insn `__asm__("" : : "i"(0));` as the **first statement of the
  thread you do not want it to take** makes that thread unstealable, so reorg
  falls through to the target thread and reproduces retail's slot — and the
  extra `j; nop` block our zero arm needed disappears (143 → 141 insns).

> **CATALOG CANDIDATE: "reorg took the wrong delay-slot thread" is dialable —
> put a zero-insn barrier at the HEAD of the thread you want it to skip.**

## 6. GetDirentry 69 → 44 — LIFT THE THIRD ALLOCNO TOO

Two standing receipts here are now refuted:

* "the TU-wide base-anchor law does not pay here… it needs a 9th saved reg"
  — it needs **no anchor local at all**. The base register retail uses is the
  compiler's OWN cse-created base for the `mc` struct; our build already has it
  (`$s2`). It was merely ranked one place too high. Frame stays `0x90`.
* the pair to flip is `base` ↔ `fretry`, and `idx` sits **in the gap**:

| pseudo | refs / live | pri | after +1 ref | home |
|---|---|---|---|---|
| `idx` | 11 / 51 | 0.6470 | 0.7059 | `$s1` |
| `base` (compiler's) | 16 / 100 | 0.6400 | — | `$s3` |
| `fretry` | 10 / 49 | 0.6122 | 0.6735 | `$s2` |

The window between `idx` and `base` is 0.007 wide, so `fretry` cannot be lifted
into it alone. **Lift both**: two 1-operand read-only fences at loop depth 0.
69 → 54.

> **RULE: when a pair will not flip because a THIRD allocno sits in the gap,
> move the third one up as well. Only the ORDER matters, never the absolute
> priorities.**

Then the guard written blez-side (`if (mc.cmd > 0) printf; else latch` — the
shape Create/DeleteFile already used) puts the latch block out-of-line: 54 → 44.

## 7. NAMED ANGLE (mechanism closed, worth 15 diffs × 2 fns) — the INLINED MemCardSync anchor

In both callers, retail's inlined copy of `MemCardSync` reaches cmd/rslt/done
through the CALLER's anchor (`$s0`) and materialises a separate `lui;addiu` only
for the spin address; ours materialises its own anchor inside the loop and
rebases it. Retail also keeps the two DEAD snapshot loads our copy DCEs.

Measured, all in the post-rotation basin:

| probe | result |
|---|---|
| drop the fence entirely | Sync 0→3, DeleteFile 34→39, CreateFile →73 |
| make the fence non-volatile | byte-identical whole-TU (flavour is NOT the lever) |
| shared `static __inline__ int *mc_anchor(void)` (ONE source line for both fences) | DeleteFile 48, CreateFile 41 |

The shared-line rationale is *correct but insufficient*, and it is worth
recording as the cse-side half of 12C: **`cse.c`'s `exp_equiv_p` compares the
generic `'i'` fields (cse.c, the `case 'i': if (XINT(x,i) != XINT(y,i))` arm of
the element loop), and `ASM_OPERANDS` carries `ASM_OPERANDS_SOURCE_LINE` as one
— so two fences on the SAME line ARE cse-equal**, exactly as `jump.c`'s
`rtx_renumbered_equal_p` makes them cross_jump-equal. It still does not merge
here because the caller's anchor is in the loop PREHEADER and the inlined body
is inside the loop: different extended basic blocks, and cse's table resets at an
EBB boundary. `invariant_p` (loop.c) *does* accept a non-volatile
`ASM_OPERANDS`, but `scan_loop` declines to hoist it (`maybe_never` is set by the
branches above it).

**SHARPENED ANGLE:** get the inlined anchor into the loop PREHEADER, where
cse2-after-loop can merge it — a device that is loop-hoistable AND
opacity-preserving. `-dL`/`-dS` on `MemCardDeleteFile` will show exactly why
`scan_loop` declines the asm. That is the next experiment, not another spelling.

## 8. Other falsifications (do not re-fight)

* DeleteFile, post-rotation: retry fence moved out of the loop = 29 (inert).
* CreateFile: dropping the base opacity fence 39 → 68; `p = &mc.cmd` instead of
  `p = base` 39 → 60. **CreateFile and DeleteFile measure OPPOSITELY on the head
  fence** — A/B per function, as the old receipt already warned.
* Exist_cb, post-split basin: fenced `long ret = 1;` after the call = 41 but
  +2 insns (116→118); 12D dead-pseudo staging (reuse the dead `c` as the result
  carrier) = 52.
* Exist_cb's now-dead `int *pc;` decl removed; re-gated 41 → 41, so it was not
  load-bearing.

## 9. 2mbyte / `stup0` — the briefing row is STALE

`python tools/tugate.py recon/syslib/psx/2mbyte/2mbyte.c` → **4/4 PASS**
(`__main`, `__SN_ENTRY_POINT`/`stup2`, `stup1`, `stup0`). The TU is already the
correct reconstruction: genuine hand-written SN Systems crt0 transcribed as
file-scope `__asm__`, byte-identical to all four oracle `.s` files, with the
"code-as-data island" table inside `stup0`. Nothing to do; the 42.86% figure
predates the w48-a7 fix that added `__main`.

---

## Orchestrator items

1. **`tools/sbsx.py` ROOT bug still open** (w60-a2 filed it twice):
   `Path(__file__).resolve().parents[2]` must be `parents[1]` — from `tools/` it
   resolves to `C:\Temp`. I again had to run a scratchpad copy.
2. Catalog rows worth harvesting: §1 (dial the whole order), §2 (fence position
   as an independent dial), §3 (opacity fence on a pointer = alias barrier;
   load-folds/store-doesn't), §4 (12C is bidirectional), §5 (**the block-local
   anchor law** — the highest-value row), §5b (head-of-thread barrier for reorg's
   thread choice), §6 (lift the third allocno), §7 (cse-side of 12C).
3. No `tools/build.py` change was needed this run — every landing is source-only,
   pin-free, zero-insn devices plus statement/block placement.

## Files touched / backups

* `recon/syslib/psx/libmcrd/LIBMCRD.c` (only file modified).
* Backups after every landing in `scratchpad/w61a3/`:
  `LIBMCRD.c.bak_base` (57/68/47/69 baseline), `…_rot47`, `…_p2_37`, `…_c2_34`,
  `…_d29`, `…_d23`, `…_cf39`, `…_c34`, `…_c30`, `…_g54`, `…_g44`, `…_cmd11`,
  `…_cmd5`, `…_cmd4`, `…_cmdPASS`, `…_ex41`, `…_pre_receipts`.
* Tooling: `ed.py` (CRLF-safe byte replace with a match-count assert — the 12K
  discipline in one script), `sbs.py`/`sbs2.py`/`probe.py` (copied from w60a2),
  `mk_*.py` payload builders (Write-tool authored; heredocs collapse `\\`).

## Hazards hit

* **Heredoc `\\` collapse fired again** (12K hazard #8-12): a `printf("…\n")`
  payload built inside a quoted bash heredoc silently lost its backslash and the
  match count went to 0. Every escape-bearing payload after that was built with
  the Write tool or from `bytes([92])`.
* `cat -A` through Git Bash shows CRLF files as LF — do not use it to decide line
  endings; derive them in Python (`b.count(b'\r\n')` vs `b.count(b'\n')`).
* A `J(*lines)` helper that appends a trailing newline silently fails to match
  when the anchor ends mid-line — the match-count assert caught it both times.
