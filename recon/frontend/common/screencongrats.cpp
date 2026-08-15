/* frontend/common/screencongrats.cpp  --  RECONSTRUCTED  (congrats screens; C++ TU)
 *   28 MEMBER fns across 5 classes (tScreenCongrats : tScreen; 4 derived : tScreenCongrats).
 *   Member-fn decls in nfs4_types.h (non-virtual, ABI-neutral). Bodies: Ghidra decompiler.
 *   TREATMENT: decl lines SLD/8c-verified (28/28); body locals = SYM REG/AUTO/STAT names where
 *   present, semantic temps otherwise; [SYM] tags in comments. Some Scale/DrawShapeExtended args
 *   + a few RECT/fade locals were not recovered by the decompiler (noted inline).
 */
#include "screencongrats.h"

/* ScreenCongrats.obj-OWNED globals -- DEFINED here (self-contained; .bss zero; SYM-typed) */
tScreenPinkSlipCongrats *screenPinkSlipCongrats;   /* @0x80052944  (bss(zero)) */
tScreenTournamentTrophy *screenTournamentTrophy;   /* @0x80052948  (bss(zero)) */
tScreenBeTheCopCongrats *screenBeTheCopCongrats;   /* @0x8005294c  (bss(zero)) */
tScreenTournamentCongrats *screenTournamentCongrats;   /* @0x80052950  (bss(zero)) */
char         congratsSwapFileName[16];   /* @0x80052954  (bss(zero)) */
char         fPermFileNameBuf[16];   /* @0x80052964  (bss(zero)) */

/* ---- tScreenCongrats::Cleanup  (screencongrats.cpp:53) ---- */
void tScreenCongrats::Cleanup()

{
  
  CleanupSpinningCarsMenu();
  this->tScreen::Cleanup();
  return;
}

/* ---- tScreenCongrats::GetShapeInfo  (screencongrats.cpp:64) ---- */
void tScreenCongrats::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)

