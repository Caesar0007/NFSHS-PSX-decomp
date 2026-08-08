/* game/psx/trackspec.cpp -- RECONSTRUCTED (NFS4 PSX track-spec load; C++ TU)
 *   5 fns: TrackSpec_SetDefault (fill a CTrackSpec with defaults), SetUp (push night/weather
 *   to GameSetup), static read (byte-copy from a buffer cursor), Read (load TrXX.bin + parse),
 *   Load (weather/night -> spec index -> Read).
 */
#include "../../nfs4_types.h"
#include "trackspec_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
int TrackSpec_gCurrentSpec;
int TrackSpec_gMaxSpec;
int TrackSpec_gPrevSpec;


/* ---- TrackSpec_SetDefault__FP10CTrackSpec  [TRACKSPEC.CPP:44-113] SLD-VERIFIED ----
 * 228 -> 195 -> 193 (w39/w40) -> 24 (w41-a5), COUNT NOW EXACT 142/142.
 * THE w40 "STRONG FLOOR" RECEIPT BELOW IS REFUTED.  It diagnosed the ~90-line
 * base-register divergence (spec in $a0 for us, $a1 for retail) as an unreachable
 * `regs_someone_prefers` allocator identity.  It was not: the recon carried TWO
 * fabricated pseudos the SYM does not name, and removing them moved the allocation.
 * THREE levers, all SYM/oracle-driven:
 *  (1) ONE REUSED `short sVar2` FOR TWO INDEPENDENT VALUES -> TWO NAMED LOCALS
 *      (`weather`, `night`).  The SYM lists NO short local at all, so the single
 *      reused temp was pure Ghidra; reusing it merged two disjoint live ranges into
 *      one long-lived pseudo, and THAT is what pushed `spec` off $a1.  Splitting it
 *      took 185 -> 44 and made the count exact -- the entire $a0/$a1 cascade fell
 *      out with it (catalog "pCVar2 rule": N re-reads = N distinct C locals).
 *      NB inlining both reads with no local at all is WORSE (204): retail does hold
 *      each value in a temp, it just holds them in two different ones.
 *  (2) RING LOOP: ONE store fed by a ternary, not a store per arm --
 *      `ringPMX[i] = (char)((i < 8) ? i : (0x17 - i));`.  Two stores gave the giv
 *      TWO uses, so loop.c strength-reduced `spec + i` into a walking pointer (an
 *      extra allocno) and left no delay slot.  With one store loop.c leaves the
 *      address as the per-iteration `addu $v1,$a1,$a2`, reorg duplicates the store
 *      into the `j` delay slot, and the back-edge slot takes the NEXT iteration's
 *      `slti $v0,$a2,8` -- the 5th slti the w41 census flagged as missing.
 *      193 -> 185; that loop is now byte-identical.  (i<8-first ternary 185,
 *      8<=i-first ternary 191, if/else+temp 196, shared element pointer 196.)
 *  (3) the three `fogspec.color` byte stores belong immediately BEFORE
 *      `fogspec.start = 200` (44 -> 24): that puts `li $v0,128` ahead of the
 *      200/8/2/1/-4224 chain so the chain reuses $v1 like retail.  Measured at four
 *      positions: before start 24, before dist2base 28, intensity 32, mirror 36.
 * RESIDUAL 24 (count exact), TWO items, both scheduler PLACEMENT of CSE'd constants:
 *   (a) `li $a3,23` vs `li $v1,1` issue order at the head (2 diffs);
 *   (b) the tail's shared literals 8 (3 sites) and 16 (4 sites): retail hoists them
 *       early into $a0/$v1, we materialize them late in $v0 (22 diffs).  Source
 *       ORDER does NOT reach it -- moving all seven stores as a block to four
 *       different positions around the sky loop measured 24 every time.
 *   w42-a5 RAN THE -dS SCHED TRACE (tools/rtl_dump.py trackspec.cpp -dS ->
 *   scratch/rtl/trackspec.i.sched).  RECEIPT: in the tail block ("basic block
 *   number 9 from 652 to 610") EVERY insn has `priority = 1` -- the whole block is
 *   independent `li`/`sb`/`sw` pairs off one base, so gcc-2.8's BACKWARD list
 *   scheduler has nothing but the LUID tie-break and therefore reproduces SOURCE
 *   ORDER exactly.  ⇒ retail's `li $a0,8` + `li $v1,16` standing ~30 insns before
 *   their first use at the TOP of that block cannot be produced by ANY store
 *   ordering: those two `li`s had a LOW LUID, i.e. they were already at the block
 *   head in retail's RTL, which no straight-line C statement sequence emits (a
 *   statement emits its `li` adjacent to its store).  This is the same phenomenon
 *   as CreateLicense's hoisted `li $a2,48` in cario.cpp -- a cross-function
 *   "constant materialized at block head" identity, NOT a per-function reshape.
 *   Positive by-product (gate-neutral, not adopted): putting `clearcolor.r = '\b'`
 *   BEFORE `clearcolor.g = '\x10'` does reproduce retail's SHAPE -- the 8-constant
 *   then lives in its own register ($v1) across the whole 16-store group instead of
 *   being re-materialized into $v0 afterwards -- but measures 24 as well, because
 *   the register letters still differ ($v1/$v0 vs retail $a0/$v1).
 * w44-a9 (24 stays, NEW falsification + NEW angle): the obvious answer to "retail's two
 * `li`s had a LOW LUID" is to make them REAL STATEMENTS -- two named locals `int c8 = 8;`
 * / `int c16 = 16;` assigned at the head of the tail block and used at all seven store
 * sites.  MEASURED: 24, byte-for-byte the SAME diff -- cse const-propagates the locals back
 * into every `sb` and DELETES the two `li` insns, so the pseudo never exists.  (Same
 * outcome the RaceStatistics `int pitch = 0x96;` probe had for a different reason.)
 * ⇒ any block-head-constant lever needs the pseudo to survive cse, i.e. a value cse cannot
 * prove constant.  NEW ANGLE (untried, in priority order): (1) source the two values from
 * an EARLIER STORED FIELD re-read that cse cannot forward across the two loops (e.g. read
 * back `(spec->fogspec).dist2base` for the 8) -- the loops break cse's extended basic
 * block, so the load is opaque at the tail; (2) failing that, this is a10's per-object
 * identity axis and the CreateLicense call-arg data point below is its twin.
 * 🏆 w44-a10: 24 -> 6, COUNT STILL EXACT 142/142.  THE w42-a5 "-dS PROVES NO
 * STATEMENT ORDER REACHES IT" RECEIPT (kept verbatim below) IS **REFUTED**.  Two
 * one-line statement moves did it:
 *   (1) `clearcolor.r = '\b';` + `clearcolor.g = '\x10';` moved to the TOP of the
 *       tail block (immediately before `sunAngleInSky = -0x1848;`), in that order
 *       -> 24 -> 8.  This is what puts retail's `li $a0,8` + `li $v1,16` AT THE
 *       BLOCK HEAD and gives the two constants retail's own registers.
 *   (2) `depthcuespec.color.r = 0x80;` moved before `depthcuespec.distance = 0x44;`
 *       -> 8 -> 6.
 * MECHANISM (the w42 receipt read the WRONG scheduler pass):
 *   - `-dS` = **sched1**, which runs BEFORE reload.  There, every constant `li` is a
 *     register BIRTH and gcc-2.8 sched.c hands it LAUNCH_PRIORITY (the dump prints
 *     `7f000001`, visible in the T-N ready-list trace) so it is scheduled the instant
 *     it becomes ready = pinned directly above its earliest use.  That is why sched1
 *     reproduces source order, and it is what the w42 receipt actually measured.
 *   - `-dR` = **sched2**, post-reload.  There LAUNCH_PRIORITY is NOT applied (every
 *     insn prints priority 1) and constants DO float: in OUR OWN build insn 590
 *     (`li $v0,19660`) enters the ready list at T-6 and is not placed until T-16 --
 *     it floats 10 slots above its use.  So "a `li` 30 insns above its use is
 *     unreachable" was false on its face.
 *   - What actually pinned our 8/16 constants was REGISTER ASSIGNMENT, not order:
 *     both landed in $v0, the same register the whole tail-block constant chain
 *     uses, so output/anti-dependences serialize the block and sched2's ready list
 *     never holds more than one insn.  Retail's 8/16 live in $a0/$v1, outside that
 *     chain, so they are ready early and float to the block head.  Moving ONE use of
 *     each constant to the block head lengthens its live range across the $v0 chain,
 *     local_alloc is forced onto $a0/$v1, and sched2's float then happens for free.
 *   ⇒ GENERAL LEVER (catalog): when a shared constant's `li` sits adjacent to its
 *     first use but retail hoists it, SPREAD that constant's USES across the block
 *     (move one use to the block head) -- it is a register-allocation dial dressed
 *     up as a scheduling diff.  Moving the whole group as a block (what w40/w42
 *     tried) cannot work: it keeps the live range short.
 * RESIDUAL 6 (count exact), TWO scheduler ready-list tie-breaks, both now understood
 * and both measured inert to statement order (27 head-order + 22 tail-order variants,
 * scratch/a10/run_ts{1..5}.py):
 *   (a) `li $a3,23` vs `li $v1,1` issue order at the head (4 diffs).  $a3 = loop.c's
 *       LICM hoist of the ring loop's `0x17`; it has NO consumer inside block 0, so
 *       it is ready at T-1 and floats until the ready list DRAINS.  sched2 trace:
 *       insn 654 sits in the ready list from T-26 to T-44 and is only picked when
 *       just insns 17 and 5 remain -> position 3; retail's drained one step later ->
 *       position 8.  `rank_for_schedule` sorts newly-RELEASED insns ahead of
 *       long-waiting ones (39/33/27/25/24 all beat uid-654), so the stopping point
 *       is a function of block 0's dependence shape, not of statement order.
 *   (b) one `sb $v1,240` placement (2 diffs), same class.
 * 🏆 w45-a9: 6 -> 4, count still exact 142/142.  Residual (a) -- the `li $a3,23` drain --
 * IS SOURCE-REACHABLE after all, but not through statement order: a ZERO-INSN SCHEDULING
 * FENCE (`__asm__ volatile("" : : "r"(i));`, §2b.5) placed after the `weather` read splits
 * block 0 into two sched2 regions so the LICM hoist can no longer drain past it.  See the
 * fence's own comment for the position sweep.  RESIDUAL 4, TWO items:
 *   (a') `li $v1,1` issues at ours[7] vs retail[4] -- it must float ABOVE the fence, i.e.
 *        into region 1, but its statements (horizonstate/skystate) are after the weather
 *        read and the store order to `spec` is fixed.  MEASURED NEGATIVE: fence moved to
 *        every other head position (8/6/6/6/6); a fence-protected `int one = 1;` pseudo
 *        used at both stores (188 -- the extra allocno re-colors the whole body).
 *        NEW NAMED ANGLE: the 1 is ALSO stored to depthcuestate and horizonspec.mirror
 *        later in the block; SPREAD ITS USES (the w44-a10 lever that cracked the 8/16
 *        pair) by moving ONE of those later `= 1` stores UP to just before the fence --
 *        that gives the constant a use in region 1 without adding an allocno, which is
 *        exactly what the `one` local failed to do.
 *   (b) the `sb $v1,240` placement (2 diffs) is unchanged and still the same drain class;
 *        try a SECOND fence inside the depthcue block once (a') lands (lever-order
 *        dependence -- the fence position sweep above already shows this fn is basin-
 *        sensitive).
 *   NEW ANGLE for whoever takes it next: both are ready-list DRAIN points -- the dial
 *   is the number/shape of insns released late in block 0 / the depthcue block, i.e.
 *   add or remove ONE RTL insn there (the giv-worth razor's +1-insn family), or
 *   permuter.  Statement order is exhausted.
 * ---- w46-a8: 4 STAYS.  The w45 "SPREAD THE 1's USES" angle for residual (a') is
 * FALSIFIED, and so is the (b) second-fence angle.  Everything measured at this base:
 *   SPREAD-THE-1 (give the constant a use in sched2 region 1, i.e. before the fence):
 *     `"r"(1)` as a 2nd operand of the existing fence 7 @143 (+1 insn -- cse does NOT fold
 *     the asm's constant onto the later stores, so it is a real extra `li`), a separate
 *     `"r"(1)` fence before 7 @143 / after 7 @143, moving `depthcuestate = 1;` above the
 *     fence 18 @142, moving `horizonspec.mirror = 1;` above it 7 @141, moving
 *     `horizonstate = 1;` above it 6 @142, a fenced `int one = 1;` local 187.
 *     Moving mirror/depthcuestate above `fogstate = 0` instead: 7 @141 / 8 @142 / 7 @141.
 *     ⇒ ANY spelling that puts a use of the 1 in region 1 also drags its STORE there,
 *     which is worse than the missing `li` position -- and the asm-operand form that would
 *     avoid the store costs the insn instead.  The lever cannot be paid for.
 *   SECOND FENCE for residual (b) (`sb $v1,240`): four positions inside the depthcue block
 *     (before depthcuespec.color.r / .distance / clearcolor.b / color.g) measure 40/38/38/40
 *     -- a second region boundary there wrecks the whole tail block, it does not refine it.
 *   FENCE POSITION re-sweep (2 positions the w45 list lacked): before `fogstate = 0` 6,
 *     before the `weather` read 8; a SECOND fence at the top of the fn KEPT alongside the
 *     existing one is 4 (neutral -- a different 4? worth a side_by_side if resumed).
 *   NEW NAMED ANGLE: (a') needs the `li $v1,1` in region 1 WITHOUT a store there.  The only
 *   zero-insn way left is to make region 1 itself longer, i.e. move the FENCE later while
 *   keeping `li $a3,23` pinned -- which the position sweep says is impossible with ONE
 *   fence.  So: TWO fences bracketing the `li a3,23` drain point (one before the weather
 *   read, one after the horizonstate/skystate stores), so the 1 is released inside the
 *   middle region while 0x17 still cannot drain past the first.  Untried.
 * ---- w49-a6: 4 STAYS.  The w46 "TWO FENCES bracketing the `li a3,23` drain point"
 * angle is FALSIFIED in all three spellings: fence before the weather read + the existing
 * one + one after skystate (three regions) 8; the bracketing PAIR alone (existing fence
 * REMOVED, one before the weather read, one after skystate) 8; the existing fence + one
 * after skystate 6.  Every added region boundary moves `li $v1,1` the WRONG way.  Residual
 * is unchanged and is exactly two position moves (`li v1,1`, `sb v1,240(a1)`), both the
 * ready-list DRAIN class; the remaining dial is +-1 RTL insn released late in block 0
 * (giv-worth razor family) or the permuter -- fences are now exhausted on this fn.
 * FLOOR-BAR NOTE: prototype re-audited (1 pointer arg, void return, SYM REGPARM $05,
 * fsize 0 / mask $00000000 leaf, no $v0 at the single `jr $ra`); the w40 per-TU flag
 * probes still stand (g_value 8 no-op, all four -f keys negative).
 * ---- OLD (REFUTED) RECEIPT, kept so the mistake stays traceable ----
 * FAR-MISS 193 diffs (was 228), COUNT-EXACT 141/142.  w39-a5 applied the SYM rule-8
 * rewrite (only i/j survive; both loops in index form) and the arm-order flip
 * (`8 <= i` first = the oracle's fall-through arm), 228 -> 195 -> 193.
 * THE WHOLE RESIDUAL IS ONE ALLOCATION DECISION: `spec` sits in $a0 for us and in
 * $a1 for retail (SYM: spec = REGPARM $05), so every one of the ~90 field stores
 * differs only in its base register.  -dg/-dl on THIS body (w39-a5):
 *   83  j            prio 3.23 -> $v1
 *   191 ring walker  prio 3.04 -> $a1   <-- retail has NO such pseudo
 *   80  spec 76 refs prio 1.64 -> $a0   (copy-preference for the incoming $a0)
 *   195 sky walker   prio 0.50 -> $a1 (reuse)
 * Retail instead has sky-walker=$a0 and spec=$a1, i.e. something took $a0 BEFORE
 * spec despite spec's lower-numbered copy preference.
 * MECHANISM (named, w40-a5): gcc-2.8 global.c find_reg SKIPS any hard register that
 * a CONFLICTING allocno PREFERS (`regs_someone_prefers`).  `spec` is the destination
 * of the parm copy `pseudo80 = $a0`, so it PREFERS $a0; every allocno that conflicts
 * with it -- and spec is live across the whole body, so that is all of them -- avoids
 * $a0 and lands on $a1/$v1/... instead, leaving $a0 for spec itself.  Retail's build
 * gave $a0 to the sky walker anyway and paid the `addu $a1,$a0,$zero` copy (its extra
 * 1 insn: ours 141 vs oracle 142).  There is no C-level handle on that avoidance --
 * the preference exists for ANY spelling of a pointer parameter.  Also note retail's
 * ring loop has NO walker at all (`addu $v1,$a1,$a2` rematerialized per iteration),
 * which is what frees the register we spend on pseudo 191.
 * FLOOR RECEIPT (upgraded w40-a5 to the w38+ bar):
 *   prototype   -- 1 pointer arg, void return; SYM REGPARM $05 + `retreg 31`,
 *                  fsize 0 / mask $00000000 (leaf, no frame, no AUTO locals),
 *                  and the raw oracle sets no $v0 at its single `jr $ra`.
 *   trichotomy  -- the retail `addu a1,a0,zero` is NOT a loop.c giv anchor (it is
 *                  the parm copy, outside every loop) and NOT a cse double-eval
 *                  (there is exactly one evaluation of the parameter); it is class
 *                  (3) true coalescing identity.
 *   probes      -- goto-loop on the ring loop 218 WORSE; arm order `i<8` first 195,
 *                  `8<=i` first 193 (kept); a `CTrackSpec *s = spec;` local used for
 *                  the whole body 193 (gcc coalesces the copy away); the same with
 *                  `spec` kept for the first store 193.
 *   flags       -- whole-TU, w40-a5: g_value 8 = NO-OP (this TU owns only 4-byte
 *                  scalars and the oracle already reaches all three with %gp_rel;
 *                  there is no 5..8-byte owned object, so the -G8 discriminator is
 *                  silent AND the measurement is identical); no_strength_reduce 222,
 *                  no_split_addresses 222, no_schedule_insns 217 (+ breaks SetUp and
 *                  Read), no_schedule_insns2 193 (+ breaks Load) -- all NEGATIVE. */
