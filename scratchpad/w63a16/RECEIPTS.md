# W63-A16 RECEIPTS — belt: femenu-family (frontend/common)

Gate = `python tools/verify_asm.py <recon path> <MangledName>` (sole authority).
Every number below is MY OWN re-gate after a fresh `python tools/build.py --skip-asm`.
**Nothing landed** — every probe restored; `git status` on all seven belt TUs is
CLEAN at finish. Zero PASS→FAIL by construction. The four user-live TUs
(femenu / fetv / screenpost / screenusername) were never opened.
`recon/nfs4_types.h` untouched (report-only).

---

## 0. LEDGER (briefed → MY re-gated baseline → final)

| fn | TU | briefed | my baseline | FINAL | outcome |
|---|---|---|---|---|---|
| Redraw__14tFEApplication | feapp | 99.28% | **10** (393/393) | 10 | 🏆 named anti-LICM question **ANSWERED** (device found, gcc-dump-proven); residual RE-CLASSIFIED |
| FeAudio_InitViv__FPc | feaudio | 96.60% | **7** (110/109) | 7 | 🏆 W63-A2 foreign-operand fence applied as first customer → **certificate's own hypothesis FALSIFIED** (new law) |
| __15tGlobalMenuDefs | femenudefs | 86.19% | **3365** (3180/3207) | 3365 | 🏆 NEW ANGLE: alpha-rename is a NO-OP ⇒ **not an allocator rotation**; standing QTY-layer angle refuted |
| Draw__17tUserNameMenuItemb | femenuoptions | 98.39% | **8** (254/254) | 8 | 2 new falsifications; W62 conflict-structure certificate stands |
| LoadGame__FsbT1 | fememcard | 99.96% | **PASS** (374) | PASS | stale board row |
| SavePinkSlipsCars__Fss | fememcard | 99.98% | **PASS** (226) | PASS | stale board row |
| Draw__29tMenuItemOptionsTwoItemChoiceiib | femenuextended | 99.97% | **PASS** (161) | PASS | stale board row |
| ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand | femenuoptions | 99.98% | **PASS** (240) | PASS | stale board row |
| UpdateTransition__12tOptionsMenu | femenuoptions | 99.97% | **PASS** (172) | PASS | stale board row |
| InitializeShapes__7tScreenR17tShapeInformationUi | fescreen | 99.88% | **PASS** (42) | PASS | stale board row |

**6 of 10 briefed rows were already PASS** (the two fememcard rows the briefing
called "near-sealed, finish" are both sealed already). 11H staleness, again.

⚠️ briefing name error: `ProcessInput__17tUserNameMenuItemR12tMenuCommand` is
`NO ORACLE`; the real symbol is
`ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand`.

---

## 1. 🏆 feapp `Redraw` — THE NAMED ANTI-LICM QUESTION IS ANSWERED

W62-A15 left exactly one question: *"WANTED: a selective anti-LICM that leaves
the address pseudo block-local."* It is answered, with the loop.c dump as the
receipt, and the residual is now a different (named) problem.

### 1a. The oracle shape, decoded from the raw .s (not from the diff)

`asm/nonmatchings/front/Redraw__14tFEApplication.s` @0x80013C84:

```
beqz  $a0, .L80013C98
 lui  $t0, 0x1F80        <- reorg eager-steal of the JOIN block's first insn
jal   Draw__7tScreenb
 addiu $a1, $zero, 1
lui   $t0, 0x1F80        <- the ORIGINAL join insn (fall-through re-executes it,
.L80013C98:                  the branch was redirected past it)
ori   $t0, $t0, 4
lw    $a0, 0($t0)
```

So there is **one** address materialization at the join; the duplicated `lui` is
reorg redirecting the taken edge past the stolen insn. The SAME shape appears in
this fn's FIRST (pre-loop) packet block @0x80013968-0x800139A4 — and **our build
already matches that one byte-for-byte**, because it is written
`u_char **packetCell = (u_char **)0x1f800004;`. The C shape was never in doubt.

### 1b. The mechanism, read off cc1plus `-dL` (harness `dmp.py`, real CC1PLPSX,
`-fno-exceptions -fno-rtti`)

```
BASE (macro form, 10 diffs)      Loop from 465 to 1121: 181 real insns.
                                 (no 0x1F800004 movable at all)
B  = cell local, join read       Insn 1015: regno 449 (life 34) savings 1  MOVED to 1139
D  = B + store moved adjacent    Insn 1015: regno 449 (life  5) savings 1  NOT DESIRABLE
```

