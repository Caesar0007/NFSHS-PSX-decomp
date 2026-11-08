/* frontend/common/screencongrats.cpp  --  RECONSTRUCTED  (congrats screens; C++ TU)
 *   28 MEMBER fns across 5 classes (tScreenCongrats : tScreen; 4 derived : tScreenCongrats).
 *   Member-fn decls in nfs4_types.h (non-virtual, ABI-neutral). Bodies: Ghidra decompiler.
 *   TREATMENT: decl lines SLD/8c-verified (28/28); body locals = SYM REG/AUTO/STAT names where
 *   present, semantic temps otherwise; [SYM] tags in comments. Some Scale/DrawShapeExtended args
 *   + a few RECT/fade locals were not recovered by the decompiler (noted inline).
 */
/* CC1PLPSX emission law: uninitialized globals are flushed at end-of-file in
 * FIRST-DECLARATION order.  Retail ScreenCongrats.obj front.data is the four
 * screen pointers (0x80052944..) THEN congratsSwapFileName/fPermFileNameBuf
 * (0x80052954/64); the header declares the buffers first, so pin the pointers
 * here (pointer-to-incomplete-class externs need no definition). */
struct tScreenPinkSlipCongrats; struct tScreenTournamentTrophy;
struct tScreenBeTheCopCongrats; struct tScreenTournamentCongrats;
extern tScreenPinkSlipCongrats *screenPinkSlipCongrats;
extern tScreenTournamentTrophy *screenTournamentTrophy;
extern tScreenBeTheCopCongrats *screenBeTheCopCongrats;
extern tScreenTournamentCongrats *screenTournamentCongrats;
#define NFS4_TSCREENCONGRATS_OWNER   /* ScreenCongrats.obj emits tScreenCongrats's table: slot 11 is __pure_virtual */
#include "screencongrats.h"





/* ScreenCongrats.obj-OWNED globals -- DEFINED here (self-contained; .bss zero; SYM-typed) */
tScreenPinkSlipCongrats *screenPinkSlipCongrats;   /* @0x80052944  (bss(zero)) */
tScreenTournamentTrophy *screenTournamentTrophy;   /* @0x80052948  (bss(zero)) */
tScreenBeTheCopCongrats *screenBeTheCopCongrats;   /* @0x8005294c  (bss(zero)) */
tScreenTournamentCongrats *screenTournamentCongrats;   /* @0x80052950  (bss(zero)) */
char         congratsSwapFileName[16];   /* @0x80052954  (bss(zero)) */
char         fPermFileNameBuf[16];   /* @0x80052964  (bss(zero)) */

/* ---- tScreenTournamentCongrats::~tScreenTournamentCongrats  (screencongrats.cpp:161) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);

/* ---- tScreenBeTheCopCongrats::~tScreenBeTheCopCongrats  (screencongrats.cpp:151) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);

/* ---- tScreenPinkSlipCongrats::~tScreenPinkSlipCongrats  (screencongrats.cpp:141) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);

/* ---- tScreenTournamentTrophy::~tScreenTournamentTrophy  (screencongrats.cpp:126) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);

/* ---- tScreenCongrats::~tScreenCongrats  (screencongrats.cpp:109) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);

/* end of screencongrats.cpp */
/* ---- tScreenCongrats::Cleanup  (screencongrats.cpp:53) ---- */
#line 50 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenCongrats::Cleanup()


{ Car_tStats *devLocal_Car_tStats; /* DEVICE (exact-only): record-less unused local; retail screencongrats.obj type record #378 (TPDEF Car_tStats) between AISpeechInfo_t and Car_tStats, inside Cleanup__15tScreenCongrats's record run (locals-before-params, GSDATA_state 7h) */
  

  CleanupSpinningCarsMenu();
  this->tScreen::Cleanup();
}

/* ---- tScreenCongrats::GetShapeInfo  (screencongrats.cpp:64) ---- */
/* 2026-10-11: CurrentTourney and the racer-count field accessor reproduce
   retail's two receiver-free inline pairs, without added wrappers or locals.
   All150 instructions, nine ordered local/parameter records and eight regions
   agree (run-ufcsbllr). Inline spellings/full SLD remain source review.
   SOURCE-REVIEW-UNRESOLVED: numRanked is an unrecorded signed-short snapshot
   held across PlayerRanking calls. After accessor recovery, direct repeated
   bounds still fail100 at156/150 (2026-10-11); that does not prove an original
   named object. Recover the count snapshot's actual source producer next. */
    /* MATCH: a real switch -- the oracle chains `beq` to OUT-OF-LINE case blocks
       with a `j` to the default (gcc's dispatch lowering); an if/else-if chain
       inlines the bodies at the branch instead. */
    /* [SYM] j lives in the block opened at SLD 19; i in the block nested
       inside it (same source line) -- the 8c record order is j then i. */
  /* CORRECTNESS: the "" here were stale Ghidra rodata placeholders -- the
     oracle sprintf()s into fPermFileNameBuf and hands that buffer back.
     Writing through a string literal was a real runtime bug. */
  /* MATCH (W69, 63 -> PASS): SYM fixes tourneyInfo=$s4, j=$s2, i=$s0,
     fsize=64 and mask=$80ff0000.  Build tourneyInfo before the zero stores,
     express both message choices directly, and keep the racer bound short;
     the decompiler's prefix/ranking locals changed statement order and the
     $s4/$s5 allocation.  The trophy test branches away to the switch arm. */
