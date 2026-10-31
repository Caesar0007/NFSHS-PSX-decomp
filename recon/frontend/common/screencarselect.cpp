/* frontend/common/screencarselect.cpp -- RECONSTRUCTED (car-select screens; C++ TU)
 *   4 classes (tScreenCarSelect + Duel/TwoPlayer/PinkSlips derived) + free DrawCar; 58 fns.
 *   Bodies from Ghidra; namespaces stripped, phantom stack-args resolved vs disasm.
 */
#include "screencarselect.h"

/* Canonical PsyQ 4.3 LIBGPU.H:104. Retail SLD groups each rectangle setup
 * into one statement; this owner does not import the vendor GPU header. */
#define setRECT(r, _x, _y, _w, _h) \
    (r)->x = (_x),(r)->y = (_y),(r)->w = (_w),(r)->h = (_h)









extern tFEApplication *FEAppB[] asm("FEApp");

typedef struct tPsyQPrimTag {
  unsigned int addr : 24;
  unsigned int len : 8;
} tPsyQPrimTag;

/* The retail SLD records this three-store expansion as an inline tDialogBase
   scope in both car-select SetDialog methods.  No standalone symbol survives,
   so SetPosition is a semantic reconstruction of the unavailable identifier. */
inline tDialogBase *tDialogBase::SetPosition(short x, short y, tPlayer player)
{
  OffsetX = x;
  OffsetY = y;
  specificPlayer = (short)player;
  return this;
}

inline tDialogBase *tDialogBase::SetPosition(short x, short y)
{
  OffsetX = x;
  OffsetY = y;
  return this;
}

inline void tDialogBase::SetSpecificPlayer(short player)
{
  specificPlayer = player;
}

/* Inferred overloads: receiver ownership is authoritative, spelling is not. */
inline void tDialogMessageString::Display(char *text)
{
  string = text;
  tDialogBase::Display();
}

inline void tDialogMessageString::Display(int word)
{
  string = TextSys_Word(word);
  tDialogBase::Display();
}

/* SYM-INLINE reconstruction (original identifier/declaration site unavailable):
   DrawSliders and both multiplayer DrawForeground functions contain the same
   nested debug scope: parameters `carStat`, pointer `carInfo`, then local
   `result`, all attributed to one call-site line.  This body reproduces all
   three expansions byte-for-byte; the retail artifacts cannot recover its
   original spelling, so CarStatValue is an explicit semantic name. */

/* ---- (static)::TransformVector  [SCREENCARSELECT.CPP:51-59] ---- */
/* File-static 4x4 fixed-point matrix * 4-vector (ScreenCarSelect.obj 1st fn @0x8003a8f0).
   GCC-v2 `FRA4_iRA4_A4_iT0` decodes to the retail array-reference signature below;
   SYM REG I=$s3, J=$s0. */
static void TransformVector(int (&vect)[4],int (&transform)[4][4],int (&result)[4]);
static void TransformVector(int (&vect)[4],int (&transform)[4][4],int (&result)[4])

{
  short I;
  short J;

  for (I = 0; I < 4; I = I + 1) {
    result[I] = 0;
    for (J = 0; J < 4; J = J + 1) {
      result[I] = result[I] + fixedmult(vect[J],transform[J][I]);
    }
  }
  return;
}

/* ---- (free)::DrawCar  [SCREENCARSELECT.CPP:180-212] ---- */

/* Decoded Phase 84: DrawCar(tCarInfo&, short, short, float, float, char, bool, u_long, tPlayer) -
   render car in 3D (428 B, 7 callers - hot). When tcarinfo->fCarID >= 0: applies fColor /
   carType=fSimNumber / Country=fCountry to (*ppCVar3)->carInfo. Used in showroom + dealer screens.
   
   [ghidra-meta] section: front.text */

/* MATCH W63/W66: 37 -> PASS (107/107 instructions).  The SYM
   names only `the_simcarcolor` ($a0) and unsigned-long `ticks` ($v1).  Keeping
   the global read in that unsigned local, then explicitly converting it to a
   signed temporary before `% 0x800`, gives retail's pre-branch `$v0 = $v1`
   copy, `$a0` dividend preservation, and quotient/result flow through $v1.
   The temporary optimizes away and does not contradict the SYM local table.
   Spelling the direction result as the SLD's explicit if/else restores its
   branch normalizer.  Direct tCarInfo fields and direct gCarObj[player] uses
   remove the decompiler's byte/pointer aliases and make the remainder of the
   body byte-identical. */


void DrawCar(tCarInfo &carInfo,short x,short y,float camerax,float cameray,char brightness,
               bool reflection,u_long rotate,tPlayer player)

{
  int the_simcarcolor;
  u_long ticks;

  ticks = GetTicks() % 0x800;
  DrawC_gMenuLights = 0;
  if (ticks < 0x400) {
    DrawC_gMenuLightsDirection = 0;
  }
  else {
    DrawC_gMenuLightsDirection = 1;
  }
  /* W55-A2 BUGFIX (class-1, unsigned-char deleted guard): fCarID is signed in the
     shared type, preserving the oracle's `lb`/`bltz` empty-slot guard here. */
  if (-1 < carInfo.fCarID) {
    the_simcarcolor = carInfo.fColor;
    gCarObj[player]->carInfo->carType = (uint)carInfo.fSimNumber;
    gCarObj[player]->carInfo->Country = (uint)carInfo.fCountry;
    gMenuRotate[player] = gMenuRotate[player] + 3;
    gCarObj[player]->carInfo->EngineMods = carInfo.fUpgrades >> 2 & 1;
    gCarObj[player]->carInfo->WeightTransfer = carInfo.fUpgrades >> 1 & 1;
    gCarObj[player]->carInfo->GroundEffects = carInfo.fUpgrades & 1;
    DrawC_MenuColorData((uint)the_simcarcolor,gCarObj[player],player);
    Draw_MenuRenderingView(gCarObj[player],&gCView,(int)x,(int)y,player,0,rotate,camerax,cameray,(uint)(byte)brightness
               ,reflection);
  }
  return;
}



/* ---- tScreenCarSelect::ctor  [SCREENCARSELECT.CPP:294-316] ---- */
/* MATCH 2026-07-11: base ctor now the IMPLICIT call to tScreen::tScreen() (declared in
   nfs4_types.h) -- deleted the manual tScreen_ctor(...) free-fn call (phantom-ctor pattern,
   catalog wave-3 row 1); g++ auto-emits `jal __7tScreen` at entry, matching oracle exactly.
   The fOverlays[i].location[0..1] init was Ghidra-decompiled as byte-packed bitfield-merge
   arithmetic; the oracle disasm is
   actually a plain UNALIGNED RECT[2] struct copy (lwl/lwr+swl/swr pairs, 2 words per RECT) --
   RECT's natural alignment is 2 (all-short members) so gcc emits the unaligned-word copy
   idiom for the struct assignment (catalog §D "plain C struct assignment" row). */
tScreenCarSelect::tScreenCarSelect()

{



  tOverlay *overlay;
  short i;

  this->fPreviousCar = 0;
  this->fPreviousCarID = -1;
  this->fPreviousCountry = 0;
  i = 0;
  for (; i < 7; i = i + 1) {
    overlay = this->fOverlays + i;
    overlay->location[0] = gOverlayPositions[i][0];
    overlay->location[1] = gOverlayPositions[i][1];
    overlay->ID = i;
    overlay->direction = 0;
    overlay->transition = 0;
    overlay->delta = 6;
  }
  for (i = 0; i < 4; i = i + 1) {
    this->fCurrentOverlays[i] = 0;
  }
}



/* ---- tScreenCarSelect::dtor  [SCREENCARSELECT.CPP:320-320] ---- */
tScreenCarSelect::~tScreenCarSelect()

{
  /* base ~tScreen is emitted implicitly (: public tScreen) -- no explicit call */
  return;
}



/* ---- tScreenCarSelect::Cleanup  [SCREENCARSELECT.CPP:324-327] ---- */
/* SYM-CODEGEN-CARRIER: vtbl -- direct this->_vf[1][5] indexing is measured
   byte-identical but violates the manual-ABI vtable safety gate. */
void tScreenCarSelect::Cleanup()

{
  CleanupSpinningCarsMenu();
  this->tScreen::Cleanup();
  this->FreeAsyncBuffer();
  return;
}



/* ---- tScreenCarSelect::DrawOverlay  [SCREENCARSELECT.CPP:334-494] ---- */
/* Retail fade is the icon-fade SHORT (0/96), not the transition update value.
 * Structured clamp arms replace the jump; both old absorption identities are
 * gone. Money/selector getters and the conditional price selection recover
 * every retail scope boundary at 551/551 PASS. Their names are inferred.
 * The recorded j is reused for the 0x410/0x411 icon flags (fits SHORT), then
 * reinitialized for the later stat-clear loop; its native home remains $a0.
 * This removes both flags objects, but does not uniquely prove the original
 * reuse spelling. Direct flags/coordinate arguments are 138dif/557; reused
 * LONG value for flags is 103dif/552. Both xPos objects are also gone:
 * negative-subtrahend coordinate arguments preserve all551 words and every
 * native name/type/home/scope tuple, without a substitute object or fence.
 * i is 0..2 here, so neither the offset nor its negation can overflow.
 * The canonical PsyQ setRECT macro recovers retail's three single-line
 * rectangle initialization groups without changing any instruction.
 * Other measured coordinate routes:
 * direct coordinates (both orders) are 80dif/551, reused SHORT text 90/555,
 * reused INT moneyColor 104/551, LONG value 173/552, temp.x 180/557,
 * widened multiply/add 224/577. No failed route proves an original object.
 * Full SLD and literal original accessor/reuse spelling remain unresolved. */
void tScreenCarSelect::DrawOverlay(tOverlay *overlay)

{
  RECT pos;
  RECT temp;
  tCarInfo carInfo;
  short fade, i, j;
  tDrawShapeExtended drawFlags;
  short text;
  long value;
  bool validCar;
  int moneyColor;
  short upgradeTranslate [3] = {2, 3, 1};
  short upgradeIcons [3] = {2, 4, 1};
  
  if (overlay != (tOverlay *)0x0)
  {

  validCar = this->GetCar(carInfo);
  if (overlay->direction != 0) {
    overlay->transition = overlay->transition + overlay->delta * overlay->direction;
    if (overlay->transition < 1) {
      overlay->transition = 0;
      overlay->direction = 0;
    }
    else if (0x80 <= overlay->transition) {
      overlay->transition = 0x80;
      overlay->direction = 0;
    }
  }
  pos.x = overlay->location[0].x +
          overlay->transition * (overlay->location[1].x - overlay->location[0].x) / 0x80;
  pos.y = overlay->location[0].y +
          overlay->transition * (overlay->location[1].y - overlay->location[0].y) / 0x80;
  pos.w = overlay->location[0].w +
          overlay->transition * (overlay->location[1].w - overlay->location[0].w) / 0x80;
  pos.h = overlay->location[0].h +
          overlay->transition * (overlay->location[1].h - overlay->location[0].h) / 0x80;
  switch(overlay->ID) {
  case 0:
    if (validCar != 0) {
      DrawShape_NFS4RoundRectangle((signed char)carInfo.fCarID + 0x121,pos,0);   /* W58-A1: RECT& decl */
    }
    break;
  case 1:
  case 2:
  case 3:
    setRECT(&temp,pos.x + 0xf,pos.y + pos.h - 0x1e,pos.w - 0x1e,0x17);
    if (validCar != 0) {
      FETextRender_MenuTextPositionedJustify((signed char)carInfo.fCarID + 0x121,temp.x + temp.w + -0xc,pos.y + 2,1,textState_Selected,
                 textType_FramedInfo);
    }
    text = overlay->ID == 2 ? 0x8d : overlay->ID == 3 ? 0x8e : 0x8c;
    if (validCar != 0) {
      moneyColor = 0xbebe;
      value = overlay->ID == 2 ? carInfo.fPrices[0] :
              overlay->ID == 3 ?
              carInfo.fPrices[upgradeTranslate[(short)Menu_CurrentItem(menuDefs->menuCarUpgrades)]] :
              carManager.CalcUsedPrice((ushort)(byte)frontEnd.sellerCar);
    }
    else {
      moneyColor = 0x232323;
      value = 0;
    }
    DrawMoney((int)temp.x + (int)temp.w + -0xc,temp.y + 3,6,value,moneyColor,0x232323);
    FETextRender_MenuTextPositionedJustify(text,temp.x + (temp.w >> 1),
                             temp.y + 3,1,textState_Selected,textType_FramedInfo)
    ;
    DrawMoney((int)temp.x + (int)temp.w + -0xc,temp.y + 0xd,9,
              Tournament_Money(tournamentManager),0xbebe,0x232323);
    FETextRender_MenuTextPositionedJustify(0x7b,temp.x + (temp.w >> 1),
                            temp.y + 0xd,1,textState_Selected,textType_FramedInfo);
    DrawShape_NFS4Rectangle(temp);   /* W58-A1: RECT& decl */
    PSXDrawSquare(0,(int)pos.x,(int)pos.y,(int)pos.w,10);
    break;
  case 4:
    for (i = 0; i < 3; i = i + 1) {
      fade = 0;
      if ((carInfo.fUpgrades & upgradeIcons[i]) == 0) {
        fade = 0x60;
      }
      drawFlags.tint[0] = 0xbebe;
      j = (carInfo.fUpgrades & upgradeIcons[i]) == 0;
      j |= 0x410;
      DrawShapeExtended(0x62 + i * 10 + (FE_Ticks() >> 4) % 10,
                        j,
                        pos.x - (-(i * 0x28 + 0x21)),pos.y + 6,
                        fade,1,&drawFlags);
    }
    break;
  case 5:
    if (overlay->transition == 0x80) {
      int descrItem;
      for (i = 0; i < 3; i = i + 1) {

        fade = 0;
        if ((carInfo.fUpgrades & upgradeIcons[i]) == 0) {
          fade = 0x60;
        }
        drawFlags.tint[0] = 0xbebe;
        j = (carInfo.fUpgrades & upgradeIcons[i]) == 0;
        j |= 0x410;
        DrawShapeExtended(0x62 + i * 10 + (FE_Ticks() >> 4) % 10,
                          j,
                          pos.x - (-(i * 0x28 + 0x85)),pos.y + 6,
                          fade,1,&drawFlags);
      }
      setRECT(&temp,pos.x + 0x1e,pos.y + 0x23,pos.w - 0x3c,pos.h - 0x4b);
        FETextRender_MenuTextPositionedJustify
                  (Menu_CurrentItem(menuDefs->menuCarUpgrades) + 0x96,
                   pos.x + (pos.w >> 1),pos.y + 0x18,2,
                   textState_Hilighted,textType_FramedInfo);
        descrItem = (short)Menu_CurrentItem(menuDefs->menuCarUpgrades) + 0xaf;
        if ((descrItem == 0xb0) &&
            (((signed char)carInfo.fCarID == 0xc) ||
             ((signed char)carInfo.fCarID == 10))) {
          descrItem = 0x41;
        }
        FETextRender_WordWrap((short)descrItem,temp,textState_Hilighted,textType_PopUpText);
      text = 0xa0;
      if ((carInfo.fUpgrades &
           upgradeIcons[(short)Menu_CurrentItem(menuDefs->menuCarUpgrades)]) == 0) {
        text = 0x9e;
        if (gPadinfo.buf[0].ID == '#') {
          text = 0x9f;
        }
      }
      FETextRender_MenuTextPositionedJustify(text,pos.x + pos.w + -0xf,pos.y + pos.h + -0x14,1,textState_Hilighted,
                 textType_FramedInfo);
    }
    if ((0x42 < pos.w) && (0x32 < pos.h)) {
      setRECT(&temp,pos.x + 0xf,pos.y + 0x14,pos.w - 0x1e,pos.h - 0x19);
      DrawShape_NFS4Rectangle(temp);   /* W58-A1: RECT& decl */
    }
    break;
  case 6:
    if (validCar == 0) {
      for (i = 0; i < 5; i = i + 1) {
        for (j = 0; j < 4; j = j + 1) {
          carInfo.fStats[j][i] = 0;
        }
      }
    }
    this->DrawSliders(carInfo,pos.x + 0xd,pos.y + 4);
  }
  if (overlay->ID != 0) {
    DrawShape_NFS4TransRectangle(pos,1);   /* W58-A1: RECT& decl */
  }
  }
  return;
}



