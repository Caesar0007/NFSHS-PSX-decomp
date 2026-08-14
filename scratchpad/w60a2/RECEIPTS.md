# W60-A2 — `recon/syslib/psx/libmcrd/LIBMCRD.c` (272 lane)

Gate: `python tools/tugate.py recon/syslib/psx/libmcrd/LIBMCRD.c`
(every number below re-gated by me; `-` = ours, `+` = oracle).

**TU: 15/26 → 19/26 PASS. 24 order inversions → 0. Two real bugs' worth of
diff removed (one genuine uninitialised-local bug).**

| fn | before | after | lever |
|---|---|---|---|
| MemCardReadFile_cb | 3 | **PASS 66/66** | PER_FN_TEXT_MOVES dispatch-slot row |
| MemCardWriteFile_cb | 3 | **PASS 66/66** | same |
| MemCardFormat | 4 | **PASS 35/35** | `-fno-delayed-branch` FLAG_SPLICE_272 + a TEXT_MOVES row |
| MemCardUnformat | 5 | **PASS 45/45** | named fill byte (5→3) + out-of-line return-0 block placement (3→0) |
| MemCardCmd_cb | 55 | **17** | uninit-`e` BUG fix (55→47) + floor_log2 ref-step dial on `st` (47→17) |
| MemCardReadData_cb | 4 | **1** | TEXT_MOVES dispatch-slot row |
| MemCardWriteData_cb | 4 | **1** | same |
| MemCardExist_cb | 47 | 47 | unchanged (named angle stands) |
| MemCardDeleteFile | 57 | 57 | unchanged (dial falsified, see below) |
| MemCardCreateFile | 68 | 68 | unchanged |
| MemCardGetDirentry | 69 | 69 | unchanged (W59 real-bug fix re-baselined: still 69, ours 149 / oracle 152) |

Commits: `43150145` (reorder) · `ec113270` (*_cb TEXT_MOVES) · `17b9caa7`
(Format) · `39c986c0` (Unformat) · `799ff65e` (Cmd_cb).

---

## 1. MSC02 — 24 intra-TU order inversions → 0 (`43150145`)

All 26 function blocks relocated into `configs/symbol_addrs.txt` VA order
(0x800FAAAC MemCardInit … 0x800FC1F4 MemCardMakeDevname). Pure block motion —
the reorder script asserted the non-blank-line MULTISET was unchanged; file-scope
data/statics and the pre-existing forward declarations stayed put (no new
forward decls were needed; every static already had one). CRLF preserved
(1720 CRLF before and after, byte length identical).

tugate 15/26 PASS **and every per-fn diff count identical** before/after
(3/3/4/4/4/5/47/55/57/68/69) ⇒ zero codegen effect, as the class predicts.
`tools/tu_order_audit.py` silent for this TU afterwards, and still silent at
the end of the run.

## 2. The four `*_cb` state-dispatch twins (`ec113270`)

One shared residual: gcc's `balance_case_nodes` emits the bound test
`beq $2,$0,$L<hi-subtree>` and the hi subtree opens with its own compare
constant. Retail carries that constant **in the bound test's delay slot** with
the label moved past it:

```
-  nop                  |  +  li v0,11      (ReadFile/WriteFile)
-  li v0,11             |                   (…30 for the Data twins)
```

**This is 09L exactly** — the candidate WRITES `$2`, the `beq` READS `$2`, so
gcc reorg can never place it — and `mostly_true_jump` scores an EQ forward
branch 0 on top. Resolved with a `PER_FN_TEXT_MOVES` `slot:True` row per twin.
Semantics-preserving: the constant is dead on the fall-through path (the next
branch's own slot writes `addu $2,$0,$0`), which is why retail could do it.

**Ladder first (04Z, in the post-reorder basin)**, whole-TU:

| rung | verdict |
|---|---|
| 2.6.3 | 15/26; the four twins IDENTICAL (3/3/4/4); Format 4→14, Cmd_cb 55→66, CreateFile 68→76, GetDirentry 69→87 |
| **2.7.2 (wired)** | 15/26 baseline |
| 2.7.2-970404 | catastrophic (Exist_cb 102, GetDirentry 136, 11 more fns fall out) |
| 2.8.0 | catastrophic (GetDirentry 160) |
| 2.8.1 | catastrophic (GetDirentry 160) |

⇒ the class is compiler-version-INVARIANT, not a rung. 2.7.2 confirmed correct
for this TU.

## 3. MemCardFormat 4 → PASS (`17b9caa7`)

The w52-a6/w55-a7 angle asked for "a ZERO-INSN way to make the arg `addiu`
issue before the store macro", and w46 had already named the obstacle: the arg
address `(plus (reg sp) (const_int 16))` has `rtx_cost <= 2`, so it is
SCHED_GROUP'd onto the CALL_INSN — "it can only be displaced by making the
STORE the later insn".

**`-fno-delayed-branch` IS that displacement.** cc1 then emits
`addu $5,$sp,16` BEFORE `sw $3,_mc_present`, and GNU-as backward-fills the
store MACRO's `%lo` half into the jal slot — retail's
`addiu $a1,$sp,16 / lui $at,%hi / jal / sw $v1,%lo($at)`, the W51 272-lane
AT-MACRO-SPLIT identity. 4 → 1.

Cost: the fn's OTHER gcc-filled slot goes empty (`bne $2,$0,$L` + the busy
return `li $2,1`) — 09L again. Restored by a TEXT_MOVES row that runs AFTER the
splice (label regex `\$L\w+`, because the spliced region carries the splice's
uniquified `$Lfs0_0_NNN` names). 1 → PASS.

