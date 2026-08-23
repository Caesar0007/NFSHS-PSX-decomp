# W76-A6 draww-B belt report (2026-08-23)

TU: `recon/game/psx/draww.cpp` (unit `game/psx/draww`). Shared clone with belt A5 (resumed
mid-belt); ALL probing done per the fleet rule -- private snapshot (`scratchpad/w76/A6_base*.cpp`)
-> temp sibling TU `draww_a6probe.cpp` via `scratchpad/w75/A6_probe.py` (deleted in `finally`;
leftover check clean) -- the real file was written exactly twice (one landing + one receipt pass),
re-read immediately before each write.

## HEADLINE

| fn | baseline | final | note |
|---|---|---|---|
| `DrawW_BuildCustomObjectFacets__...P5Groupi` | 6 @200/200 posmis 7 | **PASS 200/200** | SEALED -- clean, device-minimal, class-(B) trade retired too; psyqproof REAL=0 RELOP=0; slotcheck bad=0 |
| `DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry` | 9 @358/359 | 9 (unchanged) | 12 new falsified cells + a SYM discovery that RE-FRAMES class (b); receipt in TU |
| `DrawW_OnyxLinePrim__...MoreCache` | 66 @507/507 | 66 (unchanged) | the named second-biv construct BUILT + measured; half of it (g2 class) reproduces retail exactly; gcc-source-cited next angle in TU |

TU gate: **29/35 -> 31/35 PASS** (my +1 = BuildCustomObjectFacets; A5's resumed session sealed
BuildSpikeBelt concurrently). Gated twice at the end, plus after the landing. **ZERO PASS->FAIL**
(baseline fails {6,8,8,9,20,66} -> remaining {8 SubdividFacet, 9 DoTrough, 20 kCtrlSkidmark,
66 OnyxLinePrim}; the first two/last belong to A5 / future belts).
No pins, no asm insertions beyond the established zero-insn device families -- **PIN-SEALED count: 0.**
No build.py rows touched. slotcheck on the TU object: bad = 0.

## LANDED -- DrawW_BuildCustomObjectFacets 6 -> PASS 200/200 (three edits, one joint cell)

W75's d10 basin (laundered `g` + laundered `zo`) was reproduced at 5 @201 and DISSECTED:

1. **The one nop is the zo launder itself** (24D-4): the launder is ON THE DATAFLOW PATH
   (`lbu zo -> asm -> addu`), so no schedule can move it out of the zoffset load-delay slot and
   the zero-byte asm eats the slot. 24D-4's named cure (make the asm depend on the wanted load)
   was falsified in FOUR spellings here -- the QI operand promotion mints an `andi 255` or
   re-colors the block (tc5-before-launder 13, `"r"(tc5)` 11, `"r"(load-expr)` 65,
   `"r"((int)load-expr)` 11, all @201).
2. **The unmeasured cell wins**: `g` laundered + PLAIN `int zo` split + tc5 load after
   (NO zo device) = **2 @200**. In the g-basin the address qty already carries +2 refs from its
   own launder, so the index needs no boost -- W75's zo launder was only compensating for the
   address hoist the g launder kills at the source (24E-8). Retail registers AND retail emission
   order both fall out free.