/* ---- tScreenCarSelect::SetState  [SCREENCARSELECT.CPP:501-577] ---- */
void tScreenCarSelect::SetState(int state)

{
  /* SYM/PASS: retail owns only `i` and `fPreviousState`.  gStateOverlays is
     signed char[8][4], so direct indexing preserves the required `lb; bltz`
     empty-slot guard while removing the former cVar1/ovl aliases. */
  short i;
  short fPreviousState;
  
  fPreviousState = this->fState;
  if (state != this->fState) {
    this->fState = (short)state;
    if ((ushort)(fPreviousState - 2U) < 2) {
      TurnOff(this->fVideoWall);
      this->SetBrightness(0,0);
      this->fPreviousCar = -1;
      this->fPreviousCarID = -1;
    }
    i = 0;
    do {
      if (this->fCurrentOverlays[i] != (tOverlay *)0x0) {
        if ((int)this->fCurrentOverlays[i]->ID !=
            (int)gStateOverlays[state][i]) {
          this->fCurrentOverlays[i]->direction = -1;
        }
      }
      else {
        if (-1 < gStateOverlays[state][i]) {
          this->fCurrentOverlays[i] =
              this->fOverlays + gStateOverlays[state][i];
          this->fCurrentOverlays[i]->transition = 0;
          this->fCurrentOverlays[i]->direction = 1;
        }
      }
      i = i + 1;
    } while (i < 4);
  }
  switch (state) {
  case 0:
  case 2:
  case 5:
  case 6:
    this->fInShowroom = (uint)(state - 5U < 2);
    gStopCommentaryNow = 1;
    this->fSpeechTicks = VSyncTicks();
    this->fShowroomTicks = VSyncTicks();
    this->fSpeechPlayed = 0;
    if (this->fInShowroom != 0) {
      AudioMus_StopSong(1000);
      i = 0;
      this->fSplineInterval = 0;
      gKnots[1][4] = this->fCameraRotation & 0x3ff;
      do {
        gKnots[0][i] = gKnots[1][i] - (gKnots[2][i] - gKnots[1][i]);
        i = i + 1;
      } while (i < 5);
      gRotateOffset[3] = 0x10000;
      gRotateOffset[2] = 0x10000;
      gRotateOffset[1] = 0x10000;
      gRotateOffset[0] = 0x10000;
      this->tScreen::TransitionOff(kScreen_TransitionTypeScreen,(tMenu *)0x0);
    }
    else {
      i = 0;
      do {
        this->tvConfigs[i].state = tv_StateOff;
        this->tvConfigs[i].transition = 0;
        i = i + 1;
      } while (i < 10);
      if (fPreviousState != 1) {
        this->tScreen::TransitionOn(kScreen_TransitionTypeScreen,(tMenu *)0x0);
      }
      TurnOn(this->fVideoWall);
    }
  }
}



/* ---- tScreenCarSelect::CalcSplinePosition  [SCREENCARSELECT.CPP:583-625] ---- */
/* SYM/PASS P869: the signed / 0x10000 conversions below regenerate the
   compiler's negative-input correction without an unrecorded `_i` local.
   Each conversion is one retail statement (SLD 611, 612 and 625); assigning
   the shift/correction through the output references instead was the earlier
   FAIL 107 (185/176) probe.  This ordinary division form is PASS 176/176,
   exact -g twin, with the native T/G/i/Result1/Result2 declarations intact. */
void tScreenCarSelect::CalcSplinePosition(int knot1,int knot2,int knot3,int knot4,u_long elapsed,
               int &camY,int &camZ,int &screenX,int &screenY,int &camRot)

{
  /* [SYM] 8c decl order: T, G, i, Result1, Result2 */
  int T [4];
  int G [4] [4];
  short i;
  int Result1 [4];
  int Result2 [4];
  
  T[2] = fixeddiv(elapsed << 0x10,0x2580000);
  T[1] = fixedmult(T[2],T[2]);
  T[0] = fixedmult(T[1],T[2]);
  i = 0;
  T[3] = 0x10000;
  do {
    G[0][i] = gKnots[knot1][i];
    G[1][i] = gKnots[knot2][i];
    G[2][i] = gKnots[knot3][i];
    G[3][i] = gKnots[knot4][i];
    i = i + 1;
  } while (i < 4);
  TransformVector(T,gCatmullRom,Result1);
  TransformVector(Result1,G,Result2);
  camY = Result2[0] >> 1;
  camZ = Result2[1] >> 1;
  screenX = (Result2[2] >> 1) / 0x10000;
  screenY = (Result2[3] >> 1) / 0x10000;
  G[0][0] = gKnots[knot1][4] + gRotateOffset[0];
  G[1][0] = gKnots[knot2][4] + gRotateOffset[1];
  G[2][0] = gKnots[knot3][4] + gRotateOffset[2];
  G[3][0] = gKnots[knot4][4] + gRotateOffset[3];
  TransformVector(T,gCatmullRom,Result1);
  TransformVector(Result1,G,Result2);
  camRot = (Result2[0] >> 1) / 0x10000;
  return;
}



/* ---- tScreenCarSelect::GetShapeInfo  [SCREENCARSELECT.CPP:629-644] ---- */
void tScreenCarSelect::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName
               ,char **swapFileName)

{
  /* SYM-CODEGEN-CARRIER: vtbl -- the retail virtual GetCar call's implicit
     dispatch temporary has no SYM source local.  The manual non-virtual ABI
     model needs this cached row pointer: direct this->_vf[1][3] dispatch is
     byte-identical, but fails audit_vtable_indexing as unsafe row indexing. */
  tCarInfo carInfo;

  numPermShapes = 0x8e;
  numSwapShapes = 0xb;
  *permFileName = "zcars";
  if ((this->GetCar(carInfo) ^ 1) != 0) {
    carManager.GetStockCar(0,carInfo);
  }
  this->fPreviousCar = (ushort)carInfo.fCarIndex;
  this->fPreviousCarID = (short)(signed char)carInfo.fCarID;
  this->fPreviousCountry = (ushort)carInfo.fCountry;
  sprintf(gSwapFileName[0],"%s",carInfo.fShapeName);
  *swapFileName = gSwapFileName[0];
  return;
}



/* ---- tScreenCarSelect::UpdateVideoWall  [SCREENCARSELECT.CPP:648-660] ---- */
/* SYM/PASS P869: retail has no caller local.  Its SLD assigns fPreviousCountry
   on line 657 BEFORE fTVsInitialized on line 658; the scheduler moves the
   country store into SetBrightness's delay slot.  Restoring that source
   order removes the former `country` carrier and stays PASS 52/52 (exact -g).
   Direct assignment after the reset was the earlier FAIL 2 (52/52) probe. */
void tScreenCarSelect::UpdateVideoWall(tCarInfo &carInfo)

{
  if ((((ushort)carInfo.fCarIndex != this->fPreviousCar) ||
      ((int)(signed char)carInfo.fCarID != (int)this->fPreviousCarID)) ||
     ((carInfo.fCarClass == '\a' && (this->fPreviousCountry != (ushort)carInfo.fCountry)))) {
    if (-1 < (signed char)carInfo.fCarID) {
      ::AsyncLoadSwapShapeFile((tScreen *)this,carInfo.fShapeName);
    }
    this->fPreviousCar = (ushort)carInfo.fCarIndex;
    this->fPreviousCarID = (short)(signed char)carInfo.fCarID;
    this->fPreviousCountry = (ushort)carInfo.fCountry;
    this->fTVsInitialized = 0;
    this->SetBrightness(0,0);
    TurnOff(this->fVideoWall);
  }
}



/* ---- tScreenCarSelect::AllocateAsyncBuffer  [SCREENCARSELECT.CPP:665-666] ---- */
void tScreenCarSelect::AllocateAsyncBuffer()

{
  this->fSwapShapes.fDestFile = Platform_GetDCTBuffer(40000,"VideoWall");
  /* retail .rodata carries two UNREFERENCED format strings right after "VideoWall"
     (0x80011aec "%d,%03d", 0x80011af4 "%d"; no code reaches them): constant-false calls
     keep them in that order with no code. */
  if (0) sprintf((char *)0,"%d,%03d");
  if (0) sprintf((char *)0,"%d");
  return;
}



/* ---- tScreenCarSelect::FreeAsyncBuffer  [SCREENCARSELECT.CPP:670-672] ---- */
void tScreenCarSelect::FreeAsyncBuffer()

{
  Platform_ResetDCTBuffer();
  this->fSwapShapes.fDestFile = (char *)0x0;
}



/* ---- tScreenCarSelect::InitializeVideoWall  [SCREENCARSELECT.CPP:676-687] ---- */
void tScreenCarSelect::InitializeVideoWall()

{
  ::Initialize(&this->fVideoWall[0],this->tvConfigs,this->fSwapShapes.fShapes,0,10,tvOrder,0x96);
  SetAvailableText(this->fVideoWall,0xf8,0x140,0x50);
  this->fVideoWall->SetAvailableIcon(0x1c,10,0x136,0x3c,this->fPermShapes.fShapes);
  if ((this->fSwapShapes.fFlags & 1) != 0) {
    UpdateImages(this->fVideoWall);
    this->fTVsInitialized = 1;
  }
  return;
}



/* ---- tScreenCarSelect::Initialize  [SCREENCARSELECT.CPP:692-760] ---- */
void tScreenCarSelect::Initialize()