Falsified on the same probe: `-fno-schedule-insns` 4→18,
`-fno-schedule-insns2` 4→6.

## 4. MemCardUnformat 5 → PASS (`39c986c0`) — **two new laws**

**(a) NAMED FILL BYTE (5 → 3).** Retail materializes the fill constant BEFORE
the counter (`addiu $v1,$zero,-1; addiu $s0,$zero,0x7F`). Written as the
literal `buf[blk] = -1` inside the loop, the −1 is a loop INVARIANT that loop.c
hoists into the preheader AFTER the for-init ⇒ reversed order. A plain
`fill = -1;` statement before the loop emits it first.

**(b) 🏆 OUT-OF-LINE EXIT BLOCK VIA PLACEMENT (3 → PASS) — catalog candidate.**
Retail's failure exit is a standalone 2-insn block between the busy guard's
`return -1` and the fill loop: `.L800FC0A4: j <epi>; addu $v0,$zero,$zero`
(the zero IS the `j`'s delay slot), and the loop's `bnez` fills its OWN slot
with the unconditional `blk++`. Written inline in the loop, `return 0;` puts
the landing pad ON the epilogue, the `j` folds away, and reorg STEALS the bare
`addu $v0,$zero,$zero` into the bnez slot — ours 1 insn shorter, 3 diffs.

Fix = **placement, not spelling**:

```c
if (0) {
failed:
    return 0;
}
...
    if (_get_card_event_x() != 0) goto failed;
```

gcc drops the dead branch and keeps the labelled block at THAT point in the
RTL. reorg then processes the block's unconditional `j` FIRST and fills its
slot with the `addu`, turning it into a SEQUENCE; `stop_search_p` refuses to
search a thread starting with a SEQUENCE/JUMP_INSN, so the later `bnez` can no
longer steal from it and falls back to a plain backward fill.

> **LAW (generalizes past libmcrd):** when ours is exactly 1 insn SHORT because
> reorg stole a shared exit's value-setup into a branch delay slot, the lever is
> the exit block's PLACEMENT, not its spelling. An exit block that is NOT
> adjacent to the epilogue keeps a real `j`, and that `j`'s own filled slot
> makes the block steal-proof. `if (0) { label: … }` is the zero-insn placement
> device.

Falsified in the post-`fill` 3-diff basin (272 lane, per-fn flag splice):
`-fno-delayed-branch` 12, `-fno-strength-reduce` 11, `-fno-schedule-insns2` 7,
`-fno-schedule-insns` 3, `-fno-thread-jumps` 3.

## 5. MemCardCmd_cb 55 → 17 (`799ff65e`) — a real bug + the priced dial

**🔴 REAL BUG (55 → 47).** The `ctail` re-read wrote `ev = _mc_evrslt;` but every
use below reads `e` — a local that is **never assigned**. Both the `e == 4`
test and the two consumers (`pc[1] = e`, `MemCardEventToRslt(e)`) read an
uninitialised value, so on the ev==4 path libmcrd stored garbage into
`mc.rslt` as the command result. The in-source w53-a7 note's own wording
("a SEPARATE local for the tail's re-read of _mc_evrslt") shows `e` was the
intended target. Worth 8 diffs on its own.

**🏆 NAMED ANGLE (a) CLOSED (47 → 17): the `$s0`↔`$s1` swap.** It is a
`global_alloc` PRIORITY tie (`priority ~ floor_log2(refs)*refs/live_length`;
the first allocno takes the lowest free callee-saved reg, `$s0`=`$16`). Retail
hands `$s0` to the `pv` param and `$s1` to the case-10 `&mc.rslt` anchor; ours
was reversed because the anchor's live range is one case arm while `st` spans
the whole function. Priced with the floor_log2 REF-STEP dial — ONE zero-insn
read-only fence on `st`, sized until the count crosses a step:

| read-only fence operands on `st` (each = +1 ref) | diffs |
|---|---|
| 1 / 4 / 5 / 6 / 7 | 47 |
| **8** | **17** |
| 9 / 10 | 17 |
| 12 / 16 | CC1PSX asm-operand limit (compile fails) |

8 is the minimum that lands the step. The swap cascaded through every
`0($sN)` state access ⇒ one fence took 30 diffs. **The operand COUNT is the
dial — do not "tidy" the list.**

Residual 17 = two LOCAL-alloc QTY `$v0`/`$v1` swaps (the `cdone` tail's
rslt-vs-anchor pair, whose knock-on is the one cross-jump-merged `li $v0,1`
that makes ours 140 vs oracle 141; and the `ctail` ev==4 anchor).
FALSIFIED: 2 extra identity fences on `pc` in the ev==4 arm = inert at 17.
Per methodology §4.6 these are outside allocsim/reqdelta's global model.

## 6. Falsified, not landed

**`*Data_cb` twins' last diff (`+addu a0,zero,zero`) — the w55-a7 angle.**
Tried the catalog wave-13 **UNSIZED-ARRAY ASM-LABEL VIEW**
(`extern int mc_words[] __asm__("mc"); mc_words[1] = r;`) with fully duplicated
`MemCardEventToRslt` arms:

* it **DOES** buy the post-reload `cross_jump` the angle asked for — the two
  tails merged and retail's `addu $a0,$zero,$zero` block appeared, so **that
  half of the angle is CONFIRMED source-reachable**;
* but with a **CONSTANT** element index gcc-2.7.2 folds the access straight back
  to a MEM at `(symbol_ref mc + 4)` and emits the 2-insn `lui $at; sw %lo` macro,
  losing retail's `lui $v1; addiu $v1; sw $v0,4($v1)` store form.

Measured on MemCardWriteData_cb: fenced `pc` anchor + single shared call = **1**;
`mc_words[]` view + duplicated arms = **5**. Reverted, receipted in-source.

> **Catalog refinement:** the asm-label-view lever needs a NON-constant index
> (or an address that outlives folding) to make the `%hi` an RTL pseudo. On a
> constant-offset field store the fenced `int *pc = &mc.cmd;` anchor is still the
> only device that holds the base in a register — and it blocks `cross_jump`.
> Sharpened angle: a device that is BOTH cross_jump-transparent (not an
> `__asm__`) AND holds `&mc` in a register.

**MemCardDeleteFile's saved-reg ROTATION.** The dial that cracked Cmd_cb does
not reach it (retail `chan=$s2 / file=$s0 / base=$s3→$s0`; ours
`base=$s0 / file=$s2 / chan=$s3`):

| probe | diffs |
|---|---|
| baseline | 57 |
| PROMOTE `file` — read-only fence, 2 / 4 / 6 / 8 / 10 operands | 67 (every count) |
| DEMOTE `base` — late read-only fence, 1 / 4 operands | 57 (inert) |

Cmd_cb's was a TWO-allocno tie (one step flips the pair); this is a THREE-way
rotation, which no single-pseudo ref/live delta can express. **NAMED ANGLE:**
dump `-dg`/`-dl` for this fn and run
`tools/reqdelta.py --want "file=s0,chan=s2,base=s3"` for the minimal MULTI-pseudo
delta instead of hand-dialling one pseudo at a time. Same applies to
MemCardCreateFile (68), its twin.

---

## Tooling written (scratchpad, reusable)

* `scratchpad/w60a2/probe.py <patchfile> <recon-file> <Fn[,Fn…]>` — runs
  `tools/verify_asm.py` **unmodified on disk**, exec'ing a candidate build.py
  table patch into its namespace right after it loads `bld`. Lets a
  `PER_FN_*` table be A/B'd **without editing `tools/build.py` mid-wave**
  (which 10 agents share). Patches used: `patch_moves.py`, `patch_flag.py`
  (env-parameterised `W60A2_FLAG` / `W60A2_FNS`), `patch_format.py`.
* `scratchpad/w60a2/sbs.py` / `sbs2.py` — side-by-side ours|oracle with X marks
  (`sbs2` takes a probe patch). **`tools/sbsx.py` is BROKEN as promoted**: it
  uses `Path(__file__).resolve().parents[2]` for ROOT, which was right in a
  `scratchpad/<agent>/` directory but resolves to `C:\Temp` from `tools/`
  (`FileNotFoundError: C:\Temp\tools\verify_asm.py`). One-line fix →
  `parents[1]`. Orchestrator action.
* `scratchpad/w60a2/reorder_libmcrd.py` — the VA-order block reorderer with the
  content-multiset assertion (generic enough for any `/* @0xVA` -commented TU).

## Hazards hit

* **build.py concurrency is real.** W60-A5 added `PER_FN_CC1_VER_SPLICE` to
  `tools/build.py` while I had my own edit pending. `git add tools/build.py`
  would have committed their half-finished work. Both my commits staged only my
  own hunks, extracted with a script that splits `git diff` into hunks and keeps
  the ones containing my `w60-a2` tag, then `git apply --cached`. Recommend that
  as the standard procedure for any shared-file edit in a fan-out wave.
* `git status --cached` is not a thing (`git diff --cached` is) — the typo broke
  an `&&` chain so a commit silently did not run, and another agent's
  pathspec-limited commit landed in between. Verified my index survived it.
