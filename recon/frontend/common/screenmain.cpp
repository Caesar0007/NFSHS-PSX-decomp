/* frontend/common/screenmain.cpp -- RECONSTRUCTED (main/top-level menu screen; C++ TU)
 *   single class tScreenMain : tScreen ; 13 fns (no ctor in this TU).
 *   Phantoms (warning-image DrawShapeExtended/ScaleShapeExtended coords, dot-grid numberValues
 *   bitmap + x-walker, tvOrder/animLocations/tintColors statics, gNameBuffer/gPermBuffer sprintf
 *   dsts, void ProcessInput) resolved via m2c oracle + binary static reads.
 */
#include "screenmain.h"

/* ---- ScreenMain.obj-OWNED globals -- DEFINED here (self-contained; real NFS4.EXE bytes;
   videoWallConfigs[].videos = SYMBOL-REF ptrs to the tVideo globals, not absolute addresses) ---- */
tVideo       video11a = {0, 0, 1, 1, 1, 1, 0, 0};   /* @0x80051b78 */
tVideo       video11b = {1, 0, 1, 1, 1, 1, 0, 0};   /* @0x80051b80 */
tVideo       video11c = {2, 0, 1, 1, 1, 1, 0, 0};   /* @0x80051b88 */
tVideo       video11d = {3, 0, 1, 1, 1, 1, 0, 0};   /* @0x80051b90 */
tVideo       video11e = {0, 1, 1, 1, 1, 1, 0, 0};   /* @0x80051b98 */
tVideo       video11h = {3, 1, 1, 1, 1, 1, 0, 0};   /* @0x80051ba0 */
tVideo       video11i = {0, 2, 1, 1, 1, 1, 0, 0};   /* @0x80051ba8 */
tVideo       video11l = {3, 2, 1, 1, 1, 1, 0, 0};   /* @0x80051bb0 */
tVideo       video11m = {0, 3, 1, 1, 1, 1, 0, 0};   /* @0x80051bb8 */
tVideo       video11n = {1, 3, 1, 1, 1, 1, 0, 0};   /* @0x80051bc0 */
tVideo       video11o = {2, 3, 1, 1, 1, 1, 0, 0};   /* @0x80051bc8 */
tVideo       video11p = {3, 3, 1, 1, 1, 1, 0, 0};   /* @0x80051bd0 */
tVideo       video21a = {0, 0, 2, 1, 1, 1, 0, 0};   /* @0x80051bd8 */
tVideo       video21c = {2, 0, 2, 1, 1, 1, 0, 0};   /* @0x80051be0 */
tVideo       video21j = {0, 3, 2, 1, 1, 1, 0, 0};   /* @0x80051be8 */
tVideo       video21l = {2, 3, 2, 1, 1, 1, 0, 0};   /* @0x80051bf0 */
tVideo       video31a = {0, 0, 3, 1, 1, 1, 0, 0};   /* @0x80051bf8 */
tVideo       video31b = {1, 0, 3, 1, 1, 1, 0, 0};   /* @0x80051c00 */
tVideo       video31g = {0, 3, 3, 1, 1, 1, 0, 0};   /* @0x80051c08 */
tVideo       video31h = {1, 3, 3, 1, 1, 1, 0, 0};   /* @0x80051c10 */
tVideo       video22a = {0, 0, 2, 2, 1, 1, 0, 0};   /* @0x80051c18 */
tVideo       video22b = {1, 0, 2, 2, 1, 1, 0, 0};   /* @0x80051c20 */
tVideo       video22c = {2, 0, 2, 2, 1, 1, 0, 0};   /* @0x80051c28 */
tVideo       video22d = {0, 1, 2, 2, 1, 1, 0, 0};   /* @0x80051c30 */
tVideo       video22f = {2, 1, 2, 2, 1, 1, 0, 0};   /* @0x80051c38 */
tVideo       video22g = {0, 2, 2, 2, 1, 1, 0, 0};   /* @0x80051c40 */
tVideo       video22h = {1, 2, 2, 2, 1, 1, 0, 0};   /* @0x80051c48 */
tVideo       video22i = {2, 2, 2, 2, 1, 1, 0, 0};   /* @0x80051c50 */
tVideo       video32a = {0, 0, 3, 2, 1, 1, 0, 0};   /* @0x80051c58 */
tVideo       video32b = {1, 0, 3, 2, 1, 1, 0, 0};   /* @0x80051c60 */
tVideo       video32e = {0, 2, 3, 2, 1, 1, 0, 0};   /* @0x80051c68 */
tVideo       video32f = {1, 2, 3, 2, 1, 1, 0, 0};   /* @0x80051c70 */
tVideoWallConfig videoWallConfigs[24] = {
  {2, 0, {&video32a, &video21l, 0, 0}},
  {2, 0, {&video32b, &video21j, 0, 0}},
  {2, 0, {&video32e, &video21c, 0, 0}},
  {2, 0, {&video32f, &video21a, 0, 0}},
  {3, 0, {&video22a, &video11l, &video11p, 0}},
  {3, 0, {&video22c, &video11i, &video11m, 0}},
  {3, 0, {&video22g, &video11d, &video11h, 0}},
  {3, 0, {&video22i, &video11a, &video11e, 0}},
  {3, 0, {&video11b, &video21c, &video22h, 0}},
  {3, 0, {&video11c, &video21a, &video22h, 0}},
  {3, 0, {&video11n, &video21l, &video22b, 0}},
  {3, 0, {&video11o, &video21j, &video22b, 0}},
  {3, 0, {&video11d, &video22d, &video21j, 0}},
  {3, 0, {&video11a, &video22f, &video21l, 0}},
  {3, 0, {&video11p, &video22d, &video21a, 0}},
  {3, 0, {&video11m, &video22f, &video21c, 0}},
  {3, 0, {&video22d, &video11d, &video11p, 0}},
  {3, 0, {&video22f, &video11a, &video11m, 0}},
  {3, 0, {&video22b, &video11m, &video11p, 0}},
  {3, 0, {&video22h, &video11a, &video11d, 0}},
  {3, 0, {&video22a, &video31h, &video11m, 0}},
  {3, 0, {&video22c, &video31g, &video11p, 0}},
  {3, 0, {&video22i, &video31a, &video11d, 0}},
  {3, 0, {&video22g, &video31b, &video11a, 0}}
};   /* @0x80051c78 symbol-ref ptrs */


