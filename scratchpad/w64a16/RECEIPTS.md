# W64-A16 RECEIPTS — belt: femenu-family (frontend/common), EA C++ dual-lane

Gate = `python tools/verify_asm.py <recon path> <MangledName>` (sole authority).
Every number below is MY OWN re-gate after a fresh `python tools/build.py --skip-asm`.
Landed: **comment-only receipts** in 4 TUs (`d429c427`) — zero codegen change,
every TU whole-gated before and after, **zero PASS→FAIL**.
User-live TUs (femenu / fetv / screenpost / screenusername) never opened.
`recon/nfs4_types.h` untouched (report-only).

---

## 0. LEDGER (briefed → my re-gated baseline → final)

| fn | TU | briefed | my baseline | FINAL | outcome |
|---|---|---|---|---|---|
| Redraw__14tFEApplication | feapp | 99.28% (10) | **10** (393/393) | 10 | 🏆 the LICM blocker **SOLVED**; address window byte-exact in a 14-diff basin; residual RE-NAMED. Struct-view dial FALSIFIED |
| FeAudio_InitViv__FPc | feaudio | 96.60% (7) | **7** (110/109) | 7 | 🏆 the certificate's **missing zero-copy instrument FOUND** (gcc-cited); certificate CORRECTED |
| __15tGlobalMenuDefs | femenudefs | 86.19% (3365) | **3365** (3180/3207) | 3365 | re-gated; two standing receipts restated; header diff reported not applied |
| Draw__17tUserNameMenuItemb | femenuoptions | 98.39% (8) | **8** (254/254) | 8 | 🏆 residual RE-CLASSIFIED: retail's `$t0` is a **reload rematerialization**, not an allocno; 6 new falsifications |
| ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand | femenuoptions | 99.98% | **PASS** (240) | PASS | stale board row |
| UpdateTransition__12tOptionsMenu | femenuoptions | 99.97% | **PASS** (172) | PASS | stale board row |
| Draw__29tMenuItemOptionsTwoItemChoiceiib | femenuextended | 99.97% | **PASS** (161) | PASS | stale board row |
| InitializeShapes__7tScreenR17tShapeInformationUi | fescreen | 99.88% | **PASS** (42) | PASS | stale board row |
| LoadGame__FsbT1 | fememcard | 99.9x | **PASS** (374) | PASS | stale board row (w63 verdict confirmed) |
| SavePinkSlipsCars__Fss | fememcard | 99.9x | **PASS** (226) | PASS | stale board row (w63 verdict confirmed) |

**Whole-TU gates (all after the final edit, all clean):**
feapp 14/15 · feaudio 9/10 · femenuoptions 91/92 · femenudefs 65/66 ·
femenuextended **57/57** · fescreen **27/27** · fememcard **18/18**.
`tu_order_audit.py` = 508 objects, **0 inversions**.

**6 of 10 briefed rows were already PASS** — identical to w63a16's finding, so the
board rows have now been stale for two consecutive waves (11H, again).

---

## 1. 🏆 feapp `Redraw` — THE LICM BLOCKER IS SOLVED (the w63 named exclusion is refuted)

W63-A16 closed with: *"a two-use address pseudo whose uses are far apart is
UNREACHABLE in a loop"*, and asked for *"a struct-view spelling of `*cell` that
flips MEM_IN_STRUCT_P"*. Both halves are now answered.

### 1a. The recipe that reproduces retail's address window exactly

```c
  /* function-scope, NOT block scope */
  u_char **pc;
  ...
  if (this->fCurrentScreen[(u_char)this->fPlayer] != 0) {
    (this->fCurrentScreen[...])->Draw(true);
    pc = (u_char **)0x1f800004;          /* set in BOTH arms */
  } else {
    pc = (u_char **)0x1f800004;
  }
  daprim = (DR_AREA *)*pc;               /* read at the JOIN */
  __asm__("" : : "r"(daprim));           /* read-only fence, right after the read */
  ...
  *pc = (u_char *)daprim + 0xc;
```

**14 diffs @ 393/393**, and the *entire* window this function has been about since
W60-A10 is byte-exact:

```
lui  t0,8064        <- stolen into the beqz delay slot by reorg
lui  t0,8064 / ori t0,t0,4 / lw a0,0(t0)     <- at the join
sw   v0,0(t0)
```

