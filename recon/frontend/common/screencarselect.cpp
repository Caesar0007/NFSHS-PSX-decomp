/* frontend/common/screencarselect.cpp -- RECONSTRUCTED (car-select screens; C++ TU)
 *   4 classes (tScreenCarSelect + Duel/TwoPlayer/PinkSlips derived) + free DrawCar__FR8tCarInfossffcbUl7tPlayer; 58 fns.
 *   Bodies from Ghidra; namespaces stripped, phantom stack-args resolved vs disasm.
 */
#include "screencarselect.h"

extern tFEApplication *FEAppB[] asm("FEApp");

typedef struct tPsyQPrimTag {
  unsigned int addr : 24;
  unsigned int len : 8;
} tPsyQPrimTag;


/* ---- (static)::TransformVector  [SCREENCARSELECT.CPP:51-59] ---- */
/* File-static 4x4 fixed-point matrix * 4-vector (ScreenCarSelect.obj 1st fn @0x8003a8f0). Mangled R =
   refs (= ptr at ABI; call sites pass &T/&gCatmullRom/&Result) -> ptr form. SYM REG I=$s3, J=$s0. */
extern "C" void TransformVector(int (*vect)[4],int (*transform)[4][4],int (*result)[4])

{
  int prod;
  short I;
  short J;

  for (I = 0; I < 4; I = I + 1) {
    (*result)[I] = 0;
    for (J = 0; J < 4; J = J + 1) {
      prod = fixedmult((*vect)[J],(*transform)[J][I]);
      (*result)[I] = (*result)[I] + prod;
    }
  }
  return;
}

/* ---- (free)::DrawCar__FR8tCarInfossffcbUl7tPlayer  [SCREENCARSELECT.CPP:180-212] ---- */

/* Decoded Phase 84: DrawCar__FR8tCarInfossffcbUl7tPlayer(tCarInfo&, short, short, float, float, char, bool, u_long, tPlayer) -
   render car in 3D (428 B, 7 callers - hot). When tcarinfo->fCarID >= 0: applies fColor /
   carType=fSimNumber / Country=fCountry to (*ppCVar3)->carInfo. Used in showroom + dealer screens.
   
   [ghidra-meta] section: front.text */

extern "C" void DrawCar__FR8tCarInfossffcbUl7tPlayer(tCarInfo *carInfo,short x,short y,float camerax,float cameray,char brightness,
               bool reflection,u_long rotate,tPlayer player)

{
  byte bVar1;
  int iVar2;
  u_long ticks;
  char *carBytes = (char*)carInfo;
  int the_simcarcolor;
  Car_tObj **ppCVar3;
  
  iVar2 = ::ticks[0];
  if (::ticks[0] < 0) {
    iVar2 = ::ticks[0] + 0x7ff;
  }
  DrawC_gMenuLights = 0;
  DrawC_gMenuLightsDirection = (int)(0x3ff < (uint)(::ticks[0] + (iVar2 >> 0xb) * -0x800));
  /* W55-A2 BUGFIX (class-1, unsigned-char deleted guard): plain `char` is UNSIGNED on this
     build, so `-1 < *carBytes` folded to constant TRUE and gcc DELETED the whole guard --
     an EMPTY car slot (fCarID == -1) would still be drawn.  Oracle 8003AA58/8003AA60 has
     `lb $v0,0($t0); bltz $v0,.L8003AB5C`; force the signed load per-use. */
  if (-1 < *(signed char *)carBytes) {
    ppCVar3 = gCarObj + player;
    bVar1 = carBytes[0xc5];
    (*ppCVar3)->carInfo->carType = (uint)(byte)carBytes[1];
    (*ppCVar3)->carInfo->Country = (uint)(byte)carBytes[199];
    gMenuRotate[player] = gMenuRotate[player] + 3;
    (*ppCVar3)->carInfo->EngineMods = (byte)carBytes[0xc4] >> 2 & 1;
    (*ppCVar3)->carInfo->WeightTransfer = (byte)carBytes[0xc4] >> 1 & 1;
    (*ppCVar3)->carInfo->GroundEffects = (byte)carBytes[0xc4] & 1;
    DrawC_MenuColorData((uint)bVar1,*ppCVar3,player);
    Draw_MenuRenderingView(*ppCVar3,&gCView,(int)x,(int)y,player,0,rotate,camerax,cameray,(uint)(byte)brightness
               ,reflection);
  }
  return;
}



/* ---- tScreenCarSelect::ctor  [SCREENCARSELECT.CPP:294-316] ---- */
/* MATCH 2026-07-11: base ctor now the IMPLICIT call to tScreen::tScreen() (declared in
   nfs4_types.h) -- deleted the manual tScreen_ctor(...) free-fn call (phantom-ctor pattern,
   catalog wave-3 row 1); g++ auto-emits `jal __7tScreen` at entry, matching oracle exactly.
   The fOverlays[i].location[0..1] init was Ghidra-decompiled as byte-packed bitfield-merge
   arithmetic (gOverlayPositions mistyped char[1][112] in the header); the oracle disasm is
   actually a plain UNALIGNED RECT[2] struct copy (lwl/lwr+swl/swr pairs, 2 words per RECT) --
   RECT's natural alignment is 2 (all-short members) so gcc emits the unaligned-word copy
   idiom for the struct assignment (catalog §D "plain C struct assignment" row). Reinterpret
   gOverlayPositions locally as RECT(*)[2] (16-byte stride = 2 RECTs) to reproduce it. */
tScreenCarSelect::tScreenCarSelect()

{
  short i;
  RECT (*srcPos)[2];
  tOverlay *overlay;

  this->_vf = (__vtbl_ptr_type (*)[10])tScreenCarSelect_vtable;
  this->fPreviousCar = 0;
  this->fPreviousCarID = -1;
  this->fPreviousCountry = 0;
  i = 0;
  srcPos = (RECT (*)[2])gOverlayPositions;
  for (; i < 7; i = i + 1) {
    overlay = this->fOverlays + i;
    overlay->location[0] = srcPos[i][0];
    overlay->location[1] = srcPos[i][1];
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
  __vtbl_ptr_type (*vtbl) [10];
  
  CleanupSpinningCarsMenu();
  this->Cleanup();
  vtbl = this->_vf;
  (*vtbl[1][5].pfn)(this->fPermShapes.fFilename + -0x14 + vtbl[1][5].delta);
  return;
}



/* ---- tScreenCarSelect::DrawOverlay  [SCREENCARSELECT.CPP:334-494] ---- */
void tScreenCarSelect::DrawOverlay(tOverlay *overlay)

{
  __vtbl_ptr_type (*vtbl) [10];
  long value;
  short text;
  int moneyColor;
  int validCar;
  short i;
  short j;
  short fade;
  RECT pos;
  RECT temp;
  tCarInfo carInfo;
  tDrawShapeExtended drawFlags;
  short upgradeTranslate [3] = {2, 3, 1};
  short upgradeIcons [3] = {2, 4, 1};
  
  if (overlay == (tOverlay *)0x0) {
    return;
  }
  vtbl = this->_vf;
  validCar = (*vtbl[1][3].pfn)
               ((char *)this + vtbl[1][3].delta,&carInfo);
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
      DrawShape_NFS4RoundRectangle((signed char)carInfo.fCarID + 0x121,&pos,0);
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
        value = CalcUsedPrice(&carManager,(ushort)(byte)frontEnd.sellerCar);
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
    DrawMoney((int)temp.x + (int)temp.w + -0xc,temp.y + 0xd,9,tournamentManager.fMoney,0xbebe,
               0x232323);
    FETextRender_MenuTextPositionedJustify(0x7b,temp.x + (temp.w >> 1),
                            temp.y + 0xd,1,textState_Selected,textType_FramedInfo);
    DrawShape_NFS4Rectangle(&temp);
    PSXDrawSquare(0,(int)pos.x,(int)pos.y,(int)pos.w,10);
    break;
  case 4:
    for (i = 0; i < 3; i = i + 1) {
      int yOffset;
      int flags;

      yOffset = 0;
      if ((carInfo.fUpgrades & upgradeIcons[i]) == 0) {
        yOffset = 0x60;
      }
      drawFlags.tint[0] = 0xbebe;
      flags = (carInfo.fUpgrades & upgradeIcons[i]) == 0;
      flags |= 0x410;
      DrawShapeExtended(0x62 + i * 10 + (ticks[0] >> 4) % 10,
                        flags,
                        pos.x + i * 0x28 + 0x21,pos.y + 6,
                        yOffset,1,&drawFlags);
    }
    break;
  case 5:
    if (overlay->transition == 0x80) {
      for (i = 0; i < 3; i = i + 1) {
        int yOffset;
        int flags;

        yOffset = 0;
        if ((carInfo.fUpgrades & upgradeIcons[i]) == 0) {
          yOffset = 0x60;
        }
        drawFlags.tint[0] = 0xbebe;
        flags = (carInfo.fUpgrades & upgradeIcons[i]) == 0;
        flags |= 0x410;
        DrawShapeExtended(0x62 + i * 10 + (ticks[0] >> 4) % 10,
                          flags,
                          pos.x + i * 0x28 + 0x85,pos.y + 6,
                          yOffset,1,&drawFlags);
      }
      temp.y = pos.y + 0x23;
      temp.x = pos.x + 0x1e;
      temp.w = pos.w + -0x3c;
      temp.h = pos.h + -0x4b;
      FETextRender_MenuTextPositionedJustify
                (menuDefs->menuCarUpgrades.fCurrentItem + 0x96,
                 pos.x + (pos.w >> 1),pos.y + 0x18,2,
                 textState_Hilighted,textType_FramedInfo);
      {
        int descrItem;

        descrItem = (short)menuDefs->menuCarUpgrades.fCurrentItem + 0xaf;
        if ((menuDefs->menuCarUpgrades.fCurrentItem == 1) &&
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
      DrawShape_NFS4Rectangle(&temp);
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
    DrawShape_NFS4TransRectangle(&pos,1);
  }
  return;
}



/* ---- tScreenCarSelect::SetState  [SCREENCARSELECT.CPP:501-577] ---- */
void tScreenCarSelect::SetState(int state)

{
  /* W55-A2 BUGFIX (class-1, unsigned-char deleted guard): this build's plain `char` is
     UNSIGNED (__CHAR_UNSIGNED__), so `-1 < cVar1` below folded to a constant TRUE and gcc
     DELETED the guard -- every empty overlay slot would be treated as a valid overlay index.
     gStateOverlays is `signed char[8][4]` and the oracle guards with `lb $v1; bltz $v1`
     (8003B654/8003B65C), so the local must be SIGNED. */
  signed char cVar1;
  tOverlay *ovl;
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
      ovl = this->fCurrentOverlays[i];
      if (ovl != (tOverlay *)0x0) {
        if ((int)ovl->ID != (int)gStateOverlays[state][i]) {
          ovl->direction = -1;
        }
      }
      else {
        cVar1 = gStateOverlays[state][i];
        if (-1 < cVar1) {
          this->fCurrentOverlays[i] = this->fOverlays + cVar1;
          this->fCurrentOverlays[i]->transition = 0;
          this->fCurrentOverlays[i]->direction = 1;
        }
      }
      i = i + 1;
    } while (i < 4);
  }
  if (state != 2) {
    if (state < 3) {
      if (state != 0) {
        return;
      }
    }
    else {
      if (6 < state) {
        return;
      }
      if (state < 5) {
        return;
      }
    }
  }
  this->fInShowroom = (uint)(state - 5U < 2);
  gStopCommentaryNow = 1;
  this->fSpeechPlayed = 0;
  this->fSpeechTicks = ticks[0];
  this->fShowroomTicks = ticks[0];
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
    ::TransitionOff((tScreen *)this,kScreen_TransitionTypeScreen,(tMenu *)0x0);
  }
  else {
    i = 0;
    do {
      this->tvConfigs[i].state = tv_StateOff;
      this->tvConfigs[i].transition = 0;
      i = i + 1;
    } while (i < 10);
    if (fPreviousState != 1) {
      ::TransitionOn((tScreen *)this,kScreen_TransitionTypeScreen,(tMenu *)0x0);
    }
    TurnOn(this->fVideoWall);
  }
  return;
}