{
  short i;
  tCarInfo carInfo;
  tTrackInformation trackInfo;
  tTrackInfo tourneyTrack;
  
  if (frontEnd.raceType == RaceType_Tournament) {
    tournamentManager.GetTrackToRace(tourneyTrack);
    GameSetup_gData.track =
        (int)trackManager.GetTrackByID((short)tourneyTrack.fTrackNumber)->fSimNumber;
  }
  else {
    trackManager.GetTrack((ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               trackInfo);
    GameSetup_gData.track = (int)trackInfo.fSimNumber;
  }
  gShowroomLights[0] = 1;
  MenuItem_Enable(&menuDefs->itemDamage);
  if (frontEnd.raceType == RaceType_Tournament) {
    MenuItem_Disable(&menuDefs->itemDamage);
  }
  this->tScreen::Initialize();
  /* MATCH (W66): retail reloads each virtual-table entry directly from `_vf`;
     keeping a named vtbl temporary changes the load destination from $v0 to
     $v1.  GROUP THE INT TERMS -- `base + (delta + -0x14)` not
     `base + delta + -0x14`.  C's pointer_int_sum rebuilds ptr-first only when the
     added term is ONE int expression; the flat 3-term form leaves gcc an INT sum
     it finishes with `addu a0,a0,s0` where the oracle has `addu a0,s0,a0`
     (this-first). */
  this->AllocateAsyncBuffer();
  SetLicensePlate();
  this->fTVsInitialized = 0;
  this->fCameraRotation = 0;
  this->fInShowroom = 0;
  if (this->GetCar(carInfo) != 0) {
    /* MATCH (W57-A2): ARM ORDER -- the oracle's `beqz $v0` branches AWAY to the
       `fPrevious* = -1` block, which it lays OUT OF LINE after the carInfo
       copies (0x8003BEC4-CC, SLD 737/738/739); the success copies are the
       FALL-THROUGH.  Writing the false arm first inverts the branch and
       inlines the -1 block (46 -> 35). */
    this->fPreviousCar = (ushort)carInfo.fCarIndex;
    this->fPreviousCarID = (short)carInfo.fCarID;
    this->fPreviousCountry = (ushort)carInfo.fCountry;
  } else {
    this->fPreviousCar = -1;
    this->fPreviousCountry = -1;
    this->fPreviousCarID = -1;
  }
  /* MATCH (W66, 31 -> PASS): ticks is updated by the VSync ISR.  Retail performs
     two real reads before the brightness stores; the first feeds fShowroomTicks
     and the second feeds the shared chained fFadeTicks assignment.  Direct
     member assignments preserve that schedule and need no snapshot locals. */
  this->fShowroomTicks = VSyncTicks();
  this->fFadeTicks[0] = this->fFadeTicks[1] =
      VSyncTicks() + -0x100;
  this->fBrightness[1] = 0;
  this->fBrightness[0] = 0;
  this->fDestBrightness[1] = 0;
  this->fDestBrightness[0] = 0;
  this->InitializeVideoWall();
  i = 0;
  do {
    this->fOverlays[i].transition = 0;
    this->fOverlays[i].direction = 0;
    i = i + 1;
  } while (i < 7);
  i = 0;
  do {
    this->fCurrentOverlays[i] = (tOverlay *)0x0;
    i = i + 1;
  } while (i < 4);
  return;
}



/* ---- tScreenCarSelect::ProcessInput  [SCREENCARSELECT.CPP:764-810] ---- */
void tScreenCarSelect::ProcessInput(tPlayer,tInputKeyType &keyval,tMenuCommand &
              )

{
  /* SYM/PASS: the caller owns exactly carInfo, validCar, and item.  Flattened
     vtable slot 13 removes the decompiler's vtbl/delta alias; direct keyval and
     fState reads remove tVar4/state2.  The selected ABS menu item is SYM's
     `item`, and its three nested tMenuItem receivers are the inlined
     SetTextDescription stores reconstructed in nfs4_types.h. */

  if (keyval == kInput_KeyType_Square) {
    /* [SYM] all three live in the block opened at SLD 3 (this `if`), in the
       8c order carInfo, validCar, item. */
    tCarInfo carInfo;
    bool validCar;
    tMenuItem *item;

    validCar = this->GetCar(carInfo);
    if (FEApp->fPlayer == '\0') {
      item = &menuDefs->itemABS;
    }
    else {
      item = &menuDefs->itemABS2;
    }
    /* SYM-INLINE-THIS: SetTextDescription */
    item->SetTextDescription(0x10b);
    if (validCar != 0) {
      if ((signed char)carInfo.fCarID == '\b') {
        item->SetTextDescription(0x10c);
      }
      if ((signed char)carInfo.fCarID == '\x01') {
        item->SetTextDescription(0x10d);
      }
    }
    if ((frontEnd.oppNumber == '\x01') || (frontEnd.gameMode == '\x01')) {
      MenuItem_Disable(&menuDefs->itemOpponentUpgrades);
    }
  }
  if (keyval != kInput_KeyType_Triangle) {
    return;
  }
  /* MATCH: flat goto/shared-tail form.  The oracle has exactly ONE `jal SetState`
     that every arm reaches by `j` after setting only $a0/$a1 -- no arm stages a
     return value (the epilogue returns SetState's incidental $v0), and the
     fState<2 arm falls off the end of the function entirely (retail UB, $v0 = the
     scheduler's leftover).  `if/else if` spellings put the gameMode block in the
     middle; the explicit labels reproduce the oracle's stub-then-tail layout.
     Direct fState comparisons also let the gameMode arm reuse the compare's
     constant register
     (`addiu v0,1; beq v1,v0; addu a1,v0,zero`).  Blocks are written in the
     oracle's physical VA order (dispatch / >=6 sub-dispatch / ==5 / ==6 /
     gameMode / shared jal), which also fixes the ==6 branch polarity. */
  if (this->fState == 5) goto st5;
  if (5 < this->fState) goto ge6;
  if (this->fState < 2) goto done;
  goto gamemode;
ge6:
  if (this->fState == 6) goto st6;
  return;
st5:
  this->SetState(0);
  goto done;
st6:
  this->SetState(2);
  goto done;
gamemode:
  /* MATCH (W57-A2): the gameMode==1 arm must NOT stage a return value -- it just
     goes to the shared epilogue like every other arm (same "no arm returns a
     value" reading already documented above; the caller sees the compare's
     incidental $v0 == 1).  Written `return 1;` the const-1 becomes a RETURN-value
     constant, cse stops treating $v0 as "holds 1" at the fall-through, and the
     SetState arg rematerializes as `li a1,1` instead of the oracle's
     `addu a1,v0,zero` (6 -> 4 diffs on this one edit). */
  if (frontEnd.gameMode == '\x01') {
    goto done;
  }
  this->SetState(1);
done:
  /* 2026-10-01: explicit void return replaces the old empty-asm exit fence.
     It closes this shared path before reorg searches across the gameMode
     branch, leaving the jump's delay slot empty. The gameMode address `lui`
     instead fills the earlier fState<2 branch slot, as in retail.
     This is a source control-flow boundary, not a register pin or emitted
     assembly. The preceding arms still share the original SetState call
     structure and the function remains 98/98 byte-identical.
     Native local records match; full SLD attribution remains open. */
  return;
}



/* ---- tScreenCarSelect::DrawVideoWall  [SCREENCARSELECT.CPP:816-850] ---- */
void tScreenCarSelect::DrawVideoWall(short y)

{
  /* [SYM] 8c decl order: carInfo, validCar */
  tCarInfo carInfo;
  bool validCar;
  /* SYM-CODEGEN-CARRIER: vtbl -- the retail virtual GetCar call's implicit
     dispatch temporary has no SYM source local.  The manual non-virtual ABI
     model needs this cached row pointer: direct this->_vf[1][3] dispatch is
     byte-identical, but fails audit_vtable_indexing as unsafe row indexing. */

  validCar = this->GetCar(carInfo);
  ::DrawBackgroundImage((tScreen *)this,0,0x1c,this->fPermShapes.fShapes,0x96);
  this->DrawOverlay(this->fCurrentOverlays[0]);
  if (((this->fSwapShapes.fFlags & 1) != 0) && (this->fTVsInitialized == 0)) {
    UpdateImages(this->fVideoWall);
    this->fTVsInitialized = 1;
  }
  if ((0 < this->fScreenFadeVal) && (this->fTransitionOff != 0)) {
    TurnOffInstant(this->fVideoWall);
    this->SetBrightness(0,0);
  }
  ::UpdateTransition(this->fVideoWall);
  this->fVideoWall->SetValid(validCar);
  SetAvailable(this->fVideoWall,(ushort)carInfo.fAvailable);
  ::Draw(this->fVideoWall);
  return;
}



/* ---- tScreenCarSelect::GetCar  [SCREENCARSELECT.CPP:887-938] ---- */
/* MATCH 2026-07-11: jump-table CASE MAPPING was WRONG -- the raw oracle's dlabel jtbl_80011AF8
   (asm/data/rdata_80010000.rodata.s:2607) gives the true per-state targets: state0,5->.L8003C270
   (kept); state2,6->.L8003C2D4 (kept); state7->.L8003C310; state1,3,4 (+ state>=8 bounds-fail)
   ->.L8003C3B8. The OLD recon had case7's body swapped with default's, AND both bodies read the
   WRONG SOURCE (frontEnd.raceType/garageCar/sellerCar/carListType) where the oracle actually
   reads FOUR SEPARATE small BSS globals owned by another TU (D_8011472A/D_80114604/D_80114723/
   D_80114729, all zero-init .byte -- asm/data/data_8010CCD4.data.s:9710-9918); declared extern
   locally below (can't touch any header per module-ownership rule). Also: GetStockCar/
   GetNumOwnedCars/GetNumTourneyCars were called via the screencarselect_externs.h fallback
   free-fn stubs -- real oracle calls are the tCarManager:: MEMBER fns (nfs4_types.h:2802/
   2807/2808); switched to member-call syntax like the GetPinkSlipsCar fix. Return-value bug:
   old code did `return 1;`/bare `return;`/fell off the end with bare `return;` in an `int` fn --
   oracle explicitly zeroes $v0 before EVERY early-out (real `return 0;`) and materializes
   `li v0,1` only at the shared success tail; rewritten with explicit 0/1 returns throughout. */
/* 2026-09-22: the four "separate small globals" of the note above are members of nfs3.obj's `frontEnd` (@0x80114600,
   1104 bytes in the SYM): +4 raceType, +0x123 garageCar[0], +0x129 sellerCar, +0x12a carListType.  The 2026-07-11 body
   had the case mapping wrong, not the source; with the right mapping the plain member reads compile to retail's code. */

bool tScreenCarSelect::GetCar(tCarInfo &carInfo)

{
  /* Retail has no caller locals. Direct color capture precedes availability
   * in source; scheduling still emits the availability/color store pair with
   * the proper load gap. No color or count source object is needed. */

  switch(this->fState) {
  case 0:
  case 5:
    carManager.GetStockCar((ushort)(byte)frontEnd.playerCar[0],carInfo);
    if ((int)(uint)(byte)frontEnd.playerCar[0] < CarManager_NumCars(carManager)) {
      carInfo.fColor = frontEnd.carColors[0][(signed char)carInfo.fCarID];
    }
    carInfo.fCountry = frontEnd.carCountry[0][(signed char)carInfo.fCarID];
    break;
  case 2:
  case 6:
    carManager.GetStockCar((ushort)(byte)frontEnd.dealerCar,carInfo);
    carInfo.fColor = frontEnd.carColors[0][(signed char)carInfo.fCarID];
    carInfo.fAvailable = '\x01';
    break;
  case 7:
    if (frontEnd.carListType == 1) {
      if (carManager.GetNumOwnedCars(0) <= 0) {
        return 0;
      }
    }
    /* W64 PASS: the SYM block names no selection local.  Passing the conditional
       byte directly exposes frontEnd's base in $a1 and lets gcc merge both arms
       into the retail call sequence. */
    carManager.GetStockCar((ushort)(byte)
        ((frontEnd.carListType == 0) ? frontEnd.playerCar[0] : frontEnd.garageCar[0]),carInfo);
    if (frontEnd.carListType == 0) {
      carInfo.fColor = frontEnd.carColors[0][(signed char)carInfo.fCarID];
    }
    carInfo.fCountry = frontEnd.carCountry[0][(signed char)carInfo.fCarID];
    break;
  default:
    if (carManager.GetNumOwnedCars(0) <= 0 && frontEnd.raceType != 1) {
      return 0;
    }
    if (frontEnd.raceType == 2 && this->fState != 3) {
      if (carManager.GetNumTourneyCars(0) <= 0) {
        return 0;
      }
    }
    carManager.GetStockCar((ushort)(byte)
        ((this->fState == 3) ? frontEnd.sellerCar : frontEnd.garageCar[0]),carInfo);
    carInfo.fCountry = frontEnd.carCountry[0][(signed char)carInfo.fCarID];
  }
  carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  return 1;
}



/* ---- tScreenCarSelect::SetBrightness  [SCREENCARSELECT.CPP:943-944] ---- */
void tScreenCarSelect::SetBrightness(short bright,short i)

{
  this->fDestBrightness[i] = bright;
}



/* ---- tScreenCarSelect::UpdateBrightness  [SCREENCARSELECT.CPP:950-961] ---- */
void tScreenCarSelect::UpdateBrightness(short i)

{
  if (this->fDestBrightness[i] > this->fBrightness[i]) {
    this->fBrightness[i] = this->fBrightness[i] + 8;
    if (this->fDestBrightness[i] < this->fBrightness[i]) {
      this->fBrightness[i] = this->fDestBrightness[i];
      return;
    }
  }
  else if (this->fDestBrightness[i] < this->fBrightness[i]) {
    this->fBrightness[i] = this->fBrightness[i] + -8;
    if (this->fBrightness[i] < this->fDestBrightness[i]) {
      this->fBrightness[i] = this->fDestBrightness[i];
    }
  }
  return;
}



/* ---- tScreenCarSelect::DrawBackground  [SCREENCARSELECT.CPP:966-993] ---- */
/* 2026-10-12: the empty retail inline pair at+76 reads the video-wall
 * transition direction. The inferred TransitionDirection accessor recovers
 * it without a local capture; its name is not supplied by the pair. All
 * local/type/home/depth and20 scope boundary tuples match at76/76 PASS.
 * The old canUpload necessity marker described an already-removed capture;
 * no such object is present or reintroduced. Ordinary statement layout after
 * removing stale in-body commentary improves SLD72->16 differing tags; the
 * GetCar/load/conditional upload/brightness phase is exact. The fade/draw
 * phase remains seven source lines earlier than retail after its untagged
 * gap; no unexplained padding/comments are invented to seal that tail.
 * End23/27 and full block-line attribution/original text remain open. */
void tScreenCarSelect::DrawBackground()
{
  tCarInfo carInfo;

  if (this->GetCar(carInfo) != 0)
  {
    ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);

    if ((this->fSwapShapes.fFile != (char *)0x0) &&
        (this->fVideoWall[0].TransitionDirection() != -1) &&
        (gCarObj[FEAppB[0]->GetPlayer()]->async_handle == 0) &&
        (0x80 < FE_Ticks() - this->fFadeTicks[0]))
    {
      this->tScreen::UploadSwapShapes(0xb);
      TurnOn(this->fVideoWall);
      if (this->fBrightness[0] == this->fDestBrightness[0]) {
        this->SetBrightness((carInfo.fAvailable != '\0') ? 0x80 : 0x20,0);







      }
    }
  }
  if (this->fScreenFadeVal < 0x80) {
    this->DrawVideoWall(0);
  }
  return;
}



