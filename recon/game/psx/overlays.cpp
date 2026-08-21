/* game/psx/overlays.cpp -- RECONSTRUCTED (NFS4 PSX race-summary / stats HUD; C++ TU)
 *   5 fns: OptionsBarThing, Hud_RenderStatsView, RaceSummary, RaceStatistics, Hud_BTCStats
 *   -- all reconstructed with full SYM-locals applied (0 missing, audited). No GTE.
 */
#include "../../nfs4_types.h"
#include "overlays_externs.h"

/* gp-rel owning-TU defs (section 3.12 #6): overlays.obj OWNS these (the SYM's overlays.obj
   band defines Hud_NextPerp @0x8013d994 and StatsTimer @0x8013d998), and the oracles reach
   them via %gp_rel -- which only happens for a <=G4 object defined (not just declared) in
   this TU.  StatsTimer's two words are separate 4-byte symbols for exactly that reason.
   CAUTION (documented dual-model tradeoff, catalog section E): hud_externs.h still declares
   SYM-CARRIER: StatsTimer
   StatsTimer as `int StatsTimer[2]`.  The two 4-byte .comm symbols land adjacently in .sbss
   in declaration order, so that array view still reaches both words -- but if StatsTimer or
   D_8013D99C ever gains an initializer or another owner, re-check that adjacency. */
short Hud_NextPerp[2];
int StatsTimer;
/* w44-a9 probe: sized asm-label view of StatsTimer[0] -- an ARRAY_REF store sets
   MEM_IN_STRUCT_P, which (unlike the fixed-scalar store) may-aliases the varying
   `car->carFlags` load and should keep it BELOW the store the way retail schedules it. */
extern int StatsTimer_v1[1] asm("StatsTimer");
extern int D_8013D99C_v1[1] asm("D_8013D99C");
int D_8013D99C;


/* ---- OptionsBarThing__Fiiii  [OVERLAYS.CPP:39-47] SLD-VERIFIED ---- */
void OptionsBarThing(int x,int y,int w,int h)

{
  char *str;
  int width;

  Hud_GoTpage(1);
  str = TextSys_Word(0x40);
  width = Hud_BuildString(TextSys_Word(0x40),0,0,0,0,1);
  Hud_BuildString(str,0xa0 - (width >> 1),y + h + -6,0xbebe,0,0);
  Hud_FBuildF4(0,x,y + h + -8,w,8,0,'\0','\0');
  Hud_GoTpage(0);
  return;
}

/* ---- RaceSummary__Fv  [OVERLAYS.CPP:53-158] SLD-VERIFIED ---- */
/* w41-a4: 287 -> 65 diffs (348 ours / 349 oracle), frame layout byte-identical to the SYM.
 * FOUR levers, in the order they landed (each is a separate commit with its receipt):
 *  1. DECL POSITION IS THE FRAME LAYOUT.  reload assigns spill slots in pseudo-regno order
 *     and cc1plus numbers pseudos where the declaration is REACHED, so the SYM's AUTO
 *     offsets read off retail's decl SEQUENCE.  fsize 184 = string 0x20 / SIZE_W 0x48 /
 *     SIZE_H 0x50 / POS_Y 0x58 / <(int)SIZE_H> 0x60 / <0x78-halfH> 0x64 / colpos 0x68 /
 *     colname 0x70 / colcar 0x78 / coltime 0x80 / colbestlap 0x88: TWO SImode temps sit
 *     BETWEEN POS_Y and colpos, so the col* block is declared MID-FUNCTION, after the two
 *     statements that create them.  (287->263, slot set now exact.)
 *  2. COLOUR SELECT = TWO FULL CALLS, not a ternary.  The ternary lets gcc materialize the
 *     else-arm constant (li a0,4) BEFORE the guard and reuse that register as the mask
 *     (and v0,v0,a0), emptying the beqz delay slot; retail has andi v0,v0,4 with li a0,4
 *     IN the slot, i.e. both arms written out and cross-jump-merged.  (249->176.)
 *  3. finishType==2 arm INLINE, not the else (bne to the else, ParseTime falls through).
 *  4. MISSING GUARD ARM: retail wrote the semantically-no-op `bestLap != 0 ? bestLap : 0`
 *     null guard (raw `lw a0,1000(v0); bnez a0,T; addu a0,zero,zero`) -- again as TWO full
 *     Hud_ParseTime calls (the ternary spelling scores 153 vs the if/else 83).
 *  5. w42-a4, 65 -> 7: THE halfH SPELLING.  `halfH = HUD_STATS_SIZE_H >> 1;` (the plain
 *     source a human writes) instead of the hand-expanded `(int)(SIZE_H << 0x10) >> 0x11`.
 *     Mechanism: retail's SIZE_H product lives in ONE callee-saved pseudo ($s0) that is
 *     mutated in place down the chain `sll s0,s0,16; sra t0,s0,16; sra s0,s0,17` -- combine
 *     MERGES the (short)-extend with the >>1 into the single `sra 17` while the separate
 *     `sra t0,...,16` keeps feeding the spilled `(int)SIZE_H`.  Writing the shift pair by
 *     hand gave the sra16 TWO uses, so combine could not merge, halfH was computed as
 *     `((x<<16)>>16)>>1` off a short-lived $v0 -- and that one extra pseudo rotated $s0/$s1
 *     (halfH vs the 0xa0-centring temp) through the whole function.  ONE spelling, ~58 diffs.
 *     (Related falsifications at this base: in-place `halfH = product; SIZE_H = (short)halfH;
 *     halfH = (halfH<<16)>>17` = 254 -- it LOSES the early `(int)SIZE_H` materialization
 *     entirely (347 insns); the `(int)(short)halfH >> 1` variant = 254; sh-first = 85.)
 *  6. w42-a4, 7 -> 5: `colpos = HUD_STATS_POS_X;` is the FIRST col* assignment (retail
 *     stores it at 104(sp) BEFORE colname's 112(sp)); it was written after coltime.
 * Residual 5 = ONE emission-order tie in the OptionsBarThing/RenderPauseBox tail: retail
 * reloads all three AUTOs through the same scratch and copies (`lhu t0,72(sp); addu
 * s2,t0,zero`), ours loads SIZE_W straight into $s2 -- exactly the "ours 1 insn shorter,
 * oracle has a redundant copy" uncoalesced-temp shape.  FALSIFIED here: an `int sizeW =
 * (u_short)SIZE_W;` local (5, neutral), the `(int)(u_short)` cast (5, neutral), reusing
 * the dead `barH` local as the carrier (77).
 * FALSIFIED at the 65 base (re-probe only with a new idea): purging titleX (82), titleY
 * (90) or barH (65, neutral); the (u_short) halfH spelling (83).  NOTE the whole ladder is
 * LCS-NON-MONOTONE -- the halfH spelling flipped sign twice as other levers landed.
 * w44-a9 (all measured, 5 stays): the residual copy is a MODE-CONVERSION pseudo, not a
 * cse double-eval.  Retail = `lhu $t0,72(sp); addu $s2,$t0,$zero` (an HImode reload feeding
 * a separate SImode pseudo); ours = `lhu $s2,72(sp)` (reload folds the zero_extend into the
 * load).  FALSIFIED: the trichotomy-#2 mixed named/anonymous pair (`int sizeW = (u_short)W;`
 * for the 2nd call, the literal cast for the 1st) = 5 neutral (copy-propagated); a `u_short
 * sizeW` carrier for both calls = 5 neutral (the HImode copy coalesces); making the two
 * calls' a2 expressions TEXTUALLY different so cse cannot equate them (`W & 0xffffU` vs
 * `(u_short)W`) DOES buy the missing instruction -- count becomes EXACT 349/349 -- but as a
 * whole second reload+`addu a2,t0,zero` in the wrong place (64 diffs), not retail's copy.
 * w45-a9 (5 stays; NEW DATA POINT + refined angle): the ZERO-INSN USE FENCE (§2b.5) DOES
 * buy the missing instruction cleanly -- `__asm__ volatile("" : : "r"(HUD_STATS_SIZE_W));`
 * placed immediately before the OptionsBarThing call makes the count EXACT 349/349 (vs our
 * 348) at 6 diffs, and the `(u_short)` cast form is identical (6).  What it produces is an
 * EXTRA HImode reload of SIZE_W *ahead of* the 88(sp) load, not retail's `lhu $t0,72(sp);
 * addu $s2,$t0,$zero` in place -- i.e. the fence supplies the missing PSEUDO but at the
 * wrong point in the reload order.  (Fencing SIZE_H instead = 28; fencing both = 350/349,
 * 27.)  ⇒ the mechanism is confirmed source-reachable; only the POSITION is wrong.
 * NEW NAMED ANGLE: walk the fence DOWN one arg/statement at a time -- between the two calls,
 * and inside the arg list order (the fence must land AFTER the 88(sp) POS_Y reload and
 * BEFORE the $s2 copy).  Failing that, pair it with the `(u_short)W` vs `W & 0xffffU`
 * textual-difference trick from the w44 note (which also reached 349/349) so the second
 * consumer is the one the fence feeds.
 * NEW ANGLE for the next attempt: this is the w43 MIPS PROMOTE_MODE row -- a DECLARED
 * narrow local always promotes to SImode, so the HImode pseudo retail copies from must be
 * an ANONYMOUS cse temp.  Look for a second HImode consumer of SIZE_W in the same extended
 * BB (the Hud_FBuildF4 `(u_short)HUD_STATS_SIZE_W` arg is the candidate) and give the two
 * consumers a shared HImode subexpression so combine cannot merge load+zero_extend. */
void RaceSummary(void)

