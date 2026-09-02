# W85-M7 receipt — three JPN regional near-misses

Gate (authoritative, every number below is a real run):
```
python regiondiff/tools/verify_region.py JPN <candidate> <fn> --lane-as=recon/<unit>.cpp
```
(`VA_MAX=<n>` in the environment only widens the printed diff list; it changes nothing else.)

Prohibitions honoured: no git ops; no `tools/*.py` or `regiondiff/tools/*.py`
edits; no base-tree (`recon/**`, `src/**`, `asm/**`, `configs/**`) edits; no
memory-dir edits; no `register ... asm("$N")` pins; no `volatile`, no
`__asm__` INTRODUCED anywhere (fedialog's 2 pre-existing `__asm__("")` fences
and 2 pre-existing `volatile` came with the seed and are untouched — verified
by byte-count before/after).

## Status board

| # | function | region | before | after |
|---|---|---|---|---|
| 1 | `Draw__11tDialogHelp` | JPN | FAIL 17 (140/139) | **REGION-PASS 139** |
| 2 | `FEInput_GetNoDebounceKey__Fii` | JPN | FAIL 4 (122/122) | FAIL 4 (122/122) — mechanism now fully pinned, seed restored byte-identical |
| 3 | `DrawCongratsMessage__23tScreenTournamentTrophy` | JPN | FAIL 4 (200/200) | FAIL 4 (200/200) — 21 measured variants, seed restored byte-identical |

Sibling rows in the same candidates, re-gated green after the work:
`CalculateDimensions__11tDialogHelp` REGION-PASS 350,
`FEInput_GetKeyFromPlayer__F7tPlayerl` REGION-PASS 77,
`FEInput_VerifyControllerValues__Fi` REGION-PASS 28. **No PASS was broken.**

Files WRITTEN: `regiondiff/recon/NFS4-R-JPN/frontend/common/fedialog.cpp` only
(row 1). `feinput.cpp` and `screencongrats.cpp` are byte-identical to their
seeds (`diff` clean) — every experiment on them was reverted. Plus this
receipt and three private scratch helpers under `scratchpad/w85/`:
`M7_rtl.py` (a copy of `tools/rtl_dump.py` with a PRIVATE out-dir, per catalog
28I-6), `M7_ed.py` (CRLF-safe literal replace — the CRLF regime is asserted
intact after every edit), `M7_bak/` (seed backups), `M7_rtl/*.loop|.rtl|.jump2|
.sched2` (the dumps quoted below), `s_try*.py` (variant sweeps).

---

## 1. `Draw__11tDialogHelp` (JPN) — REGION-PASS 139 (was FAIL 17)

Candidate `regiondiff/recon/NFS4-R-JPN/frontend/common/fedialog.cpp`.

```
python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/frontend/common/fedialog.cpp Draw__11tDialogHelp,CalculateDimensions__11tDialogHelp --lane-as=recon/frontend/common/fedialog.cpp
  Draw__11tDialogHelp: REGION-PASS (139 insns) [NFS4-R-JPN]
  CalculateDimensions__11tDialogHelp: REGION-PASS (350 insns) [NFS4-R-JPN]
```

### The residual W84-R16 left

R16's diagnosis was exact: the two `FETextRender_FullText` call sites pass
`textState_Selected` (1) as their 5th (stack) argument; loop.c builds two
identical `li 1` movables, `combine_movables` MATCHES them (`Insn 362 ...
matches 310`), summing to savings 2 / life 2, and `move_movables` fires on
`threshold * savings * lifetime >= insn_count` — `4*T >= 112` — hoisting the
constant into `$s7` (frame 144 vs 136, `sw/li/lw s7`; 17 diffs).

### Threshold pinned to T = 29..30 (tighter than R16's 29..33)

Method: `-dL` dump of 6 TUs (fedialog, femenu, feinput, screencongrats, cars,
newton) and replay the inequality over every movable. Two corrections to the
replay matter — decrement `threshold -= 3` after EVERY move (`forces`/`matches`
moves included; skipping them yields a bogus T < 18.03 bound) and double
`insn_count` on `halved since already moved`:

