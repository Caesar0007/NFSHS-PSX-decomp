# W63-A17 receipts (screens + psxfront belt)

## Re-gated baselines (2026-08-15, HEAD 10e1a01b)
| fn | TU | board row | RE-GATED |
|---|---|---|---|
| GetPSXPadValue__Fii | front.cpp | 99.86 | FAIL 18 (222/222) |
| Front_InitOpponentCars__FR9tFEStream | front.cpp | 93.13 | FAIL 111 (358/357) |
| FontUpsideDownBlit__FiiPviiP12charactertbli | psxfront.cpp | 89.60 | FAIL 20 (82/82) |
| DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii | psxfront.cpp | 98.00 | FAIL 14 (245/245) |
| StatChk_IsTopTime__FP10Car_tStatss | statchk.cpp | 99.98 | **PASS 299** (stale row) |
| StatChk_SaveTopTime__FP10Car_tStatss | statchk.cpp | 95.84 | FAIL 33 (417/416) |
| MCRD_handlecardevents | memcard.c | 99.98 | **PASS 211** (stale row) |
| DrawBackground__25tScreenCarSelectTwoPlayer | screencarselect.cpp | 99.93 | **PASS 342** (stale) |
| DrawOpponentVideoWall__20tScreenCarSelectDuels | screencarselect.cpp | 99.93 | **PASS 73** (stale) |
| DrawVideoWall__20tScreenCarSelectDuels | screencarselect.cpp | 99.94 | **PASS 86** (stale) |
| CalculatePrizes__23tScreenTournamentTrophy | screencongrats.cpp | 99.97 | **PASS 144** (stale) |
| DrawBackground__11tScreenMain | screenmain.cpp | 96.10 | FAIL 110 (822/822) |
| DrawMemCardStuff__14tScreenMemcards | screenmemcard.cpp | 99.99 | **PASS 343** (stale) |

7/13 briefed rows were ALREADY PASS. Real work set = 6 fns.

## LANDED — screenmain.cpp `DrawBackground__11tScreenMain` 110 -> 12 (count-EXACT 822/822 throughout)
Three commits, each whole-TU gated 2x (12/13 PASS, zero PASS->FAIL):