#line 60 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenCongrats::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)


{
  tTourneyInfo *tourneyInfo;

  tourneyInfo = tournamentManager.CurrentTourney();


  this->fNumSmallSpinShapes = 0; this->fNumSpinShapes = 0;

  numPermShapes = this->congratsMessage == kScreenCongrats_Congrats ? 0x2b : 0x16;
  sprintf(fPermFileNameBuf,"%s%d",
          this->congratsMessage == kScreenCongrats_Congrats ? "zcong" : "zelim",


          (uint)(byte)frontEnd.language);
  *permFileName = fPermFileNameBuf;


  if (2 <= (u_int)(this->trophy - kTrophyCar))
  {
    int j; const short numRanked = (short)((short)tournamentManager.NumRacers() + (tourneyInfo->fKnockout != '\0'));
    j = 900;
    { int i; i = 1; if (0 < numRanked) { do {
          if (tournamentManager.PlayerRanking((short)i) == 0) {
            j = i;
          } i = i + 1; } while (i <= numRanked); } } GetTrophyName(&tournamentManager,tourneyInfo,ts_Large,congratsSwapFileName,j);
    *swapFileName = congratsSwapFileName;
    numSwapShapes = 0x20; this->fNumSpinShapes = 0x20;
  }
  else {

    switch (this->smallSpinningThing) {
    case kSpinningGold:

      numSwapShapes = 0x20; this->fNumSmallSpinShapes = 0x20;
      GetTrophyName(&tournamentManager,tourneyInfo,ts_Small,congratsSwapFileName,-1);
      *swapFileName = congratsSwapFileName;
      break;
    case kSpinningMemCard:
      numSwapShapes = 10; this->fNumSmallSpinShapes = 10;
      *swapFileName = "congb";
      break;
    default:
      *swapFileName = "";
      numSwapShapes = 0;
      break;
    }
  }





  return; }

/* ---- tScreenCongrats::GetCar  (screencongrats.cpp:121) ---- */
#line 118 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
bool tScreenCongrats::GetCar(tCarInfo &carInfo)


{
  carManager.GetGarageCar((ushort)(byte)frontEnd.garageCar[0],carInfo,0);
  carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  return 1;
}

/* ---- tScreenCongrats::DrawBackground  (screencongrats.cpp:128) ---- */
/* 2026-10-11: TextDefinitionColor restores the retail color-read pair;
   the final banner i is a for-header local. Sequencing the actual tick read
   and frame clamp inside the predicate restores all sixty scope regions,
   with541/541 PASS and all recorded local homes/depths correct.
   SOURCE-REVIEW-UNRESOLVED: spinTicks and the existing void fence are not
   proved original source. Direct reads fail17/540, negative-first13/540,
   widened quarter division17/540, post-test clamp20/539, and direct assignment
   in the condition17/540. Fence removal (also with scale in the condition)
   leaves3/540; a GNU minimum clamp without it is27/544. Failed trials are
   reverted, not proof of a required named object or a source/compiler floor.
   Getter spelling and complete original statement-line attribution remain open. */
        /* MATCH (FRONT 2026-10-04): `scale = true` AFTER the clamp (reorg
           still drops its `li s0,1` into the slt/bnez delay slot).  With it
           before the clamp, this arm's `framenum = 0x14` tail was identical
           to the Eliminated arm's clamp tail and cross-jumping merged them
           (540/541); the old fix was a void asm boundary in that arm. */
#line 125 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenCongrats::DrawBackground()