3. **Class (B) re-priced in the new basin (21E-1) and FELL**: `sz` through
   `objCollideBoomInstance` (retail's true all-through-s2 shape) costs 44 alone, but with a
   compensating OUT-OF-LOOP opacity launder on `objInstance` it is FREE. Position law (24D-6)
   confirmed: head-block placements cost (3 @199 / guard polarity), inside the guarded body
   (after gte_SetTransMatrix) = PASS; a q2 variant (between totalCount=0 and the count load)
   also PASSes -- q4 landed.

Device-removal re-test (23B-3): loop-top void fence removed -> 1 @199 (the empty-beqz-slot law);
loop-tail launder removed -> 45 @199; g launder removed -> 68. All three stay; the landed set is
minimal. Production lane: `psyqproof` -> **200 words (-G4), REAL=0 RELOP=0** (22 reloc sites).

**Transferable law (catalog candidate):** *a launder on the INDEX of a load-use pair can never
leave the load's delay slot (it is on the dataflow path); when a sibling address-launder already
exists in the block, the index launder is usually REDUNDANT -- re-price the plain-split cell
before trying to slot-fill around the device.* And: *the compensation for one in-loop ref added
to a walker's rival is one OUT-OF-LOOP launder on the walker, placed inside the guarded body.*

## DrawW_DoTrough -- 9 unchanged; class (b) RE-FRAMED by SYM ground truth

**Discovery:** the SYM 8c block @0x800c6fa0 names NO `gteFlag` and NO `negOne` -- retail's
`li s7,1` / `li s6,-1` are LICM movables hoisted from in-loop LITERALS (4x zeroGTETransFlag=1,
5x light=-1); s5 is the hoisted address of the AUTO `tmp2`. The recon's named-constant locals
are fabrications (rule-8 SYM-empty-locals class), and the 3-wave "cse constant-sharing breaker"
ask has been chasing a shape retail never had.

Measured this belt (temp sibling, all reverted; base 9 @358):

| cell | gate |
|---|---|
| full-literal SYM-true shape (both vars deleted, 9 literal sites) | 77 @362 |
| + W72 off7d fence removed (23B-3 in the new basin) | 77 @362 |
| opaque tied-constant asm-init on gteFlag (`"=r"(x) : "0"(1)`), 4 positions | 36-46 @359 count-EXACT, `li v0,1` MINTS every time |
| multi-output gteFlag+negOne launder / separate launders | 48 / 54 @359 |
| volatile store cast `*(volatile short*)&sd->doublelayer = 1` | 9 (cse substitutes anyway) |
| elder plain `int one = 1` before gteFlag (23C-2 test) | 9 @358 (single-def/single-use const-props back -- law confirmed) |
| elder laundered `one` (launder late) | 12 @359 -- cse canon_reg rewrites the launder INPUT to the oldest 1-holder (s7), minting `addu v1,s7,zero` |
| elder laundered `one` (launder early) / gteFlag-after-store orders | 71-83 @362 |

**New device banked (catalog candidate):** the *opaque tied-constant asm-init*
`__asm__("" : "=r"(x) : "0"(K))` is the zero-REF cse-sharing breaker the W74 ask names --
K materializes as the asm's RELOAD (post-cse), so no register is ever recorded as holding K and
the second occurrence mints fresh. It works (count-exact, li minted) but is a sched1 black box
(the prologue interleave rotates) -- right tool only where the variable is REAL.

**Next angle (named in the TU receipt):** re-tune the device set inside the full-literal
SYM-true basin (w1/w2 jsons replayable) -- the movable landscape there is
1(x4,QImode)/-1(x5)/125(x4)/&tmp2 vs buildInd, and the current fences were tuned for the
fabricated-variable basin.

## DrawW_OnyxLinePrim -- 66 unchanged; the second-biv construct measured, half of it proven

The W74-named "SECOND REAL BIV" was built (o1: `int *g2 = (int*)geomVertices + 1;` pre-loop,
`g2 += 4` at BOTH advance sites, copy words split g2[5]/gv[7], g2[1]/gv[3], gv[0]/g2[0],
g2[3]/gv[5]): **213 @524** as a whole -- but the dissection is the receipt:

- **The g2 class reproduces retail's $s5 EXACTLY**: reduced giv anchored abs +16
  (disps +8/-8/0, one word spilled only from pressure). The W74 prepend/anchor law verified in
  the 2-biv setting: with g2 init at +4, the last g2-giv in body order is vt3's g2[3] (abs 16)
  -> anchor = retail's. This half is SOLVED; keep the o1 spelling.
- **The failure is the gv class**: ours REDUCES its 3 givs (anchor +20, a second new reg = the
  +17-insn pressure blowup) where retail keeps the biv DIRECT for 0/12/20/28.
- **gcc-source facts** (gcc-2.8.1-src/loop.c, cited in the TU receipt): DEST_ADDR givs have
  lifetime=1 (:4577); combine_givs SUMS benefit+lifetime into the leader; the reduce/ignore
  test is `lifetime*threshold*benefit < insn_count` (:3914), threshold =
  (loop_has_call?1:2)*(3+n_non_fixed_regs) (:3280), `benefit -= add_cost*biv_count` (:3881);
  a +0 access is never a giv (:4376).
- **Next instrument (named):** CC1PLPSX `-dL` on the o1 form -- the :3919 dump prints the exact
  `lifetime*threshold*benefit vs insn_count` numbers per class, turning the "make gv fail the
  test while g2 passes" question into arithmetic. Do NOT re-try single-class spellings (w72),
  the biv-kill launder (w75), or an un-advanced g2 (rejoins the one class).

## PROCESS

- Session-limit cut mid-belt (during the loop.c reduction-gate read); resumed and closed per
  orchestrator: proven work landed, receipts written into the TU at all three functions,
  TU gated twice, report written.
- A5 resumed on the shared TU concurrently; no collisions (temp-sibling protocol held, my two
  real-file writes were re-read-immediately-before, and A5's BuildSpikeBelt seal survived both
  my gates).
- All probe jsons replayable under `scratchpad/w76/a6_*.json` (p1-p10, q2-q4, r1-r3, t/u/v/w/o
  series); side-by-sides `a6_*_sbs.txt`; psyqproof log `a6_psyqproof.txt`.
