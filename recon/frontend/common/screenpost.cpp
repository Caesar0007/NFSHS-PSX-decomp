/* frontend/screens/screenpost.cpp -- RECONSTRUCTED (tournament-standings screens + DrawMoney; C++ TU)
 *   3 classes (tScreenTournamentStandings -> 3item -> PinkSlipStandings) + free DrawMoney; 13 fns.
 */
#include "screenpost.h"


/* ---- (free)::DrawMoney  [SCREENPOST.CPP:47-75] ---- */

/* Decoded Phase 84: DrawMoney(int x, int y, int z, long amount, int, int) - render currency display($XX,XXX) (312 B, 11 callers - hot). Used in garage, dealer, postgame screens.
   
   [ghidra-meta] section: front.text */

void DrawMoney(int x,int y,int numplaces,long number,int colfore,int colback)

{
  char *str;
  char string1 [50];
  char string2 [50];
  
  switch (numplaces) {
  case 3:
    str = TextSys_Word(0x86);
    sprintf(string1,str,0);
    break;
  case 6:
    str = TextSys_Word(0x87);
    sprintf(string1,str,0,0);
    break;
  case 9:
    str = TextSys_Word(0x88);
    sprintf(string1,str,0,0,0);
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
  int iVar1;
  int max_damage;
  int max_money;
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
    iVar1 = tournamentManager.fMoney - tInfo.fTournMoney;
    this->moneyFinal = iVar1;
    if (tInfo.fCompletedGarageFull != 0) {
      this->moneyFinal = iVar1 - tInfo.fCompletedBonusMoney;
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
    max_money = this->moneyBonus;
    this->fStartCountdownNOW = 0;
    if (max_money < tInfo.fMoney) {
      max_money = tInfo.fMoney;
    }
    max_damage = this->moneyDamage;
    if (max_damage < max_money) {
      max_damage = max_money;
    }
    this->fCountSpeed = max_damage / 0x18;
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
void tScreenTournamentStandings::ProcessInput(tPlayer keyval,tInputKeyType &key_input,
              tMenuCommand &menu_cmd)

{
  if (key_input != kInput_KeyType_Cross) {
    return;
  }
  if (this->fCountedDown == 0) {
    key_input = kInput_KeyType_AlreadyProcessed;
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
   an input-priced textType local is 57/558; plain money literals are 217/548. */
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

  self = this;
  fade = self->fScreenFadeVal;
  fadeline = fade;
  i = 0;
  line = 0x2fe;
  tourneyInfo = &tournamentManager.fDefinition->fTournaments[
      tournamentManager.fDefinition->fTiers[tournamentManager.fTier].fTournOffset + tournamentManager.fTournament];
  numRacers = (short)((short)tournamentManager.fNumRacers + (tourneyInfo->fKnockout != 0));
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
                             (short)TextSys_WordY(line),textType_TrackRecords,statedull,0);
    FETextRender_FullTextFade(
        fade,
        j == 0 ? PlayerName(0) :
                 Stattool_GetAINameFromPersonality(tournamentManager.fCompetitors[j].fPersonality),
        (short)TextSys_WordX(0x2f8),(short)TextSys_WordY(line),
        textType_TrackRecords,state,0);
    __asm__("" : : "r"(fade), "r"(state), "r"(state),
                    "r"(line), "r"(line));
    p = j;
    if (tourneyInfo->fKnockout != 0) {
      sprintf(sBuildOutput,TextSys_Word(i == lastRacer ? 0x31c : 0x31b));
    }
    else {
      sprintf(sBuildOutput,"%d %s",(int)tournamentManager.TournPointTotal(&p),TextSys_Word(0x31d));
    }
    FETextRender_FullTextFade(fade,sBuildOutput,(short)TextSys_WordX(0x2fb),
                             (short)TextSys_WordY(line),textType_TrackRecords,state,1);
    line++;
    i++;
  }
  trackManager.GetTrack((short)Front_GetTrackRaced(),trackInfo);
  FETextRender_FullTextFade(fade,TextSys_Word((short)Front_GetTrackRaced() + 0xd5),(short)TextSys_WordX(0x2f6),
                           (short)TextSys_WordY(0x2fd),textType_TrackRecords,textState_Hilighted,2);
  i = (short)(frontEnd.tier != '\0' ?
                TextValue(&menuDefs->iteratorSpecialEvent,kPlayerBoth) :
                TextValue(&menuDefs->iteratorTournament,kPlayerBoth));
  i += 0x13;
  __asm__("" : : "r"(line));
  FETextRender_MenuTextPositionedJustifyFade(fade,(short)i,(short)TextSys_WordX(0x2f6),(short)TextSys_WordY(0x2fc),
                                             2,textState_Hilighted,textType_TrackRecords);
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
  /* Shared by the three money-state/justify pairs; this gives retail's late
     s4 constant and leaves colf/colb in s3/s2. */
  int one = 1;
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
                             textType_TrackRecords,
                             self->gotmoney ? one : 0,one);
    DrawMoney(TextSys_WordX(0x2fb),TextSys_WordY(0x312),6,self->moneyAwarded,colf,colb);
    FETextRender_FullTextFade(fade,TextSys_Word(0x313),(short)TextSys_WordX(0x2fa),
                             (short)TextSys_WordY(0x313),
                             textType_TrackRecords,self->gotbilled ? one : 0,one);
    DrawMoney(TextSys_WordX(0x2fb),TextSys_WordY(0x313),6,self->moneyDamage,colf,colb);
    FETextRender_FullTextFade(fade,TextSys_Word(0x314),(short)TextSys_WordX(0x2fa),
                             (short)TextSys_WordY(0x314),
                             textType_TrackRecords,self->gotbonus ? one : 0,one);
    DrawMoney(TextSys_WordX(0x2fb),TextSys_WordY(0x314),6,self->moneyBonus,colf,colb);
  }
  FETextRender_FullTextFade(fade,TextSys_Word(0x315),(short)TextSys_WordX(0x2fa),(short)TextSys_WordY(0x315),
                           textType_TrackRecords,textState_Hilighted,1);
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
  int row;
  int pixels;

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
  /* MATCH 2026-08-03 (8->4): this width is a new source value, not the
     earlier row-word cursor.  Keeping it separate lets GCC preserve the
     textpixels result in the TextSys_WordX delay slot, as retail does. */
  pixels = textpixels(TextSys_Word(0x2c1));
  PSXDrawSquare(0,TextSys_WordX(0x2f6) - (pixels >> 1),
               TextSys_WordY(0x2fc) - 1,pixels,9);
  shape = &gCurrentShapes[0][0x27];
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
int tScreenPinkSlipStandings::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,
               tMenuCommand &command)

{
  return tScreen_ProcessInput((tScreen *)this,fromPlayer,keyval,command);
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