/* ---- tScreenCarSelect::DrawSliders  [SCREENCARSELECT.CPP:1002-1011] ---- */
void tScreenCarSelect::DrawSliders(tCarInfo &carInfo,short x,short y)
{
  short j;

  for (j = 0; j < 5; j++) {
    FETextRender_MenuTextPositioned(textVals[j],x,(short)(y + 4),textState_Unselected,
                                    textType_Default);
    DrawSlider(CarStatValue(remap[j],&carInfo),0,0xb,x,y,0x68,3,7,3,
               false,0,0x80,0);
    y = y + 0xf;
  }
}



/* ---- tScreenCarSelect::DrawForeground  [SCREENCARSELECT.CPP:1015-1264] ---- */
/* W64 (2026-08-11): 65 -> 14 diffs at 557/557 instructions.  Raw retail uses
   the subclass GetCar/SetCar vtable entries 13/12 (offsets 104/96), not the
   decompiler's base-table 3/2 indices.  SYM removes the invented state/overlay
   temporaries, while the modulo-first text-ID expression reproduces retail's
   signed divide-by-19 chain.  Separate source temporaries reproduce retail's
   delayed currentItem/validCar handoffs into $s2/$s5, and a textBase temporary
   preserves the 996 association.  A loop-local direction value preserves the
   invariant `1` in $t0.
   W65: 14 -> 8.  Laundering `currentItemValue` before its named handoff stops
   CSE from replacing retail currentItem/$s2 with the source $s0; placing the
   bShowStats zero after the two handoffs restores its SYM $s1 initialization
   schedule.  Moving overlayDirection's assignment into its consuming arm lets
   the gStateOverlays base precede the invariant `li $t0,1`, sealing the loop
   preheader.  The sole residual is fadeVal's $v0 versus SYM/retail $t0.
   Separate shape-fade storage, register spelling, join fences, a named flags
   pointer, and a default-first clamp funnel were neutral or worse (8/8/13/22). */
/* SOURCE-REVIEW:557/557 PASS after restoring the real showroom else owner.
 * All original named locals have their retail homes/depths. fadeVal is the
 * shape fade in t0, not an extra named text-fade argument: direct CalcFadeVal
 * arguments remove the latter handoff and direct fSpeechTicks reads remove
 * shapeTicks. CurrentMenu/GetPlayer supply both actual application receivers.
 * currentItemValue/validCarValue, overlayDirection, textBase, the absorption
 * expression and the existing fence remain unresolved, not original-source
 * exemptions. Combined removal was16dif/555; removing the fence with staged
 * pointers was18/557; direct overlay direction7/556. Direct text-ID routes:
 * negative-subtrahend6/557, unsigned-base2/557, textID accumulation134/557.
 * All failed/neutral code candidates were restored. No compiler floor claimed. */
void tScreenCarSelect::DrawForeground()

{
  short i;
  tCarInfo carInfo;
  short bShowStats;
  tMenuItem *currentItem;
  /* SYM: validCar (REG BOOL) closes the 8c fn-scope set */
  bool validCar;
  tMenuItem *currentItemValue;
  bool validCarValue;
  int overlayDirection;
  
  currentItemValue = FEApp->CurrentMenu(kPlayerOne)->fItemList[
                     FEApp->CurrentMenu(kPlayerOne)->fCurrentItem];
  validCarValue = this->GetCar(carInfo);
  currentItem = (tMenuItem *)((int)currentItemValue & ((int)currentItemValue | (int)menuDefs));
  validCar = validCarValue;
  bShowStats = false;
  MenuItem_Disable(&menuDefs->itemOpponentUpgrades);
  if (this->fState == 1) {
    bShowStats = (tMenuItemNFS4LeftRightChoice *)currentItemValue == &menuDefs->itemGarageCar;
    MenuItem_Enable(&menuDefs->itemUpgradeCar);
    if (((frontEnd.raceType == RaceType_Tournament) && (frontEnd.tier == '\0')) &&
       (FECheat_IsCheatEnabled(cheat_FinishedTournament) != 0)) {
      MenuItem_Enable(&menuDefs->itemOpponentUpgrades);
    }
    __asm__("" : : "r"(currentItem));
    if ((validCar != 0) && (carInfo.fCarClass < 5)) {
      this->fOverlays[4].direction = 1;
    }
    else {
      MenuItem_Disable(&menuDefs->itemUpgradeCar);
      this->fOverlays[4].direction = -1;
    }
  }
  else if (this->fState == 0) {
    if ((tMenuItemNFS4LeftRightChoice *)currentItemValue == &menuDefs->itemCar) {
      bShowStats = true;
    }
    MenuItem_Enable(&menuDefs->itemColor);
    MenuItem_Enable(&menuDefs->itemShowcase);
    if (carInfo.fCarClass == '\a') {
      MenuItem_Disable(&menuDefs->itemColor);
      MenuItem_Disable(&menuDefs->itemShowcase);
    }
  }
  else if (this->fState == 2) {
    if ((tMenuItemNFS4LeftRightChoice *)currentItemValue == &menuDefs->itemDealerCar) {
      bShowStats = true;
    }
  }
  else if (this->fState == 3) {
    if ((tMenuItemNFS4LeftRightChoice *)currentItem == &menuDefs->itemSellerCar) {
      bShowStats = true;
    }
    MenuItem_Enable(&menuDefs->itemSellCar);
    if (validCar != 0) {
      this->fOverlays[4].direction = 1;
    }
    else {
      this->fOverlays[4].direction = -1;
      MenuItem_Disable(&menuDefs->itemSellCar);
    }
  }
  else if (this->fState == 4) {
    bShowStats = true;
  }
  if (validCar == 0) {
    bShowStats = false;
  }
  this->fOverlays[6].direction = bShowStats ? 1 : -1;
  for (i = 0; i < 4; i++) {
    if (this->fCurrentOverlays[i] != (tOverlay *)0x0) {
      if ((int)this->fCurrentOverlays[i]->ID == (int)gStateOverlays[this->fState][i]) {
        continue;
      }
      this->fCurrentOverlays[i]->direction = -1;
      if (this->fCurrentOverlays[i]->transition > 0) {
        continue;
      }
      this->fCurrentOverlays[i] = (tOverlay *)0x0;
    }
    if (-1 < (signed char)gStateOverlays[this->fState][i]) {
      overlayDirection = 1;
      this->fCurrentOverlays[i] = this->fOverlays + (signed char)gStateOverlays[this->fState][i];
      this->fCurrentOverlays[i]->transition = 0;
      this->fCurrentOverlays[i]->direction = overlayDirection;
    }
  }
  for (i = 1; i < 4; i++) {
    this->DrawOverlay(this->fCurrentOverlays[i]);
  }
      if (validCar == 0) {
        carInfo.fCarID = -1;
      }
      this->UpdateVideoWall(carInfo);
      if (gCarObj[FEApp->GetPlayer()]->async_handle != 0) {
        this->SetBrightness(0,0);
        TurnOff(this->fVideoWall);
        this->fFadeTicks[0] = FE_Ticks();
      }
      this->UpdateBrightness(0);
      if ((u_int)((ushort)this->fState - 5) >= 2) {
        showRoomFlag = 0;
        this->fCameraRotation = this->fCameraRotation + 3;
        DrawCar(carInfo,0x13a,0x54,4.0,-7.5,
                   (char)this->fBrightness[0],true,this->fCameraRotation,kPlayerOne);
      }
      else {
        int screenX;
        int screenY;
        int camRot;
        int cameraY;
        int cameraZ;
        int textID;
        int textBase;
        u_long textTicks;
        long elapsedticks;
        short knot1;
        short knot2;
        short knot3;
        short knot4;
        tDrawShapeExtended drawFlags;
        int textColor;
        int fadeVal;

        screenX = 0;
        screenY = 0;
        camRot = 0;
        cameraY = 0;
        elapsedticks = (FE_Ticks() - this->fSpeechTicks) + -0x100;
        cameraZ = 0;
        if ((-1 < elapsedticks) && (-1 < (signed char)carInfo.fSpeechCarID)) {
          textBase = (elapsedticks >> 9) % 0x13 + 0x3e4;
          textID = textBase + (signed char)carInfo.fSpeechCarID * 0x13;
          textTicks = elapsedticks - ((elapsedticks >> 9) << 9);
          textColor = kRGBVals[(byte)textDefinitions[TextSys_WordFlags((short)textID)][4]];
          if (textTicks < 0x80) {
            textColor = CalcFadeVal(textColor,0x80 - textTicks);
          }
          else if (0x200 - textTicks < 0x80) {
            textColor = CalcFadeVal(textColor,textTicks - 0x180);
          }
          FETextRender_FullTextRGB(TextSys_Word(textID),(short)TextSys_WordX(textID),
                                  (short)TextSys_WordY(textID),textColor,'\0',0);
        }
        drawFlags.tint[0] = 0x551e00;
        drawFlags.custom_shapes = this->fSwapShapes.fShapes;
        fadeVal = 0x80;
        if (this->fSpeechTicks >= 0x101) {
          if (this->fSpeechTicks >= 0x181) {
            fadeVal = 0;
          }
          else {
            fadeVal = 0x180 - this->fSpeechTicks;
          }
        }
        DrawShapeExtended(0xA,0x200,0,0,fadeVal,0,&drawFlags);
        elapsedticks = FE_Ticks() - this->fShowroomTicks;
        while (600 < elapsedticks) {
          this->fShowroomTicks = this->fShowroomTicks + 600;
          this->fSplineInterval = this->fSplineInterval + 1;
          elapsedticks -= 600;
          if (6 < this->fSplineInterval) {
            this->fSplineInterval = this->fSplineInterval - 5;
          }
        }
        knot1 = this->fSplineInterval;
        gRotateOffset[0] = 0;
        if (6 < knot1) {
          knot1 -= 5;
          gRotateOffset[0] = 0x4000000;
        }
        knot2 = knot1 + 1;
        gRotateOffset[1] = gRotateOffset[0];
        if (6 < knot2) {
          knot2 = knot1 - 4;
          gRotateOffset[1] = gRotateOffset[0] + 0x4000000;
        }
        knot3 = knot2 + 1;
        gRotateOffset[2] = gRotateOffset[1];
        if (6 < knot3) {
          knot3 = knot2 - 4;
          gRotateOffset[2] = gRotateOffset[1] + 0x4000000;
        }
        knot4 = knot3 + 1;
        gRotateOffset[3] = gRotateOffset[2];
        if (6 < knot4) {
          knot4 = knot3 - 4;
          gRotateOffset[3] = gRotateOffset[2] + 0x4000000;
        }
        this->CalcSplinePosition((int)knot1,(int)knot2,(int)knot3,(int)knot4,
                           (u_long)elapsedticks,cameraY,cameraZ,screenX,screenY,camRot);
        showRoomFlag = 1;
        DrawCar(carInfo,(short)screenX,(short)screenY,
                   (float)cameraY * 0.0000152587890625f,
                   (float)cameraZ * 0.0000152587890625f,(char)this->fBrightness[0],
                   true,camRot,kPlayerOne);
        if ((((validCar != 0) &&
             (0x280 < gettick() - this->fSpeechTicks)) &&
             (this->fSpeechPlayed == 0)) && (-1 < (signed char)carInfo.fSpeechCarID)) {
          this->fSpeechPlayed = 1;
          FeAudio_AsyncPlaySpeech(0,(int)(signed char)carInfo.fSpeechCarID)
          ;
        }
      }
      if (((gCarObj[0]->async_handle == 0) && (this->fBrightness[0] == this->fDestBrightness[0])) &&
         ((this->fBrightness[0] == 0 && (0x80 < FE_Ticks() - this->fFadeTicks[0])))) {
        this->SetBrightness((carInfo.fAvailable != '\0') ? 0x80 : 0x20,0);
        TurnOn(this->fVideoWall);
      }
      return;
}