{
  int fJustFadeOff;
  static u_long carRotate = 0;   /* retail: zero static in front.DATA @0x80052940 => written `= 0` */ tDrawShapeExtended drawFlags; tDrawShapeExtended drawFlags2; int StripeRGB; int bannerframe; tDrawShapeExtended drawFlags3; fJustFadeOff = 0; if (this->fTransitionOff != 0) {
    fJustFadeOff = this->fScreenFadeVal;
  }

  carRotate += 3;


  drawFlags.custom_shapes = this->fSwapShapes.fShapes;
  drawFlags2.custom_shapes = this->fSwapShapes.fShapes;

  this->DrawCongratsMessage();
  if ((((this->trophy == kTrophyCar) && (this->starttick == -1)) ||
      ((this->fGotCar == 0) && (this->trophy == kTrophyCar))) ||
     ((this->trophy == kTrophyCar) &&

      ((-1 < R3DCar_aSyncLoading) || (FE_Ticks() - this->fEnterTick < 0x3c))))
  {
    this->starttick = FE_Ticks();
  }
  else
  { bool scale;
    if (this->starttick == -1) { this->starttick = FE_Ticks();
    }
    if (this->CashAwarded != -1)
    { int colf;
      int colb; if ((1000 < FE_Ticks() - this->starttick) || (this->fStartCountdownNOW != 0)) {

        if (this->CashAwarded != 0) {
          AudioCmn_PlayFESFX(0x15);
        }
        this->CashAwarded -= this->fCountSpeed;
        if (this->CashAwarded < 0) {

          this->CashAwarded = 0;
          this->fCountedDown = 1;
        }
      }



      colf = CalcFadeVal(TextDefinitionColor(textType_TrackRecords,5),this->fScreenFadeVal);
      colb = CalcFadeVal(0x232323,this->fScreenFadeVal);
      FETextRender_MenuTextFade((int)this->fScreenFadeVal,0x317,textState_Hilighted,

                                textType_TrackRecords);
      DrawMoney(TextSys_WordX(0x318),TextSys_WordY(0x318),6,this->CashAwarded,colf,colb);
      FETextRender_MenuTextFade((int)this->fScreenFadeVal,0x316,textState_Hilighted,

                                textType_TrackRecords);
      DrawMoney(TextSys_WordX(0x319),TextSys_WordY(0x319),9, this->TotalCash - this->CashAwarded,colf,colb);
    }


    if ((this->fSpeechToPlay != 0) && (0x80 < FE_Ticks() - this->starttick)) {

      FeAudio_AsyncPlaySpeech(2,this->fSpeechToPlay);
      this->fSpeechToPlay = 0;
    }





    scale = false;
    if (this->congratsMessage == kScreenCongrats_Congrats)
    {
      drawFlags.tint[0] = CalcFadeVal(0xbebe,this->fScreenFadeVal);
      drawFlags2.tint[0] = CalcFadeVal(0x808080,fJustFadeOff);
      if (this->InExtraSpin != 0)
      {








        const int extraFrame = (FE_Ticks() - this->InExtraSpinTick) / 6;

        this->framenum = extraFrame + 0x15;

        if (0x29 < this->framenum) {

          this->InExtraSpin = 0;
          this->framenum = 0x14;
        }
        scale = true;
      }

      else {








        this->framenum = (FE_Ticks() - this->starttick) / 2;

        if (0x13 < this->framenum)
        {
          const int twenty = (fJustFadeOff = 0, 0x14);
          int spinTicks; scale = true; if (((spinTicks = FE_Ticks() - (spinTicks = 0, 0)),

               this->framenum = twenty, spinTicks - this->starttick / 4) % 0x5dc < 0x2d)
          {
            this->InExtraSpin = 1;
            this->InExtraSpinTick = FE_Ticks();
          }
        }
      }
    }
    else
    {

      drawFlags.tint[0] = CalcFadeVal(0x646464,fJustFadeOff);
      drawFlags2.tint[0] = CalcFadeVal(0x808080,fJustFadeOff);
      this->framenum = (FE_Ticks() - this->starttick) / 4;
      if (0x14 < this->framenum) { this->framenum = 0x14;
      }
    }


    if (scale) {
      ScaleShapeExtended(this->framenum,0x410,0, (this->congratsMessage == kScreenCongrats_Eliminated) ? 0xA : 0, 0,0,&drawFlags);
    }
    else { DrawShapeExtended(this->framenum,0x410,0, (this->congratsMessage == kScreenCongrats_Eliminated) ? 0xA : 0, 0,0,&drawFlags);
    }
    if ((uint)(this->trophy - kTrophyCar) >= 2)
    {

      ScaleShapeExtended((FE_Ticks() / 12) % 0x20,0x610,0x46,0xf,0,0,&drawFlags2);
    }




    if ((uint)this->trophy >= (uint)kTrophyCar)
    {
      switch (this->smallSpinningThing)
      { case kSpinningGold:
        ScaleShapeExtended((FE_Ticks() >> 3) % this->fNumSmallSpinShapes,

                           0x610,0x29,0xbe,0,0,&drawFlags2);
        break;
      case kSpinningMemCard:
        drawFlags.tint[0] = 0x551e00;
        DrawShapeExtended((FE_Ticks() / 0x14) % this->fNumSmallSpinShapes,
                          0x610,-0xc1,0x56,0,0,&drawFlags);


        break; } }
  }






  if (this->congratsMessage == kScreenCongrats_Congrats) {

    switch (this->trophy) {
    case kTrophyGold:
    case kTrophyCar:
      StripeRGB = 0x3e44;

      break;
    case kTrophySilver:
      StripeRGB = 0x212121;
      break;
    case kTrophyBronze:
      StripeRGB = 0x3044;
      break;
    default:
      StripeRGB = 0x30022;
      break;
    }
  }
  else {
    StripeRGB = 0x30022;
  } bannerframe = (this->congratsMessage == kScreenCongrats_Congrats) ? 0x2A : 0x15;
  ; const int fade3 = CalcFadeVal(StripeRGB,this->fScreenFadeVal);


  drawFlags3.tint[0] = fade3;


  if ((this->congratsMessage == kScreenCongrats_Congrats) && (this->trophy != kTrophyCar))
  {
    { int i; for (i = 1; i < 0x1e; i++) {

        if ((i % 3) != 0) {
          DrawShapeExtended(bannerframe,0x410,i * 2,0,

                            this->fScreenFadeVal,1,&drawFlags3);
        }
      }
    } { int i; for (i = 0x22; i < 0x3f; i++) {

        if ((i % 3) != 0) {
          DrawShapeExtended(bannerframe,0x410,i * 2,0,

                            this->fScreenFadeVal,1,&drawFlags3);
        }
      }
    }
  }
  else {
    for (int i = 7; i < 0x28; i++) {

      if ((i % 3) != 0) {
        DrawShapeExtended(bannerframe,0x410,i * 2,0,

                          this->fScreenFadeVal,1,&drawFlags3);
      }
    }
  }
  if ((this->trophy == kTrophyCar) && (this->fGotCar != 0)) {

    showRoomFlag = 0;
    DrawCar(this->fCarInfo,this->fCarX,this->fCarY,this->fCarCX,this->fCarCY,-0x80,true,carRotate,(tPlayer)this->fCarPlayer); } return; }