void TrackSpec_SetDefault(CTrackSpec *spec)

{
  /* SYM @0x800e1544: fsize 0, mask $00000000 (LEAF, no frame).  spec =
   * REGPARM $05 ($a1) -- retail copies the incoming $a0 out and keeps $a1 as
   * the record base for the whole body.  The ONLY named locals are
   * i REG $06 ($a2) and j REG $03 ($v1); the retail sky-loop walker ($a0) and
   * the i*4 term ($a3) are compiler GIVs, so both loops are written in INDEX
   * form and the invented Ghidra temps (bVar1/pCVar5/iVar3/iVar7/local_a0__1)
   * are deleted (catalog: SYM has only i/j => the pointers are givs). */
  short weather;
  short night;
  int i;
  int j;

  i = 0;
  spec->fogstate = 0;
  weather = (short)GameSetup_gData.Weather;
  /* MATCH (w45-a9, 6 -> 4): ZERO-INSN SCHEDULING FENCE (§2b.5) at the ready-list DRAIN
   * point.  `li $a3,23` is loop.c's LICM hoist of the ring loop's 0x17; it has no
   * consumer in block 0, so sched2 held it in the ready list until the list drained and
   * issued it at position 2 (retail: 7).  w44-a10 proved statement order cannot reach it
   * (27 head-order variants, all 6).  An empty asm splits the block into two scheduling
   * regions, so the hoist can no longer drain past this point and lands exactly where
   * retail has it.  POSITION IS THE DIAL, operands are irrelevant -- measured here:
   * after fogstate 8, after weather 4 (kept), after horizonstate 6, after weatherstate 6,
   * after night 6, after skystate 6; operand variants at the winning position
   * (i / weather / spec / i+weather / i+spec) all 4. */
  __asm__ volatile("" : : "r"(i));
  spec->horizonstate = 1;
  spec->skystate = 1;
  spec->weatherstate = weather;
  night = (short)GameSetup_gData.Time;
  (spec->fogspec).contrast = 0x10000;
  spec->depthcuestate = 1;
  (spec->fogspec).color.r = 0x80;
  (spec->fogspec).color.g = 0x80;
  (spec->fogspec).color.b = 0x80;
  (spec->fogspec).start = 200;
  (spec->fogspec).dist2base = 8;
  (spec->weatherspec).intensity_limit = 2;
  (spec->horizonspec).mirror = 1;
  (spec->horizonspec).yoffset = -0x1080;
  (spec->weatherspec).type = 0;
  (spec->horizonspec).angle = 0;
  (spec->horizonspec).height = 0x4b00;
  (spec->horizonspec).frontColor[0].r = 0x80;
  (spec->horizonspec).frontColor[0].g = 0x80;
  (spec->horizonspec).frontColor[0].b = 0x80;
  (spec->horizonspec).frontColor[1].r = 0x80;
  (spec->horizonspec).frontColor[1].g = 0x80;
  (spec->horizonspec).frontColor[1].b = 0x80;
  (spec->horizonspec).backColor[0].r = 0x80;
  (spec->horizonspec).backColor[0].g = 0x80;
  (spec->horizonspec).backColor[0].b = 0x80;
  (spec->horizonspec).backColor[1].r = 0x80;
  (spec->horizonspec).backColor[1].g = 0x80;
  (spec->horizonspec).backColor[1].b = 0x80;
  spec->nightstate = night;
  for (; i < 0x10; i = i + 1) {
    (spec->horizonspec).ringPMX[i] = (char)((i < 8) ? i : (0x17 - i));
  }
  i = 0;
  (spec->skyspec).type = 0;
  (spec->skyspec).flags = 4;
  for (; i < 5; i = i + 1) {
    (spec->skyspec).frontcolors[i].r = '2';
    (spec->skyspec).frontcolors[i].g = '2';
    (spec->skyspec).frontcolors[i].b = 'F';
    (spec->skyspec).backcolors[i].r = '2';
    (spec->skyspec).backcolors[i].g = '2';
    (spec->skyspec).backcolors[i].b = 'F';
    for (j = 0; j < 4; j = j + 1) {
      (spec->skyspec).cloudIndices[i][j] = '\0';
    }
    (spec->skyspec).ringAngles[i] = i << 0xc;
  }
  (spec->skyspec).clearcolor.r = '\b';
  (spec->skyspec).clearcolor.g = '\x10';
  (spec->skyspec).sunAngleInSky = -0x1848;
  (spec->skyspec).sunHeightInSky = 0xee;
  (spec->skyspec).moonHeightInSky = 0xee;
  (spec->skyspec).numStars = 0x3c;
  (spec->skyspec).starAngleLow = 4000;
  (spec->skyspec).starAngleHigh = 10000;
  (spec->skyspec).starBrightMin = 0x40;
  (spec->skyspec).starBrightMax = 200;
  (spec->skyspec).starBaseColor.r = 0xff;
  (spec->skyspec).starBaseColor.g = 0xff;
  (spec->skyspec).starBaseColor.b = 0xff;
  (spec->skyspec).starRandomSeed = 0x3039;
  (spec->skyspec).sunBeamColor.r = '!';
  (spec->skyspec).sunBeamColor.g = '!';
  (spec->skyspec).sunHaloColor.r = '\x19';
  (spec->skyspec).sunBeamColor.b = '\x10';
  (spec->nightspec).nightcolor.g = '\x10';
  (spec->nightspec).nightcolor.b = '\x10';
  (spec->skyspec).sunHaloColor.g = '\n';
  (spec->depthcuespec).color.r = 0x80;
  (spec->depthcuespec).distance = 0x44;
  (spec->skyspec).clearcolor.b = '\b';
  (spec->skyspec).moonAngleInSky = 0;
  (spec->skyspec).sunHaloColor.b = '\0';
  (spec->skyspec).yoffset = 0;
  (spec->nightspec).nightcolor.r = '\b';
  (spec->depthcuespec).color.g = 0x80;
  (spec->depthcuespec).color.b = 0x80;
  (spec->worldcolorspec).worldR = 0;
  (spec->worldcolorspec).worldG = 0;
  (spec->worldcolorspec).worldB = 0;
  (spec->worldcolorspec).type = 0;
  (spec->worldcolorspec).contrast = 0x4ccc;
  (spec->worldcolorspec).contrast_color.r = 0x80;
  (spec->worldcolorspec).contrast_color.g = 0x80;
  (spec->worldcolorspec).contrast_color.b = 0x80;
  return;
}