{
  short i;
  short HUD_STATS_POS_X;
  short HUD_STATS_SIZE_W;
  short HUD_STATS_SIZE_H;
  short HUD_STATS_POS_Y;
  char string [40];
  int halfH;
  int titleY;
  int barH;
  int titleX;

  HUD_STATS_POS_X = 8;
  if (GameSetup_gData.numLaps == 1) {
    HUD_STATS_POS_X = 0x28;
  }
  HUD_STATS_SIZE_W = 0x130;
  if (GameSetup_gData.numLaps == 1) {
    HUD_STATS_SIZE_W = 0xef;
  }
  HUD_STATS_SIZE_H = (short)((Cars_gNumRaceCars + 1) * 0xc + 0x1e);
  halfH = HUD_STATS_SIZE_H >> 1;
  HUD_STATS_POS_Y = (short)(0x78 - halfH);
  /* DECL POSITION IS THE FRAME LAYOUT (w41-a4): reload assigns spill slots in pseudo-regno
     order and cc1plus numbers pseudos where the declaration is REACHED, so the SYM's AUTO
     offsets read off retail's decl sequence.  fsize 184 = string 0x20 / SIZE_W 0x48 /
     SIZE_H 0x50 / POS_Y 0x58 / <(int)SIZE_H> 0x60 / <0x78-halfH> 0x64 / colpos 0x68 /
     colname 0x70 / colcar 0x78 / coltime 0x80 / colbestlap 0x88 -- the two SImode temps
     born in the two statements above sit BETWEEN POS_Y and colpos, so the col* block must
     be declared HERE, not at the top of the function. */
  short colpos;
  short colname;
  short colcar;
  short coltime;
  short colbestlap;
  titleX = 0xa0 - (textpixels(TextSys_Word(0x38)) >> 1);
  titleY = 0x76 - halfH;
  Font_TextColor(6);
  Font_TextXY(TextSys_Word(0x38),titleX * 0x10000 >> 0x10,titleY);
  Font_TextColor(3);
  /* each col* is computed immediately before its own Font_TextXY (oracle interleaves the
     `addiu $v0,$s6,K; addu $sN,$v0,$zero` pairs with the calls @0x800D9B2C..0x800D9B94). */
  colpos = HUD_STATS_POS_X;
  colname = HUD_STATS_POS_X + 0x11;
  Font_TextXY(TextSys_Word(0x2e),colname,(titleY + 0xf) * 0x10000 >> 0x10);
  colcar = HUD_STATS_POS_X + 0x5f;
  Font_TextXY(TextSys_Word(0x3a),colcar,(titleY + 0xf) * 0x10000 >> 0x10);
  coltime = HUD_STATS_POS_X + 0xa7;
  Font_TextXY(TextSys_Word(0x3b),coltime,(titleY + 0xf) * 0x10000 >> 0x10);
  colbestlap = HUD_STATS_POS_X + 0xe1;
  if (GameSetup_gData.numLaps != 1) {
    Font_TextXY(TextSys_Word(0x3c),colbestlap,(titleY + 0xf) * 0x10000 >> 0x10);
  }
  Hud_FBuildF4(0,HUD_STATS_POS_X,((titleY + 0x11) * 0x10000 >> 0x10) + 0xc,(u_short)HUD_STATS_SIZE_W,1,0,'\0','\0');
  barH = HUD_STATS_SIZE_H + -8;
  Hud_FBuildF4(0,colname + -2,HUD_STATS_POS_Y,1,barH,0,'\0','\0');
  Hud_FBuildF4(0,colcar + -2,HUD_STATS_POS_Y,1,barH,0,'\0','\0');
  Hud_FBuildF4(0,coltime + -2,HUD_STATS_POS_Y,1,barH,0,'\0','\0');
  if (GameSetup_gData.numLaps != 1) {
    Hud_FBuildF4(0,colbestlap + -2,HUD_STATS_POS_Y,1,barH,0,'\0','\0');
  }
  i = 0;
  while (1) {
    if (Cars_gNumRaceCars <= i) break;
    {
    /* SYM: `pos` is a BLOCK-scoped REG $s2 inside the per-car loop. */
    int pos;

    pos = Cars_gRaceCarList[i]->stats.finalPosition;
    if (pos * 2 + 4 < StatsTimer) {
      if ((Cars_gRaceCarList[i]->carFlags & 4U) != 0) {
        Font_TextColor(3);
      }
      else {
        Font_TextColor(4);
      }
      sprintf(string,"%d",pos);
      Font_TextXY(string,colpos | 1,((titleY + 0x11) * 0x10000 >> 0x10) + pos * 0xc);
      Font_TextColor(3);
      sprintf(string,"%s",(char *)(*(int *)((int)Cars_gRaceCarList[i] + 0x288) + 0x5c));
      Font_TextXY(string,colname,((titleY + 0x11) * 0x10000 >> 0x10) + pos * 0xc);
      if ((*(u_int *)((int)Cars_gRaceCarList[i] + 0x260) & 4) != 0) {
        Font_TextColor(3);
      }
      else {
        Font_TextColor(4);
      }
      sprintf(string,"%s",Cars_gRaceCarList[i]->carNameLocalized);
      Font_TextXY(string,colcar,((titleY + 0x11) * 0x10000 >> 0x10) + pos * 0xc);
      if (GameSetup_gData.pinkSlipsForfeit == i) {
        sprintf(string,TextSys_Word(0x36));
      }
      else if ((GameSetup_gData.raceType == RaceType_HotPursuit) &&
               (Cars_gRaceCarList[i]->stats.finalNumArrests != 0)) {
        sprintf(string,TextSys_Word(0x3d));
      }
      else if (*(int *)((int)Cars_gRaceCarList[i] + 0x3cc) == 2) {
        Hud_ParseTime(*(int *)((int)Cars_gRaceCarList[i] + 0x3d4),string);
      }
      else {
        sprintf(string,TextSys_Word(0x35));
      }
      Font_TextXY(string,coltime,((titleY + 0x11) * 0x10000 >> 0x10) + pos * 0xc);
      if (GameSetup_gData.numLaps != 1) {
        if (*(int *)((int)Cars_gRaceCarList[i] + 0x3e8) != 0) {
          Hud_ParseTime(*(int *)((int)Cars_gRaceCarList[i] + 0x3e8),string);
        }
        else {
          Hud_ParseTime(0,string);
        }
        Font_TextXY(string,colbestlap,((titleY + 0x11) * 0x10000 >> 0x10) + pos * 0xc);
      }
    }
    }
    i = i + 1;
  }
  {
  /* w46-a8 SEAL (5 -> PASS, 349/349).  THE `& 0xffff` NAMED CARRIER.  Retail reloads the
     SIZE_W AUTO through the shared scratch and COPIES it into the callee-saved carrier
     (`lhu $t0,72(sp); addu $s2,$t0,$zero`) where every `(u_short)` spelling let reload fold
     the zero-extend straight into the destination (`lhu $s2,72(sp)`, 1 insn short).
     `HUD_STATS_SIZE_W & 0xffff` on a `short` builds `(and:SI (sign_extend:SI (mem:HI)) 0xffff)`
     -- combine narrows the load to `lhu` but the AND's result is a SEPARATE pseudo from the
     load's, so the long-lived carrier is a COPY, exactly retail's pair.  MEASURED at this
     base: `(u_short)` cast named local = 5 (folded), `int t2=(u_short)W; int w2=t2;` split
     = 5 (coalesced), named y2/w2/h2 triple = 5, zero-insn USE fence before the call = 6
     (count-exact 349 but the extra load lands ahead of the 88(sp) reload), fence + named
     carrier = 6 (the volatile asm invalidates memory in cse, so the carrier cannot be CSE'd
     onto the fence's load -- that is WHY the w45 fence angle could not be walked into place),
     statement-expression fence inside arg 3 = 6, fence on POS_Y too = 7 (350 insns). */
  int w2 = HUD_STATS_SIZE_W & 0xffff;
  OptionsBarThing(HUD_STATS_POS_X,HUD_STATS_POS_Y,w2,(int)HUD_STATS_SIZE_H);
  Hud_RenderPauseBox(HUD_STATS_POS_X,HUD_STATS_POS_Y,w2,(int)HUD_STATS_SIZE_H);
  }
  return;
}