/* ---- tScreenCongrats::DrawForeground  (screencongrats.cpp:360) ---- */
#line 357 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenCongrats::DrawForeground()


{

}

/* ---- tScreenCongrats::CalculatePrizes  (screencongrats.cpp:365) ---- */
#line 362 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenCongrats::CalculatePrizes()


{

  this->congratsMessage = kScreenCongrats_Congrats;
  this->trophy = kTrophyNone;
  this->smallSpinningThing = kSpinningNone;
  this->fCarPlayer = 0;
  this->TotalCash = 0;
  this->CashAwarded = -1;


  this->fCarX = 0x116; this->fCarY = 0x3f;
  this->fCarCX = 4.0; this->fCarCY = -7.4;

  if (this->congratsMessage == kScreenCongrats_Eliminated)
  {
    this->fCarX = 0x120; this->fCarY = 0x49; this->fCarCX = 4.0; this->fCarCY = -8.2; } return; }

/* ---- tScreenCongrats::Initialize  (screencongrats.cpp:385) ---- */
/* SYM-CODEGEN-CARRIER: vtbl -- retail SYM has no source local here; the original
   C++ virtual-call syntax produced its vtable temporaries implicitly.  The
   reconstruction models the ABI through _vf, so this cache is the safe
   source-level surrogate.  Direct _vf[1][0]/_vf[1][2] access remains byte-
   exact (PASS 49/49) but is rejected by audit_vtable_indexing.py four times. */
/* MATCH: use the field directly in the comparison and division. GCC CSEs the
   load later, after lowering signed /64 to retail's bgez/addiu/sra sequence;
   a cached local lets its value-range pass incorrectly remove that sequence. */
#line 382 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenCongrats::Initialize()


{
  /* P892: capture the entry tick before state writes. Direct native fields
     remove an unproved inline helper; exact bytes and improved SLD pairs. */
  this->fEnterTick = FE_Ticks();
  this->fSpeechToPlay = 0;
  this->starttick = -1;

  this->framenum = -1;
  this->InExtraSpin = 0;
  SetLicensePlate();
  this->CalculatePrizes();



  this->fGotCar = this->GetCar(this->fCarInfo);

  if (this->CashAwarded > 0) {

    this->fCountedDown = 0;

    this->fStartCountdownNOW = 0;
    this->fCountSpeed = this->CashAwarded / 0x40;

  }
  else {
    this->fCountedDown = 1;
    this->fStartCountdownNOW = 1;
    this->fCountSpeed = 1000;

  }
  this->tScreen::Initialize();
}


extern SPEECHINFO ginfo;   /* global @0x800514e8 (feaudio.cpp); oracle reads ginfo+0x10 as lhu */
#line 420 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenCongrats::ProcessInput(tPlayer p,tInputKeyType &keyval,tMenuCommand &c)


{
  if (keyval != kInput_KeyType_Circle)
  {
    if (SpeechLoading(&ginfo) || (CongratsTicks() - this->starttick < 0x96)) {
      keyval = kInput_KeyType_AlreadyProcessed;
    }
  }
}


/* ---- tScreenPinkSlipCongrats::DrawCongratsMessage  (screencongrats.cpp:432) ---- */
  /* @0x80048C34: WordWrapText's 1st arg is `addiu a0,sp,0x20` = BUFFER, not sprintf's
     return value (the old `fmt = (char *)sprintf(...)` funnel was a transcription bug). */
  /* @0x80048B54-70: oracle materializes a real RECT{x=0x29,y=0x3C,w=0x1A4,h=0xC8} local. */
  /* SYM 8c @0x80048B48: the ONLY locals are `RECT r` (AUTO -0x120) and
     `char buffer[250]` (AUTO -0x118); `this` is REGPARM $13 = $s3.  The four
     char* temps the earlier recon carried (fmt/name1/word/name2) are Ghidra
     fictions -- retail spells the four helper calls INLINE in the sprintf
     argument list, so their results live in whatever callee-saved regs the
     allocator hands out ($s2/$s1/$s0), and `this` keeps $s3.  (W55-A15) */
#line 429 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenPinkSlipCongrats::DrawCongratsMessage()


{
  RECT r;
  char buffer [250]; r.x = 0x29;
  r.y = 0x3c;
  r.w = 0x1a4;
  r.h = 200;
  /* @0x80048B88-90: oracle's compare is `sltiu` (unsigned) -- the range-check idiom. */


  if ((uint)((byte)frontEnd.language - 2) < 2) {
    sprintf(buffer,TextSys_Word(0x275),PlayerName((int)this->fWinner),
               TextSys_Word((signed char)this->fCarInfo.fCarID + 0x121),
               PlayerName(1 - this->fWinner),this->fWinner + 1);
  }
  else {
    sprintf(buffer,TextSys_Word(0x275),PlayerName((int)this->fWinner),
               PlayerName(1 - this->fWinner),
               TextSys_Word((signed char)this->fCarInfo.fCarID + 0x121),
               this->fWinner + 1);
  }
  FETextRender_WordWrapText(buffer,r,textState_Selected,textType_PostGame); return;
}