* lower bound — `cars` insn 34: ic 29, savings 1, life 1, 0 prior moves → **T ≥ 29**
* upper bound — `femenu` insn 600: ic 115, savings 2, life 19, 9 prior moves →
  `(T-27)*38 < 115` → **T < 30.03**

So T ∈ {29, 30}; the hoist would need `insn_count ≥ 4T+1` = 117..121, i.e. +5..9
RTL insns in a 112-insn loop — not reachable code-neutrally. **The match had to
be broken instead.**

### The fix — a "LICM shield" that costs zero instructions

`scan_loop` only creates a movable when
`n_times_set[dest] == 1 || consec_sets_invariant_p(dest, n, p)` (loop.c:707),
and `combine_movables` only matches movables whose regs satisfy
`n_times_used[regno] == 1` (== `n_times_set`; loop.c:1252/1263). So giving ONE
of the two arms a named carrier that is **set twice, non-consecutively** removes
it from the movable list entirely; the surviving arm's movable is then alone
(savings 1 × life 1 × T < 112 → `not desirable`) and BOTH constants stay put.

```c
int state;                       /* function-scope carrier */
...
  if (numLetters < (int)strlen(this->text[i])) {
    j = 0;
    state = 0;                   /* dead set #1 - separated from #2 by the copy loop */
    if (numLetters > 0) { do { ... } while (j < numLetters); }
    bufferPtr[numLetters] = '\0';
    FETextRender_FullText(bufferPtr, ..., state = textState_Selected, 0);   /* set #2 */
  }
  else {
    FETextRender_FullText(this->text[i], ..., textState_Selected, 0);       /* untouched */
  }
```

Two details are load-bearing and each was measured:

* **The dead `state = 0` must NOT be adjacent to the live set.** Adjacent sets
  make `consec_sets_invariant_p` succeed → the pair becomes a movable again
  (`consec 1`) and BOTH insns get hoisted. Putting the copy loop between them is
  what makes it fail. `flow` (which runs after `loop`, before regalloc) deletes
  the dead store, so the shield costs **zero instructions** — 139/139 count-exact.
* **The live set must be written INSIDE the argument**, not as a preceding
  statement. As a statement the carrier's live range starts before the
  `textType` ternary's branch, spans two basic blocks, goes to `global_alloc`,
  colors `$t0` (MIPS `REG_ALLOC_ORDER` hands out call-clobbered temps before
  `$v0`) and pushes the magic-divide `mfhi` from `$t0` to `$t1`:
  **FAIL 10, count-exact 139/139**. Written in the argument, the set lands after
  the ternary, stays in one basic block, `local_alloc` gives it `$v0` — retail's
  register — and the last 10 diffs go.

Confirmation from the loop dump (`python scratchpad/w85/M7_rtl.py <cand> <base_tu> -dL`):
```
before: Loop from 83 to 390: 112 real insns.
        Insn 310: regno 183 (life 2), move-insn savings 2  moved to 416
        Insn 362: regno 199 (life 1), done move-insn matches 310
after : Loop from 84 to 397: 113 real insns.
        Insn 369: regno 199 (life 1), move-insn savings 1 not desirable
```

### Falsified angles (each a real measurement)

| angle | result |
|---|---|
| catalog **32B-1 `do{}while(0)` LICM shield** wrapped round both call sites | **FAIL 61** (from 17). The shield does NOT absorb this hoist: `-dL` still shows 310 moved + 362 matching, and the degenerate loops additionally rotate `$s2`↔`$s3` through the whole body. 32B-1 works on a constant's *comparison* inside a real loop; an outgoing stack ARGUMENT is not reached by it. |
| shared `int state` assigned in BOTH arms (n_times_set = 2 — also kills the hoist) | FAIL 15, 138/139 — one insn SHORT: the carrier is a global allocno in `$t0`, reorg steals its `li t0,1` into the outer `beq` delay slot where retail has `li a3,8`, and `mfhi` shifts to `$t1` |
| same, with the assignment written inside the argument | FAIL 15 — identical (a side-effecting argument is precomputed first, so emission order does not change while the carrier still spans both arms) |
| adding a named `int type` carrier for the `textType` ternary on top of that | **FAIL 43** (134/139) — destroys the arm layout |
| the adopted shield but with the live set as a STATEMENT | FAIL 10, count-exact (see above) |

