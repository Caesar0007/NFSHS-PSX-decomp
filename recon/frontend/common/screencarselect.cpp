/* frontend/common/screencarselect.cpp -- RECONSTRUCTED (car-select screens; C++ TU)
 *   4 classes (tScreenCarSelect + Duel/TwoPlayer/PinkSlips derived) + free DrawCar; 58 fns.
 *   Bodies from Ghidra; namespaces stripped, phantom stack-args resolved vs disasm.
 */
#include "screencarselect.h"

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

/* SYM-INLINE reconstruction (original identifier/declaration site unavailable):
   DrawSliders and both multiplayer DrawForeground functions contain the same
   nested debug scope: parameters `carStat`, pointer `carInfo`, then local
   `result`, all attributed to one call-site line.  This body reproduces all
   three expansions byte-for-byte; the retail artifacts cannot recover its
   original spelling, so CarStatValue is an explicit semantic name. */
static inline short CarStatValue(tCarStatType carStat, tCarInfo *carInfo)
{
  short result;

  result = (short)carInfo->fStats[0][carStat];
  if ((carInfo->fUpgrades & 1) != 0) {
    result = result + carInfo->fStats[1][carStat];
  }
  if ((carInfo->fUpgrades & 2) != 0) {
    result = result + carInfo->fStats[2][carStat];
  }
  if ((carInfo->fUpgrades & 4) != 0) {
    result = result + carInfo->fStats[3][carStat];
  }
  return result;
}

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
  /* SYM-CODEGEN-CARRIER: signedTicks -- the W63/W66 oracle receipt above
     proves this source conversion supplies retail's signed remainder shape. */
  long signedTicks;
  
  ticks = ::ticks[0];
  signedTicks = (long)ticks;
  ticks = signedTicks % 0x800;
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

  this->_vf = (__vtbl_ptr_type (*)[10])tScreenCarSelect_vtable;
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
  return;
}



/* ---- tScreenCarSelect::dtor  [SCREENCARSELECT.CPP:320-320] ---- */
tScreenCarSelect::~tScreenCarSelect()

{
  this->_vf = (__vtbl_ptr_type (*)[10])tScreenCarSelect_vtable;
  /* base ~tScreen is emitted implicitly (: public tScreen) -- no explicit call */
  return;
}



/* ---- tScreenCarSelect::Cleanup  [SCREENCARSELECT.CPP:324-327] ---- */
void tScreenCarSelect::Cleanup()

{
  /* SYM-CODEGEN-CARRIER: vtbl -- direct this->_vf[1][5] indexing is measured
     byte-identical but violates the manual-ABI vtable safety gate. */
  __vtbl_ptr_type (*vtbl) [10];

  CleanupSpinningCarsMenu();
  this->tScreen::Cleanup();
  vtbl = this->_vf;
  (*vtbl[1][5].pfn)(this->fPermShapes.fFilename + -0x14 + vtbl[1][5].delta);
  return;
}



/* ---- tScreenCarSelect::DrawOverlay  [SCREENCARSELECT.CPP:334-494] ---- */
/* MATCH (2026-08-11, 84 -> PASS, exact 551/551): retail reads the
   menuCarUpgrades item as a full word for the title expression; the shared
   header's narrow field otherwise lets cc1plus fold it to lhu, so the test
   read is volatile and width-explicit.  The description guard compares the
   already-computed `descrItem` with 0xB0 instead of re-reading currentItem;
   that removes the extra lw and reproduces retail's add/compare chain.
   In both upgrade loops a read-only yOffset fence buys the QTY reference that
   places it in $a0, while a named xPos preserves retail's `(40*i + K) + x`
   expression tree and caller-save handout.  The block-scoped tournamentMoney
   pseudo reproduces the final DrawMoney call-setup schedule. */
void tScreenCarSelect::DrawOverlay(tOverlay *overlay)