/* ---- tScreenPinkSlipCongrats::GetCar  (screencongrats.cpp:456) ---- */
#line 453 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
bool tScreenPinkSlipCongrats::GetCar(tCarInfo &carInfo)


{
  carManager.GetPinkSlipsCar((ushort)(byte)frontEnd.pinkSlipsCar[1 - this->fWinner],carInfo, 1 - this->fWinner);
  carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  return 1;
}

/* ---- tScreenPinkSlipCongrats::CalculatePrizes  (screencongrats.cpp:463) ---- */
/* ORIGINAL-NAME-UNRESOLVED: ReplaceLoserLicense and its player parameter
   are inferred spellings, not names recovered from retail SYM. This real
   two-call update reproduces retail's receiver-free zero-length inline pair
   with the computed argument below; the caller needs no player capture.
   MATCH 2026-10-09: CalculatePrizes 68/68 PASS, complete TU sections/layout
   unchanged (run-1l6dllfm), native locals and blocks exact. Full SLD and
   literal original helper spelling remain unresolved. */

    /* P864: SYM records only carinfo, not the former speechId2/base carriers.
       Widening the grouped right operand prevents 32-bit reassociation while
       assignment truncates to the retail int result.  Direct carinfo access
       preserves the $v1 load/shift/sum and both arm stores: PASS 68/68, exact
       debug twin, SLD 477's single award statement.  This is an inferred
       source-shape reconstruction, not proof of the original cast spelling;
       the former split-temp requirement is superseded by this measured form. */
    /* @0x80048D84-8C: oracle adds 0x13 to fWinner FIRST (`lh v0,388;addiu v0,19`), THEN adds the
     * doubled speech-car-id (`addu v1,v1,v0`) -- explicit grouping to match that addition order. */
  /* @0x80048D74: oracle `lb v1,0xD1(sp)` reads fSpeechCarID as SIGNED (matches its use in a real
   * `==-1` compare below); tCarInfo::fSpeechCarID is a shared-header plain `char` (platform default
   * unsigned on this toolchain, hence a stray `lbu` -- cast to `signed char` here, in-TU only).
   * @0x80048D7C: oracle's `beq v1,s2,.L(==-1 case)` computes the `!=-1` (else) body INLINE on the
   * fallthrough and jumps PAST the ==-1 body -- invert the branch polarity to match. */
  /* MATCH (W54-A7, from the SYM SLD line map of 0x80048CDC..0x80048DEC):
     retail's statement order is EXACTLY 464 TotalCash / 465 CashAwarded /
     466 congratsMessage / 467 trophy / 468 smallSpinningThing /
     469 fCarPlayer / 471 player.  There is NO `winner` local: line 469 and
     line 471 each RE-READ this->fWinner (two `lh 0x184` + two `subu`). */
#line 460 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenPinkSlipCongrats::CalculatePrizes()


{
  tCarInfo carinfo;   /* [SYM] the ONLY 8c-recorded local of this fn (AUTO) */ this->TotalCash = 0;
  this->CashAwarded = -1;
  this->congratsMessage = kScreenCongrats_Congrats;
  this->trophy = kTrophyCar;
  this->smallSpinningThing = kSpinningMemCard;
  this->fCarPlayer = 1 - this->fWinner;

  ReplaceLoserLicense(1 - this->fWinner);


  this->GetCar(carinfo);
  if ((signed char)carinfo.fSpeechCarID != -1) {

    this->fSpeechToPlay = (signed char)carinfo.fSpeechCarID * 2 + (long long)(this->fWinner + 0x13);
  }
  else {

    this->fSpeechToPlay = this->fWinner + 0x17;
  }


  this->fCarX = 0x116; this->fCarY = 0x4b;
  this->fCarCX = 4.0; this->fCarCY = -7.4; return;
}

/* ---- tScreenPinkSlipCongrats::Initialize  (screencongrats.cpp:491) ---- */
#line 488 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenPinkSlipCongrats::Initialize()


{


  this->fWinner = -1;

  if ((int)(((byte)frontEnd.pinkSlipsNumTracks >> 1) + 1) <= (int)(byte)frontEnd.pinkSlipsWins[0]) {
    this->fWinner = 0;
  } else { this->fWinner = 1;
  }
  this->tScreenCongrats::Initialize(); return;
}

/* ---- tScreenPinkSlipCongrats::Cleanup  (screencongrats.cpp:505) ---- */
#line 502 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenPinkSlipCongrats::Cleanup()


{
  

  CleanupSpinningCarsMenu();
  this->tScreen::Cleanup();
}


/* ---- tScreenTournamentTrophy::ProcessInput  (screencongrats.cpp:518) ---- */
#line 515 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenTournamentTrophy::ProcessInput(tPlayer p,tInputKeyType &keyval,tMenuCommand &c)


{
  if (keyval == kInput_KeyType_Cross) {

    if (this->fCountedDown == 0) {

      keyval = kInput_KeyType_AlreadyProcessed;
      this->fStartCountdownNOW = 1;
    } }

  this->tScreenCongrats::ProcessInput(p,keyval,c); return;
}

/* ---- tScreenTournamentTrophy::GetCar  (screencongrats.cpp:531) ---- */
      /* two separate sprintf calls -- gcc cross-jump-merges them into the oracle's
         single `.L800490EC: jal sprintf` with only the $a0 setup per arm. */
      /* MATCH: a real switch -- oracle is gcc's case TREE over {0},{1},{3}
         (root ==1, slti 2, then ==0 / ==3) with bodies in source order 0,1,default. */