---

## 2. `FEInput_GetNoDebounceKey__Fii` (JPN) — FAIL 4, count-exact 122/122

Candidate `regiondiff/recon/NFS4-R-JPN/frontend/common/feinput.cpp` — **restored
byte-identical to the W84-R08 seed** (`diff` clean); every experiment reverted.

```
  FEInput_GetNoDebounceKey__Fii: FAIL 4 diffs (ours 122 / oracle 122) [NFS4-R-JPN]
      - li v0,1              + addu v0,zero,zero
      - addu v0,zero,zero    + nop
```

### Mechanism — now traced end-to-end (R08 had the reorg half; this is the cause)

R08 correctly identified the symptom: reorg fills the HIGH funnel's `beqz` from
the TARGET thread (copying `li v0,1`, redirecting past it) instead of from the
FALL-THROUGH (`move v0,zero`), because `own_thread_p(NEXT_INSN(branch), 0, 1)`
returns 0 when **any** CODE_LABEL sits between the branch and its first
fall-through insn (reorg.c: with `label == NULL_RTX` the test `insn != label ||
LABEL_NUSES != 1` is true for every label).

**What R08 could not say is WHY a label is there. It is created by `jump2`, not
by reorg.** The RTL dumps settle it:

* `-dR` (sched2, i.e. the input to reorg) — `return_zero` is exactly where the
  source puts it, on the LOW funnel's zero block, and the HIGH funnel's zero
  block is label-free:
```
(code_label 200 195 202 21 ("return_zero"))
  (insn 204 ...  v0 = 0)
(jump_insn 206 ...)            <- LOW zero block
(barrier 207) (code_label 208 ...)
(code_label 219 ... ("return_not_bool"))
(jump_insn 223 ...)            <- HIGH funnel beq
  (insn 232 ...  v0 = 0)       <- NO label here
(jump_insn 234 ...)
```
* `-dJ` (jump2 = `jump_optimize(..., cross_jump=1)`) — label 200 is **GONE**, a
  fresh `code_label 424` (printed `$L37`) has appeared immediately before insn
  232, and the `'#'` branch now points at it:
```
(code_label 424 230 232 37 "")
  (insn 232 424 234 (set (reg/i:SI 2 v0) ...
...
(jump_insn 337 ... (if_then_else (eq ... ) (label_ref 424) (pc)))
```
  jump2's cross-jumping merged the LOW zero block into the HIGH one
  (`do_cross_jump` deletes the matching insns and `get_label_before`s the
  survivor — insn 204 is absent from the jump2 dump).
