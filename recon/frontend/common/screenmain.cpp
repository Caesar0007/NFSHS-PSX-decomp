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
        /* MATCH (SLD 246 = ONE statement): don't park rand()'s result in the
           slot variable -- that copy (addu a1,v0,zero) is a live-range
           extension the oracle has no room for. */
        this->fCurrentBG[this->fCurrentSlot] = rand() % 0x1c;
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
    /* MATCH (SLD 260/261/263): retail DUPLICATES the SetState call in both
       arms (gcc cross-jump-merges them back into one `jal`, with the `!=`
       polarity putting the Warning arm out of line and `a0 = this` in the
       beq's delay slot); a select-into-a-variable form emits one setup. */
    if (tVar2 != kScreenMain_WarningImage) {
      this->SetState(kScreenMain_StaticImage);
    }
    else {
      this->SetState(kScreenMain_WarningImage);
    }
    this->fNumTVsInTransition = 0x10;
  }
  return;
}



/* ---- tScreenMain::DoneLoadingBackground  [SCREENMAIN.CPP:270-276] ---- */
int tScreenMain::DoneLoadingBackground()

{
  /* MATCH: the whole body is ONE retail source line (SLD 274) -- a single
     `&&` chain.  It gives the oracle's early-exit chain with `v0 = 0` in each
     branch delay slot and the final `beqz`+`li v0,1`-in-slot cross-jump tail;
     a result-variable form emits an `sltiu` funnel instead. */
  /* MATCH: the whole body is ONE retail source line (SLD 274) -- a single `||`
     early-out chain.  It gives the oracle's `v0 = 0` in every branch delay slot
     and the shared `jr ra` tail; a result-variable / &&-chain form folds the
     last test into an `sltiu` funnel instead. */
  if (this->fVideoShapes[this->fCurrentSlot].async_handle != 0 ||
      this->fVideoShapes[this->fCurrentSlot].fFile != 0 ||
      this->fVideoShapes[1 - this->fCurrentSlot].async_handle != 0 ||
      this->fVideoShapes[1 - this->fCurrentSlot].fFile != 0) {
    goto DLB_ret0;
  }
  return 1;
DLB_ret0:
  return 0;
}



/* ---- tScreenMain::SetState  [SCREENMAIN.CPP:280-342] ---- */
void tScreenMain::SetState(tScreenMainState state)

{
  /* MATCH (W64 PASS, 32->0): IDA's retail allocation is recovered by making
     `shape` the current element pointer, storing transition state before the
     u calculation, and placing the DynamicImage case first in source order.
     The SYM 8c block lists ONLY `shape` and `i` -- every
     uVarN/iVarN/tVarN was a Ghidra temp.  And the state dispatch carries the
     gcc-2.8 balance_case_nodes fingerprint (median-pivot `beq $v1,3` with the
     `slti $v1,4` bound test in its DELAY SLOT, case bodies out of line in
     source order) => it was a `switch`, not an if/else-if cascade. */
  tTexture_ShapeInfo *shape;
  short i;
  
  if (state != this->fState) {
    VIDEO_abortplayback(this->hVideo);
    this->bVideoAborted = 1;
    this->fMovieTicks = ticks;
    if ((state != kScreenMain_Credits) && (CreditManager.fCreditsInitialized == 1)) {
      DeInit(&CreditManager);
    }
    i = 0;
    this->fState = state;
    this->fStartTicks = ticks;
    do {
      shape = this->fVideoShapes[this->fCurrentSlot].fShapes + i;
      this->tvTransitions[i].state = kScreenMain_StaticImage;
      this->tvTransitions[i].u =
           (uchar)((((int)shape->shapex - (int)(short)(shape->shapex & 0xffc0)) * 0x10) /
                   (int)(uint)(byte)shape->depth);
      this->tvTransitions[i].v = (uchar)shape->shapey;
      this->tvTransitions[i].uw = (uchar)shape->width;
      this->tvTransitions[i].vh = (uchar)shape->height;
      this->tvTransitions[i].tpage =
           ((u_char)*((u_char*)shape + 9) & 3) << 7 | (short)(shape->shapey & 0x100U) >> 4 |
           (ushort)(((ushort)shape->shapex & 0x3c0) >> 6) |
           (shape->shapey & 0x200U) << 2;
      this->tvTransitions[i].clut =
           GetClut((shape->clutID & 0x3fU) << 4,shape->clutID >> 6);
      this->tvTransitions[i].flags = 0;
      this->tvTransitions[i].tint = 0x808080;
      this->tvTransitions[i].bright = 0x80;
      i = i + 1;
    } while (i < 0x10);
    switch (this->fState) {
    case kScreenMain_DynamicImage:
      this->InitDynamicImages();
      break;
    case kScreenMain_WarningImage:
      i = 4;
      do {
        this->tvTransitions[i].bright = 0x80;
        this->tvTransitions[i].state = kScreenMain_WarningImage;
        i = i + 1;
      } while (i < 0xc);
      this->tvTransitions[6].bright = 0x80;
      this->tvTransitions[5].bright = 0x80;
      break;
    case kScreenMain_Credits:
      i = 0;
      do {
        this->tvTransitions[i].bright = 0x80;
        this->tvTransitions[i].state = kScreenMain_Credits;
        i = i + 1;
      } while (i < 0x10);
      Init(&CreditManager,this->fStartTicks);
      break;
    }
  }
  return;
}