{
  /* MATCH (W69, 63 -> PASS): SYM fixes tourneyInfo=$s4, j=$s2, i=$s0,
     fsize=64 and mask=$80ff0000.  Build tourneyInfo before the zero stores,
     express both message choices directly, and keep the racer bound short;
     the decompiler's prefix/ranking locals changed statement order and the
     $s4/$s5 allocation.  The trophy test branches away to the switch arm. */
  short numRanked;
  int i;
  int j;
  tTourneyInfo *tourneyInfo;

  tourneyInfo = &(tournamentManager.fDefinition)->fTournaments
      [(uint)(tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset +
       tournamentManager.fTournament];
  this->fNumSmallSpinShapes = 0;
  this->fNumSpinShapes = 0;
  numPermShapes = this->congratsMessage == kScreenCongrats_Congrats ? 0x2b : 0x16;
  /* 🔴 CORRECTNESS: the "" here were stale Ghidra rodata placeholders -- the
     oracle sprintf()s into fPermFileNameBuf and hands that buffer back.
     Writing through a string literal was a real runtime bug. */
  sprintf(fPermFileNameBuf,"%s%d",
          this->congratsMessage == kScreenCongrats_Congrats ? "zcong" : "zelim",
          (uint)(byte)frontEnd.language);
  *permFileName = fPermFileNameBuf;
  if (2 <= (u_int)(this->trophy - kTrophyCar)) {
    j = 900;
    numRanked = (short)((short)tournamentManager.fNumRacers +
                        (tourneyInfo->fKnockout != '\0'));
    i = 1;
    if (0 < numRanked) {
      do {
        if (PlayerRanking(&tournamentManager,(short)i) == 0) {
          j = i;
        }
        i = i + 1;
      } while (i <= numRanked);
    }
    GetTrophyName(&tournamentManager,tourneyInfo,ts_Large,congratsSwapFileName,j);
    *swapFileName = congratsSwapFileName;
    numSwapShapes = 0x20;
    this->fNumSpinShapes = 0x20;
  }
  else {
    /* MATCH: a real switch -- the oracle chains `beq` to OUT-OF-LINE case blocks
       with a `j` to the default (gcc's dispatch lowering); an if/else-if chain
       inlines the bodies at the branch instead. */
    switch (this->smallSpinningThing) {
    case kSpinningGold:
      numSwapShapes = 0x20;
      this->fNumSmallSpinShapes = 0x20;
      GetTrophyName(&tournamentManager,tourneyInfo,ts_Small,congratsSwapFileName,-1);
      *swapFileName = congratsSwapFileName;
      break;
    case kSpinningMemCard:
      numSwapShapes = 10;
      this->fNumSmallSpinShapes = 10;
      *swapFileName = "congb";
      break;
    default:
      *swapFileName = "";
      numSwapShapes = 0;
      break;
    }
  }
  return;
}

/* ---- tScreenCongrats::GetCar  (screencongrats.cpp:121) ---- */
int tScreenCongrats::GetCar(tCarInfo &carInfo)

{
  
  GetGarageCar(&carManager, (ushort)(byte)frontEnd.garageCar[0],&carInfo,0);
  carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  return 1;
}

/* ---- tScreenCongrats::DrawBackground  (screencongrats.cpp:128) ---- */
void tScreenCongrats::DrawBackground()

{
  /* MATCH W64 PASS (54 -> 0, 541 instructions).  Retail source shapes recovered here include base-first
     virtual-thunk arithmetic, explicit stripe defaults, signed division by
     4 in the subtractive spin timer, and the showroom-flag side effect in DrawCar's
     brightness argument.  In the regular spin block, the scoped tick value
     reproduces retail's $a0 lifetime; the void fence prevents speculative
     delay-slot filling at the block boundary, and the read-only scale fence
     anchors the $s0 assignment before the timer loads.  Writing the tick field
     before the enable field lets sched2 produce retail's load/store order.
     A zero-instruction fence after the eliminated-message clamp prevents GCC
     from cross-jumping the extra-spin framenum store into that later path. */
  int fJustFadeOff;
  static u_long carRotate;
  tDrawShapeExtended drawFlags;
  tDrawShapeExtended drawFlags2;
  int StripeRGB;
  int bannerframe;
  tDrawShapeExtended drawFlags3;
  __vtbl_ptr_type (*vtbl) [10];

  fJustFadeOff = 0;
  if (this->fTransitionOff != 0) {
    fJustFadeOff = this->fScreenFadeVal;
  }
  drawFlags.custom_shapes = this->fSwapShapes.fShapes;
  drawFlags2.custom_shapes = this->fSwapShapes.fShapes;
  vtbl = this->_vf;
  carRotate += 3;
  (*vtbl[1][1].pfn)
      ((char *)((int)this->fPermShapes.fFilename + (vtbl[1][1].delta + -0x14)));
  if ((((this->trophy == kTrophyCar) && (this->starttick == -1)) ||
      ((this->fGotCar == 0) && (this->trophy == kTrophyCar))) ||
     ((this->trophy == kTrophyCar) &&
      ((-1 < R3DCar_aSyncLoading) || (ticks[0] - this->fEnterTick < 0x3c)))) {
    this->starttick = ticks[0];
  }
  else {
    bool scale;

    if (this->starttick == -1) {
      this->starttick = ticks[0];
    }
    if (this->CashAwarded != -1) {
      int colf;
      int colb;

      if ((1000 < ticks[0] - this->starttick) || (this->fStartCountdownNOW != 0)) {
        if (this->CashAwarded != 0) {
          AudioCmn_PlayFESFX(0x15);
        }
        this->CashAwarded -= this->fCountSpeed;
        if (this->CashAwarded < 0) {
          this->CashAwarded = 0;
          this->fCountedDown = 1;
        }
      }
      colf = CalcFadeVal(kRGBVals[(byte)textDefinitions[0xb][5]],this->fScreenFadeVal);
      colb = CalcFadeVal(0x232323,this->fScreenFadeVal);
      FETextRender_MenuTextFade((int)this->fScreenFadeVal,0x317,textState_Hilighted,
                                textType_TrackRecords);
      DrawMoney(TextSys_WordX(0x318),TextSys_WordY(0x318),6,this->CashAwarded,colf,colb);
      FETextRender_MenuTextFade((int)this->fScreenFadeVal,0x316,textState_Hilighted,
                                textType_TrackRecords);
      DrawMoney(TextSys_WordX(0x319),TextSys_WordY(0x319),9,
                this->TotalCash - this->CashAwarded,colf,colb);
    }
    if ((this->fSpeechToPlay != 0) && (0x80 < ticks[0] - this->starttick)) {
      FeAudio_AsyncPlaySpeech(2,this->fSpeechToPlay);
      this->fSpeechToPlay = 0;
    }
    scale = false;
    if (this->congratsMessage == kScreenCongrats_Congrats) {
      drawFlags.tint[0] = CalcFadeVal(0xbebe,this->fScreenFadeVal);
      drawFlags2.tint[0] = CalcFadeVal(0x808080,fJustFadeOff);
      if (this->InExtraSpin != 0) {
        this->framenum = (ticks[0] - this->InExtraSpinTick) / 6 + 0x15;
        scale = true;
        if (0x29 < this->framenum) {
          this->InExtraSpin = 0;
          this->framenum = 0x14;
        }
      }
      else {
        this->framenum = (ticks[0] - this->starttick) / 2;
        if (0x13 < this->framenum) {
          int spinTicks;

          __asm__("" : : "i"(0));
          scale = true;
          __asm__("" : : "r"(scale));
          spinTicks = ticks[0];
          this->framenum = 0x14;
          if ((spinTicks - this->starttick / 4) % 0x5dc < 0x2d) {
            this->InExtraSpinTick = ticks[0];
            this->InExtraSpin = 1;
          }
        }
      }
    }
    else {
      drawFlags.tint[0] = CalcFadeVal(0x646464,fJustFadeOff);
      drawFlags2.tint[0] = CalcFadeVal(0x808080,fJustFadeOff);
      this->framenum = (ticks[0] - this->starttick) / 4;
      if (0x14 < this->framenum) {
        this->framenum = 0x14;
      }
      __asm__("" : : "i"(0));
    }
    if (scale) {
      ScaleShapeExtended(this->framenum,0x410,0,
                         (this->congratsMessage == kScreenCongrats_Eliminated) ? 0xA : 0,
                         0,0,&drawFlags);
    }
    else {
      DrawShapeExtended(this->framenum,0x410,0,
                        (this->congratsMessage == kScreenCongrats_Eliminated) ? 0xA : 0,
                        0,0,&drawFlags);
    }
    if ((uint)(this->trophy - kTrophyCar) >= 2) {
      ScaleShapeExtended((ticks[0] / 12) % 0x20,0x610,0x46,0xf,0,0,&drawFlags2);
    }
    if ((uint)this->trophy >= (uint)kTrophyCar) {
      switch (this->smallSpinningThing) {
      case kSpinningGold:
        ScaleShapeExtended((ticks[0] >> 3) % this->fNumSmallSpinShapes,
                           0x610,0x29,0xbe,0,0,&drawFlags2);
        break;
      case kSpinningMemCard:
        drawFlags.tint[0] = 0x551e00;
        DrawShapeExtended((ticks[0] / 0x14) % this->fNumSmallSpinShapes,
                          0x610,-0xc1,0x56,0,0,&drawFlags);
        break;
      }
    }
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
  }
  bannerframe = (this->congratsMessage == kScreenCongrats_Congrats) ? 0x2A : 0x15;
  drawFlags3.tint[0] = CalcFadeVal(StripeRGB,this->fScreenFadeVal);
  if ((this->congratsMessage == kScreenCongrats_Congrats) &&
      (this->trophy != kTrophyCar)) {
    {
      int i;

      for (i = 1; i < 0x1e; i++) {
        if ((i % 3) != 0) {
          DrawShapeExtended(bannerframe,0x410,i * 2,0,
                            this->fScreenFadeVal,1,&drawFlags3);
        }
      }
    }
    {
      int i;

      for (i = 0x22; i < 0x3f; i++) {
        if ((i % 3) != 0) {
          DrawShapeExtended(bannerframe,0x410,i * 2,0,
                            this->fScreenFadeVal,1,&drawFlags3);
        }
      }
    }
  }
  else {
    int i;

    for (i = 7; i < 0x28; i++) {
      if ((i % 3) != 0) {
        DrawShapeExtended(bannerframe,0x410,i * 2,0,
                          this->fScreenFadeVal,1,&drawFlags3);
      }
    }
  }
  if ((this->trophy == kTrophyCar) && (this->fGotCar != 0)) {
    DrawCar(&this->fCarInfo,this->fCarX,this->fCarY,this->fCarCX,this->fCarCY,
            (showRoomFlag[0] = 0, -0x80),true,carRotate,(tPlayer)this->fCarPlayer);
  }
  return;
}

/* ---- tScreenCongrats::DrawForeground  (screencongrats.cpp:360) ---- */
void tScreenCongrats::DrawForeground()

{
  return;
}

/* ---- tScreenCongrats::CalculatePrizes  (screencongrats.cpp:365) ---- */
void tScreenCongrats::CalculatePrizes()

{
  unsigned long carCYBits = 0xc0eccccd;
  unsigned long carCXBits = 0x40800000;

  /* MATCH (2026-08-12, 8 -> 4 diffs, exact 29/29): spelling BOTH float fields
     as raw-word locals gives gcc the two independent integer quantities seen
     in retail.  It now materializes/stores the -7.4 bits in $v1, schedules the
     message/zero stores correctly, and sinks fCarCX into the branch delay slot.
     The remaining coupled pair is only `lui $a1,0x4080` + the fCarY store:
     retail places both earlier.  Declaration order and a pure-C multi-set were
     neutral; early read/identity fences moved the message/CY group too early
     (8 diffs), and reversed X/Y stores also cost 8. */
  this->congratsMessage = kScreenCongrats_Congrats;
  this->trophy = kTrophyNone;
  this->smallSpinningThing = kSpinningNone;
  this->fCarPlayer = 0;
  this->TotalCash = 0;
  this->CashAwarded = -1;
  this->fCarX = 0x116; this->fCarY = 0x3f;
  *(unsigned long *)&this->fCarCY = carCYBits;
  *(unsigned long *)&this->fCarCX = carCXBits;
  if (this->congratsMessage == kScreenCongrats_Eliminated) {
    this->fCarX = 0x120;
    this->fCarY = 0x49;
    this->fCarCY = -8.2;
  }
  __asm__("" : : "r"(carCXBits));
  return;
}

/* ---- tScreenCongrats::Initialize  (screencongrats.cpp:385) ---- */
void tScreenCongrats::Initialize()

{
  __vtbl_ptr_type (*vtbl) [10];
  int tick;

  tick = ticks[0];
  this->fSpeechToPlay = 0;
  this->starttick = -1;
  this->framenum = -1;
  this->InExtraSpin = 0;
  this->fEnterTick = tick;
  SetLicensePlate();
  vtbl = this->_vf;
  (*vtbl[1][0].pfn)((char *)this + vtbl[1][0].delta);
  vtbl = this->_vf;
  tick = (*vtbl[1][2].pfn)
                    ((char *)this + vtbl[1][2].delta,
                     &this->fCarInfo);
  this->fGotCar = tick;
  /* MATCH: use the field directly in the comparison and division. GCC CSEs the
     load later, after lowering signed /64 to retail's bgez/addiu/sra sequence;
     a cached local lets its value-range pass incorrectly remove that sequence. */
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
  return;
}

/* ---- tScreenCongrats::ProcessInput  (screencongrats.cpp:423) ---- */
void tScreenCongrats::ProcessInput(tPlayer p,tInputKeyType &keyval,tMenuCommand &c)

{
  extern SPEECHINFO ginfo;   /* global @0x800514e8 (feaudio.cpp); oracle reads ginfo+0x10 as lhu */
  bool bConsumeKey;

  if (keyval != kInput_KeyType_Circle) {
    bConsumeKey = false;
    if ((*(u_short *)((char *)&ginfo + 0x10) != 0) || (ticks[0] - this->starttick < 0x96)) {
      bConsumeKey = true;
    }
    if (bConsumeKey) {
      keyval = kInput_KeyType_AlreadyProcessed;
    }
  }
  return;
}

/* ---- tScreenPinkSlipCongrats::DrawCongratsMessage  (screencongrats.cpp:432) ---- */
void tScreenPinkSlipCongrats::DrawCongratsMessage()

{
  /* SYM 8c @0x80048B48: the ONLY locals are `RECT r` (AUTO -0x120) and
     `char buffer[250]` (AUTO -0x118); `this` is REGPARM $13 = $s3.  The four
     char* temps the earlier recon carried (fmt/name1/word/name2) are Ghidra
     fictions -- retail spells the four helper calls INLINE in the sprintf
     argument list, so their results live in whatever callee-saved regs the
     allocator hands out ($s2/$s1/$s0), and `this` keeps $s3.  (W55-A15) */
  RECT r;
  char buffer [250];

  /* @0x80048B54-70: oracle materializes a real RECT{x=0x29,y=0x3C,w=0x1A4,h=0xC8} local. */
  r.x = 0x29;
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
  /* @0x80048C34: WordWrapText's 1st arg is `addiu a0,sp,0x20` = BUFFER, not sprintf's
     return value (the old `fmt = (char *)sprintf(...)` funnel was a transcription bug). */
  FETextRender_WordWrapText(buffer,r,textState_Selected,textType_PostGame);
  return;
}

/* ---- tScreenPinkSlipCongrats::GetCar  (screencongrats.cpp:456) ---- */
int tScreenPinkSlipCongrats::GetCar(tCarInfo &carInfo)

{

  GetPinkSlipsCar(&carManager,
             (ushort)(byte)frontEnd.pinkSlipsCar[1 - this->fWinner],&carInfo,
             1 - this->fWinner);
  carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  return 1;
}

/* ---- tScreenPinkSlipCongrats::CalculatePrizes  (screencongrats.cpp:463) ---- */
void tScreenPinkSlipCongrats::CalculatePrizes()

{
  __vtbl_ptr_type (*vtbl)[10];
  int player;
  int speechId2;
  tCarInfo carinfo;

  /* MATCH (W54-A7, from the SYM SLD line map of 0x80048CDC..0x80048DEC):
     retail's statement order is EXACTLY 464 TotalCash / 465 CashAwarded /
     466 congratsMessage / 467 trophy / 468 smallSpinningThing /
     469 fCarPlayer / 471 player.  There is NO `winner` local: line 469 and
     line 471 each RE-READ this->fWinner (two `lh 0x184` + two `subu`). */
  this->TotalCash = 0;
  this->CashAwarded = -1;
  this->congratsMessage = kScreenCongrats_Congrats;
  this->trophy = kTrophyCar;
  this->smallSpinningThing = kSpinningMemCard;
  this->fCarPlayer = 1 - this->fWinner;

  player = 1 - this->fWinner;
  CarIO_CleanUpLicense(player);
  CarIO_CreateLicense((char *)((int)&frontEnd + (1 - player) * 8 + 900),0,player);
  vtbl = this->_vf;
  (*vtbl[1][2].pfn)
            /* MATCH: explicit int-cast with the BASE first -> oracle `addu $a0,$s3,$a0`
               (the natural `p + delta` form emits the operands the other way round). */
            ((char *)((int)this->fPermShapes.fFilename + (vtbl[1][2].delta + -0x14)),&carinfo);
  /* @0x80048D74: oracle `lb v1,0xD1(sp)` reads fSpeechCarID as SIGNED (matches its use in a real
   * `==-1` compare below); tCarInfo::fSpeechCarID is a shared-header plain `char` (platform default
   * unsigned on this toolchain, hence a stray `lbu` -- cast to `signed char` here, in-TU only).
   * @0x80048D7C: oracle's `beq v1,s2,.L(==-1 case)` computes the `!=-1` (else) body INLINE on the
   * fallthrough and jumps PAST the ==-1 body -- invert the branch polarity to match. */
  speechId2 = (signed char)carinfo.fSpeechCarID;
  if (speechId2 != -1) {
    /* @0x80048D84-8C: oracle adds 0x13 to fWinner FIRST (`lh v0,388;addiu v0,19`), THEN adds the
     * doubled speech-car-id (`addu v1,v1,v0`) -- explicit grouping to match that addition order. */
    /* MATCH (W57-A7 SEAL, 3 -> PASS 68/68): a THREE-STEP IN-PLACE MUTATION CHAIN on ONE
       local is the whole lever -- `speechId2 = (signed char)fSpeechCarID;` before the test,
       then `speechId2 = speechId2 * 2;` and `speechId2 = speechId2 + base;` inside the arm.
       Each `x = x <op> y` keeps the SAME pseudo as dest, so the load lands in $v1, the sll is
       in-place (`sll v1,v1,1`, reorg steals it into the beq slot), and the sum's dest is that
       dying $v1 (`addu v1,v1,v0`).  Because arm-1's value then lives in $v1 while the else
       arm's lives in $v0, post-reload cross_jump CANNOT merge the two `sw ...,0x174` stores
       (rtx_renumbered_equal_p on different hard regs) -> retail's per-arm store, arm-1's copy
       riding the `j` delay slot.  `base` MUST stay its own statement (fold's constant
       reassociation is statement-granular: inlining `(fWinner + 0x13)` re-associates to
       `(id2 + 0x13) + fWinner` -> 9-14 diffs).  Falsified at the pre-mutation basin: <<1 vs *2,
       both operand orders, flat 3-term forms, a named product temp, a named speech
       accumulator, void-tail fences in/after the else arm. */
    int base = this->fWinner + 0x13;

    speechId2 = speechId2 * 2;
    speechId2 = speechId2 + base;
    this->fSpeechToPlay = speechId2;
  }
  else {
    this->fSpeechToPlay = this->fWinner + 0x17;
  }
  this->fCarX = 0x116;
  this->fCarY = 0x4b;
  this->fCarCX = 4.0;
  this->fCarCY = -7.4;
  return;
}

/* ---- tScreenPinkSlipCongrats::Initialize  (screencongrats.cpp:491) ---- */
void tScreenPinkSlipCongrats::Initialize()

{
  this->fWinner = -1;
  if ((int)(((byte)frontEnd.pinkSlipsNumTracks >> 1) + 1) <= (int)(byte)frontEnd.pinkSlipsWins[0]) {
    this->fWinner = 0;
  }
  else {
    this->fWinner = 1;
  }
  this->tScreenCongrats::Initialize();
  return;
}

/* ---- tScreenPinkSlipCongrats::Cleanup  (screencongrats.cpp:505) ---- */
void tScreenPinkSlipCongrats::Cleanup()

{
  
  CleanupSpinningCarsMenu();
  this->tScreen::Cleanup();
  return;
}

/* ---- tScreenTournamentTrophy::ProcessInput  (screencongrats.cpp:518) ---- */
void tScreenTournamentTrophy::ProcessInput(tPlayer p,tInputKeyType &keyval,tMenuCommand &c)

{
  if ((keyval == kInput_KeyType_Cross) && (this->fCountedDown == 0)) {
    keyval = kInput_KeyType_AlreadyProcessed;
    this->fStartCountdownNOW = 1;
  }
  this->tScreenCongrats::ProcessInput(p,keyval,c);
  return;
}

/* ---- tScreenTournamentTrophy::GetCar  (screencongrats.cpp:531) ---- */
int tScreenTournamentTrophy::GetCar(tCarInfo &carInfo)

{
  tCarInfo *srcCar;
  tAwardInformation tInfo;
  
  if (this->congratsMessage == kScreenCongrats_Congrats) {
    GetAwardInformation(&tournamentManager,&tInfo);
    srcCar = GetCarFromID(&carManager, (u_short)tInfo.fAwardCarModel);
    blockmove(srcCar,&carInfo,0xcc);
    carInfo.fUpgrades = tInfo.fAwardCarUpgrades;
    carInfo.fColor = tInfo.fAwardCarColor;
  }
  else {
    GetGarageCar(&carManager, (ushort)(byte)frontEnd.garageCar[0],&carInfo,0);
    carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  }
  return 1;
}

/* ---- tScreenTournamentTrophy::DrawCongratsMessage  (screencongrats.cpp:555) ---- */
void tScreenTournamentTrophy::DrawCongratsMessage()

{
  /* MATCH: locals + block scopes taken VERBATIM from the SYM 8c block
     (fsize 1456, mask $801f0000 = ra,s0-s4):
       fn scope  AUTO  r, tInfo, buffer1[500], buffer2[500], buffer[256], money[64]
       blk @567  REG   firstmessage($s2), secondmessage($s3), tourneyInfo($s1)
       blk @575  REG   placeoffset($s0)
       blk @639  REG   yyy($s0)
     Ghidra's word/word2/trophyClass are FABRICATED (absent from the SYM) --
     they cost a 6th saved register ($s5) and 8 bytes of frame. */
  RECT r;
  tAwardInformation tInfo;
  char buffer1 [500];
  char buffer2 [500];
  char buffer [256];
  char money [64];

  r.x = 0x29;
  r.y = 0x3c;
  r.w = 200;
  r.h = 400;
  /* MATCH: the non-Congrats message is the ELSE arm (oracle `bnez $v0,.L800491DC`
     branches FORWARD to a block sitting just before the epilogue). */
  if (this->congratsMessage == kScreenCongrats_Congrats) {
    int firstmessage;
    int secondmessage;
    tTourneyInfo *tourneyInfo;

    secondmessage = firstmessage = 0;   /* oracle: `addu s2,zero,zero; addu s3,s2,zero` */
    tourneyInfo = &(tournamentManager.fDefinition)->fTournaments
             [(uint)(tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset +
              tournamentManager.fTournament];
    /* fPrevBestPlacement/fTournamentID are shared-header plain `char` (unsigned by platform
     * default); the oracle reads BOTH signed (`lb`) throughout -- cast at every read site. */
    if ('\x03' < (signed char)tournamentManager.fPrevBestPlacement) {
      int placeoffset;

      firstmessage = (signed char)tourneyInfo->fTournamentID + 0x3b3;
      /* MATCH: a real switch -- oracle is gcc's case TREE over {0},{1},{3}
         (root ==1, slti 2, then ==0 / ==3) with bodies in source order 0,1,default. */
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
        ((signed char)tournamentManager.fPrevBestPlacement != '\x01')) ||
       (this->trophy == kTrophyCar)) {
      /* two separate sprintf calls -- gcc cross-jump-merges them into the oracle's
         single `.L800490EC: jal sprintf` with only the $a0 setup per arm. */
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
    GetAwardInformation(&tournamentManager,&tInfo);
    if (tInfo.fAwardCarGarageFull != 0) {
      r.x = 0x104;
      r.y = 200;
      r.w = 0xf0;
      FeTools_FormatMoney(money,tInfo.fAwardCarBonusMoney);
      sprintf(buffer,TextSys_Word(0x40),money);
      FETextRender_WordWrapTextFade
                ((int)this->fScreenFadeVal,TextSys_Word(0x40),r,textState_Selected,
                 textType_PostGame);
    }
  }
  else {
    int yyy;

    /* MATCH: the -10 bias is folded into the jal delay slot (oracle
       `addiu $s0,$v0,-0xA`); computing it after the call costs a copy + addiu. */
    yyy = TextSys_WordY(800) + -10;
    FETextRender_FullTextRGB(TextSys_Word(800),0x120,(short)((uint)(yyy * 0x10000) >> 0x10),
                             0x414141,'\x03',2);
  }
  return;
}

/* ---- tScreenTournamentTrophy::CalculatePrizes  (screencongrats.cpp:654) ---- */
void tScreenTournamentTrophy::CalculatePrizes()

{
  /* MATCH (2026-08-12, 115 -> PASS, exact 144/144): rebuilt from the
     trusted SYM allocation contract (i=$s1, j=$s3, tInfo=sp+0x10,
     tourneyInfo=$s5, this=$s2) and IDA/SLD control flow.  The decompiler's
     ranking/numRanked/tourIndex/place locals caused the original whole-body
     register cascade.  A void boundary after the spinner reset prevents
     sched2 from hoisting the tournament-money address setup across that
     store.  The separate m2c body exposed the signed manager halfword as its
     own working value before the short sum; `ranked` plus a short `numRanked`
     reproduces retail's `lh` and post-add 16-bit truncation (4 -> 2) without
     changing allocation.  The final store group needs the 4.0f high half in
     $a0 before the -7.4f pair while retaining the preceding delay-slot nop:
     a pin-free identity fence on a block-local raw word plus a zero-insn
     boundary does that; a short-lived `cashAwarded` working value sinks its
     store behind both materializations.  No volatile or fixed-register pin. */
  long money;
  int i;
  int j;
  tAwardInformation tInfo;
  tTourneyInfo *tourneyInfo;

  this->congratsMessage = kScreenCongrats_Eliminated;
  this->trophy = kTrophyNone;
  this->smallSpinningThing = kSpinningMemCard;
  GetAwardInformation(&tournamentManager,&tInfo);
  j = 900;
  /* @0x800492A8-D4/0x80049380: oracle computes the tourneyInfo (fTournaments[tourIndex]) POINTER
   * ONCE (kept live in s5) and reuses it for BOTH fKnockout checks below (numRanked's ".fKnockout"
   * AND the later `def->fTournaments[tourIndex].fKnockout` re-test) -- one named local matches. */
  tourneyInfo = &(tournamentManager.fDefinition)->fTournaments[
      (uint)(tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset +
      tournamentManager.fTournament];
  i = 1;
  {
    int knockout = !!tourneyInfo->fKnockout;
    int ranked = *(short *)((char *)&tournamentManager + 0x10);
    short numRanked = ranked + knockout;
    if (0 < numRanked) {
      int loopLimit = numRanked;
      do {
        if (PlayerRanking(&tournamentManager,(short)i) == 0) {
          j = i;
        }
        i = i + 1;
      } while (i <= loopLimit);
    }
  }
  if (j == 1) goto first_place;
  if (j <= 0) goto eliminated;
  if (j >= 4) goto eliminated;
  goto ranked_finish;

first_place:
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
    goto prizes_done;
  }

ranked_finish:
  if (tourneyInfo->fKnockout != '\0') goto eliminated;
  this->fSpeechToPlay = j + 0xe;
  this->congratsMessage = kScreenCongrats_Congrats;
  this->trophy = j == 2 ? kTrophySilver : kTrophyBronze;
  goto prizes_done;

eliminated:
  this->congratsMessage = kScreenCongrats_Eliminated;
  this->trophy = kTrophyCar;

prizes_done:
  this->smallSpinningThing = kSpinningNone;
  __asm__("" : : "i"(0));
  this->fCarPlayer = 0;
  money = tournamentManager.fMoney;
  this->TotalCash = money;
  if (tInfo.fCompletedGarageFull != 0) {
    this->TotalCash = money - tInfo.fCompletedBonusMoney;
  }
  long cashAwarded = tInfo.fTournMoney == 0 ? -1 : tInfo.fTournMoney;
  __asm__("" : : "i"(0));
  {
    unsigned long carCXBits = 0x40800000;
    __asm__("" : "=r"(carCXBits) : "0"(carCXBits));
    this->CashAwarded = cashAwarded;
    this->fCarX = 0x116;
    this->fCarY = 0x3f;
    this->fCarCY = -7.4;
    *(unsigned long *)&this->fCarCX = carCXBits;
  }
  if (this->congratsMessage == kScreenCongrats_Eliminated) {
    this->fCarX = 0x120;
    this->fCarY = 0x49;
    this->fCarCY = -8.2;
  }
  return;
}

/* ---- tScreenBeTheCopCongrats::GetCar  (screencongrats.cpp:746) ---- */
int tScreenBeTheCopCongrats::GetCar(tCarInfo &carInfo)

{
  tCarInfo *srcCar;
  
  srcCar = GetCarFromID(&carManager, (ushort)(byte)frontEnd.congratsCopCar);
  blockmove(srcCar,&carInfo,0xcc);
  carInfo.fCountry = frontEnd.congratsCopCountry;
  return 1;
}

/* ---- tScreenBeTheCopCongrats::CalculatePrizes  (screencongrats.cpp:756) ---- */
void tScreenBeTheCopCongrats::CalculatePrizes()

{
  
  this->tScreenCongrats::CalculatePrizes();
  this->trophy = kTrophyCar;
  this->fCarX = 0x116;
  this->fCarY = 0x4b;
  this->fCarCX = 4.0;
  this->fCarCY = -7.4;
  return;
}

/* ---- tScreenBeTheCopCongrats::DrawCongratsMessage  (screencongrats.cpp:766) ---- */
void tScreenBeTheCopCongrats::DrawCongratsMessage()

{
  uint padState;
  char *fmt;
  char *copWord;
  RECT r;
  tMenuTextState fade;
  int wordnum;
  char buffer [250];

  /* @0x80049540-58: oracle materializes a real RECT{x=0x29,y=0x3C,w=0xC8,h=0xC8} local (same idiom
   * as TournamentTrophy's DrawCongratsMessage, h differs: 0xC8 here not 0x190) -- the prior recon's
   * `(RECT*)(uint)(byte)congratsCopCar` cast was a bogus reuse of the field-compare value as the
   * RECT pointer arg (dropped the real RECT init entirely). */
  r.x = 0x29;
  r.y = 0x3c;
  r.w = 200;
  r.h = 200;
  /* @0x80049598/end: oracle's FETextRender_WordWrapText 3rd arg is a LITERAL `li a2,1` (=
   * textState_Selected), not a read of an uninitialized `fade` local. */
  fade = textState_Selected;
  wordnum = 0x4c;
  if (frontEnd.congratsCopCar == 0x1c) {
    wordnum = 0x4d;
  }
  padState = PAD_state(4);
  if ((padState & 0xffff) != 0) {
    /* fCarID is a shared-header plain `char` (unsigned by platform default); oracle reads it
     * SIGNED (`lb`) here -- cast in-TU only, matches the fSpeechCarID precedent elsewhere. */
    TextSys_Word((signed char)this->fCarInfo.fCarID + 0x121);
  }
  fmt = TextSys_Word(wordnum);
  copWord = TextSys_Word((signed char)this->fCarInfo.fCarID + 0x121);
  sprintf(buffer,fmt,copWord);
  FETextRender_WordWrapText(buffer,r,fade,textType_PostGame);   /* MATCH: pass buffer (addr held in s0 across sprintf, 3.12#16), NOT sprintf's return */
  return;
}

/* ---- tScreenTournamentCongrats::GetCar  (screencongrats.cpp:796) ---- */
int tScreenTournamentCongrats::GetCar(tCarInfo &carInfo)

{
  tCarInfo *srcCar;
  tAwardInformation tInfo;
  
  GetAwardInformation(&tournamentManager,&tInfo);
  srcCar = GetCarFromID(&carManager, (u_short)tInfo.fCompletedCar);
  blockmove(srcCar,&carInfo,0xcc);
  return 1;
}

/* ---- tScreenTournamentCongrats::CalculatePrizes  (screencongrats.cpp:807) ---- */
void tScreenTournamentCongrats::CalculatePrizes()

{
  long cash;
  tAwardInformation tInfo;
  
  GetAwardInformation(&tournamentManager,&tInfo);
  this->tScreenCongrats::CalculatePrizes();
  this->trophy = kTrophyCar;
  this->TotalCash = tournamentManager.fMoney;
  cash = -1;
  if (tInfo.fCompletedGarageFull != 0) {
    cash = tInfo.fCompletedBonusMoney;
  }
  this->CashAwarded = cash;
  this->fCarX = 0x116;
  this->fCarY = 0x4b;
  this->fCarCX = 4.0;
  this->fCarCY = -7.4;
  return;
}

/* ---- tScreenTournamentCongrats::DrawCongratsMessage  (screencongrats.cpp:825) ---- */
void tScreenTournamentCongrats::DrawCongratsMessage()

{
  char *word;
  RECT r;
  tMenuTextState fade;
  tAwardInformation tInfo;
  char buffer [256];
  char money [64];

  /* @0x800496E0-FC/0x39F4C-58: oracle materializes a real RECT{x=0x29,y=0x3C,w=0xC8,h=0x190} local
   * (same idiom as the sibling DrawCongratsMessage fns) then, inside the fCompletedGarageFull branch,
   * OVERWRITES r.w/r.h to {0xB4,0x1AE} for the money-line rewrap -- the prior recon's uninitialized
   * `RECT *r;`/`tMenuTextState fade;` dropped this entirely (real bug: NULL/garbage RECT ptr). */
  r.x = 0x29;
  r.y = 0x3c;
  r.w = 200;
  r.h = 400;
  /* oracle's FETextRender_WordWrapText 3rd arg is a LITERAL `li a2,1` (=textState_Selected), not a
   * read of an uninitialized `fade` local (both call sites). */
  fade = textState_Selected;
  GetAwardInformation(&tournamentManager,&tInfo);
  word = TextSys_Word((int)tInfo.fCompletedText);
  FETextRender_WordWrapText(word,r,fade,textType_PostGame);
  if (tInfo.fCompletedGarageFull != 0) {
    /* @0x39F4C-58: oracle overwrites r.y/r.w here (NOT r.w/r.h) -- confirmed via the exact sp
     * offsets (0x12=r.y, 0x14=r.w), not a naive "next two fields" guess. */
    r.y = 0xb4;
    r.w = 0x1ae;
    FeTools_FormatMoney(money,tInfo.fCompletedBonusMoney);
    word = TextSys_Word(0x40);
    sprintf(buffer,word,money);
    word = TextSys_Word(0x40);
    FETextRender_WordWrapText(word,r,fade,textType_PostGame);
  }
  return;
}

/* ---- tScreenTournamentCongrats::~tScreenTournamentCongrats  (screencongrats.cpp:161) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___25tScreenTournamentCongrats(void *thisp) { ___7tScreen(thisp); }

/* ---- tScreenBeTheCopCongrats::~tScreenBeTheCopCongrats  (screencongrats.cpp:151) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___23tScreenBeTheCopCongrats(void *thisp) { ___7tScreen(thisp); }

/* ---- tScreenPinkSlipCongrats::~tScreenPinkSlipCongrats  (screencongrats.cpp:141) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___23tScreenPinkSlipCongrats(void *thisp) { ___7tScreen(thisp); }

/* ---- tScreenTournamentTrophy::~tScreenTournamentTrophy  (screencongrats.cpp:126) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___23tScreenTournamentTrophy(void *thisp) { ___7tScreen(thisp); }

/* ---- tScreenCongrats::~tScreenCongrats  (screencongrats.cpp:109) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___15tScreenCongrats(void *thisp) { ___7tScreen(thisp); }

/* end of screencongrats.cpp */