/* ---- TrackSpec_SetUp__Fv  [TRACKSPEC.CPP:119-121] SLD-VERIFIED ---- */
void TrackSpec_SetUp(void)

{
  GameSetup_gData.Time = (int)TrackSpec_gSpec.nightstate;
  GameSetup_gData.Weather = (int)TrackSpec_gSpec.weatherstate;
  return;
}

/* ---- read__FPPcPvi  [TRACKSPEC.CPP:127-139] SLD-VERIFIED ---- */
void read(char **handle,void *buf,int bytes)

{
  char *source;
  int new_var;
  int i;
  char c;

  source = *handle;
  i = 0;
  new_var = 0;
  if (new_var < bytes) {
    do {
      c = *source;
      source = source + 1;
      i = i + 1;
      *(char *)buf = c;
      buf = (char *)buf + 1;
    } while (i < bytes);
  }
  *handle = source;
  return;
}

/* ---- TrackSpec_Read__Fi  [TRACKSPEC.CPP:145-200] SLD-VERIFIED ----
 * NEAR-MISS 26 diffs (ours 59 / oracle 63), was 32.
 * MATCH (w38-a10): ARM ORDER -- the oracle's `slt v0,s2,v1; bnez v0,.L800E186C`
 * makes the SetDefault arm the FALL-THROUGH and the parse arm the branch target,
 * i.e. the source tests `spec_num >= header.num_spec` with SetDefault as the
 * if-BODY (catalog sec.B arm-order/polarity row).
 * 26 -> 4 (w40-a5, count now EXACT 63/63).  The w39 "no-copy-prop FLOOR" call was
 * WRONG in its remedy, not its mechanism.  The SYM is the key: `startpos` is REG
 * $13 = $s3, NOT $s0 -- so retail holds the loadfileadr result in THREE places
 * (the return pseudo $v0, an uncoalesced temp $s0 that carries the null test and
 * the SetDefault arm's purge, and `startpos` $s3 for the parse arm's purge), and
 * mask $800f0000 (ra+s0..s3) pays for all of them.  THREE cooperating changes:
 *  (1) model the uncoalesced temp as a real local (`filebuf`) that `startpos` is
 *      copied FROM -- the copy survives because `startpos` OUTLIVES it (its use is
 *      in the later arm; catalog "make_regs_eqv is steerable: the copy becomes
 *      canonical iff it outlives its source").  The earlier probe copied in the
 *      OPPOSITE direction, which is why it was copy-propagated away.
 *  (2) purgememadr(...) written INSIDE each arm (filebuf in the SetDefault arm,
 *      startpos in the parse arm) -- gcc cross-jumps the two `jal`s into one but
 *      keeps each arm's own `addu a0,<reg>,zero`, which is exactly the oracle's
 *      800E181C / 800E18A4 pair.  Duplicating the call with ONE variable does not
 *      work (both arms then use the same register and the merge swallows it).
 *  (3) `currentpos = filebuf;` hoisted ABOVE the null test so the store lands in
 *      the `beqz` delay slot like the oracle.
 * RESIDUAL 4 (2 real insns): the delay-slot store is `sw s0,88(sp)` for us vs
 * `sw v0,88(sp)` for retail (a THIRD uncoalesced copy we cannot name without a
 * fourth variable), and the sprintf `lui a1,%hi(fmt)` is scheduled one insn
 * earlier.  Prototype re-checked vs the raw oracle: 1 int arg ($a0->$s2), void
 * return (no $v0 set at the single epilogue).  Per-TU flag probes (w40-a5, whole
 * TU): g_value 8 = NO-OP (this TU owns only 4-byte scalars, all already %gp_rel),
 * no_strength_reduce / no_split_addresses / no_schedule_insns / no_schedule_insns2
 * all neutral-or-worse -- see the SetDefault note. */