/* ---- tScreenCarSelectDuel::PreLoad  [SCREENCARSELECT.CPP:1272-1296] ---- */
void tScreenCarSelectDuel::PreLoad()

{
  /* SYM/PASS: retail records only carInfo and buffer.  Direct destination
     assignments and flattened slot 13 remove buf_or_path/str/vtbl exactly. */
  /* SYM-CODEGEN-CARRIER: useDefault -- folding `call == 1` into the following
     guard is FAIL4 (74/74), replacing retail's xori/beqz with li/beq.  SYM
     cannot recover an identifier for this optimized boolean; useDefault is
     the semantic reconstruction of the required materialized predicate. */
  /* [SYM] 8c decl order: carInfo, buffer */
  tCarInfo carInfo;
  char buffer [32];
  bool useDefault;
  
  (this->fOpponentShapes).fShapes = (tTexture_ShapeInfo *)0x0;
  ::InitializeShapes((tScreen *)this,&this->fOpponentShapes,5);
  ::PreLoad((tScreen *)this);
  this->fSwapShapes.fDestFile = Platform_GetDCTBuffer(16000,"VideoWall");
  this->fOpponentShapes.fDestFile =
      Platform_GetDCTBuffer(16000,"OpponentVid");
  useDefault = this->GetCar(carInfo) == 1;
  if (!useDefault) {
    carManager.GetStockCar(0,carInfo);
  }
  sprintf(buffer,"z%s",carInfo.fSmallName);
  ::AsyncLoadShapeFile((tScreen *)this,buffer,&this->fSwapShapes);
  carManager.GetStockCar((ushort)(byte)frontEnd.oppCar,carInfo);
  sprintf(buffer,"z%s",carInfo.fSmallName);
  ::AsyncLoadShapeFile((tScreen *)this,buffer,&this->fOpponentShapes);
  this->fOpponentTVsInitialized = 0;
  return;
}



/* ---- tScreenCarSelectDuel::AllocateAsyncBuffer  [SCREENCARSELECT.CPP:1300-1301] ---- */
void tScreenCarSelectDuel::AllocateAsyncBuffer()

{
}



/* ---- tScreenCarSelectDuel::FreeAsyncBuffer  [SCREENCARSELECT.CPP:1304-1308] ---- */
void tScreenCarSelectDuel::FreeAsyncBuffer()

{

  Platform_ResetDCTBuffer();
  this->fSwapShapes.fDestFile = (char *)0x0;
  (this->fOpponentShapes).fDestFile = (char *)0x0;
}



/* ---- tScreenCarSelectDuel::InitializeVideoWall  [SCREENCARSELECT.CPP:1312-1334] ---- */
void tScreenCarSelectDuel::InitializeVideoWall()

{
  /* SYM records no locals.  Repeating fVideoWall and fVideoWall + 1 at their
     consumers lets GCC retain the two addresses anonymously in retail $s1
     and $s0 without the former vw_player/vw_opp source identities. */
  ::Initialize(&this->fVideoWall[0],this->tvConfigs,
             this->fSwapShapes.fShapes,0,5,tvSplitOrder,0);
  SetAvailableText(this->fVideoWall,0xf8,0x10e,0x2d);
  if ((this->fSwapShapes.fFlags & 1) != 0) {
    this->fVideoWall->SetOffset(6,0);
    UpdateImages(this->fVideoWall);
    this->fTVsInitialized = 1;
  }
  ::Initialize(&this->fVideoWall[1],this->tvConfigs + 5,(this->fOpponentShapes).fShapes,0,5,
             tvSplitOrder,0);
  SetAvailableText(this->fVideoWall,0xf8,0x10e,0x96);
  if (((this->fOpponentShapes).fFlags & 1) != 0) {
    (this->fVideoWall + 1)->SetOffset(6,0x69);
    UpdateImages(this->fVideoWall + 1);
    this->fTVsInitialized = 1;
  }
  return;
}



/* ---- tScreenCarSelectDuel::Initialize  [SCREENCARSELECT.CPP:1339-1342] ---- */
void tScreenCarSelectDuel::Initialize()

{
  this->tScreenCarSelect::Initialize();
  this->fState = 0;
  gShowroomLights[0] = 0;
}



/* ---- tScreenCarSelectDuel::Cleanup  [SCREENCARSELECT.CPP:1346-1348] ---- */
void tScreenCarSelectDuel::Cleanup()

{
  ::FreeShapes((tScreen *)this,&this->fOpponentShapes);
  this->tScreenCarSelect::Cleanup();
}



/* ---- tScreenCarSelectDuel::DrawVideoWall  [SCREENCARSELECT.CPP:1352-1383] ---- */
void tScreenCarSelectDuel::DrawVideoWall(short y)

{
  /* [SYM] 8c decl order: validCar, carInfo, i */
  bool validCar;
  tCarInfo carInfo;
  short i;
  /* SYM-CODEGEN-CARRIER: vtbl -- the retail virtual GetCar call's implicit
     dispatch temporary has no SYM source local.  The manual non-virtual ABI
     model needs this cached row pointer: direct this->_vf[1][3] dispatch is
     byte-identical, but fails audit_vtable_indexing as unsafe row indexing. */

  validCar = this->GetCar(carInfo);
  i = 0;
  do {
    DrawShapeExtended(i,0,0,-(int)y,
               (int)this->fScreenFadeVal,0,(tDrawShapeExtended *)0x0);
    i = i + 1;
  } while (i < 0xc);
  if ((0 < this->fScreenFadeVal) &&
     (this->fTransitionOff != 0)) {
    TurnOffInstant(this->fVideoWall);
    this->SetBrightness(0,0);
  }
  if (((this->fSwapShapes.fFlags & 1) != 0) &&
     (this->fTVsInitialized == 0)) {
    this->fVideoWall->SetOffset(6,0);
    UpdateImages(this->fVideoWall);
    this->fTVsInitialized = 1;
  }
  ::UpdateTransition(this->fVideoWall);
  this->fVideoWall->SetValid(validCar);
  SetAvailable(this->fVideoWall,(ushort)carInfo.fAvailable);
  ::Draw(this->fVideoWall);
}



/* ---- tScreenCarSelectDuel::DrawOpponentVideoWall  [SCREENCARSELECT.CPP:1387-1414] ---- */
void tScreenCarSelectDuel::DrawOpponentVideoWall(short y)

{
  short i;

  i = 0;
  do {
    DrawShapeExtended(i,0,0,-(int)y,
               (int)this->fScreenFadeVal,0,(tDrawShapeExtended *)0x0);
    i = i + 1;
  } while (i < 0xc);
  if ((0 < this->fScreenFadeVal) &&
     (this->fTransitionOff != 0)) {
    TurnOffInstant(this->fVideoWall + 1);
    this->SetBrightness(0,1);
  }
  if (((this->fSwapShapes.fFlags & 1) != 0) &&
     (this->fOpponentTVsInitialized == 0)) {
    (this->fVideoWall + 1)->SetOffset(6,0x69);
    UpdateImages(this->fVideoWall + 1);
    this->fOpponentTVsInitialized = 1;
  }
  ::UpdateTransition(this->fVideoWall + 1);
  (this->fVideoWall + 1)->SetValid(1);
  SetAvailable(this->fVideoWall + 1,1);
  ::Draw(this->fVideoWall + 1);
  return;
}



/* ---- tScreenCarSelectDuel::GetShapeInfo  [SCREENCARSELECT.CPP:1418-1433] ---- */
void tScreenCarSelectDuel::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  /* SYM-CODEGEN-CARRIER: vtbl -- the retail virtual GetCar call's implicit
     dispatch temporary has no SYM source local.  The manual non-virtual ABI
     model needs this cached row pointer: direct this->_vf[1][3] dispatch is
     byte-identical, but fails audit_vtable_indexing as unsafe row indexing. */
  tCarInfo carInfo;
  
  numPermShapes = 0x34;
  numSwapShapes = 5;
  if ((this->GetCar(carInfo) ^ 1) != 0) {
    carManager.GetStockCar(0,carInfo);
  }
  this->fPreviousCar = (ushort)carInfo.fCarIndex;
  this->fPreviousCarID = (short)(signed char)carInfo.fCarID;
  this->fPreviousCountry = (ushort)carInfo.fCountry;
  this->fPreviousOpponent = -1;
  *permFileName = "zDuel";
  *swapFileName = (char *)0x0;
  return;
}



/* ---- tScreenCarSelectDuel::UpdateVideoWall  [SCREENCARSELECT.CPP:1438-1450] ---- */
void tScreenCarSelectDuel::UpdateVideoWall(tCarInfo &carInfo)

{
  if ((((ushort)carInfo.fCarIndex != this->fPreviousCar) ||
      ((int)(signed char)carInfo.fCarID != (int)this->fPreviousCarID)) ||
     ((carInfo.fCarClass == '\a' &&
      (this->fPreviousCountry != (ushort)carInfo.fCountry)))) {
    if (-1 < (signed char)carInfo.fCarID) {
      ::AsyncLoadSwapShapeFile((tScreen *)this,carInfo.fSmallName);
    }
    this->fPreviousCar = (ushort)carInfo.fCarIndex;
    this->fPreviousCarID = (short)(signed char)carInfo.fCarID;
    this->fPreviousCountry = (ushort)carInfo.fCountry;   /* stored BEFORE fTVsInitialized: that order needs no temp (SYM has none) */
    this->fTVsInitialized = 0;
    this->SetBrightness(0,0);
    TurnOff(this->fVideoWall);
  }
  return;
}



/* ---- tScreenCarSelectDuel::UpdateOpponentVideoWall  [SCREENCARSELECT.CPP:1455-1466] ---- */
void tScreenCarSelectDuel::UpdateOpponentVideoWall(tCarInfo &carInfo)

{
  char buffer [32];
  
  if ((ushort)carInfo.fCarIndex != this->fPreviousOpponent) {
    sprintf(buffer,"z%s",carInfo.fSmallName);
    ::AsyncLoadShapeFile((tScreen *)this,buffer,&this->fOpponentShapes);
    this->fOpponentTVsInitialized = 0;
    this->fPreviousOpponent = (ushort)carInfo.fCarIndex;
    this->SetBrightness(0,1);
    TurnOff(this->fVideoWall + 1);
  }
  return;
}



/* ---- tScreenCarSelectDuel::DrawBackground  [SCREENCARSELECT.CPP:1471-1607] ---- */
/* 2026-10-12 MATCH414/414, native CLEAN: the two readiness predicates use
 * the actual TransitionDirection getter, async state and elapsed expression
 * directly, without p1Ready/p2Ready or either elapsed capture. Their former
 * direct-form failures were relative to the incomplete getter/source regions.
 * For both fade-in checks, async completion owns the outer region and the
 * brightness/equality/elapsed condition belongs to its inner body. All seven
 * ordered local/parameter tuples and all70 scope boundary tuples match retail.
 * Nesting after brightness equality was also byte-exact, but its two regions
 * began20 bytes too late; placing that equality in the inner test fixes them.
 * No new helper, local, qualifier, fence, fake region or output rewrite.
 * SOURCE-REVIEW: complete SLD/original getter/expression spelling is unsealed. */
void tScreenCarSelectDuel::DrawBackground()

