/* frontend/screens/screenpost.cpp -- RECONSTRUCTED (tournament-standings screens + DrawMoney; C++ TU)
 *   3 classes (tScreenTournamentStandings -> 3item -> PinkSlipStandings) + free DrawMoney; 13 fns.
 */
#include "screenpost.h"

/* The Initialize SLD puts the complete max/max/divide expansion on source line
 * 118 and records only tInfo.  Keep its two evaluation carriers macro-private;
 * the original macro spelling is not recoverable. */
#define SCREENPOST_SET_COUNT_SPEED(self,tInfo) {          \
  int max_money;                                         \
  int max_damage;                                        \
  max_money = (self)->moneyBonus;                        \
  (self)->fStartCountdownNOW = 0;                        \
  if (max_money < (tInfo).fMoney) {                      \
    max_money = (tInfo).fMoney;                          \
  }                                                      \
  max_damage = (self)->moneyDamage;                      \
  if (max_damage < max_money) {                          \
    max_damage = max_money;                              \
  }                                                      \
  (self)->fCountSpeed = max_damage / 0x18;               \
}


/* ---- (free)::DrawMoney  [SCREENPOST.CPP:47-75] ---- */

/* Decoded Phase 84: DrawMoney(int x, int y, int z, long amount, int, int) - render currency display($XX,XXX) (312 B, 11 callers - hot). Used in garage, dealer, postgame screens.
   
   [ghidra-meta] section: front.text */

void DrawMoney(int x,int y,int numplaces,long number,int colfore,int colback)

{
  char string1 [50];
  char string2 [50];
  
  switch (numplaces) {
  case 3:
    sprintf(string1,TextSys_Word(0x86),0);
    break;
  case 6:
    sprintf(string1,TextSys_Word(0x87),0,0);
    break;
  case 9:
    sprintf(string1,TextSys_Word(0x88),0,0,0);
    break;
  }
  FeTools_FormatMoney(string2,number);
  FETextRender_FullTextRGB(string2,(short)x,(short)y,colfore,'\0',1);
  FETextRender_FullTextRGB(string1,(short)x,(short)y,colback,'\0',1);
  return;
}



/* ---- tScreenTournamentStandings::ctor  [SCREENPOST.CPP:80-81] ---- */
tScreenTournamentStandings::tScreenTournamentStandings()
  /* base subobject _base_tScreen is constructed implicitly by g++ -> jal __7tScreen */
{

  this->_vf = (__vtbl_ptr_type (*)[10])tScreenTournamentStandings_vtable;
  this->fDrawMoney = 0;
  return;
}



/* ---- tScreenTournamentStandings::Initialize  [SCREENPOST.CPP:85-120] ---- */
void tScreenTournamentStandings::Initialize()

{
  tAwardInformation tInfo;
  
  this->tScreen::Initialize();
  tournamentManager.GetAwardInformation(tInfo);
  this->gotmoney = 0;
  this->gotbonus = 0;
  this->gotbilled = 0;
  if (this->fDrawMoney != 0) {
    if (tInfo.fMoney != 0) {
      this->gotmoney = 1;
    }
    this->moneyFinal = tournamentManager.fMoney - tInfo.fTournMoney;
    if (tInfo.fCompletedGarageFull != 0) {
      this->moneyFinal -= tInfo.fCompletedBonusMoney;
    }
    this->moneyAwarded = tInfo.fMoney;
    tournamentManager.CalcTrackFinishDamageBill(false,this->moneyDamage,this->moneyBonus);
    if (0 < this->moneyBonus) {
      this->gotbonus = 1;
    }
    if (0 < this->moneyDamage) {
      this->gotbilled = 1;
    }
    this->fCountedDown = 0;
    if (((this->moneyBonus == 0) && (this->moneyDamage == 0)) && (this->moneyAwarded == 0)) {
      this->fCountedDown = 1;
    }
    SCREENPOST_SET_COUNT_SPEED(this,tInfo);
  }
  else {
    this->moneyFinal = tournamentManager.fMoney - tInfo.fTournMoney;
  }
  this->starttick = ticks[0];
  return;
}



/* ---- tScreenTournamentStandings::Cleanup  [SCREENPOST.CPP:124-129] ---- */
void tScreenTournamentStandings::Cleanup()

{
  this->fDrawMoney = 0;
  this->tScreen::Cleanup();
  return;
}