/* ---- tScreenMain::SwapBackground  [SCREENMAIN.CPP:218-265] ---- */
void tScreenMain::SwapBackground(int num)

{
  tScreenMainState oldState;
  int iVar1;
  tScreenMainState tVar2;
  char buffer [8];
  
  oldState = this->hVideo;
  VIDEO_abortplayback(oldState);
  iVar1 = this->fCurrentSlot;
  this->bVideoAborted = 1;
  if ((((this->fVideoShapes[iVar1].async_handle == 0) &&
       (this->fVideoShapes[iVar1].fFile == (char *)0x0)) &&
      (this->fVideoShapes[1 - iVar1].async_handle == 0)) &&
     (this->fVideoShapes[1 - iVar1].fFile == 0)) {
    if (num == -1) {
      do {
        iVar1 = rand();
        this->fCurrentBG[this->fCurrentSlot] = iVar1 % 0x1c;
      } while (this->fCurrentBG[this->fCurrentSlot] ==
               this->fCurrentBG[1 - this->fCurrentSlot]);
    }
    else {
      this->fCurrentBG[iVar1] = num;
    }
    sprintf(buffer,"zyVid%02d",this->fCurrentBG[this->fCurrentSlot]);
    ::AsyncLoadShapeFile((tScreen *)this,buffer,this->fVideoShapes + this->fCurrentSlot);
    tVar2 = this->fState;
    this->fState = kScreenMain_Off;
    this->fCurrentSlot = 1 - this->fCurrentSlot;
    if (tVar2 == kScreenMain_WarningImage) {
      tVar2 = kScreenMain_WarningImage;
    }
    else {
      tVar2 = kScreenMain_StaticImage;
    }
    this->SetState(tVar2);
    this->fNumTVsInTransition = 0x10;
  }
  return;
}



/* ---- tScreenMain::DoneLoadingBackground  [SCREENMAIN.CPP:270-276] ---- */
int tScreenMain::DoneLoadingBackground()

{
  int result;
  int iVar2;
  
  iVar2 = this->fCurrentSlot;
  result = 0;
  if ((this->fVideoShapes[iVar2].async_handle == 0) &&
     (result = 0, this->fVideoShapes[iVar2].fFile == (char *)0x0)) {
    result = 0;
    if ((this->fVideoShapes[1 - iVar2].async_handle == 0) &&
       (result = 1, this->fVideoShapes[1 - iVar2].fFile != 0)) {
      result = 0;
    }
  }
  return result;
}



/* ---- tScreenMain::SetState  [SCREENMAIN.CPP:280-342] ---- */
void tScreenMain::SetState(tScreenMainState state)