#line 528 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
bool tScreenTournamentTrophy::GetCar(tCarInfo &carInfo)


{
  if (this->congratsMessage == kScreenCongrats_Congrats)
  { tAwardInformation tInfo;   /* [SYM] AUTO sp+16, block opened at SLD 3 */

    tournamentManager.GetAwardInformation(tInfo);



    tCarInfo *const car = carManager.GetCarFromID((u_short)tInfo.fAwardCarModel); /* DEVICE (exact-only): retail tags the lookup (8) apart from the copy (9); const temp, no SYM record */
    blockmove(car,&carInfo,0xcc);

    carInfo.fUpgrades = tInfo.fAwardCarUpgrades;
    carInfo.fColor = tInfo.fAwardCarColor;

  }
  else {
    carManager.GetGarageCar((ushort)(byte)frontEnd.garageCar[0],carInfo,0);
    carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  }
  return 1;
}

/* ---- tScreenTournamentTrophy::DrawCongratsMessage  (screencongrats.cpp:555) ---- */
/* 2026-10-11: the tournament and previous-placement getters restore all
   twelve native local/parameter tuples and fifteen regions, with182/182 PASS.
   Getter spelling is inferred; complete original text/SLD remains unsealed.
   Retail starts the rectangle stores at relative lines2..5. Declare r at
   its initialization phase, and message data at the subsequent text phase;
   no dummy local, padding region or artificial line directive is needed. */

#line 555 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenTournamentTrophy::DrawCongratsMessage() {
  RECT r;
  r.x = 0x29;
  r.y = 0x3c;
  r.w = 200;
  r.h = 400;
  tAwardInformation tInfo;
  char buffer1 [500], buffer2 [500];

  /* MATCH: the non-Congrats message is the ELSE arm (oracle `bnez $v0,.L800491DC`
     branches FORWARD to a block sitting just before the epilogue). */
  if (this->congratsMessage == kScreenCongrats_Congrats)
  {
    int firstmessage = 0; int secondmessage; tTourneyInfo *tourneyInfo = tournamentManager.CurrentTourney();
    secondmessage = firstmessage;
    /* fPrevBestPlacement/fTournamentID are shared-header plain `char` (unsigned by platform
     * default); the oracle reads BOTH signed (`lb`) throughout -- cast at every read site. */


    if ('\x03' < (signed char)tournamentManager.PreviousPlacement())
    {
      int placeoffset; firstmessage = (signed char)tourneyInfo->fTournamentID + 0x3b3;

      switch (this->trophy) {
      case kTrophyGold:
      case kTrophyCar:
        placeoffset = 0;

        break;
      case kTrophySilver:
        placeoffset = 1;
        break;
      default:
        placeoffset = 2;
        break;
      }
      sprintf(buffer1,TextSys_Word((signed char)tourneyInfo->fTournamentID + 0x3b3),
              TextSys_Word(placeoffset + 0x3e1));
    }

    if (((this->trophy == kTrophyGold) &&
        (tournamentManager.PreviousPlacement() != '\x01')) ||
       (this->trophy == kTrophyCar)) {

      if (firstmessage == 0) {

        firstmessage = (signed char)tourneyInfo->fTournamentID + 0x3c6;
        sprintf(buffer1,TextSys_Word(firstmessage));
      }
      else {

        secondmessage = (signed char)tourneyInfo->fTournamentID + 0x3c6;
        sprintf(buffer2,TextSys_Word(secondmessage));
      }
    }
    /* @0x80049108/144/1C4: the oracle reads `this->fScreenFadeVal` (lh a0,0x5C(s4)) fresh
     * right before EACH of the 3 calls below, not via a cached local. */
    if (firstmessage != 0) {
      FETextRender_WordWrapTextFade((int)this->fScreenFadeVal,buffer1,r,textState_Selected,
                                    textType_PostGame);
      r.y = r.y + (short)FETextRender_WordWrapHeight(r.w,buffer1);
    }

    if (secondmessage != 0) {
      FETextRender_WordWrapTextFade
                ((int)this->fScreenFadeVal,buffer2,r,textState_Selected,textType_PostGame);
    }


    tournamentManager.GetAwardInformation(tInfo);
    if (tInfo.fAwardCarGarageFull != 0)
    {
      char buffer [256];
      char money [64];

      r.x = 0x104;
      r.y = 200;
      r.w = 0xf0;
      FeTools_FormatMoney(money,tInfo.fAwardCarBonusMoney);
      sprintf(buffer,TextSys_Word(0x40),money);
      FETextRender_WordWrapTextFade ((int)this->fScreenFadeVal,TextSys_Word(0x40),r,textState_Selected, textType_PostGame);
    }
  }
  else
  {
    int yyy;
    /* MATCH: the -10 bias is folded into the jal delay slot (oracle
       `addiu $s0,$v0,-0xA`); computing it after the call costs a copy + addiu. */
    yyy = TextSys_WordY(800) + -10;
    FETextRender_FullTextRGB(TextSys_Word(800),0x120,(short)((uint)(yyy * 0x10000) >> 0x10),


                             0x414141,'\x03',2); } return; }