/* ---- RaceStatistics__Fv  [OVERLAYS.CPP:165-321] SLD-VERIFIED ---- */
/* w41-a4: 296 -> 94 diffs (471 ours / 475 oracle), frame 168 -> 176 == SYM fsize.
 * Levers: (1) the decl-order spill-slot model (see the decl block below); (2) the lap
 * COLOUR select and (3) the lap-TIME null guard both rewritten as TWO full calls instead
 * of ternaries (230->208->120 -- the same pair of levers that took RaceSummary to 65);
 * (4) finishType==2 as the INLINE arm (120->106); (5) dataY inlined at its use sites
 * (106->94).  Residual 94 = a uniform head register rotation (ours s1/s4/s7/s2 vs oracle
 * s4/s7/s2/s3), the `mult $v1,$a1` (0x96) the synthesized shift chain replaces, and two
 * 2-insn lui/addiu hoist positions.  FALSIFIED at the 94 base: `int rows` product
 * liveness (98), `int pitch = 0x96` for the mult (139), purging halfH (94, neutral),
 * titleX (160) or titleY (123), and the y-coordinate ternaries as two calls (259/248).
 * w42-a4 re-probe of the mult+rows pair (the w41 "land them TOGETHER" lead): rows+pitch
 * DOES reproduce the retail head STRUCTURE -- real `mult v1,a1` off `li a1,150`, the
 * product kept live for BOTH the `+0x28` and `+0x1C` arms, and n*75 demoted out of a
 * callee-saved reg -- and drives the insn count 471 -> 473 of 475.  It still gates WORSE
 * (138) for ONE reason, readable in the -dg dump: with `pitch` a real pseudo, sched1
 * hoists the whole `lw numHuman; mult` chain ABOVE the register saves, so the product's
 * live range spans the prologue and reload cannot colour it (greg: "Need 2 regs of class
 * MD_REGS (for insn 55) / Spilling reg 9,64,65,66") -- it emits `mflo t1; sw t1,132(sp)`
 * + an `lhu` truncation reload where retail has `mflo s3`.  Retail's mult is issued AFTER
 * the saves.  Variants measured: rows-only 98, pitch-only 139, rows+pitch 138, SIZE_W
 * after POS_X 123, `short pitch` 138, pitch also driving the two `col +=` increments
 * (94/139 -- cse const-props it back in the loop, so the increments are NOT the reason
 * retail has a variable multiplier).
 * 🔑 w45-a9 EXECUTED THE "NEXT IDEA" BELOW WITH THE ZERO-INSN USE FENCE (§2b.5) -- IT WORKS
 * ON THE MECHANISM, and its result is the structurally-correct base to continue from (NOT
 * landed: gates 102 vs the kept 94, but its COUNT IS EXACT 475/475 where the kept form is
 * 471):
 *     { int pitch = 0x96;  __asm__ volatile("" : : "r"(pitch));
 *       HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * pitch; }
 * The fence is a sched1 fixpoint, so the `lw numHuman; mult` chain can no longer hoist above
 * the register saves and reload colours the product normally: ours now emits the REAL
 * `mult $v1,$v0` + **`mflo $s3`** (retail `mult $v1,$a1` + `mflo $s3`), and the w42 greg
 * spill (`mflo $t1; sw $t1,132(sp)` + the lhu truncation reload) is GONE.  ⇒ the multiplier
 * form AND the schedule are both solved.  What is left at 102 is ONE thing: retail
 * INTERLEAVES its three constant materializations into the prologue save sequence
 * (`sw s7,164(sp); li s7,160; sw s2,144(sp); li s2,1`, with `li a1,150` at insn 3) while ours
 * emits all nine saves first and the constants after.  NEW NAMED ANGLE from that base: 150 /
 * 160 / 1 are exactly the constants retail parks in CALLEE-SAVED regs, so give each its own
 * named local in the SYM's decl order and fence them TOGETHER in one asm before the first
 * use -- the interleave is reload's save-insn placement around live callee-saved constants,
 * a live-range dial, not a statement-order dial.
 * OLD NEXT IDEA for this axis: stop sched1 from hoisting
 * the mult chain (shorten the product's live range) rather than another spelling of the
 * multiplier -- the multiplier form is SOLVED, the schedule is not.
 * ---- w46-a8: 94 KEPT (471/475), but the w45 "NEW NAMED ANGLE" WAS EXECUTED and produced a
 * STRUCTURALLY BETTER, COUNT-EXACT 475/475 BASIN at LCS 100.  Not landed (it gates worse
 * than the kept 94 and the LCS is non-monotone here), but it is the base to resume from --
 * reproduce it with scratch/p_rst3.py variant `t1` (committed):
 *     int pitch, cx, one, rows;                 // added to the decl block, after titleY
 *     rows = (numLaps + 1) * 0xc;  HUD_STATS_SIZE_H = rows + 0x28;
 *     ...  if (numLaps == 1) HUD_STATS_SIZE_H = rows + 0x1c;
 *     { pitch = 0x96; cx = 0xa0; one = 1;
 *       __asm__ volatile("" : : "r"(pitch), "r"(cx), "r"(one));
 *       HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * pitch; }
 *     HUD_STATS_POS_X = cx - ...;  col2 = cx;  titleX = cx - ...;
 * WHAT IT BUYS (all read off the side_by_side, not the LCS number):
 *   - the w45 fence keeps the real `mult` + `mflo $s3` (as documented) AND
 *   - `cx` reproduces retail's CONSTANT-INTERLEAVED-INTO-THE-PROLOGUE-SAVES shape exactly
 *     (`sw $sN,K(sp); li $sN,160` adjacent, where the kept form emits all nine saves first);
 *   - `rows` reproduces retail's kept product: ours `addiu $a1,$a1,28` == oracle
 *     `addiu $a0,$a0,28`, replacing the const-folded `li $t1,52`.  This closes the w41
 *     "land rows TOGETHER with the head rotation" item -- rows lands cleanly here.
 * WHAT IS LEFT (the whole residual, and it is now ONE thing): the callee-saved CONSTANT
 * RANK.  Retail 1 -> $s2 and 160 -> $s7 with `li $a1,150` at insn 4; ours 160 -> $s2 and
 * 1 -> $s1, and the 150 materializes late in $v0.  Everything else in the head is
 * instruction-for-instruction.
 * MEASURED AROUND THAT BASIN: fence(pitch) alone 102 @475 (the w45 form); +cx 102; +cx+one
 * with `one` also routed into the four Hud_FBuildF4 `1` args 112; +one only 108; pitch also
 * driving the two `col += 0x96` increments 176; +rows with cx not routed to titleX 100;
 * +rows +one routed 116.  So `one` must stay DECLARED-AND-FENCED BUT UNUSED (routing it
 * into the arg lists costs 16), and cx must be routed to all three sites.
 * NEW NAMED ANGLE: this is now a pure allocno-rank problem with a count-exact base, i.e.
 * exactly what tools/allocsim.py + reqdelta.py are for -- dump this basin (-dg/-dl), ask
 * `--want "p<one>=s2,p<cx>=s7"`, and apply the ref/live delta it prints.  The three
 * constants are fn-scope locals, so they are GLOBAL allocnos and find_reg DOES reach them
 * (unlike the local-qty cases elsewhere in this wave).
 * ---- 🔴 w50-a10 EXECUTED THAT ANGLE AND IT IS FALSIFIED AT THE MODEL LEVEL -- 94 KEPT.
 * The t1 basin was reproduced exactly (scratch/p_rst3.py V=t1 -> 100 diffs @ 475/475
 * count-exact, RaceSummary/Hud_RenderStatsView/OptionsBarThing all still PASS), dumped with
 * `CC1PLPSX -O2 -G4 -dg -dl`, and run through tools/allocsim.py: the model reports
 * **MATCH 50/50 (order-vs-dump: IDENTICAL)**, so the dump is trustworthy.  What it says
 * kills the premise: the three fenced constants are the allocnos p84 / p85 (`preferences:
 * 17`) / p86 / p87 (`preferences: 18`), they sit at the BOTTOM of the priority list
 * (refs=2 live=351..389 crossing 43-45 calls, pri 0.0052-0.0308) and global_alloc gives
 * them **NO HARD REGISTER AT ALL** (`--`) -- in BOTH the sim and the real dump.  The
 * `li $18,160` / `li $17,1` in our asm are therefore RELOAD REMATERIALIZATIONS into the
 * consumer pseudos, not a callee-saved allocation of the constants.
 *   => the w46 "pure allocno-RANK problem, ask reqdelta for p<one>=s2,p<cx>=s7" framing is
 *      WRONG: you cannot dial the rank of an allocno that never wins a register.
 *      Confirmed empirically: `reqdelta --want p85=s2,p87=s7` finds NO single-dial delta in
 *      +-40 on refs/live/calls AND no two-dial (refs+live) pair -- it is unreachable by
 *      construction, not by budget.
 *   NEW NAMED ANGLE (replaces it): the dial is which CONSUMER pseudo reload remats each
 *   constant into, i.e. the copy-PREFERENCE edges (`;; 85 preferences: 17`, `;; 87
 *   preferences: 18` in the .greg) -- retail wants 160 in $s7 and 1 in $s2 with `li a1,150`
 *   at insn 4.  Instruments: (1) reqdelta on the CONSUMERS that actually hold s2/s1 in the
 *   t1 basin (p259 s2 refs=8 live=68, p81 s1 refs=17 live=69, p80 s7 refs=13 live=295)
 *   rather than on the constants; (2) an opacity fence placed on a CONSUMER (the "0"
 *   constraint kills a copy-preference outright -- catalog w49 row) to redirect the
 *   preference edge.  Repro kit: scratch/w50_a10/rst.py (applies V=t1, gates, restores).
 * ---- W71-A6 (2026-08-21): 94 KEPT @471/475.  Two contributions, both negative on the
 * gate but they NARROW the problem and name a transferable sibling cure.
 * (1) FALSIFIED -- the W71 INDEX-TERM-FIRST ADDRESS lever (which landed
 *     InGame_GetPSXPadValue 168->126 and Hud_BTCStats' cluster (d) 24->15) does NOT
 *     reach this fn's repeated `lui t1; addiu t1; addu v0,v0,t1` sites.  The two
 *     `Cars_gRaceCarList[i]` accesses rewritten as
 *     `*(Car_tObj **)(((int)i << 2) + (int)Cars_gRaceCarList)` = 96, base-first = 96,
 *     the MULT spelling = 94 (bit-identical).  The direction is INVERTED here: retail
 *     emits the BASE PAIR FIRST and the `sll` second (side_by_side lines 316/390/432),
 *     i.e. the natural ARRAY_REF form is already the right shape and the residual at
 *     those sites is only the SCRATCH REGISTER (ours t1, retail v0/v1) -- downstream of
 *     the head band rotation w63/w64 price, not of the access spelling.
 * (2) 🔑 THE PER-PLAYER BAR HEIGHT CARRIES Hud_BTCStats' EXACT FOLD DEFECT.  sbs lines
 *     163-174: retail computes `subu v1,s3,t1` (yoff), `lw t1,120(sp)` (barH),
 *     `addiu v1,v1,19`, `subu v1,t1,v1` = `barH - (yoff + 0x13)`; ours folds it to
 *     `addiu v1,t1,-19; subu v1,v1,t0` = `(barH - 19) - yoff`.  Same `A - (B + CST)`
 *     reassociation, same 2-insn-for-2-insn shape, and `barH` is already the hoisted
 *     int minuend that Hud_BTCStats needed.  Hud_BTCStats is now at 6 diffs whose
 *     ENTIRE residual is that one fold, so it is the cheap laboratory -- whatever fold
 *     escape seals it there transfers straight here.  Do the 6-diff fn first.
 * The w64 `ip` basin was re-verified this wave (`python scratchpad/w64a13/apply.py
 * rprobe5 ip` -> 106 @475/475, census `addiu 69v70 nop 24v23`); its named dial (+4 RTL
 * insns inside p95's live range at zero refs) is unchanged and still needs the w60-12E
 * instrument, not a spelling. */
void RaceStatistics(void)