1. **a0928e56  110 -> 84** — BOTH dot-grid loops are UN-ROTATED in retail (07C/13D).
   Oracle tests `i` at the TOP (`sll;sra;slti 25;beqz`) and reaches the back edge as
   `j T ; addiu s2,s2,1` (increment in the jump's delay slot); the inner j-loop likewise
   tests at the top (`sll;sra;bltz`) with an IN-PLACE `addiu s0,s0,-1`.  Our
   `while (A && B)` + `for (j=4; -1<j; j--)` pair let jump.c's duplicate_loop_exit_test
   rotate BOTH, costing the fresh-dest+copy decrements AND the body's own sign-extension
   of `i` (retail reuses the top test's `$a0` via `addu s4,a0,zero`).
   MEASURED: inner-only 99 @823 · outer-only 95 @821 · **BOTH 84 @822** (the only
   count-exact combination).
   Same commit, -2 more: `j--` BEFORE `x += 0xd` (retail emits `addiu s0,s0,-1` ahead of
   `addiu s1,s1,13`).  Same commit, -14: the tvOrder `do{...}while(j<=iVar10)` is ALSO
   un-rotated in retail (guard at top, back-edge at bottom) -> `while(1){ if(0xf<j) break;
   ...; j++; if (iVar10<j) break; }`.  A block-local `byte tvIdx` measures EXACTLY the same,
   so the SYM-absent `bVar1` (06A) was inlined instead.
2. **(2nd commit) 84 -> 44** — the frame-index divide as its OWN statement ahead of the
   animLocations reads (w43 "independent-chain issue order is fixed by STATEMENT SPLIT").
   Retail materialises the %10 magic pair first, then the animLocations base, then `multu`,
   then loads fAnimLocation; our fused call-argument form interleaved the two chains and
   swapped their register roles.  Fully inlining the x/y reads into the call args measures
   EXACTLY 44 too but drops both SYM 8c locals (shapeX $v0 / shapeY $s0) -> split-temp kept.
3. **(3rd commit) 44 -> 12** — **W46 STORAGE-SCOPE LAW.**  Retail homes the packed-tint
   scratch in `$a1` INSIDE the tvConfigs[4..0xb] loop and in `$v1` AFTER it; our one
   fn-scope `uVar9` was ONE global allocno barred from both.  Block-scoping the POST-LOOP
   use turns it into a local qty and the entire a1/a2 (loop) + a2/v1 (tail) rotation
   collapses (-32 in one edit).
   🔑 DIRECTION IS THE WHOLE DIAL: splitting the IN-LOOP use instead -- alone (52),
   in-place-mutated (52), or together with the tail split (52) -- REGRESSES.  Only the
   second site is the dial.

### screenmain residual 12 = three named items (all re-gated from the 12 basin)
- **4 diffs — the SHORT `j` in the video block.** Retail passes it with `addu a2,s0,zero`
  and tests it with a bare `beqz s0`; ours emits the `sll/sra 16` promotion pair
  (`j` is SYM SHORT REG $16) at both sites.  Retail's `j` must be SHORT in the tv loops
  (it sign-extends there), so retail used a different INT carrier in the video region.
  12D dead-pseudo staging RE-PROBED FROM THIS BASIN (the W62 numbers were basin-stale):
  carrier = `shapeY` (SYM INT $s0) both sites **87 @821** · flag site only **90** ·
  carrier = `TextCol` (SYM INT $s0) **36 @820**.  All three worse -> the carrier is NOT
  either SYM INT local homed in $s0.
- **3 diffs — the `iVar10` uncoalesced copy.**  Retail `sra v1,v0,16; bltz v1,T; ...
  addu s1,v1,zero` (compute in a caller-saved reg, test it, THEN copy to the loop's
  callee-saved home); ours colours the sign-extend straight into `$s1`.  Modelled as a
  real local COPIED FROM (14C): via `uVar9` **37 @823**, via `uVar6` **13 @823** -- both
  cost the extra insn and neither is the shape.  ANGLE: the copy must OUTLIVE its source
  (make_regs_eqv) and here the source dies at the copy; needs a second consumer of the
  pre-copy value, or the qty-layer route.
- **1 diff — one `lui v0,0` retail has that we lack** (line 98 of the side-by-side).

## LANDED (spec) — psxfront.cpp `DrawGouraudShape` 14 -> 11 via ONE PER_FN_TEXT_MOVES row
NOT wired by me (build.py is orchestrator-owned).  Probe-verified **2x** via
`W60_TEXT_MOVES_FILE=scratchpad/w63a17/dgs_moves.json python tools/vprobe.py`:

```json
"recon/frontend/psx/psxfront.cpp": {
  "DrawGouraudShape__FP18tTexture_ShapeInfoiiiPii": [
    {"take": "\tsh\t\$23,10\(\$16\)\n", "after": "\tsh\t\$2,8\(\$16\)\n"}
  ]
}
```
MECHANISM: in the `flags & 4` arm retail leaves the `lhu t8,16(sp)` (width AUTO reload)
load-delay slot as a **nop** and emits `sh s7,10(s0)` AFTER `sh v0,8(s0)`; sched2 in our
build steals the y0 store into that slot.  Rows 2-4 of the same quad DO fill their slots
in retail, so it is not a source-order question -- source order already matches.  Moving
the line pre-maspsx lets maspsx insert the load-delay nop itself, reproducing retail's
window byte-exactly (verified in tools/side_by_side.py: the whole cluster becomes clean).
Both anchors are matched INSIDE the fn's `.ent/.end` region and take the FIRST match
(the arm-4 site precedes the else-arm site), so no TU-mate can be touched.
Equivalent source form measured: a void-tail fence between the x0 and y0 stores in the
arm = the same 11 @246 (fence in BOTH arms = 13 @246) -- the text move is preferred
because it adds no asm.
RESIDUAL 11 @246 vs 245: the +1 is the pre-existing `addu v1,t4,zero` forwarded-value copy
of the `prim[0x19] = prim[0xd];` read-back (retail stores `$t4` directly, `sb t4,25`).
Before this move the missing nop and that copy CANCELLED numerically at 245 -- the move
exposes the real structural delta rather than creating one.
FALSIFIED from the moved basin (all re-gated): `prim[0x19] = v` direct **37** ·
`= vb` **58 @247** · read-back moved before `prim[0x18]` **37** · after `prim[0x30]` **11** ·
after `prim[0x31]` **11** · read-back adjacent to `prim[0xd]` **37** ·
`prim[0x30] = prim[0x18]` too **14 @247** · a named `uw1` temp **38 @249**.
=> the read-back's ref-delete is load-bearing (the receipted v-root crack) and the copy it
mints is not removable by any spelling; combine_regs cannot tie it because `v` is
loop-carried and never dies at the copy.

## FontUpsideDownBlit -- residual 20 QUANTIFIED (no change; the 22->20 TEXT_MOVES row is already wired)
`tools/posdiff.py`: counts 82/82, **first-use register order 16/16 IDENTICAL to retail**,
alpha-renamed LCS 72/82 => the residual is **PURE EMISSION ORDER**, not a rotation.
Exact anatomy (tools/side_by_side.py): ours hoists the `lui/lw font_tint` pair to slots
19-20 and stores it at 28; retail materialises it at 32/35 and stores at 40, INTERLEAVED
into the 2nd OT-link RMW, with the RMW2 chain in `$v1` (freed by `sw v1,0(t1)`) while
ours reuses `$v0`.  The `li 9`/`li 44` pair follows the same split (retail v1/v0, ours
v0/v0).  Every "tint after the link" spelling is the receipted 108-134 basin, and the
fence family is receipted EXHAUSTED on this mono-block fn.  A TEXT_MOVES row cannot
express it: moving our 3-insn tint group into retail's slots would clobber `$v0`, which
the RMW2 chain also owns in our build -- it is an emission order AND a qty-assignment
coupling, so it stays the instrumented-cc1 sched/qty job the receipt already names.

## StatChk_SaveTopTime — 33 @417/416, NO movement; 3 NEW falsified angles
Re-gated baseline 33 (NOT the 34 the in-source W69 note implies).  posdiff: first-use
register order **19/19 IDENTICAL**, alpha-renamed LCS 402/416 => structural residual 14.
Anatomy (three sites, all in the record-size/copy-size chain):
- ours carries an extra dead `lhu t0,96(sp)` (fence-1's `"r"(nNumCars)` stack operand)
  where retail simply has `li t0,20`;
- ours has an extra `addu v0,t1,zero` before `sll a2,v0,3` (retail `sll a2,t1,3`);
- ours LACKS retail's `addu a2,t0,zero` (retail materialises 20 in `$t0` for the `mult`
  and COPIES it into `$a2` for the memcpy size; ours shares one register for both).
Net +1 insn = 417 vs 416, exactly as the W62-A16 receipt describes.
NEW, all re-gated from the 33 basin:
- **do{}while(0) DEPTH WRAPPER on the `uRecSz * 18` statement** (the ONE zero-insn
  ref inflator the W62-A16 fence-operand table never covers): identity-fence + depth-1
  **114 @416** · depth-2 **156 @416** · no fence + depth **115 @413** · fence kept +
  depth **41 @417**.  => the wrapper behaves EXACTLY like every other zero-insn operand
  in that table (retail's COUNT, wrong registers) — the 12E law reproduced with a
  non-fence instrument, which closes the "maybe a non-fence zero-insn dial exists" gap.
- **give the memcpy SIZE arg its own variable copied from `uCopySz`** (14C uncoalesced-temp,
  aimed at retail's missing `addu a2,t0,zero`): replacing fence-3 **34 @418** · keeping
  fence-3 **33 @417** (exactly neutral).  The copy is folded away; its source dies at it.
- **fence-2 operand reduction**: `"r"(uBulkUnit),"r"(uBulkSz)` -> `"r"(uBulkUnit)` alone is
  **exactly 33 @417** (the `uBulkSz` operand is INERT — a free scaffolding reduction,
  reported not landed to avoid a gratuitous basin move); `"r"(uBulkSz)` alone **56 @416**.

## Front_InitOpponentCars — 111 @358/357; the certificate's CHARACTERISATION IS INCOMPLETE
Re-gated 111.  The W61-A17 receipt calls the residual "a uniform s0<->s1 swap plus its
knock-ons".  posdiff says otherwise and this is the NEW finding:
- counts **ours 358 / oracle 357**;
- ours uses **16** distinct registers, the oracle **18** (retail also has `$t1`,`$t2` live);
- alpha-renamed LCS **309/357 => structural residual 48**, i.e. ~half the diffs survive
  a whole-function register renaming and are NOT a rotation at all.
Concrete structural sites read off tools/side_by_side.py:
- ours `addiu a0,v0,0 ; lbu v1,4(a0)` vs retail `lbu v1,0(v0)` (the receipt's named
  angle (1): retail fuses `%lo(frontEnd+4)` where we materialise `&frontEnd` first);
- retail mutates the carLineup base IN PLACE (`addiu s0,s0,376`) with the counter zeroed
  into `$s1`; ours computes a fresh `addiu s1,s0,376` and zeroes `$s0` (12D in-place
  mutation, a variable-identity question, not a handout question);
- retail `lbu t1,204(s2) ; addiu a2,sp,260 ; sw zero,440(s2)` where ours reloads
  `lw v1,256(sp) ; lbu a2,260(sp)` — a genuine memory-vs-register shape difference.
=> the priced "carInfo needs +7 refs" certificate is sound for the s0/s1 pair, but it is
NOT the whole residual; the fn needs the SLD-first rewrite its own W57-A4 note already
asks for.  No new spelling was landed (the belt's budget went to screenmain).

## GetPSXPadValue — certificate CONFIRMED unchanged
Re-gated 18 @222/222.  posdiff: first-use order **7/7 identical**, alpha-renamed LCS
216/222 => structural residual 6 (three 2-word merged tails).  This exactly matches the
W62-A15 `-dg` certificate (p82 = newControl, preferences {a0,a1,a2}, find_reg takes the
lowest free preference => `$a0` unconditionally; retail's three tails are block-local
qtys tied by qty_combine to op0, and one global allocno cannot be `$a2` at one tail and
`$a1` at two).  Nothing new attempted — the certificate is a hardness receipt, not a floor.

## PRODUCTION LANE (psyqproof) note for screenmain
`DrawBackground__11tScreenMain`: REAL=616 / RELOP=88 of 822 words — but this is a
POSITIONAL-SHIFT artifact: the streams desynchronise by ONE word at word ~99 (ours[100]
== retail[101] and onward), inside the `IsShapeFileLoaded`/`UploadShapes` head loop that
NONE of this belt's edits touch.  TU-mates `DrawDropShadow` (69 words) and
`DoneLoadingBackground` (31 words) both prove **REAL=0**, so the lane/harness is healthy
for this TU and the divergence is PRE-EXISTING, not introduced here.  It belongs to the
14A shim-masked/whole-schedule class and needs its own production pass.

## HAZARDS ENCOUNTERED
- **Edit-tool CRLF normalisation (12K, fired again)**: `recon/frontend/psx/psxfront.cpp`
  was MIXED (1643 CRLF + 53 bare LF) and is now uniformly CRLF after two Edit-tool
  round-trips.  `git diff` is EMPTY (autocrlf normalises), tracked content is
  byte-identical, and `tugate` re-confirms 23/25 PASS with both FAILs at their baseline
  values (14 / 20) — but any LF-anchored probe harness against that file must now derive
  its endings per anchor.  NOT reverted (a checkout of a phantom change is the documented
  worse move).
- JSON probe anchors containing non-ASCII (an emoji inside a MATCH comment) fail to
  match — keep probe anchors ASCII-only.
- `tools/alpha.py` is UNRUNNABLE as committed: it imports a `probe` module that only ever
  existed in the w49 agent scratchpads (`scratch/w49_*/probe.py`).  `tools/posdiff.py`
  gives the same alpha-rename verdict and was used instead.  (Tool-repair candidate.)