{
  ushort uVar1;
  uint uVar2;
  short sVar3;
  int iVar4;
  tScreenMainState tVar5;
  tTexture_ShapeInfo *shape;
  short i;
  int iVar7;
  
  if (state != this->fState) {
    VIDEO_abortplayback(this->hVideo);
    iVar4 = ticks;
    this->bVideoAborted = 1;
    this->fMovieTicks = iVar4;
    if ((state != kScreenMain_Credits) && (CreditManager.fCreditsInitialized == 1)) {
      DeInit(&CreditManager);
    }
    iVar4 = ticks;
    iVar7 = 0;
    this->fState = state;
    this->fStartTicks = iVar4;
    do {
      sVar3 = (short)iVar7;
      shape = this->fVideoShapes[this->fCurrentSlot].fShapes;
      this->tvTransitions[sVar3].state = kScreenMain_StaticImage;
      uVar2 = (uint)(byte)shape[sVar3].depth;
      iVar4 = ((int)shape[sVar3].shapex - (int)(short)(shape[sVar3].shapex & 0xffc0)) * 0x10;
      this->tvTransitions[sVar3].u = (uchar)(iVar4 / (int)uVar2);
      this->tvTransitions[sVar3].v = (uchar)shape[sVar3].shapey;
      this->tvTransitions[sVar3].uw = (uchar)shape[sVar3].width;
      this->tvTransitions[sVar3].vh = (uchar)shape[sVar3].height;
      this->tvTransitions[sVar3].tpage =
           ((u_char)*((u_char*)&shape[sVar3] + 9) & 3) << 7 | (short)(shape[sVar3].shapey & 0x100U) >> 4 |
           (ushort)(((ushort)shape[sVar3].shapex & 0x3c0) >> 6) |
           (shape[sVar3].shapey & 0x200U) << 2;
      uVar1 = GetClut((shape[sVar3].clutID & 0x3fU) << 4,shape[sVar3].clutID >> 6);
      iVar7 = iVar7 + 1;
      this->tvTransitions[sVar3].clut = uVar1;
      this->tvTransitions[sVar3].flags = 0;
      this->tvTransitions[sVar3].tint = 0x808080;
      this->tvTransitions[sVar3].bright = 0x80;
    } while (iVar7 * 0x10000 >> 0x10 < 0x10);
    tVar5 = this->fState;
    if (tVar5 == kScreenMain_WarningImage) {
      iVar4 = 4;
      do {
        sVar3 = (short)iVar4;
        iVar4 = iVar4 + 1;
        this->tvTransitions[sVar3].bright = 0x80;
        this->tvTransitions[sVar3].state = kScreenMain_WarningImage;
      } while (iVar4 * 0x10000 >> 0x10 < 0xc);
      this->tvTransitions[6].bright = 0x80;
      this->tvTransitions[5].bright = 0x80;
    }
    else if ((int)tVar5 < 4) {
      if (tVar5 == kScreenMain_DynamicImage) {
        this->InitDynamicImages();
      }
    }
    else {
      iVar4 = 0;
      if (tVar5 == kScreenMain_Credits) {
        do {
          sVar3 = (short)iVar4;
          iVar4 = iVar4 + 1;
          this->tvTransitions[sVar3].bright = 0x80;
          this->tvTransitions[sVar3].state = kScreenMain_Credits;
        } while (iVar4 * 0x10000 >> 0x10 < 0x10);
        Init(&CreditManager,this->fStartTicks);
      }
    }
  }
  return;
}



/* ---- tScreenMain::InitDynamicImages  [SCREENMAIN.CPP:348-402] ---- */
void tScreenMain::InitDynamicImages()

{
  byte bVar1;
  byte bVar2;
  ushort uVar3;
  int index;
  int iVar4;
  int iVar5;
  int xOffset, yOffset;
  uint uVar6;
  int startX;
  int i;
  int iVar7;
  int startY;
  tVideo *video;
  tVideo *video2;
  int x;
  int iVar9;
  int y;
  int iVar10;
  int k;
  int iVar11;
  int j;
  int iVar12;
  int videoWallConfig;
  
  iVar4 = rand();
  iVar4 = iVar4 % 0x18;
  iVar7 = 0;
  if (0 < videoWallConfigs[iVar4].numVideos) {
    do {
      video2 = videoWallConfigs[iVar4].videos[iVar7];
      bVar1 = video2->x;
      bVar2 = video2->y;
      iVar12 = 0;
      if (video2->tileWidth != '\0') {
        do {
          iVar11 = 0;
          if (video2->tileHeight != '\0') {
            do {
              iVar10 = 0;
              if (video2->height != '\0') {
                do {
                  uVar6 = (uint)(byte)video2->width;
                  iVar9 = 0;
                  if (uVar6 != 0) {
                    do {
                      iVar5 = (iVar10 + (uint)bVar2 + iVar11 * (uint)(byte)video2->height) * 4 +
                              iVar9 + (uint)bVar1 + iVar12 * uVar6;
                      this->tvTransitions[iVar5].u = (char)iVar9 * (char)(0x50 / uVar6);
                      this->tvTransitions[iVar5].v =
                           (char)iVar10 * (char)(0x50 / (byte)video2->height);
                      this->tvTransitions[iVar5].uw = (char)(0x50 / (byte)video2->width) + 0xff;
                      this->tvTransitions[iVar5].vh = (uchar)(0x50 / (byte)video2->height);
                      uVar3 = GetTPage(2,0,0x200,0);
                      this->tvTransitions[iVar5].tpage = uVar3;
                      this->tvTransitions[iVar5].clut = 0;
                      this->tvTransitions[iVar5].flags = 0x22;
                      iVar9 = iVar9 + 1;
                      uVar6 = tintColors[this->fCurrentBG[this->fCurrentSlot]];
                      this->tvTransitions[iVar5].state = kScreenMain_DynamicImage;
                      this->tvTransitions[iVar5].bright = 0x80;
                      this->tvTransitions[iVar5].tint = uVar6;
                      uVar6 = (uint)(byte)video2->width;
                    } while (iVar9 < (int)uVar6);
                  }
                  iVar10 = iVar10 + 1;
                } while (iVar10 < (int)(uint)(byte)video2->height);
              }
              iVar11 = iVar11 + 1;
            } while (iVar11 < (int)(uint)(byte)video2->tileHeight);
          }
          iVar12 = iVar12 + 1;
        } while (iVar12 < (int)(uint)(byte)video2->tileWidth);
      }
      iVar7 = iVar7 + 1;
    } while (iVar7 < videoWallConfigs[iVar4].numVideos);
  }
  return;
}