{
  short i;
  short j;
  short col1;
  short col2;
  char string [40];
  short HUD_STATS_POS_X;
  short HUD_STATS_SIZE_W;
  short HUD_STATS_SIZE_H;
  short HUD_STATS_POS_Y;
  /* DECL ORDER IS THE FRAME LAYOUT (w41-a4): reload assigns spill slots in PSEUDO-REGNO
     order and cc1plus numbers pseudos in declaration order, so the SYM's AUTO offsets read
     off the retail decl sequence directly.  fsize 176 = string@0x20, POS_X 0x48, SIZE_W
     0x50, SIZE_H 0x58, POS_Y 0x60, <sizeH16> 0x68, <posy> 0x6C, HOTPURSUIT_Y 0x70, <barH>
     0x78, <posyL> 0x7C, <barH8> 0x80 -- i.e. TWO int temps sit BETWEEN POS_Y and
     HOTPURSUIT_Y (HImode decl slots take an 8-byte stride, SImode spills 4). */
  int sizeH16;
  int posy;
  short HUD_STATS_HOTPURSUIT_Y;
  int barH;
  int posyL;
  int barH8;
  int halfH;
  int titleX;
  int titleY;

  HUD_STATS_SIZE_H = (GameSetup_gData.numLaps + 1) * 0xc + 0x28;
  /* w40-a4 OPEN (mult 0 vs 1): the oracle hoists `li $a1,0x96` to insn 4 and does a REAL
     `mult $v1,$a1` @0x800DA020; ours synth_mult's 150 as (n*75)<<1 and then CSEs the n*75
     into POS_X below.  A named `int pitch = 0x96;` local DOES produce the mult (RTL: a
     non-CONST_INT operand at expand time, cse const-props the 0x96 afterwards) and moves
     the insn count 457->462 of 475, but costs LCS 296->311 and contradicts the SYM local
     list -- not adopted.  Falsified as multiplier forms: operand swap, decimal spelling,
     statement order vs POS_X. */
  /* w49-a10: RE-FALSIFIED on the current basin (94 diffs, ours 471 / oracle 475).  The
     `int pitch = 0x96;` block-local still produces the real mult but scores 139 (worse
     than 94), so it stays rejected.  ALSO NEW: the retail SLD line order is POS_X (174),
     SIZE_W (175), SIZE_H (176), `if (numLaps == 1)` (177), SIZE_H (178) -- i.e. retail
     assigns POS_X BEFORE SIZE_W and SIZE_H, the reverse of this file.  All five
     permutations of the three statements were gated: CBA/BCA/BAC = 126 (and 8 insns
     short), CAB/ACB = 94 (identical to the current ABC).  Statement order is therefore
     NOT the lever for the synth-mult-vs-mult split; the shift chain for 0x4b is shared
     into 0x96 regardless of which statement expands first. */
  /* ---- w63-a13 (2026-08-15): 94 STAYS @471/475.  NEW READING OF THE PROLOGUE -- retail
     does not name ONE constant, it names THREE, and every earlier wave probed only the
     first: `addiu $a1,$zero,0x96` (insn 4), `addiu $s7,$zero,0xA0` (insn 6) and
     `addiu $s2,$zero,1` (insn 8).  $s7 is the POS_X centre (`subu s4,s7,v1` = 0xA0 - n*75)
     and $s2 is the compare operand for BOTH `== 1` tests (`bne a2,s2` numLaps,
     `bne v0,s2` raceType).  So the retail source held pitch/centre/one in locals, which is
     what makes 0x96 a non-CONST_INT operand at expand time = the real `mult`.
     A per-opcode census against the oracle (scratchpad/w63a13/opcen.py) prices the whole
     4-insn shortfall exactly: `mult 0v1  mflo 0v1  addiu 68v70  addu 54v55  sll 53v52`.
     MEASURED (13F/04Z: land the SET, not one member -- all re-gated):
        pitch alone                    139 @472    (re-confirms the w49 measurement)
        pitch + centre                 142 @473
        pitch + centre + one           152 @473    <- the mult appears; 2 short, not 4
        centre + one (no pitch)        129 @470
        pitch + one                    144 @473
     ⇒ the named-constant SET moves the INSN COUNT the right way (471 -> 473 of 475) and
     produces retail's `mult`/`mflo`, but the LCS gate rises because the head register
     band rotates.  This is exactly the hard-floor-basin case the AGENT_GUIDE rule 9
     describes, and it is the SAME pairing the w41-a4 note already flagged for the
     `rows` local ("land it TOGETHER with the head register rotation (ours s1/s4/s7/s2 vs
     oracle s4/s7/s2/s3)").  UNWOUND here for lack of budget to complete the paired step.
     NEXT TAKER: start from `all_three` (473/475) and treat the head band as the ONLY
     remaining problem -- retail's s7/s2 are the two named constants themselves, so the
     rotation is very likely a consequence of WHERE the three initialisers sit, not an
     independent tie.  Sweep their statement positions (the w45 stmtclimb family) before
     touching anything else. */
  /* ---- w64-a13 (2026-08-15): 94 KEPT @471/475, but the w63 "THREE NAMED CONSTANTS"
   * reading is CORRECTED and a COUNT-EXACT 475/475 basin is now banked with the census
   * down from five opcodes to TWO.  Repro: scratchpad/w64a13/rprobe{3,4,5,6}.py +
   * apply.py (variants `pf_below` 102, `pf_rows` 102, `ip` = pf_rows + in-place titleX
   * 106 -- all 475/475 count-EXACT).
   * (1) READ THE WHOLE ORACLE, NOT THE PROLOGUE: two of w63's "three constants" are
   *     NOT constants, they are TWO-ROLE VARIABLES mutated in place --
   *       $s7: `addiu s7,zero,0xA0` (insn 6) -> `subu s4,s7,v1` (POS_X)
   *            -> `subu s7,s7,v0` @0x800DA0B0 (titleX, IN PLACE) -> later the j counter;
   *       $s2: `addiu s2,zero,1` (insn 8) -> both `== 1` tests -> `sw s2,0x10(sp)`
   *            (the 1st Hud_FBuildF4's 5th arg) -> later colmid.
   *     And col2 gets its OWN `addiu s5,zero,0xA0` @0x800DA0A8, so the w46 instruction
   *     "cx must be routed to all three sites incl. col2" was WRONG.  Because both cross
   *     calls they are callee-saved BY CONSTRUCTION -- no fence is needed to park them,
   *     which is what separates this from every w45/w46/w50/w63 "named constant" probe.
   * (2) THE BASIN.  `pitch = 0x96;` + the w45 use fence placed BELOW the SIZE_H statement
   *     (so numLaps is read first, like retail) is count-EXACT 475/475 at 102; adding the
   *     w41 `rows` local lands it CLEANLY (ours `addiu a1,a1,28; sh` == oracle
   *     `addiu a0,a0,28; sh`, the `li t1,52` const-fold gone) and adding the in-place
   *     titleX merges 160 INTO titleX's own pseudo (ours `subu s1,s1,v0` == retail's
   *     `subu s7,s7,v0`).  Census ladder: kept 94 = `addiu 68v70 addu 54v55 mflo 0v1
   *     mult 0v1 sll 53v52` -> pf_rows = `addiu 69v70 addu 54v55 nop 25v23` -> ip =
   *     `addiu 69v70 nop 24v23`.  Placement of the pitch fence is the whole dial:
   *     ABOVE the SIZE_H statement 140 @473, BELOW it 102 @475, no fence 139 @472.
   * (3) THE RESIDUAL IS NOW ONE PRICED BAND SWAP, and the model is VALID here:
   *     tools/allocsim.py reports MATCH 49/49 on the `ip` basin (dump it with
   *     `apply.py rprobe5 ip` + `tools/rtl_dump.py recon/game/psx/overlays.cpp -dg -dl`).
   *     pseudoid names them: p95 = `(set (reg/v:SI 95) (const_int 160))` = titleX,
   *     p123 = `(set (reg:SI 123) (const_int 1))` = the anonymous cse constant 1.
   *     Retail wants p95=$s7 and p123=$s2; we get $s1 and $s7.
   *     multidial PRICES THE titleX HALF EXACTLY: **p95 live 57 -> 61 (+4 RTL insns in
   *     its range, refs UNCHANGED at 4) lands it in retail's $s7** (verified by
   *     `multidial.py ... --ov "p95:live=61"` -> that half matches).  p95 refs 4->3 does
   *     NOT work (it drops to $fp).  The p123 half is NOT priced: it needs $s2, held by
   *     p257 (a pointer, refs=8 live=68, pri 0.3529) -- reqdelta finds no single- or
   *     two-dial delta in +-60, and multidial's greedy only closes it with p237
   *     refs 18->1 (the GameSetup_gData address pointer -- not source-reachable).
   *     FALSIFIED attempts to buy the +4 live (all on the `ip` basin, all 475/475 unless
   *     noted): titleX added as a 2nd operand of the pitch fence 110 . titleX declared
   *     after the pitch fence 106 (bit-identical) . its own `"r"(titleX)` fence right
   *     after the init 113 @476 . col1/col2 moved ABOVE the in-place update 134 @473 .
   *     a `"r"(col1)` fence before the Font_TextXY 106 (bit-identical) . the same with
   *     two operands 106 . both fences together 113 @476.
   *     NEXT TAKER: the dial is +4 RTL insns inside p95's live range at ZERO refs and
   *     ZERO barriers -- i.e. exactly the w60-12E "4-WITNESS INSTRUMENT REQUEST" (lengthen
   *     a live range without adding a ref or a barrier).  A cheaper equivalent is to move
   *     p95's BIRTH earlier: retail's `li s7,160` is at insn 6 (interleaved with the
   *     saves) while ours is at ~insn 20, so ~14 insns of the delta are already sitting
   *     in the birth position -- pin the `li 160` into the prologue group and the live
   *     dial comes for free.  Do NOT re-probe spellings of the three constants; that axis
   *     is closed in both waves. */
  HUD_STATS_SIZE_W = Cars_gNumHumanRaceCars * 0x96;
  HUD_STATS_POS_X = 0xa0 - Cars_gNumHumanRaceCars * 0x4b;
  /* the numLaps==1 arm RE-COMPUTES `(numLaps+1)*0xc + 0x1c` (oracle @0x800DA044
     `addiu $a0,$a0,0x1C` off the SAME (numLaps+1)*12 product) -- it is not the folded
     constant 0x34 that the old spelling used.
     w41-a4 OPEN (banked, receipts): with THIS spelling cse still const-folds the arm
     (it records numLaps==1 off the branch) and we emit `li $t1,0x34`.  A named
     `int rows = (numLaps+1)*0xc;` used on BOTH sides reproduces the oracle exactly
     (`addiu $a1,$a1,0x1C; sh` == oracle `addiu $a0,$a0,0x1C; sh`) -- retail kept the
     product live in a local.  Insn count unchanged 459/475 but LCS 230->236, so land
     it TOGETHER with the head register rotation (ours s1/s4/s7/s2 vs oracle s4/s7/s2/s3). */
  if (GameSetup_gData.numLaps == 1) {
    HUD_STATS_SIZE_H = (GameSetup_gData.numLaps + 1) * 0xc + 0x1c;
  }
  if (GameSetup_gData.raceType == RaceType_HotPursuit) {
    HUD_STATS_SIZE_H = HUD_STATS_SIZE_H + 0x1b;
  }
  sizeH16 = (int)((u_int)(u_short)HUD_STATS_SIZE_H << 0x10);
  halfH = sizeH16 >> 0x11;
  posy = 0x78 - halfH;
  titleX = 0xa0 - (textpixels(TextSys_Word(0x39)) >> 1);
  col1 = HUD_STATS_POS_X + 0xa;
  col2 = 0xa0;
  HUD_STATS_POS_Y = (short)posy;
  titleY = 0x76 - halfH;
  HUD_STATS_HOTPURSUIT_Y = (short)(titleY + (GameSetup_gData.numLaps + 2) * 0xc + 0x13);
  if (1 < Cars_gNumHumanRaceCars) {
    col2 = 0x55;
  }
  Font_TextColor(6);
  Font_TextXY(TextSys_Word(0x39),titleX * 0x10000 >> 0x10,titleY);
  Hud_FBuildF4(0,HUD_STATS_POS_X,((titleY + 0x11) * 0x10000 >> 0x10) + 0xb,(int)HUD_STATS_SIZE_W,1,0,'\0','\0');
  if (GameSetup_gData.raceType == RaceType_HotPursuit) {
    Hud_FBuildF4(0,HUD_STATS_POS_X,HUD_STATS_HOTPURSUIT_Y,(int)HUD_STATS_SIZE_W,1,0,'\0','\0');
  }
  i = 0;
  posyL = posy;
  barH = sizeH16 >> 0x10;
  barH8 = barH + -8;
  while (1) {
    if (Cars_gNumHumanRaceCars <= (int)i) break;
    {
      /* SYM: `colmid` is a BLOCK-scoped REG $s2, declared inside the per-player loop. */
      int colmid;

      colmid = col2 - ((textpixels(Cars_gRaceCarList[i]->carInfo->driver) >> 1) + 2);
      Hud_FBuildF4(0,col2 + -2,((titleY + 0x11) * 0x10000 >> 0x10) + 0xb,1,barH - ((((titleY + 0x11) * 0x10000 >> 0x10) - posyL) + 0x13),0,'\0','\0');
      if (0 < (int)i) {
        Hud_FBuildF4(0,col1 + -2,posyL,1,barH8,0,'\0','\0');
      }
      if (2 < D_8013D99C) {
        Font_TextColor(3);
        sprintf(string,"%s",Cars_gRaceCarList[i]->carInfo->driver);
        /* CORRECTNESS (w39-a4): the Y arg is ((titleY + 0x11) * 0x10000 >> 0x10)-4, NOT (-halfH)-4.  Raw oracle
           @0x800DA2D0 `addiu $a2,$s3,-0x4` with $s3 = ((titleY + 0x11) * 0x10000 >> 0x10). */
        Font_TextXY(string,colmid,((titleY + 0x11) * 0x10000 >> 0x10) + -4);
      }
    }
    /* NOT `a && b`: the oracle keeps two separate compares off ONE load
       (`beq $v0,1` @0x800DA2E0 then `blez $v0` @0x800DA2EC); the &&-form lets gcc
       range-fold them into a single `slti v0,v0,2`. */
    if (GameSetup_gData.numLaps != 1) {
     if (0 < GameSetup_gData.numLaps) {
      j = 0;
      do {
        if ((int)j * 2 + 4 < D_8013D99C) {
          /* colour is an inline ternary (oracle puts `li $a0,3` in the `beq` delay slot
             @0x800DA33C and falls into `li $a0,4`); there is no `color` local in the SYM. */
          if (((Cars_gHumanRaceCarList[i]->stats).finalLapTime[j] != 0) &&
              ((Cars_gHumanRaceCarList[i]->stats).finalLapTime[j] ==
               (Cars_gHumanRaceCarList[i]->stats).finalBestLap)) {
            Font_TextColor(3);
          }
          else {
            Font_TextColor(4);
          }
          sprintf(string,TextSys_Word(0x34),(int)j + 1);
          Font_TextXY(string,(int)col1,((titleY + 0x11) * 0x10000 >> 0x10) + (int)j * 0xc + 0xc);
          if ((Cars_gHumanRaceCarList[i]->stats).finalLapTime[j] != 0) {
            Hud_ParseTime((Cars_gHumanRaceCarList[i]->stats).finalLapTime[j],string);
          }
          else {
            Hud_ParseTime(0,string);
          }
          Font_TextXY(string,col2 + 5,((titleY + 0x11) * 0x10000 >> 0x10) + (int)j * 0xc + 0xc);
        }
        j = j + 1;
      } while ((int)j < GameSetup_gData.numLaps);
     }
    }
    if (GameSetup_gData.numLaps * 2 + 4 < D_8013D99C) {
      sprintf(string,TextSys_Word(0x37));
      Font_TextColor(3);
      Font_TextXY(string,(int)col1,
                  GameSetup_gData.numLaps != 1 ?
                  ((titleY + 0x11) * 0x10000 >> 0x10) + GameSetup_gData.numLaps * 0xc + 0xc :
                  ((titleY + 0x11) * 0x10000 >> 0x10) + GameSetup_gData.numLaps * 0xc);
      if (GameSetup_gData.pinkSlipsForfeit == i) {
        sprintf(string,TextSys_Word(0x36));
      }
      else if ((Cars_gHumanRaceCarList[i]->stats).finalFinishType == 2) {
        Hud_ParseTime((Cars_gHumanRaceCarList[i]->stats).finalTotalTime,string);
      }
      else if ((GameSetup_gData.raceType == RaceType_HotPursuit) &&
               ((Cars_gHumanRaceCarList[i]->stats).finalNumArrests != 0)) {
        sprintf(string,TextSys_Word(0x3d));
      }
      else {
        sprintf(string,TextSys_Word(0x35));
      }
      Font_TextXY(string,col2 + 5,
                  (GameSetup_gData.numLaps != 1 ?
                   ((titleY + 0x11) * 0x10000 >> 0x10) + GameSetup_gData.numLaps * 0xc : ((titleY + 0x11) * 0x10000 >> 0x10)) + 0xc);
    }
    if (GameSetup_gData.raceType == RaceType_HotPursuit) {
      if (GameSetup_gData.numLaps * 2 + 6 < D_8013D99C) {
        sprintf(string,TextSys_Word(0x3e));
        Font_TextColor(3);
        Font_TextXY(string,(int)col1,HUD_STATS_HOTPURSUIT_Y + 1);
        sprintf(string,"%d",*(int *)((int)Cars_gHumanRaceCarList[i] + 0x3c0));
        Font_TextXY(string,col2 + 5,HUD_STATS_HOTPURSUIT_Y + 1);
      }
      if (GameSetup_gData.numLaps * 2 + 8 < D_8013D99C) {
        sprintf(string,TextSys_Word(0x3f));
        Font_TextColor(3);
        Font_TextXY(string,(int)col1,HUD_STATS_HOTPURSUIT_Y + 0xd);
        sprintf(string,"%d",*(int *)((int)Cars_gHumanRaceCarList[i] + 0x3c4));
        Font_TextXY(string,col2 + 5,HUD_STATS_HOTPURSUIT_Y + 0xd);
      }
    }
    col1 = col1 + 0x96;
    col2 = col2 + 0x96;
    i = i + 1;
  }
  OptionsBarThing(HUD_STATS_POS_X,(int)HUD_STATS_POS_Y,(int)HUD_STATS_SIZE_W,(int)HUD_STATS_SIZE_H);
  Hud_RenderPauseBox(HUD_STATS_POS_X,(int)HUD_STATS_POS_Y,(int)HUD_STATS_SIZE_W,(int)HUD_STATS_SIZE_H);
  return;
}