void TrackSpec_Read(int spec_num)

{
  char *filebuf;
  char *startpos;
  char str [64];
  CTrackSpecHeader header;
  char *currentpos;
  /* w41-a5: the track fetch is its OWN source statement, not an inline sprintf arg.
   * SLD PROOF: 800E17E8 (`lui $v0,%hi(GameSetup_gData)`) carries source line 148 while
   * every other insn of the call setup (800E17DC/17EC/1804) carries line 151 -- the
   * sprintf line.  Inline, cc1 gives the a1 `lui %hi(fmt)` the earlier luid and sched1
   * issues it one slot too soon (the last 2 diffs).  Hoisted, the ready-list tie flips
   * and the lui lands in the oracle's slot.  CAVEAT: the SYM's block list for this fn
   * names only currentpos/startpos/str -- no `trk` -- so the name is ours; the STATEMENT
   * is SLD-attested. */
  int trk = GameSetup_gData.track;

  sprintf(str,"%sTr%02d.bin",Paths_Paths[6],trk);
  /* w41-a5: `currentpos` (an AUTO -- its address goes to read()) takes the RAW
   * call result; `filebuf` is then READ BACK from it.  cse forwards the just-stored
   * register, so the read-back becomes retail's `addu s0,v0,zero` copy while the
   * delay-slot store keeps the raw `$v0` (`sw v0,0x58(sp)`) -- the third
   * uncoalesced copy the w40 note could not name.  Assigning currentpos FROM
   * filebuf instead stores the copy (`sw s0,...`). */
  currentpos = (char *)loadfileadr(str,0);
  filebuf = currentpos;
  startpos = filebuf;
  if (filebuf != (char *)0x0) {
    TrackSpec_gPrevSpec = spec_num;
    TrackSpec_gCurrentSpec = spec_num;
    read(&currentpos,&header,8);
    if (spec_num >= header.num_spec) {
      TrackSpec_SetDefault(&TrackSpec_gSpec);
      purgememadr(filebuf);
    }
    else {
      TrackSpec_gMaxSpec = header.num_spec + 1;
      currentpos = currentpos + spec_num * 0x108;
      read(&currentpos,&TrackSpec_gSpec,0x108);
      TrackSpec_SetUp();
      purgememadr(startpos);
    }
  }
  return;
}

/* ---- TrackSpec_Load__Fii  [TRACKSPEC.CPP:205-207] SLD-VERIFIED ---- */
void TrackSpec_Load(int weather,int night)

{
  int spec [2] [2] = { { 0, 1 }, { 2, 3 } };   /* @0x80056ad4 rodata template -> stack copy */
  
  TrackSpec_Read(spec[weather][night]);
  return;
}

/* end of trackspec.cpp */