{
  /* [SYM] 8c decl order: r, carInfo, drenv, daprim, temp, validCar */
  RECT r;
  tCarInfo carInfo;
  DRAWENV *drenv;
  DR_AREA *daprim;
  RECT temp;
  bool validCar;
  
  drenv = (DRAWENV *)Draw_GetDRAWENV(Draw_gPlayer1View,gFlip);
  daprim = (DR_AREA *)Render_gPacketPtr;
  this->fState = 7;
  temp.x = 0;
  temp.y = *(short *)((char *)drenv + 2);
  temp.w = 0x200;
  temp.h = (short)screenheight;
  ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr;
  Render_gPacketPtr = (u_char *)daprim + 0xc;
  ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
  SetDrawArea(daprim,&temp);
  r.x = 0x122;
  r.w = 200;
  r.h = 0xc;
  r.y = 0x82;
  DrawShape_NFS4RoundRectangle(
      (int)menuDefs->iteratorOpponentCar.TextValue(kPlayerBoth),r,0);
  carManager.GetStockCar((ushort)(byte)frontEnd.oppCar,carInfo);
  carInfo.fColor = carInfo.fColorOrder[carInfo.fDefaultColor];
  this->UpdateOpponentVideoWall(carInfo);
  ::IsShapeFileLoaded((tScreen *)this,&this->fOpponentShapes);
  if ((this->fOpponentShapes.fFile != (char *)0x0) &&
      (this->fVideoWall[1].TransitionDirection() != -1) &&
      (gCarObj[1]->async_handle == 0) &&
      (0x80 < FE_Ticks() - this->fFadeTicks[1])) {
    this->tScreen::UploadShapes(this->fOpponentShapes,0,0x41,5,0);
    this->fOpponentTVsInitialized = 0;
    TurnOn(this->fVideoWall + 1);
    if (this->fBrightness[1] == this->fDestBrightness[1]) {
      this->SetBrightness(0x80,1);
    }
  }
  this->fCameraRotation = this->fCameraRotation + 3;
  carInfo.fUpgrades = '\0';
  if ((gCarObj[1]->async_handle != 0) && (0x80 < FE_Ticks() - this->fFadeTicks[1])) {
    this->SetBrightness(0,1);
    TurnOff(this->fVideoWall + 1);
    this->fFadeTicks[1] = FE_Ticks();
  }
  this->UpdateBrightness(1);
  showRoomFlag = 0;
  DrawCar(carInfo,0x116,0xb8,1.7,-9.9,(char)this->fBrightness[1],false,
             this->fCameraRotation,kPlayerTwo);
  if (gCarObj[1]->async_handle == 0) {
    if ((this->fBrightness[1] == this->fDestBrightness[1]) &&
        (this->fBrightness[1] == 0) && (0x80 < FE_Ticks() - this->fFadeTicks[1])) {
      this->SetBrightness(0x80,1);
      TurnOn(this->fVideoWall + 1);
    }
  }
  this->DrawOpponentVideoWall(0x69);
  daprim = (DR_AREA *)Render_gPacketPtr;
  temp.x = 0;
  temp.y = *(short *)((char *)drenv + 2) + 0x80;
  temp.w = 0x200;
  temp.h = (short)screenheight + -0x80;
  ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr;
  Render_gPacketPtr = (u_char *)daprim + 0xc;
  ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
  SetDrawArea(daprim,&temp);
  PSXDrawSquare(0,0,screenheight / 2,0x200,screenheight / 2);
  validCar = this->GetCar(carInfo);
  if (validCar != 0) {
    r.y = 0x19;
    if (frontEnd.carListType == '\0') {
      DrawShape_NFS4RoundRectangle(
          menuDefs->iteratorCar1.TextValue(kPlayerBoth),r,0);
    }
    else {
      DrawShape_NFS4RoundRectangle(
          menuDefs->iteratorGarageCar.TextValue(kPlayerBoth),r,0);
    }
  }
  else {
    carInfo.fCarID = -1;
  }
  this->UpdateVideoWall(carInfo);
  if ((gCarObj[0]->async_handle != 0) && (0x80 < FE_Ticks() - this->fFadeTicks[0])) {
    this->SetBrightness(0,0);
    TurnOff(this->fVideoWall);
    this->fFadeTicks[0] = FE_Ticks();
  }
  this->UpdateBrightness(0);
  showRoomFlag = 0;
  DrawCar(carInfo,0x116,0x4f,1.7,-9.9,(char)this->fBrightness[0],false,
             this->fCameraRotation,kPlayerOne);
  if (gCarObj[0]->async_handle == 0) {
    if ((this->fBrightness[0] == this->fDestBrightness[0]) &&
        (this->fBrightness[0] == 0) && (0x80 < FE_Ticks() - this->fFadeTicks[0])) {
      this->SetBrightness((carInfo.fAvailable != '\0') ? 0x80 : 0x20,0);
      TurnOn(this->fVideoWall);
    }
  }
  if (validCar != 0) {
    ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
    if ((this->fSwapShapes.fFile != (char *)0x0) &&
        (this->fVideoWall[0].TransitionDirection() != -1) &&
        (gCarObj[0]->async_handle == 0) &&
        (0x80 < FE_Ticks() - this->fFadeTicks[0])) {
      this->tScreen::UploadSwapShapes(5);
      TurnOn(this->fVideoWall);
      if (this->fDestBrightness[0] == this->fBrightness[0]) {
        this->SetBrightness((carInfo.fAvailable != '\0') ? 0x80 : 0x20,0);
      }
    }
  }
  this->DrawVideoWall(0)
  ;
  return;
}



/* ---- tScreenCarSelectDuel::DrawForeground  [SCREENCARSELECT.CPP:1613-1635] ---- */
/* MATCH/SYM: 106 -> PASS (118/118).  The caller owns exactly carInfo, i, j,
   y, and validCar.  Flattened slot 13 removes the decompiler-only vtbl alias
   while remaining safe under the vtable audit.  The conditional CarStatValue
   call restores SYM's nested inline scope and removes both fabricated `ci`
   and `sliderResult` without changing one retail instruction. */
void tScreenCarSelectDuel::DrawForeground()

{
  tCarInfo carInfo;
  short i;
  short j;
  short y;
  bool validCar;
  
  y = 0x2d;
  validCar = this->GetCar(carInfo);
  for (i = 0; i < 2; i++) {
    for (j = 0; j < 5; j++) {
      FETextRender_MenuTextPositionedJustify(text2PVals[j],500,y + 4,1,
          textState_Unselected,textType_ScreenInfo);
      /* SYM-INLINE-LOCAL: carStat = CarStatValue
         SYM-INLINE-LOCAL: carInfo = CarStatValue
         SYM-INLINE-LOCAL: result = CarStatValue */
      DrawSlider((validCar != 0) ? CarStatValue(remap[j],&carInfo) : 0,
                 0,0xb,0x1a1,y,0x49,3,4,3,true,0,0x80,0);
      y = y + 0xf;
    }
    y = 0x96;
    carManager.GetStockCar((ushort)(byte)frontEnd.oppCar,carInfo);
  }
}



/* ---- tScreenCarSelectTwoPlayer::GetCar  [SCREENCARSELECT.CPP:1640-1664] ---- */
/* MATCH 2026-07-11: same fix family as the other 2 GetCar overloads -- GetStockCar/
   GetNumOwnedCars/GetGarageCar were called via the screencarselect_externs.h free-fn
   fallback stubs; switched to the real tCarManager:: member calls (nfs4_types.h:2802-2803/
   2807). `frontEnd.carColors[player * 0x18][...]`/`carCountry[... * 0x18][...]` used the
   WRONG per-player stride (0x18=24) -- carColors/carCountry are declared `char[2][48]`
   (nfs4_types.h:2833); the oracle's own scaling (sll 1;addu;sll 4 = *3*16 = *48) confirms
   48, not 24 -- real 2-D indexing `frontEnd.carColors[player][...]` lets the compiler derive
   the correct *48 scale AND matches the oracle's shift/add/shift sequence exactly. `fCarID`
   is read `lb` (signed) in the oracle vs the default `lbu` this build gives plain `char`
   reads -- cast at each use site (catalog "char IS UNSIGNED on this build" row). Also a
   correctness bug: the `GetNumOwnedCars(otherPlayer)<=0` guard returned `1` (success) where
   the oracle explicitly zeroes $v0 and returns 0 (failure) -- caller previously treated a
   failed car lookup as success. The ORIGINAL `player` (FEApp->fPlayer) stays live for the
   `garageCar[player]` index across the whole `else` arm even though a SEPARATE `otherPlayer`
   (reset to 0 when the first GetNumOwnedCars(player) call returns <=0) is threaded through the
   second GetNumOwnedCars call + GetGarageCar's 3rd (playerNum) arg -- oracle keeps them in two
   distinct registers (s5 vs s0/s3), so keep them as two distinct C locals. */
bool tScreenCarSelectTwoPlayer::GetCar(tCarInfo &carInfo)

{
  /* SYM-INLINE-THIS: GetPlayer */
  /* MATCH 2026-08-11 (59 -> PASS, 84/84).  SYM 8c @0x8003e040 gives fsize 48,
     mask $803f0000 = ra + s0..s5;
     REGPARM `carInfo` = $18 ($s2); the ONLY named REG locals are
     `currentplayer` = $21 ($s5) and `garageNumber` = $19 ($s3), both type INT.
     Ghidra's `byte player / byte color / short count / short otherPlayer` were
     inventions -- the byte types cost two dead `andi ..,255` promotions and the
     named `count` pinned an extra pseudo.  The missing source shape was an INT
     `player` cache used by the stock arm and first ownership query, distinct from
     named `currentplayer` (later garage index) and mutable `garageNumber`.
     That preserves retail's three simultaneous FEApp->fPlayer values naturally:
     anonymous/cache s0, currentplayer s5, garageNumber s3; no fence is needed. */
  int currentplayer;
  int garageNumber;

  currentplayer = FEApp->GetPlayer();
  garageNumber = currentplayer;
  if (frontEnd.carListType == '\0') {
    carManager.GetStockCar((ushort)(byte)frontEnd.playerCar[currentplayer],carInfo);
    carInfo.fColor = carInfo.fColorOrder
         [frontEnd.carColors[currentplayer][(signed char)carInfo.fCarID]];
  }
  else {
    if (carManager.GetNumOwnedCars((short)currentplayer) <= 0) {
      garageNumber = 0;
    }
    if (carManager.GetNumOwnedCars((short)garageNumber) <= 0) {
      return 0;
    }
    carManager.GetGarageCar((ushort)(byte)frontEnd.garageCar[currentplayer],carInfo,garageNumber);
    carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  }
  carInfo.fCountry = frontEnd.carCountry[FEApp->GetPlayer()][(signed char)carInfo.fCarID];
  return 1;
}



/* ---- tScreenCarSelectTwoPlayer::DrawVideoWall  [SCREENCARSELECT.CPP:1668-1701] ---- */
/* MATCH 2026-08-03 (18->PASS): the unsized FEApp view keeps %hi(FEApp)
   live while reloading the pointer value at each access, as in retail. */
/* 2026-10-12 MATCH104/104, native CLEAN: loaded-shapes and not-yet-initialized
 * TV tests are nested source conditions, not one && binding region. Restoring
 * them places both actual FEApp receivers at retail depth6 and reproduces all
 *18 scope boundary tuples. No helper, dummy region or replacement carrier.
 * Complete instruction-line attribution/original text remains unsealed. */
void tScreenCarSelectTwoPlayer::DrawVideoWall(short y)

{
  /* [SYM] 8c decl order: i, validCar, carInfo */
  short i;
  bool validCar;
  tCarInfo carInfo;

  validCar = this->GetCar(carInfo);
  i = 0;
  do {
    DrawShapeExtended(i,0,0,-(int)y,
               (int)this->fScreenFadeVal,0,(tDrawShapeExtended *)0x0);
    i = i + 1;
  } while (i < 0xc);
  if ((this->fSwapShapes.fFlags & 1) != 0) {
    if (this->fTVsInitialized == 0) {
      this->fVideoWall->SetOffset(6,(FEApp->GetPlayer() != 0) ? 0x69 : 0);
      SetAvailableText(this->fVideoWall,0xf8,0x10e,
          (FEApp->GetPlayer() != 0) ? 0x96 : 0x2d);
      UpdateImages(this->fVideoWall);
      this->fTVsInitialized = 1;
    }
  }
  if ((0 < this->fScreenFadeVal) &&
     (this->fTransitionOff != 0)) {
    TurnOffInstant(this->fVideoWall);
    this->SetBrightness(0,0);
  }
  ::UpdateTransition(this->fVideoWall);
  this->fVideoWall->SetValid(validCar);
  SetAvailable(this->fVideoWall,(ushort)carInfo.fAvailable);
  ::Draw(this->fVideoWall);
  return;
}



/* ---- tScreenCarSelectTwoPlayer::GetShapeInfo  [SCREENCARSELECT.CPP:1705-1719] ---- */
void tScreenCarSelectTwoPlayer::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  tCarInfo carInfo;
  
  numPermShapes = 0x34;
  numSwapShapes = 5;
  *(short *)((int)this + 0x11e) = -1;
  *(short *)((int)this + 0x120) = -1;
  *(short *)((int)this + 0x122) = -1;
  carManager.GetStockCar(0,carInfo);
  *permFileName = "zcarsb";
  sprintf(gSwapFileName[0],"%s",carInfo.fSmallName);
  *swapFileName = gSwapFileName[0];
  return;
}



/* ---- tScreenCarSelectTwoPlayer::UpdateVideoWall  [SCREENCARSELECT.CPP:1723-1735] ---- */
void tScreenCarSelectTwoPlayer::UpdateVideoWall(tCarInfo &carInfo)

{
  if ((((ushort)carInfo.fCarIndex != this->fPreviousCar) ||
      ((int)(signed char)carInfo.fCarID != (int)this->fPreviousCarID)) ||
     ((carInfo.fCarClass == '\a' &&
      (this->fPreviousCountry != (ushort)carInfo.fCountry)))) {
    if (-1 < (signed char)carInfo.fCarID) {
      ::AsyncLoadSwapShapeFile((tScreen *)this,carInfo.fSmallName);
    }
    this->fPreviousCar = (ushort)carInfo.fCarIndex;
    this->fPreviousCarID = (short)(signed char)carInfo.fCarID;
    this->fPreviousCountry = (ushort)carInfo.fCountry;   /* stored BEFORE fTVsInitialized: that order needs no temp (SYM has none) */
    this->fTVsInitialized = 0;
    TurnOff(this->fVideoWall);
    this->SetBrightness(0,0);
  }
  return;
}



/* ---- tScreenCarSelectTwoPlayer::TurnOffVideoWall  [SCREENCARSELECT.CPP:1739-1740] ---- */
void tScreenCarSelectTwoPlayer::TurnOffVideoWall()