/* ---- tScreenTournamentStandings::GetShapeInfo  [SCREENPOST.CPP:133-137] ---- */
void tScreenTournamentStandings::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  numSwapShapes = 0;
  *swapFileName = (char *)0x0;
  numPermShapes = 0x29;
  *permFileName = "zTrnSt1";
  return;
}



/* ---- tScreenTournamentStandings3item::GetShapeInfo  [SCREENPOST.CPP:142-146] ---- */
void tScreenTournamentStandings3item::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  numSwapShapes = 0;
  *swapFileName = (char *)0x0;
  numPermShapes = 0x29;
  *permFileName = "zTrnStd";
  return;
}



/* ---- tScreenTournamentStandings::ProcessInput  [SCREENPOST.CPP:152-158] ---- */
void tScreenTournamentStandings::ProcessInput(tPlayer,tInputKeyType &keyval,
              tMenuCommand &)

{
  if (keyval != kInput_KeyType_Cross) {
    return;
  }
  if (this->fCountedDown == 0) {
    keyval = kInput_KeyType_AlreadyProcessed;
    this->fStartCountdownNOW = 1;
  }
  return;
}



/* MATCH W61-A17 (127 -> 95 diffs, 556/561 insns), continued to 56/559:
   (1) THE LOOP-ROTATION CURE IS A BLOCK-SCOPE DECLARATION.  Retail's racer
   loop is UN-rotated: a top test that re-loads the spilled bound
   (`lw t1,196(sp); nop; slt v0,s4,t1; beqz` at SLD:183) with an unconditional
   `j` back at SLD:224.  Ours was rotated (specialised entry guard `blez v0`
   plus a bottom test) because jump.c:620 duplicate_loop_exit_test fired.  The
   SYM 8c block lists `p` as a BLOCK-scope AUTO (Block start line = 20), not a
   function-scope local; moving `short p;` into the loop body plants the
   NOTE_INSN_BLOCK_BEG/END that jump.c:2296 refuses to duplicate, and the loop
   head became byte-identical (-19 diffs).
   FALSIFIED (none of these change the rotation): a real
   `for (i = 0, line = 0x2fe; i < numRacers; i++, line++)` 115; `while
   (i < numRacers)` 114; `for (; i < numRacers; )` 114; `for (;; i++, line++)`
   with the break 115.
   (2) The tier/tournament iterator select is TWO TextValue calls that gcc
   tail-merges -- retail duplicates `li a1,-1` per arm and adds the offset into
   a0 IN PLACE -- not one call on a ternary-selected pointer (-13).
   FALSIFIED on the 95 base (pre-rotation price in parentheses): `one` -> plain
   literals 180 (212); the three DrawShapeExtended fade args re-reading
   `self->fScreenFadeVal` 190 (214) even though retail does exactly that
   (`lh v0,92(s7)` before each call); lbx as ((w>>1)-2)-centerx 99 (131);
   E3+E4 194; E2+E3+E4 277; `line` replaced by the giv `0x2fe + i` 163 -- the
   sealed TU-mate tScreenPinkSlipStandings' row-giv law does NOT transfer here.
   FRAME CENSUS: our sp-offset multiset is ALREADY identical to retail's (20
   slots incl. the 196/200 spill pair), so the W61-A1 declaration-order spill
   law does not apply to this function.
   CONTINUATION: SLD 234/235 requires the TextValue result and +19 as two
   statements; a separate halfWidth local gives retail's subtraction order;
   removing the manager alias and sharing only the branch-selected driver name
   gives retail's single renderer call.  Retail's three shape calls then really
   do reload fScreenFadeVal.  Two zero-byte input-only pricing fences recover
   the SYM saved-register order after those source corrections: the loop fence
   prices fade/state/line, and the post-TextValue line use keeps i/state/line/
   this in s4/s5/s6/s7.  Together these authoritative changes cut 95 -> 56.
   RESIDUAL: (a) the textType constant 11 lands in t1 for retail and v0/v1 for
   us at five call sites (local-alloc numeric scan); (b) an s4/s5 rotation around
   the ticks[0] address and late constant one; (c) one duplicate manager-base
   copy in the prologue.  FALSIFIED at 56: named definition pointer is neutral;
   an input-priced textType local is 57/558; plain money literals are 217/548.
   ==== W71-A18 (2026-08-21): 56 -> 35 (562/561).  THE `one` LOCAL IS RETIRED. ====
   The W61 "plain money literals 180 (212)" falsification was BASIN-RELATIVE and
   is now dead: re-measured from the 56 basin, spelling ALL SIX of the three
   money rows' trailing args as plain `1` literals (`self->gotmoney ? 1 : 0, 1`)
   gates 35, and the (b) s4/s5-rotation half of the residual goes with it --
   retail keeps a cse-shared `1` in $s4 for the justify args AND materializes a
   FRESH `li v0,1` for each ternary arm, which only the literal spelling
   produces (the named `one` local makes both uses one pseudo, so ours passed
   $s4 for both).  Splitting the two roles was measured: literal ternary + named
   justify 67, named ternary + literal justify 61, both literal 35.
   RESIDUAL 35 = (a) the textType constant `11` in $v0/$v1 vs retail's $t1 at
   six call sites, plus (c) the +1 prologue `addiu v0,t1,0` (a SECOND
   `%lo(tournamentManager)` lo_sum off the shared `%hi`; retail reuses one base
   for the 4/24/8/16 field reads).  (a) is a local-alloc numeric-scan question:
   retail's shared `2` (state AND justify at the same call) is born BEFORE the
   textType constant and holds $v0 across both stores, so the 11 scans on to
   $t1; ours serializes (li 11, sw, li 2, sw) and reuses $v0.  (c) is NOT
   source-shapeable: re-gated neutral at 35 are a `tTournamentManager *tm`
   alias for every pre-loop field read, a hoisted `fDefinition` pointer, a
   hoisted `fTier`, an index temp, and hoisting the `fNumRacers` read to be the
   FIRST manager access; operand-order variants are worse (tier-last 39,
   fTournament-first 49).  Route for both halves: the local-alloc QTY
   instrument (methodology 4.6) -- neither is an allocno-table question.
   Harness: scratchpad/A18/post_v{1,2,3,4}.json + probe.py.
   ==== W72-A7 (2026-08-22): 35 -> 4, count 562 -> 561 EXACT. ====
    (1) 🔑 35 -> 3: THE textType CONSTANT IS A NAMED LOCAL, exactly as the
        sealed TU-mate tScreenPinkSlipStandings::DrawBackground already spells
        it (`tMenuTextType type; type = textType_TrackRecords;`).  One pseudo
        with a live range spanning all nine uses keeps $v0/$v1 occupied at each
        call, so the rematerialised `li` scans on to retail's $t1 -- ALL SIX
        textType sites fall together.  The W61 falsification ("an input-priced
        textType local is 57/558") was BASIN-RELATIVE and is now dead: from the
        35 basin the plain named local gates 3.  Using it at only the six
        post-loop sites gates the same 3, so the whole-function spelling (the
        sibling's) is the one kept.  LAW: when a TU-mate with the same shape is
        already sealed, COPY ITS LOCAL SET before hunting allocator levers.
    (2) 3 -> 4 with the COUNT going 562 -> 561: the duplicate
        `%lo(tournamentManager)` lo_sum (`addiu v0,t1,0` -- objdump proves BOTH
        addends are 0, i.e. a genuinely redundant second LO_SUM off the shared
        HI) dies when the manager is reached through a reference bound BEFORE
        any other statement: `tTournamentManager &tm = tournamentManager;`.
        POSITION IS THE WHOLE LEVER -- binding/assigning it as the FIRST thing
        in the body gives one lo_sum (561); the identical alias assigned even
        ONE statement later (after `self = this;`) gives two again (562).
        Pointer (`*tm`) and reference spellings are equivalent (both 4).
        Extending the alias into the loop body is WORSE (15 @562): retail
        rematerialises the manager address for `PlayerRanking`/`fCompetitors`/
        `TournPointTotal`, so ONLY the pre-loop reads share a base.
    (3) the alias re-shuffled global-alloc and swapped `self`/`line` between
        $s6/$s7 body-wide (78 diffs, all one swap).  A THIRD `"r"(line)` in the
        loop pricing fence restores retail's `self`=$s7 / `line`=$s6 -> 4.
        Fence-operand variants that did NOTHING (all exactly 78): adding
        `"r"(self)` anywhere in either fence, dropping the post-loop fence,
        `"r"(tm)`, and every declaration-order permutation of `self`/`line`.
   RESIDUAL 4 = PROLOGUE EMISSION ORDER ONLY.  Same six insns, different order:
   retail `sw s7 / addu s7,a0 / sw s4 / addu s4,zero / lui t1 / addiu t1`, ours
   `sw s4 / addu s4,zero / lui t1 / addiu t1 / sw s7 / addu s7,a0` -- sched2
   ordering the two save+init groups against the manager-address pair.  This is
   the methodology's prologue save-ORDER tie-break class.  FALSIFIED here (all
   4 or worse): `i` as a decl-init / first statement / last statement, `self`
   as a decl-init, `fade` read through `this` instead of `self`, a `this` use
   fence before the alias (12), a `self` fence after it (16), `tm` fenced (12),
   and `const`-qualifying the alias.  TU state after this wave: 12/13 PASS,
   this fn the only FAIL.
   Harness: scratchpad/W72_A7/{probe.py,q1..q12.py} + scratchpad/W72_A7_sbs.py.

   ==== W74-A7 (2026-08-22): 4 -> PASS 561/561 via a PER_FN_TEXT_MOVES row. ====
   THE CLASS IS SETTLED FROM THE COMPILER SOURCE, not guessed.  gcc-2.8.1
   sched.c:2415 rank_for_schedule sorts the ready list by INSN_PRIORITY, then by
   dependence class vs last_scheduled_insn, then by INSN_LUID -- and priority()
   (sched.c:1453) accumulates over LOG_LINKS, i.e. it is chain depth from the
   block TOP (22A(6)).  Both prologue groups here are structurally identical
   2-chains (callee-save `sw` -> its def), so they carry the SAME priority and
   the order is decided by the class/luid tie-break inside sched2.  That is not
   a source-visible quantity: MEASURED INERT (all exactly 4 @561) --
     declaration order: `self` first, `i` last, both;
     statement order: `i = 0;` first / immediately after `self = this;` /
       with `line` hoisted with it;
   and every device that DOES touch it makes it worse (all @561 unless noted):
     void fence after `self = this;` 16 · void fence after `i = 0;` 60 ·
     clobber `"$20"` (= $s4, i's home) after `self = this;` 60 ·
     20B tied launder on (self,i) after `line = 0x2fe;` 11 @562 ·
     20B launder on `self` before `i = 0;` 68.
   Per-fn `-fno-schedule-insns2` was ALSO falsified as the vehicle (cc1 A/B on
   the TU's own .i): it yields the fully UNSCHEDULED prologue (all ten saves
   contiguous, `move $20,$0` + `li $22,766` after them), which is a THIRD order,
   not retail's.  Retail IS sched2 output; only the tie went the other way.
   => the mechanism is the methodology's prologue save-ORDER tie-break class and
   the vehicle is the one this repo already built for it: the BSEARCH.c
   PER_FN_TEXT_MOVES row ("the prologue emission ORDER of the `lo = 0` def vs
   the 4th parm copy").  VALIDATED SPEC (probe-verified 2x via
   W60_TEXT_MOVES_FILE=scratchpad/W74_A7/tm_screenpost.json + tools/vprobe.py;
   whole TU 12/12 PASS both runs, zero PASS->FAIL) -- for tools/build.py's
   PER_FN_TEXT_MOVES:
       "recon/frontend/common/screenpost.cpp": {
           "DrawBackground__26tScreenTournamentStandings": [
               {"take": "\tsw\t\$23,236\(\$sp\)\n\tmove\t\$23,\$4\n",
                "after": "\tsubu\t\$sp,\$sp,248\n"},
           ],
       },
   (Both anchors assert region-unique against the current .s; the row moves two
   NON-branch prologue lines only -- no label, no branch target, no delay slot --
   so brdist/branch-word census is unaffected by construction.)  Until the row is
   wired this fn gates FAIL 4; with it, PASS 561/561 and the TU is 13/13. */