/* ---- tScreenMain::InitDynamicImages  [SCREENMAIN.CPP:348-402] ---- */
/* MATCH W61 (2026-08-10): PASS, 170 -> 0 diffs.  Replaced the Ghidra
   temporary graph with the SYM's exact 12 locals and original nested-loop
   roles.  IDA's retail allocation (video=$s1, config=$fp, x/y=$s2/$s3,
   i/j/k=$t2/$s6/$s4) then falls out naturally; SLD lines 394-396 establish
   the final tint/state/bright statement order. */
void tScreenMain::InitDynamicImages()

{
  tVideo *video;
  int videoWallConfig;
  int startX;
  int startY;
  int x;
  int y;
  int xOffset;
  int yOffset;
  int i;
  int j;
  int k;
  int index;

  videoWallConfig = rand() % 24;
  for (i = 0; i < videoWallConfigs[videoWallConfig].numVideos; i++) {
    video = videoWallConfigs[videoWallConfig].videos[i];
    startX = video->x;
    startY = video->y;
    for (j = 0; j < video->tileWidth; j++) {
      for (k = 0; k < video->tileHeight; k++) {
        for (y = 0; y < video->height; y++) {
          for (x = 0; x < video->width; x++) {
            xOffset = x + startX + j * video->width;
            yOffset = y + startY + k * video->height;
            index = yOffset * 4 + xOffset;
            this->tvTransitions[index].u = x * (80 / video->width);
            this->tvTransitions[index].v = y * (80 / video->height);
            this->tvTransitions[index].uw = (80 / video->width) - 1;
            this->tvTransitions[index].vh = 80 / video->height;
            this->tvTransitions[index].tpage = GetTPage(2,0,0x200,0);
            this->tvTransitions[index].clut = 0;
            this->tvTransitions[index].flags = 0x22;
            this->tvTransitions[index].tint = tintColors[this->fCurrentBG[this->fCurrentSlot]];
            this->tvTransitions[index].state = kScreenMain_DynamicImage;
            this->tvTransitions[index].bright = 0x80;
          }
        }
      }
    }
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
  int i;
  uint addrMask;
  uint tagMask;
  u_char *pal_link;
  uint palTag;
  u_char *prim;
  
  i = 0;
  do {
    prim = Render_gPacketPtr;
    pal_link = Render_gPalettePtr;
    addrMask = 0xffffff;
    tagMask = 0xff000000;
    /* MATCH (2026-08-11, 32 -> PASS, 69/69): allocsim reproduced all seven
       allocnos and priced the 3-way rotation to exactly +2 weighted refs on
       addrMask.  Re-masking the already-masked addr_24 inside the loop supplies
       those refs at zero instructions, yielding retail's i->$t0,
       0xFFFFFF->$a3 and 0x808080->$t1 handout.  The named early palTag snapshot
       keeps the second tag RMW in $v1 across the packet-pointer update; the
       prim/pal fence prevents the first tag store from sinking past it.  Keeping
       the mask initializers at the top of the loop lets loop.c hoist them after
       the two scratchpad address constants in the exact retail order. */
    *(uint *)prim = *(uint *)prim & tagMask |
                    *(uint *)pal_link & addrMask;
    __asm__("" : : "r" (prim), "r" (pal_link));
    palTag = *(uint *)pal_link;
    addr_24 = (uint)prim & addrMask;
    Render_gPacketPtr = prim + 0x24;
    *(uint *)pal_link = palTag & tagMask | (addr_24 & addrMask);
    *(u_int *)(prim + 4) = 0x808080;
    prim[7] = 0x3a;
    *(u_int *)(prim + 0xc) = 0x808080;
    *(u_int *)(prim + 0x1c) = 0;
    *(u_int *)(prim + 0x14) = 0;
    prim[3] = 8;
    /* MATCH (W57, 69->28): the SYM 8c block lists ONLY `i` and `prim` --
       `src_walk` was a Ghidra-invented walk pointer, and gcc strength-reduced
       it into a SECOND induction giv (`addiu a3,v0,0` + `addiu a2,a3,14`)
       where the oracle carries one.  dropShadow is `tVertex[4][4]`, so retail
       indexed it by the loop counter (3.12 #1 index-form). */
    *(u_short *)(prim + 8) = dropShadow[i][0].x;
    *(u_short *)(prim + 10) = dropShadow[i][0].y;
    *(u_short *)(prim + 0x10) = dropShadow[i][1].x;
    *(u_short *)(prim + 0x12) = dropShadow[i][1].y;
    *(u_short *)(prim + 0x18) = dropShadow[i][2].x;
    *(u_short *)(prim + 0x1a) = dropShadow[i][2].y;
    *(u_short *)(prim + 0x20) = dropShadow[i][3].x;
    *(u_short *)(prim + 0x22) = dropShadow[i][3].y;
    i = i + 1;
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
  short i;
  short j;
  tDrawShapeExtended drawFlags;
  u_long deltaTicks;
  short animFade;
  short x;
  short y;
  char buffer [32];
  int shapeX;
  int shapeY;
  byte bVar1;
  bool bVar2;
  short sVar3;
  int fade;
  char *str;
  int iVar5;
  uint uVar6;
  int iVar7;
  uint uVar9;
  int TextCol;
  int iVar10;
  RECT r;
  char moviename [80];
  
  animFade = 0;
  for (i = animFade; i < 2; i++) {
    ::IsShapeFileLoaded((tScreen *)this,this->fVideoShapes + i);
    if (this->fVideoShapes[i].fFile != (char *)0x0) {
      bool bAllTVsOn;

      bAllTVsOn = true;
      for (j = 0; j < 0x10; j++) {
        if (((this->tvStates[j] != kScreenMain_StaticImage) &&
             (this->tvStates[j] != kScreenMain_Credits)) ||
            (this->tvTransitions[j].state != this->tvStates[j]) ||
            (this->tvConfigs[j].clut != this->tvTransitions[j].clut)) {
          bAllTVsOn = false;
        }
      }
      if (bAllTVsOn) {
        ::UploadShapes((tScreen *)this,this->fVideoShapes + i,i * 0xa6,0,0x10,0);
      }
    }
  }
  if (this->fState == kScreenMain_Credits) {
    if (FEApp->fCurrentMenu[0] != (tMenu *)&menuDefs->menuCredits) {
      this->SetState(kScreenMain_StaticImage);
    }
  }
  else if (FEApp->fCurrentMenu[0] == (tMenu *)&menuDefs->menuCredits) {
    this->SetState(kScreenMain_Credits);
  }
  ::Draw(&CreditManager,this->fState == kScreenMain_Credits);
  if (this->fState == kScreenMain_WarningImage) {
    if ((frontEnd.raceType != '\x06') &&
       ((tMenuItemGoToMenuNFS4Button *)
        FEApp->fCurrentMenu[0]->fItemList[FEApp->fCurrentMenu[0]->fCurrentItem] !=
        &menuDefs->itemTwoPlayerPinkSlips)) {
      this->SetState(kScreenMain_StaticImage);
    }
  }
  else if ((frontEnd.raceType == '\x06') ||
          ((tMenuItemGoToMenuNFS4Button *)
           FEApp->fCurrentMenu[0]->fItemList[FEApp->fCurrentMenu[0]->fCurrentItem] ==
           &menuDefs->itemTwoPlayerPinkSlips)) {
    this->SetState(kScreenMain_WarningImage);
  }
  if ((this->fState == kScreenMain_WarningImage) || (0 < this->fWarningFade)) {
    if (this->fState == kScreenMain_WarningImage) {
      if (this->fWarningFade < 0x60) {
        this->fWarningFade = this->fWarningFade + 4;
      }
    }
    else {
      this->fWarningFade = this->fWarningFade + -4;
    }
    for (i = 4; i < 0xc; i++) {
      this->tvConfigs[i].flags = this->tvConfigs[i].flags | 2;
      uVar9 = 0x80 - (int)this->fWarningFade;
      this->tvConfigs[i].tint = uVar9 * 0x10000 | uVar9 * 0x100 | uVar9;
    }
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
    TextCol = CalcFadeVal(0xbebe,0x60 - this->fWarningFade);
    r.x = 0xb5;
    r.y = 0x81;
    r.w = 0x11c;
    r.h = 0x2a;
    str = TextSys_Word(0x272);
    FETextRender_WordWrapTextRGB(str,r,TextCol);
    iVar7 = 0;
    FETextRender_SetABR(0,false);
    FeDraw_SetABRMode(iVar7);
  }
  j = 0;
  if ((this->fFrame & 1U) == 0) {
    j = 0x50;
  }
  iVar5 = VIDEO_state(this->hVideo);
  if (iVar5 == 3) {
    this->bVideoAborted = 0;
    this->fMovieTicks = ticks;
    iVar7 = VIDEO_updateframexy(this->hVideo,0x200,j);
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
        this->fCurrentMovie = rand() % 0x14;
      } while (this->fCurrentMovie == this->fPreviousMovie);
      this->fPreviousMovie = this->fCurrentMovie;
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
        sVar3 = rand() % 0x19;
      } while (sVar3 == this->fPreviousAnim);
      this->fPreviousAnim = sVar3;
      sprintf(buffer,"yVda%02d",(int)sVar3);
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
    animFade = deltaTicks * 0x1ffffff + 0x80;
  }
  else if (deltaTicks - 0x2a0 < 0x80) {
    animFade = deltaTicks - 0x2a0;
  }
  if ((deltaTicks < 800) && (this->fAnimationUploaded != 0)) {
    int drawAnimFade;

    drawFlags.tint[0] = tintColors[this->fCurrentBG[this->fCurrentSlot]];
    drawFlags.custom_shapes = this->fSwapShapes.fShapes;
    drawAnimFade = (int)animFade;
    if (CreditManager.fCreditsInitialized != 0) {
      drawAnimFade = drawAnimFade + 0x40;
      if (0x80 < drawAnimFade) {
        drawAnimFade = 0x80;
      }
    }
    shapeX = animLocations[this->fAnimLocation].x;
    shapeY = animLocations[this->fAnimLocation].y;
    DrawShapeExtended((deltaTicks / 0xf) % 10,0x611,shapeX,shapeY,drawAnimFade,1,&drawFlags);
  }
  y = 0x32;
  i = 0;
  while ((i < 0x19) && (y < 0xd2)) {
    x = 0x1a2;
    for (j = 4; -1 < j; j--) {
      DrawShapeExtended((numberValues[(i + ticks / 0x14) % 0x19] >> j) & 1,1,x,y,0x40,3,
                 (tDrawShapeExtended *)0x0);
      x = x + 0xd;
    }
    y = y + 8;
    i++;
  }
  iVar10 = (int)((ticks - this->fStartTicks) * 0x1000) >> 0x10;
  j = 0;
  if (-1 < iVar10) {
    do {
      if (0xf < j) break;
      bVar1 = tvOrder[j];
      if (((this->tvStates[bVar1] != this->tvTransitions[bVar1].state) ||
          (this->tvConfigs[bVar1].clut != this->tvTransitions[bVar1].clut)) &&
         (this->tvConfigs[bVar1].state == tv_StateOn)) {
        TurnOffTV(this->tvConfigs + bVar1);
      }
      j++;
    } while (j <= iVar10);
  }
  for (i = 0; i < 0x10; i++) {
    if (this->tvConfigs[i].state == tv_StateOff) {
      this->tvConfigs[i].u = this->tvTransitions[i].u;
      this->tvConfigs[i].v = this->tvTransitions[i].v;
      this->tvConfigs[i].uw = this->tvTransitions[i].uw;
      this->tvConfigs[i].vh = this->tvTransitions[i].vh;
      this->tvConfigs[i].tpage = this->tvTransitions[i].tpage;
      this->tvConfigs[i].clut = this->tvTransitions[i].clut;
      this->tvConfigs[i].flags = this->tvTransitions[i].flags;
      this->tvConfigs[i].tint = this->tvTransitions[i].tint;
      this->tvStates[i] = this->tvTransitions[i].state;
      TurnOnTV(this->tvConfigs + i);
      this->tvConfigs[i].destBrightness = this->tvTransitions[i].bright;
      this->fNumTVsInTransition = this->fNumTVsInTransition + -1;
    }
  }
  for (i = 0; i < 0x10; i++) {
    DrawTV(this->tvConfigs + i);
  }
  for (i = 0xf3; i < 0x1e3; i = i + 0x50) {
    PSXDrawSquare(0x404040,i,0x2a,2,0xa9);
  }
  for (i = 0x54; i < 0xd2; i = i + 0x2a) {
    PSXDrawSquare(0x303030,0xa3,i,0x141,1);
  }
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
  short i;
  char buffer [32];
  
  sprintf(gPermBuffer,"zMain%d",(uint)(byte)frontEnd.language);
  rnd = rand();
  this->fPreviousAnim = (short)(rnd % 0x19);
  sprintf(gNameBuffer,"yVda%02d",(rnd % 0x19) * 0x10000 >> 0x10);
  this->PreLoad();
  /* MATCH: ONE fn-scope `short i` serves BOTH loops -- splitting it into i/j
     halves the allocno's refs and loses the oracle's s2 handout (s0 instead).
     A plain `short` counter -- the decompiler's `i_int * 0x10000 >> 0x10`
     idiom pre-shifts into an extra pseudo; the oracle re-signs the short at each
     use (sll/sra) and copies the bumped value back (addiu v0,s2,1; addu s2,v0). */
  i = 0;
  do {
    this->fVideoShapes[i].fShapes = (tTexture_ShapeInfo *)0x0;
    ::InitializeShapes((tScreen *)this,this->fVideoShapes + i,0x10);
    i = i + 1;
  } while (i < 2);
  this->fCurrentBG[0] = rand() % 0x1c;
  i = 0;
  this->fCurrentBG[1] = (this->fCurrentBG[0] + rand() % 0x1b + 1) % 0x1c;
  do {
    sprintf(buffer,"zyVid%02d",this->fCurrentBG[i]);
    ::AsyncLoadShapeFile((tScreen *)this,buffer,this->fVideoShapes + i);
    i = i + 1;
  } while (i < 2);
  return;
}