{
  TurnOffInstant(this->fVideoWall);
}



/* ---- tScreenCarSelectTwoPlayer::DrawBackground  [SCREENCARSELECT.CPP:1744-1838] ---- */
/* MATCH: unsized-array asm-label view of FEApp (same device as
   tScreenCarSelectTwoPlayer::DrawForeground below) -- the oracle hoists
   `lui $s2,%hi(FEApp)` once and reuses `lw ..,%lo(FEApp)($s2)` at every
   FEApp-> access across this whole function (3+ uses spanning several
   calls); the plain scalar extern compiles to the unschedulable
   `lw $r,sym` macro and gets rematerialized at each use instead. */
/* SOURCE-REVIEW:342/342 PASS with only retail's named objects. Restored all
 * GetPlayer receiver expansions and the transition-direction getter. Direct
 * predicates/arguments then remove elapsed/uploadReady/uploadY and both player
 * captures. Real carInfo.fCarID replaces the signed-ID union alias. Repricing
 * loading after the complete upload rewrite also removes that capture with
 * zero branch divergence; older jump-graph necessity claims were basin-specific.
 * All local/type/home/depth tuples match. Three empty zero-address scopes from
 * the retail prefix remain unidentified; do not manufacture a no-op producer.
 * Complete SLD/original getter and expression spelling remain unsealed. */
void tScreenCarSelectTwoPlayer::DrawBackground()

{
  /* [SYM] 8c decl order: r, carInfo, carY, drenv, daprim, temp */
  RECT r;
  tCarInfo carInfo;
  short carY;
  DRAWENV *drenv;
  DR_AREA *daprim;
  RECT temp;
  
  carY = 0x4f;
  drenv = (DRAWENV *)Draw_GetDRAWENV(Draw_gPlayer1View,gFlip);
  daprim = (DR_AREA *)Render_gPacketPtr;
  setRECT(&temp,0,drenv->clip.y,0x200,(short)screenheight);
  ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr;
  Render_gPacketPtr = (u_char *)daprim + 0xc;
  ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
  SetDrawArea(daprim,&temp);
  r.x = 0x122;
  r.y = 0x19;
  if (FEAppB[0]->GetPlayer() == kPlayerTwo) {
    r.y = 0x82;
  }
  r.w = 200;
  r.h = 0xc;
  if (this->GetCar(carInfo) != 0) {
    r.y = 0x14;
    if (FEAppB[0]->GetPlayer() == kPlayerTwo) {
      carY = 0xb8;
      r.y = 0x80;
    }
    this->fCameraRotation = this->fCameraRotation + 3;
    DrawShape_NFS4RoundRectangle((signed char)carInfo.fCarID + 0x121,r,0);   /* W58-A1: RECT& decl */
    this->UpdateVideoWall(carInfo);
    if (gCarObj[FEAppB[0]->GetPlayer()]->async_handle != 0) {
      this->SetBrightness(0,0);
      this->fFadeTicks[0] = FE_Ticks();
    }
    if (gCarObj[FEAppB[0]->GetPlayer()]->async_handle == 0) {
      if (((this->fBrightness[0] == this->fDestBrightness[0]) &&
           (this->fBrightness[0] == 0)) &&
          (0x80 < FE_Ticks() - this->fFadeTicks[0])) {
        this->SetBrightness(carInfo.fAvailable != '\0' ? 0x80 : 0x20,0);
        TurnOn(this->fVideoWall);
      }
    }
    this->UpdateBrightness(0);
    showRoomFlag = 0;
    DrawCar(carInfo,0x116,carY,1.7,-9.9,(char)this->fBrightness[0],false,
               this->fCameraRotation,FEAppB[0]->GetPlayer());
  }
  else {
    carInfo.fCarID = -1;
    this->UpdateVideoWall(carInfo);
    showRoomFlag = 0;
    DrawCar(carInfo,0x116,0x4f,1.7,-9.9,(char)this->fBrightness[0],false,
               this->fCameraRotation,FEAppB[0]->GetPlayer());
    this->TurnOffVideoWall()
    ;
  }
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  if (((this->fSwapShapes.fFile != (char *)0x0) &&
     (this->fVideoWall[0].TransitionDirection() != -1)) &&
     (gCarObj[FEAppB[0]->GetPlayer()]->async_handle == 0) &&
     (0x80 < FE_Ticks() - this->fFadeTicks[0])) {
    this->tScreen::UploadShapes(this->fSwapShapes,0,
                               FEAppB[0]->GetPlayer() == kPlayerTwo ? 0x41 : 0,5,0);
    TurnOn(this->fVideoWall);
    if (this->fDestBrightness[0] == this->fBrightness[0]) {
      this->SetBrightness(carInfo.fAvailable != '\0' ? 0x80 : 0x20,0);
    }
  }
  r.y = 0;
  if (FEAppB[0]->GetPlayer() == kPlayerTwo) {
    r.y = 0x69;
  }
  this->DrawVideoWall(r.y);
  this->SetDialog();
  setRECT(&temp,0,drenv->clip.y,0x200,(short)(screenheight / 2));
  if (FEAppB[0]->GetPlayer() == kPlayerTwo) {
    temp.y = temp.y + temp.h;
  }
  daprim = (DR_AREA *)Render_gPacketPtr;
  ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr;
  Render_gPacketPtr = (u_char *)daprim + 0xc;
  ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
  SetDrawArea(daprim,&temp);
  return;
}



/* ---- tScreenCarSelectTwoPlayer::DrawForeground  [SCREENCARSELECT.CPP:1842-1876] ---- */
/* MATCH: unsized-array asm-label view of FEApp -- keeps %hi(FEApp) as an RTL
   pseudo so cc1 hoists it into a callee-saved reg and reuses it for both loads
   (oracle `lui $s0,%hi(FEApp)` + two `lw ..,%lo(FEApp)($s0)`); the scalar extern
   compiles to the unschedulable `lw $r,sym` macro and is rematerialized. */
extern tFEApplication *FEAppA[] asm("FEApp");

void tScreenCarSelectTwoPlayer::DrawForeground()
{




  tCarInfo carInfo;
  short j;
  short yOffset;
  bool gotcar;

  yOffset = 0x2d;
  if (FEApp->GetPlayer() == 1) {
    yOffset = 0x96;
  }
  gotcar = this->GetCar(carInfo);
  if (FEApp->GetPlayer() == 0) {
    MenuItem_Enable(&menuDefs->itemColorP1);
    if (gotcar == 0 || carInfo.fCarClass == 7) {
      MenuItem_Disable(&menuDefs->itemColorP1);
    }
  }
  else {
    MenuItem_Enable(&menuDefs->itemColorP2);
    if (gotcar == 0 || carInfo.fCarClass == 7) {
      MenuItem_Disable(&menuDefs->itemColorP2);
    }
  }
  for (j = 0; j < 5; j++) {
    FETextRender_MenuTextPositionedJustify(text2PVals[j],500,(short)(yOffset + 4),1,
                                           textState_Unselected,textType_Default);
    DrawSlider((gotcar != 0) ? CarStatValue(remap[j],&carInfo) : 0,
               0,0xb,0x1a1,yOffset,0x49,3,4,3,
               true,0,0x80,0);
    yOffset = yOffset + 0xf;
  }
}



/* ---- tScreenCarSelectTwoPlayer::SetDialog  [SCREENCARSELECT.CPP:1881-1892] ---- */
void tScreenCarSelectTwoPlayer::SetDialog()
{
  int player = FEApp->GetPlayer();
  if (FEApp->waitingForOtherPlayer[player] != 0) {


    Dialog_SetString(this->CarDialog.SetPosition(0, (player == 0) ? -0x3c : 0x3c, (tPlayer)(short)player),
      (sprintf(WaitingString,Text_WaitingForPlayer(),PlayerName(1 - player)), WaitingString));

    this->CarDialog.tDialogBase::Display();
  }
  else {
    this->CarDialog.Hide();
  }
}



/* ---- tScreenCarSelectTwoPlayer::AllocateAsyncBuffer  [SCREENCARSELECT.CPP:1896-1897] ---- */
void tScreenCarSelectTwoPlayer::AllocateAsyncBuffer()

{
  this->fSwapShapes.fDestFile = Platform_GetDCTBuffer(16000,"VideoWall");
}



/* ---- tScreenCarSelectTwoPlayer::InitializeVideoWall  [SCREENCARSELECT.CPP:1901-1909] ---- */
void tScreenCarSelectTwoPlayer::InitializeVideoWall()

{
  
  ::Initialize(&this->fVideoWall[0],this->tvConfigs,
             this->fSwapShapes.fShapes,0,5,tvSplitOrder,0);
  if ((this->fSwapShapes.fFlags & 1) != 0) {
    UpdateImages(this->fVideoWall);
    this->fTVsInitialized = 1;
  }
  return;
}



/* ---- tScreenCarSelectTwoPlayer::Initialize  [SCREENCARSELECT.CPP:1914-1921] ---- */
void tScreenCarSelectTwoPlayer::Initialize()

{
  
  this->tScreenCarSelect::Initialize();
  this->fState = 0;
  this->fPreviousCar = -1;
  this->fPreviousCarID = -1;
  this->fPreviousCountry = -1;
  this->fDestBrightness[1] = 0;
  this->fDestBrightness[0] = 0;
  this->fBrightness[1] = 0;
  this->fBrightness[0] = 0;
  gShowroomLights[0] = 0;
  return;
}



/* ---- tScreenCarSelectTwoPlayer::Cleanup  [SCREENCARSELECT.CPP:1925-1927] ---- */
void tScreenCarSelectTwoPlayer::Cleanup()

{
  ((tDialogBase *)&this->CarDialog)->Hide();
  this->tScreenCarSelect::Cleanup();
}



/* ---- tScreenPinkSlipsCarSelect::GetCar  [SCREENCARSELECT.CPP:1935-1945] ---- */
/* MATCH 2026-07-11: Ghidra typed this VOID-shaped (unconditional `return 1;`, dead `pv` local
   holding the real return value) -- the raw oracle shows the fn actually returns 0 on EITHER
   guard failing and 1 only on full success (flat descending early-return guard chain, catalog
   §D "flat descending guard-chain" row). `pv` WAS the return value register; write it as a
   real `int` return + early-returns instead of a dead void* local + unconditional `return 1`.
   Correctness bug: caller previously always got `1` back even when no card was loaded.
   Also: call site used the screencarselect_externs.h fallback `void *GetPinkSlipsCar(...)`
   variadic free-fn stub (oracle mangled name is `GetPinkSlipsCar__11tCarManagersR8tCarInfos`
   = the REAL member `tCarManager::GetPinkSlipsCar` declared nfs4_types.h:2804 / defined
   fecars.cpp -- call it as a member so it resolves to the real mangled symbol + true
   3-arg(short,tCarInfo&,short) signature instead of the bogus 4-arg free-fn shape (which was
   materializing carInfo by VALUE into a huge stack frame -- also a correctness bug: `carInfo`
   was being copied instead of passed by the caller's reference). */
bool tScreenPinkSlipsCarSelect::GetCar(tCarInfo &carInfo)
{
  if (PinkSlipsScreenState[0] == CardLoadedFine && PinkSlipsScreenState[1] == CardLoadedFine) {
    const tPlayer player = FEApp->GetPlayer();
    carManager.GetPinkSlipsCar(FrontEnd_PinkSlipsCar(player), carInfo, player);

    carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];

    return 1;
  }
  else {
    return 0;
  }
}



/* ---- tScreenPinkSlipsCarSelect::DrawBackground  [SCREENCARSELECT.CPP:1949-1954] ---- */
void tScreenPinkSlipsCarSelect::DrawBackground()

{
  this->DoMemCardStuff();

  this->tScreenCarSelectTwoPlayer::DrawBackground();
  if (this->fExitingScreen != 0) {
    ((tDialogBase *)&this->CarDialog)->Hide();
  }
}



/* ---- tScreenPinkSlipsCarSelect::DoMemCardStuff  [SCREENCARSELECT.CPP:1958-2061] ---- */
/* SOURCE-REVIEW: 198/198 PASS with only retail's player/card and scoped ret.
 * Dialog_FullyOpen restores the missing readiness pair without the invented
 * ready label. Direct pCI and PinkSlipsScreenState accesses remove cardInfo,
 * pinkState, resultState, resultStatePtr and stateBase; GCC merges the actual
 * outcome stores itself. Old separate-carrier necessity claims are withdrawn.
 * The readiness else-if owns the wait phase through +224; independent guards
 * matched code but ended +196. Positive nested readiness was six differences.
 * Negative card selection `player != kPlayerOne ? 5 : 1` preserves the real
 * branch polarity and retail's single initializer line; reversed arms were
 * four differences at198 words. No original literal spelling is certified.
 * The getter name is inferred; original spelling/full SLD remain unsealed. */
void tScreenPinkSlipsCarSelect::DoMemCardStuff()