/* ---- tScreenTournamentTrophy::CalculatePrizes  (screencongrats.cpp:654) ---- */
/* 2026-10-11: CurrentTourney, NumRacers and Tournament_Money recover the
   three retail inline pairs. The typed short count expression needs no
   knockout/ranked aliases or raw halfword pointer view. Both old staging
   scopes are removed: all seven native regions and recorded local homes
   agree, while the full144-word stream and complete TU layout remain exact.
   SOURCE-REVIEW-UNRESOLVED: numRanked is an unrecorded count snapshot; its
   original producer/name are not uniquely recovered. cashAwarded/carCXBits
   and the two existing zero-template fences also remain unresolved.
   After getter recovery, direct float and cash-award expressions, with or
   without the void fence, leave2dif/144; float-store order gives10/144,
   explicit cash-award arms4/144 and a raw literal store6/144. Those trials
   are reverted, not proof that original source required these devices.
   Native agreement is not a complete original-source or SLD certificate. */
  /* MATCH: the kSpinningNone store belongs to the ranked and eliminated paths
     ONLY -- the first-place path skips it and keeps the Gold/None spinner it
     just set.  Written as `switch (j)` with cases 2/3 falling into `default:`
     for a knockout tourney (FRONT9 round 7; replaced the old `goto prizes_done`
     ladder, no LABEL records); cross_jump merges the duplicated tails into
     retail's shared suffix. */
  /* @0x800492A8-D4/0x80049380: oracle computes the tourneyInfo (fTournaments[tourIndex]) POINTER
   * ONCE (kept live in s5) and reuses it for BOTH fKnockout checks below (numRanked's ".fKnockout"
   * AND the later `def->fTournaments[tourIndex].fKnockout` re-test) -- one named local matches. */
#line 651 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenTournamentTrophy::CalculatePrizes()


{
  int i;
  int j;
  tAwardInformation tInfo; tTourneyInfo *tourneyInfo; this->congratsMessage = kScreenCongrats_Eliminated;
  this->trophy = kTrophyNone;
  this->smallSpinningThing = kSpinningMemCard;

  tournamentManager.GetAwardInformation(tInfo);




  tourneyInfo = tournamentManager.CurrentTourney(); const short numRanked = (short)((short)tournamentManager.NumRacers() + (tourneyInfo->fKnockout != '\0'));

  j = 900;
  i = 1; if (0 < numRanked) { do {
      if (tournamentManager.PlayerRanking((short)i) == 0) {
        j = i;
      }

      i = i + 1; } while (i <= numRanked);
  }

  switch (j) {
  case 1:
  {
    if (tInfo.fAwardCar != 0) {

      this->trophy = kTrophyCar;
      this->smallSpinningThing = kSpinningGold;
    }
    else {

      this->trophy = kTrophyGold;
      this->smallSpinningThing = kSpinningNone;
    }
    this->fSpeechToPlay = 0xf;
    this->congratsMessage = kScreenCongrats_Congrats;
    break;
  }
  case 2: case 3:
    if (tourneyInfo->fKnockout == '\0') {

      this->fSpeechToPlay = j + 0xe;
      this->congratsMessage = kScreenCongrats_Congrats;
      this->trophy = j == 2 ? kTrophySilver : kTrophyBronze;
      this->smallSpinningThing = kSpinningNone;

      break; }

  default:

    this->congratsMessage = kScreenCongrats_Eliminated;
    this->trophy = kTrophyCar;
    this->smallSpinningThing = kSpinningNone;
  }


  this->fCarPlayer = 0;


  this->TotalCash = Tournament_Money(tournamentManager);
  if (tInfo.fCompletedGarageFull != 0) {
    this->TotalCash -= tInfo.fCompletedBonusMoney;
  }




  this->CashAwarded = tInfo.fTournMoney == 0 ? -1 : tInfo.fTournMoney;


  this->fCarX = 0x116; this->fCarY = 0x3f;
  this->fCarCX = 4.0; this->fCarCY = -7.4;

  if (this->congratsMessage == kScreenCongrats_Eliminated) {

    this->fCarX = 0x120; this->fCarY = 0x49; this->fCarCX = 4.0; this->fCarCY = -8.2; } return; }


/* ---- tScreenBeTheCopCongrats::GetCar  (screencongrats.cpp:746) ---- */
#line 743 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
bool tScreenBeTheCopCongrats::GetCar(tCarInfo &carInfo)


{


  tCarInfo *const car = carManager.GetCarFromID((ushort)(byte)frontEnd.congratsCopCar); /* DEVICE (exact-only): retail tags the lookup (3) apart from the copy (4); const temp, no SYM record */
  blockmove(car,&carInfo,0xcc);
  carInfo.fCountry = frontEnd.congratsCopCountry;
  return 1;
}

/* ---- tScreenBeTheCopCongrats::CalculatePrizes  (screencongrats.cpp:756) ---- */
#line 753 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenBeTheCopCongrats::CalculatePrizes()


{
  this->tScreenCongrats::CalculatePrizes();
  this->trophy = kTrophyCar;

  this->fCarX = 0x116; this->fCarY = 0x4b;
  this->fCarCX = 4.0; this->fCarCY = -7.4; return;
}