/* ---- tScreenMain::Initialize  [SCREENMAIN.CPP:788-837] ---- */
void tScreenMain::Initialize()

{
  /* MATCH (2026-08-11, 14 -> PASS, exact 129/129): SLD lines 812-824 put
     bVideoAborted before the tick snapshots, followed by transition and the
     remaining state fields.  A site-local volatile read preserves retail's
     separate fStartTicks/fAnimTicks loads; typed tvStates[i] indexing gives
     the retail base-first address addition. */
  /* MATCH (06A): the SYM 8c block lists exactly TWO named locals -- `i` (class
     REG $16 = $s0, SHORT) and `shapesLoaded` (class REG $16 = $s0, BOOL), sharing
     one register over disjoint ranges; mask $800f0000 = ra + s0..s3, i.e. FOUR
     saved regs.  loaded / pv / all_loaded / iVar2 / scratch / iVar3 were Ghidra
     inventions and bought a fifth saved register ($s4). */
  /* SYM types it BOOL, which in this codebase is a 4-byte int -- the oracle's
     first assignment is a RAW COPY (`addu s0,v0,zero`), not a normalization, so
     it is an int taking the pointer; only the `&&` below normalizes (`sltu`). */
  int shapesLoaded;
  short i;

  this->Initialize();
  do {
    FeAudio_systemtask(0);
    shapesLoaded = (int)::IsShapeFileLoaded((tScreen *)this,this->fVideoShapes);
    if (this->fVideoShapes[0].fFile != (char *)0x0) {
      ::UploadShapes((tScreen *)this,this->fVideoShapes,0,0,0x10,0);
    }
    /* MATCH: ONE `&&` expression re-assigned to the SAME named flag -- gcc builds
       the value in an anonymous temp ($v1 in both arms) and emits a single
       `addu s0,v1,zero` copy into `shapesLoaded`; the `flag = false; if (...)
       flag = ...;` form writes $s0 directly in both arms (no phi copy). */
    shapesLoaded = shapesLoaded &&
                   (::IsShapeFileLoaded((tScreen *)this,this->fVideoShapes + 1) != (void *)0x0);
    if (this->fVideoShapes[1].fFile != (char *)0x0) {
      ::UploadShapes((tScreen *)this,this->fVideoShapes + 1,0xa6,0,0x10,0);
    }
  } while (!shapesLoaded);
  this->fPreviousMovie = -1;
  this->fFrame = 0;
  this->hVideo = VIDEO_create(0x50,0x50,0xf0000,0x20000,0x10);
  this->bVideoAborted = 0;
  this->fStartTicks = *(volatile int *)&ticks;
  this->fAnimTicks = ticks - 800;
  this->fTransitionDirection = '\x01';
  this->fAnimationUploaded = 0;
  this->fWarningFade = 0;
  this->fNumTVsInTransition = 0;
  this->fCurrentSlot = 0;
  /* MATCH: ONE fn-scope `short n` serves all THREE loops -- the decompiler's
     `iVarN * 0x10000 >> 0x10` pre-shift idiom costs an extra pseudo per loop
     (and a whole extra saved register); a plain short counter reproduces the
     oracle's per-use sll/sra + `addiu v0,n,1; addu n,v0,zero` bump. */
  i = 0;
  do {
    InitTV(this->tvConfigs + i,this->fVideoShapes[this->fCurrentSlot].fShapes,i);
    i = i + 1;
  } while (i < 0x10);
  this->fState = kScreenMain_Off;
  this->SetState(kScreenMain_StaticImage);
  i = 0;
  do {
    this->tvStates[i] = 0;
    i = i + 1;
  } while (i < 0x10);
  i = 0;
  do {
    numberValues[i] = (char)rand();
    i = i + 1;
  } while (i < 0x19);
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