{
  int player = FEApp->GetPlayer();
  int card = player != kPlayerOne ? 5 : 1;
  if (this->fExitingScreen != 0) {
    return;
  }
  if ((player == kPlayerTwo) && (PinkSlipsScreenState[0] != CardLoadedFine)) {
    return;
  }
  if (PinkSlipsScreenState[0] == CardCurrentlyLoading) {
    return;
  }
  if (PinkSlipsScreenState[1] == CardCurrentlyLoading) {
    return;
  }
  if (PinkSlipsScreenState[player] == CardLoadedFine) {
    return;
  }
  if (!Dialog_FullyOpen((tDialogBase *)&this->CarDialog)) {
    this->waitfordialog = 0;
    return;
  }
  else if (this->waitfordialog < 5) {
    this->waitfordialog = this->waitfordialog + 1;
    return;
  }
  if (PinkSlipsScreenState[player] != CardCurrentlyLoading) {
    MCRD_handlecardevents(card);
    this->pCI = MCRD_getcard(card);
    if (this->pCI->status == -1) {
      PinkSlipsScreenState[player] = NoCardInserted;
    }
    else if ((CURRENTLYUSINGMEMCARD == 0) && (PinkSlipsScreenState[player] == NoCardInserted)) {
      int ret;   /* [SYM] REG $v1, block opened at SLD 39 */

      PinkSlipsScreenState[player] = CardCurrentlyLoading;
      FEApp->Redraw();
      FEApp->Redraw();
      ret = LoadGame((ushort)player,true,0);
      if (ret == 0) {
        carManager.GetNumPinkSlipsCars((ushort)player);
        carManager.CheapestCarStockPrice();
        if (carManager.GetNumPinkSlipsCars((ushort)player) == 0x20) {
          PinkSlipsScreenState[player] = TooManyCars;
          goto DoMC_pinkSlipsIter;
        }
        if ((1 < carManager.GetNumPinkSlipsCars((ushort)player)) ||
           ((carManager.GetNumPinkSlipsCars((ushort)player) == 1) &&
            (frontEnd.pinkSlipsCash[player] >= carManager.CheapestCarStockPrice()))) {
          PinkSlipsScreenState[player] = CardLoadedFine;
        }
        else {
          PinkSlipsScreenState[player] = NotEnoughCars;
        }
      }
      else {
        switch (ret) {
        case 1:
          PinkSlipsScreenState[player] = CardFailed;
          goto DoMC_pinkSlipsIter;
        case 2:
          PinkSlipsScreenState[player] = CardFailedUnformatted;
          goto DoMC_pinkSlipsIter;
        default:
          PinkSlipsScreenState[player] = CardFailedNotFound;
          break;
        }
      }
    }
  }
DoMC_pinkSlipsIter:
  if (PinkSlipsScreenState[player] == CardLoadedFine) {
    menuDefs->iteratorPinkSlipsCar.Decrement((tPlayer)player);
    menuDefs->iteratorPinkSlipsCar.Increment((tPlayer)player);
  }
  if ((PinkSlipsScreenState[0] == CardLoadedFine) && (PinkSlipsScreenState[1] == CardLoadedFine)) {
    DeInit_Memcard();
    SetLicensePlate();
  }
  return;
}



/* ---- tScreenPinkSlipsCarSelect::DrawForeground  [SCREENCARSELECT.CPP:2064-2065] ---- */
void tScreenPinkSlipsCarSelect::DrawForeground()

{
  this->tScreenCarSelectTwoPlayer::DrawForeground();
}



/* ---- tScreenPinkSlipsCarSelect::Initialize  [SCREENCARSELECT.CPP:2070-2083] ---- */
void tScreenPinkSlipsCarSelect::Initialize()

{
  this->waitfordialog = 0;
  this->fStartCheckTick = 0;
  this->fCardFailed = 0;

  PinkSlipsScreenState[0] = NoCardInserted;

  PinkSlipsScreenState[1] = NoCardInserted;
  this->pCI = MCRD_getcard(1);
  Init_Memcard(true,1);

  this->fExitingScreen = 0;
  this->tScreenCarSelectTwoPlayer::Initialize();
  return;
}



/* ---- tScreenPinkSlipsCarSelect::Cleanup  [SCREENCARSELECT.CPP:2086-2094] ---- */
void tScreenPinkSlipsCarSelect::Cleanup()

{
  this->fExitingScreen = 1;
  PinkSlipsScreenState[0] = WhoCaresWeBeExiting;
  PinkSlipsScreenState[1] = WhoCaresWeBeExiting;

  ((tDialogBase *)&this->CarDialog)->Hide();
  DeInit_Memcard();

  this->tScreenCarSelectTwoPlayer::Cleanup();
}



/* ---- tScreenPinkSlipsCarSelect::SetDialog  [SCREENCARSELECT.CPP:2098-2187] ---- */
/* MATCH W63/P92 PASS (37 -> 0, 164/164 instructions).  The raw CFG/SLD puts the
   CardLoadedFine message arm first and branches to the ready-player Hide arm;
   it also places the shared card-failure tail before the three loading cases.
   Retail SYM records one caller local, `player` in $s0. Direct FEApp getter
   ownership and the ordinary waiting if/else recover the application receiver
   and +204..+340 region. Its waiting-string dlg alias is removed at164/164.
   Per-case Display(word) overload calls restore all eight actual dialog this
   records and remove the remaining three dlg objects and wordnum. All named
   local/type/home/depth tuples now match retail. Inferred position/player
   methods supply both initial pairs without an extra enum parameter record.
   No new storage, fake reference, asm or qualifier is used. Every scope tuple
   matches after a common break OUTSIDE the no-card if/else, with the real
   fCardFailed clear kept only in the failed-card arm. That source structure
   restores the caller end +428 without altering the merged store/call stream.
   RTL of the earlier body put parent note335 after jump333/barrier334; the
   inline end notes327/330 move before calls while that parent stayed late.
   Return/early-break, explicit endpoint goto and short word-ID parameter were
   byte-neutral but did not fix it; all those diagnostic variants were reverted.
   Original method names/signatures and full SLD remain explicitly unsealed. */
void tScreenPinkSlipsCarSelect::SetDialog()

{
  int player;
  
  /* SYM: `player` is the sole caller local ($s0).  SetPosition reconstructs the
     line-2100 inline tDialogBase receiver and its three retail halfword stores. */
  /* SYM-INLINE-THIS: GetPlayer */
  player = FEApp->GetPlayer();
  this->CarDialog.SetPosition(0, (player == 0) ? -0x3c : 0x3c)
                 ->SetSpecificPlayer((short)player);
  /* MATCH: the Hide+return block is OUT OF LINE -- the oracle's `bnez fExitingScreen`
     branches TO it and it sits physically right after the switch dispatch (`jr v0`),
     i.e. it IS the first case body.  Keeping it inline as the if-body flips the
     branch polarity and costs the `j T; nop` skip pair. */
  if (((PinkSlipsScreenState[0] != CardLoadedFine) && (player == 1)) || (this->fExitingScreen != 0)) {
    goto switchD_8003f3b4_caseD_7;
  }
  if (PinkSlipsScreenState[player] != NoCardInserted) {
    this->fStartCheckTick = 0;
  }
  /* MATCH: CASE BODIES IN ORACLE VA ORDER (wave-10 law).  The jump table is keyed
     by case VALUE, but the BODIES are emitted in source order -- retail lays them
     out CardLoadedFine, NoCardInserted, NotFound(0x2af), Unformatted(0x2b1),
     CardFailed(0x2ad, falls through into the shared TextSys_Word/Display tail),
     then NotEnough/TooMany.  Ghidra's value order costs ~60 diffs of pure block
     motion. */
  switch(PinkSlipsScreenState[player]) {
  case WhoCaresWeBeExiting:
switchD_8003f3b4_caseD_7:
    ((tDialogBase *)&this->CarDialog)->Hide();
    return;
  case CardLoadedFine:
    if ((FEApp->waitingForOtherPlayer[player] != 0) ||
        (PinkSlipsScreenState[1 - player] != CardLoadedFine)) {
      /* P866: both references are the module's SYM WaitingString buffer. */
      sprintf(WaitingString,TextSys_Word(0x2a8),PlayerName(1 - player));
      this->CarDialog.Display(WaitingString);
    }
    else {
      ((tDialogBase *)&this->CarDialog)->Hide();
    }
    this->fStartCheckTick = 0;
    goto SetDlg_cardOkReturn;
  case NoCardInserted:
    if (this->fCardFailed == 0) {
      if (this->fStartCheckTick == 0) {
        this->fStartCheckTick = FE_Ticks();
      }
      this->CarDialog.Display(FE_Ticks() - this->fStartCheckTick <= 799 ?
                              player + 0x2ab : player + 0x2a9);
    }
    else {
      if (this->fStartCheckTick == 0) {
        this->fStartCheckTick = FE_Ticks();
      }
      if (FE_Ticks() - this->fStartCheckTick < 0x385) {
        return;
      }
      this->fStartCheckTick = 0;
      this->fCardFailed = 0;
    }
    break;
  case CardFailedNotFound:
    this->CarDialog.Display(player + 0x2af);
    this->fCardFailed = 1;
    this->fStartCheckTick = 0;
    return;
  case CardFailedUnformatted:
    this->CarDialog.Display(player + 0x2b1);
    this->fCardFailed = 1;
    this->fStartCheckTick = 0;
    return;
  case CardFailed:
    this->CarDialog.Display(player + 0x2ad);
    this->fCardFailed = 1;
    this->fStartCheckTick = 0;
    return;
  case NotEnoughCars:
    this->CarDialog.Display(player + 0x32d);
    this->fStartCheckTick = 0;
    this->fCardFailed = 0;
    return;
  case TooManyCars:
    this->CarDialog.Display(player + 0x32f);
    this->fStartCheckTick = 0;
    this->fCardFailed = 0;
    return;
  case CardCurrentlyLoading:
    this->CarDialog.Display(player + 0x280);
    this->fStartCheckTick = 0;
SetDlg_cardOkReturn:
    this->fCardFailed = 0;
    return;
  default:
    goto switchD_8003f3b4_default;
  }
switchD_8003f3b4_default:
  return;
}



/* ---- tScreenPinkSlipsCarSelect::ProcessInput  [SCREENCARSELECT.CPP:2190-2200] ---- */
void tScreenPinkSlipsCarSelect::ProcessInput(tPlayer,tInputKeyType &keyval,
              tMenuCommand &)

{
  if (keyval != kInput_KeyType_Triangle) {
    if ((keyval != kInput_KeyType_Circle) &&
       ((PinkSlipsScreenState[0] != CardLoadedFine || (PinkSlipsScreenState[1] != CardLoadedFine))))
    {
      keyval = kInput_KeyType_AlreadyProcessed;
    }
    if (keyval != kInput_KeyType_Triangle) {
      return;
    }
  }
  if ((PinkSlipsScreenState[0] != CardLoadedFine) ||
     (PinkSlipsScreenState[1] != CardLoadedFine)) {
    this->fExitingScreen = 1;
    PinkSlipsScreenState[0] = WhoCaresWeBeExiting;
    PinkSlipsScreenState[1] = WhoCaresWeBeExiting;
    ((tDialogBase *)&this->CarDialog)->Hide();
  }
  /* MATCH: NO trailing return.  The oracle stages no return value on either exit
     path -- $v0 is the just-loaded PinkSlipsScreenState[1] on the fall-through and
     Hide's incidental $v0 after the call.  An explicit `return PVar1;` makes gcc
     const-prop PVar1==CardLoadedFine (transitively via the two guards) and emit an
     extra `li v0,6`, which reorg then steals into the beq delay slot the oracle
     leaves a nop.  (`return 0x10;` above still works: it reuses the compare
     constant already in $v0 -- shared-constant-return.) */
}



/* ---- tScreenPinkSlipsCarSelect::GetShapeInfo  [SCREENCARSELECT.CPP:2205-2219] ---- */
void tScreenPinkSlipsCarSelect::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  tCarInfo carInfo;
  
  numPermShapes = 0x34;
  numSwapShapes = 5;
  *(short *)((int)this + 0x11e) = -1;
  *(short *)((int)this + 0x120) = -1;
  *(short *)((int)this + 0x122) = -1;
  carManager.GetStockCar(0,carInfo);
  *permFileName = "zcarsb";
  sprintf(gSwapFileName[0],"%s",carInfo.fSmallName);
  *swapFileName = gSwapFileName[0];
  return;
}



/* (2026-09-20) The hand-transcribed __asm__ destructor(s) that stood here are GONE: with real virtual destructors the
 * compiler emits the out-of-line copies the vtables need, at the same place (the deferred-inline tail). */



/* ---- tScreenCarSelectDuel::dtor  [SCREENCARSELECT.CPP:285-2230] ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___16tScreenCarSelect the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___16tScreenCarSelect(void *);



/* end of screencarselect.cpp */

PinkSlipsCarSelectState PinkSlipsScreenState[2];                 /* @0x80052034 */
tScreenCarSelect *screenCarSelect;                               /* @0x8005203c */
tScreenCarSelectDuel *screenCarSelectDuel;                       /* @0x80052040 */
tScreenCarSelectTwoPlayer *screenCarSelectTwoPlayer;             /* @0x80052044 */
tScreenCarSelectTwoPlayer *screenCarSelectPlayerTwo;             /* @0x80052048 */
tScreenPinkSlipsCarSelect *screenPinkSlipsCarSelectTwoPlayer;    /* @0x8005204c */
tScreenPinkSlipsCarSelect *screenPinkSlipsCarSelectPlayerTwo;    /* @0x80052050 */