/* ---- tScreenMain::ProcessInput  [SCREENMAIN.CPP:406-412] ---- */
void tScreenMain::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command)

{
  
  if ((keyval == kInput_KeyType_Triangle) && (0 < FEApp->backDepth[0])) {
    this->SwapBackground(-1);
    if ((tMenuNFS4 *)FEApp->fCurrentMenu[0] == &menuDefs->menuPinkSlipSelect) {
      frontEnd.raceType = '\0';
    }
  }
  return;
}



/* ---- tScreenMain::DrawDropShadow  [SCREENMAIN.CPP:417-437] ---- */
void tScreenMain::DrawDropShadow()

{
  int addr_24;
  int src_walk;
  int i;
  u_char *pal_link;
  void *tp1;
  u_char *prim;
  
  i = 0;
  src_walk = (int)dropShadow;
  do {
    prim = Render_gPacketPtr;
    pal_link = Render_gPalettePtr;
    *(uint *)Render_gPacketPtr =
         *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
    addr_24 = (uint)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x24;
    *(uint *)pal_link = *(uint *)pal_link & 0xff000000 | addr_24;
    *(u_int *)(prim + 4) = 0x808080;
    prim[7] = 0x3a;
    *(u_int *)(prim + 0xc) = 0x808080;
    *(u_int *)(prim + 0x1c) = 0;
    *(u_int *)(prim + 0x14) = 0;
    prim[3] = 8;
    *(u_short *)(prim + 8) = *(u_short *)src_walk;
    *(u_short *)(prim + 10) = *(u_short *)(src_walk + 2);
    *(u_short *)(prim + 0x10) = *(u_short *)(src_walk + 4);
    *(u_short *)(prim + 0x12) = *(u_short *)(src_walk + 6);
    *(u_short *)(prim + 0x18) = *(u_short *)(src_walk + 8);
    *(u_short *)(prim + 0x1a) = *(u_short *)(src_walk + 10);
    i = i + 1;
    *(u_short *)(prim + 0x20) = *(u_short *)(src_walk + 0xc);
    *(u_short *)(prim + 0x22) = *(u_short *)(src_walk + 0xe);
    src_walk = src_walk + 0x10;
  } while (i < 4);
  FeDraw_SetABRMode(2);
  return;
}



/* ---- tScreenMain::DrawVideoLines  [SCREENMAIN.CPP:441-452] ---- */
void tScreenMain::DrawVideoLines()

{
  int i;
  
  i = 0xf3;
  do {
    PSXDrawTransSquare(0x303030,i,0x2a,2,0xa9,1);
    i = i + 0x50;
  } while (i < 0x1e3);
  i = 0x54;
  do {
    PSXDrawTransSquare(0x202020,0xa3,i,0x141,1,1);
    i = i + 0x2a;
  } while (i < 0xd2);
  FeDraw_SetABRMode(2);
  return;
}



/* ---- tScreenMain::DrawBackground  [SCREENMAIN.CPP:456-737] ---- */
void tScreenMain::DrawBackground()