/* ---- Hud_BTCStats__Fsb  [OVERLAYS.CPP:326-441] SLD-VERIFIED ---- */
/* w40-a4: 379 -> 49 diffs (472 ours / 473 oracle), frame now 168 == SYM fsize.
 * 🔑 The +8 frame slot (worth ~30 diffs on its own, via every sp displacement) is decided
 *    ENTIRELY by the showtimeleft-bar height expression: any spelling gcc can algebraically
 *    cancel down to `SIZE_H + POS_Y - K` allocates a 7th (dead) 8-byte spill slot and the
 *    whole frame shifts.  Keeping `startY+0xf` on BOTH sides of the subtraction (the same
 *    shape as the loop's height term) keeps the frame at 168.  Measured ladder:
 *    baseline 120/f176 -> `SIZE_H + startY+0xf - ...` 59/f168 -> loop-shape reuse 49/f168.
 * Residual 49, four clusters, all scheduling/coloring:
 *   (a) `li s5,1` (the i=1 init) issued one slot early vs the oracle's jal delay slot;
 *   (b) col-loop preheader s1<->s2 (y-POS_Y vs (int)SIZE_H) + gcc refolding
 *       `SIZE_H - ((y-POS_Y)+8)` into `(SIZE_H-8) - (y-POS_Y)` (3 spellings falsified:
 *       ternary-first, showtimeleft-term-first, POS_Y-as-base);
 *   (c) the showtimeleft bar's remaining 6-insn evaluation order;
 *   (d) `lui t0` vs `lui v1` scratch pick on the StatsTimer base + one nop/lhu swap.
 * w42-a4 re-probe of cluster (b) -- the refold `SIZE_H - ((y-POS_Y)+8)` -> `(SIZE_H-8) -
 * (y-POS_Y)` survives EVERY spelling tried, because cc1 splits the `postgame ? 8 : 0`
 * ternary into arms FIRST and then folds the now-constant addend inside each arm.
 * FALSIFIED at the 49 base: addition-operand swap `((postgame?8:0) + dy)` (49, neutral),
 * `(postgame != 0) * 8` (49, neutral), a per-arm ternary of two full subtractions (59),
 * TWO FULL Hud_FBuildF4 CALLS per postgame arm (134 -- the w41 value-select-ternary lever
 * does NOT transfer here, this is a value argument inside a loop, not a call selector),
 * and right-association `(SIZE_H - dy) - (postgame?8:0)` (55).  The s1<->s2 half of the
 * cluster is downstream of the same fold (it decides which subterm is evaluated first).
 * w44-a9 re-read of cluster (c) (the showtimeleft bar) -- the residual is now NAMED
 * precisely: retail evaluates the SUM first and then MUTATES the shared `startY+0xf` value
 * IN PLACE into the difference --
 *   `sra v1,..;addiu v1,v1,15` (= y) ; `addu a0,v1,SIZE_H` (= top) ;
 *   `subu v1,v1,POS_Y` (in-place!) ; `subu v0,a0,v1`
 * -- while ours evaluates the DIFFERENCE first into a FRESH pseudo (`subu a0,v1,POS_Y`)
 * and the sum second (`addu v0,v1,SIZE_H`), then `subu v0,v0,a0`.  Same value, mirrored
 * operand order at every step; cause = gcc expands the more COMPLEX operand of `X - Y`
 * first and our Y carries the `postgame ? 8 : 0` ternary.
 * FALSIFIED w44-a9: pulling the ternary out of the subtrahend
 * (`... - (startY+0xf-POS_Y) - (postgame?8:0) - 0x10`) = 120 diffs @465 (8 SHORT -- the
 * per-arm fold collapses); re-associating the subtrahend as one parenthesized group
 * (`(A) - ((B) + t + 0x10)`) = 54 @471 (2 short).
 * ✅ w44-a9 LANDED (49 -> 27): the minuend form below.  The SAME re-sign does NOT transfer
 * to the col-loop expression (cluster b) -- measured there: MODIFY_EXPR embedded assignment
 * `SIZE_H - (inset = dy + (postgame?8:0)) - ...` = 48 @469 (4 SHORT), and swapping the two
 * subtracted terms `SIZE_H - (showtimeleft?0x10:0) - (dy + (postgame?8:0))` = 36 @471
 * (2 short).  Cluster (b) still wants the UN-refolded `s2 - (s1 + 8)`; the fold survives.
 * OLD NOTE (this is what LANDED): make the SUM the complex operand -- keep the ternary on the MINUEND
 * side (`(startY+0xf+SIZE_H-(postgame?0:8)) - (startY+0xf-POS_Y) - 0x10`, algebraically
 * re-signed) so gcc expands the difference term second and can reuse the shared
 * `startY+0xf` pseudo in place, which is the only shape that produces retail's
 * `subu v1,v1,POS_Y` self-mutation.
 * ---- w45-a9 RECEIPT BAR: 27 stays (count 472 / 473).  Two clusters remain:
 *  (a) `li $s5,1` (the col-rule loop's i=1) issues at ours[214] vs retail[193] (retail puts
 *      it in the delay slot of the Font_TextXY(0x4c) `jal`, i.e. BEFORE the first
 *      Hud_FBuildF4).  FALSIFIED THIS WAVE: hoisting `i = 1;` out of the `for` to a
 *      statement ahead of that Hud_FBuildF4 call (`for (; i < 4; ...)`) = 27, byte-for-byte
 *      the same diff -- loop.c re-sinks the init into the preheader, so SOURCE POSITION OF
 *      THE INIT IS NOT THE DIAL.
 *  (b) the col-loop `s2 - (s1 + 8)` fold + the s1/s2 role swap (s1 = (short)startY-term,
 *      s2 = SIZE_H-term in ours; mirrored in retail).  The 3 tail insns are ALGEBRAICALLY
 *      EQUAL, not wrong: ours `(A-8)-B` vs retail `A-(B+8)` (verified by hand; there is NO
 *      semantic bug here despite the `addiu v0,s1,-8` vs `addiu v0,s1,8` diff line).
 *      FALSIFIED THIS WAVE with the new zero-insn USE fence (§2b.5), which is what finally
 *      cracked the sibling sched ties in flare.cpp: a fenced `int inset = dy + (postgame?8:0);`
 *      local inside the loop = 59 @470 (the extra allocno re-colors s0/s1); fencing the
 *      SUBEXPRESSION without a local = 41 @478 (+6 insns, the fence's own reload survives).
 *      ⇒ the fence CANNOT block this fold: cc1 splits the ternary into arms and folds the
 *      constant inside each arm BEFORE any pseudo the fence could hold exists.
 *  NEW NAMED ANGLE (untried, in priority order): the fold happens because the `+8` addend is
 *  CONSTANT in each arm.  Make it non-constant to cse/fold but free at runtime: source the 8
 *  from a value gcc cannot constant-propagate across the loop -- e.g. reuse the already-live
 *  `showtimeleft ? 0x10 : 0` term's register (`inset = dy + ((postgame?8:0))` -> `dy +
 *  (postgame ? (showtimeleft ? 8 : 8) : 0)` is still folded, but `dy + (postgame << 3)` with
 *  `postgame` the BOOL REGPARM is NOT: it is a runtime shift, so there is no constant to sink
 *  into SIZE_H).  `postgame * 8` was tried at the 49 base as `(postgame != 0) * 8` and was
 *  neutral, but that was BEFORE the minuend re-sign landed -- re-measure it here (lever-order
 *  dependence, §2b.4).  Second angle: cluster (a) is a reorg delay-slot choice, so try the
 *  fence as a REGION SPLITTER (not a value holder) between the Font_TextXY(0x4c) call and the
 *  first Hud_FBuildF4 -- the trackspec.cpp SetDefault seal this wave shows an operand-less
 *  fence moves a drain point without costing an insn.
 * ---- w46-a8: 27 STAYS.  BOTH w45 ANGLES EXECUTED AND FALSIFIED.
 *  (1) NON-CONSTANT ADDEND for the col-loop fold.  The `postgame << 3` idea does make the
 *      addend a runtime shift, and the fold does die -- but the result is WORSE, not better:
 *      `postgame << 3` 38 @471, `(int)postgame << 3` 38, `postgame * 8` 38 (all 2 insns
 *      SHORT -- killing the fold also kills the shared subterm retail keeps).  The
 *      already-0/1-provable spellings are simply neutral: `(postgame != 0) * 8` 27,
 *      `(postgame != 0) << 3` 27 -- so the w45 "re-measure it post-minuend-re-sign
 *      (lever-order)" prediction is answered: it is basin-INSENSITIVE here, 27 both times.
 *      Masked variants `-(int)postgame & 8` and `((int)postgame << 3) & 8` = 39.
 *  (2) FENCE AS A REGION SPLITTER for cluster (a) (`li $s5,1`).  An operand-less
 *      `__asm__ volatile("")` is EXACTLY NEUTRAL (27, byte-identical) at every position
 *      tried -- after Font_TextXY(0x4c), after the first Hud_FBuildF4, before it, before the
 *      `for`, and two of those together -- and so is a `"r"(startY)` fence there.  gcc-2.8
 *      drops an asm with no operands and no clobbers before reorg ever sees it, so the
 *      "operand-less fence splits a region" reading of the trackspec seal is WRONG: that
 *      fence carries `"r"(i)`, and it is the OPERAND that creates the RTL barrier insn.
 *      ⇒ any future fence in this fn must name a live value.
 *  NEW NAMED ANGLE: cluster (a) wants `li $s5,1` inside the Font_TextXY(0x4c) jal's delay
 *  slot.  That is a reorg STEAL, and the only zero-insn handle on a steal is what the fn
 *  offers reorg to steal.  Since a value-carrying fence at that point is untested (only the
 *  empty one and `startY` were), try `"r"(i)` / `"r"(col[3])` fences BETWEEN the two calls;
 *  and for cluster (b) the fold is now proven unreachable from the addend side, so attack it
 *  from the MINUEND side as the showtimeleft bar was (algebraic re-sign of the col-loop
 *  height so the ternary sits on the minuend) -- w44 measured the two subtracted terms
 *  swapped (36) but never the full re-sign that sealed the sibling expression.
 * ---- w50-a10: 24 KEPT (473/473).  The residual is now exactly THREE clusters, read off
 * side_by_side (indices are ours):
 *  (b) 216-232, the col-loop height.  Retail computes the SHARED `s1 = yoff` once (SIZE_H in
 *      a dying TEMP $v0, not a saved reg) and spends 2 insns in the postgame arm
 *      (`addiu v0,s1,8; subu v0,s2,v0`); ours keeps SIZE_H in a saved reg and spends 3
 *      (`addiu v0,s2,-8; subu v0,s0,v0; subu v0,s1,v0`) -- i.e. our current spelling sinks
 *      the +8 into POS_Y, the w45 spelling sank it into SIZE_H, and retail sinks it into
 *      NEITHER.  FALSIFIED THIS WAVE (7 more spellings, none < 24): `SIZE_H - (yoff + t)`
 *      with yoff spelled inline (27 @472), the same with a named fn-scope `int yoff` (33
 *      @474), named yoff + zero-insn opacity fence on yoff (35 @474), a fenced `int inset =
 *      yoff + t` inside the loop (59 @472), a per-arm ternary of two full subtractions (37
 *      @474 -- re-confirms the w42 measurement in the new basin), `(SIZE_H - yoff) - t` right
 *      association (33 @472), and addend-first `SIZE_H - (t + yoff)` (27 @472).
 *  (d) 304-306, the StatsTimer base: retail SELF-temps the address into its dest
 *      (`lui v1; addiu v1; addu v1,s2,v1`), ours picks a separate `t0`.  FALSIFIED: a SIZED
 *      `extern int StatsTimer_a2[2] asm("StatsTimer")` view at the variable-index site (24,
 *      neutral) and at both variable-index sites (24, neutral) -- so the §3.12 #5
 *      sized-vs-unsized declaration axis does NOT reach this scratch pick; it is a reload
 *      tie, and the two SIBLING sites in the same fn already match with `t0`.
 *  (e) 387-389, a one-slot nop/lhu/lui rotation around a beqz delay slot (ours fills the
 *      slot with the `lui`, retail nops it and issues the `lhu` first). */