`0x1F800004` = `const_int 528482308` in the dump — the movable is confirmed.
Solving loop.c's `threshold*savings*lifetime >= insn_count` against the four
verdicts in this one loop (life 8 moved, life 6 not, at insn_count 181) brackets
**T ∈ [22.6, 33.2)**, so at insn_count ≈178 the hoist declines at **life ≤ 5**.

### 1c. THREE anti-LICM devices, all verified to defeat the hoist

| device | how it blocks loop.c | dump evidence |
|---|---|---|
| **USE-ADJACENCY** (store written immediately after the read) | collapses `m->lifetime` below the threshold | `life 34 → 5`, "not desirable" |
| **IDENTITY FENCE on the cell** (`"=r"(cell):"0"(cell)`) | the fence is a **second SET** ⇒ `set_in_loop != 1` ⇒ never becomes a movable | reg 449 absent from the movable list entirely |
| **ARM-DUPLICATED ASSIGNMENT** (`cell = ADDR;` in both if/else arms) | two sets in the loop ⇒ same as above, and **barrier-free** | reg 449 listed twice as "possible biv", never moved |

All three reproduce retail's address shape. Best structural reproduction —
variant **M** (cell for the READ, identity fence after it, macro for the STORE):
**count-exact 393/393** and the read block is byte-identical to retail modulo the
register name:

```
OURS: lui v0,8064 / (delay slot)   ORACLE: lui t0,8064
OURS: lui v0,8064                  ORACLE: lui t0,8064
OURS: ori v0,v0,4                  ORACLE: ori t0,t0,4
OURS: lw  a0,0(v0)                 ORACLE: lw  a0,0(t0)
```

### 1d. Why nothing landed — the residual moved to a NEW, named exclusion

Full ladder (all re-gated, all reverted; base **10 @393**):

| variant | diffs | insns | hoist? |
|---|---|---|---|
| A join read, no cell | 58 | 395 | — |
| B join read + cell (both uses) | 89 | 394 | **hoisted** (life 34) |
| D B + store adjacent to read | 57 | 394 | declined (life 5) |
| E arm reads + cell store adjacent | 45 | 392 | declined |
| F store after `r.x=0` | 115 | 396 | — |
| G r-set first, store late | 89 | 394 | **hoisted** (life 22) |
| H r-set first, store adjacent | 31 | 392 | declined (life 5) |
| K r-set last | 103 | 394 | **hoisted** (life 22) |
| L store between the two RMW halves | 95 | 396 | **hoisted** (life 17) |
| **M cell READ + identity fence + macro STORE** | 40 | **393** | declined (2 sets) |
| N as M without the fence | 89 | 394 | **hoisted** (life 34, cse merged read+store) |
| O r-set first, cell read, macro store | 89 | 394 | **hoisted** (life 22) |
| P cell read + fence + cell store | 37 | 392 | declined |
| Q fence after r-set | 51 | 394 | declined |
| R fence before the store | 69 | 394 | declined |
| S cell assigned in BOTH arms, join read | 55 | 394 | declined (2 sets) |
| T cell pre-assigned + re-assigned in arm | 39 | 390 | declined |
| U cell + read both arms | 37 | 392 | declined |

🔴 **THE NEW NAMED EXCLUSION (structural, not a spelling gap).** Retail needs
BOTH of these simultaneously and our pipeline can supply only one at a time:

* the cell must have **two uses** (read + store) on one pseudo — that is what
  produces `li` + two displacement-0 accesses;