* reorg then *undoes the size win* (`fill_simple_delay_slots`' "unconditional
  jump → take the insn at the branch target" path copies `v0 = 0` back into the
  low block's `j` slot and redirects it to the epilogue), so the final code has
  both zero blocks again — but the label stays on the HIGH one, and that is what
  costs the two delay-slot pairs.

**⇒ the lever is `jump2`, not reorg: keep cross-jumping from putting a label in
front of the high funnel's fall-through.**

### The decisive experiment (new, and it proves the lever works)

Take `return_zero:` OFF the low funnel's `return 0;` and give the `'#'` arm its
own labelled `return 0;` at the very end of the function:

```c
      if (lowResult) { goto return_one; }
      return 0;                    /* low funnel - now unlabelled */
...
return_one:
  return 1;
return_zero:                       /* the '#' arm's own block */
  return 0;
```
```
  FEInput_GetNoDebounceKey__Fii: FAIL 2 diffs (ours 124 / oracle 122)
      - j T
      - addu v0,zero,zero
```
**Both funnels now match retail exactly** (the high funnel gets its
fall-through `move v0,zero` fill, the low funnel keeps its target-copy `li v0,1`
fill) — the whole 4-diff residual is gone. The only remaining difference is the
+2-insn trailing block, i.e. retail shares that `return 0` with the LOW funnel's
zero block while we have a fourth one.

That block is irreducible in this shape: retail's last block is `li v0,1`
falling into the epilogue, so any *labelled* `return 0` needs its own
`j epilogue` + value insn (+2). The `'#'` arm therefore MUST re-use an existing
zero block, and the only one that works is the LOW funnel's — which is exactly
the binding jump2 rewrites.

### Falsified angles (all measured this session; R08's list re-confirmed)

| angle | result |
|---|---|
| `return_zero:` moved onto the HIGH funnel's `return 0` (mirror) | FAIL 7 @119 |
| `return_zero:` moved onto the DEFAULT arm's `return 0` | FAIL 11 @119 (the low funnel's whole test collapses) |
| `'#'` arm keeps `goto return_zero` + a SECOND reference to the same label (the early `nopad` guard rewritten `goto return_zero;`, which is codegen-neutral there) — i.e. `LABEL_NUSES == 2` | FAIL 4 @122, unchanged — NUSES does not stop the cross-jump rewrite |
| `'#'` arm gets its own trailing labelled `return 0` | **FAIL 2 @124** (funnels correct, +1 spurious block) |
| R08's list, re-read and not re-run: inline `return 0` for `'#'` (11 @119), `'#'` through the low funnel with `lowResult = 0` (11 @121), `'#'` test inverted (4 @122, different residual), branch-polarity flip at the high funnel (neutral), if/else instead of default+override (neutral) | — |

**Left in the count-exact 122/122 state** rather than the 2-diff/124 state: 124
carries a basic block retail does not have, which is a worse reconstruction even
though the diff number is lower. The remaining work is a `jump2` cross-jump
direction, and the next thing to try is a source shape in which the LOW zero
block is the *later* of the two identical blocks (cross-jump keeps the later
one) without disturbing the oracle's case-body order.

---

## 3. `DrawCongratsMessage__23tScreenTournamentTrophy` (JPN) — FAIL 4, count-exact 200/200

Candidate `regiondiff/recon/NFS4-R-JPN/frontend/common/screencongrats.cpp` —
**restored byte-identical to its seed** (`diff` clean).

```
  DrawCongratsMessage__23tScreenTournamentTrophy: FAIL 4 diffs (ours 200 / oracle 200)
      - li v0,97          + li v1,97
      - sh v0,26(sp)      + sh v1,26(sp)
```

### What it actually is (NOT the R12 `-14`-bias cast family)

The assigned angle was R12's `(short)`-cast family. It does not apply: that
lever is already in the candidate (`r.y = (short)(r.y - 14) + (short)
FETextRender_WordWrapHeight(...)`, line 696) and the `-14` bias region is
byte-clean. The residual is in the translucent-plate tail
(`r.h/r.y/r.x/r.w` before `DrawShape_NFS4TransRectangle`) and is a **two-insn
scheduling swap that decides one register**:

```
oracle:  addiu v0,v0,6 / sh v0,30(sp) / lhu v0,24(sp) / li v1,97 / sh v1,26(sp)
         / lhu v1,28(sp) / addiu v0,v0,-5 / addiu v1,v1,10 / sh v0,24(sp) / jal / sh v1,28(sp)
ours  :  addu  $2,$2,6  / sh $2,30(sp) / li $2,97      / sh $2,26(sp) / lhu $2,24(sp)
         / lhu $3,28(sp) / addu $2,$2,-5 / addu $3,$3,10 / sh $2,24(sp) / jal / sh $3,28(sp)
```
Retail schedules the `r.x` LOAD into the slot right after the `r.h` store, so
`local_alloc` re-uses the dying call-result `$v0` for `r.x` and the constant 97
lands in `$v1` (then re-used for `r.w`). We schedule the `li 97` there instead,
so 97 takes `$v0` and `r.x` follows it in `$v0`, `r.w` in `$v1`. Same 13 insns,
same order otherwise.

