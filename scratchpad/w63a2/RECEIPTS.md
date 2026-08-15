# W63-A2 RECEIPTS — draww belt + THE DEVICE LAB

Repo HEAD at start: `10e1a01b`. All numbers below re-gated by me with
`tools/verify_asm.py` (VA_MAX=400) unless marked otherwise.

## 0. RE-GATED BASELINE (whole TU, `tools/tugate.py recon/game/psx/draww.cpp`)

`26/35 PASS`:

| fn | board % | MY re-gated diffs |
|---|---|---|
| DrawW_BuildObjectFacets | 98.86 | **6** |
| DrawW_BuildChunkObjectFacets | 96.46 | **19** |
| DrawW_DoObjects | 92.79 | **30** |
| DrawW_SubdividFacet | 98.94 | **35** (ours 587 / oracle 588, ONE SHORT) |
| DrawW_BuildSpikeBelt | 95.13 | **66** |
| DrawW_DoTrough | 92.15 | **86** |
| DrawW_OnyxLinePrim | 98.36 | **101** |
| DrawW_BuildCustomObjectFacets | 81.76 | **105** |
| Draw_kCtrlSkidmark | 91.07 | **303** |

---

# ASSIGNMENT 1 — THE ZERO-INSN LIVE-RANGE EXTENDER

## 1A. THE LAW THAT BOUNDS THE WHOLE SEARCH (gcc-cited)

`flow.c:1594` `REG_LIVE_LENGTH (regno)++` sits inside
`flow.c:1399  else if (GET_RTX_CLASS (GET_CODE (insn)) == 'i')`.

⇒ **REG_LIVE_LENGTH counts REAL RTL INSNS ONLY.**  NOTE insns are counted by
neither branch.  This **falsifies, by construction, the whole "plant notes"
family** as a live dial:

* `{ }` block scope (`NOTE_INSN_BLOCK_BEG/END`) — **cannot** move live length;
* `do { } while (0)` (`NOTE_INSN_LOOP_BEG/END`) — **cannot** move live length.
  (It moves *refs* only, via flow.c's `loop_depth` weighting — which is exactly
  why the w44/w45 depth wrapper is a REF dial and was never a LIVE dial.)

⇒ any zero-byte live extender must be a class-`'i'` RTL insn that assembles to
zero bytes.  There are exactly two such things in this pipeline:
1. an **empty `__asm__` template** (ASM_OPERANDS/ASM_INPUT, 0 bytes), and
2. a **reg-reg copy whose two ends get the same hard reg** (`final.c` drops
   `(set (reg N) (reg N))` before output) — the "copy IS the mechanism" family.

## 1B. 🏆 THE DEVICE — THE **FOREIGN-OPERAND FENCE** (validated, quantified)

    __asm__("" : : "r"(SOME_OTHER_LIVE_VALUE));     /* placed INSIDE the
                                                       target's live range */

* `+1 REG_LIVE_LENGTH` for **every pseudo live across it** (it is a class-`'i'`
  insn);
* `+1 REG_N_REFS` **only for its own operands** — i.e. the ref lands on a
  *different* variable than the one whose live range you are stretching;
* `+0` emitted bytes.

This is the first instrument that **separates the live axis from the ref axis**
— the standing 14E / 13B "4-witness instrument request" (*"lengthen a live range
WITHOUT adding a ref"*).  The read-only fence's ref always landed on the target
before; putting the operand on a neighbour moves it off.

**MEASURED (lab3.py, DrawW_SubdividFacet `prim` = p383, real CC1PLPSX -dl/-dg):**

| fences inserted after `prim = …PrimPtr;` (operand = `sd`) | prim refs | prim live | sd refs | ours insns |
|---|---|---|---|---|
| 0 (base) | 3 | 3  | 25 | 587 |
| 1        | 3 | 5  | 26 | 588 |
| 3        | 3 | 7  | 28 | 588 |
| 6        | 3 | 10 | 31 | 588 |

⇒ **prim's refs never move; its live length moves +1 per fence** (the first
fence reads +2 because it also displaces the insn boundary).  The whole ref
delta lands on `sd`.  Byte cost: the fences themselves emit nothing (587→588
once, then flat at 3 and 6 fences) — the single +1 is the known 05C/13B
one-time barrier cost (an asm stops reorg's backward scan, so one delay slot
that was being filled goes to `nop`).

**COSTS / BOUNDARIES (state these when you use it):**
* it is still a **scheduling barrier** (reorg `stop_search_p` returns 1 at any
  asm, reorg.c:685-712) — so it is not usable where a delay-slot fill must
  cross the insertion point;