{
  byte bVar1;
  bool bVar2;
  short sVar3;
  int fade;
  char *str;
  int iVar5;
  uint uVar6;
  int iVar7;
  tScreenMainState tVar8;
  uint uVar9;
  u_long deltaTicks;
  byte bAllTVsOn;
  int drawAnimFade;
  int TextCol, shapeX, shapeY;
  int iVar10;
  short x;
  short i;
  short y;
  short animFade, j;
  short sVar11;
  tDrawShapeExtended drawFlags;
  char buffer [32];
  RECT r;
  char moviename [80];
  
  sVar11 = 0;
  for (sVar3 = 0; iVar7 = (int)sVar3, iVar7 < 2; sVar3 = sVar3 + 1) {
    ::IsShapeFileLoaded((tScreen *)this,this->fVideoShapes + iVar7);
    bVar2 = true;
    if (this->fVideoShapes[iVar7].fFile != (char *)0x0) {
      iVar10 = 0;
      iVar7 = 0;
      do {
        iVar7 = iVar7 >> 0x10;
        tVar8 = this->tvStates[iVar7];
        if ((tVar8 == kScreenMain_StaticImage) || (tVar8 == kScreenMain_Credits)) {
          if ((this->tvTransitions[iVar7].state != tVar8) ||
             (this->tvConfigs[iVar7].clut != this->tvTransitions[iVar7].clut))
          goto DrawBg_innerFalse;
        }
        else {
DrawBg_innerFalse:
          bVar2 = false;
        }
        iVar10 = iVar10 + 1;
        iVar7 = iVar10 * 0x10000;
      } while (iVar10 * 0x10000 >> 0x10 < 0x10);
      if (bVar2) {
        ::UploadShapes((tScreen *)this,this->fVideoShapes + sVar3,sVar3 * 0xa6,0,0x10,0);
      }
    }
  }
  if ((this->fState == kScreenMain_Credits) &&
     (FEApp->fCurrentMenu[0] != (tMenu *)&menuDefs->menuCredits)) {
    tVar8 = kScreenMain_StaticImage;
DrawBg_setStateCall:
    this->SetState(tVar8);
  }
  else if (FEApp->fCurrentMenu[0] == (tMenu *)&menuDefs->menuCredits) {
    tVar8 = kScreenMain_Credits;
    goto DrawBg_setStateCall;
  }
  ::Draw(&CreditManager,this->fState == kScreenMain_Credits);
  if (this->fState == kScreenMain_WarningImage) {
    if ((frontEnd.raceType != '\x06') &&
       ((tMenuItemGoToMenuNFS4Button *)
        FEApp->fCurrentMenu[0]->fItemList[FEApp->fCurrentMenu[0]->fCurrentItem] !=
        &menuDefs->itemTwoPlayerPinkSlips)) {
      tVar8 = kScreenMain_StaticImage;
DrawBg_setStaticImage:
      this->SetState(tVar8);
    }
  }
  else if ((frontEnd.raceType == '\x06') ||
          ((tMenuItemGoToMenuNFS4Button *)
           FEApp->fCurrentMenu[0]->fItemList[FEApp->fCurrentMenu[0]->fCurrentItem] ==
           &menuDefs->itemTwoPlayerPinkSlips)) {
    tVar8 = kScreenMain_WarningImage;
    goto DrawBg_setStaticImage;
  }
  if (this->fState == kScreenMain_WarningImage) {
    if (this->fWarningFade < 0x60) {
      this->fWarningFade = this->fWarningFade + 4;
    }
DrawBg_tvConfigsLoop:
    iVar7 = 4;
    do {
      sVar3 = (short)iVar7;
      iVar7 = iVar7 + 1;
      this->tvConfigs[sVar3].flags = this->tvConfigs[sVar3].flags | 2;
      uVar9 = 0x80 - (int)this->fWarningFade;
      this->tvConfigs[sVar3].tint = uVar9 * 0x10000 | uVar9 * 0x100 | uVar9;
    } while (iVar7 * 0x10000 >> 0x10 < 0xc);
    uVar9 = 0x80 - ((int)this->fWarningFade << 6) / 0x60;
    uVar9 = uVar9 * 0x10000 | uVar9 * 0x100 | uVar9;
    this->tvConfigs[6].tint = uVar9;
    this->tvConfigs[5].tint = uVar9;
    drawFlags.tint[0] = 0xbebe;
    DrawShapeExtended((gettick() / 0xf) % 10 + 0x101,0x411,0xa3,-0xf,0x60 - this->fWarningFade
               ,1,&drawFlags);
    DrawShapeExtended((gettick() / 0xf) % 10 + 0x101,0x415,0x193,-0xf,0x60 - this->fWarningFade
               ,1,&drawFlags);
    DrawShapeExtended(0x100,0x11,0,0,0x60 - this->fWarningFade
               ,1,&drawFlags);
    iVar7 = 0;
    ScaleShapeExtended((gettick() / 0x15) % 6 + 0xfa,1,0,0,0x60 - this->fWarningFade
               ,3,(tDrawShapeExtended *)0x0);
    FETextRender_SetABR(1,true);
    iVar7 = CalcFadeVal(0xbebe,0x60 - this->fWarningFade);
    r.x = 0xb5;
    r.y = 0x81;
    r.w = 0x11c;
    r.h = 0x2a;
    str = TextSys_Word(0x272);
    FETextRender_WordWrapTextRGB(str,r,iVar7);
    iVar7 = 0;
    FETextRender_SetABR(0,false);
    FeDraw_SetABRMode(iVar7);
  }
  else if (0 < this->fWarningFade) {
    this->fWarningFade = this->fWarningFade + -4;
    goto DrawBg_tvConfigsLoop;
  }
  iVar7 = 0;
  if ((this->fFrame & 1U) == 0) {
    iVar7 = 0x50;
  }
  iVar5 = VIDEO_state(this->hVideo);
  iVar10 = ticks;
  if (iVar5 == 3) {
    this->bVideoAborted = 0;
    this->fMovieTicks = iVar10;
    iVar7 = VIDEO_updateframexy(this->hVideo,0x200,iVar7);
    if (iVar7 != 0) {
      this->fFrame = this->fFrame + 1;
    }
  }
  else {
    bVar2 = false;
    iVar7 = VIDEO_state(this->hVideo);
    if (iVar7 != 1) {
      bVar2 = 0x280 < ticks - this->fStartTicks;
    }
    if ((bVar2) && (this->fState == kScreenMain_StaticImage)) {
      r.x = 0x200;
      r.w = 0x50;
      r.y = 0;
      r.h = 0xa0;
      ClearImage(&r,'\0','\0','\0');
      DrawSync(0);
      do {
        iVar7 = rand();
        sVar3 = (short)(iVar7 % 0x14);
        this->fCurrentMovie = sVar3;
      } while ((iVar7 % 0x14) * 0x10000 >> 0x10 == (int)this->fPreviousMovie);
      this->fPreviousMovie = sVar3;
      this->SetState(kScreenMain_DynamicImage);
      sprintf(moviename,"%szzzVD%02d.dct",Paths_Paths[0x29],(int)this->fCurrentMovie);
      VIDEO_spoolfile(this->hVideo,moviename);
      VIDEO_startplayback(this->hVideo);
    }
  }
  if ((this->fState == kScreenMain_DynamicImage) &&
     (iVar7 = VIDEO_state(this->hVideo), iVar7 == 0)) {
    this->SetState(kScreenMain_StaticImage);
  }
  ::DrawBackgroundImage((tScreen *)this,2,0x1c,this->fPermShapes.fShapes,0);
  this->DrawDropShadow();
  this->DrawVideoLines();
  deltaTicks = ticks - this->fAnimTicks;
  if ((0x5dc < deltaTicks) && (this->fState != kScreenMain_WarningImage)) {
    uVar6 = this->fSwapShapes.async_handle;
    deltaTicks = 0;
    this->fAnimationUploaded = 0;
    if (uVar6 == 0) {
      do {
        iVar7 = rand();
        str = (char *)((iVar7 % 0x19) * 0x10000 >> 0x10);
      } while (str == (char *)(int)this->fPreviousAnim);
      this->fPreviousAnim = (short)(iVar7 % 0x19);
      sprintf(buffer,"yVda%02d",(int)this->fPreviousAnim);
      ::AsyncLoadSwapShapeFile((tScreen *)this,buffer);
    }
  }
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  if (this->fSwapShapes.fFile != (char *)0x0) {
    this->fSwapShapes.fNumShapes = 10;
    ::UploadSwapShapes((tScreen *)this,10);
    this->fAnimTicks = ticks;
    this->fAnimationUploaded = 1;
    this->fAnimLocation = (ushort)this->fAnimTicks & 3;
  }
  if (deltaTicks < 0x80) {
    uVar6 = deltaTicks * 0x1ffffff + 0x80;
  }
  else {
    uVar6 = deltaTicks - 0x2a0;
    if (0x7f < uVar6) goto DrawBg_emitShape;
  }
  sVar11 = (short)uVar6;
DrawBg_emitShape:
  if ((deltaTicks < 800) && (this->fAnimationUploaded != 0)) {
    drawFlags.tint[0] = tintColors[this->fCurrentBG[this->fCurrentSlot]];
    drawFlags.custom_shapes = this->fSwapShapes.fShapes;
    iVar7 = (int)sVar11;
    if ((CreditManager.fCreditsInitialized != 0) && (iVar7 = iVar7 + 0x40, 0x80 < iVar7)) {
      iVar7 = 0x80;
    }
    shapeX = animLocations[this->fAnimLocation].x;
    shapeY = animLocations[this->fAnimLocation].y;
    DrawShapeExtended((deltaTicks / 0xf) % 10,0x611,shapeX,shapeY,iVar7,1,&drawFlags);
  }
  sVar3 = 0;
  for (sVar11 = 0x32; (sVar3 < 0x19 && (sVar11 < 0xd2)); sVar11 = sVar11 + 8) {
    x = 0x1a2;
    iVar10 = 4;
    iVar7 = 0x40000;
    while (-1 < iVar7 >> 0x10) {
      iVar10 = iVar10 + -1;
      DrawShapeExtended((numberValues[(sVar3 + ticks / 0x14) % 0x19] >> (iVar7 >> 0x10)) & 1,1,x,sVar11,0x40,3,
                 (tDrawShapeExtended *)0x0);
      x = x + 0xd;
      iVar7 = iVar10 * 0x10000;
    }
    sVar3 = sVar3 + 1;
  }
  iVar10 = (int)((ticks - this->fStartTicks) * 0x1000) >> 0x10;
  iVar7 = 0;
  if (-1 < iVar10) {
    iVar5 = 0;
    do {
      if (0xf < iVar5 >> 0x10) break;
      bVar1 = tvOrder[iVar5 >> 0x10];
      if (((this->tvStates[bVar1] != this->tvTransitions[bVar1].state) ||
          (this->tvConfigs[bVar1].clut != this->tvTransitions[bVar1].clut)) &&
         (this->tvConfigs[bVar1].state == tv_StateOn)) {
        TurnOffTV(this->tvConfigs + bVar1);
      }
      iVar7 = iVar7 + 1;
      iVar5 = iVar7 * 0x10000;
    } while (iVar7 * 0x10000 >> 0x10 <= iVar10);
  }
  iVar10 = 0;
  iVar7 = 0;
  do {
    iVar7 = iVar7 >> 0x10;
    if (this->tvConfigs[iVar7].state == tv_StateOff) {
      this->tvConfigs[iVar7].u = this->tvTransitions[iVar7].u;
      this->tvConfigs[iVar7].v = this->tvTransitions[iVar7].v;
      this->tvConfigs[iVar7].uw = this->tvTransitions[iVar7].uw;
      this->tvConfigs[iVar7].vh = this->tvTransitions[iVar7].vh;
      this->tvConfigs[iVar7].tpage = this->tvTransitions[iVar7].tpage;
      this->tvConfigs[iVar7].clut = this->tvTransitions[iVar7].clut;
      this->tvConfigs[iVar7].flags = this->tvTransitions[iVar7].flags;
      this->tvConfigs[iVar7].tint = this->tvTransitions[iVar7].tint;
      this->tvStates[iVar7] = this->tvTransitions[iVar7].state;
      TurnOnTV(this->tvConfigs + iVar7);
      this->tvConfigs[iVar7].destBrightness = this->tvTransitions[iVar7].bright;
      this->fNumTVsInTransition = this->fNumTVsInTransition + -1;
    }
    iVar10 = iVar10 + 1;
    iVar7 = iVar10 * 0x10000;
  } while (iVar10 * 0x10000 >> 0x10 < 0x10);
  iVar10 = 0;
  iVar7 = 0;
  do {
    DrawTV(this->tvConfigs + (iVar7 >> 0x10));
    iVar10 = iVar10 + 1;
    iVar7 = iVar10 * 0x10000;
  } while (iVar10 * 0x10000 >> 0x10 < 0x10);
  iVar7 = 0xf3;
  do {
    PSXDrawSquare(0x404040,(int)(short)iVar7,0x2a,2,0xa9);
    iVar7 = iVar7 + 0x50;
  } while (iVar7 * 0x10000 >> 0x10 < 0x1e3);
  iVar7 = 0x54;
  do {
    PSXDrawSquare(0x303030,0xa3,(int)(short)iVar7,0x141,1);
    iVar7 = iVar7 + 0x2a;
  } while (iVar7 * 0x10000 >> 0x10 < 0xd2);
  return;
}



