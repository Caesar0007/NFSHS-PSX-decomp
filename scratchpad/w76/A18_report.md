# W76-A18 -- libmcrd belt (LIBMCRD.c, cc1_272 lane)

## Headline

| fn | baseline | final | verdict |
|---|---|---|---|
| MemCardCreateFile  | FAIL 4 @130/130 | **PASS 130/130** | **PIN-SEALED** (3-part joint cell; wordcmp REAL=0; strict_branch 13/13 CLEAN) |
| MemCardGetDirentry | FAIL 23 @153/152 | **FAIL 8 @152/152 count-exact** (posmis 13) | -15; residual = the W74-certified class-(a) rung floor + its tail reload; one named additive angle left |

Whole TU: **24/26 -> 25/26 PASS**, zero PASS->FAIL, gated twice at the close, `tools/slotcheck.py`
bad = 0 (run after both landings).  `tools/build.py` NOT touched (user + other belts' hunks intact).
Source delta = one TU only (`git diff`: 86+/18- on LIBMCRD.c, receipts included).

## 1. MemCardGetDirentry 23 -> 8: the W75 named angle landed -- and the device that landed it is
##    the one the four falsified basins never tried

**The W75 receipt asked for**: `mc.chan` read as base+offset off the compiler's own `mc` cse base
WITHOUT an asm in that basic block.  **What actually works**: there is no way to keep the
compiler's own base un-folded -- and no need.  The collector is a **single fn-scope
opacity-laundered `int *pc = &mc.cmd`** (declared above the busy guard, laundered once) that
carries **every** mc access in the function: entry guard `pc[0]`, RMW `pc[3]`, handler guard
`pc[0]`, latch stores `pc[0..2]`.  This is the full DeleteFile/CreateFile anchor design; the four
falsified "base-anchor" basins all ADDED an anchor next to the compiler's own cse base (9th
allocno -> band rotation).  This one REPLACES the compiler's base (same allocno count).