The `-dS` (sched1) dump shows the decision is made BEFORE regalloc and is not a
dependency: gcc disambiguates all four `(mem/s:HI (plus (reg fp) 24/26/28/30))`
accesses (no memory LOG_LINKS between them), yet sched1 still emits
`501 (reg:HI 202 = 97) / 503 (store r.y)` ahead of `493 (load r.x)` even when
the source orders `r.x` first — i.e. `rank_for_schedule` ranks the 2-insn
constant chain above the 3-insn load→add→store chain here. Source statement
order is therefore *not* the dial.

### Falsified angles — 21 variants, every one gated

| family | variants | result |
|---|---|---|
| statement ORDER of `{r.h, r.x, r.y, r.w}` | `y,x,w` (seed) · `x,y,w` · `x,w,y` | FAIL 4 (unchanged) |
| | `w,y,x` · `w,x,y` · `y,w,x` · `h` moved between the field stores (`x,h,y,w`, `x,y,h,w`) | FAIL 16 / 16 / 16 / 16 / 18 (worse) |
| | `r.y` first (`y,h,x,w`) | FAIL 8 |
| cast family on the plate stores | drop the `(short)` on `r.h` · `(short)` on `r.x`/`r.w` · `(short)((int)r.x - 5)` · `r.y = (short)97` · `r.x = r.x + -5` · `r.x -= 5; r.w += 10` | FAIL 4 (all neutral) |
| cast/operand family on the height call | `6 + f(...)` · `(short)f(...) + 6` | FAIL 4 |
| carriers / scoping | `int plateY = 0x61; r.y = plateY;` · `short nx/nw` temps · `short nx` only · own `{ }` block for the group | FAIL 4 |
| | `int nx = (int)r.x - 5; r.x = (short)nx;` | FAIL 6 |
| aliasing (force program order) | `RECT *pr = &r; pr->x = ...; pr->y = ...;` | FAIL 8 |
| dependency-lengthening probe | `r.y = (short)(0x61 + (r.h - r.h));` | FAIL 4 |

Nothing at C level moved the sched1 rank. This is a genuine
`rank_for_schedule` priority decision on two independent chains, and the next
step is the permuter (multi-basin) on this function with a C++-method harness —
not attempted here for budget reasons. **No floor is claimed**; the function is
left count-exact at its best measured state, identical to the seed.

---

## Reusable findings (catalog candidates)

1. **LICM shield by NON-CONSECUTIVE double set.** To stop `move_movables`
   hoisting a loop constant you do not have to beat the budget — break
   `combine_movables`. A named carrier written twice in the loop with at least
   one real insn between the two sets makes `n_times_set == 2` AND
   `consec_sets_invariant_p` fail, so `scan_loop` never builds the movable; the
   partner constant is then alone and falls below `T*1*1`. `flow` deletes the
   dead first store before regalloc, so it costs nothing. Write the LIVE set
   *inside the call argument* so the carrier stays in one basic block and gets a
   `local_alloc` caller-saved register instead of a `global_alloc` `$t0`.
   (Generalises 32B-1, which only shields a comparison inside a nested loop.)
2. **`-dL` budget replay: count EVERY move.** `threshold -= 3` fires for
   `forces`/`matches` moves too, and `insn_count` doubles on
   `halved since already moved`. Replaying with those two corrections over 6 TUs
   pins this build's LICM threshold to **T ∈ {29, 30}** (was 29..33).
3. **A reorg delay-slot "thread choice" can be a `jump2` cross-jump artifact.**
   Before blaming `fill_eager_delay_slots`, diff `-dR` (sched2) against `-dJ`
   (jump2): if a user label moved between them, cross-jumping re-pointed a
   `goto` at an identical later block and `get_label_before`d it, and the label
   is what kills `own_thread_p` on the fall-through thread. reorg then restores
   the deleted insn by copying, so the final *size* is unchanged and the cause is
   invisible in the asm.