/* ---- tScreenCarSelect::CalcSplinePosition  [SCREENCARSELECT.CPP:583-625] ---- */
void tScreenCarSelect::CalcSplinePosition(int knot1,int knot2,int knot3,int knot4,u_long elapsed,
               int &camY,int &camZ,int &screenX,int &screenY,int &camRot)

{
  int _i;
  short i;
  int T [4];
  int G [4] [4];
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
  TransformVector(&T,&gCatmullRom,&Result1);
  TransformVector(&Result1,(int (*) [4] [4])G,&Result2);
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
  TransformVector(&T,&gCatmullRom,&Result1);
  TransformVector(&Result1,(int (*) [4] [4])G,&Result2);
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
  __vtbl_ptr_type (*vtbl) [10];
  int valid;
  tCarInfo carInfo;

  numPermShapes = 0x8e;
  numSwapShapes = 0xb;
  *permFileName = "zcars";
  vtbl = this->_vf;
  valid = (*vtbl[1][3].pfn)
                    (this->fPermShapes.fFilename + -0x14 + vtbl[1][3].delta,&carInfo) == 1;
  if (!valid) {
    GetStockCar(&carManager, 0,&carInfo);
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
  u_int bVar1;

  if ((((ushort)carInfo.fCarIndex != this->fPreviousCar) ||
      ((int)(signed char)carInfo.fCarID != (int)this->fPreviousCarID)) ||
     ((carInfo.fCarClass == '\a' && (this->fPreviousCountry != (ushort)carInfo.fCountry)))) {
    if (-1 < (signed char)carInfo.fCarID) {
      ::AsyncLoadSwapShapeFile((tScreen *)this,carInfo.fShapeName);
    }
    this->fPreviousCar = (ushort)carInfo.fCarIndex;
    this->fPreviousCarID = (short)(signed char)carInfo.fCarID;
    bVar1 = carInfo.fCountry;
    this->fTVsInitialized = 0;
    this->fPreviousCountry = (ushort)bVar1;
    this->SetBrightness(0,0);
    TurnOff(this->fVideoWall);
  }
  return;
}



/* ---- tScreenCarSelect::AllocateAsyncBuffer  [SCREENCARSELECT.CPP:665-666] ---- */
void tScreenCarSelect::AllocateAsyncBuffer()

{
  char *str;
  
  str = Platform_GetDCTBuffer(40000,"VideoWall");
  this->fSwapShapes.fDestFile = str;
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
  tVideoWall *videowall;
  
  videowall = this->fVideoWall;
  ::Initialize(&this->fVideoWall[0],this->tvConfigs,this->fSwapShapes.fShapes,0,10,tvOrder,0x96);
  SetAvailableText(videowall,0xf8,0x140,0x50);
  SetAvailableIcon(videowall,0x1c,10,0x136,0x3c,this->fPermShapes.fShapes);
  if ((this->fSwapShapes.fFlags & 1) != 0) {
    UpdateImages(videowall);
    this->fTVsInitialized = 1;
  }
  return;
}



/* ---- tScreenCarSelect::Initialize  [SCREENCARSELECT.CPP:692-760] ---- */
void tScreenCarSelect::Initialize()

{
  tGlobalMenuDefs *mdefs;
  short sVar2;
  tTrackInformation *trackInfo2;
  __vtbl_ptr_type (*vtbl) [10];
  int valid;
  short i;
  uint uVar6;
  tCarInfo carInfo;
  tTrackInformation trackInfo;
  tTrackInfo tourneyTrack;
  
  if (frontEnd.raceType == '\x02') {
    GetTrackToRace(&tournamentManager,&tourneyTrack);
    trackInfo2 = GetTrackByID(&trackManager,(short)tourneyTrack.fTrackNumber);
    trackInfo.fSimNumber = trackInfo2->fSimNumber;
  }
  else {
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               &trackInfo);
  }
  mdefs = menuDefs;
  GameSetup_gData.track = (int)trackInfo.fSimNumber;
  gShowroomLights[0] = 1;
  uVar6 = (menuDefs->itemDamage).fFlags &
          0xfffffffe;
  (menuDefs->itemDamage).fFlags = uVar6;
  if (frontEnd.raceType == '\x02') {
    (mdefs->itemDamage).fFlags = uVar6 | 1;
  }
  this->Initialize();
  vtbl = this->_vf;
  (*vtbl[1][4].pfn)(this->fPermShapes.fFilename + vtbl[1][4].delta + -0x14);
  SetLicensePlate();
  vtbl = this->_vf;
  this->fTVsInitialized = 0;
  this->fCameraRotation = 0;
  this->fInShowroom = 0;
  valid = (*vtbl[1][3].pfn)
                    (this->fPermShapes.fFilename + -0x14 + vtbl[1][3].delta,&carInfo);
  if (valid == 0) {
    this->fPreviousCar = -1;
    this->fPreviousCountry = -1;
    this->fPreviousCarID = -1;
  }
  else {
    this->fPreviousCar = (ushort)carInfo.fCarIndex;
    this->fPreviousCarID = (short)carInfo.fCarID;
    this->fPreviousCountry = (ushort)carInfo.fCountry;
  }
  valid = ticks[0];
  this->fBrightness[1] = 0;
  this->fBrightness[0] = 0;
  this->fDestBrightness[1] = 0;
  this->fDestBrightness[0] = 0;
  this->fShowroomTicks = valid;
  vtbl = this->_vf;
  valid = valid + -0x100;
  this->fFadeTicks[1] = valid;
  this->fFadeTicks[0] = valid;
  (*vtbl[1][1].pfn)(this->fPermShapes.fFilename + vtbl[1][1].delta + -0x14);
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
int tScreenCarSelect::ProcessInput(tPlayer keyval,tInputKeyType &key_input,tMenuCommand &menu_cmd
              )

{
  short state2;
  __vtbl_ptr_type (*vtbl) [10];
  int iVar3;
  tInputKeyType tVar4;
  byte validCar;
  tMenuItem *item;
  tMenuItemOptionsLeftRightChoice *lrItem;
  tCarInfo carInfo;
  
  tVar4 = key_input;
  if (tVar4 == kInput_KeyType_Square) {
    vtbl = this->_vf;
    item = (tMenuItem *)(int)vtbl[1][3].delta;
    iVar3 = (*vtbl[1][3].pfn)((int)(tScreen *)this + (int)&item->fFlags,&carInfo);
    if (FEApp->fPlayer == '\0') {
      lrItem = &menuDefs->itemABS;
    }
    else {
      lrItem = &menuDefs->itemABS2;
    }
    lrItem->fTextDescription = 0x10b;
    if (iVar3 != 0) {
      if ((signed char)carInfo.fCarID == '\b') {
        lrItem->fTextDescription = 0x10c;
      }
      if ((signed char)carInfo.fCarID == '\x01') {
        lrItem->fTextDescription = 0x10d;
      }
    }
    if ((frontEnd.oppNumber == '\x01') || (frontEnd.gameMode == '\x01')) {
      (menuDefs->itemOpponentUpgrades).
      fFlags = (menuDefs->itemOpponentUpgrades).fFlags | 1;
    }
    tVar4 = key_input;
  }
  if (tVar4 != kInput_KeyType_Triangle) {
    return 5;
  }
  state2 = this->fState;
  /* MATCH: NONE of the three SetState arms stages a return value -- the oracle has
     exactly ONE `jal SetState` that all three arms reach by `j` after setting only
     $a0/$a1, and the epilogue returns SetState's incidental $v0.  Writing
     `return 1;`/`return 6;` after each call blocks gcc's cross_jump merge (2 jals)
     and rewrites the whole block layout.  Same "falls off the end" shape as the
     state2<2 arm already documented below. */
  /* MATCH: flat goto/shared-tail form.  The oracle has exactly ONE `jal SetState`
     that every arm reaches by `j` after setting only $a0/$a1 -- no arm stages a
     return value (the epilogue returns SetState's incidental $v0), and the
     state2<2 arm falls off the end of the function entirely (retail UB, $v0 = the
     scheduler's leftover).  `if/else if` spellings put the gameMode block in the
     middle; the explicit labels reproduce the oracle's stub-then-tail layout. */
  /* MATCH (06A): the SYM 8c block lists ONLY carInfo/validCar/item -- there is no
     `state` and no `state2`.  A `state` local costs its own `li a1,N` in the
     gameMode arm, where the oracle re-uses the compare's constant register
     (`addiu v0,1; beq v1,v0; addu a1,v0,zero`).  Blocks are written in the
     oracle's physical VA order (dispatch / >=6 sub-dispatch / ==5 / ==6 /
     gameMode / shared jal), which also fixes the ==6 branch polarity. */
  if (state2 == 5) goto st5;
  if (5 < state2) goto ge6;
  if (state2 < 2) goto done;
  goto gamemode;
ge6:
  if (state2 == 6) goto st6;
  return 6;
st5:
  this->SetState(0);
  goto done;
st6:
  this->SetState(2);
  goto done;
gamemode:
  if (frontEnd.gameMode == '\x01') {
    return 1;
  }
  /* RESIDUAL 6 (count-exact 98/98), two independent 1998-unreachable ties:
     (a) the oracle stages the SetState arg as `addu a1,v0,zero` (re-using the
         compare's constant register) where cc1plus const-props a fresh `li a1,1`
         -- FALSIFIED here: named `int cmd = 1` before the compare, after the
         compare, and shared across compare+return+arg all const-prop back;
     (b) reorg fills the `bnez` slot with the gameMode block's head `lui` and nops
         the `j`, while ours fills the `j` -- a fill_simple_delay_slots tie. */
  this->SetState(1);
done:
  ;
}



/* ---- tScreenCarSelect::DrawVideoWall  [SCREENCARSELECT.CPP:816-850] ---- */
void tScreenCarSelect::DrawVideoWall(short y)

{
  short valid;
  __vtbl_ptr_type (*vtbl) [10];
  tVideoWall *this_00;
  byte validCar;
  tCarInfo carInfo;
  
  vtbl = this->_vf;
  valid = (*vtbl[1][3].pfn)
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
  this_00 = this->fVideoWall;
  ::UpdateTransition(this_00);
  SetValid(this_00,valid);
  SetAvailable(this_00,(ushort)carInfo.fAvailable);
  ::Draw(this_00);
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

int tScreenCarSelect::GetCar(tCarInfo &carInfo)

{
  uchar uVar1;
  byte garageNum;
  short count;

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
    uVar1 = frontEnd.carColors[0][(signed char)carInfo.fCarID];
    carInfo.fAvailable = '\x01';
    carInfo.fColor = uVar1;
    break;
  case 7:
    if (D_8011472A == 1) {
      count = carManager.GetNumOwnedCars(0);
      if (count <= 0) {
        return 0;
      }
    }
    /* MATCH (06A): the SYM 8c block for GetCar names NO locals -- a `garageNum`
       byte local costs an `addu a1,v0,zero` copy where the oracle loads the byte
       STRAIGHT into the call's $a1 in each arm.  Duplicating the call lets gcc
       cross-jump-merge the two `jal`s back into one, and putting the `== 0`
       (playerCar) arm first gives the oracle's `bnez` -> garage-arm polarity. */
    if (frontEnd.carListType == 0) {
      carManager.GetStockCar((ushort)(byte)frontEnd.playerCar[0],carInfo);
    } else {
      carManager.GetStockCar((ushort)(byte)frontEnd.garageCar[0],carInfo);
    }
    if (frontEnd.carListType == 0) {
      carInfo.fColor = frontEnd.carColors[0][(signed char)carInfo.fCarID];
    }
    carInfo.fCountry = frontEnd.carCountry[0][(signed char)carInfo.fCarID];
    break;
  default:
    count = carManager.GetNumOwnedCars(0);
    if (count <= 0 && D_80114604 != 1) {
      return 0;
    }
    if (D_80114604 == 2 && this->fState != 3) {
      count = carManager.GetNumTourneyCars(0);
      if (count <= 0) {
        return 0;
      }
    }
    garageNum = (this->fState == 3) ? D_80114729 : D_80114723;
    carManager.GetStockCar((ushort)garageNum,carInfo);
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
  short destBrightness;
  short brightness;
  short sVar3;

  brightness = this->fBrightness[i];
  destBrightness = this->fDestBrightness[i];
  /* MATCH: `destBrightness > brightness` -- NOT the equivalent
     `brightness < destBrightness`.  Compare-operand order IS the load order here
     (05H): the reversed phrasing emits `lh a2,888` before `lh a1,884`, which is
     what puts destBrightness in $a2 / brightness in $a1 like the oracle.  The
     plain `<` spelling swaps the pair across all 3 compares. */
  if (destBrightness > brightness) {
    sVar3 = this->fBrightness[i] + 8;
    this->fBrightness[i] = sVar3;
    if (this->fDestBrightness[i] < sVar3) {
      this->fBrightness[i] = this->fDestBrightness[i];
      return;
    }
  }
  else if (destBrightness < brightness) {
    sVar3 = this->fBrightness[i] + -8;
    this->fBrightness[i] = sVar3;
    if (sVar3 < this->fDestBrightness[i]) {
      this->fBrightness[i] = this->fDestBrightness[i];
    }
  }
  return;
}



/* ---- tScreenCarSelect::DrawBackground  [SCREENCARSELECT.CPP:966-993] ---- */
void tScreenCarSelect::DrawBackground()

{
  bool bVar1;
  __vtbl_ptr_type (*vtbl) [10];
  int valid;
  short bright;
  tCarInfo carInfo;

  vtbl = this->_vf;
  valid = (*vtbl[1][3].pfn)
                    (this->fPermShapes.fFilename + -0x14 + vtbl[1][3].delta,&carInfo);
  if (valid != 0) {
    ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
    bVar1 = (this->fSwapShapes.fFile != (char *)0x0) &&
            (this->fVideoWall[0].fTransitionDirection != -1) &&
            (gCarObj[(byte)FEAppB[0]->fPlayer]->async_handle == 0) &&
            (0x80 < ticks[0] - this->fFadeTicks[0]);
    if (bVar1) {
      ::UploadSwapShapes((tScreen *)this,0xb);
      TurnOn(this->fVideoWall);
      if (this->fBrightness[0] == this->fDestBrightness[0]) {
        bright = 0x20;
        if (carInfo.fAvailable != '\0') {
          bright = 0x80;
        }
        this->SetBrightness(bright,0);
      }
    }
  }
  if (this->fScreenFadeVal < 0x80) {
    vtbl = this->_vf;
    (*vtbl[1][0].pfn)(this->fPermShapes.fFilename + -0x14 + vtbl[1][0].delta,0);
  }
  return;
}



/* ---- tScreenCarSelect::DrawSliders  [SCREENCARSELECT.CPP:1002-1011] ---- */
void tScreenCarSelect::DrawSliders(tCarInfo &carInfo,short x,short y)

{
  /* MATCH: locals from the SYM 8c block (fsize 88, mask $807f0000 = ra,s0-s6):
       fn scope   short j        ($s2)
       loop block tCarStatType carStat ($v0), short result ($a0)
     Ghidra's bVar1/tVar2/value/iVar3/sVar4 were fabricated; the extra
     sign-extended copy of `y` they induced cost an 8th saved reg ($s7).
     Loop is EXIT-IN-THE-MIDDLE (oracle: top test + unconditional `j` back
     edge at .L8003C6B4) -- a `for` rotates it. */
  short j;

  j = 0;
  while (true) {
    tCarStatType carStat;
    short result;

    if (4 < j) break;
    /* MATCH: the (short) cast must sit on the SUM -- `y + 4` alone makes gcc
       materialize a sign-extended copy of y in its own saved reg (an 8th
       callee-save + 8 bytes of frame); the oracle extends AFTER the add. */
    FETextRender_MenuTextPositioned(textVals[j],x,(short)(y + 4),textState_Unselected,
                                    textType_Default);
    carStat = remap[j];
    /* 🔴 CORRECTNESS: the previous form indexed fStats[k][carStat + k], reading
       0x36/0x3C/0x42 instead of the oracle's 0x35/0x3A/0x3F -- the upgrade rows
       of fStats[4][5] are reached with the SAME column index.  Sharing the index
       expression is also what lets gcc CSE one base (`addu $a1,$s4,$v0`). */
    result = (short)carInfo.fStats[0][carStat];
    if ((carInfo.fUpgrades & 1) != 0) {
      result = result + carInfo.fStats[1][carStat];
    }
    if ((carInfo.fUpgrades & 2) != 0) {
      result = result + carInfo.fStats[2][carStat];
    }
    if ((carInfo.fUpgrades & 4) != 0) {
      result = result + carInfo.fStats[3][carStat];
    }
    DrawSlider(result,0,0xb,x,y,0x68,3,7,3,false,0,0x80,0);
    y = y + 0xf;
    j = j + 1;
  }
  return;
}



/* ---- tScreenCarSelect::DrawForeground  [SCREENCARSELECT.CPP:1015-1264] ---- */
void tScreenCarSelect::DrawForeground()

{
  short i;
  tCarInfo carInfo;
  short bShowStats;
  tMenuItem *currentItem;
  BOOL validCar;
  signed char state;
  tOverlay *ovl;
  short sVar12;
  int overlayDirection;
  
  currentItem = FEApp->fCurrentMenu[0]->fItemList[FEApp->fCurrentMenu[0]->fCurrentItem];
  validCar = (*(*this->_vf)[3].pfn)
                    (this->fPermShapes.fFilename + -0x14 + (*this->_vf)[3].delta,&carInfo);
  bShowStats = false;
  (menuDefs->itemOpponentUpgrades).fFlags =
       (menuDefs->itemOpponentUpgrades).
       fFlags | 1;
  sVar12 = this->fState;
  if (sVar12 == 1) {
    bShowStats = (tMenuItemNFS4LeftRightChoice *)currentItem == &menuDefs->itemGarageCar;
    (menuDefs->itemUpgradeCar).fFlags =
         (menuDefs->itemUpgradeCar).fFlags &
         0xfffffffe;
    if (((frontEnd.raceType == '\x02') && (frontEnd.tier == '\0')) &&
       (FECheat_IsCheatEnabled(cheat_FinishedTournament) != (void *)0x0)) {
      (menuDefs->itemOpponentUpgrades).
      fFlags = (menuDefs->itemOpponentUpgrades).fFlags & 0xfffffffe;
    }
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
  else if (sVar12 == 0) {
    if ((tMenuItemNFS4LeftRightChoice *)currentItem == &menuDefs->itemCar) {
      bShowStats = true;
    }
    (menuDefs->itemColor).fFlags &= 0xfffffffe;
    (menuDefs->itemShowcase).fFlags &= 0xfffffffe;
    if (carInfo.fCarClass == '\a') {
      (menuDefs->itemColor).fFlags |= 1;
      (menuDefs->itemShowcase).fFlags |= 1;
    }
  }
  else if (sVar12 == 2) {
    if ((tMenuItemNFS4LeftRightChoice *)currentItem == &menuDefs->itemDealerCar) {
      bShowStats = true;
    }
  }
  else if (sVar12 == 3) {
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
  else if (sVar12 == 4) {
    bShowStats = true;
  }
  if (validCar == 0) {
    bShowStats = false;
  }
  sVar12 = 1;
  if (!bShowStats) {
    sVar12 = -1;
  }
  this->fOverlays[6].direction = sVar12;
  for (i = 0; i < 4; i++) {
    overlayDirection = 1;
    ovl = this->fCurrentOverlays[i];
    if (ovl != (tOverlay *)0x0) {
      if ((int)ovl->ID == (int)gStateOverlays[this->fState][i]) {
        continue;
      }
      ovl->direction = -1;
      if (this->fCurrentOverlays[i]->transition > 0) {
        continue;
      }
      this->fCurrentOverlays[i] = (tOverlay *)0x0;
    }
    state = gStateOverlays[this->fState][i];
    if (-1 < state) {
      this->fCurrentOverlays[i] = this->fOverlays + state;
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
      (*(*this->_vf)[2].pfn)
                (this->fPermShapes.fFilename + -0x14 + (*this->_vf)[2].delta,&carInfo);
      if (gCarObj[(byte)FEApp->fPlayer]->async_handle != 0) {
        this->SetBrightness(0,0);
        TurnOff(this->fVideoWall);
        this->fFadeTicks[0] = ticks[0];
      }
      this->UpdateBrightness(0);
      if ((u_int)((ushort)this->fState - 5) >= 2) {
        showRoomFlag = 0;
        this->fCameraRotation = this->fCameraRotation + 3;
        DrawCar__FR8tCarInfossffcbUl7tPlayer(&carInfo,0x13a,0x54,4.0,-7.5,
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
        elapsedticks = (ticks[0] - this->fSpeechTicks) + -0x100;
        cameraZ = 0;
        if ((-1 < elapsedticks) && (-1 < (signed char)carInfo.fSpeechCarID)) {
          textID = (signed char)carInfo.fSpeechCarID * 0x13 + 0x3e4 +
                   (elapsedticks >> 9) % 0x13;
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
        if (this->fSpeechTicks < 0x101) {
          fadeVal = 0x80;
        }
        else {
          if (this->fSpeechTicks >= 0x181) {
            fadeVal = 0;
            goto DrawFG_fadeDone;
          }
          fadeVal = 0x180 - this->fSpeechTicks;
        }
DrawFG_fadeDone:
        DrawShapeExtended(0xA,0x200,0,0,fadeVal,0,&drawFlags);
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
        DrawCar__FR8tCarInfossffcbUl7tPlayer(&carInfo,(short)screenX,(short)screenY,
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
  char *buf_or_path;
  char *str;
  int use_default;
  void *vtbl;
  tCarInfo carInfo;
  char buffer [32];
  
  (this->fOpponentShapes).fShapes = (tTexture_ShapeInfo *)0x0;
  ::InitializeShapes((tScreen *)this,&this->fOpponentShapes,5);
  ::PreLoad((tScreen *)this);
  buf_or_path = Platform_GetDCTBuffer(16000,"VideoWall");
  this->fSwapShapes.fDestFile = buf_or_path;
  str = Platform_GetDCTBuffer(16000,"OpponentVid");
  vtbl = this->_vf;
  (this->fOpponentShapes).fDestFile = str;
  use_default = (**(code **)((int)vtbl + 0x6c))
                          (this->fPermShapes.fFilename +
                           -0x14 + *(short *)((int)vtbl + 0x68),&carInfo) == 1;
  if (!use_default) {
    GetStockCar(&carManager, 0,&carInfo);
  }
  sprintf(buffer,"z%s",carInfo.fSmallName);
  ::AsyncLoadShapeFile((tScreen *)this,buffer,&this->fSwapShapes);
  GetStockCar(&carManager, (ushort)(byte)frontEnd.oppCar,&carInfo);
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
  tVideoWall *vw_opp;
  tVideoWall *vw_player;
  
  vw_player = this->fVideoWall;
  ::Initialize(&this->fVideoWall[0],this->tvConfigs,
             this->fSwapShapes.fShapes,0,5,tvSplitOrder,0);
  SetAvailableText(vw_player,0xf8,0x10e,0x2d);
  if ((this->fSwapShapes.fFlags & 1) != 0) {
    SetOffset(vw_player,6,0);
    UpdateImages(vw_player);
    this->fTVsInitialized = 1;
  }
  vw_opp = this->fVideoWall + 1;
  ::Initialize(&this->fVideoWall[1],this->tvConfigs + 5,(this->fOpponentShapes).fShapes,0,5,
             tvSplitOrder,0);
  SetAvailableText(vw_player,0xf8,0x10e,0x96);
  if (((this->fOpponentShapes).fFlags & 1) != 0) {
    SetOffset(vw_opp,6,0x69);
    UpdateImages(vw_opp);
    this->fTVsInitialized = 1;
  }
  return;
}



/* ---- tScreenCarSelectDuel::Initialize  [SCREENCARSELECT.CPP:1339-1342] ---- */
void tScreenCarSelectDuel::Initialize()

{
  
  this->Initialize();
  this->fState = 0;
  gShowroomLights[0] = 0;
  return;
}



/* ---- tScreenCarSelectDuel::Cleanup  [SCREENCARSELECT.CPP:1346-1348] ---- */
void tScreenCarSelectDuel::Cleanup()

{
  
  ::FreeShapes((tScreen *)this,&this->fOpponentShapes);
  this->Cleanup();
  return;
}



/* ---- tScreenCarSelectDuel::DrawVideoWall  [SCREENCARSELECT.CPP:1352-1383] ---- */
void tScreenCarSelectDuel::DrawVideoWall(short y)

{
  short valid;
  __vtbl_ptr_type (*vtbl) [10];
  tVideoWall *vw;
  short i;
  byte validCar;
  tCarInfo carInfo;

  vtbl = this->_vf;
  valid = (*vtbl[1][3].pfn)
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
  vw = this->fVideoWall;
  if (((this->fSwapShapes.fFlags & 1) != 0) &&
     (this->fTVsInitialized == 0)) {
    SetOffset(vw,6,0);
    UpdateImages(vw);
    this->fTVsInitialized = 1;
  }
  vw = this->fVideoWall;
  ::UpdateTransition(vw);
  SetValid(vw,valid);
  SetAvailable(vw,(ushort)carInfo.fAvailable);
  ::Draw(vw);
  return;
}



/* ---- tScreenCarSelectDuel::DrawOpponentVideoWall  [SCREENCARSELECT.CPP:1387-1414] ---- */
void tScreenCarSelectDuel::DrawOpponentVideoWall(short y)

{
  short i;
  tVideoWall *vw_opp;
  tVideoWall *this_00;

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
  vw_opp = this->fVideoWall + 1;
  if (((this->fSwapShapes.fFlags & 1) != 0) &&
     (this->fOpponentTVsInitialized == 0)) {
    SetOffset(vw_opp,6,0x69);
    UpdateImages(vw_opp);
    this->fOpponentTVsInitialized = 1;
  }
  this_00 = this->fVideoWall + 1;
  ::UpdateTransition(this_00);
  SetValid(this_00,1);
  SetAvailable(this_00,1);
  ::Draw(this_00);
  return;
}



/* ---- tScreenCarSelectDuel::GetShapeInfo  [SCREENCARSELECT.CPP:1418-1433] ---- */
void tScreenCarSelectDuel::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  __vtbl_ptr_type (*vtbl) [10];
  int valid;
  tCarInfo carInfo;
  
  numPermShapes = 0x34;
  numSwapShapes = 5;
  vtbl = this->_vf;
  valid = (*vtbl[1][3].pfn)
                    (this->fPermShapes.fFilename + -0x14 +
                     vtbl[1][3].delta,&carInfo) == 1;
  if (!valid) {
    GetStockCar(&carManager, 0,&carInfo);
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
  u_int bVar1;

  if ((((ushort)carInfo.fCarIndex != this->fPreviousCar) ||
      ((int)(signed char)carInfo.fCarID != (int)this->fPreviousCarID)) ||
     ((carInfo.fCarClass == '\a' &&
      (this->fPreviousCountry != (ushort)carInfo.fCountry)))) {
    if (-1 < (signed char)carInfo.fCarID) {
      ::AsyncLoadSwapShapeFile((tScreen *)this,carInfo.fSmallName);
    }
    this->fPreviousCar = (ushort)carInfo.fCarIndex;
    this->fPreviousCarID = (short)(signed char)carInfo.fCarID;
    bVar1 = carInfo.fCountry;
    this->fTVsInitialized = 0;
    this->fPreviousCountry = (ushort)bVar1;
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
void tScreenCarSelectDuel::DrawBackground()

{
  short ts3;
  int drenv;
  short creditsTextVal;
  int screenVtbl;
  int screenVtbl2;
  int ti8;
  __vtbl_ptr_type (*vtbl) [10];
  int pkt_addr24;
  int pkt_addr24_2;
  tListIteratorCar *carIter;
  short sVar2;
  tCarInfo *stockCarInfo;
  tCarInfo *carInfo_00;
  byte validCar;
  RECT r;
  tCarInfo carInfo;
  RECT temp;
  byte bVar1;
  u_char *prev_pkt;
  u_char *cur_pkt_2;
  u_char *daprim;
  byte bVar2;
  
  drenv = (int)Draw_GetDRAWENV(Draw_gPlayer1View,gFlip);
  daprim = Render_gPacketPtr;
  this->fState = 7;
  prev_pkt = Render_gPalettePtr;
  temp.x = 0;
  temp.y = *(short *)(drenv + 2);
  temp.w = 0x200;
  stockCarInfo = (tCarInfo *)0xff000000;
  temp.h = (short)screenheight;
  *(uint *)Render_gPacketPtr =
       *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
  pkt_addr24 = (uint)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0xc;
  *(uint *)prev_pkt = *(uint *)prev_pkt & 0xff000000 | pkt_addr24;
  SetDrawArea((DR_AREA *)daprim,&temp);
  r.x = 0x122;
  r.w = 200;
  r.h = 0xc;
  r.y = 0x82;
  creditsTextVal = TextValue(&menuDefs->iteratorOpponentCar,kPlayerBoth);
  DrawShape_NFS4RoundRectangle((int)creditsTextVal,&r,0);
  GetStockCar(&carManager, (ushort)(byte)frontEnd.oppCar,&carInfo);
  carInfo.fColor = carInfo.fColorOrder[carInfo.fDefaultColor];
  this->UpdateOpponentVideoWall(carInfo);
  ::IsShapeFileLoaded((tScreen *)this,&this->fOpponentShapes);
  bVar1 = false;
  if ((((this->fOpponentShapes).fFile != (char *)0x0) &&
      (this->fVideoWall[1].fTransitionDirection != -1)) &&
     (gCarObj[1]->async_handle == 0)) {
    bVar1 = 0x80 < ticks[0] - this->fFadeTicks[1];
  }
  if ((bool)bVar1) {
    ::UploadShapes((tScreen *)this,&this->fOpponentShapes,0,0x41,5,0);
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
  DrawCar__FR8tCarInfossffcbUl7tPlayer(stockCarInfo,0x116,0xb8,1.7,-9.9,(char)this->fBrightness[1],false,
             this->fCameraRotation,kPlayerTwo);
  if (((gCarObj[1]->async_handle == 0) &&
      (sVar2 = this->fBrightness[1],
      sVar2 == this->fDestBrightness[1])) &&
     ((sVar2 == 0 && (0x80 < ticks[0] - this->fFadeTicks[1])))) {
    this->SetBrightness(0x80,1);
    TurnOn(this->fVideoWall + 1);
  }
  screenVtbl = (int)this->_vf;
  (**(code **)(screenVtbl + 0x84))
            (this->fPermShapes.fFilename +
             *(short *)(screenVtbl + 0x80) + -0x14,0x69);
  daprim = Render_gPacketPtr;
  cur_pkt_2 = Render_gPalettePtr;
  temp.x = 0;
  carInfo_00 = (tCarInfo *)0xff000000;
  temp.w = 0x200;
  temp.y = *(short *)(drenv + 2) + 0x80;
  temp.h = (short)screenheight + -0x80;
  *(uint *)Render_gPacketPtr =
       *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
  pkt_addr24_2 = (uint)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0xc;
  *(uint *)cur_pkt_2 = *(uint *)cur_pkt_2 & 0xff000000 | pkt_addr24_2;
  SetDrawArea((DR_AREA *)daprim,&temp);
  PSXDrawSquare(0,0,screenheight / 2,0x200,screenheight / 2);
  screenVtbl2 = (int)this->_vf;
  ti8 = (**(code **)(screenVtbl2 + 0x6c))
                  (this->fPermShapes.fFilename +
                   *(short *)(screenVtbl2 + 0x68) + -0x14,&carInfo);
  if (ti8 == 0) {
    carInfo.fCarID = -1;
  }
  else {
    r.y = 0x19;
    if (frontEnd.carListType == '\0') {
      carIter = &menuDefs->iteratorCar1;
    }
    else {
      carIter = &menuDefs->iteratorGarageCar;
    }
    ts3 = TextValue(carIter,kPlayerBoth);
    DrawShape_NFS4RoundRectangle((int)ts3,&r,0);
  }
  vtbl = this->_vf;
  (*vtbl[1][2].pfn)
            (this->fPermShapes.fFilename + vtbl[1][2].delta + -0x14,
             &carInfo);
  if ((gCarObj[0]->async_handle != 0) && (0x80 < ticks[0] - this->fFadeTicks[0])) {
    this->SetBrightness(0,0);
    TurnOff(this->fVideoWall);
    this->fFadeTicks[0] = ticks[0];
  }
  this->UpdateBrightness(0);
  showRoomFlag = 0;
  DrawCar__FR8tCarInfossffcbUl7tPlayer(carInfo_00,0x116,0x4f,1.7,-9.9,(char)this->fBrightness[0],false,
             this->fCameraRotation,kPlayerOne);
  if ((((gCarObj[0]->async_handle == 0) &&
       (sVar2 = this->fBrightness[0],
       sVar2 == this->fDestBrightness[0])) && (sVar2 == 0)) &&
     (0x80 < ticks[0] - this->fFadeTicks[0])) {
    sVar2 = 0x20;
    if (carInfo.fAvailable != '\0') {
      sVar2 = 0x80;
    }
    this->SetBrightness(sVar2,0);
    TurnOn(this->fVideoWall);
  }
  if (ti8 != 0) {
    ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
    bVar2 = false;
    if (((this->fSwapShapes.fFile != (char *)0x0) &&
        (this->fVideoWall[0].fTransitionDirection != -1)) &&
       (gCarObj[0]->async_handle == 0)) {
      bVar2 = 0x80 < ticks[0] - this->fFadeTicks[0];
    }
    if ((bool)bVar2) {
      ::UploadSwapShapes((tScreen *)this,5);
      TurnOn(this->fVideoWall);
      if (this->fDestBrightness[0] == this->fBrightness[0]) {
        sVar2 = 0x20;
        if (carInfo.fAvailable != '\0') {
          sVar2 = 0x80;
        }
        this->SetBrightness(sVar2,0);
      }
    }
  }
  vtbl = this->_vf;
  (*vtbl[1][0].pfn)
            (this->fPermShapes.fFilename + vtbl[1][0].delta + -0x14,0)
  ;
  return;
}



/* ---- tScreenCarSelectDuel::DrawForeground  [SCREENCARSELECT.CPP:1613-1635] ---- */
void tScreenCarSelectDuel::DrawForeground()

{
  tCarInfo *carInfo;
  __vtbl_ptr_type (*vtbl) [10];
  int iVar2;
  int iVar3;
  short result;
  ushort carStat;
  tCarStatType tVar4;
  short j;
  short sVar5;
  short y;
  short fY;
  short i;
  int iVar6;
  byte validCar;
  tCarInfo tStack_f8;
  
  fY = 0x2d;
  iVar6 = 0;
  vtbl = this->_vf;
  iVar2 = (*vtbl[1][3].pfn)
                    (this->fPermShapes.fFilename +
                     vtbl[1][3].delta + -0x14,&tStack_f8);
  iVar3 = 0;
  while (sVar5 = 0, iVar3 >> 0x10 < 2) {
    for (; iVar3 = (int)sVar5, iVar3 < 5; sVar5 = sVar5 + 1) {
      FETextRender_MenuTextPositionedJustify(text2PVals[iVar3],500,fY + 4,1,textState_Unselected,textType_ScreenInfo);
      if (iVar2 == 0) {
        carStat = 0;
      }
      else {
        tVar4 = remap[iVar3];
        carStat = (ushort)tStack_f8.fStats[0][tVar4];
        if ((tStack_f8.fUpgrades & 1) != 0) {
          carStat = carStat + tStack_f8.fStats[1][tVar4 + cst_Brake];
        }
        if ((tStack_f8.fUpgrades & 2) != 0) {
          carStat = carStat + tStack_f8.fStats[2][tVar4 + cst_Speed];
        }
        if ((tStack_f8.fUpgrades & 4) != 0) {
          carStat = carStat + tStack_f8.fStats[3][tVar4 + cst_Handling];
        }
      }
      DrawSlider(carStat,0,0xb,0x1a1,fY,0x49,3,4,3,true,0,0x80,0);
      fY = fY + 0xf;
    }
    fY = 0x96;
    iVar6 = iVar6 + 1;
    GetStockCar(&carManager, (ushort)(byte)frontEnd.oppCar,&tStack_f8);
    iVar3 = iVar6 * 0x10000;
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
int tScreenCarSelectTwoPlayer::GetCar(tCarInfo &carInfo)

{
  /* MATCH (SYM 8c @0x8003e040, rule 8): fsize 48, mask $803f0000 = ra + s0..s5;
     REGPARM `carInfo` = $18 ($s2); the ONLY named REG locals are
     `currentplayer` = $21 ($s5) and `garageNumber` = $19 ($s3), both type INT.
     Ghidra's `byte player / byte color / short count / short otherPlayer` were
     inventions -- the byte types cost two dead `andi ..,255` promotions and the
     named `count` pinned an extra pseudo.  RESIDUAL: 59 diffs / ours 81 vs
     oracle 84 -- retail still holds THREE copies of FEApp->fPlayer (s0 anonymous
     temp + s5 + s3, copies emitted BEFORE the carListType branch) so it needs a
     6th callee-saved reg; every probed source form (2 reads, 3 reads,
     garageNumber-from-FEApp, hoisted copy) coalesces one of them away. */
  int currentplayer;
  int garageNumber;
  int color;

  currentplayer = FEApp->fPlayer;
  garageNumber = currentplayer;
  if (frontEnd.carListType == '\0') {
    carManager.GetStockCar((ushort)(byte)frontEnd.playerCar[currentplayer],carInfo);
    color = frontEnd.carColors[currentplayer][(signed char)carInfo.fCarID];
  }
  else {
    if (carManager.GetNumOwnedCars((short)currentplayer) <= 0) {
      garageNumber = 0;
    }
    if (carManager.GetNumOwnedCars((short)garageNumber) <= 0) {
      return 0;
    }
    carManager.GetGarageCar((ushort)(byte)frontEnd.garageCar[currentplayer],carInfo,garageNumber);
    color = carInfo.fColor;
  }
  carInfo.fColor = carInfo.fColorOrder[color];
  carInfo.fCountry = frontEnd.carCountry[FEApp->fPlayer][(signed char)carInfo.fCarID];
  return 1;
}



/* ---- tScreenCarSelectTwoPlayer::DrawVideoWall  [SCREENCARSELECT.CPP:1668-1701] ---- */
/* MATCH 2026-08-03 (18->PASS): the unsized FEApp view keeps %hi(FEApp)
   live while reloading the pointer value at each access, as in retail.
   A dedicated int offset is copy-coalesced directly into the third argument
   register; sharing the later short text offset forced GCC to use $a3 and
   insert a move.  Direct fVideoWall expressions also match SLD's local set. */
void tScreenCarSelectTwoPlayer::DrawVideoWall(short y)

{
  short valid;
  __vtbl_ptr_type (*vtbl) [10];
  short sVar2;
  int offset;
  short i;
  byte validCar;
  tCarInfo carInfo;

  vtbl = this->_vf;
  valid = (*vtbl[1][3].pfn)
                    (this->fPermShapes.fFilename + -0x14 +
                     vtbl[1][3].delta,&carInfo);
  i = 0;
  do {
    DrawShapeExtended(i,0,0,-(int)y,
               (int)this->fScreenFadeVal,0,(tDrawShapeExtended *)0x0);
    i = i + 1;
  } while (i < 0xc);
  if (((this->fSwapShapes.fFlags & 1) != 0) &&
     (this->fTVsInitialized == 0)) {
    offset = 0;
    if (FEAppB[0]->fPlayer != '\0') {
      offset = 0x69;
    }
    SetOffset(this->fVideoWall,6,offset);
    sVar2 = 0x2d;
    if (FEAppB[0]->fPlayer != '\0') {
      sVar2 = 0x96;
    }
    SetAvailableText(this->fVideoWall,0xf8,0x10e,sVar2);
    UpdateImages(this->fVideoWall);
    this->fTVsInitialized = 1;
  }
  if ((0 < this->fScreenFadeVal) &&
     (this->fTransitionOff != 0)) {
    TurnOffInstant(this->fVideoWall);
    this->SetBrightness(0,0);
  }
  ::UpdateTransition(this->fVideoWall);
  SetValid(this->fVideoWall,valid);
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
  GetStockCar(&carManager, 0,&carInfo);
  *permFileName = "zcarsb";
  sprintf(gSwapFileName[0],"%s",carInfo.fSmallName);
  *swapFileName = gSwapFileName[0];
  return;
}



/* ---- tScreenCarSelectTwoPlayer::UpdateVideoWall  [SCREENCARSELECT.CPP:1723-1735] ---- */
void tScreenCarSelectTwoPlayer::UpdateVideoWall(tCarInfo &carInfo)

{
  u_int bVar1;

  if ((((ushort)carInfo.fCarIndex != this->fPreviousCar) ||
      ((int)(signed char)carInfo.fCarID != (int)this->fPreviousCarID)) ||
     ((carInfo.fCarClass == '\a' &&
      (this->fPreviousCountry != (ushort)carInfo.fCountry)))) {
    if (-1 < (signed char)carInfo.fCarID) {
      ::AsyncLoadSwapShapeFile((tScreen *)this,carInfo.fSmallName);
    }
    this->fPreviousCar = (ushort)carInfo.fCarIndex;
    this->fPreviousCarID = (short)(signed char)carInfo.fCarID;
    bVar1 = carInfo.fCountry;
    this->fTVsInitialized = 0;
    this->fPreviousCountry = (ushort)bVar1;
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
  int screenVtbl;
  int ti7;
  int screenVtbl2;
  __vtbl_ptr_type (*vtbl) [10];
  int pkt_addr24;
  int pkt_addr24_2;
  int brightness;
  int elapsed;
  short carY_2;
  short sVar3;
  short ts3;
  short carY;
  short ts10;
  DRAWENV *drenv;
  RECT r;
  union {
    tCarInfo carInfo;
    signed char signedCarID;
  };
  RECT temp;
  u_char *cur_pkt;
  DR_AREA *daprim;
  u_char *cur_pkt_2;
  BOOL bVar1;
  
  ts10 = 0x4f;
  drenv = (DRAWENV *)Draw_GetDRAWENV(Draw_gPlayer1View,gFlip);
  daprim = (DR_AREA *)Render_gPacketPtr;
  cur_pkt = Render_gPalettePtr;
  temp.x = 0;
  temp.y = *(short *)((char *)drenv + 2);
  temp.w = 0x200;
  temp.h = (short)screenheight;
  ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)cur_pkt)->addr;
  Render_gPacketPtr = (u_char *)daprim + 0xc;
  ((tPsyQPrimTag *)cur_pkt)->addr = (u_int)daprim;
  SetDrawArea(daprim,&temp);
  r.x = 0x122;
  r.y = 0x19;
  if (FEAppB[0]->fPlayer == '\x01') {
    r.y = 0x82;
  }
  r.w = 200;
  r.h = 0xc;
  screenVtbl = (int)this->_vf;
  ti7 = (**(code **)(screenVtbl + 0x6c))
                  (*(short *)(screenVtbl + 0x68) + -0x14 +
                   this->fPermShapes.fFilename,&carInfo);
  if (ti7 != 0) {
    r.y = 0x14;
    if (FEAppB[0]->fPlayer == '\x01') {
      ts10 = 0xb8;
      r.y = 0x80;
    }
    this->fCameraRotation = this->fCameraRotation + 3;
    DrawShape_NFS4RoundRectangle((signed char)carInfo.fCarID + 0x121,&r,0);
    screenVtbl2 = (int)this->_vf;
    (**(code **)(screenVtbl2 + 100))
              (*(short *)(screenVtbl2 + 0x60) + -0x14 +
               this->fPermShapes.fFilename,&carInfo);
    if (gCarObj[(byte)FEAppB[0]->fPlayer]->async_handle != 0) {
      this->SetBrightness(0,0);
      this->fFadeTicks[0] = ticks[0];
    }
    if (gCarObj[(byte)FEAppB[0]->fPlayer]->async_handle == 0) {
      sVar3 = this->fBrightness[0];
      if (((sVar3 == this->fDestBrightness[0]) && (sVar3 == 0)) &&
          (0x80 < ticks[0] - this->fFadeTicks[0])) {
        carY_2 = 0x20;
        if (carInfo.fAvailable != '\0') {
          carY_2 = 0x80;
        }
        this->SetBrightness(carY_2,0);
        TurnOn(this->fVideoWall);
      }
      /* MATCH: void fence HERE (inner-if exit, still inside the outer if) gives the
         inner guard chain its OWN branch target, so reorg can no longer copy the
         outer target's `addu a0,s0,zero` head into the `bne fBrightness,fDest`
         delay slot -- the oracle leaves that one slot a nop while KEEPING the
         steal in the outer `bnez async_handle` slot.  Zero insns.  Do NOT delete. */
      __asm__("" : : "i"(0));
    }
    this->UpdateBrightness(0);
    showRoomFlag = 0;
    tPlayer player = (tPlayer)(byte)FEAppB[0]->fPlayer;
    DrawCar__FR8tCarInfossffcbUl7tPlayer(&carInfo,0x116,ts10,1.7,-9.9,(char)this->fBrightness[0],false,
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
    DrawCar__FR8tCarInfossffcbUl7tPlayer(&carInfo,0x116,0x4f,1.7,-9.9,(char)this->fBrightness[0],false,
               this->fCameraRotation,player);
    vtbl = this->_vf;
    (*vtbl[1][6].pfn)
              (vtbl[1][6].delta + -0x14 + this->fPermShapes.fFilename)
    ;
  }
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  bVar1 = false;
  if (((this->fSwapShapes.fFile != (char *)0x0) &&
     (this->fVideoWall[0].fTransitionDirection != -1)) &&
     (gCarObj[(byte)FEAppB[0]->fPlayer]->async_handle == 0)) {
    elapsed = ticks[0] - this->fFadeTicks[0];
    bVar1 = 0x80 < elapsed;
  }
  if (bVar1) {
    ts3 = 0;
    if (FEAppB[0]->fPlayer == '\x01') {
      ts3 = 0x41;
    }
    ::UploadShapes((tScreen *)this,&this->fSwapShapes,0,ts3,5,0);
    TurnOn(this->fVideoWall);
    if (this->fDestBrightness[0] == this->fBrightness[0]) {
      brightness = 0x20;
      if (carInfo.fAvailable != '\0') {
        brightness = 0x80;
      }
      this->SetBrightness(brightness,0);
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
  cur_pkt_2 = Render_gPalettePtr;
  ((tPsyQPrimTag *)daprim)->addr = ((tPsyQPrimTag *)cur_pkt_2)->addr;
  Render_gPacketPtr = (u_char *)daprim + 0xc;
  ((tPsyQPrimTag *)cur_pkt_2)->addr = (u_int)daprim;
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
  /* MATCH: locals VERBATIM from the SYM 8c block (fsize 296, mask $807f0000):
       AUTO tCarInfo carInfo (@sp+0x38)   REG short j($s2), short yOffset($s1),
       BOOL gotcar($s4).  Ghidra's auStack_f0/abStack_c0/bb/b6/b1/loc_2c were
       byte-slices of that ONE tCarInfo -- keeping them apart cost the shared
       `addu $a1,$s3,$v0` stat base.  Loop is exit-in-the-middle like
       tScreenCarSelect::DrawSliders, and the (short) cast sits on `yOffset + 4`. */
  tCarInfo carInfo;
  short j;
  short yOffset;
  BOOL gotcar;   /* SYM BOOL == int: the oracle just copies $v0 (`addu $s4,$v0,$zero`);
                    a C++ `bool` normalizes it with an extra `sltu`. */
  /* MATCH: the SYM 8c block does NOT list a function-scope `ci`/carInfo-pointer --
     it names a PTR STRUCT tCarInfo "carInfo" (shadowing the AUTO struct) scoped to
     the innermost block starting @0x8003EB60, i.e. declared FRESH inside the
     `if (gotcar)` loop body, not hoisted before the loop. The compiler still
     loop-invariant-hoists its VALUE (&carInfo is constant), landing the address
     materialize in the loop-setup preamble (@0x8003EB14, beside the s6/s5 table
     bases) instead of inside the earlier if/else (which had no reason to touch it
     when `ci` didn't exist there yet) -- that's what was stealing the if/else's
     branch-delay slots in the old function-scope-hoisted form. */

  yOffset = 0x2d;
  if (FEAppA[0]->fPlayer == '\x01') {
    yOffset = 0x96;
  }
  gotcar = (**(code **)(*(int *)((int)this + 0x60) + 0x6c))
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
    short result;

    if (4 < j) break;
    FETextRender_MenuTextPositionedJustify(text2PVals[j],500,(short)(yOffset + 4),1,
                                           textState_Unselected,textType_Default);
    /* MATCH: the ACCUMULATE arm is the inline one -- oracle `beqz $s4,.L8003EBC8`
       branches AWAY to the `result = 0` block, which sits after it. RESIDUAL FLOOR:
       oracle keeps the accumulator in $v1 (matching the SYM's REG $v1 `result`) and
       the fUpgrades test byte in $a0; ours swaps them ($a0 accumulator / $v1 test) --
       a uniform a0<->v1 register-coloring tie-break (§3.15 family). Tried: call
       duplication per branch (worse, 56 diffs -- reverted), ci/carStat declaration
       reorder (already applied above, helped elsewhere but doesn't move this pair). */
    if (gotcar != 0) {
      tCarStatType carStat = remap[j];
      tCarInfo *ci = &carInfo;
      result = (short)ci->fStats[0][carStat];
      if ((ci->fUpgrades & 1) != 0) {
        result = result + ci->fStats[1][carStat];
      }
      if ((ci->fUpgrades & 2) != 0) {
        result = result + ci->fStats[2][carStat];
      }
      if ((ci->fUpgrades & 4) != 0) {
        result = result + ci->fStats[3][carStat];
      }
    }
    else {
      result = 0;
    }
    DrawSlider(result,0,0xb,0x1a1,yOffset,0x49,3,4,3,true,0,0x80,0);
    yOffset = yOffset + 0xf;
    j = j + 1;
  }
  return;
}



/* ---- tScreenCarSelectTwoPlayer::SetDialog  [SCREENCARSELECT.CPP:1881-1892] ---- */
void tScreenCarSelectTwoPlayer::SetDialog()

{
  /* MATCH (06A): the SYM 8c block lists exactly ONE named local -- `player`
     (class REG $16 = $s0, type INT) -- plus the inlined accessors' `this`
     pseudos.  dlg / sVar2 / fmt / str were Ghidra inventions.  `this` is
     REGPARM $17 = $s1 and the oracle ADVANCES THAT SAME REGISTER IN PLACE
     (`addiu s1,s1,928`) to reach the dialog sub-object, which only happens when
     every access is spelled `this->CarDialog...` -- a `dlg` pointer local gets its
     own pseudo and leaves `this` un-copied in $a0.  The guard reads fPlayer
     ANONYMOUSLY and `player` is a second, named read, so cse emits the oracle's
     `lbu a0,556(v0)` + `addu s0,a0,zero` copy (the copy landing in the beqz
     delay slot) instead of loading straight into $s0. */
  int player;

  if (FEApp->waitingForOtherPlayer[FEApp->fPlayer] != 0) {
    player = FEApp->fPlayer;
    this->CarDialog.OffsetX = 0;
    this->CarDialog.OffsetY = (player == 0) ? -0x3c : 0x3c;
    this->CarDialog.specificPlayer = (ushort)player;
    sprintf("",TextSys_Word(0x2a8),PlayerName(1 - player));
    this->CarDialog.string = "";
    Display((tDialogBase *)&this->CarDialog);
  }
  else {
    Hide((tDialogBase *)&this->CarDialog);
  }
  return;
}



/* ---- tScreenCarSelectTwoPlayer::AllocateAsyncBuffer  [SCREENCARSELECT.CPP:1896-1897] ---- */
void tScreenCarSelectTwoPlayer::AllocateAsyncBuffer()

{
  char *str;
  
  str = Platform_GetDCTBuffer(16000,"VideoWall");
  this->fSwapShapes.fDestFile = str;
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
  
  this->Initialize();
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
  
  Hide((tDialogBase *)&this->CarDialog);
  this->Cleanup();
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
int tScreenPinkSlipsCarSelect::GetCar(tCarInfo &carInfo)

{
  ushort garageNumber;
  byte player;

  if (PinkSlipsScreenState[0] != CardLoadedFine) {
    return 0;
  }
  if (PinkSlipsScreenState[1] != CardLoadedFine) {
    return 0;
  }
  player = (byte)FEAppB[0]->fPlayer;
  garageNumber = (ushort)frontEnd.pinkSlipsCar[player];
  carManager.GetPinkSlipsCar(garageNumber,carInfo,(ushort)player);
  carInfo.fColor = carInfo.fColorOrder[carInfo.fColor];
  return 1;
}



/* ---- tScreenPinkSlipsCarSelect::DrawBackground  [SCREENCARSELECT.CPP:1949-1954] ---- */
void tScreenPinkSlipsCarSelect::DrawBackground()

{
  
  this->DoMemCardStuff();
  this->DrawBackground();
  if (this->fExitingScreen != 0) {
    Hide((tDialogBase *)&this->CarDialog);
  }
  return;
}



/* ---- tScreenPinkSlipsCarSelect::DoMemCardStuff  [SCREENCARSELECT.CPP:1958-2061] ---- */
void tScreenPinkSlipsCarSelect::DoMemCardStuff()

{
  byte player2;
  bool bVar2;
  tFEApplication *this_00;
  short sVar3;
  CARDINFO_def *cardInfo;
  long lVar5;
  PinkSlipsCarSelectState PVar6;
  int ret;
  PinkSlipsCarSelectState *pinkState;
  int card;
  int card_00;
  int player;
  tPlayer atIndex;
  
  player2 = FEApp->fPlayer;
  atIndex = (tPlayer)player2;
  card_00 = 1;
  if (atIndex != kPlayerOne) {
    card_00 = 5;
  }
  if (this->fExitingScreen != 0) {
    return;
  }
  if ((atIndex == kPlayerTwo) && (PinkSlipsScreenState[0] != CardLoadedFine)) {
    return;
  }
  if (PinkSlipsScreenState[0] == CardCurrentlyLoading) {
    return;
  }
  if (PinkSlipsScreenState[1] == CardCurrentlyLoading) {
    return;
  }
  pinkState = PinkSlipsScreenState + atIndex;
  if (*pinkState == CardLoadedFine) {
    return;
  }
  if (this->CarDialog.fFullyOpen != 1)
  {
    this->waitfordialog = 0;
    return;
  }
  if (this->waitfordialog < 5) {
    this->waitfordialog = this->waitfordialog + 1;
    return;
  }
  if (*pinkState != CardCurrentlyLoading) {
    MCRD_handlecardevents(card_00);
    cardInfo = MCRD_getcard(card_00);
    this->pCI = cardInfo;
    this_00 = FEApp;
    if (cardInfo->status == -1) {
      *pinkState = NoCardInserted;
    }
    else if ((CURRENTLYUSINGMEMCARD == 0) && (*pinkState == NoCardInserted)) {
      *pinkState = CardCurrentlyLoading;
      Redraw(this_00);
      Redraw(FEApp);
      sVar3 = LoadGame((ushort)player2,true,0);
      if (sVar3 == 0) {
        GetNumPinkSlipsCars(&carManager, (ushort)player2);
        CheapestCarStockPrice(&carManager);
        sVar3 = GetNumPinkSlipsCars(&carManager, (ushort)player2);
        bVar2 = false;
        if (sVar3 == 0x20) {
          *pinkState = TooManyCars;
          goto DoMC_pinkSlipsIter;
        }
        sVar3 = GetNumPinkSlipsCars(&carManager, (ushort)player2);
        if ((1 < sVar3) ||
           ((sVar3 = GetNumPinkSlipsCars(&carManager, (ushort)player2), sVar3 == 1 &&
            (lVar5 = CheapestCarStockPrice(&carManager),
            lVar5 <= frontEnd.pinkSlipsCash[atIndex])))) {
          bVar2 = true;
        }
        if (bVar2) {
          pinkState = PinkSlipsScreenState + atIndex;
          PVar6 = CardLoadedFine;
        }
        else {
          pinkState = PinkSlipsScreenState + atIndex;
          PVar6 = NotEnoughCars;
        }
      }
      else {
        if (sVar3 == 1) {
          *pinkState = CardFailed;
          goto DoMC_pinkSlipsIter;
        }
        if (sVar3 == 2) {
          *pinkState = CardFailedUnformatted;
          goto DoMC_pinkSlipsIter;
        }
        pinkState = PinkSlipsScreenState + atIndex;
        PVar6 = CardFailedNotFound;
      }
      *pinkState = PVar6;
    }
  }
DoMC_pinkSlipsIter:
  if (PinkSlipsScreenState[atIndex] == CardLoadedFine) {
    Decrement(&menuDefs->iteratorPinkSlipsCar,atIndex);
    Increment(&menuDefs->iteratorPinkSlipsCar,atIndex);
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
  
  this->DrawForeground();
  return;
}



/* ---- tScreenPinkSlipsCarSelect::Initialize  [SCREENCARSELECT.CPP:2070-2083] ---- */
void tScreenPinkSlipsCarSelect::Initialize()

{
  CARDINFO_def *cardInfo;
  
  this->waitfordialog = 0;
  this->fStartCheckTick = 0;
  this->fCardFailed = 0;
  PinkSlipsScreenState[0] = NoCardInserted;
  PinkSlipsScreenState[1] = NoCardInserted;
  cardInfo = MCRD_getcard(1);
  this->pCI = cardInfo;
  Init_Memcard(true,1);
  this->fExitingScreen = 0;
  this->Initialize();
  return;
}



/* ---- tScreenPinkSlipsCarSelect::Cleanup  [SCREENCARSELECT.CPP:2086-2094] ---- */
void tScreenPinkSlipsCarSelect::Cleanup()

{
  
  this->fExitingScreen = 1;
  PinkSlipsScreenState[0] = WhoCaresWeBeExiting;
  PinkSlipsScreenState[1] = WhoCaresWeBeExiting;
  Hide((tDialogBase *)&this->CarDialog);
  DeInit_Memcard();
  this->Cleanup();
  return;
}



/* ---- tScreenPinkSlipsCarSelect::SetDialog  [SCREENCARSELECT.CPP:2098-2187] ---- */
void tScreenPinkSlipsCarSelect::SetDialog()

{
  char *str;
  char *str2;
  short y_off;
  int iVar3;
  int wordnum;
  int player;
  uint p;
  byte p_byte;
  
  /* MATCH: ONE u_int `p` (a separate `byte p_byte` + `(uint)` copy emits two dead
     `andi ..,255` promotions the oracle has none of) and a BLOCK-LOCAL `dlg`
     declared AFTER the y_off select -- the oracle materializes `addiu v0,s2,928`
     there, in a caller-saved reg, and reaches all three header fields by
     displacement (124/126/100) instead of the absolute 1028/1052/1054. */
  p = FEApp->fPlayer;
  y_off = 0x3c;
  if (p == 0) {
    y_off = -0x3c;
  }
  tDialogBackUpOnly *dlg = &this->CarDialog;
  dlg->OffsetX = 0;
  dlg->OffsetY = y_off;
  dlg->specificPlayer = (ushort)p;
  /* MATCH: the Hide+return block is OUT OF LINE -- the oracle's `bnez fExitingScreen`
     branches TO it and it sits physically right after the switch dispatch (`jr v0`),
     i.e. it IS the first case body.  Keeping it inline as the if-body flips the
     branch polarity and costs the `j T; nop` skip pair. */
  if (((PinkSlipsScreenState[0] != CardLoadedFine) && (p == 1)) || (this->fExitingScreen != 0)) {
    goto switchD_8003f3b4_caseD_7;
  }
  if (PinkSlipsScreenState[p] != NoCardInserted) {
    this->fStartCheckTick = 0;
  }
  /* MATCH: CASE BODIES IN ORACLE VA ORDER (wave-10 law).  The jump table is keyed
     by case VALUE, but the BODIES are emitted in source order -- retail lays them
     out CardLoadedFine, NoCardInserted, NotFound(0x2af), Unformatted(0x2b1),
     CardFailed(0x2ad, falls through into the shared TextSys_Word/Display tail),
     then NotEnough/TooMany.  Ghidra's value order costs ~60 diffs of pure block
     motion. */
  switch(PinkSlipsScreenState[p]) {
  case WhoCaresWeBeExiting:
switchD_8003f3b4_caseD_7:
    Hide((tDialogBase *)&this->CarDialog);
    return;
  case CardLoadedFine:
    if ((FEApp->waitingForOtherPlayer[p] == 0) && (PinkSlipsScreenState[1 - p] == CardLoadedFine)) {
      Hide((tDialogBase *)&this->CarDialog);
      this->fStartCheckTick = 0;
      goto SetDlg_cardOkReturn;
    }
    str2 = TextSys_Word(0x2a8);
    str = PlayerName(1 - p);
    sprintf("",str2,str);
    this->CarDialog.string = "";
    goto SetDlg_displayAndReset;
  case NoCardInserted:
    if (this->fCardFailed == 0) {
      if (this->fStartCheckTick == 0) {
        this->fStartCheckTick = ticks[0];
      }
      iVar3 = p + 0x2ab;
      if (799 < ticks[0] - this->fStartCheckTick) {
        iVar3 = p + 0x2a9;
      }
      str2 = TextSys_Word(iVar3);
      this->CarDialog.string = str2;
      Display((tDialogBase *)&this->CarDialog);
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
    iVar3 = p + 0x2af;
    break;
  case CardFailedUnformatted:
    iVar3 = p + 0x2b1;
    break;
  case CardFailed:
    iVar3 = p + 0x2ad;
    break;
  case NotEnoughCars:
    wordnum = p + 0x32d;
    goto SetDlg_loadingWord;
  case TooManyCars:
    wordnum = p + 0x32f;
    goto SetDlg_loadingWord;
  case CardCurrentlyLoading:
    wordnum = p + 0x280;
SetDlg_loadingWord:
    str2 = TextSys_Word(wordnum);
    this->CarDialog.string = str2;
SetDlg_displayAndReset:
    Display((tDialogBase *)&this->CarDialog);
    this->fStartCheckTick = 0;
SetDlg_cardOkReturn:
    this->fCardFailed = 0;
    return;
  default:
    goto switchD_8003f3b4_default;
  }
  str2 = TextSys_Word(iVar3);
  this->CarDialog.string = str2;
  Display((tDialogBase *)&this->CarDialog);
  this->fCardFailed = 1;
  this->fStartCheckTick = 0;
switchD_8003f3b4_default:
  return;
}



/* ---- tScreenPinkSlipsCarSelect::ProcessInput  [SCREENCARSELECT.CPP:2190-2200] ---- */
int tScreenPinkSlipsCarSelect::ProcessInput(tPlayer keyval,tInputKeyType &key_input,
              tMenuCommand &menu_cmd)

{
  if (key_input != kInput_KeyType_Triangle) {
    if ((key_input != kInput_KeyType_Circle) &&
       ((PinkSlipsScreenState[0] != CardLoadedFine || (PinkSlipsScreenState[1] != CardLoadedFine))))
    {
      key_input = kInput_KeyType_AlreadyProcessed;
    }
    if (key_input != kInput_KeyType_Triangle) {
      return 0x10;
    }
  }
  if ((PinkSlipsScreenState[0] != CardLoadedFine) ||
     (PinkSlipsScreenState[1] != CardLoadedFine)) {
    this->fExitingScreen = 1;
    PinkSlipsScreenState[0] = WhoCaresWeBeExiting;
    PinkSlipsScreenState[1] = WhoCaresWeBeExiting;
    Hide((tDialogBase *)&this->CarDialog);
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
  GetStockCar(&carManager, 0,&carInfo);
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
 * as ___23tScreenControllerConfig. Byte-identical to the prior compiler-generated PASS. */
#if defined(__mips__)
__asm__(
    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"
    "\t.set noreorder\n"
    "\t.globl ___25tScreenCarSelectTwoPlayer\n"
    "___25tScreenCarSelectTwoPlayer:\n"
    "\taddiu $sp, $sp, -32\n"
    "\tsw    $s0, 16($sp)\n"
    "\taddu  $s0, $a0, $zero\n"
    "\tsw    $s1, 20($sp)\n"
    "\taddu  $s1, $a1, $zero\n"
    "\taddiu $a0, $s0, 928\n"      /* &this->CarDialog (+0x3A0) */
    "\tsw    $ra, 24($sp)\n"
    "\tjal   ___7tScreen\n"
    "\t addiu $a1, $zero, 2\n"      /* delay slot: member sub-object, not in charge */
    "\taddu  $a0, $s0, $zero\n"
    "\tjal   ___16tScreenCarSelect\n"   /* base (past tScreenCarSelect) */
    "\t addu  $a1, $s1, $zero\n"    /* delay slot: forward the original in_chrg */
    "\tlw    $ra, 24($sp)\n"
    "\tlw    $s1, 20($sp)\n"
    "\tlw    $s0, 16($sp)\n"
    "\tjr    $ra\n"
    "\t addiu $sp, $sp, 32\n"
    "\t.set pop\n"
    "\t.set\treorder\n"  /* maspsx tracks .set linearly (no push/pop): restore nop-insertion for the rest of the file (gcc2.8 HOISTS toplevel asm above all fns) */

    "\t.set push\n"
    "\t.set noat\n"
    "\t.set\tnoreorder\n"
    "\t.set noreorder\n"
    "\t.globl ___25tScreenPinkSlipsCarSelect\n"
    "___25tScreenPinkSlipsCarSelect:\n"
    "\taddiu $sp, $sp, -32\n"
    "\tsw    $s0, 16($sp)\n"
    "\taddu  $s0, $a0, $zero\n"
    "\tsw    $s1, 20($sp)\n"
    "\taddu  $s1, $a1, $zero\n"
    "\taddiu $a0, $s0, 928\n"      /* &this->CarDialog (inherited, +0x3A0) */
    "\tsw    $ra, 24($sp)\n"
    "\tjal   ___7tScreen\n"
    "\t addiu $a1, $zero, 2\n"      /* delay slot */
    "\taddu  $a0, $s0, $zero\n"
    "\tjal   ___16tScreenCarSelect\n"
    "\t addu  $a1, $s1, $zero\n"    /* delay slot: forward the original in_chrg */
    "\tlw    $ra, 24($sp)\n"
    "\tlw    $s1, 20($sp)\n"
    "\tlw    $s0, 16($sp)\n"
    "\tjr    $ra\n"
    "\t addiu $sp, $sp, 32\n"
    "\t.set pop\n"
    "\t.set\treorder\n"  /* maspsx tracks .set linearly (no push/pop): restore nop-insertion for the rest of the file (gcc2.8 HOISTS toplevel asm above all fns) */);
#endif



/* ---- tScreenCarSelectDuel::dtor  [SCREENCARSELECT.CPP:285-2230] ---- */
tScreenCarSelectDuel::~tScreenCarSelectDuel()

{
  /* retail dtor is empty -- only the implicit base ~tScreenCarSelect runs */
  return;
}



/* end of screencarselect.cpp */