/* ---- w63-a13 (2026-08-15): 24 STAYS @473/473.  A per-opcode census against the oracle
 * (scratchpad/w63a13/opcen.py) reduces the whole residual to TWO opcodes:
 *     subu 12 v 11      nop 24 v 25
 * i.e. ours spends ONE EXTRA `subu` in the col-loop's postgame arm and retail spends one
 * extra `nop` elsewhere -- exactly the cluster (b) the w44/w45/w46/w50/w60 stack has been
 * grinding, and NOTHING else.  That is worth recording because it bounds the problem
 * hard: there is no second structural defect hiding under the 24, and any lever that
 * removes our extra `subu` without disturbing the rest is a seal.
 * The arm is `SIZE_H - ((startY+0xf + (postgame?8:0)) - POS_Y)`; fold rewrites it to
 * `s0 - (POS_Y - 8)` (3 insns) while retail has `yoff + 8` then `SIZE_H - that` (2).
 * Both natural spellings fold in OPPOSITE directions and retail folded NEITHER (w60-a7),
 * so the remaining route is a fold ESCAPE, not a choice between the two folds -- the
 * catalog's FOLD-REWRITE ESCAPE row (split_tree's varsign=-1 branch: fold never re-folds
 * its own rewrite output) is the one device this receipt stack has never tried, and it is
 * the named next angle. */
/* ---- w64-a13 (2026-08-15): 24 KEPT @473/473 -- but THE CENSUS'S ONE EXTRA `subu` IS
 * SOLVED, and the residual has moved.  Repro: scratchpad/w64a13/bprobe{,2,3}.py.
 * READ THE ORACLE LOOP BODY, not just the arm: retail hoists BOTH operands above the loop
 * (`sll v0,s7,16; sra s2,v0,16` = (int)SIZE_H, and `subu s1,s0,v0` = yoff) and then writes
 * TWO COMPLETE SUBTRACTIONS -- `beqz postgame,.else / addiu v0,s1,8 / j .join /
 * subu v0,s2,v0 / .else: subu v0,s2,s1`.  So the arm is a 2-arm select over a LOOP-
 * INVARIANT (yoff, sizeH) pair, which w53 (bare ternary, 37 @474) and w60 (bare yoff
 * local, 33 @474) each measured HALF of and never together.
 *   `int yoff` + `int sizeH` hoisted above the loop + the two-arm ternary
 *   (`(postgame ? sizeH - (yoff + 8) : sizeH - yoff) - (showtimeleft ? 0x10 : 0)`)
 *   = 33 @474 and its census is `addiu 52v51  addu 68v67  nop 24v25` --
 *   **`subu` is 11v11, i.e. the ONE opcode w63 bounded the whole 24 to is GONE.**
 * The new +1 addiu/+1 addu are NAMED by side_by_side: retail computes `startY + 0xf`
 * ONCE into an int (`sll s0,s6,16; sra s0; addiu s0,s0,15` @0x800DAA4C) and passes
 * `addu a2,s0,zero` at every call AND derives yoff from that same s0; ours re-derives it
 * and stages a second copy into $s2.  ⚠️ FALSIFIED: minting that as a source local
 * (`int yplus = startY + 0xf;` at the first Hud_FBuildF4, reused at all sites) makes us
 * SHORTER, not longer -- cse over-shares it: yplus alone 38 @471, yplus + the full stack
 * 39 @470, yplus + two-arm ternary 35 @470, full stack with the showtimeleft call left
 * alone 27 @472.  So the term must stay spelled inline and the sharing must come from
 * cse, not from a variable.
 * ALSO FALSIFIED this wave (all on the kept 24 basin, the two devices the w63 note named):
 *   EMBEDDED ASSIGNMENT (catalog 14C, a MODIFY_EXPR operand blocks fold's reassociation)
 *   applied to the SHARED yoff term rather than w49's outer `inset`:
 *     `SIZE_H - ((yoff = (startY+0xf) - POS_Y) + (postgame?8:0)) - ...` 33 @474 .
 *     addend-first 33 @474 . the assignment on `(yoff = startY + 0xf)` instead 27 @472 .
 *     showtimeleft-first 44 @473 . minting yoff at the showtimeleft call site 32 @473.
 *   FOLD-REWRITE ESCAPE (split_tree varsign=-1, `(CON-VAR)+ARG1 -> (CON+ARG1)-VAR`):
 *     `SIZE_H - ((postgame?8:0) - POS_Y + (startY+0xf)) - ...` 32 @473 . the same with
 *     showtimeleft folded into the subtrahend 41 @476 . `(postgame?8:0) + (startY+0xf)
 *     - POS_Y` 24 (BIT-IDENTICAL -- fold reaches it anyway).
 * ⇒ neither device blocks the reassociation in the ONE-EXPRESSION shape; only the
 * TWO-ARM shape does, because there is no addend left to sink.  NEXT TAKER: start from
 * the two-arm + hoisted-pair basin (33 @474) and attack ONLY the `startY + 0xf` sharing
 * -- the target is retail's single int temp reused by three call sites and by yoff, with
 * NO source local (cse must mint it).  Everything else in that basin is register roles
 * (ours s1=SIZE_H/s0=yoff, retail s2=SIZE_H/s1=yoff) plus one nop/lhu rotation. */
/* ===== W71-A6 (2026-08-21): 24 -> 6 @473/473, OPCODE MULTISET NOW IDENTICAL. =====
 * TWO independent landings; clusters (d) and (e) are GONE and the whole residual is the
 * ONE fold w63-a13's census bounded it to.
 * (1) CLUSTER (d) SOLVED -- the StatsTimer base scratch pick (24 -> 15 @474).
 *     Retail SELF-temps the address into its dest (`lui v1; addiu v1; addu v1,s2,v1`),
 *     ours picked a separate `t0`.  w50-a10 falsified the §3.12 #5 sized-vs-unsized
 *     DECLARATION axis here and filed it as a reload tie -- that verdict is REFUTED by
 *     the ACCESS-SPELLING axis it never tried.  Write the guard's load as an explicit
 *     index-term-first byte address:
 *         *(int *)((player << 2) + (int)&StatsTimer)     [both guard sites]
 *     instead of `StatsTimer_arr[player]`.  Same lever as W71-A6's psxcontroller
 *     InGame_GetPSXPadValue landing (methodology 3.12-fusion / W60-A6 Hud_BuildNumbers0):
 *     the SHIFT spelling keeps fold from rebuilding an ARRAY_REF, and the address then
 *     materializes into its own dest.  MEASURED: `(&StatsTimer)[player]` 17 @474 .
 *     `player * 4 + (int)&StatsTimer` 17 @474 (the MULT form is folded back) .
 *     `(int)&StatsTimer + (player << 2)` 15 @474 (bit-identical to index-first --
 *     fold canonicalizes the operand order, so it is MULT-vs-SHIFT that is the dial) .
 *     `(player << 2) + (int)StatsTimer_arr` 24 (neutral -- the array VIEW re-folds) .
 *     per-site: site0 alone 18 @473, site1 alone 21 @474, BOTH 15 @474.
 * (2) CLUSTER (b) 15 -> 6, and the s1/s2 ROLE SWAP IS SOLVED -- hoist the MINUEND.
 *     `int sizeH = HUD_STATS_SIZE_H;` as a statement before the loop, plus the SINK
 *     spelling of the subtrahend (`sizeH - ((startY+0xf) - POS_Y + (postgame?8:0))`).
 *     The two halves are NOT separable and neither had been measured together:
 *     the sink spelling alone is 18 @473 (w50 measured it as `SIZE_H - (yoff + t)` 27),
 *     the sizeH local alone was only ever probed inside the two-arm shape (24 @475),
 *     TOGETHER they are 6 @473 with `sra s2` (sizeH) emitted BEFORE `subu s1,s0,v0`
 *     (yoff) exactly like retail -- i.e. the "which operand does gcc expand first"
 *     question the whole w44..w64 stack read as an allocator tie is decided by WHICH
 *     operand is a plain pseudo.  yoff must stay INLINE (a `yoff` local re-enters the
 *     +1 addiu/+1 addu `startY+0xf` basin: 24 @475).
 * RESIDUAL 6 @473, opcode multiset IDENTICAL to the oracle -- purely the fold direction
 * in the postgame arm: ours `addiu v0,s2,-8; subu v0,v0,s1` = `(sizeH - 8) - yoff`,
 * retail `addiu v0,s1,8; subu v0,s2,v0` = `sizeH - (yoff + 8)`.  Register ROLES now
 * match retail (s1 = yoff, s2 = sizeH), so this is the LAST fact in the function.
 * FALSIFIED FROM THE 6 BASIN (all re-gated here; every one either 6 bit-identical or
 * worse): `(postgame != 0) << 3` and `(postgame != 0) * 8` addends 6 (bit-identical --
 * postgame is a bool so gcc rebuilds the same COND_EXPR) . addend-first 6 . no inner
 * parens 6 . unary-minus re-sign `-(yoff + t - sizeH)` 6 . `(int)` casts 6 .
 * `- (postgame ? -8 : 0)` 6 . two-arm ternary 28 @475 . ternary-over-the-subtrahend
 * 28 @475 . both-arms-PLUS `postgame ? yoff+8 : yoff+0` 28 @475 . the w49 in-paren
 * spelling 17 @474 . `sizeH - yoff - (postgame?8:0)` 24 . 14C embedded assignment on
 * the OUTER addend 25 @472 and on sizeH 6 (bit-identical) . opacity fence on sizeH
 * outside the loop 16 @473 / inside it 14 @473 / on a yoff local 51 @476 .
 * fold-escape `(postgame?8:0) - POS_Y + (startY+0xf)` 23 @474 . showtimeleft-term-first
 * 27 @472 . hoisting `startY = startY + 0xf;` ABOVE the first Hud_FBuildF4 (so all three
 * call sites read plain `startY`, semantically identical, and retail's in-place
 * `addiu s0,s0,15` mints) 23 @470 -- 3 insns SHORT, and it makes every two-arm variant
 * much worse (51 @470).
 * NEXT TAKER: the target is a fold ESCAPE for `A - (B + CST)` that keeps BOTH the
 * constant and the two-insn shape.  gcc-2.8 fold distributes the outer MINUS over the
 * `postgame ? 8 : 0` COND_EXPR FIRST (both arms constant) and only then reassociates
 * `A - (B + 8)` into `(A - 8) - B`; so the device must make ONE arm of the ternary
 * non-constant WITHOUT costing an `addu` in that arm -- e.g. a second constant local
 * whose value cse cannot prove (the fenced NAMED-CONSTANT dial, catalog 09G) used as
 * the `8`.  Sibling: RaceStatistics' per-player bar height carries the IDENTICAL fold
 * (`barH - (yoff + 0x13)` -> `(barH - 19) - yoff`, sbs lines 163-174), so a cure here
 * transfers there. */