/* ---- tScreenBeTheCopCongrats::DrawCongratsMessage  (screencongrats.cpp:766) ---- */
    /* fCarID is a shared-header plain `char` (unsigned by platform default); oracle reads it
     * SIGNED (`lb`) here -- cast in-TU only, matches the fSpeechCarID precedent elsewhere. */
  /* @0x80049540-58: oracle materializes a real RECT{x=0x29,y=0x3C,w=0xC8,h=0xC8} local (same idiom
   * as TournamentTrophy's DrawCongratsMessage, h differs: 0xC8 here not 0x190) -- the prior recon's
   * `(RECT*)(uint)(byte)congratsCopCar` cast was a bogus reuse of the field-compare value as the
   * RECT pointer arg (dropped the real RECT init entirely). */
#line 763 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenBeTheCopCongrats::DrawCongratsMessage()


{
  short congrats = 0x4c;
  RECT r;
  char buffer [250]; r.x = 0x29;
  r.y = 0x3c;
  r.w = 200;
  r.h = 200;
  /* @0x80049598/end: oracle's FETextRender_WordWrapText 3rd arg is a LITERAL `li a2,1` (=
   * textState_Selected), not a read of an uninitialized `fade` local. */

  if (frontEnd.congratsCopCar == 0x1c) {
    congrats = 0x4d;
  }
  if ((PAD_state(4) & 0xffff) != 0) {
    TextSys_Word((signed char)this->fCarInfo.fCarID + 0x121);
  }
  sprintf(buffer,TextSys_Word(congrats), TextSys_Word((signed char)this->fCarInfo.fCarID + 0x121));
  FETextRender_WordWrapText(buffer,r,textState_Selected,textType_PostGame);   /* MATCH: pass buffer (addr held in s0 across sprintf, 3.12#16), NOT sprintf's return */ return;
}


/* ---- tScreenTournamentCongrats::GetCar  (screencongrats.cpp:796) ---- */
#line 793 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
bool tScreenTournamentCongrats::GetCar(tCarInfo &carInfo)


{

  tAwardInformation tInfo;

  tournamentManager.GetAwardInformation(tInfo);
  tCarInfo *const car = carManager.GetCarFromID((u_short)tInfo.fCompletedCar); /* DEVICE (exact-only): retail tags the lookup (5) apart from the copy (6); const temp, no SYM record */
  blockmove(car,&carInfo,0xcc);
  return 1;
}

/* ---- tScreenTournamentCongrats::CalculatePrizes  (screencongrats.cpp:807) ---- */

#line 806 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenTournamentCongrats::CalculatePrizes()
{
  tAwardInformation tInfo;
  tournamentManager.GetAwardInformation(tInfo);

  this->tScreenCongrats::CalculatePrizes();
  this->trophy = kTrophyCar;

  this->TotalCash = Tournament_Money(tournamentManager);


  this->CashAwarded = tInfo.fCompletedGarageFull != 0 ? tInfo.fCompletedBonusMoney : -1;

  this->fCarX = 0x116; this->fCarY = 0x4b;
  this->fCarCX = 4.0; this->fCarCY = -7.4;
}

/* ---- tScreenTournamentCongrats::DrawCongratsMessage  (screencongrats.cpp:825) ---- */
  /* @0x800496E0-FC/0x39F4C-58: oracle materializes a real RECT{x=0x29,y=0x3C,w=0xC8,h=0x190} local
   * (same idiom as the sibling DrawCongratsMessage fns) then, inside the fCompletedGarageFull branch,
   * OVERWRITES r.w/r.h to {0xB4,0x1AE} for the money-line rewrap -- the prior recon's uninitialized
   * `RECT *r;`/`tMenuTextState fade;` dropped this entirely (real bug: NULL/garbage RECT ptr). */
#line 822 "C:/nfs4/FRONTEND/COMMON/SCREENCONGRATS.CPP"
void tScreenTournamentCongrats::DrawCongratsMessage()


{
  RECT r;
  tAwardInformation tInfo; r.x = 0x29;
  r.y = 0x3c;
  r.w = 200;
  r.h = 400;
  /* oracle's FETextRender_WordWrapText 3rd arg is a LITERAL `li a2,1` (=textState_Selected), not a
   * read of an uninitialized `fade` local (both call sites). */
  tournamentManager.GetAwardInformation(tInfo);
  FETextRender_WordWrapText(TextSys_Word((int)tInfo.fCompletedText),r,
                            textState_Selected,textType_PostGame);

  if (tInfo.fCompletedGarageFull != 0)
  {
    char buffer [256]; char money [64];
    /* @0x39F4C-58: oracle overwrites r.y/r.w here (NOT r.w/r.h) -- confirmed via the exact sp
     * offsets (0x12=r.y, 0x14=r.w), not a naive "next two fields" guess. */
    r.y = 0xb4;
    r.w = 0x1ae;
    FeTools_FormatMoney(money,tInfo.fCompletedBonusMoney);
    sprintf(buffer,TextSys_Word(0x40),money);
    FETextRender_WordWrapText(TextSys_Word(0x40),r,textState_Selected, textType_PostGame); } return; }

/* Retained EOF source extent; literal lost comments are not reconstructed.
 * The final real DrawCongratsMessage body ends on source line846.
 * Retail synthesis records the translation-unit end on source855.
 * This documentary tail supplies that existing source extent only.
 * No executable operation, declaration, helper or pragma is added.
 * Default and original CPP emission contexts are measured independently.
 * Existing real footer declarations are retained before the first anchor.
 */