* `+1 live` per fence is a **linear** dial — it is a razor instrument (1–5
  units), not a way to buy tens of units;
* the operand must be **register-resident** at that point, else it costs a real
  `lw`/`addiu` (w45 fence cost profile);
* the operand's own allocno moves (+1 ref) — price the neighbour too.

## 1C. THE SECOND DEVICE — `REG_EQUIV` LIVE-LENGTH DOUBLING (found, not yet witnessed)

`local-alloc.c:1149-1153` (`update_equiv_regs`):

```c
      if (note)                       /* note = a REG_EQUIV on the single set */
	{ ...
	  if (REG_LIVE_LENGTH (regno) >= 0)
	    {
	      /* Note that the statement below does not affect the priority
		 in local-alloc!  */
	      REG_LIVE_LENGTH (regno) *= 2;
```

⇒ **a REG_EQUIV note DOUBLES the pseudo's live length at zero insns and zero
refs** — a pure `allocno_compare` DEMOTE dial (the in-source comment says it
does *not* touch local-alloc's `QTY_CMP_PRI`, so it is a **GLOBAL-allocno-only**
device; useless on a block-local qty).

Three routes to plant the note, with their exact gates:
1. **MEM route** (`local-alloc.c:1135-1139`): the pseudo's single set is
   `reg = MEM`, `REG_N_SETS==1`, `REG_BASIC_BLOCK(regno) >= 0`, and
   `validate_equiv_mem` holds — no aliasing store, **no CALL_INSN inside the
   life unless `RTX_UNCHANGING_P(memref)`** (i.e. a `const`-qualified source
   survives calls), no REG_DEAD/REG_INC of a register used in the address.
   `validate_equiv_mem` returns 1 the moment it reaches the pseudo's own
   REG_DEAD note, so a call *at* the last use is fine — only calls strictly
   inside the life kill it.
2. **STORE-BACK route** (`local-alloc.c:1069-1080`): a `MEM = reg` store whose
   MEM is unmodified over the reg's life and unread between init and store puts
   the REG_EQUIV on the *init* insn.  Same `REG_BASIC_BLOCK >= 0` gate.
3. **CONSTANT route**: a `REG_EQUAL` note with a `CONSTANT_P` source is promoted
   in place to `REG_EQUIV` (`local-alloc.c:1116-1117`).
   ⚠ side effect of all three: `reg_equiv_replacement` is set, so reload may
   rematerialize the value from the MEM/constant instead of keeping a register —
   always gate.

Not yet witnessed in-tree; the SubdividFacet witness fails gate 1 (a `"memory"`
clobber in the OT-link template + the call).  Filed as a named angle.

## 1D. 🔴 FALSIFICATION OF A STANDING RECEIPT — SubdividFacet's `prim` is **p383**, not p90

The in-source w62-a2 receipt quantifies the residual on **p90**
(`refs 6 / live 54 / crosses 1 call / GLOBAL / $s0`, `pri .2222`) and derives
*"prim must fall below p187's .1274, which at 6 refs needs live > 94"*.

**That is the wrong pseudo.**  Re-measured (lab1/lab2/lab3, real CC1PLPSX):

| variant | p90 | p383 |
|---|---|---|
| base (35 @587) | refs 6 live 54 GLOBAL **$s0** | refs 3 live 3 **blk 62** local **$a0** |
| + tail read fence (36 @588) | refs 6 live 54 GLOBAL **$s0** (unchanged) | refs 4 live 10 blk 62 local **$s0** |

p90 is **identical in both**; p383 is the one that moves `$a0`→`$s0` exactly as
the w61-a2 receipt describes for `prim`.  `prim = p383`, and it is a
**BLOCK-LOCAL qty in block 62**, so `allocno_compare` never even sees it —
`local-alloc`'s `find_free_reg` does.

**⇒ QUANTIFIED HARDNESS CERTIFICATE for cluster (b):**
`local-alloc.c:2204-2215` — for a call-crossing qty `used` is seeded with
`call_used_reg_set` and then ORed with `regs_live_at[]` over the qty's span,
which holds **HARD regs only** (`REG_SET_TO_HARD_REG_SET` of
`basic_block_live_at_start`).  Nothing in block 62 holds `$s0/$s1/$s2`, and the
numeric scan is plain ascending ⇒ **a block-local call-crossing `prim` can ONLY
ever be `$s0`**, at any refs/live.  Retail's `$s3` is therefore *unreachable*
while prim is block-local: **prim must become a GLOBAL allocno**, and then it
must ALSO cross a call (or every caller-saved reg would win the numeric scan)
and sort below `p82` (`pri .105`).