/* HIDDEN-PHANTOM FIX (w14-a2): oracle mangles __Fsb (short,bool) -- 2nd param was `int`, mangling
 * __Fsi, a NAME MISMATCH invisible to the gate (same class as the AudioCmn_GetAsyncSfx precedent).
 * SYM confirms `class ARG type BOOL name postgame`. */
void Hud_BTCStats(short player,bool postgame)

{
  short i;
  short col [4];
  short startY;
  char string [40];
  bool chasinghuman;
  bool showname;
  short PLAYERWIDTH;
  bool showtimeleft;
  short HUD_STATS_POS_X;
  short HUD_STATS_SIZE_W;
  short HUD_STATS_SIZE_H;
  short HUD_STATS_POS_Y;
  short HUD_STATS_TEXT_START_X;
  short HUD_STATS_TITLE_START_X;
  short HUD_STATS_TITLE_START_Y;
  short HUD_STATS_TEXT_START_Y;
  int sizeH;

  chasinghuman = 0;
  showname = 0;
  if (1 < Cars_gNumHumanRaceCars) {
    if ((Cars_gHumanRaceCarList[1 - player]->carFlags & 0x200U) == 0) {
      chasinghuman = 1;
    }
    else {
      showname = 1;
    }
  }
  PLAYERWIDTH = 0xe7;
  if (chasinghuman) {
    PLAYERWIDTH = 0xa1;
  }
  showtimeleft = 0;
  /* the oracle indexes row `player` and element `Hud_NextPerp[player] - 1`
     (`addiu $v1,$v1,-1` @0x800DA810, no -1 on the row). */
  if ((postgame == 0) || (BTCPerpInfo[player][Hud_NextPerp[player] - 1].caught != 0)) {
    showtimeleft = 1;
  }
  HUD_STATS_SIZE_W = PLAYERWIDTH + 6;
  /* w40-a4: the oracle builds POS_X directly as `0xa0 - (PLAYERWIDTH>>1)` (`li $s5,0xA0`
     CSE'd with the TITLE_START_X centring below, then `subu $s1,$s5,$v0` @0x800DA87C) and
     derives TEXT_START_X from it (`addiu $s2,$s1,0x7`).  The old `-(PW>>1)` + `+0xa0`
     spelling was numerically equal but cost a `negu` and re-based every column constant. */
  HUD_STATS_POS_X = 0xa0 - (PLAYERWIDTH >> 1);
  HUD_STATS_SIZE_H = (Hud_NextPerp[player] + 1) * 0xc + 0x16;
  if (showtimeleft) {
    HUD_STATS_SIZE_H = (Hud_NextPerp[player] + 1) * 0xc + 0x22;
  }
  if (postgame) {
    HUD_STATS_SIZE_H = HUD_STATS_SIZE_H + 8;
  }
  if (showname) {
    HUD_STATS_SIZE_H = HUD_STATS_SIZE_H + 0xc;
  }
  HUD_STATS_POS_Y = 0x78 - (HUD_STATS_SIZE_H >> 1);
  HUD_STATS_TEXT_START_X = HUD_STATS_POS_X + 7;
  HUD_STATS_TITLE_START_X = 0xa0 - (textpixels(TextSys_Word(postgame ? 0x48 : 0x47)) >> 1);
  HUD_STATS_TITLE_START_Y = 0x76 - (HUD_STATS_SIZE_H >> 1);
  HUD_STATS_TEXT_START_Y = HUD_STATS_TITLE_START_Y + 0xf;
  col[0] = HUD_STATS_POS_X + 3;
  col[1] = HUD_STATS_TEXT_START_X + (chasinghuman ? 0xc : 0xf);
  col[2] = HUD_STATS_TEXT_START_X + (chasinghuman ? 0xc : 0x50);
  col[3] = HUD_STATS_TEXT_START_X + (chasinghuman ? 0x50 : 0x96);
  startY = HUD_STATS_TEXT_START_Y;
  Font_TextColor(6);
  Font_TextXY(TextSys_Word(postgame ? 0x48 : 0x47),HUD_STATS_TITLE_START_X,HUD_STATS_TITLE_START_Y);
  if (showname) {
    Font_TextColor(4);
    Font_TextXY(Cars_gRaceCarList[player]->carInfo->driver,col[2],startY);
    startY = startY + 0xc;
  }
  Font_TextColor(3);
  if (!chasinghuman) {
    Font_TextXY(TextSys_Word(0x4a),col[1],startY);
  }
  Font_TextXY(TextSys_Word(0x4b),col[2],startY);
  Font_TextXY(TextSys_Word(0x4c),col[3],startY);
  Hud_FBuildF4(0,HUD_STATS_POS_X,startY + 0xf,HUD_STATS_SIZE_W,1,0,'\0','\0');
  /* w40-a4 CORRECTNESS: the vertical rules run i = 1..3 (`li $s5,1` in the jal delay slot
     @0x800DAA34, loop `slti $v0,$v0,4`), NOT 0..3 -- col[0] gets no rule.  And the height is
     SIZE_H minus the bar inset, not a flat SIZE_H-8: oracle @0x800DAAAC picks
     `s2 - (s1 + 8)` under postgame vs `s2 - s1`, then `-0x10` under showtimeleft, with
     s2 = (int)SIZE_H and s1 = y - POS_Y. */
  /* MATCH (w49-a10, 27 -> 24 diffs and count-EXACT 473/473): the postgame inset is
   * added to `startY + 0xf` INSIDE the parenthesis, before POS_Y is subtracted --
   * `SIZE_H - ((startY + 0xf + (postgame ? 8 : 0)) - POS_Y)`.  Adding it to the
   * already-hoisted yoff instead (`SIZE_H - (yoff + (postgame ? 8 : 0))`) lets combine
   * reassociate the postgame arm into `(SIZE_H - 8) - yoff` (`addiu v0,s1,-8` vs
   * retail's `addiu v0,s1,8; subu v0,s2,v0`), which also SWAPS the s1/s2 homes of
   * SIZE_H and yoff and leaves the function one instruction short.
   * w53-a3 RE-PROBE of the SAME residual in this basin (kept at 24 / 473-exact).  The
   * residual really is only the ARM-1 shape -- retail reuses the already-computed
   * `yoff = s0 - B` and adds 8 (`addiu $v0,$s1,8; subu $v0,$s2,$v0`), we recompute
   * `s0 - (B - 8)` (`addiu $v0,$s2,-8; subu $v0,$s0,$v0`), which drags an s1/s2 swap of
   * SIZE_H vs yoff through the whole tail.  BOTH catalog shapes for "write the select as
   * two full arms" were measured and BOTH are worse: an explicit `if (postgame) ruleH =
   * ...; else ruleH = ...; if (showtimeleft) ruleH -= 0x10;` block-local funnel = 63 diffs
   * AND one insn SHORT (472); an outer ternary over the two complete subtractions
   * (`(postgame ? SIZE_H - (yoff+8) : SIZE_H - yoff) - (showtimeleft ? 0x10 : 0)`) = 37 at
   * 474 (one insn LONG).  So the ternary-as-two-calls / two-arm lever does NOT transfer to
   * a value select feeding a call ARGUMENT here; the in-parenthesis spelling stays.
   * W55-A16 re-probe (kept at 24 / 473-exact).  allocsim replicates this fn's global
   * handout 57/57 EXACTLY, so the s1/s2/s3 rotation is NOT a global-allocno tie you can
   * dial with reqdelta -- it is downstream of the ARM-1 expression shape, exactly as
   * w49/w53 concluded.  NEW falsification of the one device w49 did not try: an OPACITY
   * fence on the hoisted inset (`int yoff = (startY+0xf) - POS_Y; int inset = yoff +
   * (postgame ? 8 : 0); __asm__("" : "=r"(inset) : "0"(inset));` then `SIZE_H - inset`),
   * i.e. the w47 identity-fence used precisely to stop combine reassociating
   * `SIZE_H - (yoff+8)` into `(SIZE_H-8) - yoff` -- 81 diffs at 472 (one insn SHORT), the
   * fence recolours the whole prologue chain (s0->s1 on the POS_X/`sh 96(sp)` web).  The
   * reassociation blocker is therefore not reachable with a tied-operand fence either.
   * ---- w60-a7 (2026-08-14): 24 STAYS, count-exact 473/473.  THIRTEEN more spellings of
   * the ARM-1 expression, none better, and the fold now has a NAME in both directions:
   * `(A + 8) - B` folds to `A - (B - 8)` (ours: `addiu v0,s2,-8; subu v0,s0,v0`) while
   * `SIZE_H - (yoff + 8)` folds the other way to `(SIZE_H - 8) - yoff` -- retail folded
   * NEITHER (`addiu v0,s1,8; subu v0,s2,v0`), so the target is a form fold cannot touch
   * at all, not a choice between the two folds.  MEASURED (all this basin):
   *   yoff spelled as its own parenthesised subexpression `(((startY+0xf) - POS_Y) +
   *   (postgame?8:0))` 27 @472 . the same with `(int)` casts on SIZE_H/POS_Y 27 @472 .
   *   `(int)POS_Y` alone 24 (bit-identical) . an extra inner paren on `(startY+0xf)` 24
   *   (bit-identical) . `inset` as its own statement inside the loop 59 @470 . the same
   *   with an `if (postgame) inset += 8;` instead of the ternary 81 @472 . subtracting
   *   the 8 as a separate term `- (postgame?8:0)` 33 @472 . a `yoff` local hoisted above
   *   the loop 33 @474 . that plus an `inset` statement 59 @472 . the ternary moved to
   *   cover the WHOLE subtrahend (`SIZE_H - (postgame ? yoff+8 : yoff)`) 37 @474, and its
   *   `8 + yoff` variant 37 @474 . the showtimeleft term written first 39 @474 .
   *   `startY + 0xf` hoisted into a local 26 @473.
   * Note the count tell: every spelling that reaches the retail SHAPE loses or gains an
   * instruction (472/474), i.e. the fold is what keeps us count-exact.  NEXT ANGLE
   * (named, untried): retail's `yoff` is a cse temp shared with the LATER showtimeleft
   * call at line ~779, which spells `(startY + 0xf - HUD_STATS_POS_Y)` literally -- so
   * the dial may be that SECOND call site's spelling (make cse mint yoff THERE first),
   * not this one's; and per the w44 ternary-fold boundary the only other route is to
   * make the addend non-constant, which here would delete retail's own `beqz`. */
  /* MATCH (W71-A6): `sizeH` is the HOISTED MINUEND -- do NOT inline it back into the
     expression below.  Making the minuend a plain pseudo is what makes gcc expand it
     BEFORE the subtrahend, which is what gives retail's s1=yoff / s2=sizeH roles.
     Pairs with the SINK spelling of the subtrahend below; neither works alone. */
  sizeH = HUD_STATS_SIZE_H;
  for (i = 1; i < 4; i = i + 1) {
    Hud_FBuildF4(0,col[i] - 2,startY + 0xf,1,
                 sizeH - (((startY + 0xf) - HUD_STATS_POS_Y) + (postgame ? 8 : 0)) -
                 (showtimeleft ? 0x10 : 0),0,'\0','\0');
  }
  if (showtimeleft) {
    Hud_FBuildF4(0,HUD_STATS_POS_X,
                 (startY + 0xf + HUD_STATS_SIZE_H - (postgame ? 8 : 0)) -
                 (startY + 0xf - HUD_STATS_POS_Y) - 0x10,HUD_STATS_SIZE_W,1,0,'\0','\0');
  }
  /* in-place `startY += 0xf` (`addiu $a0,$s6,0xF; addu $s6,$a0,$zero` @0x800DAB9C) -- there is
     no separate dataY local (SYM lists only i/col/startY/string/chasinghuman/showname/
     PLAYERWIDTH/showtimeleft/HUD_STATS_*). */
  startY = startY + 0xf;
  /* MATCH (W71-A6): both StatsTimer guards are spelled as an INDEX-TERM-FIRST byte
     address (`(player << 2) + (int)&StatsTimer`) and NOT as `StatsTimer_arr[player]`.
     The `<<` keeps fold from rebuilding an ARRAY_REF, which is what makes gcc
     self-temp the address into its own dest like retail (`lui v1; addiu v1;
     addu v1,s2,v1`) instead of picking a separate `t0` scratch.  The MULT spelling
     `player * 4 + ...` folds back and loses it. */
  for (i = 0; i < Hud_NextPerp[player]; i = i + 1) {
    if (*(int *)((player << 2) + (int)&StatsTimer) > (int)i * 2 + 4) {
      Font_TextColor(4);
      sprintf(string,"%d",(int)i + 1);
      Font_TextXY(string,col[0],startY + (int)i * 0xc);
      if (!chasinghuman) {
        sprintf(string,"%s",BTCPerpInfo[player][i].name);
        Font_TextXY(string,col[1],startY + (int)i * 0xc);
      }
      Hud_ParseTime(BTCPerpInfo[player][i].time,string);
      Font_TextXY(string,col[2],startY + (int)i * 0xc);
      Font_TextXY(TextSys_Word(BTCPerpInfo[player][i].caught != 0 ? 0x3d : 0x49),col[3],
                  startY + (int)i * 0xc);
    }
  }
  if (showtimeleft && (*(int *)((player << 2) + (int)&StatsTimer) > (int)i * 2 + 4)) {
    Font_TextColor(3);
    Hud_ParseTime(FinalBTC_Countdown,string);
    Font_TextXY(TextSys_Word(0x4d),col[0],startY + (int)i * 0xc + 2);
    /* oracle selects the COLUMN (`lh $a1,0x26(sp)` vs `lh $a1,0x24(sp)` @0x800DADC0), it does
       not overwrite col[2] with col[3]. */
    Font_TextXY(string,chasinghuman ? col[3] : col[2],startY + (int)i * 0xc + 2);
  }
  if (postgame) {
    OptionsBarThing(HUD_STATS_POS_X,HUD_STATS_POS_Y,HUD_STATS_SIZE_W,HUD_STATS_SIZE_H);
  }
  Hud_RenderPauseBox(HUD_STATS_POS_X,HUD_STATS_POS_Y,HUD_STATS_SIZE_W,HUD_STATS_SIZE_H);
  return;
}