### 1b. Why each ingredient is load-bearing (each measured, all reverted)

| ingredient | drop it | mechanism |
|---|---|---|
| **fn-scope decl** | 55 @394, whole loop re-rotated (`bltz` vs `bgez`) | a block-scope decl inside the `for` body plants a `NOTE_INSN_BLOCK_BEG`; jump.c:2296 `duplicate_loop_exit_test` refuses an exit region containing one (13D) |
| **arm-duplicated set** | 58 @395 (hoisted, callee-saved `$s7`) | two SETs ⇒ loop.c `scan_loop` never builds a movable; the final `cross_jump` merges the two `li` back into one at the join, so the count is unchanged |
| **read-only fence on `daprim`** | 28 @395 | without it the extra pseudo costs `daprim` its `$a0` coalesce and pays two `addu a0,tN,zero` copies (+2 insns) in BOTH packet blocks |

Decl POSITION is **completely inert** — 5 positions × 2 cell types, all 28.
Fence position/operand count is a **plateau at 14** (after-read 14, after `r.x` 14,
after `r.y` 19, after `r.h` 24; 1/2/3 operands identical).

### 1c. 🔴 The struct-view alias dial is EXACTLY INERT (w63's ask answered NO)

A one-member `typedef struct { u_char *pkt; } tPktCell;` at `0x1f800004`, used for
both accesses, flips `MEM_IN_STRUCT_P` on the cursor store — and gates **14**, the
same as the plain `u_char **`. It cannot help, and gcc-2.8.1 `sched.c:846-56` says
why: the exemption needs one MEM `(in_struct && varying)` and the other
`(!in_struct && !varying)`; the partner prim-tag stores are already
`(in_struct && varying)`, so making `*cell` in-struct puts BOTH on the same side.
Related struct-view measurements: same view in the pre-fence basin 54 @393; based
at `0x1F800000` with offset 4 (so the low half never folds) 55 @394; struct view +
3-way comma 46 @395.

### 1d. 🔑 `packetCell` in the FIRST (pre-loop) packet block is COSMETIC