**MEASURED LADDER (lab2/lab4):**

| shape | prim row | order | reg | gate |
|---|---|---|---|---|
| base | refs 3 live 3, local blk62 | — | a0 | 35 @587 |
| tail read fence | refs 4 live 10, local blk62 | — | s0 | 36 @588 |
| identity launder at the def (`"=r"/"0"`) | refs 5 live 5, **GLOBAL** "dies in 2 places" | 1st | a0 | 40 @588 |
| identity launder ×2 | refs 7 live 6, GLOBAL | 1st | a0 | 40 @588 |
| identity launder + tail fence | refs 6 live 12, GLOBAL, crosses 1 call | 1st | s0 | 41 @589 |
| **hoist the PrimPtr load above the backface block** | refs 3 live 28, **GLOBAL** | 12th | a0 | 42 @586 |
| **hoist + 1 foreign fence** | refs 3 live 29, GLOBAL, **pri .1034 → sorted AFTER p82** | 13th | a0 | 47 @587 |
| hoist + tail read fence | refs 4 live 35, GLOBAL, crosses 1 call | 4th | **s1** | 475 @601 |

Two independently-necessary conditions, and I can hit **either** but not both:

* **priority < p82's .105** — reached by *hoist + 1 foreign fence*
  (refs 3, live 29 → .1034; the globals order line literally shows `… 82 383 84 …`);
* **crosses a call** (else the numeric scan hands out `$a0`/`$v0` before any
  callee-saved reg is considered) — every way of crossing the call is a *use
  after the call* = **+1 ref**, which at refs 4 moves the bar to `live > 76`
  (i.e. +41 more foreign fences from live 35).

So the residual is now a *named two-condition* problem, not a coloring tie:
**"make `prim` cross the AddSubdividPrimGT4 call without adding a reference."**

**NEXT NAMED ANGLE (not attempted, budget):** the 12D DEAD-PSEUDO STAGING LAW.
The SYM gives `prim` **and** `v4` both as `REG $s3`, and `v4` = p187 (refs 11 /
live 259 / crosses 10 calls) **already owns `$s3`** in our build.  Staging the
leaf `prim` through the *existing* call-crossing pseudo that owns `$s3` (rather
than minting a new one) is the shape 12D says retail used; it needs `v4`'s
declaration lifted to the enclosing scope and a cast at the leaf uses.  Price it
with `tools/reqdelta.py` on the merged allocno before writing code (merged row
would be refs ~14 / live ~287 → pri .146, which lands 5th — that has to be
checked, it may need its own dial).

**Falsified here (all re-measured myself, from the 587 basin unless noted):**
identity launder ×1/×2, identity launder + tail fence, foreign fences 1/3/6
alone (40 @588 each), hoist alone, hoist + foreign fence, hoist + tail fence.

---

# ASSIGNMENT 2 — THE draww BELT

## 2A. 🏆 LANDED: DrawW_BuildChunkObjectFacets **19 @433 → 8 @434 COUNT-EXACT**
commit `1bf09396`.  FIRST APPLICATION OF THE FOREIGN-OPERAND FENCE.

The w46 cluster-(A) named angle had stood for three waves: *"buy objDef's +4 live
somewhere that is NOT an emission-order change"*.  w62 falsified the obvious
instrument — a read-only fence ON objDef — because it costs an insn **and** puts
the +1 ref on objDef, which RAISES the priority (the wrong direction).

The landing is a PAIR, neither half works alone (13F lever-order-dependence):
1. move case 2's `objDef = Track_gObjDefs[objInstance->pad];` to the SLD/oracle
   position — after the last `jal fixedmult` **and** after the three
   `matrix.m[2]/[5]/[8]` stores  → **33 diffs** alone (objDef p89 live 86→79,
   loses `$s6` to `$s5`, exactly as w46/w62 measured);
2. **one foreign-operand fence** `__asm__("" : : "r"(objInstance));` in case 1
   between `objDef = …` and the `DrawObjectSimple` call → **24 diffs** alone;
   together → **8 @434**.

Measured on the real CC1PLPSX `-dl` dump: `objDef` (p89) **live 79 → 85, refs
UNCHANGED at 20**.

**OPERAND CHOICE IS A REAL DIAL** (this is the device's directional law in one
table, all re-gated by me):

| fence operand in case 1 (+ the case-2 move) | gate |
|---|---|
| `objInstance` (a neighbour)   | **8 @434** |
| `Vi`                          | 23 @435 |
| `objDef` itself (= the w62 read-only fence) | 220 @434 |