{
  /* [SYM] 8c decl order: pos, temp, carInfo, fade, i, j, drawFlags, text,
     value, validCar, moneyColor, upgradeTranslate, upgradeIcons */
  RECT pos;
  RECT temp;
  tCarInfo carInfo;
  short fade;
  short i;
  short j;
  tDrawShapeExtended drawFlags;
  short text;
  long value;
  bool validCar;
  int moneyColor;
  short upgradeTranslate [3] = {2, 3, 1};
  short upgradeIcons [3] = {2, 4, 1};
  
  if (overlay == (tOverlay *)0x0) {
    return;
  }
  validCar = (*(bool (*)(...))(*this->_vf)[13].pfn)
               ((char *)this + (*this->_vf)[13].delta,&carInfo);
  if (overlay->direction != 0) {
    fade = overlay->transition + overlay->delta * overlay->direction;
    overlay->transition = fade;
    if (fade < 1) {
      overlay->transition = 0;
    }
    else {
      if (fade < 0x80) goto DrawOvl_transitionPos;
      overlay->transition = 0x80;
    }
    overlay->direction = 0;
  }
DrawOvl_transitionPos:
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
    temp.h = 0x17;
    temp.x = pos.x + 0xf;
    temp.y = pos.y + pos.h + -0x1e;
    temp.w = pos.w + -0x1e;
    if (validCar != 0) {
      FETextRender_MenuTextPositionedJustify((signed char)carInfo.fCarID + 0x121,temp.x + temp.w + -0xc,pos.y + 2,1,textState_Selected,
                 textType_FramedInfo);
    }
    text = overlay->ID == 2 ? 0x8d : overlay->ID == 3 ? 0x8e : 0x8c;
    if (validCar != 0) {
      moneyColor = 0xbebe;
      if (overlay->ID == 2) {
        value = carInfo.fPrices[0];
      }
      else if (overlay->ID == 3) {
        value = carInfo.fPrices
                    [upgradeTranslate[(short)menuDefs->menuCarUpgrades.fCurrentItem]];
      }
      else {
        value = carManager.CalcUsedPrice((ushort)(byte)frontEnd.sellerCar);
      }
    }
    else {
      moneyColor = 0x232323;
      value = 0;
    }
    DrawMoney((int)temp.x + (int)temp.w + -0xc,temp.y + 3,6,value,moneyColor,0x232323);
    FETextRender_MenuTextPositionedJustify(text,temp.x + (temp.w >> 1),
                             temp.y + 3,1,textState_Selected,textType_FramedInfo)
    ;
    {
      /* SYM-CODEGEN-CARRIER: tournamentMoney -- direct fMoney argument is
         measured FAIL6 (551/551), scheduling li a2 after the global load;
         this materialized value preserves retail's li/load/a3 sequence. */
      long tournamentMoney;

      tournamentMoney = tournamentManager.fMoney;
      DrawMoney((int)temp.x + (int)temp.w + -0xc,temp.y + 0xd,9,
                 tournamentMoney,0xbebe,0x232323);
    }
    FETextRender_MenuTextPositionedJustify(0x7b,temp.x + (temp.w >> 1),
                            temp.y + 0xd,1,textState_Selected,textType_FramedInfo);
    DrawShape_NFS4Rectangle(temp);   /* W58-A1: RECT& decl */
    PSXDrawSquare(0,(int)pos.x,(int)pos.y,(int)pos.w,10);
    break;
  case 4:
    for (i = 0; i < 3; i = i + 1) {
      /* SYM-CODEGEN-CARRIER: yOffset -- replacing the materialized value and
         read-only register fence with a call-site ternary in both loops is
         measured FAIL210 (547/551); the fence preserves retail's $a0 handout. */
      int yOffset;
      /* SYM-CODEGEN-CARRIER: flags -- inlining the predicate/0x410 mask in
         both calls is measured FAIL188 with six extra instructions. */
      int flags;
      /* SYM-CODEGEN-CARRIER: xPos -- inlining both `(40*i + K) + pos.x`
         expressions is measured FAIL40 (551/551), changing i/a2/t2 handout. */
      int xPos;

      yOffset = 0;
      if ((carInfo.fUpgrades & upgradeIcons[i]) == 0) {
        yOffset = 0x60;
      }
      /* MATCH W86-D3 2026-09-02: the read-only `yOffset` fence that bought the
         QTY reference for retail's $a0 handout is replaced by a pure-C
         ABSORPTION inflator.  `yOffset & (yOffset | i)` == yOffset for ANY i
         (absorption law) -- a semantic no-op whose operand is runtime-unknown
         to cse, so the AND survives to flow (which counts the extra reference)
         and combine collapses it at ZERO bytes.  Whole-TU gate 59/59, and the
         twin loop below takes the same edit (both together also PASS).
         Measured: either fence removed 74; the absorption against
         `carInfo.fUpgrades` 22; against the OTHER loop's counter `j` 46. */
      yOffset &= (yOffset | i);
      drawFlags.tint[0] = 0xbebe;
      flags = (carInfo.fUpgrades & upgradeIcons[i]) == 0;
      flags |= 0x410;
      xPos = i * 0x28 + 0x21;
      DrawShapeExtended(0x62 + i * 10 + (ticks[0] >> 4) % 10,
                        flags,
                        pos.x + xPos,pos.y + 6,
                        yOffset,1,&drawFlags);
    }
    break;
  case 5:
    if (overlay->transition == 0x80) {
      for (i = 0; i < 3; i = i + 1) {
        int yOffset;
        int flags;
        int xPos;

        yOffset = 0;
        if ((carInfo.fUpgrades & upgradeIcons[i]) == 0) {
          yOffset = 0x60;
        }
        /* MATCH W86-D3 2026-09-02: twin of the fence above -- same pure-C
           absorption inflator, whole-TU gate 59/59. */
        yOffset &= (yOffset | i);
        drawFlags.tint[0] = 0xbebe;
        flags = (carInfo.fUpgrades & upgradeIcons[i]) == 0;
        flags |= 0x410;
        xPos = i * 0x28 + 0x85;
        DrawShapeExtended(0x62 + i * 10 + (ticks[0] >> 4) % 10,
                          flags,
                          pos.x + xPos,pos.y + 6,
                          yOffset,1,&drawFlags);
      }
      temp.y = pos.y + 0x23;
      temp.x = pos.x + 0x1e;
      temp.w = pos.w + -0x3c;
      temp.h = pos.h + -0x4b;
      /* [W85-S5, volatile removed] This argument used to be spelled
         `*(volatile int *)&menuDefs->menuCarUpgrades.fCurrentItem + 0x96`.
         What the volatile bought is the FULL-WORD load retail uses; a plain
         read narrows to `lhu`.  An honest named `int` local holding the field
         reproduces it with no volatile (whole-TU 59/59 PASS).  FALSIFIED:
         a plain `*(int *)&` cast 2; the direct field read 2. */
      {
        int curItem = menuDefs->menuCarUpgrades.fCurrentItem;

        FETextRender_MenuTextPositionedJustify
                  (curItem + 0x96,
                   pos.x + (pos.w >> 1),pos.y + 0x18,2,
                   textState_Hilighted,textType_FramedInfo);
      }
      {
        int descrItem;

        descrItem = (short)menuDefs->menuCarUpgrades.fCurrentItem + 0xaf;
        if ((descrItem == 0xb0) &&
            (((signed char)carInfo.fCarID == 0xc) ||
             ((signed char)carInfo.fCarID == 10))) {
          descrItem = 0x41;
        }
        FETextRender_WordWrap((short)descrItem,temp,textState_Hilighted,textType_PopUpText);
      }
      text = 0xa0;
      if ((carInfo.fUpgrades &
           upgradeIcons[(short)menuDefs->menuCarUpgrades.fCurrentItem]) == 0) {
        text = 0x9e;
        if (gPadinfo.buf[0].ID == '#') {
          text = 0x9f;
        }
      }
      FETextRender_MenuTextPositionedJustify(text,pos.x + pos.w + -0xf,pos.y + pos.h + -0x14,1,textState_Hilighted,
                 textType_FramedInfo);
    }
    if ((0x42 < pos.w) && (0x32 < pos.h)) {
      temp.w = pos.w + -0x1e;
      temp.h = pos.h + -0x19;
      temp.x = pos.x + 0xf;
      temp.y = pos.y + 0x14;
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
  /* MATCH (W57-A2): GOTO-DISPATCH in the oracle's branch polarity.  The nested
     `if (state != 2) { if (state < 3) { if (state != 0) return; } ... }` form makes
     the state==0 test a `bnez s1,<return>` with the compute block as FALL-THROUGH;
     the oracle has `beqz s1,<compute>` + a fall-through `j <return>` (the return is
     the fall-through arm, the compute block is the branch TARGET).  Writing the
     arms as explicit `goto compute;` reproduces it (22 -> 18).  The state==2 arm
     enters one insn LATER than the state==0 arm in the oracle (0x8003B6D8 vs
     0x8003B6DC) purely because reorg put `addiu v0,s1,-5` in the state==0 branch's
     delay slot and jump.c threaded the edge past it -- not a source distinction. */
  if (state == 2) goto compute;
  if (state < 3) {
    if (state == 0) goto compute;
    return;
  }
  if (6 < state) {
    return;
  }
  if (state < 5) {
    return;
  }
compute:
  /* `ticks` is VSync-ISR state, so both volatile reads are semantically real.
     This statement order lets the scheduler batch retail's two loads, then emit
     its fSpeechTicks/fSpeechPlayed/fShowroomTicks stores without the former
     source-only t1/t2 temporaries.  Exact result: PASS 161/161. */
  this->fInShowroom = (uint)(state - 5U < 2);
  gStopCommentaryNow = 1;
  this->fSpeechTicks = *(volatile int *)&ticks[0];
  this->fShowroomTicks = *(volatile int *)&ticks[0];
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
  return;
}



/* ---- tScreenCarSelect::CalcSplinePosition  [SCREENCARSELECT.CPP:583-625] ---- */
void tScreenCarSelect::CalcSplinePosition(int knot1,int knot2,int knot3,int knot4,u_long elapsed,
               int &camY,int &camZ,int &screenX,int &screenY,int &camRot)

{
  /* SYM-CODEGEN-CARRIER: _i -- writing through the output references directly
     is measured FAIL 107 (185/176); this scalar preserves retail allocation. */
  /* [SYM] 8c decl order: T, G, i, Result1, Result2 */
  int T [4];
  int G [4] [4];
  short i;
  int Result1 [4];
  int Result2 [4];
  int _i;
  
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
  _i = Result2[2] >> 1;
  if (_i < 0) {
    _i = _i + 0xffff;
  }
  screenX = _i >> 0x10;
  _i = Result2[3] >> 1;
  if (_i < 0) {
    _i = _i + 0xffff;
  }
  screenY = _i >> 0x10;
  G[0][0] = gKnots[knot1][4] + gRotateOffset[0];
  G[1][0] = gKnots[knot2][4] + gRotateOffset[1];
  G[2][0] = gKnots[knot3][4] + gRotateOffset[2];
  G[3][0] = gKnots[knot4][4] + gRotateOffset[3];
  TransformVector(T,gCatmullRom,Result1);
  TransformVector(Result1,G,Result2);
  _i = Result2[0] >> 1;
  if (_i < 0) {
    _i = _i + 0xffff;
  }
  camRot = _i >> 0x10;
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
  __vtbl_ptr_type (*vtbl) [10];
  tCarInfo carInfo;

  numPermShapes = 0x8e;
  numSwapShapes = 0xb;
  *permFileName = "zcars";
  vtbl = this->_vf;
  if (((*vtbl[1][3].pfn)
           (this->fPermShapes.fFilename + -0x14 + vtbl[1][3].delta,
            &carInfo) ^ 1) != 0) {
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
void tScreenCarSelect::UpdateVideoWall(tCarInfo &carInfo)

{
  /* SYM-CODEGEN-CARRIER: country -- direct fCountry storage is measured FAIL 2
     (52/52) because its relocation/reference identity differs from retail. */
  u_int country;

  if ((((ushort)carInfo.fCarIndex != this->fPreviousCar) ||
      ((int)(signed char)carInfo.fCarID != (int)this->fPreviousCarID)) ||
     ((carInfo.fCarClass == '\a' && (this->fPreviousCountry != (ushort)carInfo.fCountry)))) {
    if (-1 < (signed char)carInfo.fCarID) {
      ::AsyncLoadSwapShapeFile((tScreen *)this,carInfo.fShapeName);
    }
    this->fPreviousCar = (ushort)carInfo.fCarIndex;
    this->fPreviousCarID = (short)(signed char)carInfo.fCarID;
    country = carInfo.fCountry;
    this->fTVsInitialized = 0;
    this->fPreviousCountry = (ushort)country;
    this->SetBrightness(0,0);
    TurnOff(this->fVideoWall);
  }
  return;
}



/* ---- tScreenCarSelect::AllocateAsyncBuffer  [SCREENCARSELECT.CPP:665-666] ---- */
void tScreenCarSelect::AllocateAsyncBuffer()

{
  this->fSwapShapes.fDestFile = Platform_GetDCTBuffer(40000,"VideoWall");
  return;
}



/* ---- tScreenCarSelect::FreeAsyncBuffer  [SCREENCARSELECT.CPP:670-672] ---- */
void tScreenCarSelect::FreeAsyncBuffer()

{
  
  Platform_ResetDCTBuffer();
  this->fSwapShapes.fDestFile = (char *)0x0;
  return;
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
  (menuDefs->itemDamage).fFlags &= 0xfffffffe;
  if (frontEnd.raceType == RaceType_Tournament) {
    (menuDefs->itemDamage).fFlags |= 1;
  }
  this->tScreen::Initialize();
  /* MATCH (W66): retail reloads each virtual-table entry directly from `_vf`;
     keeping a named vtbl temporary changes the load destination from $v0 to
     $v1.  GROUP THE INT TERMS -- `base + (delta + -0x14)` not
     `base + delta + -0x14`.  C's pointer_int_sum rebuilds ptr-first only when the
     added term is ONE int expression; the flat 3-term form leaves gcc an INT sum
     it finishes with `addu a0,a0,s0` where the oracle has `addu a0,s0,a0`
     (this-first). */
  (*(*(this->_vf + 1))[4].pfn)
      (this->fPermShapes.fFilename + ((*(this->_vf + 1))[4].delta + -0x14));
  SetLicensePlate();
  this->fTVsInitialized = 0;
  this->fCameraRotation = 0;
  this->fInShowroom = 0;
  if ((*(*(this->_vf + 1))[3].pfn)
          (this->fPermShapes.fFilename +
               ((*(this->_vf + 1))[3].delta + -0x14),&carInfo) != 0) {
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
  this->fShowroomTicks = *(volatile int *)&ticks[0];
  this->fFadeTicks[0] = this->fFadeTicks[1] =
      *(volatile int *)&ticks[0] + -0x100;
  this->fBrightness[1] = 0;
  this->fBrightness[0] = 0;
  this->fDestBrightness[1] = 0;
  this->fDestBrightness[0] = 0;
  (*(*(this->_vf + 1))[1].pfn)
      (this->fPermShapes.fFilename + ((*(this->_vf + 1))[1].delta + -0x14));
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

    validCar = (*(bool (*)(...))(*this->_vf)[13].pfn)
        ((char *)this + (*this->_vf)[13].delta,&carInfo);
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
      (menuDefs->itemOpponentUpgrades).
      fFlags = (menuDefs->itemOpponentUpgrades).fFlags | 1;
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
  /* MATCH (W57-A2, the 4->0 seal): VOID-TAIL FENCE at the shared exit label.
     Without it reorg's fill_simple_delay_slots reaches the `j gamemode`
     simplejump FIRST and steals the gameMode block's head
     `lui %hi(frontEnd.gameMode)` into the *j's* slot; retail leaves the `j`
     nop'd and the `lui` lands in the preceding `bnez` (fState<2) slot instead.
     A zero-insn `asm("" : : "i"(0))` at THIS label (the bnez's target head) is
     the only placement that flips it -- at the gamemode head it costs a real
     insn (99), before the `goto` / after the guard it is inert. */
  __asm__("" : : "i"(0));
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
  __vtbl_ptr_type (*vtbl) [10];

  vtbl = this->_vf;
  validCar = (*(bool (*)(...))vtbl[1][3].pfn)
                    (this->fPermShapes.fFilename + -0x14 + vtbl[1][3].delta,&carInfo);
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
extern byte D_8011472A, D_80114604, D_80114723, D_80114729;

bool tScreenCarSelect::GetCar(tCarInfo &carInfo)

{
  /* SYM-CODEGEN-CARRIER: color -- retail records no caller locals.  Directly
     assigning the color expression is FAIL 9 at 159/160: it collapses the
     available/color value split and removes retail's intervening nop.  The
     separate color byte keeps the exact $v1/$v0 store pair.  The former
     `count` cache is not required: direct GetNum*Cars comparisons remain PASS. */
  uchar color;

  switch(this->fState) {
  case 0:
  case 5:
    carManager.GetStockCar((ushort)(byte)frontEnd.playerCar[0],carInfo);
    if ((int)(uint)(byte)frontEnd.playerCar[0] < (int)carManager.fNumCars) {
      carInfo.fColor = frontEnd.carColors[0][(signed char)carInfo.fCarID];
    }
    carInfo.fCountry = frontEnd.carCountry[0][(signed char)carInfo.fCarID];
    break;
  case 2:
  case 6:
    carManager.GetStockCar((ushort)(byte)frontEnd.dealerCar,carInfo);
    color = frontEnd.carColors[0][(signed char)carInfo.fCarID];
    carInfo.fAvailable = '\x01';
    carInfo.fColor = color;
    break;
  case 7:
    if (D_8011472A == 1) {
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
    if (carManager.GetNumOwnedCars(0) <= 0 && D_80114604 != 1) {
      return 0;
    }
    if (D_80114604 == 2 && this->fState != 3) {
      if (carManager.GetNumTourneyCars(0) <= 0) {
        return 0;
      }
    }
    carManager.GetStockCar((ushort)(byte)
        ((this->fState == 3) ? D_80114729 : D_80114723),carInfo);
    carInfo.fCountry = frontEnd.carCountry[0][(signed char)carInfo.fCarID];
  }
  carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  return 1;
}



/* ---- tScreenCarSelect::SetBrightness  [SCREENCARSELECT.CPP:943-944] ---- */
void tScreenCarSelect::SetBrightness(short bright,short i)

{
  this->fDestBrightness[i] = bright;
  return;
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
void tScreenCarSelect::DrawBackground()

{
  /* SYM/PASS: the recorded caller local is only carInfo.  Flattened slots
     13/10 and the direct brightness conditional remove valid/vtbl/bright;
     GetPlayer restores the nested tFEApplication receiver. */
  /* SYM-CODEGEN-CARRIER: canUpload -- retail records no caller local here,
     but folding this predicate directly into the if is FAIL7 (75/76): it
     removes retail's boolean materialization/nop and reverses the final branch.
     The identifier is not recoverable; this semantic spelling documents the
     exact source-level allocation carrier. */
  bool canUpload;
  tCarInfo carInfo;

  if ((*(*this->_vf)[13].pfn)
      (this->fPermShapes.fFilename + -0x14 + (*this->_vf)[13].delta,
       &carInfo) != 0) {
    ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
    canUpload = (this->fSwapShapes.fFile != (char *)0x0) &&
                (this->fVideoWall[0].fTransitionDirection != -1) &&
                /* SYM-INLINE-THIS: GetPlayer */
                (gCarObj[FEAppB[0]->GetPlayer()]->async_handle == 0) &&
                (0x80 < ticks[0] - this->fFadeTicks[0]);
    if (canUpload) {
      this->tScreen::UploadSwapShapes(0xb);
      TurnOn(this->fVideoWall);
      if (this->fBrightness[0] == this->fDestBrightness[0]) {
        this->SetBrightness((carInfo.fAvailable != '\0') ? 0x80 : 0x20,0);
      }
    }
  }
  if (this->fScreenFadeVal < 0x80) {
    (*(*this->_vf)[10].pfn)
        (this->fPermShapes.fFilename + -0x14 + (*this->_vf)[10].delta,0);
  }
  return;
}



/* ---- tScreenCarSelect::DrawSliders  [SCREENCARSELECT.CPP:1002-1011] ---- */
void tScreenCarSelect::DrawSliders(tCarInfo &carInfo,short x,short y)

{
  /* MATCH/SYM: the caller's own local is only short j ($s2).  The repeated
     nested `carStat`, pointer `carInfo`, and `result` records belong to the
     inlined CarStatValue body reconstructed above.  Ghidra's
     bVar1/tVar2/value/iVar3/sVar4 were fabricated; the extra
     sign-extended copy of `y` they induced cost an 8th saved reg ($s7).
     Loop is EXIT-IN-THE-MIDDLE (oracle: top test + unconditional `j` back
     edge at .L8003C6B4) -- a `for` rotates it. */
  short j;

  j = 0;
  while (true) {
    if (4 < j) break;
    /* MATCH: the (short) cast must sit on the SUM -- `y + 4` alone makes gcc
       materialize a sign-extended copy of y in its own saved reg (an 8th
       callee-save + 8 bytes of frame); the oracle extends AFTER the add. */
    FETextRender_MenuTextPositioned(textVals[j],x,(short)(y + 4),textState_Unselected,
                                    textType_Default);
    /* SYM-INLINE-LOCAL: carStat = CarStatValue
       SYM-INLINE-LOCAL: carInfo = CarStatValue
       SYM-INLINE-LOCAL: result = CarStatValue */
    DrawSlider(CarStatValue(remap[j],&carInfo),0,0xb,x,y,0x68,3,7,3,
               false,0,0x80,0);
    y = y + 0xf;
    j = j + 1;
  }
  return;
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
void tScreenCarSelect::DrawForeground()

{
  short i;
  tCarInfo carInfo;
  short bShowStats;
  tMenuItem *currentItem;
  /* SYM: validCar (REG BOOL) closes the 8c fn-scope set */
  bool validCar;
  /* SYM-CODEGEN-CARRIER: currentItemValue -- using only the SYM-visible
     `currentItem` is FAIL 11 at 556/557 and collapses retail's `$s0`->$s2
     handoff, rotating the shared -2 mask into the wrong saved register. */
  tMenuItem *currentItemValue;
  /* SYM-CODEGEN-CARRIER: validCarValue -- assigning the virtual-call result
     directly to `validCar` is count-exact FAIL 14 and moves retail's `$v0`
     ->`$s5` handoff ahead of menu-flag initialization. */
  bool validCarValue;
  /* SYM-CODEGEN-CARRIER: overlayDirection -- a direct literal store is
     FAIL 7 at 556/557 and loses retail's loop-invariant `$t0 = 1`. */
  int overlayDirection;
  
  currentItemValue = FEApp->fCurrentMenu[0]->fItemList[FEApp->fCurrentMenu[0]->fCurrentItem];
  validCarValue = (*(bool (*)(...))(*this->_vf)[13].pfn)
                    (this->fPermShapes.fFilename + -0x14 + (*this->_vf)[13].delta,&carInfo);
  /* MATCH W86-D3 2026-09-02: the identity launder that kept `currentItem` and
     `currentItemValue` in two registers (gcc otherwise copy-propagates one into
     the other -- the "old-gcc no-copy-prop" identity, W85-S5) is replaced by a
     pure-C ABSORPTION copy.  `v & (v | q)` == v for ANY q (absorption law), so
     the value is unchanged, but it is a DIFFERENT expression, so cse cannot
     record currentItem == currentItemValue; combine collapses the AND/OR pair
     at ZERO bytes.  Whole-TU gate 59/59; plain removal is 2 (count-exact
     557/557, `bne s0` vs retail `bne s2`).  Also PASS: the OR spelling, the
     same absorption against `FEApp`, and absorbing currentItemValue in place
     before a plain copy. */
  currentItem = (tMenuItem *)((int)currentItemValue & ((int)currentItemValue | (int)menuDefs));
  validCar = validCarValue;
  bShowStats = false;
  (menuDefs->itemOpponentUpgrades).fFlags =
       (menuDefs->itemOpponentUpgrades).
       fFlags | 1;
  if (this->fState == 1) {
    bShowStats = (tMenuItemNFS4LeftRightChoice *)currentItemValue == &menuDefs->itemGarageCar;
    (menuDefs->itemUpgradeCar).fFlags =
         (menuDefs->itemUpgradeCar).fFlags &
         0xfffffffe;
    if (((frontEnd.raceType == RaceType_Tournament) && (frontEnd.tier == '\0')) &&
       (FECheat_IsCheatEnabled(cheat_FinishedTournament) != 0)) {
      (menuDefs->itemOpponentUpgrades).
      fFlags = (menuDefs->itemOpponentUpgrades).fFlags & 0xfffffffe;
    }
    __asm__("" : : "r"(currentItem));
    if ((validCar != 0) && (carInfo.fCarClass < 5)) {
      this->fOverlays[4].direction = 1;
    }
    else {
      (menuDefs->itemUpgradeCar).fFlags =
           (menuDefs->itemUpgradeCar).fFlags
           | 1;
      this->fOverlays[4].direction = -1;
    }
  }
  else if (this->fState == 0) {
    if ((tMenuItemNFS4LeftRightChoice *)currentItemValue == &menuDefs->itemCar) {
      bShowStats = true;
    }
    (menuDefs->itemColor).fFlags &= 0xfffffffe;
    (menuDefs->itemShowcase).fFlags &= 0xfffffffe;
    if (carInfo.fCarClass == '\a') {
      (menuDefs->itemColor).fFlags |= 1;
      (menuDefs->itemShowcase).fFlags |= 1;
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
    (menuDefs->itemSellCar).fFlags =
         (menuDefs->itemSellCar).fFlags &
         0xfffffffe;
    if (validCar != 0) {
      this->fOverlays[4].direction = 1;
    }
    else {
      this->fOverlays[4].direction = -1;
      (menuDefs->itemSellCar).fFlags =
           (menuDefs->itemSellCar).fFlags | 1;
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
        *(signed char *)&carInfo.fCarID = -1;
      }
      (*(*this->_vf)[12].pfn)
                (this->fPermShapes.fFilename + -0x14 + (*this->_vf)[12].delta,&carInfo);
      if (gCarObj[(byte)FEApp->fPlayer]->async_handle != 0) {
        this->SetBrightness(0,0);
        TurnOff(this->fVideoWall);
        this->fFadeTicks[0] = ticks[0];
      }
      this->UpdateBrightness(0);
      if ((u_int)((ushort)this->fState - 5) >= 2) {
        showRoomFlag = 0;
        this->fCameraRotation = this->fCameraRotation + 3;
        DrawCar(carInfo,0x13a,0x54,4.0,-7.5,
                   (char)this->fBrightness[0],true,this->fCameraRotation,kPlayerOne);
        goto DrawFG_afterCarRender;
      }
      {
        int screenX;
        int screenY;
        int camRot;
        int cameraY;
        int cameraZ;
        int textID;
        /* SYM-CODEGEN-CARRIER: textBase -- folding the 996 base into the full
           text ID is count-exact FAIL 2 and associates it with the wrong arm. */
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
        /* MATCH W67: IDA's distinct speech-tick fade live ranges are real.
           The empty early-clobber boundary keeps the subtraction's three
           simultaneous values in retail `$v0`/`$v1`/`$t0` without emitting
           instructions, sealing the former eight-diff residual. */
        /* SYM-CODEGEN-CARRIER: shapeFade -- a direct nested conditional in
           the draw call is FAIL 11 at 558/557 and stores the result via `$v0`.
           Its explicit early-clobber identity keeps retail's `$t0` value web. */
        int shapeFade;
        /* SYM-CODEGEN-CARRIER: shapeTicks -- repeated direct member reads are
           FAIL 12 at 559/557, reload the value, and reshape both fade arms. */
        u_long shapeTicks;
        /* SYM-CODEGEN-CARRIER: fadeBase -- using literal 0x180 directly in
           the explicit branch form is count-exact FAIL 8 and moves the fade
           result from retail `$t0` to `$v0`. */
        int fadeBase;

        screenX = 0;
        screenY = 0;
        camRot = 0;
        cameraY = 0;
        elapsedticks = (ticks[0] - this->fSpeechTicks) + -0x100;
        cameraZ = 0;
        if ((-1 < elapsedticks) && (-1 < (signed char)carInfo.fSpeechCarID)) {
          textBase = (elapsedticks >> 9) % 0x13 + 0x3e4;
          textID = textBase + (signed char)carInfo.fSpeechCarID * 0x13;
          textTicks = elapsedticks - ((elapsedticks >> 9) << 9);
          textColor = kRGBVals[(byte)textDefinitions[TextSys_WordFlags((short)textID)][4]];
          if (textTicks < 0x80) {
            fadeVal = 0x80 - textTicks;
            textColor = CalcFadeVal(textColor,fadeVal);
          }
          else if (0x200 - textTicks < 0x80) {
            fadeVal = textTicks - 0x180;
            textColor = CalcFadeVal(textColor,fadeVal);
          }
          FETextRender_FullTextRGB(TextSys_Word(textID),(short)TextSys_WordX(textID),
                                  (short)TextSys_WordY(textID),textColor,'\0',0);
        }
        drawFlags.tint[0] = 0x551e00;
        drawFlags.custom_shapes = this->fSwapShapes.fShapes;
        shapeTicks = this->fSpeechTicks;
        if (shapeTicks < 0x101) {
          shapeFade = 0x80;
        }
        else {
          if (shapeTicks >= 0x181) {
            shapeFade = 0;
            goto DrawFG_fadeDone;
          }
          fadeBase = 0x180;
          shapeFade = fadeBase - shapeTicks;
          __asm__("" : "+&r"(shapeFade) : "r"(shapeTicks), "r"(fadeBase));
        }
DrawFG_fadeDone:
        DrawShapeExtended(0xA,0x200,0,0,shapeFade,0,&drawFlags);
        elapsedticks = ticks[0] - this->fShowroomTicks;
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
DrawFG_afterCarRender:
      if (((gCarObj[0]->async_handle == 0) && (this->fBrightness[0] == this->fDestBrightness[0])) &&
         ((this->fBrightness[0] == 0 && (0x80 < ticks[0] - this->fFadeTicks[0])))) {
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
  useDefault = (*(*this->_vf)[13].pfn)
      (this->fPermShapes.fFilename + -0x14 + (*this->_vf)[13].delta,
       &carInfo) == 1;
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
  return;
}



/* ---- tScreenCarSelectDuel::FreeAsyncBuffer  [SCREENCARSELECT.CPP:1304-1308] ---- */
void tScreenCarSelectDuel::FreeAsyncBuffer()

{
  
  Platform_ResetDCTBuffer();
  this->fSwapShapes.fDestFile = (char *)0x0;
  (this->fOpponentShapes).fDestFile = (char *)0x0;
  return;
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
  return;
}



/* ---- tScreenCarSelectDuel::Cleanup  [SCREENCARSELECT.CPP:1346-1348] ---- */
void tScreenCarSelectDuel::Cleanup()

{
  
  ::FreeShapes((tScreen *)this,&this->fOpponentShapes);
  this->tScreenCarSelect::Cleanup();
  return;
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
  __vtbl_ptr_type (*vtbl) [10];

  vtbl = this->_vf;
  validCar = (*(bool (*)(...))vtbl[1][3].pfn)
                    (this->fPermShapes.fFilename + -0x14 +
                     vtbl[1][3].delta,&carInfo);
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
  return;
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
  __vtbl_ptr_type (*vtbl) [10];
  tCarInfo carInfo;
  
  numPermShapes = 0x34;
  numSwapShapes = 5;
  vtbl = this->_vf;
  if (((*vtbl[1][3].pfn)
           (this->fPermShapes.fFilename + -0x14 + vtbl[1][3].delta,
            &carInfo) ^ 1) != 0) {
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
  /* SYM-CODEGEN-CARRIER: country -- direct fCountry storage is measured FAIL 2
     (52/52) because its relocation/reference identity differs from retail. */
  u_int country;

  if ((((ushort)carInfo.fCarIndex != this->fPreviousCar) ||
      ((int)(signed char)carInfo.fCarID != (int)this->fPreviousCarID)) ||
     ((carInfo.fCarClass == '\a' &&
      (this->fPreviousCountry != (ushort)carInfo.fCountry)))) {
    if (-1 < (signed char)carInfo.fCarID) {
      ::AsyncLoadSwapShapeFile((tScreen *)this,carInfo.fSmallName);
    }
    this->fPreviousCar = (ushort)carInfo.fCarIndex;
    this->fPreviousCarID = (short)(signed char)carInfo.fCarID;
    country = carInfo.fCountry;
    this->fTVsInitialized = 0;
    this->fPreviousCountry = (ushort)country;
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
/* MATCH: 154 -> 0 diffs.  The SYM local set is authoritative: both cars use
   the single stack tCarInfo, drenv/daprim keep their typed PSY-Q forms, and
   validCar is the vcall BOOL.  The two readiness tests need BOOL destinations
   fed by block-local elapsed expressions; byte temporaries add `andi 255`,
   while direct combined conditions perturb the surrounding allocation.
   Source-only SYM cleanup (2026-08-26) folds the opponent-credit and repeated
   brightness values directly, and canonical flattened vtable slots 16/13/12/10
   remove all three decompiler dispatch aliases while preserving exact retail
   delta calls and passing the safe-index audit. */
void tScreenCarSelectDuel::DrawBackground()

{
  /* [SYM] 8c decl order: r, carInfo, drenv, daprim, temp, validCar */
  RECT r;
  tCarInfo carInfo;
  DRAWENV *drenv;
  DR_AREA *daprim;
  RECT temp;
  bool validCar;
  /* SYM-CODEGEN-CARRIER: p2Ready -- nesting the player-two readiness body
     directly is count-exact FAIL 16 and loses retail's held opponent-shape
     base plus explicit BOOL branch web. */
  BOOL p2Ready;
  /* SYM-CODEGEN-CARRIER: p1Ready -- nesting the player-one readiness body
     directly is FAIL 7 at 413/414 and changes retail's explicit BOOL branch. */
  BOOL p1Ready;
  
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
  p2Ready = false;
  if ((((this->fOpponentShapes).fFile != (char *)0x0) &&
      (this->fVideoWall[1].fTransitionDirection != -1)) &&
     (gCarObj[1]->async_handle == 0)) {
    /* SYM-CODEGEN-CARRIER: elapsed -- folding both block-local elapsed-time
       values into their comparisons is count-exact FAIL 20 and reverses each
       retail load/subtract destination web. */
    int elapsed = ticks[0] - this->fFadeTicks[1];
    p2Ready = 0x80 < elapsed;
  }
  if ((bool)p2Ready) {
    this->tScreen::UploadShapes(this->fOpponentShapes,0,0x41,5,0);
    this->fOpponentTVsInitialized = 0;
    TurnOn(this->fVideoWall + 1);
    if (this->fBrightness[1] == this->fDestBrightness[1]) {
      this->SetBrightness(0x80,1);
    }
  }
  this->fCameraRotation = this->fCameraRotation + 3;
  carInfo.fUpgrades = '\0';
  if ((gCarObj[1]->async_handle != 0) && (0x80 < ticks[0] - this->fFadeTicks[1])) {
    this->SetBrightness(0,1);
    TurnOff(this->fVideoWall + 1);
    this->fFadeTicks[1] = ticks[0];
  }
  this->UpdateBrightness(1);
  showRoomFlag = 0;
  DrawCar(carInfo,0x116,0xb8,1.7,-9.9,(char)this->fBrightness[1],false,
             this->fCameraRotation,kPlayerTwo);
  if (((gCarObj[1]->async_handle == 0) &&
      (this->fBrightness[1] == this->fDestBrightness[1])) &&
     ((this->fBrightness[1] == 0 && (0x80 < ticks[0] - this->fFadeTicks[1])))) {
    this->SetBrightness(0x80,1);
    TurnOn(this->fVideoWall + 1);
  }
  (*(*this->_vf)[16].pfn)
            ((char *)this + (*this->_vf)[16].delta,0x69);
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
  validCar = (*(bool (*)(...))(*this->_vf)[13].pfn)
                  ((char *)this + (*this->_vf)[13].delta,&carInfo);
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
  (*(*this->_vf)[12].pfn)
            ((char *)this + (*this->_vf)[12].delta,
             &carInfo);
  if ((gCarObj[0]->async_handle != 0) && (0x80 < ticks[0] - this->fFadeTicks[0])) {
    this->SetBrightness(0,0);
    TurnOff(this->fVideoWall);
    this->fFadeTicks[0] = ticks[0];
  }
  this->UpdateBrightness(0);
  showRoomFlag = 0;
  DrawCar(carInfo,0x116,0x4f,1.7,-9.9,(char)this->fBrightness[0],false,
             this->fCameraRotation,kPlayerOne);
  if ((((gCarObj[0]->async_handle == 0) &&
       (this->fBrightness[0] == this->fDestBrightness[0])) &&
      (this->fBrightness[0] == 0)) &&
     (0x80 < ticks[0] - this->fFadeTicks[0])) {
    this->SetBrightness((carInfo.fAvailable != '\0') ? 0x80 : 0x20,0);
    TurnOn(this->fVideoWall);
  }
  if (validCar != 0) {
    ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
    p1Ready = false;
    if (((this->fSwapShapes.fFile != (char *)0x0) &&
        (this->fVideoWall[0].fTransitionDirection != -1)) &&
       (gCarObj[0]->async_handle == 0)) {
      int elapsed = ticks[0] - this->fFadeTicks[0];
      p1Ready = 0x80 < elapsed;
    }
    if ((bool)p1Ready) {
      this->tScreen::UploadSwapShapes(5);
      TurnOn(this->fVideoWall);
      if (this->fDestBrightness[0] == this->fBrightness[0]) {
        this->SetBrightness((carInfo.fAvailable != '\0') ? 0x80 : 0x20,0);
      }
    }
  }
  (*(*this->_vf)[10].pfn)
            ((char *)this + (*this->_vf)[10].delta,0)
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
  validCar = (*(bool (*)(...))(*this->_vf)[13].pfn)
                    ((char *)this + (*this->_vf)[13].delta,&carInfo);
  i = 0;
  while (i < 2) {
    j = 0;
    while (j < 5) {
      FETextRender_MenuTextPositionedJustify(text2PVals[j],500,y + 4,1,
          textState_Unselected,textType_ScreenInfo);
      /* SYM-INLINE-LOCAL: carStat = CarStatValue
         SYM-INLINE-LOCAL: carInfo = CarStatValue
         SYM-INLINE-LOCAL: result = CarStatValue */
      DrawSlider((validCar != 0) ? CarStatValue(remap[j],&carInfo) : 0,
                 0,0xb,0x1a1,y,0x49,3,4,3,true,0,0x80,0);
      y = y + 0xf;
      j = j + 1;
    }
    y = 0x96;
    carManager.GetStockCar((ushort)(byte)frontEnd.oppCar,carInfo);
    i = i + 1;
  }
  return;
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
  /* SYM-CODEGEN-CARRIER: player.  Retail omits a caller-local name, but this
     long-lived cache is currently required to preserve its $s0 allocation:
     direct fPlayer repetition is FAIL 67 and repeated GetPlayer calls are
     count-exact FAIL 46.  The accessor spelling itself is not retained by
     SYM; see the shared-type declaration receipt. */
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
  int player;

  player = FEApp->GetPlayer();
  currentplayer = player;
  garageNumber = player;
  if (frontEnd.carListType == '\0') {
    carManager.GetStockCar((ushort)(byte)frontEnd.playerCar[player],carInfo);
    carInfo.fColor = carInfo.fColorOrder
         [frontEnd.carColors[player][(signed char)carInfo.fCarID]];
  }
  else {
    if (carManager.GetNumOwnedCars((short)player) <= 0) {
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
void tScreenCarSelectTwoPlayer::DrawVideoWall(short y)

{
  /* [SYM] 8c decl order: i, validCar, carInfo */
  short i;
  bool validCar;
  tCarInfo carInfo;
  /* SYM-CODEGEN-CARRIER: videoOffset
   * Retail initializes the third SetOffset argument in the FEApp branch delay
   * slot.  A direct ternary is one instruction shorter and measures FAIL 5. */
  int videoOffset;

  validCar = (*(bool (*)(...))(*this->_vf)[13].pfn)
                    (this->fPermShapes.fFilename + -0x14 +
                     (*this->_vf)[13].delta,&carInfo);
  i = 0;
  do {
    DrawShapeExtended(i,0,0,-(int)y,
               (int)this->fScreenFadeVal,0,(tDrawShapeExtended *)0x0);
    i = i + 1;
  } while (i < 0xc);
  if (((this->fSwapShapes.fFlags & 1) != 0) &&
     (this->fTVsInitialized == 0)) {
    videoOffset = 0;
    if (FEAppB[0]->fPlayer != '\0') {
      videoOffset = 0x69;
    }
    this->fVideoWall->SetOffset(6,videoOffset);
    SetAvailableText(this->fVideoWall,0xf8,0x10e,
        (FEAppB[0]->fPlayer != '\0') ? 0x96 : 0x2d);
    UpdateImages(this->fVideoWall);
    this->fTVsInitialized = 1;
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
  /* SYM-CODEGEN-CARRIER: country -- direct fCountry storage is measured FAIL 3
     (52/53); this temporary retains retail's load-delay-slot schedule. */
  u_int country;

  if ((((ushort)carInfo.fCarIndex != this->fPreviousCar) ||
      ((int)(signed char)carInfo.fCarID != (int)this->fPreviousCarID)) ||
     ((carInfo.fCarClass == '\a' &&
      (this->fPreviousCountry != (ushort)carInfo.fCountry)))) {
    if (-1 < (signed char)carInfo.fCarID) {
      ::AsyncLoadSwapShapeFile((tScreen *)this,carInfo.fSmallName);
    }
    this->fPreviousCar = (ushort)carInfo.fCarIndex;
    this->fPreviousCarID = (short)(signed char)carInfo.fCarID;
    country = carInfo.fCountry;
    this->fTVsInitialized = 0;
    this->fPreviousCountry = (ushort)country;
    TurnOff(this->fVideoWall);
    this->SetBrightness(0,0);
  }
  return;
}



/* ---- tScreenCarSelectTwoPlayer::TurnOffVideoWall  [SCREENCARSELECT.CPP:1739-1740] ---- */
void tScreenCarSelectTwoPlayer::TurnOffVideoWall()

{
  TurnOffInstant(this->fVideoWall);
  return;
}



/* ---- tScreenCarSelectTwoPlayer::DrawBackground  [SCREENCARSELECT.CPP:1744-1838] ---- */
/* MATCH: unsized-array asm-label view of FEApp (same device as
   tScreenCarSelectTwoPlayer::DrawForeground below) -- the oracle hoists
   `lui $s2,%hi(FEApp)` once and reuses `lw ..,%lo(FEApp)($s2)` at every
   FEApp-> access across this whole function (3+ uses spanning several
   calls); the plain scalar extern compiles to the unschedulable
   `lw $r,sym` macro and gets rematerialized at each use instead. */
void tScreenCarSelectTwoPlayer::DrawBackground()

{
  /* [SYM] 8c decl order: r, carInfo, carY, drenv, daprim, temp */
  RECT r;
  union {
    tCarInfo carInfo;
    signed char signedCarID;
  }; /* SYM-CARRIER: carInfo (AUTO -248; union alias is codegen-only) */
  short carY;
  DRAWENV *drenv;
  DR_AREA *daprim;
  RECT temp;
  /* SYM-CODEGEN-CARRIER: vtbl -- direct this->_vf[1][slot] indexing is
     byte-identical, but is structurally unsafe for the pointer-to-row type and
     fails the repository vtable-index audit.  This typed dispatch carrier
     preserves the retail delta-call shape without inventing a helper symbol. */
  __vtbl_ptr_type (*vtbl) [10];
  /* SYM-CODEGEN-CARRIER: elapsed -- folding the elapsed-time expression into
     the comparison is count-exact FAIL 10 and reverses the retail
     load/subtract destination web. */
  int elapsed;
  /* SYM-CODEGEN-CARRIER: uploadY -- folding the player-dependent ordinate
     into UploadShapes is count-exact FAIL 6 and moves `li a3,65` relative to
     the receiver setup. */
  short uploadY;
  /* SYM-CODEGEN-CARRIER: uploadReady -- nesting the readiness body directly
     is FAIL 24 at 338/342, losing four retail instructions and the held
     shape-file base. */
  BOOL uploadReady;
  
  carY = 0x4f;
  drenv = (DRAWENV *)Draw_GetDRAWENV(Draw_gPlayer1View,gFlip);
  daprim = (DR_AREA *)Render_gPacketPtr;
  temp.x = 0;
  temp.y = *(short *)((char *)drenv + 2);
  temp.w = 0x200;
  temp.h = (short)screenheight;
  ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)Render_gPalettePtr)->addr;
  Render_gPacketPtr = (u_char *)daprim + 0xc;
  ((tPsyQPrimTag *)Render_gPalettePtr)->addr = (u_int)daprim;
  SetDrawArea(daprim,&temp);
  r.x = 0x122;
  r.y = 0x19;
  if (FEAppB[0]->fPlayer == '\x01') {
    r.y = 0x82;
  }
  r.w = 200;
  r.h = 0xc;
  vtbl = this->_vf;
  if ((*vtbl[1][3].pfn)
                  (vtbl[1][3].delta + -0x14 +
                   this->fPermShapes.fFilename,&carInfo) != 0) {
    r.y = 0x14;
    if (FEAppB[0]->fPlayer == '\x01') {
      carY = 0xb8;
      r.y = 0x80;
    }
    this->fCameraRotation = this->fCameraRotation + 3;
    DrawShape_NFS4RoundRectangle((signed char)carInfo.fCarID + 0x121,r,0);   /* W58-A1: RECT& decl */
    vtbl = this->_vf;
    (*vtbl[1][2].pfn)
              (vtbl[1][2].delta + -0x14 +
               this->fPermShapes.fFilename,&carInfo);
    /* MATCH (w83-a15): NAMING one of the two async_handle reads is a ZERO-INSN
       JUMP-GRAPH dial (catalog 26G-3).  `rtx_equal_for_thread_p' (jump.c:4599)
       refuses the equivalence as soon as REG_USERVAR_P holds on EITHER compared
       pseudo, so with BOTH reads anonymous jump.c THREADS this beqz past the
       second test's re-load: branch word 106 lands +20 where retail is +8.
       Naming exactly ONE side blocks it (naming BOTH re-enables it -- the
       REGNO clause runs first).  Byte-identical with the name on the `== 0'
       test instead (measured: same object, per-symbol md5).
       INVISIBLE to verify_asm (branch targets normalise to `T') and to wordcmp
       (R_MIPS_26 waived) -- tools/brdist.py is the only witness. */
    /* SYM-CODEGEN-CARRIER: loading -- one named async-handle read blocks an
       otherwise incorrect jump-threading equivalence; see the receipt above. */
    int loading = gCarObj[(byte)FEAppB[0]->fPlayer]->async_handle;
    if (loading != 0) {
      this->SetBrightness(0,0);
      this->fFadeTicks[0] = ticks[0];
    }
    if (gCarObj[(byte)FEAppB[0]->fPlayer]->async_handle == 0) {
      if (((this->fBrightness[0] == this->fDestBrightness[0]) &&
           (this->fBrightness[0] == 0)) &&
          (0x80 < ticks[0] - this->fFadeTicks[0])) {
        this->SetBrightness(carInfo.fAvailable != '\0' ? 0x80 : 0x20,0);
        TurnOn(this->fVideoWall);
      }
      /* w83-a15: the w45 void fence that stood here is DELETED, and its receipt
         was a BASIN verdict (catalog 29A0-5 device-masking).  The fence is what
         BLOCKED reorg's `relax_delay_slots'/`redundant_insn' redirect --
         `resource_conflicts_p' (reorg.c:726) short-circuits on res->volatil --
         so retail's four inner branches could never be advanced past the
         redundant `addu a0,s0,zero' at .L8003E718 (branch words 130/132/139/143,
         each ours exactly one instruction short of retail).  With the fence in,
         the `loading' naming above reads as nearly inert (5 -> 3); fence OUT
         alone costs a nop; the PAIR is REAL 0 / brdist 0 / 342 == 342.
         Do not re-add it without re-running tools/brdist.py. */
    }
    this->UpdateBrightness(0);
    showRoomFlag = 0;
    /* SYM-CODEGEN-CARRIER: player -- passing fPlayer directly is count-exact
       FAIL 24 in this arm and count-exact FAIL 20 in the alternate arm; the
       two scoped materializations preserve the retail argument register web. */
    tPlayer player = (tPlayer)(byte)FEAppB[0]->fPlayer;
    DrawCar(carInfo,0x116,carY,1.7,-9.9,(char)this->fBrightness[0],false,
               this->fCameraRotation,player);
  }
  else {
    signedCarID = -1;
    vtbl = this->_vf;
    (*vtbl[1][2].pfn)
              (vtbl[1][2].delta + -0x14 + this->fPermShapes.fFilename,
               &carInfo);
    showRoomFlag = 0;
    tPlayer player = (tPlayer)(byte)FEAppB[0]->fPlayer;
    DrawCar(carInfo,0x116,0x4f,1.7,-9.9,(char)this->fBrightness[0],false,
               this->fCameraRotation,player);
    vtbl = this->_vf;
    (*vtbl[1][6].pfn)
              (vtbl[1][6].delta + -0x14 + this->fPermShapes.fFilename)
    ;
  }
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  uploadReady = false;
  if (((this->fSwapShapes.fFile != (char *)0x0) &&
     (this->fVideoWall[0].fTransitionDirection != -1)) &&
     (gCarObj[(byte)FEAppB[0]->fPlayer]->async_handle == 0)) {
    elapsed = ticks[0] - this->fFadeTicks[0];
    uploadReady = 0x80 < elapsed;
  }
  if (uploadReady) {
    uploadY = 0;
    if (FEAppB[0]->fPlayer == '\x01') {
      uploadY = 0x41;
    }
    this->tScreen::UploadShapes(this->fSwapShapes,0,uploadY,5,0);
    TurnOn(this->fVideoWall);
    if (this->fDestBrightness[0] == this->fBrightness[0]) {
      this->SetBrightness(carInfo.fAvailable != '\0' ? 0x80 : 0x20,0);
    }
  }
  r.y = 0;
  if (FEAppB[0]->fPlayer == '\x01') {
    r.y = 0x69;
  }
  vtbl = this->_vf;
  (*vtbl[1][0].pfn)
            (vtbl[1][0].delta + -0x14 + this->fPermShapes.fFilename,
             r.y);
  vtbl = this->_vf;
  (*vtbl[1][7].pfn)
            (vtbl[1][7].delta + -0x14 + this->fPermShapes.fFilename);
  temp.x = 0;
  temp.y = *(short *)((char *)drenv + 2);
  temp.w = 0x200;
  temp.h = (short)(screenheight / 2);
  if (FEAppB[0]->fPlayer == '\x01') {
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
  /* MATCH: caller locals verbatim from the SYM 8c block (fsize 296,
       mask $807f0000):
       AUTO tCarInfo carInfo (@sp+0x38)   REG short j($s2), short yOffset($s1),
       BOOL gotcar($s4).  Ghidra's auStack_f0/abStack_c0/bb/b6/b1/loc_2c were
       byte-slices of that ONE tCarInfo -- keeping them apart cost the shared
       `addu $a1,$s3,$v0` stat base.  Loop is exit-in-the-middle like
       tScreenCarSelect::DrawSliders, and the (short) cast sits on `yOffset + 4`.
       The nested carStat/pointer-carInfo/result records at 0x8003EB60 are the
       byte-exact inline CarStatValue expansion, not extra caller locals. */
  tCarInfo carInfo;
  short j;
  short yOffset;
  bool gotcar;   /* SYM BOOL is native C++ bool; the oracle copies the normalized `$v0`. */

  yOffset = 0x2d;
  if (FEAppA[0]->fPlayer == '\x01') {
    yOffset = 0x96;
  }
  gotcar = (*(bool (*)(...))(*(code **)(*(int *)((int)this + 0x60) + 0x6c)))
                     ((int)this + *(short *)(*(int *)((int)this + 0x60) + 0x68),&carInfo);
  if (FEAppA[0]->fPlayer == '\0') {
    (menuDefs->itemColorP1).fFlags =
         (menuDefs->itemColorP1).fFlags & 0xfffffffe;
    if ((gotcar == 0) || (carInfo.fCarClass == '\a')) {
      (menuDefs->itemColorP1).fFlags =
           (menuDefs->itemColorP1).fFlags | 1;
    }
  }
  else {
    (menuDefs->itemColorP2).fFlags =
         (menuDefs->itemColorP2).fFlags & 0xfffffffe;
    if ((gotcar == 0) || (carInfo.fCarClass == '\a')) {
      (menuDefs->itemColorP2).fFlags =
           (menuDefs->itemColorP2).fFlags | 1;
    }
  }
  j = 0;
  while (true) {
    if (4 < j) break;
    FETextRender_MenuTextPositionedJustify(text2PVals[j],500,(short)(yOffset + 4),1,
                                           textState_Unselected,textType_Default);
    /* SYM-INLINE-LOCAL: carStat = CarStatValue
       SYM-INLINE-LOCAL: carInfo = CarStatValue
       SYM-INLINE-LOCAL: result = CarStatValue
       The conditional call keeps result in retail/SYM $v1, the upgrades byte
       in $a0, and materializes the invalid-car zero directly as DrawSlider's
       first argument.  Exact result: PASS 143/143. */
    DrawSlider((gotcar != 0) ? CarStatValue(remap[j],&carInfo) : 0,
               0,0xb,0x1a1,yOffset,0x49,3,4,3,
               true,0,0x80,0);
    yOffset = yOffset + 0xf;
    j = j + 1;
  }
  return;
}



/* ---- tScreenCarSelectTwoPlayer::SetDialog  [SCREENCARSELECT.CPP:1881-1892] ---- */
void tScreenCarSelectTwoPlayer::SetDialog()

{
  /* SYM/PASS (2026-08-25): retail lists only `int player` ($s0).  Its SLD
     records inline tFEApplication::this at entry and inline tDialogBase::this
     at 0x8003EC9C, exactly where OffsetX, OffsetY, and specificPlayer are
     written.  Reconstructing that inline member removes the former SYM-extra
     `y_off` and `dlg` locals.  The member's returned `this` carries the dialog
     subobject through sprintf and the string store, allowing GCC to advance
     outer `this` from $s1 to CarDialog in place as retail does.  The duplicated
     FEApp read remains load-bearing: CSE turns it into the retail
     `addu $s0,$a0,$zero` in the guard delay slot.  Exact result: PASS 48/48.
     The debug data proves the inline member's type/body but does not encode its
     original identifier; SetPosition is the explicit semantic reconstruction. */
  int player = FEApp->fPlayer;

  if (FEApp->waitingForOtherPlayer[player] != 0) {
    player = FEApp->fPlayer;
    ((tDialogBackUpOnly *)this->CarDialog.SetPosition(
        0, (player == 0) ? -0x3c : 0x3c, (tPlayer)player))->string =
      (sprintf("",TextSys_Word(0x2a8),PlayerName(1 - player)), "");
    this->CarDialog.Display();
  }
  else {
    this->CarDialog.Hide();
  }
  return;
}



/* ---- tScreenCarSelectTwoPlayer::AllocateAsyncBuffer  [SCREENCARSELECT.CPP:1896-1897] ---- */
void tScreenCarSelectTwoPlayer::AllocateAsyncBuffer()

{
  this->fSwapShapes.fDestFile = Platform_GetDCTBuffer(16000,"VideoWall");
  return;
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
  return;
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
  /* SYM-INLINE-THIS: GetPlayer */
  if (PinkSlipsScreenState[0] != CardLoadedFine) {
    return 0;
  }
  if (PinkSlipsScreenState[1] != CardLoadedFine) {
    return 0;
  }
  carManager.GetPinkSlipsCar
       ((ushort)(byte)frontEnd.pinkSlipsCar[FEApp->GetPlayer()],carInfo,
        (ushort)FEApp->GetPlayer());
  carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  return 1;
}



/* ---- tScreenPinkSlipsCarSelect::DrawBackground  [SCREENCARSELECT.CPP:1949-1954] ---- */
void tScreenPinkSlipsCarSelect::DrawBackground()

{
  
  this->DoMemCardStuff();
  this->tScreenCarSelectTwoPlayer::DrawBackground();
  if (this->fExitingScreen != 0) {
    ((tDialogBase *)&this->CarDialog)->Hide();
  }
  return;
}



/* ---- tScreenPinkSlipsCarSelect::DoMemCardStuff  [SCREENCARSELECT.CPP:1958-2061] ---- */
/* MATCH: 83 -> 0 diffs.  The SYM budget has only player/card plus the scoped
   load result; removing the decompiler's duplicate player/card identities
   restores $s3/$s1.  CURRENTLYUSINGMEMCARD is a 32-bit BOOL (`lw`, not `lbu`).
   The explicit xor-ready edge preserves retail's dialog branch and the named
   PinkSlipsScreenState store lets sched2 fill the first Redraw delay slot.
   Separate result pointer/value temporaries reproduce the shared outcome store;
   the default arm's block-local base pointer fixes its %hi/%lo/index order. */
void tScreenPinkSlipsCarSelect::DoMemCardStuff()

{
  /* Reliable SYM does not name these optimized-away source identities:
     SYM-CODEGEN-CARRIER: cardInfo
     SYM-CODEGEN-CARRIER: resultState
     SYM-CODEGEN-CARRIER: resultStatePtr
     SYM-CODEGEN-CARRIER: pinkState
     SYM-CODEGEN-CARRIER: stateBase */
  /* [SYM] 8c decl order at fn scope: player, card (`ret` is block-scoped
     to the load arm opened at SLD 39). */
  int player;
  int card;
  CARDINFO_def *cardInfo;
  PinkSlipsCarSelectState resultState;
  PinkSlipsCarSelectState *resultStatePtr;
  PinkSlipsCarSelectState *pinkState;
  
  /* SYM-INLINE-THIS: GetPlayer */
  player = FEApp->GetPlayer();
  card = 1;
  if (player != kPlayerOne) {
    card = 5;
  }
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
  pinkState = PinkSlipsScreenState + player;
  if (*pinkState == CardLoadedFine) {
    return;
  }
  if ((this->CarDialog.fFullyOpen ^ 1) == 0) {
    goto DoMC_dialogReady;
  }
  this->waitfordialog = 0;
  return;
DoMC_dialogReady:
  if (this->waitfordialog < 5) {
    this->waitfordialog = this->waitfordialog + 1;
    return;
  }
  if (*pinkState != CardCurrentlyLoading) {
    MCRD_handlecardevents(card);
    cardInfo = MCRD_getcard(card);
    this->pCI = cardInfo;
    if (cardInfo->status == -1) {
      *pinkState = NoCardInserted;
    }
    else if ((CURRENTLYUSINGMEMCARD == 0) && (*pinkState == NoCardInserted)) {
      int ret;   /* [SYM] REG $v1, block opened at SLD 39 */

      PinkSlipsScreenState[player] = CardCurrentlyLoading;
      FEApp->Redraw();
      FEApp->Redraw();
      ret = LoadGame((ushort)player,true,0);
      if (ret == 0) {
        carManager.GetNumPinkSlipsCars((ushort)player);
        carManager.CheapestCarStockPrice();
        if (carManager.GetNumPinkSlipsCars((ushort)player) == 0x20) {
          *pinkState = TooManyCars;
          goto DoMC_pinkSlipsIter;
        }
        if ((1 < carManager.GetNumPinkSlipsCars((ushort)player)) ||
           ((carManager.GetNumPinkSlipsCars((ushort)player) == 1) &&
            (frontEnd.pinkSlipsCash[player] >= carManager.CheapestCarStockPrice()))) {
          resultStatePtr = PinkSlipsScreenState + player;
          resultState = CardLoadedFine;
        }
        else {
          resultStatePtr = PinkSlipsScreenState + player;
          resultState = NotEnoughCars;
        }
      }
      else {
        switch (ret) {
        case 1:
          *pinkState = CardFailed;
          goto DoMC_pinkSlipsIter;
        case 2:
          *pinkState = CardFailedUnformatted;
          goto DoMC_pinkSlipsIter;
        default: {
          PinkSlipsCarSelectState *stateBase;

          stateBase = PinkSlipsScreenState;
          resultStatePtr = stateBase + player;
          resultState = CardFailedNotFound;
          break;
        }
        }
      }
      *resultStatePtr = resultState;
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
  return;
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
  return;
}



/* ---- tScreenPinkSlipsCarSelect::SetDialog  [SCREENCARSELECT.CPP:2098-2187] ---- */
/* MATCH W63/P92 PASS (37 -> 0, 164/164 instructions).  The raw CFG/SLD puts the
   CardLoadedFine message arm first and branches to the ready-player Hide arm;
   it also places the shared card-failure tail before the three loading cases.
   Retail SYM records one caller local, `player` in $s0; the repeated dialog
   aliases below represent its inline tDialogMessageString `this` scopes. */
void tScreenPinkSlipsCarSelect::SetDialog()

{
  /* [SYM] `player` (REG $s0) is the fn's sole 8c record; the carrier follows. */
  int player;
  /* SYM-CODEGEN-CARRIER: wordnum -- retail lists no durable caller local for
     this selector.  Each definition feeds TextSys_Word in $a0 and dies there;
     duplicated selector-free arms are count-exact FAIL 2 (the final store uses
     $s0 instead of retail $a0).  Reusing one selector across the disjoint card
     and loading funnels is PASS and does not join their RTL lifetimes.  Neither
     SYM nor the binary can distinguish this optimized local from a macro temp. */
  int wordnum;
  
  /* SYM: `player` is the sole caller local ($s0).  SetPosition reconstructs the
     line-2100 inline tDialogBase receiver and its three retail halfword stores. */
  /* SYM-INLINE-THIS: GetPlayer */
  player = FEApp->GetPlayer();
  this->CarDialog.SetPosition(0, (player == 0) ? -0x3c : 0x3c,
                              (tPlayer)player);
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
      sprintf("",TextSys_Word(0x2a8),PlayerName(1 - player));
      {
        /* SYM-CODEGEN-CARRIER: dlg -- preserves the inline receiver allocation. */
        tDialogBackUpOnly *dlg = &this->CarDialog;
        dlg->SetString("")->tDialogBase::Display();
      }
      this->fStartCheckTick = 0;
      goto SetDlg_cardOkReturn;
    }
    ((tDialogBase *)&this->CarDialog)->Hide();
    this->fStartCheckTick = 0;
    goto SetDlg_cardOkReturn;
  case NoCardInserted:
    if (this->fCardFailed == 0) {
      if (this->fStartCheckTick == 0) {
        this->fStartCheckTick = ticks[0];
      }
      wordnum = player + 0x2ab;
      if (799 < ticks[0] - this->fStartCheckTick) {
        wordnum = player + 0x2a9;
      }
      {
        /* SYM-CODEGEN-CARRIER: dlg -- the inline receiver must be born before
           TextSys_Word to occupy retail $s0 and fill the call delay slot. */
        tDialogBackUpOnly *dlg = &this->CarDialog;
        dlg->SetString(TextSys_Word(wordnum))->tDialogBase::Display();
      }
      return;
    }
    if (this->fStartCheckTick == 0) {
      this->fStartCheckTick = ticks[0];
    }
    if (ticks[0] - this->fStartCheckTick < 0x385) {
      return;
    }
    this->fStartCheckTick = 0;
    goto SetDlg_cardOkReturn;
  case CardFailedNotFound:
    wordnum = player + 0x2af;
    goto SetDlg_cardFailed;
  case CardFailedUnformatted:
    wordnum = player + 0x2b1;
    goto SetDlg_cardFailed;
  case CardFailed:
    wordnum = player + 0x2ad;
SetDlg_cardFailed:
    {
      /* SYM-CODEGEN-CARRIER: dlg -- preserves the inline receiver allocation. */
      tDialogBackUpOnly *dlg = &this->CarDialog;
      dlg->SetString(TextSys_Word(wordnum))->tDialogBase::Display();
    }
    this->fCardFailed = 1;
    this->fStartCheckTick = 0;
    return;
  case NotEnoughCars:
    wordnum = player + 0x32d;
    goto SetDlg_loadingWord;
  case TooManyCars:
    wordnum = player + 0x32f;
    goto SetDlg_loadingWord;
  case CardCurrentlyLoading:
    wordnum = player + 0x280;
SetDlg_loadingWord:
    {
      /* The shared selector remains block-local in RTL across this funnel. */
      tDialogBackUpOnly *dlg = &this->CarDialog;
      dlg->SetString(TextSys_Word(wordnum))->tDialogBase::Display();
    }
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



/* ---- ___25tScreenPinkSlipsCarSelect / ___25tScreenCarSelectTwoPlayer
 * MATCH 2026-07-11 (dtor-surgery): both tScreenPinkSlipsCarSelect::~tScreenPinkSlipsCarSelect()
 * and tScreenCarSelectTwoPlayer::~tScreenCarSelectTwoPlayer() are now declared INLINE-in-class
 * (nfs4_types.h) with empty bodies -- see the tScreenControllerConfig dtor comment in
 * screencontroller.cpp for the full rationale (gcc-2.8/CC1PLPSX fully expands an inline dtor at
 * every implicit member/base-teardown call site; this reproduces tAllScreens::~tAllScreens(),
 * which the oracle shows INLINING both classes' teardown directly).
 *
 * PinkSlipsCarSelect has NO extra members of its own (CarDialog is INHERITED from
 * tScreenCarSelectTwoPlayer, not redeclared) -- so once tScreenCarSelectTwoPlayer is ALSO
 * inline, PinkSlipsCarSelect's auto-teardown of its base RECURSIVELY expands straight through it
 * to CarDialog (offset 0x3A0, same in both classes since single inheritance sits at +0x0) plus
 * the tScreenCarSelect base -- matching the oracle exactly. The old explicit
 * `tScreen_dtor(&this->CarDialog, 2)` manual call is DELETED (it was made redundant/wrong the
 * moment the base become inline-recursive too; keeping it would double-destroy CarDialog).
 *
 * Both classes' standalone out-of-line destructor symbols (___25tScreenCarSelectTwoPlayer,
 * ___25tScreenPinkSlipsCarSelect) still genuinely exist in retail (their own vtable dtor slots
 * need a real address) and are IDENTICAL in body (CarDialog @0x3A0 -> ___7tScreen, then base
 * -> ___16tScreenCarSelect forwarding in_chrg) -- transcribed verbatim, same technique/rationale
 * as ___23tScreenControllerConfig. Byte-identical to the prior compiler-generated PASS.
 *
 * W60-A10 (intra-TU VA ORDER, the MSC02 class): the two blobs are byte-identical, so only their
 * LABELS were swapped -- retail emits ___25tScreenPinkSlipsCarSelect (@0x8003f6d0) BEFORE
 * ___25tScreenCarSelectTwoPlayer (@0x8003f714). Wrong order here is invisible to verify_asm
 * (per-fn, VA-agnostic) but link-visible: it hands both symbols the wrong VAs. The two
 * `&this->CarDialog` / delay-slot comments below stayed with their original blob positions. */
#if defined(__mips__)
__asm__(
    "\t.set noat\n"
    "\t.set\tnoreorder\n"
    "\t.set noreorder\n"
    "\t.globl ___25tScreenPinkSlipsCarSelect\n"
    "___25tScreenPinkSlipsCarSelect:\n"
    "\taddiu $29, $29, -32\n"
    "\tsw    $16, 16($29)\n"
    "\taddu  $16, $4, $0\n"
    "\tsw    $17, 20($29)\n"
    "\taddu  $17, $5, $0\n"
    "\taddiu $4, $16, 928\n"      /* &this->CarDialog (+0x3A0) */
    "\tsw    $31, 24($29)\n"
    "\tjal   ___7tScreen\n"
    "\t addiu $5, $0, 2\n"      /* delay slot: member sub-object, not in charge */
    "\taddu  $4, $16, $0\n"
    "\tjal   ___16tScreenCarSelect\n"   /* base (past tScreenCarSelect) */
    "\t addu  $5, $17, $0\n"    /* delay slot: forward the original in_chrg */
    "\tlw    $31, 24($29)\n"
    "\tlw    $17, 20($29)\n"
    "\tlw    $16, 16($29)\n"
    "\tjr    $31\n"
    "\t addiu $29, $29, 32\n"
    "\t.set at\n\t.set reorder\n"
    "\t.set\treorder\n"  /* maspsx tracks .set linearly (no push/pop): restore nop-insertion for the rest of the file (gcc2.8 HOISTS toplevel asm above all fns) */

    "\t.set noat\n"
    "\t.set\tnoreorder\n"
    "\t.set noreorder\n"
    "\t.globl ___25tScreenCarSelectTwoPlayer\n"
    "___25tScreenCarSelectTwoPlayer:\n"
    "\taddiu $29, $29, -32\n"
    "\tsw    $16, 16($29)\n"
    "\taddu  $16, $4, $0\n"
    "\tsw    $17, 20($29)\n"
    "\taddu  $17, $5, $0\n"
    "\taddiu $4, $16, 928\n"      /* &this->CarDialog (inherited, +0x3A0) */
    "\tsw    $31, 24($29)\n"
    "\tjal   ___7tScreen\n"
    "\t addiu $5, $0, 2\n"      /* delay slot */
    "\taddu  $4, $16, $0\n"
    "\tjal   ___16tScreenCarSelect\n"
    "\t addu  $5, $17, $0\n"    /* delay slot: forward the original in_chrg */
    "\tlw    $31, 24($29)\n"
    "\tlw    $17, 20($29)\n"
    "\tlw    $16, 16($29)\n"
    "\tjr    $31\n"
    "\t addiu $29, $29, 32\n"
    "\t.set at\n\t.set reorder\n"
    "\t.set\treorder\n"  /* maspsx tracks .set linearly (no push/pop): restore nop-insertion for the rest of the file (gcc2.8 HOISTS toplevel asm above all fns) */);
#endif



/* ---- tScreenCarSelectDuel::dtor  [SCREENCARSELECT.CPP:285-2230] ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___16tScreenCarSelect the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___16tScreenCarSelect(void *);
extern "C" void ___20tScreenCarSelectDuel(void *thisp) { ___16tScreenCarSelect(thisp); }



/* end of screencarselect.cpp */

PinkSlipsCarSelectState PinkSlipsScreenState[2];                 /* @0x80052034 */
tScreenCarSelect *screenCarSelect;                               /* @0x8005203c */
tScreenCarSelectDuel *screenCarSelectDuel;                       /* @0x80052040 */
tScreenCarSelectTwoPlayer *screenCarSelectTwoPlayer;             /* @0x80052044 */
tScreenCarSelectTwoPlayer *screenCarSelectPlayerTwo;             /* @0x80052048 */
tScreenPinkSlipsCarSelect *screenPinkSlipsCarSelectTwoPlayer;    /* @0x8005204c */
tScreenPinkSlipsCarSelect *screenPinkSlipsCarSelectPlayerTwo;    /* @0x80052050 */
