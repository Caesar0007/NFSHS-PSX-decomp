/* frontend/common/screenmain.cpp -- RECONSTRUCTED (main/top-level menu screen; C++ TU)
 *   single class tScreenMain : tScreen ; 13 fns (no ctor in this TU).
 *   Phantoms (warning-image DrawShapeExtended/ScaleShapeExtended coords, dot-grid numberValues
 *   bitmap + x-walker, tvOrder/animLocations/tintColors statics, gNameBuffer/gPermBuffer sprintf
 *   dsts, void ProcessInput) resolved via m2c oracle + binary static reads.
 */
#include "screenmain.h"

/* ---- ScreenMain.obj-OWNED globals -- DEFINED here (self-contained; real NFS4.EXE bytes;
   videoWallConfigs[].videos = SYMBOL-REF ptrs to the tVideo globals, not absolute addresses) ---- */
static tVideo video11a = {0, 0, 1, 1, 1, 1, 0, 0};   /* @0x80051b78; SYM STAT */
static tVideo video11b = {1, 0, 1, 1, 1, 1, 0, 0};   /* @0x80051b80; SYM STAT */
static tVideo video11c = {2, 0, 1, 1, 1, 1, 0, 0};   /* @0x80051b88; SYM STAT */
static tVideo video11d = {3, 0, 1, 1, 1, 1, 0, 0};   /* @0x80051b90; SYM STAT */
static tVideo video11e = {0, 1, 1, 1, 1, 1, 0, 0};   /* @0x80051b98; SYM STAT */
static tVideo video11h = {3, 1, 1, 1, 1, 1, 0, 0};   /* @0x80051ba0; SYM STAT */
static tVideo video11i = {0, 2, 1, 1, 1, 1, 0, 0};   /* @0x80051ba8; SYM STAT */
static tVideo video11l = {3, 2, 1, 1, 1, 1, 0, 0};   /* @0x80051bb0; SYM STAT */
static tVideo video11m = {0, 3, 1, 1, 1, 1, 0, 0};   /* @0x80051bb8; SYM STAT */
static tVideo video11n = {1, 3, 1, 1, 1, 1, 0, 0};   /* @0x80051bc0; SYM STAT */
static tVideo video11o = {2, 3, 1, 1, 1, 1, 0, 0};   /* @0x80051bc8; SYM STAT */
static tVideo video11p = {3, 3, 1, 1, 1, 1, 0, 0};   /* @0x80051bd0; SYM STAT */
static tVideo video21a = {0, 0, 2, 1, 1, 1, 0, 0};   /* @0x80051bd8; SYM STAT */
static tVideo video21c = {2, 0, 2, 1, 1, 1, 0, 0};   /* @0x80051be0; SYM STAT */
static tVideo video21j = {0, 3, 2, 1, 1, 1, 0, 0};   /* @0x80051be8; SYM STAT */
static tVideo video21l = {2, 3, 2, 1, 1, 1, 0, 0};   /* @0x80051bf0; SYM STAT */
static tVideo video31a = {0, 0, 3, 1, 1, 1, 0, 0};   /* @0x80051bf8; SYM STAT */
static tVideo video31b = {1, 0, 3, 1, 1, 1, 0, 0};   /* @0x80051c00; SYM STAT */
static tVideo video31g = {0, 3, 3, 1, 1, 1, 0, 0};   /* @0x80051c08; SYM STAT */
static tVideo video31h = {1, 3, 3, 1, 1, 1, 0, 0};   /* @0x80051c10; SYM STAT */
static tVideo video22a = {0, 0, 2, 2, 1, 1, 0, 0};   /* @0x80051c18; SYM STAT */
static tVideo video22b = {1, 0, 2, 2, 1, 1, 0, 0};   /* @0x80051c20; SYM STAT */
static tVideo video22c = {2, 0, 2, 2, 1, 1, 0, 0};   /* @0x80051c28; SYM STAT */
static tVideo video22d = {0, 1, 2, 2, 1, 1, 0, 0};   /* @0x80051c30; SYM STAT */
static tVideo video22f = {2, 1, 2, 2, 1, 1, 0, 0};   /* @0x80051c38; SYM STAT */
static tVideo video22g = {0, 2, 2, 2, 1, 1, 0, 0};   /* @0x80051c40; SYM STAT */
static tVideo video22h = {1, 2, 2, 2, 1, 1, 0, 0};   /* @0x80051c48; SYM STAT */
static tVideo video22i = {2, 2, 2, 2, 1, 1, 0, 0};   /* @0x80051c50; SYM STAT */
static tVideo video32a = {0, 0, 3, 2, 1, 1, 0, 0};   /* @0x80051c58; SYM STAT */
static tVideo video32b = {1, 0, 3, 2, 1, 1, 0, 0};   /* @0x80051c60; SYM STAT */
static tVideo video32e = {0, 2, 3, 2, 1, 1, 0, 0};   /* @0x80051c68; SYM STAT */
static tVideo video32f = {1, 2, 3, 2, 1, 1, 0, 0};   /* @0x80051c70; SYM STAT */
static tVideoWallConfig videoWallConfigs[24] = {
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
  char buffer [8];
  
  VIDEO_abortplayback(this->hVideo);
  this->bVideoAborted = 1;
  if ((((this->fVideoShapes[this->fCurrentSlot].async_handle == 0) &&
       (this->fVideoShapes[this->fCurrentSlot].fFile == (char *)0x0)) &&
      (this->fVideoShapes[1 - this->fCurrentSlot].async_handle == 0)) &&
     (this->fVideoShapes[1 - this->fCurrentSlot].fFile == 0)) {
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
      this->fCurrentBG[this->fCurrentSlot] = num;
    }
    sprintf(buffer,"zyVid%02d",this->fCurrentBG[this->fCurrentSlot]);
    ::AsyncLoadShapeFile((tScreen *)this,buffer,this->fVideoShapes + this->fCurrentSlot);
    oldState = this->fState;
    this->fState = kScreenMain_Off;
    this->fCurrentSlot = 1 - this->fCurrentSlot;
    /* MATCH (SLD 260/261/263): retail DUPLICATES the SetState call in both
       arms (gcc cross-jump-merges them back into one `jal`, with the `!=`
       polarity putting the Warning arm out of line and `a0 = this` in the
       beq's delay slot); a select-into-a-variable form emits one setup. */
    if (oldState != kScreenMain_WarningImage) {
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
bool tScreenMain::DoneLoadingBackground()

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
void tScreenMain::ProcessInput(tPlayer,tInputKeyType &keyval,tMenuCommand &)

{
  
  if ((keyval == kInput_KeyType_Triangle) && (0 < FEApp->backDepth[0])) {
    this->SwapBackground(-1);
    if ((tMenuNFS4 *)FEApp->fCurrentMenu[0] == &menuDefs->menuPinkSlipSelect) {
      frontEnd.raceType = RaceType_SingleRace;
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
  POLY_G4 *prim;
  
  i = 0;
  do {
    prim = (POLY_G4 *)Render_gPacketPtr;
    pal_link = Render_gPalettePtr;
    addrMask = 0xffffff;
    tagMask = 0xff000000;
    /* MATCH (2026-08-11, 32 -> PASS, 69/69):
       SYM-CODEGEN-CARRIER: addr_24
       SYM-CODEGEN-CARRIER: addrMask
       SYM-CODEGEN-CARRIER: tagMask
       SYM-CODEGEN-CARRIER: pal_link
       SYM-CODEGEN-CARRIER: palTag
       allocsim reproduced all seven
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
    Render_gPacketPtr = (u_char *)prim + 0x24;
    *(uint *)pal_link = palTag & tagMask | (addr_24 & addrMask);
    *(u_int *)((u_char *)prim + 4) = 0x808080;
    ((u_char *)prim)[7] = 0x3a;
    *(u_int *)((u_char *)prim + 0xc) = 0x808080;
    *(u_int *)((u_char *)prim + 0x1c) = 0;
    *(u_int *)((u_char *)prim + 0x14) = 0;
    ((u_char *)prim)[3] = 8;
    /* MATCH (W57, 69->28): the SYM 8c block lists ONLY `i` and `prim` --
       `src_walk` was a Ghidra-invented walk pointer, and gcc strength-reduced
       it into a SECOND induction giv (`addiu a3,v0,0` + `addiu a2,a3,14`)
       where the oracle carries one.  dropShadow is `tVertex[4][4]`, so retail
       indexed it by the loop counter (3.12 #1 index-form). */
    *(u_short *)((u_char *)prim + 8) = dropShadow[i][0].x;
    *(u_short *)((u_char *)prim + 10) = dropShadow[i][0].y;
    *(u_short *)((u_char *)prim + 0x10) = dropShadow[i][1].x;
    *(u_short *)((u_char *)prim + 0x12) = dropShadow[i][1].y;
    *(u_short *)((u_char *)prim + 0x18) = dropShadow[i][2].x;
    *(u_short *)((u_char *)prim + 0x1a) = dropShadow[i][2].y;
    *(u_short *)((u_char *)prim + 0x20) = dropShadow[i][3].x;
    *(u_short *)((u_char *)prim + 0x22) = dropShadow[i][3].y;
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
/* MATCH: 121 -> 115 diffs.  Keeping the video-timeout test as one combined
   condition removes the decompiler's invented saved-register boolean; the
   unsigned-short VIDEO y cast removes one of its two sign-extension ops.
   Remaining large islands are the SLD-confirmed dot-grid/TV-order loop CFGs
   and warning-fade/animation local-allocation order. */
/* W61-A17/root resume (115 -> 111) -- census + verified SLD:530 repair.
   FRAME CENSUS:
   our sp-offset multiset is IDENTICAL to retail's, so this is NOT the W61-A1
   declaration-order spill class.  SLD attribution (tools/sldall.py) puts the
   residual in two places: (a) an a1<->a2 rotation through the tvConfigs[i]
   flags/tint writes (SLD:524-527), and (b) SLD:530, where retail computes the
   warning tint ONCE and stores the same word to BOTH 428(s6) and 380(s6)
   while ours rebuilds it.  FALSIFIED, all EXACTLY neutral at 115 (so the
   Ghidra-invented one-shot temps the SYM 8c list omits are codegen-free here):
   inlining iVar5 (the `VIDEO_state(hVideo) == 3` test), iVar7 (the second
   VIDEO_state test), str (`TextSys_Word(0x272)`), and dropping the dead
   `iVar7 = 0;` before FeDraw_SetABRMode.  The SYM's real local set is
   i, j, drawFlags, deltaTicks, animFade, x, y, buffer, shapeX, shapeY plus a
   block-scope BOOL bAllTVsOn -- our bVar1/sVar3/fade/str/iVar5/uVar6/iVar7 are
   inventions but are not what costs the rotation.
   VERIFIED: keeping the packed warning tint in a distinct `fade` result makes
   retail's ONE computed word feed BOTH tvConfigs[6] and tvConfigs[5], removing
   four detailed diffs.  A per-iteration config pointer worsened 111 -> 122; a
   `fadeMid` block temp was exactly neutral; passing short `j` directly to
   VIDEO_updateframexy worsened 111 -> 112.  All three probes were reverted. */
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
  /* MATCH W64-A17 -- REAL CFG FIX (the 11C branch-target audit class; the
     gate normalises branch targets so this was invisible to it, and
     tools/psyqproof.py + tools/brdist.py caught it as REAL=2 on a gate-PASSing
     body).  Retail's guard is a FLAT `&&`, not a nested if: its `beq` (fState
     == Credits AND menu == credits) targets .L80037B44 = the SECOND test's
     head, so retail RE-RUNS the menu test and calls SetState(Credits) on that
     path; our nested `if (fState==Credits) { if (menu!=credits) ... }` sent it
     to the join instead and skipped the second test.  Same instruction stream,
     different control flow.  Re-gated alternatives: two SEQUENTIAL ifs 5 @821
     (retail's SetState calls cross-jump onto one shared `jal`, ours emits two),
     the same with an explicit goto-funnel 6 @820 / 6 @820.
     The else-arm void fence is the 1 -> PASS %hi un-sharer (see below). */
  if ((this->fState == kScreenMain_Credits) &&
     (FEApp->fCurrentMenu[0] != (tMenu *)&menuDefs->menuCredits)) {
    this->SetState(kScreenMain_StaticImage);
  }
  else {
    /* MATCH W64-A17 (1 -> PASS 822/822): the ON-DEMAND %hi UN-SHARER.  Both
       arms materialise `%hi(FEApp)`; reorg slots the then-arm's copy into the
       `bne` delay slot, which executes on BOTH paths, so cse2
       (-fcse-follow-jumps) lets the else arm reuse it and we came out ONE
       `lui v0,0` short (retail keeps two pseudos and enters the second test
       block at TWO labels -- .L80037B44 with the lui, .L80037B48 without).
       FALSIFIED, all re-gated from the 1-diff basin: Yoda in the else arm
       10 @822 (adds the lui but reverses `bne v1,v0` and the three loads),
       Yoda in the then arm 11, Yoda in both 21, arms swapped (`!=` first) 19,
       a block-local for the menuCredits address in the else arm 8 @822 / in
       both arms 17, a block-local for `FEApp` in the else arm / the then arm /
       both, a `tMenu **cm = FEApp->fCurrentMenu` local, and an explicit nested
       `else { if ... }` -- all exactly 1 (neutral). */
    __asm__("" : : "i"(0));
    if (FEApp->fCurrentMenu[0] == (tMenu *)&menuDefs->menuCredits) {
      this->SetState(kScreenMain_Credits);
    }
  }
  ::Draw(&CreditManager,this->fState == kScreenMain_Credits);
  if (this->fState == kScreenMain_WarningImage) {
    if ((frontEnd.raceType != RaceType_PinkSlips) &&
       ((tMenuItemGoToMenuNFS4Button *)
        FEApp->fCurrentMenu[0]->fItemList[FEApp->fCurrentMenu[0]->fCurrentItem] !=
        &menuDefs->itemTwoPlayerPinkSlips)) {
      this->SetState(kScreenMain_StaticImage);
    }
  }
  else if ((frontEnd.raceType == RaceType_PinkSlips) ||
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
    /* MATCH W63-A17 (44 -> 12, count still EXACT 822/822): W46 STORAGE-SCOPE LAW.
       Retail homes the packed-tint scratch in $a1 INSIDE the tvConfigs[4..0xb]
       loop and in $v1 AFTER it -- two different registers for what our recon
       carried in ONE fn-scope `uVar9`, i.e. one global allocno whose merged
       conflict set was barred from both.  Giving the POST-LOOP use its own
       block-scoped variable turns it into a local qty and the whole a1/a2 (loop)
       plus a2/v1 (tail) rotation collapses.  Splitting the IN-LOOP use instead --
       alone, in-place-mutated, or together with this one -- REGRESSES to 52
       (all three re-gated): only the second site is the dial. */
    { uint uFade = 0x80 - ((int)this->fWarningFade << 6) / 0x60;
    fade = uFade * 0x10000 | uFade * 0x100 | uFade; }
    this->tvConfigs[6].tint = fade;
    this->tvConfigs[5].tint = fade;
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
  /* MATCH W64-A17 (7 -> 1): the video block's $s0 carrier is an INT, not the
     SHORT `j`.  Retail passes it with a bare `addu a2,s0,zero` and tests it
     with a bare `beqz s0`; a SHORT carrier makes cc1plus sign-extend at BOTH
     sites (`sll;sra` / `sll;beqz`), which is the 4 diffs and the +2 count.
     `j` must stay SHORT for the tv/dot-grid loops (it sign-extends there), so
     retail used a DIFFERENT variable here -- a fresh block-scope int.  The
     SYM's two INT $s0 locals are wrong carriers (re-gated from this basin:
     shapeY arg-only 75 / flag-only 85 / both 82, TextCol arg-only 24 /
     flag-only 34 / both 31, TextCol+shapeY mixed 102): both are LIVE across
     this region, so naming them merges live ranges instead of splitting them. */
  int vy = 0;
  if ((this->fFrame & 1U) == 0) {
    vy = 0x50;
  }
  iVar5 = VIDEO_state(this->hVideo);
  if (iVar5 == 3) {
    this->bVideoAborted = 0;
    this->fMovieTicks = ticks;
    iVar7 = VIDEO_updateframexy(this->hVideo,0x200,vy);
    if (iVar7 != 0) {
      this->fFrame = this->fFrame + 1;
    }
  }
  else {
    /* MATCH W62-A15: the 13C INVERTED-DEFAULT lever + the 13C
       CSE-CONSTANT-CAPTURE, read straight off the oracle.  Retail zeroes the
       flag variable in the VIDEO_state jal's DELAY SLOT (`addu s0,zero,zero`),
       materialises the guard as a VALUE, and tests it with the `1` that the
       preceding `iVar7 != 1` guard already left in $a0:
           jal VIDEO_state ; addu s0,zero,zero ; li a0,1 ; beq v0,a0,T
           ... sltiu v0,v0,641 ; xor s0,v0,a0 ; beqz s0,T
       A bare `&&` chain emits `sltiu ; bnez` with an EMPTY slot (3 insns
       short).  Spelling the middle term as an assignment to `j` -- which the
       SYM names as REG $16 = $s0 and which is dead after the
       VIDEO_updateframexy arg above -- reproduces the zero-in-the-slot, the
       xor-against-the-captured-1 and the beqz byte-exactly, and takes the fn
       COUNT-EXACT: 111 diffs @819 insns -> 110 @822 (oracle 822).
       The 3rd arg's `(u_int)(u_short)` cast was the Sec.3.12 #9 redundant-mask
       class: SYM `j` is a plain SHORT and retail passes it with
       `addu a2,s0,zero`; the cast emitted `andi a2,s0,65535`.
       CARRIER CHOICE IS LOAD-BEARING (12D dead-pseudo staging): a fresh
       `int notYet` 117 @821, `shapeY` (the OTHER SYM local homed in $s0, and
       an INT) 178, `shapeX` 178, `shapeY` without the zero-default 204 @824.
       RESIDUAL AT THIS SITE = the `sll/sra 16` pair gcc inserts because `j` is
       a SHORT being tested as a word; retail's `beqz s0` has none. */
    vy = 0;
    iVar7 = VIDEO_state(this->hVideo);
    if (iVar7 != 1) {
      /* MATCH W64-A17: the elapsed-tick subtraction is its OWN named value.
         Folded into the compare, cc1plus computes it straight into the
         carrier's register (`subu s0,v1,v0`) and loads `ticks` through the
         shared %hi (`lw v1,0(v0)`); retail keeps it anonymous in $v0 with a
         SELF-TEMP ticks load (`lui v0,0; lw v0,0(v0); lw v1,108(s6);
         subu v0,v0,v1`).  Naming it splits the two and lands the whole
         cluster.  Yoda-flipping the compare instead is neutral (11). */
      u_long el = ticks - this->fStartTicks;
      vy = (0x280 < el);
    }
    if (vy && (this->fState == kScreenMain_StaticImage)) {
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
    int frameIdx;

    drawFlags.tint[0] = tintColors[this->fCurrentBG[this->fCurrentSlot]];
    drawFlags.custom_shapes = this->fSwapShapes.fShapes;
    drawAnimFade = (int)animFade;
    if (CreditManager.fCreditsInitialized != 0) {
      drawAnimFade = drawAnimFade + 0x40;
      if (0x80 < drawAnimFade) {
        drawAnimFade = 0x80;
      }
    }
    /* MATCH W63-A17 (68 -> 44, count still EXACT 822/822): the frame-index divide
       is its OWN statement AHEAD of the animLocations reads.  Retail materialises
       the %10 magic pair first (`lui a0,52428; ori a0,a0,52429`), then the
       animLocations base (`lui v1,0; addiu v1,v1,0`), then `multu t0,a0`, and only
       then loads fAnimLocation -- our fused call-argument form interleaved the two
       chains and swapped their register roles (magic in $v0, base in $a0, index in
       $v1).  w43's "independent-chain issue order is fixed by STATEMENT SPLIT, not
       operand order".  Fully inlining the x/y reads into the call args measures
       EXACTLY the same 44, but drops both SYM 8c locals (shapeX $v0, shapeY $s0),
       so the split-temp form is kept. */
    frameIdx = (deltaTicks / 0xf) % 10;
    shapeX = animLocations[this->fAnimLocation].x;
    shapeY = animLocations[this->fAnimLocation].y;
    DrawShapeExtended(frameIdx,0x611,shapeX,shapeY,drawAnimFade,1,&drawFlags);
  }
  y = 0x32;
  i = 0;
  /* MATCH W63-A17 (110 -> 84, count still EXACT 822/822): BOTH dot-grid loops are
     UN-ROTATED in retail (07C/13D).  The oracle tests i at the TOP
     (`sll;sra;slti 25;beqz`) and reaches the back-edge with `j T ; addiu s2,s2,1`
     (increment in the jump's delay slot), and the inner j-loop likewise tests at
     the top (`sll;sra;bltz`) with an IN-PLACE `addiu s0,s0,-1`.  Our `while (A && B)`
     + `for (j = 4; -1 < j; j--)` pair let jump.c's duplicate_loop_exit_test rotate
     BOTH, which costs the fresh-dest+copy decrements (`addiu v0,s0,-1; addu s0,v0,zero`)
     AND the body's own sign-extension of i (retail reuses the top test's `a0`
     via `addu s4,a0,zero`).  Measured separately: inner-only 99 @823, outer-only
     95 @821, BOTH 84 @822 = the only count-exact combination. */
  while (1) {
    if (0x19 <= i) break;
    if (0xd2 <= y) break;
    x = 0x1a2;
    j = 4;
    while (1) {
      if (j < 0) break;
      DrawShapeExtended((numberValues[(i + ticks / 0x14) % 0x19] >> j) & 1,1,x,y,0x40,3,
                 (tDrawShapeExtended *)0x0);
      j--;
      x = x + 0xd;
    }
    y = y + 8;
    i++;
  }
  /* MATCH W64-A17 (12 -> 7): 12D DEAD-PSEUDO STAGING.  Retail computes this
     bound in a caller-saved reg, TESTS it there and only then copies it into
     $s1 (`sra v1,v0,16; bltz v1,T; ... addu s1,v1,zero`); ours coloured the
     sign-extend straight into $s1 and had no copy.  $s1 is the SYM home of
     `x` (SHORT) / `deltaTicks` (ULONG), both dead here -- and the value is
     provably 16-bit (`(e << 12) >> 16` keeps only bits 4..19 of the elapsed
     tick count, sign-extended), so the SHORT carrier is exact, not a
     truncation.  Assigning into `x` (name AND use, per 12D) reproduces the
     three-insn shape.  Re-gated alternatives: `deltaTicks` (the other $s1
     SYM local, ULONG, needs an `(int)` at both compares) is EXACTLY neutral
     at 12; inlining the expression at both sites 35 @827; the fabricated
     `iVar10` was a Ghidra invention with no SYM record. */
  x = (short)((int)((ticks - this->fStartTicks) * 0x1000) >> 0x10);
  j = 0;
  if (-1 < x) {
    /* MATCH W63-A17 (84 -> 68, count still EXACT 822/822): the tvOrder loop is
       UN-ROTATED in retail too -- the `j < 16` guard is tested at the TOP
       (`sll;sra;slti 16;beqz`) and the `j <= iVar10` back-edge sits at the
       BOTTOM (`slt v0,s1,v0; beqz`); our `do { if (0xf<j) break; ... } while
       (j <= iVar10);` let jump.c rotate the guard DOWN into the back edge, so
       both tests emitted at the bottom.  The SYM 8c block lists NO local for the
       tvOrder index (bVar1 was a Ghidra invention, 06A) -- inlining it is exactly
       neutral against a block-local `byte tvIdx` (both 68) and drops the fabricated
       local.  Also landed here: `j--` BEFORE `x += 0xd` in the dot-grid inner loop
       (retail emits `addiu s0,s0,-1` ahead of `addiu s1,s1,13`), -2. */
    while (1) {
      if (0xf < j) break;
      if (((this->tvStates[tvOrder[j]] != this->tvTransitions[tvOrder[j]].state) ||
          (this->tvConfigs[tvOrder[j]].clut != this->tvTransitions[tvOrder[j]].clut)) &&
         (this->tvConfigs[tvOrder[j]].state == tv_StateOn)) {
        TurnOffTV(this->tvConfigs + tvOrder[j]);
      }
      j++;
      if (x < j) break;
    }
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
  short i;
  char buffer [32];
  
  sprintf(gPermBuffer,"zMain%d",(uint)(byte)frontEnd.language);
  this->fPreviousAnim = (short)(rand() % 0x19);
  sprintf(gNameBuffer,"yVda%02d",
          (int)this->fPreviousAnim * 0x10000 >> 0x10);
  this->tScreen::PreLoad();
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
  /* SYM types it native C++ bool (four bytes in CC1PLPSX).  A call whose
     prototype also returns bool copies directly into the local; the `&&`
     below performs the only required normalization. */
  bool shapesLoaded;
  short i;

  this->tScreen::Initialize();
  do {
    FeAudio_systemtask(0);
    shapesLoaded = ::IsShapeFileLoaded((tScreen *)this,this->fVideoShapes);
    if (this->fVideoShapes[0].fFile != (char *)0x0) {
      ::UploadShapes((tScreen *)this,this->fVideoShapes,0,0,0x10,0);
    }
    /* MATCH: ONE `&&` expression re-assigned to the SAME named flag -- gcc builds
       the value in an anonymous temp ($v1 in both arms) and emits a single
       `addu s0,v1,zero` copy into `shapesLoaded`; the `flag = false; if (...)
       flag = ...;` form writes $s0 directly in both arms (no phi copy). */
    shapesLoaded = shapesLoaded &&
                   (::IsShapeFileLoaded((tScreen *)this,this->fVideoShapes + 1) != 0);
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
  int i;

  i = 0;
  VIDEO_destroy(this->hVideo);
  purgememadr((void *)this->hVideo);
  do {
    ::FreeShapes((tScreen *)this,this->fVideoShapes + i);
    i = i + 1;
  } while (i < 2);
  this->tScreen::Cleanup();
  return;
}



/* ---- tScreenMain::dtor  [SCREENMAIN.CPP:162-851] ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___11tScreenMain(void *thisp) { ___7tScreen(thisp); }



/* end of screenmain.cpp */

tScreenMain *screenMain;   /* @0x80051e58; SYM EXT */
