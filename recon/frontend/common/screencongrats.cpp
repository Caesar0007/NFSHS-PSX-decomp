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
  this->_base_tScreen.Cleanup();
  return;
}

/* ---- tScreenCongrats::GetShapeInfo  (screencongrats.cpp:64) ---- */
void tScreenCongrats::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)

{
  byte tournOffset;
  tTournamentDefinition *def;
  short ranking;
  int numRanked;
  u_short numShapes;
  char *prefix;
  int i;
  int place;
  tTourneyInfo *tourneyInfo;
  
  def = tournamentManager.fDefinition;
  place = tournamentManager.fTournament;
  tournOffset = (tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset;
  this->fNumSmallSpinShapes = 0;
  this->fNumSpinShapes = 0;
  tourneyInfo = def->fTournaments + (uint)tournOffset + place;
  numShapes = 0x16;
  if (this->congratsMessage == kScreenCongrats_Congrats) {
    numShapes = 0x2b;
  }
  numPermShapes = numShapes;
  if (this->congratsMessage == kScreenCongrats_Congrats) {
    prefix = "zcong";
  }
  else {
    prefix = "zelim";
  }
  sprintf("","%s%d",prefix,(uint)(byte)frontEnd.language);
  *permFileName = "";
  if (this->trophy - kTrophyCar < 2) {
    if (this->smallSpinningThing == kSpinningGold) {
      numSwapShapes = 0x20;
      this->fNumSmallSpinShapes = 0x20;
      GetTrophyName(&tournamentManager,tourneyInfo,ts_Small,"",-1);
      *swapFileName = "";
    }
    else if (this->smallSpinningThing == kSpinningMemCard) {
      numSwapShapes = 10;
      this->fNumSmallSpinShapes = 10;
      *swapFileName = "congb";
    }
    else {
      *swapFileName = "";
      numSwapShapes = 0;
    }
  }
  else {
    place = 900;
    numRanked = (int)(((int)(short)tournamentManager.fNumRacers + (uint)(tourneyInfo->fKnockout != '\0')) *
                 0x10000) >> 0x10;
    i = 1;
    if (0 < numRanked) {
      do {
        ranking = PlayerRanking(&tournamentManager,(short)i);
        if (ranking == 0) {
          place = i;
        }
        i = i + 1;
      } while (i <= numRanked);
    }
    GetTrophyName(&tournamentManager,tourneyInfo,ts_Large,"",place);
    *swapFileName = "";
    numSwapShapes = 0x20;
    this->fNumSpinShapes = 0x20;
  }
  return;
}

/* ---- tScreenCongrats::GetCar  (screencongrats.cpp:121) ---- */
void tScreenCongrats::GetCar(tCarInfo &carInfo)

{
  
  GetGarageCar(&carManager, (ushort)(byte)frontEnd.garageCar[0],&carInfo,0);
  carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  return;
}

/* ---- tScreenCongrats::DrawBackground  (screencongrats.cpp:128) ---- */
void tScreenCongrats::DrawBackground()

{
  static u_long carRotate;   /* [SYM] STAT (rotation accumulator, persists across calls) */
  bool bDrawSpin;
  tCarInfo *carShape;
  int j;
  int wordX;
  int wordY;
  int StripeRGB;
  tTrophyClass trophyClass;
  int i;
  __vtbl_ptr_type (*vtbl) [10];
  int fadeAmt;
  int bannerframe;
  tCarInfo *carInfo;
  int fJustFadeOff;
  tDrawShapeExtended drawFlags;
  tDrawShapeExtended drawFlags2;
  tDrawShapeExtended drawFlags3;
  
  drawFlags.custom_shapes = (this->_base_tScreen).fSwapShapes.fShapes;
  drawFlags2.custom_shapes = (this->_base_tScreen).fSwapShapes.fShapes;
  vtbl = (this->_base_tScreen)._vf;
  StripeRGB = (int)vtbl[1][1].delta;
  carRotate = carRotate + 3;
  (*vtbl[1][1].pfn)((this->_base_tScreen).fPermShapes.fFilename + StripeRGB + -0x14);
  trophyClass = (tTrophyClass)this->trophy;
  if ((((trophyClass == kTrophyCar) && (this->starttick == -1)) ||
      ((this->fGotCar == 0 && (trophyClass == kTrophyCar)))) ||
     ((trophyClass == kTrophyCar && ((-1 < R3DCar_aSyncLoading || (ticks - this->fEnterTick < 0x3c)))))) {
    this->starttick = ticks;
  }
  else {
    if (this->starttick == -1) {
      this->starttick = ticks;
    }
    if (this->CashAwarded != -1) {
      if ((1000 < ticks - this->starttick) || (this->fStartCountdownNOW != 0)) {
        if (this->CashAwarded != 0) {
          AudioCmn_PlayFESFX(0x15);
        }
        i = this->CashAwarded - this->fCountSpeed;
        this->CashAwarded = i;
        if (i < 0) {
          this->CashAwarded = 0;
          this->fCountedDown = 1;
        }
      }
      i = CalcFadeVal(kRGBVals[(byte)textDefinitions[0xb][5]],fadeAmt);
      j = CalcFadeVal(0x232323,fadeAmt);
      FETextRender_MenuTextFade((int)(this->_base_tScreen).fScreenFadeVal,0x317,textState_Hilighted,textType_TrackRecords
                );
      wordX = TextSys_WordX(0x318);
      wordY = TextSys_WordY(0x318);
      DrawMoney
                (wordX,wordY,6,this->CashAwarded,i,j);
      FETextRender_MenuTextFade
                ((int)(this->_base_tScreen).fScreenFadeVal,0x316,textState_Hilighted,textType_TrackRecords
                );
      wordX = TextSys_WordX(0x319);
      wordY = TextSys_WordY(0x319);
      fadeAmt = 9;
      DrawMoney
                (wordX,wordY,9,this->TotalCash - this->CashAwarded,i,j);
    }
    if ((this->fSpeechToPlay != 0) && (0x80 < ticks - this->starttick)) {
      FeAudio_AsyncPlaySpeech(2,this->fSpeechToPlay);
      this->fSpeechToPlay = 0;
    }
    bDrawSpin = false;
    if (this->congratsMessage == kScreenCongrats_Congrats) {
      drawFlags.tint[0] = CalcFadeVal(0xbebe,fadeAmt);
      drawFlags2.tint[0] = CalcFadeVal(0x808080,fadeAmt);
      if (this->InExtraSpin == 0) {
        j = (ticks - this->starttick) / 2;
        this->framenum = j;
        i = ticks;
        if (0x13 < j) {
          bDrawSpin = true;
          wordX = this->starttick;
          this->framenum = 0x14;
          j = ticks;
          if (wordX < 0) {
            wordX = wordX + 3;
          }
          i = i - (wordX >> 2);
          bannerframe = (int)((unsigned long long)((long long)i * 0x57619f1) >> 0x20);
          if (i % 0x5dc < 0x2d) {
            this->InExtraSpin = 1;
            this->InExtraSpinTick = j;
          }
        }
      }
      else {
        j = ticks - this->InExtraSpinTick;
        i = j >> 0x1f;
        bannerframe = j / 6 + i;
        i = (bannerframe - i) + 0x15;
        this->framenum = i;
        bDrawSpin = true;
        if (0x29 < i) {
          this->InExtraSpin = 0;
          this->framenum = 0x14;
        }
      }
    }
    else {
      drawFlags.tint[0] = CalcFadeVal(0x646464,fadeAmt);
      drawFlags2.tint[0] = CalcFadeVal(0x808080,fadeAmt);
      i = ticks - this->starttick;
      if (i < 0) {
        i = i + 3;
      }
      this->framenum = i >> 2;
      if (0x14 < i >> 2) {
        this->framenum = 0x14;
      }
    }
    if (bDrawSpin) {
      fadeAmt = 0;
      ScaleShapeExtended    /* @0x80048584 idx=framenum(132) flags=0x410 x=0 y=(off100==1?0xA:0) */
                (this->framenum,0x410,0,
                 (this->congratsMessage == kScreenCongrats_Eliminated) ? 0xA : 0,0,0,&drawFlags);
    }
    else {
      fadeAmt = 0;
      DrawShapeExtended     /* @0x800485c0 idx=framenum flags=0x410 x=0 y=(off100==1?0xA:0) */
                (this->framenum,0x410,0,
                 (this->congratsMessage == kScreenCongrats_Eliminated) ? 0xA : 0,0,0,&drawFlags);
    }
    if (1 < this->trophy - kTrophyCar) {
      bannerframe = ticks / 6 + (ticks >> 0x1f);
      fadeAmt = 0x46;
      ScaleShapeExtended    /* @0x80048630 idx=(ticks/6)%32 flags=0x610 x=0x46 y=0xF */
                ((ticks / 6) % 0x20,0x610,0x46,0xF,0,0,&drawFlags2);
    }
    if (kTrophyBronze < this->trophy) {
      if (this->smallSpinningThing == kSpinningGold) {
        if (this->fNumSmallSpinShapes == 0) {
          trap(0x1c00);
        }
        if ((this->fNumSmallSpinShapes == -1) && (ticks >> 3 == -0x80000000)) {
          trap(0x1800);
        }
        fadeAmt = 0x29;
        ScaleShapeExtended    /* @0x800486c0 idx=(ticks>>3)%fNumSmallSpinShapes flags=0x610 x=0x29 y=0xBE */
                  ((ticks >> 3) % this->fNumSmallSpinShapes,0x610,0x29,0xBE,0,0,&drawFlags2);
      }
      else if (this->smallSpinningThing == kSpinningMemCard) {
        drawFlags.tint[0] = 0x551e00;
        if (this->fNumSmallSpinShapes == 0) {
          trap(0x1c00);
        }
        if ((this->fNumSmallSpinShapes == -1) && (ticks / 0x14 == -0x80000000)) {
          trap(0x1800);
        }
        fadeAmt = -0xc1;
        DrawShapeExtended     /* @0x80048744 idx=(ticks/20)%fNumSmallSpinShapes flags=0x610 x=-0xC1 y=0x56 */
                  ((ticks / 0x14) % this->fNumSmallSpinShapes,0x610,-0xC1,0x56,0,0,&drawFlags);
      }
    }
  }
  if (this->congratsMessage == kScreenCongrats_Congrats) {
    trophyClass = (tTrophyClass)this->trophy;
    if (trophyClass == kTrophySilver) {
      i = 0x212121;
      goto DrawBgCongrats_emitShape;
    }
    if ((int)trophyClass < 2) {
      i = 0x30022;
      if (trophyClass != kTrophyGold) goto DrawBgCongrats_emitShape;
    }
    else {
      if (trophyClass == kTrophyBronze) {
        i = 0x3044;
        goto DrawBgCongrats_emitShape;
      }
      if (trophyClass != kTrophyCar) goto DrawBgCongrats_setFadeIdx;
    }
    i = 0x3e44;
  }
  else {
DrawBgCongrats_setFadeIdx:
    i = 0x30022;
  }
DrawBgCongrats_emitShape:
  /* loop base shape-index $s1 (oracle @0x800487b4-c4: off100==0 -> 0x2A, else 0x15) */
  bannerframe = (this->congratsMessage == kScreenCongrats_Congrats) ? 0x2A : 0x15;
  drawFlags3.tint[0] = CalcFadeVal(i,fadeAmt);
  if ((this->congratsMessage == kScreenCongrats_Congrats) && (i = 1, this->trophy != kTrophyCar)
     ) {
    j = 0;
    do {
      if (i != (j - (i >> 0x1f)) * 3) {
        DrawShapeExtended    /* @0x80048840 loop1 idx=bannerframe flags=0x410 x=i*2 y=0 */
                  (bannerframe,0x410,i * 2,0,
                   (int)(this->_base_tScreen).fScreenFadeVal,1,&drawFlags3);
      }
      i = i + 1;
      j = i / 3 + (i >> 0x1f);
    } while (i < 0x1e);
    i = 0x22;
    carShape = (tCarInfo *)0xb;
    do {
      carInfo = carShape;
      if (i != ((int)carInfo - (i >> 0x1f)) * 3) {
        DrawShapeExtended    /* loop2/3 idx=bannerframe flags=0x410 x=i*2 y=0 (@0x800488a4/0x80048910) */
                  (bannerframe,0x410,i * 2,0,
                   (int)(this->_base_tScreen).fScreenFadeVal,1,&drawFlags3);
      }
      i = i + 1;
      carShape = (tCarInfo *)(i / 3 + (i >> 0x1f));
    } while (i < 0x3f);
  }
  else {
    i = 7;
    carShape = (tCarInfo *)0x2;
    do {
      carInfo = carShape;
      if (i != ((int)carInfo - (i >> 0x1f)) * 3) {
        DrawShapeExtended    /* loop2/3 idx=bannerframe flags=0x410 x=i*2 y=0 (@0x800488a4/0x80048910) */
                  (bannerframe,0x410,i * 2,0,
                   (int)(this->_base_tScreen).fScreenFadeVal,1,&drawFlags3);
      }
      i = i + 1;
      carShape = (tCarInfo *)(i / 3 + (i >> 0x1f));
    } while (i < 0x28);
  }
  if ((this->trophy == kTrophyCar) && (this->fGotCar != 0)) {
    fJustFadeOff = 0;
    DrawCar
              (carInfo,this->fCarX,this->fCarY,this->fCarCX,this->fCarCY,-0x80,true,
               carRotate,(tPlayer)this->fCarPlayer);
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
  this->trophy = kTrophyNone;
  this->CashAwarded = -1;
  this->fCarX = 0x116;
  this->congratsMessage = kScreenCongrats_Congrats;
  this->fCarY = 0x3f;
  this->fCarCY = -7.4;
  this->smallSpinningThing = kSpinningNone;
  this->fCarPlayer = 0;
  this->TotalCash = 0;
  /* @0x80048A04: fCarCX=4.0 is written ONLY inside the congratsMessage==Eliminated branch (dead here --
   * congratsMessage was just set to Congrats=0 @0x800489E0). The recon hoisted it to an UNCONDITIONAL
   * store, so fCarCX always became 4.0 instead of retaining its prior value (M12). */
  if (this->congratsMessage == kScreenCongrats_Eliminated) {
    this->fCarCX = 4.0;
    this->fCarX = 0x120;
    this->fCarY = 0x49;
    this->fCarCY = -8.2;
  }
  return;
}

/* ---- tScreenCongrats::Initialize  (screencongrats.cpp:385) ---- */
void tScreenCongrats::Initialize()

{
  __vtbl_ptr_type (*vtbl) [10];
  int tick;
  int cashAwarded;
  
  tick = ticks;
  this->fSpeechToPlay = 0;
  this->starttick = -1;
  this->framenum = -1;
  this->InExtraSpin = 0;
  this->fEnterTick = tick;
  SetLicensePlate();
  vtbl = (this->_base_tScreen)._vf;
  (*vtbl[1][0].pfn)((this->_base_tScreen).fPermShapes.fFilename + vtbl[1][0].delta + -0x14);
  vtbl = (this->_base_tScreen)._vf;
  tick = (*vtbl[1][2].pfn)
                    ((this->_base_tScreen).fPermShapes.fFilename + vtbl[1][2].delta + -0x14,
                     &this->fCarInfo);
  cashAwarded = this->CashAwarded;
  this->fGotCar = tick;
  if (cashAwarded < 1) {
    this->fCountedDown = 1;
    this->fStartCountdownNOW = 1;
    cashAwarded = 1000;
  }
  else {
    this->fCountedDown = 0;
    this->fStartCountdownNOW = 0;
    if (cashAwarded < 0) {
      cashAwarded = cashAwarded + 0x3f;
    }
    cashAwarded = cashAwarded >> 6;
  }
  this->fCountSpeed = cashAwarded;
  this->_base_tScreen.Initialize();
  return;
}

/* ---- tScreenCongrats::ProcessInput  (screencongrats.cpp:423) ---- */
void tScreenCongrats::ProcessInput(tPlayer p,tInputKeyType &keyval,tMenuCommand &c)

{
  char ginfo[24];   /* decompiler gap: input-info buffer, no SYM local */
  bool bConsumeKey;
  
  if (keyval != kInput_KeyType_Circle) {
    bConsumeKey = false;
    if ((*(short *)(ginfo + 0x16) != 0) || (ticks - this->starttick < 0x96)) {
      bConsumeKey = true;
    }
    if (bConsumeKey) {
      keyval = kInput_KeyType_AlreadyProcessed;
    }
  }
  return;
}

/* ---- tScreenCongrats::~tScreenCongrats  (screencongrats.cpp:109) ---- */
tScreenCongrats::~tScreenCongrats()

{
  return;
}

/* ---- tScreenPinkSlipCongrats::DrawCongratsMessage  (screencongrats.cpp:432) ---- */
void tScreenPinkSlipCongrats::DrawCongratsMessage()

{
  char *fmt;
  char *name1;
  char *word;
  char *name2;
  RECT *r;
  tMenuTextState fade;
  char buffer [250];
  
  if ((byte)frontEnd.language - 2 < 2) {
    fmt = TextSys_Word(0x275);
    name1 = PlayerName((int)this->fWinner);
    word = TextSys_Word((this->_base_tScreenCongrats).fCarInfo.fCarID + 0x121);
    r = (RECT *)(int)this->fWinner;
    name2 = PlayerName(1 - (int)r);
  }
  else {
    fmt = TextSys_Word(0x275);
    name1 = PlayerName((int)this->fWinner);
    r = (RECT *)(int)this->fWinner;
    word = PlayerName(1 - (int)r);
    name2 = TextSys_Word((this->_base_tScreenCongrats).fCarInfo.fCarID + 0x121);
  }
  fmt = (char *)sprintf
                             (buffer,fmt,name1,word,name2,this->fWinner + 1);
  FETextRender_WordWrapText
            (fmt,r,fade,textType_PostGame);
  return;
}

/* ---- tScreenPinkSlipCongrats::GetCar  (screencongrats.cpp:456) ---- */
void tScreenPinkSlipCongrats::GetCar(tCarInfo &carInfo)

{
  
  GetPinkSlipsCar(&carManager, (ushort)*(byte *)((int)&frontEnd + (0x126 - this->fWinner)),&carInfo,
             1 - this->fWinner);
  carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  return;
}

/* ---- tScreenPinkSlipCongrats::CalculatePrizes  (screencongrats.cpp:463) ---- */
void tScreenPinkSlipCongrats::CalculatePrizes()

{
  __vtbl_ptr_type (*vtbl)[10];
  int player;
  tCarInfo carinfo;
  short winner;
  
  winner = this->fWinner;
  (this->_base_tScreenCongrats).trophy = kTrophyCar;
  (this->_base_tScreenCongrats).smallSpinningThing = kSpinningMemCard;
  winner = this->fWinner;
  (this->_base_tScreenCongrats).TotalCash = 0;
  (this->_base_tScreenCongrats).CashAwarded = -1;
  (this->_base_tScreenCongrats).congratsMessage = kScreenCongrats_Congrats;
  player = 1 - winner;
  (this->_base_tScreenCongrats).fCarPlayer = 1 - winner;
  CarIO_CleanUpLicense(player);
  CarIO_CreateLicense((char *)((int)&frontEnd + (1 - player) * 8 + 900),0,player);
  vtbl = (this->_base_tScreenCongrats)._base_tScreen._vf;
  (*vtbl[1][2].pfn)
            ((this->_base_tScreenCongrats)._base_tScreen.fPermShapes.fFilename +
             vtbl[1][2].delta + -0x14,&carinfo);
  if (carinfo.fSpeechCarID == -1) {
    (this->_base_tScreenCongrats).fSpeechToPlay = this->fWinner + 0x17;
  }
  else {
    (this->_base_tScreenCongrats).fSpeechToPlay = carinfo.fSpeechCarID * 2 + this->fWinner + 0x13;
  }
  (this->_base_tScreenCongrats).fCarX = 0x116;
  (this->_base_tScreenCongrats).fCarY = 0x4b;
  (this->_base_tScreenCongrats).fCarCX = 4.0;
  (this->_base_tScreenCongrats).fCarCY = -7.4;
  return;
}

/* ---- tScreenPinkSlipCongrats::Initialize  (screencongrats.cpp:491) ---- */
void tScreenPinkSlipCongrats::Initialize()

{
  this->fWinner = -1;
  if ((byte)frontEnd.pinkSlipsWins[0] < (byte)(((byte)frontEnd.pinkSlipsNumTracks >> 1) + 1)) {
    this->fWinner = 1;
  }
  else {
    this->fWinner = 0;
  }
  this->_base_tScreenCongrats.Initialize();
  return;
}

/* ---- tScreenPinkSlipCongrats::Cleanup  (screencongrats.cpp:505) ---- */
void tScreenPinkSlipCongrats::Cleanup()

{
  
  CleanupSpinningCarsMenu();
  this->_base_tScreenCongrats._base_tScreen.Cleanup();
  return;
}

/* ---- tScreenPinkSlipCongrats::~tScreenPinkSlipCongrats  (screencongrats.cpp:141) ---- */
tScreenPinkSlipCongrats::~tScreenPinkSlipCongrats()

{
  return;
}

/* ---- tScreenTournamentTrophy::ProcessInput  (screencongrats.cpp:518) ---- */
void tScreenTournamentTrophy::ProcessInput(tPlayer p,tInputKeyType &keyval,tMenuCommand &c)

{
  if ((keyval == kInput_KeyType_Cross) && ((this->_base_tScreenCongrats).fCountedDown == 0)) {
    keyval = kInput_KeyType_AlreadyProcessed;
    (this->_base_tScreenCongrats).fStartCountdownNOW = 1;
  }
  this->_base_tScreenCongrats.ProcessInput(p,keyval,c);
  return;
}

/* ---- tScreenTournamentTrophy::GetCar  (screencongrats.cpp:531) ---- */
void tScreenTournamentTrophy::GetCar(tCarInfo &carInfo)

{
  tCarInfo *srcCar;
  tAwardInformation tInfo;
  
  if ((this->_base_tScreenCongrats).congratsMessage == kScreenCongrats_Congrats) {
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
  return;
}

/* ---- tScreenTournamentTrophy::DrawCongratsMessage  (screencongrats.cpp:555) ---- */
void tScreenTournamentTrophy::DrawCongratsMessage()

{
  char *word;
  char *word2;
  tTrophyClass trophyClass;
  int fade;
  int placeoffset;
  tTourneyInfo *tourneyInfo;
  int firstmessage;
  int secondmessage;
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
  if ((this->_base_tScreenCongrats).congratsMessage != kScreenCongrats_Congrats) {
    firstmessage = TextSys_WordY(800);
    word = TextSys_Word(800);
    FETextRender_FullTextRGB(word,0x120,(short)((uint)((firstmessage + -10) * 0x10000) >> 0x10),0x414141,'\x03',2);
    return;
  }
  firstmessage = 0;
  secondmessage = 0;
  tourneyInfo = (tournamentManager.fDefinition)->fTournaments +
           (uint)(tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset +
           tournamentManager.fTournament;
  if (tournamentManager.fPrevBestPlacement < '\x04') goto DrawCongrats_inlinedJoin084;
  trophyClass = (tTrophyClass)(this->_base_tScreenCongrats).trophy;
  firstmessage = tourneyInfo->fTournamentID + 0x3b3;
  if (trophyClass == kTrophySilver) {
    placeoffset = 1;
  }
  else if ((int)trophyClass < 2) {
    if (trophyClass == kTrophyGold) {
DrawCongrats_inlinedJoin048:
      placeoffset = 0;
    }
    else {
      placeoffset = 2;
    }
  }
  else {
    if (trophyClass == kTrophyCar) goto DrawCongrats_inlinedJoin048;
    placeoffset = 2;
  }
  word = TextSys_Word(tourneyInfo->fTournamentID + 0x3b3);
  word2 = TextSys_Word(placeoffset + 0x3e1);
  sprintf(buffer1,word,word2);
DrawCongrats_inlinedJoin084:
  trophyClass = (tTrophyClass)(this->_base_tScreenCongrats).trophy;
  if (((trophyClass == kTrophyGold) && (tournamentManager.fPrevBestPlacement != '\x01')) ||
     (trophyClass == kTrophyCar)) {
    if (firstmessage == 0) {
      firstmessage = tourneyInfo->fTournamentID + 0x3c6;
      word = TextSys_Word(firstmessage);
      word2 = buffer1;
    }
    else {
      secondmessage = tourneyInfo->fTournamentID + 0x3c6;
      word = TextSys_Word(secondmessage);
      word2 = buffer2;
    }
    sprintf(word2,word);
  }
  if (firstmessage != 0) {
    FETextRender_WordWrapTextFade(fade,buffer1,&r,textState_Selected,textType_PostGame);
    firstmessage = FETextRender_WordWrapHeight(r.w,buffer1);
    r.y = r.y + (short)firstmessage;
  }
  if (secondmessage != 0) {
    FETextRender_WordWrapTextFade
              (fade,buffer2,&r,textState_Selected,textType_PostGame);
  }
  GetAwardInformation(&tournamentManager,&tInfo);
  if (tInfo.fAwardCarGarageFull != 0) {
    r.x = 0x104;
    r.y = 200;
    r.w = 0xf0;
    FeTools_FormatMoney(money,tInfo.fAwardCarBonusMoney);
    word = TextSys_Word(0x40);
    sprintf(buffer,word,money);
    word = TextSys_Word(0x40);
    FETextRender_WordWrapTextFade
              (fade,word,&r,textState_Selected,textType_PostGame);
  }
  return;
}

/* ---- tScreenTournamentTrophy::CalculatePrizes  (screencongrats.cpp:654) ---- */
void tScreenTournamentTrophy::CalculatePrizes()

{
  long money;
  tTournamentDefinition *def;
  short ranking;
  int numRanked;
  tTrophyClass trophyClass;
  int tourIndex;
  int i;
  int place;
  tAwardInformation tInfo;
  
  (this->_base_tScreenCongrats).congratsMessage = kScreenCongrats_Eliminated;
  (this->_base_tScreenCongrats).trophy = kTrophyNone;
  (this->_base_tScreenCongrats).smallSpinningThing = kSpinningMemCard;
  GetAwardInformation(&tournamentManager,&tInfo);
  def = tournamentManager.fDefinition;
  place = 900;
  tourIndex = (uint)(tournamentManager.fDefinition)->fTiers[tournamentManager.fTier].fTournOffset +
          tournamentManager.fTournament;
  numRanked = (int)(((int)(short)tournamentManager.fNumRacers +
                (uint)((tournamentManager.fDefinition)->fTournaments[tourIndex].fKnockout != '\0')) *
               0x10000) >> 0x10;
  i = 1;
  if (0 < numRanked) {
    do {
      ranking = PlayerRanking(&tournamentManager,(short)i);
      if (ranking == 0) {
        place = i;
      }
      i = i + 1;
    } while (i <= numRanked);
  }
  if (place == 1) {
    if (tInfo.fAwardCar == 0) {
      (this->_base_tScreenCongrats).trophy = kTrophyGold;
      (this->_base_tScreenCongrats).smallSpinningThing = kSpinningNone;
    }
    else {
      (this->_base_tScreenCongrats).trophy = kTrophyCar;
      (this->_base_tScreenCongrats).smallSpinningThing = kSpinningGold;
    }
    (this->_base_tScreenCongrats).fSpeechToPlay = 0xf;
    (this->_base_tScreenCongrats).congratsMessage = kScreenCongrats_Congrats;
  }
  else {
    if (((place < 1) || (3 < place)) || (def->fTournaments[tourIndex].fKnockout != '\0')) {
      (this->_base_tScreenCongrats).congratsMessage = kScreenCongrats_Eliminated;
      trophyClass = kTrophyCar;
    }
    else {
      (this->_base_tScreenCongrats).fSpeechToPlay = place + 0xe;
      trophyClass = kTrophyBronze;
      (this->_base_tScreenCongrats).congratsMessage = kScreenCongrats_Congrats;
      if (place == 2) {
        trophyClass = kTrophySilver;
      }
    }
    (this->_base_tScreenCongrats).trophy = trophyClass;
    (this->_base_tScreenCongrats).smallSpinningThing = kSpinningNone;
  }
  (this->_base_tScreenCongrats).fCarPlayer = 0;
  money = tournamentManager.fMoney;
  (this->_base_tScreenCongrats).TotalCash = tournamentManager.fMoney;
  if (tInfo.fCompletedGarageFull != 0) {
    (this->_base_tScreenCongrats).TotalCash = money - tInfo.fCompletedBonusMoney;
  }
  if (tInfo.fTournMoney == 0) {
    tInfo.fTournMoney = -1;
  }
  (this->_base_tScreenCongrats).CashAwarded = tInfo.fTournMoney;
  (this->_base_tScreenCongrats).fCarX = 0x116;
  (this->_base_tScreenCongrats).fCarY = 0x3f;
  (this->_base_tScreenCongrats).fCarCY = -7.4;
  (this->_base_tScreenCongrats).fCarCX = 4.0;
  if ((this->_base_tScreenCongrats).congratsMessage == kScreenCongrats_Eliminated) {
    (this->_base_tScreenCongrats).fCarX = 0x120;
    (this->_base_tScreenCongrats).fCarY = 0x49;
    (this->_base_tScreenCongrats).fCarCY = -8.2;
  }
  return;
}

/* ---- tScreenTournamentTrophy::~tScreenTournamentTrophy  (screencongrats.cpp:126) ---- */
tScreenTournamentTrophy::~tScreenTournamentTrophy()

{
  return;
}

/* ---- tScreenBeTheCopCongrats::GetCar  (screencongrats.cpp:746) ---- */
void tScreenBeTheCopCongrats::GetCar(tCarInfo &carInfo)

{
  tCarInfo *srcCar;
  
  srcCar = GetCarFromID(&carManager, (ushort)(byte)frontEnd.congratsCopCar);
  blockmove(srcCar,&carInfo,0xcc);
  carInfo.fCountry = frontEnd.congratsCopCountry;
  return;
}

/* ---- tScreenBeTheCopCongrats::CalculatePrizes  (screencongrats.cpp:756) ---- */
void tScreenBeTheCopCongrats::CalculatePrizes()

{
  
  this->_base_tScreenCongrats.CalculatePrizes();
  (this->_base_tScreenCongrats).trophy = kTrophyCar;
  (this->_base_tScreenCongrats).fCarX = 0x116;
  (this->_base_tScreenCongrats).fCarY = 0x4b;
  (this->_base_tScreenCongrats).fCarCX = 4.0;
  (this->_base_tScreenCongrats).fCarCY = -7.4;
  return;
}

/* ---- tScreenBeTheCopCongrats::DrawCongratsMessage  (screencongrats.cpp:766) ---- */
void tScreenBeTheCopCongrats::DrawCongratsMessage()

{
  uint padState;
  char *fmt;
  char *copWord;
  RECT *r;
  tMenuTextState fade;
  int wordnum;
  char buffer [250];
  
  wordnum = 0x4c;
  r = (RECT *)(uint)(byte)frontEnd.congratsCopCar;
  if (r == (RECT *)0x1c) {
    wordnum = 0x4d;
  }
  padState = PAD_state(4);
  if ((padState & 0xffff) != 0) {
    TextSys_Word((this->_base_tScreenCongrats).fCarInfo.fCarID + 0x121);
  }
  fmt = TextSys_Word(wordnum);
  copWord = TextSys_Word((this->_base_tScreenCongrats).fCarInfo.fCarID + 0x121);
  fmt = (char *)sprintf(buffer,fmt,copWord);
  FETextRender_WordWrapText(fmt,r,fade,textType_PostGame);
  return;
}

/* ---- tScreenBeTheCopCongrats::~tScreenBeTheCopCongrats  (screencongrats.cpp:151) ---- */
tScreenBeTheCopCongrats::~tScreenBeTheCopCongrats()

{
  return;
}

/* ---- tScreenTournamentCongrats::GetCar  (screencongrats.cpp:796) ---- */
void tScreenTournamentCongrats::GetCar(tCarInfo &carInfo)

{
  tCarInfo *srcCar;
  tAwardInformation tInfo;
  
  GetAwardInformation(&tournamentManager,&tInfo);
  srcCar = GetCarFromID(&carManager, (u_short)tInfo.fCompletedCar);
  blockmove(srcCar,&carInfo,0xcc);
  return;
}

/* ---- tScreenTournamentCongrats::CalculatePrizes  (screencongrats.cpp:807) ---- */
void tScreenTournamentCongrats::CalculatePrizes()

{
  long cash;
  tAwardInformation tInfo;
  
  GetAwardInformation(&tournamentManager,&tInfo);
  this->_base_tScreenCongrats.CalculatePrizes();
  (this->_base_tScreenCongrats).trophy = kTrophyCar;
  (this->_base_tScreenCongrats).TotalCash = tournamentManager.fMoney;
  cash = -1;
  if (tInfo.fCompletedGarageFull != 0) {
    cash = tInfo.fCompletedBonusMoney;
  }
  (this->_base_tScreenCongrats).CashAwarded = cash;
  (this->_base_tScreenCongrats).fCarX = 0x116;
  (this->_base_tScreenCongrats).fCarY = 0x4b;
  (this->_base_tScreenCongrats).fCarCX = 4.0;
  (this->_base_tScreenCongrats).fCarCY = -7.4;
  return;
}

/* ---- tScreenTournamentCongrats::DrawCongratsMessage  (screencongrats.cpp:825) ---- */
void tScreenTournamentCongrats::DrawCongratsMessage()

{
  char *word;
  RECT *r;
  tMenuTextState fade;
  tAwardInformation tInfo;
  char buffer [256];
  char money [64];
  
  GetAwardInformation(&tournamentManager,&tInfo);
  word = TextSys_Word((int)tInfo.fCompletedText);
  FETextRender_WordWrapText(word,r,fade,textType_PostGame);
  if (tInfo.fCompletedGarageFull != 0) {
    FeTools_FormatMoney(money,tInfo.fCompletedBonusMoney);
    word = TextSys_Word(0x40);
    sprintf(buffer,word,money);
    word = TextSys_Word(0x40);
    FETextRender_WordWrapText(word,r,fade,textType_PostGame);
  }
  return;
}

/* ---- tScreenTournamentCongrats::~tScreenTournamentCongrats  (screencongrats.cpp:161) ---- */
tScreenTournamentCongrats::~tScreenTournamentCongrats()

{
  return;
}

/* end of screencongrats.cpp */