/* ---- tScreenMain::GetShapeInfo  [SCREENMAIN.CPP:747-754] ---- */
void tScreenMain::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)

{
  numPermShapes = 0x10b;
  *permFileName = gPermBuffer;
  numSwapShapes = 10;
  *swapFileName = gNameBuffer;
  return;
}



/* ---- tScreenMain::PreLoad  [SCREENMAIN.CPP:758-784] ---- */
void tScreenMain::PreLoad()

{
  int rnd;
  int iVar1;
  short i;
  int i_int;
  int local_s2_356;
  char buffer [32];
  
  sprintf(gPermBuffer,"zMain%d",(uint)(byte)frontEnd.language);
  i_int = 0;
  rnd = rand();
  this->fPreviousAnim = (short)(rnd % 0x19);
  sprintf(gNameBuffer,"yVda%02d",(rnd % 0x19) * 0x10000 >> 0x10);
  this->PreLoad();
  iVar1 = 0;
  do {
    this->fVideoShapes[iVar1 >> 0x10].fShapes = (tTexture_ShapeInfo *)0x0;
    ::InitializeShapes((tScreen *)this,this->fVideoShapes + (iVar1 >> 0x10),0x10);
    i_int = i_int + 1;
    iVar1 = i_int * 0x10000;
  } while (i_int * 0x10000 >> 0x10 < 2);
  iVar1 = rand();
  this->fCurrentBG[0] = iVar1 % 0x1c;
  iVar1 = rand();
  local_s2_356 = 0;
  this->fCurrentBG[1] = (this->fCurrentBG[0] + iVar1 % 0x1b + 1) % 0x1c;
  do {
    sprintf(buffer,"zyVid%02d",this->fCurrentBG[(short)local_s2_356]);
    ::AsyncLoadShapeFile((tScreen *)this,buffer,this->fVideoShapes + (short)local_s2_356);
    local_s2_356 = local_s2_356 + 1;
  } while (local_s2_356 * 0x10000 >> 0x10 < 2);
  return;
}