Fence COUNT is flat: N = 1,2,3,4,5,6 all gate 8 @434 → **land the minimum (1)**.
(N = 8 → 134 @434: past some point the barriers start costing.)

Dual-lane: `tools/psyqproof.py` (psq43 cc1 + ASPSX 2.77) reports
`434 words, REAL=121 RELOP=21` **both before and after** — my edit is
production-NEUTRAL (measured with an explicit `git show HEAD:` control run,
`scratchpad/w63a2/pq_ctl.py`).  The production residual for this fn is a
separate pre-existing class, not something this landing moved.

Gate 2×, `tugate` 26/35 unchanged (zero PASS→FAIL), `tu_order_audit` 0.

**RESIDUAL 8, count-EXACT**, two clusters:
* the ONE `addu v0,s7,zero` retail puts in the zero-trip-guard's delay slot
  (a distinct `return totalCount;` exit site) where we emit `nop`.  Since we are
  now count-EXACT, minting it is free — but re-probed from THIS basin:
  `if (groupNumElements == 0) return totalCount;` before the loop is
  BYTE-IDENTICAL (jump.c folds it), `if (groupNumElements <= 0) return …` is
  48 @438, and the un-rotated `while(1){ if(!(i<n)) return totalCount; …}` shape
  is 17 @**429** (5 SHORT — a genuinely different, shorter basin worth its own
  pass).  ⇒ the 04T "return the VARIABLE" family does not reach it from a
  rotated `for`; the reachable route is the un-rotated shape + 5 recovered insns.
* a 2-insn transposition `lui a1,8064 / lw a0,128(sp)` and the `sw s5,40(sp)`
  position — sched2 emission order.

## 2B. DrawW_SubdividFacet — re-diagnosed, certificate above (§1D).  NOT LANDED.
Base stands at 35 @587 (ONE SHORT).  See §1D for the two-condition statement and
the 12D staging angle.

## 2C. DrawW_BuildObjectFacets — 6 @189 count-EXACT, LEFT ALONE (evidence-based)
Residual is the `goffsets[]` address scratch (`lui t0` ours vs `lui v1` oracle),
six waves deep.  w62-a2 established the blocker is the `find_free_reg` WINDOW
and that the instrumented cc1plus lab is **not byte-faithful for this fn**
(186 vs 188 insns), so its trace may not be quoted (12H).  I re-read the whole
falsification list (ref dials, qty-count 3↔4 probes, all storage-shape views, all
four address spellings, index-term-first) — the one axis never tried is a LIVE
dial at the qty layer, but the address qty's whole live range sits **inside one
expression**, so no fence can be placed inside it.  ⇒ the device does NOT reach
this one; recorded as such rather than burning budget.

## 2D. DrawW_DoObjects — 30 @222 count-EXACT, NOT MOVED
Five waves; residual = six 1-3-slot transpositions, all ours-EARLIER (the sched2
drain class) + the range-chain rematerialization.  The standing named angle is
*"a real `$a0` CLOBBER between the two track-guard chains that is not an extra
insn"*.  My device cannot supply it: a fence cannot choose its operand's hard
register, and hard-register clobber fences are the USER-sign-off class (AGENT_GUIDE
§4.4).  The w53/w62 opacity-fence route costs +1 insn because `thisChunkInd` is a
cross-block pseudo (12E's documented boundary: the launder forces a real copy).

## 2E. DrawW_BuildCustomObjectFacets (105), DoTrough (86), OnyxLinePrim (101),
BuildSpikeBelt (66), Draw_kCtrlSkidmark (303) — NOT WORKED THIS PASS.
BuildCustomObjectFacets's PARM-STAYS-SPILLED class does **not** yield to the
extender: forcing a param to its ARG home needs the callee-saved pool to be FULL
at its rank (the w40 ARG-SPILL-FORCING recipe = MORE allocnos), whereas the
extender only DEMOTES an existing allocno — and every fence lengthens *every*
pseudo live across it, so it cannot move `sd` relative to rivals that are live
everywhere `sd` is.  Its receipted route is unchanged: the whole-function rule-8
rewrite (delete ~20 fabricated locals, materialize the SYM's nine REG locals),
which is a one-function-per-session job.

## 2F. FINAL TU STATE (re-gated, HEAD `1bf09396`)
`recon/game/psx/draww.cpp: 26/35 PASS` — 6 / **8** / 30 / 35 / 66 / 86 / 101 /
105 / 303.  Net: **−11 diffs, zero regressions.**