**Why the launder is load-bearing (compiler-source, dumps kept)**: RTL dumps on the CC1PSX 2.7.2
binary itself (`-ds -dc -dS -dl -dg` all work; dumps `scratchpad/w76/rtl/A18_base.i.*`) show the
plain-source fold-back is **cse2**, not cse1: after cse1 the chan read is `mem(reg84+12)`
(base-relative, retail's very shape); cse2 rewrites it to `mem(const(mc+12))` -- cse's fold_rtx
const-propagates a base register whose qty is REG_EQUAL-known along the extended path, and once an
address is CONSTANT_ADDRESS_P, find_best_addr never re-touches it (cse.c:2707 early return).  The
+0 accesses survive because a bare `(reg)` address skips the fold step (`GET_CODE (addr) != REG`
gate, cse.c:2714) -- which is exactly why five waves saw guards/latches base-relative while every
non-zero-offset access came out as the `lui/lw` macro.  The launder removes the REG_EQUAL, so
nothing folds; ADDRESS_COST never enters into it (mips: reg+d costs 1, symbolic 2 -- the fold that
happens is a rtx_cost/src-substitution, not find_best_addr).

**The measured ladder** (every step whole-TU gated; prober `scratchpad/w76/A18_probe.py`):

| step | edit | gate |
|---|---|---|
| base | shipped W75 basin | 23 @153/152 |
| G1 | plain chan read, init fences moved into the then-block | 26 (chan still macro; blez slot fills with the WRONG init) |
| G2 | + retail init order: `fretry, idx` early, **`stored` LAST** | 22 @152/152 (reorg backward fill takes the CLOSEST eligible init -> source init order IS the slot-filler dial) |
| G4 | fence move alone, pc block kept | 23 (inert -- fences were never the blocker) |
| G5 | fn-scope opaque pc, ALL accesses | 49 (band rotated: pc pri .8648 ranks over idx) |
| G5c | + latch do-while(0) UNWRAPPED (-3 weighted refs on the base) | 39 (fretry .5192 vs pc .527 -- the 0.008 window again) |
| G5d | + fretry read-only fences (**ref counting is PER-INSN**, +1 per fence insn, a 2-operand fence buys only +1) | 17 -- band retail-exact: idx $s1 .6666 > fretry $s2 .6000 > pc $s3 .5064 > giv $s4 .3783 (qty272 receipts `A18_G5d_qty.txt`) |
| G6 | + the W71 read-before-store hoist ported (`prevcb`/`cmd0` block: read `pc[0]` BEFORE the `_mc_save_cb` store) | 12 (guard load lands v1, store after -- retail order) |
| G7 | + **`cmd2 = 2` DEMOTE local** (fn-scope, set with the inits, single use `pc[0] = cmd2`): long-live/low-pri -> keeps REG_EQUIV -> global alloc passes it over -> **reload remats `li t0,2`** and reorg's target-thread steal drops it into the blez delay slot exactly like retail | **8** |
| G7e | device minimization: idx fence UNNECESSARY (8); 3 fretry fences = the minimum (2 -> 34) | 8 (landed form) |

**Free side wins inside the basin** (no extra devices):
* the chan WRITE un-folds by itself: plain `mc.chan = chan` against the opaque pc has no const
  base to relate to -> stays the `sw $23,mc+12` macro -> **gas splits it into UserFuncOpen's jal
  slot** = retail's `lui $at ; jal ; sw $s7,%lo(D_80147524)($at)`.  The read/write asymmetry the
  w59-a8 "REFINED NAMED ANGLE" wanted comes out of the one-anchor design for free.
* the `li 2` target-thread steal into the blez slot is reorg's natural choice once the constant
  is a remat (it becomes the latch thread's first eligible insn).

**REMAINING 8 = one class.**  `sw $a3,156` vs retail `92($sp)` (the W74 class-(a) certificate:
2.7.2's alter_reg passes align=-1 unconditionally -> 8/8 spill slots; source-unreachable on this
rung) plus the `files` tail reload riding the same slot (`lw v1,156` vs `lw t0,92`).  Tail-REG
dials re-measured on THIS basin (the ring membership changed -- the cmd2 remat is a new
participant): clobber `"$2"` (kept) v1 / 8 | none v0 / 9 (+nop, loses the beqz-slot `sw s5` fill)
| `"$3"` 9 | `"$2","$3"` a0 / 8 (ring walks one reg per name, 24F/23D confirmed) | `"$2".."$7"`
24 (bad_spill_regs displaces the max-reload/end-pointer $t0 users -- W74's verdict re-confirmed).
The reg half is worth 4 rows.  **NAMED ANGLE (unclaimed, from W74, still the right ask): the
ADDITIVE ring dial -- give $2 more hard_reg_n_uses so order_regs_for_reload demotes it in the
ascending-uses sort, instead of forbidding it.**  Beyond that, class (a) keeps its quantified
floor.

## 2. MemCardCreateFile 4 -> PASS: the 3-part pin cell (PIN-SEALED, last resort)

W75 proved the row unreachable by every compiler-input device (no source fence can reach past the
arg moves; flag/ladder falsifications listed in the TU receipt; SLOT_UNFILL forbidden by policy).
Under the W76 policy (pins permitted, last resort only) the row fell to a **joint 3-part cell** --
each part alone measured INERT this wave (pins-no-wall 4, one-pin+wall 4, wall-only 4):

1. `register char *dn __asm__("$4") = devname;` -- the devname address materializes at the DECL
   (retail's early `addiu $a0,$sp,16`), not inside expand_call;
2. `register long m1 __asm__("$5") = 1;` -- same for the mode constant (`li $a1,1` early);
3. `__asm__ __volatile__("" : : "i"(0));` between the pinned sets and the RMW -- the
   stop_search_p wall: reorg's backward scan dies before reaching either pinned set, the open()
   jal slot stays EMPTY, and GNU as backward-fills it by SPLITTING the `sw $3,_mc_present`
   macro -- retail's `lui $at ; jal open ; sw $v1,%lo(_mc_present)($at)` byte-exact.

The pins force nothing the ABI does not already force ($4/$5 ARE the open() argument registers);
they only move WHERE the values materialize.  Verified: wordcmp REAL=0 (38 reloc-word diffs, all
expected unlinked), strict_branch 13/13 CLEAN, slotcheck bad=0 (the zero-insn wall was NOT eaten
as a slot filler).  Counted separately per the brief: **PIN-SEALED, not a clean seal.**

## 3. New laws / corrections (for the catalog)

1. **cse2 is the macro-fold-back pass, and its gate is the REG_EQUAL const, not address cost.**
   cse1 leaves a struct access base-relative; cse2 const-props the base back into the address
   wherever the la's REG_EQUAL is visible on the extended path.  Bare `(reg)` addresses (+0
   accesses) are immune (`GET_CODE (addr) != REG` gate before the fold, cse.c:2714; constant
   addresses then locked by the CONSTANT_ADDRESS_P early return, cse.c:2707).  ONE opacity
   launder at the anchor's definition protects EVERY downstream access -- no per-block asm needed
   (retires the W75 "asm walls the blez scan" dilemma: the wall was only ever needed because the
   launder sat in the wrong block).
2. **Anchor REPLACEMENT vs anchor ADDITION.**  A fn-scope laundered base is only a "9th-allocno
   band rotation" when plain accesses remain to mint the compiler's own base beside it.  Route
   ALL accesses through it and the allocno count is unchanged -- the falsified base-anchor family
   was falsified on incomplete ports (4 basins, all partial).
3. **Read-only fence refs count PER-INSN on this lane** -- a 2-operand `"r"(x),"r"(x)` fence buys
   +1 ref, two separate fence insns buy +2.  (Refines the W61-A3 "3rd operand bought one step"
   reading: it was the insn, not the operand.)
4. **The DEMOTE-class honest shape works on 2.7.2**: a fn-scope constant local, set once with the
   inits, used once far away = low-pri allocno that keeps REG_EQUIV -> reload remats at the use
   with a RING register (retail's spilled-constant shape).  No address-taken trick needed --
   liveness alone demotes it (`(void)&x` remains unnecessary AND wrong per W75-A11).
5. **Init source order = reorg's backward-fill selector** (G2): the fill takes the closest
   eligible init above the branch; put the init whose reg retail carries in the slot LAST.
6. **The eager target-thread steal serves a remat li**: once the latch constant is a reload
   remat, it is the thread's first insn and reorg carries it into the guard's slot, retargeting
   the branch -- source-reachable via the demote local (complements 21B(5)).
7. **Ring re-confirmations on a new basin**: one clobbered name = one ring step ($2->v1,
   +$3->a0); wide clobbers displace the OTHER $t0 customers (function-wide bad_spill_regs);
   a new remat participant re-rotates the later picks (24E(1) held exactly).

## 4. Falsified this wave (do not re-run)

* G1/G4: fence position was NEVER the chan-read blocker (the W75 cse-flush hypothesis is dead --
  input-only asms are cse-transparent; the label/path story decides).
* G8d `"$2".."$7"` tail clobber: 24 (displacement of the max/end-ptr users, second confirmation).
* CF2/CF3/CF4: every 2-of-3 subset of the CreateFile pin cell is inert at 4.
* G5 without the ref re-pricing: 49; G5c single-step fence: 39 -- the band window is 0.008-0.01
  wide on this fn; price with qty272 first, always.

## 5. Artifacts (untracked, scratchpad/w76/)

`A18_probe.py` (all variants, byte-mode CRLF, always-restoring) | `A18_base_tugate.txt` |
`A18_preland_LIBMCRD.c.bak` (pre-landing snapshot) | `A18_G1/G2/G5/G5c/G5d/G6/G7*.s` +
`A18_G*_diff.txt` + `A18_G5_qty.txt`/`A18_G5c_qty.txt`/`A18_G5d_qty.txt` |
`rtl/A18_base.i.{cse,cse2,loop,combine,sched,lreg,greg}` (CC1PSX-native dumps; NOTE: the
`.i` snapshotted was the last-compiled probe variant, label it accordingly) |
`A18_G2_diff.txt` etc.

## 6. Process notes

* `scratchpad/w76/rtl/` was ALREADY populated by a sibling belt (DIVDF3/stcdint files) when I
  "created" it -- shared-dir hazard; all my dumps are `A18_`-prefixed.  Belt-id prefixes on
  EVERYTHING in shared scratch dirs.
* qty272 ran clean here (no multi-word allocnos in this fn -- the " (2)" parse crash never fired).
* The G5d variant was produced by a text-transform bug (each fretry fence line doubled, giving 4
  fences where 2 were intended) -- and it MEASURED BETTER than the intent.  The minimization pass
  (G7b/c/d/e) then found the true minimum (3).  Sweep-generated variants deserve a read-back
  before interpretation.
* CC1PSX (2.7.2.SN32) accepts `register ... __asm__("$4")` with the numeric-dollar spelling
  directly; no ABI-name fallback needed.