/* ---- tScreenMain::Initialize  [SCREENMAIN.CPP:788-837] ---- */
void tScreenMain::Initialize()

{
  void *loaded;
  void *pv;
  int i;
  int iVar2;
  byte shapesLoaded;
  int scratch;
  int iVar3;
  bool all_loaded;
  
  this->Initialize();
  do {
    FeAudio_systemtask(0);
    loaded = ::IsShapeFileLoaded((tScreen *)this,this->fVideoShapes);
    if (this->fVideoShapes[0].fFile != (char *)0x0) {
      ::UploadShapes((tScreen *)this,this->fVideoShapes,0,0,0x10,0);
    }
    all_loaded = false;
    if (loaded != (void *)0x0) {
      pv = ::IsShapeFileLoaded((tScreen *)this,this->fVideoShapes + 1);
      all_loaded = pv != (void *)0x0;
    }
    if (this->fVideoShapes[1].fFile != (char *)0x0) {
      ::UploadShapes((tScreen *)this,this->fVideoShapes + 1,0xa6,0,0x10,0);
    }
  } while (!all_loaded);
  this->fPreviousMovie = -1;
  this->fFrame = 0;
  i = VIDEO_create(0x50,0x50,0xf0000,0x20000,0x10);
  scratch = 0;
  this->hVideo = i;
  iVar2 = ticks;
  this->bVideoAborted = 0;
  this->fTransitionDirection = '\x01';
  this->fAnimationUploaded = 0;
  this->fWarningFade = 0;
  this->fNumTVsInTransition = 0;
  this->fCurrentSlot = 0;
  this->fStartTicks = iVar2;
  this->fAnimTicks = iVar2 - 800;
  iVar2 = 0;
  do {
    InitTV(this->tvConfigs + (iVar2 >> 0x10),this->fVideoShapes[this->fCurrentSlot].fShapes,
               (short)((uint)iVar2 >> 0x10));
    scratch = scratch + 1;
    iVar2 = scratch * 0x10000;
  } while (scratch * 0x10000 >> 0x10 < 0x10);
  this->fState = kScreenMain_Off;
  this->SetState(kScreenMain_StaticImage);
  iVar3 = 0;
  iVar2 = 0;
  do {
    *(u_int *)((int)this->tvStates + (iVar2 >> 0xe)) = 0;
    iVar3 = iVar3 + 1;
    iVar2 = iVar3 * 0x10000;
  } while (iVar3 * 0x10000 >> 0x10 < 0x10);
  iVar2 = 0;
  do {
    iVar3 = rand();
    numberValues[(short)iVar2] = (char)iVar3;
    iVar2 = iVar2 + 1;
  } while (iVar2 * 0x10000 >> 0x10 < 0x19);
  return;
}



/* ---- tScreenMain::Cleanup  [SCREENMAIN.CPP:841-851] ---- */
void tScreenMain::Cleanup()

{
  int off;
  int i;
  int i_2;
  
  i_2 = 0;
  VIDEO_destroy(this->hVideo);
  off = 0x558;
  purgememadr((void *)this->hVideo);
  do {
    ::FreeShapes((tScreen *)this,
                        (tShapeInformation *)((char *)this + off));
    i_2 = i_2 + 1;
    off = off + 0x28;
  } while (i_2 < 2);
  this->Cleanup();
  return;
}



/* ---- tScreenMain::dtor  [SCREENMAIN.CPP:162-851] ---- */
tScreenMain::~tScreenMain()

{
  /* base ~tScreen() runs implicitly (non-poly inheritance) */
  return;
}



/* end of screenmain.cpp */