/* ---- Hud_RenderStatsView__Fv  [OVERLAYS.CPP:450-507] SLD-VERIFIED ---- */
/* w42-a4: 23 -> 8 diffs, insn count now EXACT 139/139.  ONE lever, and it cracked BOTH
 * w41 clusters at once -- the PER-ELEMENT SPLAT DATA-LABEL alias (catalog w41 SS D):
 * declaring `extern Car_tObj *D_8010FA4C;` (= Cars_gHumanRaceCarList[1], a real splat
 * label in asm/data/data_8010CCD4.data.s) and reading it at the .L800DAF88 join instead
 * of `Cars_gHumanRaceCarList[1]`.
 *   WHY it works (the mechanism, worth reusing): the .L800DAF30 edge into that join is
 * `beqz (list[1]->carFlags & 0x200)` and the join's OWN first test was the identical
 * expression, so jump.c THREADED that edge past the join -- leaving .L800DAF88 with a
 * single (fall-through) predecessor, on which cse had already recorded commMode==1 and
 * therefore DELETED the commMode re-test (the whole 4-insn `bne` deficit a10's census
 * flagged).  Retail's element read is a self-temp `lui/%lo(D_8010FA4C)` load that gcc
 * cannot equate with the base+4 form, so the edge is NOT threaded, the block stays a
 * 2-predecessor join, cse_basic_block restarts, and the test survives.  The alias fixes
 * the address FORM and the missing arm with one edit -- it is a CFG lever, not a reloc
 * cosmetic.  (Applying the same alias to the screen!=0 branch's list[1] read REGRESSES
 * 8 -> 15 / 140 insns; it is site-specific.  Sizing the extern [9] measured NEUTRAL.)
 * w44-a9: 8 -> PASS (139/139).  The residual was two copies of ONE scheduling pick --
 * retail fills the `lw %lo(Cars_gHumanRaceCarList[k])` load-delay slot with the clamped
 * timer store and pays the nop after `lw 0x260(carFlags)`; ours emitted BOTH loads first
 * and the store last.  MECHANISM (gcc-2.8 alias.c `fixed_scalar_and_varying_struct_p`):
 * a store to a plain global SCALAR is a FIXED-address, !MEM_IN_STRUCT_P ref, which that
 * heuristic declares NOT to conflict with a VARYING-address STRUCT load -- so sched was
 * free to sink it below `car->carFlags`.  Storing through a SIZED asm-label array VIEW
 * (`extern int StatsTimer_v1[1] asm("StatsTimer");`, see the top of this TU) makes the
 * store an ARRAY_REF -> MEM_IN_STRUCT_P set -> the heuristic no longer applies -> the
 * carFlags load stays BELOW the store, while the constant-index element load
 * `Cars_gHumanRaceCarList[0]` (fixed address, provably different decl) still hoists ABOVE
 * it = retail's exact lw/sw/lw/nop.
 * ⚠️ SIZING IS LOAD-BEARING: the pre-existing UNSIZED `StatsTimer_arr[]` view loses the
 * gp-rel store (140 insns / 27 diffs); `[1]` keeps it.  Also falsified at the 8 base: the
 * in-place clamp `if (10000 < StatsTimer) StatsTimer = 10000;` (140 insns / 15 diffs) and
 * a `Car_tObj *car = Cars_gHumanRaceCarList[k];` pointer local (8, neutral -- coalesced).
 * REUSABLE LEVER: the sized asm-label array view is the general "make a scalar-global
 * store ALIAS a pointer-based struct load" instrument -- the mirror image of the w43
 * pointer-local-defeats-true_dependence row, which un-aliases in the other direction. */
void Hud_RenderStatsView(void)

{
  int screen;
  int t;

  screen = simGlobal.gameTicks >> 9 & 1;
  /* Block order + branch polarity transcribed from the oracle CFG (0x800DAE94..0x800DAFE8):
     the flags!=0 arm is the if-BODY (oracle `beqz` skips to the ==0 block), the shared
     screen=0 block sits EARLY at .L800DAED0, and the "one player" tail (.L800DAFE4)
     falls out of the numRaceCars test at .L800DAFD0. */
  if ((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) != 0) {
    if (GameSetup_gData.commMode == 1) goto HudStats_common;
HudStats_setUserZero:
    screen = 0;
    goto HudStats_finalize;
  }
  if (GameSetup_gData.commMode != 1) goto HudStats_checkNumCars;
HudStats_common:
  if ((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) != 0) {
    if ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) != 0) goto HudStats_check200B;
    goto HudStats_setUserZero;
  }
  if ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0) goto HudStats_secondCar;
HudStats_check200B:
  if ((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0) goto HudStats_setUserOne;
  if (Hud_NextPerp[0] != 0) goto HudStats_setUserZero;
  if (GameSetup_gData.commMode != 1) goto HudStats_setUserZero;
HudStats_secondCar:
  if ((D_8010FA4C->carFlags & 0x200U) == 0) goto HudStats_finalize;
  if (GameSetup_gData.commMode != 1) goto HudStats_finalize;
  if (Hud_NextPerp[1] == 0) goto HudStats_finalize;
  screen = 1;
  goto HudStats_finalize;
HudStats_checkNumCars:
  if (Cars_gNumRaceCars != 1) goto HudStats_finalize;
HudStats_setUserOne:
  screen = 1;
HudStats_finalize:
  if (screen == 0) {
    D_8013D99C = 0;
    /* the oracle keeps the incremented value in its own pseudo and stores it BOTH
       before and after the clamp (`addu $v1,$v0,$zero` / two `sw $v1,%gp_rel(...)`). */
    StatsTimer = StatsTimer + 1;
    t = StatsTimer;
    if (10000 < t) {
      t = 10000;
    }
    StatsTimer_v1[0] = t;
    if ((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0) {
      RaceSummary();
    }
    else {
      /* w40-a4: there is no `player` local (SYM lists only `screen`); the two
         Hud_BTCStats(0/1,true) call sites CROSS-JUMP into the single shared
         `jal` @0x800DB090 with $a0 set per arm. */
      Hud_BTCStats(0,true);
    }
  }
  else {
    StatsTimer = 0;
    D_8013D99C = D_8013D99C + 1;
    t = D_8013D99C;
    if (10000 < t) {
      t = 10000;
    }
    D_8013D99C_v1[0] = t;
    if ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0) {
      RaceStatistics();
    }
    else if (GameSetup_gData.commMode == 1) {
      Hud_BTCStats(1,true);
    }
    else {
      RaceStatistics();
    }
  }
  return;
}

/* end of overlays.cpp */