/* ---- tScreenTournamentStandings::DrawBackground  [SCREENPOST.CPP:164-312] ---- */
void tScreenTournamentStandings::DrawBackground()

{
  int fade;
  int fadeline;
  int i;
  int j;
  tTourneyInfo *tourneyInfo;
  char sBuildOutput[80];
  tMenuTextState state;
  tMenuTextState statedull;
  tTrackInformation trackInfo;
  int wwwww;
  tTexture_ShapeInfo *shape;
  int lbx;
  int tt;
  tDrawShapeExtended drawflags;
  int colf;
  int colb;
  int numRacers;
  int lastRacer;
  int line;
  tScreenTournamentStandings *self;
  /* W72-A7: MUST be bound BEFORE any other statement -- one statement later
     and gcc emits a SECOND redundant %lo(tournamentManager) lo_sum (+1 insn). */
  tTournamentManager &tm = tournamentManager;
  tMenuTextType type;   /* W72-A7: named, like the sibling tScreenPinkSlipStandings */

  self = this;
  type = textType_TrackRecords;
  fade = self->fScreenFadeVal;
  fadeline = fade;
  i = 0;
  line = 0x2fe;
  tourneyInfo = &tm.fDefinition->fTournaments[
      tm.fDefinition->fTiers[tm.fTier].fTournOffset + tm.fTournament];
  numRacers = (short)((short)tm.fNumRacers + (tourneyInfo->fKnockout != 0));
  lastRacer = numRacers - 1;
  for (;;) {
    short p;

    if (i >= numRacers) {
      break;
    }
    j = (short)tournamentManager.PlayerRanking((short)(i + 1));
    state = textState_Selected;
    if (j == 0) {
      state = textState_Hilighted;
      statedull = textState_Hilighted;
    }
    else {
      statedull = textState_Unselected;
    }
    FETextRender_FullTextFade(fade,TextSys_Word(i + 599),(short)TextSys_WordX(0x2f7),
                             (short)TextSys_WordY(line),type,statedull,0);
    FETextRender_FullTextFade(
        fade,
        j == 0 ? PlayerName(0) :
                 Stattool_GetAINameFromPersonality(tournamentManager.fCompetitors[j].fPersonality),
        (short)TextSys_WordX(0x2f8),(short)TextSys_WordY(line),
        type,state,0);
    /* W72-A7: the THIRD "r"(line) is load-bearing -- it restores retail's
       self=$s7 / line=$s6 after the tm alias re-ordered global-alloc. */
    __asm__("" : : "r"(fade), "r"(state), "r"(state),
                    "r"(line), "r"(line), "r"(line));
    p = j;
    if (tourneyInfo->fKnockout != 0) {
      sprintf(sBuildOutput,TextSys_Word(i == lastRacer ? 0x31c : 0x31b));
    }
    else {
      sprintf(sBuildOutput,"%d %s",(int)tournamentManager.TournPointTotal(&p),TextSys_Word(0x31d));
    }
    FETextRender_FullTextFade(fade,sBuildOutput,(short)TextSys_WordX(0x2fb),
                             (short)TextSys_WordY(line),type,state,1);
    line++;
    i++;
  }
  trackManager.GetTrack((short)Front_GetTrackRaced(),trackInfo);
  FETextRender_FullTextFade(fade,TextSys_Word((short)Front_GetTrackRaced() + 0xd5),(short)TextSys_WordX(0x2f6),
                           (short)TextSys_WordY(0x2fd),type,textState_Hilighted,2);
  i = (short)(frontEnd.tier != '\0' ?
                TextValue(&menuDefs->iteratorSpecialEvent,kPlayerBoth) :
                TextValue(&menuDefs->iteratorTournament,kPlayerBoth));
  i += 0x13;
  __asm__("" : : "r"(line));
  FETextRender_MenuTextPositionedJustifyFade(fade,(short)i,(short)TextSys_WordX(0x2f6),(short)TextSys_WordY(0x2fc),
                                             2,textState_Hilighted,type);
  wwwww = textpixels(TextSys_Word(i));
  PSXDrawSquare(0,TextSys_WordX(0x2f6) - (wwwww >> 1),TextSys_WordY(0x2fc) - 1,wwwww,9);
  shape = &gCurrentShapes[0][0x27];
  int halfWidth = ((short)shape->width >> 1) - 2;
  lbx = halfWidth - shape->centerx;
  tt = ticks[0] % (short)shape->width;
  if (((short)shape->width / 2) < tt) {
    tt = (short)shape->width - tt;
  }
  DrawShapeExtended(0x28,0,lbx + tt,TextSys_WordY(0x2fc) + 1,self->fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  DrawShapeExtended(0x28,0,lbx - tt,TextSys_WordY(0x2fc) + 1,self->fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  drawflags.tint[0] = 0x282828;
  DrawShapeExtended(0x27,0x400,0,-1,self->fScreenFadeVal,0,&drawflags);
  PSXDrawBrightEndLine(0x232323,TextSys_WordX(0x2f6) - 0x96,TextSys_WordY(0x2fd) + 10,
                       300,1,3,fadeline,0x1e);
  colf = CalcFadeVal(kRGBVals[(byte)textDefinitions[0xb][5]],fade);
  colb = CalcFadeVal(0x232323,fade);
  if ((1000 < ticks[0] - self->starttick) || (self->fStartCountdownNOW != 0)) {
    if ((0 < self->moneyAwarded) || ((0 < self->moneyDamage || (0 < self->moneyBonus)))) {
      AudioCmn_PlayFESFX(0x15);
    }
    self->moneyAwarded -= self->fCountSpeed;
    if (self->moneyAwarded < 1) {
      self->moneyAwarded = 0;
      self->moneyDamage -= self->fCountSpeed;
      if (self->moneyDamage < 1) {
        long bonus = self->moneyBonus - self->fCountSpeed;
        self->fCountedDown = 1;
        self->moneyDamage = 0;
        if (bonus < 0) {
          bonus = 0;
        }
        self->moneyBonus = bonus;
      }
    }
  }
  if (self->fDrawMoney != 0) {
    FETextRender_FullTextFade(fade,TextSys_Word(0x312),(short)TextSys_WordX(0x2fa),
                             (short)TextSys_WordY(0x312),
                             type,
                             self->gotmoney ? 1 : 0,1);
    DrawMoney(TextSys_WordX(0x2fb),TextSys_WordY(0x312),6,self->moneyAwarded,colf,colb);
    FETextRender_FullTextFade(fade,TextSys_Word(0x313),(short)TextSys_WordX(0x2fa),
                             (short)TextSys_WordY(0x313),
                             type,self->gotbilled ? 1 : 0,1);
    DrawMoney(TextSys_WordX(0x2fb),TextSys_WordY(0x313),6,self->moneyDamage,colf,colb);
    FETextRender_FullTextFade(fade,TextSys_Word(0x314),(short)TextSys_WordX(0x2fa),
                             (short)TextSys_WordY(0x314),
                             type,self->gotbonus ? 1 : 0,1);
    DrawMoney(TextSys_WordX(0x2fb),TextSys_WordY(0x314),6,self->moneyBonus,colf,colb);
  }
  FETextRender_FullTextFade(fade,TextSys_Word(0x315),(short)TextSys_WordX(0x2fa),(short)TextSys_WordY(0x315),
                           type,textState_Hilighted,1);
  DrawMoney(TextSys_WordX(0x2fb),TextSys_WordY(0x315),9,
            ((self->moneyFinal - self->moneyAwarded) + self->moneyDamage) - self->moneyBonus,colf,colb);
  ::DrawBackgroundImage((tScreen *)self,10,0x1d,gCurrentShapes[0],0);
  return;
}



/* ---- tScreenPinkSlipStandings::DrawBackground  [SCREENPOST.CPP:320-401] ---- */
/* W56 REGRESSION RECEIPT: was PASS pre-wave; the phantom-signature/signed-short
 * correctness fixes shifted this caller's coloring -> residual ~4 = fp<->s7
 * saved-reg rotation (oracle: lh 92(s7), li fp,1; ours swapped). qtytrace-class
 * (methodology 4.6); NOT reverting correct link/signedness fixes for one swap.
 * TOP W57 near-seal. */
void tScreenPinkSlipStandings::DrawBackground()

{
  int fade;
  char sBuildOutput [50];
  int i;
  tMenuTextState state;
  tMenuTextType type;
  int wwwww;
  tTexture_ShapeInfo *shape;
  int lbx;
  int tt;

  fade = (int)this->fScreenFadeVal;
  type = textType_TrackRecords;
  for (i = 0; state = textState_Hilighted,
      i < (int)(byte)frontEnd.pinkSlipsNumTracks; i = i + 1) {
      tTrackInformation trackInfo;
      char string [30];

      if (i != (byte)frontEnd.pinkSlipsTrackIndex) {
        state = (tMenuTextState)(i < (int)(byte)frontEnd.pinkSlipsTrackIndex);
      }
      trackManager.GetTrack((byte)frontEnd.track[i],trackInfo);
      FETextRender_MenuTextPositionedJustifyFade((int)this->fScreenFadeVal,
                 (short)((signed char)trackInfo.fTrackID + 0xd5),
                 (short)TextSys_WordX(0x2f7),(short)TextSys_WordY(0x2fe + i),0,state,
                 type);
      if (frontEnd.pinkSlipsWinner[i] == -1) {
        sprintf(string,TextSys_Word(0x30d));
      }
      else {
        sprintf(string,PlayerName((int)frontEnd.pinkSlipsWinner[i]));
      }
      FETextRender_FullTextFade(fade,string,(short)TextSys_WordX(0x2fb),
                 (short)TextSys_WordY(0x2fe + i),type,state,1);
  }
  i = 0;
  /* MATCH (W57, 26->PASS): `row` was a Ghidra-invented biv -- the SYM 8c list
     has no such local.  Retail spells the second loop exactly like the first
     (`0x2fe + i`), i.e. TextSys_WordY(0x313 + i): the giv's preheader init
     `addiu $s3,$zero,0x313` is emitted AFTER loop.c's hoist of the shared
     literal 1 (`addiu $s7,$zero,1`), which is retail's constant order.  A real
     `row` variable inverts that order, and naming the 1 (`int one`) rotates
     $s7<->$fp off the SYM's REGPARM this=$0x1e.  Plain literals + the giv. */
  do {
    FETextRender_FullTextFade(fade,PlayerName(i),(short)TextSys_WordX(0x2f8),
               (short)TextSys_WordY(0x313 + i),type,state,0);
    if (frontEnd.pinkSlipsWins[i] == 1) {
      sprintf(sBuildOutput,TextSys_Word(799));
    }
    else {
      sprintf(sBuildOutput,TextSys_Word(0x31e),(uint)(byte)frontEnd.pinkSlipsWins[i]);
    }
    FETextRender_FullTextFade(fade,sBuildOutput,(short)TextSys_WordX(0x2fb),
               (short)TextSys_WordY(0x313 + i),type,
               state,1);
    i = i + 1;
  } while (i < 2);
  FETextRender_MenuTextPositionedJustifyFade(fade,0x2c1,(short)TextSys_WordX(0x2f6),
               (short)TextSys_WordY(0x2fc),2,textState_Hilighted,type);
  wwwww = textpixels(TextSys_Word(0x2c1));
  PSXDrawSquare(0,TextSys_WordX(0x2f6) - (wwwww >> 1),
               TextSys_WordY(0x2fc) - 1,wwwww,9);
  shape = &gCurrentShapes[0][0x27];
  /* SYM-CODEGEN-CARRIER: halfWidth
   * Retail keeps this short-lived value in $v0 and only places the final
   * center-adjusted result in lbx/$s2.  Folding the expression is FAIL 8;
   * assigning both steps through lbx is FAIL 4. */
  int halfWidth = (shape->width >> 1) - 2;
  lbx = halfWidth - shape->centerx;
  tt = ticks[0] % (short)shape->width;
  if ((shape->width / 2) < tt) {
    tt = shape->width - tt;
  }
  tDrawShapeExtended drawflags;
  drawflags.tint[0] = 0x282828;
  DrawShapeExtended(0x28,0,lbx + tt,TextSys_WordY(0x2fc) + 1,
             (int)this->fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  DrawShapeExtended(0x28,0,lbx - tt,TextSys_WordY(0x2fc) + 1,
             (int)this->fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  DrawShapeExtended(0x27,0x400,0,-1,
             (int)this->fScreenFadeVal,0,&drawflags);
  ::DrawBackgroundImage((tScreen *)this,10,0x1d,gCurrentShapes[0],0);
  return;
}



/* ---- tScreenPinkSlipStandings::ProcessInput  [SCREENPOST.CPP:80-80] ---- */
void tScreenPinkSlipStandings::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  tScreen_ProcessInput((tScreen *)this,fromPlayer,keyval,command);
  return;
}



/* ---- tScreenPinkSlipStandings::dtor  [SCREENPOST.CPP:82-406] ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___24tScreenPinkSlipStandings(void *thisp) { ___7tScreen(thisp); }



/* ---- tScreenTournamentStandings3item::dtor  [SCREENPOST.CPP:72-406] ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___31tScreenTournamentStandings3item(void *thisp) { ___7tScreen(thisp); }



/* ---- tScreenTournamentStandings::dtor  [SCREENPOST.CPP:64-406] ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___26tScreenTournamentStandings(void *thisp) { ___7tScreen(thisp); }



/* end of screenpost.cpp */