* the cursor **store must sit ~14 insns after the read** (retail's schedule).

Two uses that far apart give `m->lifetime` 17–34 ⇒ loop.c hoists ⇒ callee-saved
`$s7` + frame growth (89 diffs). Collapsing the lifetime to ≤5 requires the
store adjacent to the read, and **sched cannot sink it back**: the cursor store
`*cell = …` is `(mem (reg))` — varying, non-struct — and the two 24-bit
bitfield RMW stores in between are varying struct refs, so
`fixed_scalar_and_varying_struct_p` (sched.c:846-56, catalog 14D) does NOT free
it and `true_dependence` chains them. The only spelling that makes the cursor
store a **fixed scalar** (non-varying address ⇒ schedulable) is the literal
macro — which by construction has no cell pseudo.

⇒ **WANTED (sharpened, replaces the old "selective anti-LICM" request):** a way
to make a `(mem (reg-holding-a-constant))` store carry a NON-VARYING address for
`rtx_varies_p`, or a loop.c dial on `savings`/`insn_count` rather than lifetime.
The three anti-LICM devices above are now catalogued and general — this fn just
cannot use them at the position it needs.

**DO NOT re-run:** the 17 spellings in-source, nor the 18 above.

---

## 2. 🏆 feaudio `FeAudio_InitViv` — FIRST CUSTOMER OF THE W63-A2 DEVICE
### → the device WORKS exactly as specified, and FALSIFIES this fn's certificate

The standing certificate (W60→W62, three rounds) named its missing instrument as
*"a way to lengthen a live range WITHOUT relocating a use"*, citing the proven
data point **"p87 refs=5 live=19 → $a3"**. W63-A2's **foreign-operand fence**
`__asm__("" : : "r"(NEIGHBOUR))` is exactly that instrument. Applied:

### 2a. The device's claims are CONFIRMED, quantified on this fn
(real CC1PLPSX `-dl/-dg`, harness `scratchpad/w63a16/dmp.py`; p86 = the swap
SOURCE word, p83 = `lumpyName` = the fence operand)

| basin | p86 refs | p86 live | p86 home | p83 refs | insns | gate |
|---|---|---|---|---|---|---|
| V4 (read-only fence on result) | 7 | 11 | **$a1** | 2 | 109 | 12 |
| V4 + 3 foreign fences | 7 | **14** | $a1 | 5 | 109 | 12 |
| V4 + 8 foreign fences | 7 | **19** | $a1 | 10 | 109 | 12 |

**Target refs are perfectly invariant (7 at every step), live moves +1 per fence,
the whole ref delta lands on the operand, and the byte count is FLAT at 109.**
A2's characterization is exactly right.

### 2b. 🔴 NEW LAW — REG_LIVE_LENGTH IS **NOT** THE ALLOCATION WINDOW

We reached the certificate's own named target — **live = 19 at refs = 7, zero
insn cost** — and p86 **still lands `$a1`**; the gate is flat at 12 @109 across
0/1/2/3/5/8 fences and two operand choices.

> `find_free_reg` (local-alloc.c) scans hard regs over the qty's
> **[birth, death) WINDOW**, taking the first reg free over that span.
> `REG_LIVE_LENGTH` feeds only `QTY_CMP_PRI` — i.e. the **ORDER** in which qtys
> are served. A device that adds live LENGTH without moving the last USE can
> therefore change only the serving order, never which registers are busy.

⇒ The certificate's inference ("extending the live range past the two header
loads flips it to $a3") was **the wrong causal reading of its own experiment**:
the winning variant also **MOVED A USE**, and it was that WINDOW change — not
the live number — that made `$a1`/`$a2` busy. The live-length axis is now
falsified for this fn, at zero cost, with dumps.

**FLEET COROLLARY (worth a catalog row):** the foreign-operand fence is a
**priority-only** dial. Before spending it, check whether the target qty is
already FIRST-served — if it is (as here: `QTY_CMP_PRI` 2·7/11 beats every other
qty in the block), demoting it changes nothing at all. And whenever a receipt
says "extending the live range flipped the home", verify the winning variant did
not also relocate a use; if it did, the fence cannot substitute for it.

### 2c. Gate ladder (all reverted; base **7 @110**)

| operand | ×1 | ×2 | ×3 | ×5 | ×8 |
|---|---|---|---|---|---|
| basin A (identity fence, 7@110) `lumpyName` | 7 | 7 | 7 | 7 | — |
| basin A `vivHandle` | 25 | 7 | 7 | 7 | — |
| basin A `fname` | 10 @111 | 10 @111 | 10 @111 | 10 @111 | — |
| basin B (V4, 12@109) `lumpyName` | 12 | 12 | 12 | 12 | 12 |
| basin B `vivHandle` | 30 | 12 | 12 | 12 | 12 |

(`fname` costs a real insn — it is not register-resident there; that is A2's
documented operand cost, reproduced.)

**A2's second device (REG_EQUIV live doubling) is inapplicable here by its own
gate:** it is global-allocno-only, and in the V4 basin p86 is a block-local qty
(`blk=2`); in the 7-diff basin p86 is already global AND already `$a3`.

The 7-diff basin's picture is also now confirmed on the record:
`p86 refs=9 live=16 "dies in 2 places" → GLOBAL → $a3` (retail's home), price =
the one carrier copy (110 vs 109). Certificate otherwise unchanged.

---

## 3. 🏆 femenudefs `__15tGlobalMenuDefs` — NEW ANGLE (the standing one refuted)

Re-baselined **3365 (3180/3207)**. The in-source receipt's standing NAMED ANGLE
is *"every one of these handouts is LOCAL-ALLOC QTY … use the instrumented cc1
[qty_order] trace"*. **That angle is wrong.**

### 3a. Alpha-rename is a NO-OP ⇒ this is not an allocation problem

Alpha-renaming every register to a per-stream first-appearance index (the 13F
`alpha.py` instrument, re-implemented inline over `verify_asm.ours/oracle`):

| view | LCS diff |
|---|---|
| raw | 1744 |
| **alpha-renamed** | **1744** |
| sp-displacement-blinded | 1875 |
| alpha + sp-blinded | 1875 |

A pure register rotation collapses under alpha-rename. This does not move **one
instruction**. ⇒ the residual is **emission STRUCTURE / ORDER**, not a handout.
Blinding the spill displacements makes it *worse*, so the frame-offset shift is
not the driver either.

### 3b. What it actually is — an opcode census

| op | ours | oracle | Δ |
|---|---|---|---|
| addu | 413 | 395 | **+18** |
| addiu | 482 | 494 | −12 |
| lw | 509 | 521 | −12 |
| sw | 786 | 799 | −13 |
| lui | 229 | 238 | −9 |
| li | 492 | 489 | +3 |

Ours carries **18 extra register-register moves** and **13 fewer spill stores /
12 fewer reloads**. Read at the first structural divergence (index 40, the third
member ctor):

```
OURS                          ORACLE
lw t1,640(sp)                 lw t1,640(sp)
lw t0,640(sp)   <- 2nd reload  (none)
addiu t1,t1,88   (mutate)     addiu s3,t1,88   <- FRESH dest, this+88 kept in a CALLEE-SAVED reg
addu a0,t1,zero               addu a0,s3,zero
addiu t0,t0,388               addiu t0,t1,388  <- SECOND address derived from the SAME reload
addu a2,t0,zero               addu a2,t0,zero
sw t1,140(sp)                 sw t0,84(sp)     <- ONE spill, not two
sw t0,144(sp)                 (none)
li s2,50 ; sw s2,16(sp)       li t1,50 ; sw t1,16(sp)   <- ours puts a scratch constant in a SAVED reg
```

⇒ **NAMED ANGLE (new): retail derives N sub-object addresses from ONE `this`
reload with FRESH destinations; we mutate the reload in place and therefore
re-load `this` for each.** That single habit explains all three census deltas at
once (+addu from the arg moves, −lw/−sw from the missing spills, −lui). It is a
cse/expression-shape question, addressable per-site, not a QTY handout.

### 3c. The frame receipt, completed (supersedes "the pad is optimal")

Exact sp-slot sets: retail uses **14 slots we never touch — 72,76,…,124** and we
use one it doesn't (596); everything else is identical, and every one of our
spills above offset 68 is retail's **+56**. That is precisely
`char compilerFramePad[56]` sitting at 72..127.

🔴 **A declared local can NEVER occupy those slots.** gcc assigns declared
locals at expand and reload spill slots later, both from the same upward-growing
`frame_offset`, so a pad is always BELOW the spill area. The pad therefore cannot
be "tuned" into the right place — it buys the correct `fsize` 640 (needed by the
244 `lw this,640(sp)`) at the price of mis-siting **every** spill. The real
target is +14 spilled values, i.e. §3b's reload/pressure habit.

**Report only (nfs4_types.h is off-limits to me):** the ctor's member-init order
is fixed by the class declaration order, so none of the ordering deltas above
are reachable from `femenudefs.cpp`; they are all cse/reload effects.

---

## 4. femenuoptions `Draw__17tUserNameMenuItemb` — 2 new falsifications (8, held)

Residual unchanged: two copies of `li v1,156 / subu a3,v1,a3` vs retail
`li t0,156 / subu a3,t0,a3`, count-exact 254/254.

Oracle read (`scratchpad/w63a16/un.sbs`): retail's `$t0` previously held the
`x` **reload** (`lw t0,88(sp)`), dead after `addiu s1,t0,156`; the `li t0,156`
recycles that reload register. It is a reload-register recycle, not a source
variable, so 12D dead-pseudo staging has no carrier to name.

NEW, both reverted (base 8):

| probe | diffs | insns |
|---|---|---|
| `boxRight` hoisted above the preceding `DrawShapeExtended`, fence at the decl | **73** | 253 |
| same, fence kept at the use | **67** | 253 |

Both lose an instruction (253) — the two blocks' constants merge into one — so
the constant must stay per-block. W62-A15's conflict-structure certificate
(`;; 196 conflicts: … 2 29`, find_reg's ascending scan hands it `$v1`) stands
unchanged; the 13B copy devices remain inert here by the governing limit.

---

## 5. CATALOG-ROW CANDIDATES (for the orchestrator)

1. 🔴 **REG_LIVE_LENGTH ≠ THE ALLOCATION WINDOW** (§2b). `find_free_reg` scans
   over `[birth, death)`; `REG_LIVE_LENGTH` only feeds `QTY_CMP_PRI` (serving
   ORDER). The foreign-operand fence is therefore a **priority-only** dial: it
   cannot make a register busy. Check the target is not already first-served
   before spending it. Whenever an old receipt says "extending the live range
   flipped the home", check whether that variant also MOVED A USE — if so the
   flip was a WINDOW change and the fence cannot substitute. (InitViv reached
   the certificate's own target live=19 at refs=7, 0 bytes, home unchanged.)
2. **THREE selective anti-LICM devices, ranked** (§1c): (a) USE-ADJACENCY —
   collapse `m->lifetime` below `insn_count/threshold`; (b) IDENTITY FENCE on
   the pseudo — the fence is a **second SET**, so `set_in_loop != 1` and no
   movable is ever created (works at ANY lifetime, costs a barrier);
   (c) ARM-DUPLICATED ASSIGNMENT — two sets, **barrier-free**. All three dump-
   verified on one function. `-dL` on cc1plus prints the verdict directly.
3. **Solving loop.c's threshold from its own dump**: four verdicts in one loop
   bracket `T` numerically (here `T ∈ [22.6, 33.2)` at insn_count 181), giving
   the exact lifetime budget before you write any variant.
4. **A two-use address pseudo whose uses are far apart is UNREACHABLE in a
   loop**: far apart ⇒ hoisted; adjacent ⇒ the store cannot be sunk back,
   because `*cell` (mem of a reg) is *varying, non-struct* and so is not freed
   by `fixed_scalar_and_varying_struct_p` against varying struct stores. Only
   the literal-address spelling is a "fixed scalar" — and it has no pseudo.
5. **ALPHA-RENAME AS A TRIAGE OPENER on monsters** (§3a): if alpha-renaming
   does not move the diff by one instruction, the residual is NOT an allocator
   rotation and every qty/allocno instrument is the wrong tool. Cost: one run.
   It refuted a standing multi-wave named angle here.
6. **A frame PAD can never sit above the spill area** (§3c) — declared locals
   are assigned at expand, spills at reload, from one upward-growing offset. A
   pad that restores `fsize` necessarily mis-sites every spill; the only real
   fix is more spilled values.
7. **The board's percentage column is not a residual** — 6 of 10 rows on this
   belt were already PASS, including two briefed as "near-sealed, finish".

---

## 6. FILES / HARNESSES / HAZARDS

**Landed: nothing.** All seven belt TUs verified clean (`git status`) and
re-gated at their baselines at finish.

Harnesses (`scratchpad/w63a16/`): `dmp.py` (cc1plus `-dl/-dg/-dL` section
extractor **with the mandatory `-fno-exceptions -fno-rtti`** — `tools/fast.py`'s
own `picture()` omits them), `rd.py` / `rd2.py` / `rd3.py` (Redraw variant +
loop.c-verdict ladder), `viv.py` (InitViv fence ladder).
Captures: `redraw.sbs`, `D.sbs`, `M.sbs`, `viv.sbs`, `un.sbs`.

Hazards hit:
* 🔴 **`recon/frontend/common/feaudio.cpp` is CRLF** (551/551) while feapp.cpp
  is LF. A hand-rolled `orig.replace()` with `\n` anchors **silently no-op'd**
  and produced four IDENTICAL "different" dumps that I nearly reported as data
  (12K, firing again). `tools/fast.py`'s `run()` does the ending fix; anything
  hand-rolled must copy it **and assert the anchor matched**. The tell was that
  a variant with a known-different gate produced a byte-identical dump.
* `tools/verify_asm.py` reads `sys.argv` at import, so any script that
  `exec_module`s it must be invoked with `<cpp> <fn>` on its own argv.
* cc1's dump files are keyed by the **demangled C++** signature
  (`FeAudio_InitViv(char *)`), not the mangled symbol.