Rewriting block 1 with the bare literal macro instead of its `u_char **packetCell`
local gates **exactly 10** — byte-identical output. In a straight-line block cse
commons the constant address by itself; the local was never the lever. (This
corrects w63-A16 §1a, which read block 1's match as evidence for the cell spelling.)

### 1e. Full new ladder (base 10 @393; all reverted)

| variant | diffs | insns |
|---|---|---|
| arm-dup plain cell, block decl | 55 | 394 |
| arm-dup set+read in both arms | 37 | 392 |
| join set + identity fence after read | 37 | 392 |
| join set + identity fence before read | 55 | 394 |
| join set, plain (control) | 113 | 396 |
| two short-lived cells (cse merges them) | 89 | 394 |
| two cells, both identity-fenced | 69 | 396 |
| struct view at 0x1F800000 + arm-dup | 54 | 393 |
| **fn-scope cell + arm-dup (no fence)** | **28** | **395** |
| ONE shared fn-scope cell for both packet blocks | 58 | 395 |
| shared cell + arm reads | 57 | 396 |
| block1 macro + loop cell | 28 | 395 |
| **+ read-only fence on daprim (X1)** | **14** | **393** |
| X1 + identity fence instead | 14 | 393 |
| X1 + fence on `pc` | 14 | 393 |
| X1 + struct view | 14 | 393 |
| X1 + comma split, store between prim stmts | 69 | 400 |
| X1 + 3-way comma, store in middle | 69 | 400 |
| X1 + 3-way comma, store first | 26 | 393 |
| X1 + named `yo` local for fYOffset | 102 | 397 |

### 1f. NAMED ANGLE (replaces w63's)

In the 14-diff basin the two remaining facts are **inside one basic block**:
(a) `fYOffset` lands `$a1` for us and `$a2` for retail, and retail materialises
`addiu a1,sp,56` earlier; (b) reorg fills the `SetDrawArea` jal slot with our
packet store where retail fills it with the palette store (ours is emitted last).
That is an emission/serving-order question, not an address-materialisation one.
Harnesses: `scratchpad/w64a16/rw{,2,3,4,5,6,7,8,9,10}.py`, `rwd.py` (single-variant
full-diff), `dmp.py`.

---

## 2. 🏆 feaudio `FeAudio_InitViv` — THE CERTIFICATE'S MISSING INSTRUMENT EXISTS

Three waves (W60-A10, W61-A16, W62-A15) closed this fn with the same request:
*"a device that gives the pseudo a SECOND live range with no copy insn"*.

### 2a. The gcc source says there are TWO disjuncts, and only one was ever attacked

`gcc-2.8.1 local-alloc.c:471-477`:

```c
      if (REG_BASIC_BLOCK (i) >= 0 && REG_N_DEATHS (i) == 1
	  && (reg_alternate_class (i) == NO_REGS
	      || ! CLASS_LIKELY_SPILLED_P (reg_preferred_class (i))))
	reg_qty[i] = -2;          /* eligible for LOCAL allocation */
      else
	reg_qty[i] = -1;          /* falls through to global.c */
```

Every prior wave attacked `REG_N_DEATHS == 1` (identity fence ⇒ two deaths ⇒
GLOBAL ⇒ `$a3`, at the price of one carrier copy = the +1 insn, 110 vs 109).
**`REG_BASIC_BLOCK (i) >= 0` is an independent, ZERO-INSN route to the same
GLOBAL set** (this is 05D promotion, but its cost model was never stated: it is
free *because it adds no RTL*). InitViv has a structurally identical byte-swap
block after `if (bigfileHeader == 0) return 0;` and the second async wait, so ONE
shared source-word variable spans two basic blocks for free.

### 2b. Measured — every sharing variant is COUNT-EXACT (base 7 @110; all reverted)

| variant | diffs | insns |
|---|---|---|
| shared source word (block-2 `headerType`) + identity fence | 32 | **109** |
| shared source word, NO fence | 40 | **109** |
| shared with block-2 `num`, fence / no fence | 34 / 42 | **109** |
| shared with block-2 `hlen`, fence / no fence | 42 / 50 | **109** |
| no fence, not shared (control) | 34 | 109 |

**The carrier copy is gone in all six** — the exact device the three certificates
asked for.

### 2c. 🔴 Why it still misses, from the real CC1PLPSX `-dl/-dg` dump

```
;; 3 regs to allocate: 84 81 82
Register 84 used 17 times across 28 insns; dies in 2 places;   <- no "in block N": GLOBAL
;; 84 conflicts: 82 84 2 3 4 5 6 7 8 29
```

The merged pseudo *is* a real global allocno, but its conflict set now contains
`7 ($a3)` and `8 ($t0)` picked up from the second region, so `find_reg`'s ascending
scan hands it `$t1 ($9)`. In the 7-diff base the same pseudo's conflicts are
`2 3 4 5 6 8 29` — **`$a3` absent** — which is precisely why the fence shape reaches
`$a3`.

### 2d. CERTIFICATE, corrected

> The missing device is **not** "a second live range without a copy insn" — that is
> a second-basic-block reference, and it is free. It is **"a second live range whose
> SECOND region does not add `$a3` to the conflict set"**. A second reference sited
> where `$a3` is dead would land the count AND the register together; none of
> InitViv's three candidate block-2 words qualifies.

(W63-A16's separate finding — that `REG_LIVE_LENGTH` is only `QTY_CMP_PRI` serving
order, so the 15A foreign-operand fence is priority-only — is untouched and stands.)
Harnesses: `scratchpad/w64a16/viv.py`, `viv2.py`, `dmp.py`.

---

## 3. 🏆 femenuoptions `Draw__17tUserNameMenuItemb` — RESIDUAL RE-CLASSIFIED

Residual unchanged at **8 @254/254**: two copies of `li v1,156 / subu a3,v1,a3`
against retail's `li t0,156 / subu a3,t0,a3`.

**New reading — retail's `$t0` is a RELOAD REGISTER, not an allocno.** Read straight
off the oracle stream: two insns earlier retail does `lw t0,88(sp)` (the spilled `x`
reloaded) + `addiu s1,t0,156`; `$t0` is dead immediately after, and retail then
re-uses it for `li t0,156` placed **immediately before its consumer** (after
`addu a2,s0,zero`), where ours sits 2 slots earlier (before `addu a0,zero,zero`).
Rematerialising a `REG_EQUIV` constant into a reload register drawn from
`order_regs_for_reload`'s pool reproduces **both** facts at once — the register and
the position — where an allocated pseudo reproduces neither (W62-A15's
conflict-structure certificate already proved `find_reg`'s ascending scan can only
hand out `$v1` here). Our identity fence is what kills the `REG_EQUIV` and forces
the allocation.

NEW FALSIFICATIONS (base 8, all re-gated, all reverted):

| probe | diffs | insns |
|---|---|---|
| plain `0x9c` literal, BOTH blocks | 67 | 253 |
| unfenced `int boxRight = 0x9c;`, BOTH blocks | 67 | 253 |
| literal in the FIRST block only | 78 | 254 |
| **literal in the SECOND block only** | **8 (inert)** | 254 |
| `int boxRight; boxRight = 0x9c;` (12D decl-with-init demote), both | 8 (inert) | 254 |
| 15A foreign-operand fence on `shape` after the identity fence | 32 | 254 |

Two consequences: (i) only the **first** block's identity fence is load-bearing —
the second one is provably inert; (ii) every spelling that restores the `REG_EQUIV`
lets cse share ONE materialisation across both blocks (253 = one `li`), and drops a
whole `s2`↔`s3` saved-band rotation on top (the 67).

**NAMED ANGLE (new):** keep the constant unallocated/`REG_EQUIV` per block (two
reload remats) while stopping cse from sharing one materialisation between the two
blocks — explicitly **not** an allocno dial. Harness: `scratchpad/w64a16/un.py`.

---

## 4. femenudefs `__15tGlobalMenuDefs` — re-gated, receipts restated

Re-gated **3365 (3180/3207)** on a fresh build — identical to W59-A12 and W63-A16;
the 86.19% board row is stale (it is not a residual count). Nothing probed; the two
standing receipts are restated in-source and **not re-opened**:

* W63-A16's **alpha-rename triage** — 1744 raw LCS == 1744 alpha-renamed, so the
  residual is not an allocator rotation and every qty/allocno instrument is the
  wrong tool;
* the **frame receipt** — retail's spill area is 72..592, ours 128..596, and a
  declared local can never occupy 72..127 (gcc assigns declared locals at expand and
  reload spill slots later from one upward-growing `frame_offset`), so
  `compilerFramePad` necessarily buys the 640 total at the price of mis-siting every
  spill.

The briefed angle ("retail derives N sub-object addresses from ONE `this` reload
with fresh destinations") is a **post-RELOAD** effect on compiler-generated
`this + offset` operands of an initializer list — there is no init-list spelling for
it, which is why it was not attacked with the remaining budget.

**ORCHESTRATOR ACTION (report only, deliberately NOT applied):** the W59-A12
shared-header diff — give
`nfs4_types.h:4894 tInsideBoxControllerLeftRightSlider(unsigned int, tListIterator*)`
its own vptr store (`*(void **)&_base_tInsideBoxLeftRightSlider._vf =
(void *)&tInsideBoxControllerLeftRightSlider_vtable;`, exactly as the sibling ctors
at :4577 / :4586 already do) and delete the two body stores in `femenudefs.cpp`.
The oracle sets it inside the object's construction at 0x80030ADC/0x80030AFC/
0x80030B34. Not applied here because a shared-header edit mid-wave forces a
full-tree re-gate and would collide with 19 concurrent belts.

---

## 5. CATALOG-ROW CANDIDATES

1. 🔴 **`REG_BASIC_BLOCK < 0` IS THE ZERO-INSN HALF OF THE LOCAL/GLOBAL TEST**
   (`local-alloc.c:471-477`). A pseudo goes to `global.c` if it dies twice **OR** is
   referenced from more than one basic block. Every catalogued promotion device
   (identity launder, copy-tail, copy-back) buys the first disjunct and pays an insn;
   sharing one fn-scope variable with an equivalent value in another block buys the
   second and pays **nothing** (6 InitViv variants, all count-exact). Price it BEFORE
   any copy device. Caveat, same receipt: the promoted pseudo inherits the conflicts
   of BOTH regions — check the `-dg` `;; N conflicts:` line for the register you want
   before spending it.
2. **BLOCK-SCOPE DECLARATION INSIDE A LOOP BODY = LOOP-ROTATION SWITCH, at a
   distance.** 13D already names `duplicate_loop_exit_test` refusing a
   `NOTE_INSN_BLOCK_BEG`; the new receipt is that this fires for a declaration you
   added for an unrelated reason and shows up as a 40-diff cascade with `bltz`↔`bgez`
   (feapp Redraw: same variable, block scope 55 vs fn scope 28). Whenever a new local
   costs far more than "one more pseudo", check the loop's test position first.
3. **ARM-DUPLICATED ASSIGNMENT IS THE COUNT-FREE ANTI-LICM DEVICE.** Two SETs in the
   loop ⇒ no movable is ever created (works at ANY lifetime, unlike use-adjacency),
   and the final `cross_jump` pass merges the duplicated constant loads back into one
   at the join, so the instruction count is unchanged. Contrast the identity fence,
   which also works but plants a scheduling barrier.
4. **`MEM_IN_STRUCT_P` CAN ONLY HELP WHEN THE PARTNER IS A FIXED SCALAR.**
   `sched.c:846-56`'s exemption needs one MEM `(in_struct && varying)` and the other
   `(!in_struct && !varying)`. Flipping the in-struct bit on a MEM whose partner is
   already `(in_struct && varying)` puts both on the same side and is provably inert
   (feapp Redraw: 14 with the struct view, 14 without). Check the partner's two bits
   before spending the 14D/15C dial.
5. **A CONSTANT IN A CALLER-SAVED REG THAT THE ASCENDING SCAN CANNOT EXPLAIN IS A
   RELOAD REMAT.** Tell: the oracle's `li rD,K` sits immediately before its single
   consumer and `rD` is a register a RELOAD just used and dropped (here `lw t0,88(sp)`
   two insns earlier). No allocno/priority/fence dial can reach it; the source lever
   is to keep the pseudo `REG_EQUIV`/unallocated, not to move an allocation.
6. **A LOCAL POINTER TO A CONSTANT ADDRESS IS COSMETIC IN A STRAIGHT-LINE BLOCK.**
   cse commons a repeated `(mem (const_int))` address into a register by itself
   (feapp Redraw block 1: cell spelling and bare macro are byte-identical). Do not
   read "this block matches and it has a cell local" as evidence for the cell.
7. **The board's percentage column is not a residual, wave 2 running** — 6 of 10
   briefed rows on this belt were already PASS, the same 6 as last wave.

---

## 6. FILES / HARNESSES / HAZARDS

**Landed:** `d429c427` — comment-only receipts in `feapp.cpp`, `feaudio.cpp`,
`femenuoptions.cpp`, `femenudefs.cpp`. Backups in `scratchpad/w64a16/bak/`.
All seven belt TUs whole-gated after the edit; zero PASS→FAIL; `tu_order_audit` 0.

**Harnesses** (`scratchpad/w64a16/`): `rw.py` … `rw10.py` (Redraw ladders),
`rwd.py` (apply ONE variant + full `VA_MAX` diff, module chosen by `RWMOD=`),
`un.py` (the 156-constant ladder), `viv.py` / `viv2.py` (InitViv 2-block-pseudo
ladders), `dmp.py` (cc1plus `-dl/-dg/-dL` with the MANDATORY `-fno-exceptions
-fno-rtti`; `tools/fast.py`'s own `picture()` still omits them).

**Hazards hit:**
* 🔴 **Heredoc backslash collapse, firing again** — writing a Python probe through a
  quoted bash heredoc collapsed `\\n` inside byte literals to real newlines and
  produced an unterminated-string `SyntaxError` (the benign outcome; the malignant
  one is a silent control byte). All probe scripts were rewritten with the Write
  tool. The rule is absolute.
* **Edit-tool line endings** — `feaudio.cpp` is all-CRLF while `feapp.cpp`,
  `femenuoptions.cpp` are all-LF and `femenudefs.cpp` is all-CRLF. The Edit tool
  preserved each file's regime here, but every edit was byte-checked afterwards
  (`CRLF == total LF` for the CRLF files, `CRLF == 0` for the LF ones, no control
  bytes). `tools/fast.py`'s `run()` does the anchor translation; anything hand-rolled
  must copy it and assert the anchor matched.
* `git commit` prints a `LF will be replaced by CRLF` warning for the two LF files —
  that is git's `core.autocrlf` on the index side, the working tree is unchanged
  (verified by re-reading the bytes after the commit).
