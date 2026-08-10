/* frontend/screens/screentracks.cpp -- RECONSTRUCTED (track-select screen; C++ TU)
 *   10 member fns of tScreenTrackSelect (embeds tScreen base as _base_tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom regs resolved vs disasm.
 */
#include "screentracks.h"

typedef struct {
  u_int addr : 24;
  u_int len : 8;
} tTrackSelectPrimTag;


/* ---- tScreenTrackSelect::DrawBackground ---- */
void tScreenTrackSelect::DrawBackground()

{
  short creditsTextVal;
  short shapeY;
  RECT r;
  tTrackInformation trackInfo;
  POLY_FT4 *prim;
  VIDEOSTATE state;
  
  r.x = 0x140;
  r.y = 200;
  r.w = 0xaa;
  r.h = 0xc;
  creditsTextVal = TextValue(&menuDefs->iteratorTrack,kPlayerBoth);
  DrawShape_NFS4RoundRectangle(creditsTextVal,&r,0);
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[0],&trackInfo);
  this->UpdateBrightness(trackInfo);
  this->UpdateVideoWall(trackInfo);
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  {
    tVideoWall *videoWall = &this->fVideoWall;

    if (((this->fSwapShapes.fFile != (char *)0x0) &&
        (videoWall->fTransitionDirection != -1)) && (this->fBrightness == 0)) {
      ::UploadSwapShapes((tScreen *)this,10);
      TurnOn(videoWall);
    }
  }
  shapeY = ((this->fFrame & 1U) == 0) << 7;
  state = (VIDEOSTATE)VIDEO_state(this->hVideo);
  if (state == VIDEOSTATE_SPOOLING) {
    RECT r;
    int startTicks;

    r.w = 0xaa;
    r.x = 0x200;
    r.y = 0;
    r.h = 0x100;
    ClearImage(&r,'\0','\0','\0');
    DrawSync(0);
    startTicks = ticks[0];
    this->fBrightness = 0;
    this->fStartTicks = startTicks - 0x14;
  }
  else if (state == VIDEOSTATE_PLAYING) {
    if (VIDEO_updateframexy(this->hVideo,0x200,(u_short)shapeY) != 0) {
      this->fFrame = this->fFrame + 1;
      shapeY = ((this->fFrame & 1U) == 0) << 7;
    }
  }
  else if (((this->fTicksSet != 0) || (this->fDestBrightness < this->fBrightness)) &&
          ((uint)(ticks[0] - this->fVideoTicks) >= 0x101U)) {
    if (this->fDestBrightness >= this->fBrightness) {
      this->SetBrightness(trackInfo.fAvailable != '\0' ? 0x80 : 0x20);
    }
    {
      char moviename[80];

      sprintf(moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],
              (int)this->fMovieTrack);
      VIDEO_spoolfile(this->hVideo,moviename);
    }
    VIDEO_startplayback(this->hVideo);
  }
  if (0 < this->fBrightness) {
    /* MATCH: the EA/PsyQ quad wrapper materializes its texture-X origin for
       both UV and tpage arithmetic.  Recreate that hidden macro temporary;
       rematerializing 0x200 before the second quad also avoids a call spill. */
    short textureX = 0x200;

    __asm__("" : "+r"(textureX));
    (prim = (POLY_FT4 *)Render_gPacketPtr,
     ((tTrackSelectPrimTag *)prim)->addr = *(u_int *)Render_gPalettePtr,
     Render_gPacketPtr = (u_char *)prim + sizeof(POLY_FT4),
     ((tTrackSelectPrimTag *)Render_gPalettePtr)->addr = (u_int)prim);
    *(u_int *)&prim->r0 = this->fBrightness << 0x10 |
                          this->fBrightness << 8 | this->fBrightness;
    (((tTrackSelectPrimTag *)prim)->len = 9, prim->code = 0x2e);
    (prim->x0 = 0x99, prim->y0 = 0x69,
     prim->x1 = 0x139, prim->y1 = 0x69,
     prim->x2 = 0x99, prim->y2 = 0xe8,
     prim->x3 = 0x139, prim->y3 = 0xe8);
    (prim->u0 = textureX & 0x3f, prim->v0 = shapeY,
     prim->u1 = (textureX & 0x3f) + 0x50, prim->v1 = shapeY,
     prim->u2 = textureX & 0x3f, prim->v2 = shapeY | 0x7f,
     prim->u3 = (textureX & 0x3f) + 0x50, prim->v3 = shapeY | 0x7f);
    prim->tpage = GetTPage(2,1,textureX & ~0x3f,shapeY & ~0xff);
    prim->clut = 0;

    textureX = 0x200;
    __asm__("" : "+r"(textureX));
    textureX += 0x50;
    (prim = (POLY_FT4 *)Render_gPacketPtr,
     ((tTrackSelectPrimTag *)prim)->addr = *(u_int *)Render_gPalettePtr,
     Render_gPacketPtr = (u_char *)prim + sizeof(POLY_FT4),
     ((tTrackSelectPrimTag *)Render_gPalettePtr)->addr = (u_int)prim);
    *(u_int *)&prim->r0 = this->fBrightness << 0x10 |
                          this->fBrightness << 8 | this->fBrightness;
    (((tTrackSelectPrimTag *)prim)->len = 9, prim->code = 0x2e);
    (prim->x0 = 0x139, prim->y0 = 0x69,
     prim->x1 = 0x1d9, prim->y1 = 0x69,
     prim->x2 = 0x139, prim->y2 = 0xe8,
     prim->x3 = 0x1d9, prim->y3 = 0xe8);
    (prim->u0 = textureX & 0x3f, prim->v0 = shapeY,
     prim->u1 = (textureX & 0x3f) + 0x50, prim->v1 = shapeY,
     prim->u2 = textureX & 0x3f, prim->v2 = shapeY | 0x7f,
     prim->u3 = (textureX & 0x3f) + 0x50, prim->v3 = shapeY | 0x7f);
    prim->tpage = GetTPage(2,1,textureX & ~0x3f,shapeY & ~0xff);
    prim->clut = 0;
  }
  this->DrawVideoWall();
  return;
}



/* ---- tScreenTrackSelect::GetShapeInfo ---- */
void tScreenTrackSelect::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  tTrackInformation trackInfo;
  
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[0],&trackInfo);
  numPermShapes = 0x44;
  numSwapShapes = 10;
  *permFileName = "ztrack";
  sprintf(gSwapFileName,"%s",trackInfo.fShapeName);
  *swapFileName = gSwapFileName;
  this->fPreviousTrack = (short)(signed char)trackInfo.fTrackID;
  return;
}



/* ---- tScreenTrackSelect::Initialize ---- */
void tScreenTrackSelect::Initialize()

{
  int iVar1;
  tVideoWall *this_00;
  tTrackInformation trackInfo;
  RECT r;
  char moviename [80];
  
  frontEnd.pinkSlipsTrackIndex = '\0';
  Decrement(&menuDefs->iteratorTrack,kPlayerBoth);
  Increment(&menuDefs->iteratorTrack,kPlayerBoth);
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[0],&trackInfo);
  r.x = 0x200;
  r.w = 0xaa;
  r.y = 0;
  r.h = 0x100;
  ClearImage(&r,'\0','\0','\0');
  DrawSync(0);
  this->Initialize();
  sprintf
            (moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],(int)(signed char)trackInfo.fTrackID);
  iVar1 = VIDEO_create(0xa0,0x80,0xf0000,0x2c000,0x10);
  this->hVideo = iVar1;
  VIDEO_spoolfile(iVar1,moviename);
  this_00 = &this->fVideoWall;
  VIDEO_startplayback(this->hVideo);
  this->fFrame = 0;
  ::Initialize(this_00,this->tvConfigs,this->fSwapShapes.fShapes,0,10,tvOrder,0x96);
  SetAvailableText(this_00,0xf8,0x140,0x50);
  SetAvailableIcon(this_00,0x26,10,0x136,0x3c,this->fPermShapes.fShapes);
  this->fBrightness = 0;
  this->fDestBrightness = 0;
  this->fTVsInitialized = 0;
  TurnOn(this_00);
  /* MATCH: retail computes the dependent tick value before publishing fTicksSet. */
  this->fVideoTicks = ticks[0] - 0x100;
  this->fTicksSet = 1;
  this->fMovieTrack = (short)(signed char)trackInfo.fTrackID;
  return;
}



/* ---- tScreenTrackSelect::Cleanup ---- */
void tScreenTrackSelect::Cleanup()

{
  
  VIDEO_destroy(this->hVideo);
  purgememadr((void *)this->hVideo);
  this->Cleanup();
  return;
}



/* ---- tScreenTrackSelect::SetBrightness ---- */
void tScreenTrackSelect::SetBrightness(short bright)

{
  int iVar1;
  short curBrightness;

  if (bright != this->fDestBrightness) {
    curBrightness = this->fBrightness;
    iVar1 = ticks[0];
    this->fDestBrightness = bright;
    this->fStartBrightness = curBrightness;
    this->fStartTicks = iVar1;
  }
  return;
}



/* ---- tScreenTrackSelect::UpdateBrightness ----
   MATCH: 60/60.  SLD lines 277-286 reveal a three-way chain in source order:
   finished, nonnegative interpolation, negative clamp.  Keeping the interpolation
   as signed division by 128 lets gcc emit its own rounding sequence.  The named
   `elapsed = ticks[0]` assignment inside the fTicksSet guard also gives retail's
   delay-slot address setup and carries the tick value across the flag store. */
void tScreenTrackSelect::UpdateBrightness(tTrackInformation &trackInfo)

{
  long elapsed;
  
  elapsed = ticks[0] - this->fStartTicks;
  if ((int)this->fDestBrightness != (int)this->fBrightness) {
    if (elapsed >= 0x80) {
      this->fBrightness = this->fDestBrightness;
    }
    else if (elapsed >= 0) {
      this->fBrightness = this->fStartBrightness +
          (short)(((int)this->fDestBrightness - (int)this->fStartBrightness) * elapsed / 0x80);
    }
    else {
      this->fBrightness = 0;
    }
  }
  if ((this->fBrightness == 0) && (this->fDestBrightness == 0)) {
    VIDEO_abortplayback(this->hVideo);
    if (this->fTicksSet == 0) {
      elapsed = ticks[0];
      this->fTicksSet = 1;
      this->fVideoTicks = elapsed;
      this->fMovieTrack = (short)(signed char)trackInfo.fTrackID;
    }
  }
  return;
}



/* ---- tScreenTrackSelect::UpdateVideoWall ---- */
void tScreenTrackSelect::UpdateVideoWall(tTrackInformation &trackInfo)

{
  
  if ((int)(signed char)trackInfo.fTrackID != (int)this->fPreviousTrack) {
    ::AsyncLoadSwapShapeFile((tScreen *)this,trackInfo.fShapeName);
    this->fTVsInitialized = 0;
    this->fPreviousTrack = (short)(signed char)trackInfo.fTrackID;
    TurnOff(&this->fVideoWall);
    this->SetBrightness(0);
    this->fTicksSet = 0;
  }
  return;
}



/* ---- tScreenTrackSelect::DrawVideoWall ---- */
void tScreenTrackSelect::DrawVideoWall()

{
  tTrackInformation trackInfo;
  
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
             &trackInfo);
  FETextRender_MenuTextPositionedJustify
            (trackInfo.fSpeedoCountry + 0x43,0x1de,0x21,1,textState_Unselected,textType_TrackRecords
            );
  ::DrawBackgroundImage((tScreen *)this,0,0x1c,this->fPermShapes.fShapes,0x96);
  PSXDrawTransSquare(0,0x140,0x1e,0xa0,10,1);
  FeDraw_SetABRMode(0);
  if (((this->fSwapShapes.fFlags & 1) != 0) && (this->fTVsInitialized == 0)) {
    SetAvailable(&this->fVideoWall,(ushort)trackInfo.fAvailable);
    UpdateImages(&this->fVideoWall);
    this->fTVsInitialized = 1;
  }
  ::UpdateTransition(&this->fVideoWall);
  ::Draw(&this->fVideoWall);
  return;
}



/* ---- tScreenTrackSelect::ProcessInput ---- */
/* MATCH: unsized-array asm-label view of menuDefs -- makes the %hi an RTL
   pseudo so cc1 CSEs ONE `lui $v0,%hi(menuDefs)` across the flag blocks and
   loads through a SEPARATE scratch (oracle `lui $v0; lw $v1,%lo(..)($v0)`)
   instead of the self-temp `lui $v1; lw $v1,0($v1)`. */
extern tGlobalMenuDefs *menuDefsA[] asm("menuDefs");
extern tFEApplication *FEAppA[] asm("FEApp");

void tScreenTrackSelect::ProcessInput(tPlayer player,tInputKeyType &keyval,
              tMenuCommand &command)

{
  /* MATCH (SLD 341-370 + SYM fsize 72 / mask $80010000 = ra,s0 only):
     the SQUARE arm is the INLINE one (oracle `bne $a2,8,.L80042178` branches
     AWAY to the Triangle arm); the recon had them the other way round, which
     rotated the whole body.  Note $s0 holds `this` on the Triangle path and is
     REASSIGNED to &frontEnd on the Square path.
     There is NO `return -0x7ffb0000`: the `lui $v0,0x8005` that produced it is
     just the `lui $v0,%hi(FEApp)` sitting in the `bne` delay slot at 0x80042178,
     and the SYM types this function FCN VOID -- the Triangle tail simply falls
     into the epilogue with $v0 incidental.
     [2026-08-03, 12->PASS] Keep the Square arm's masked trafficFlags in its
     own block-local pseudo instead of reusing the Triangle arm's cmdResult.
     With ptVar1 retained for the two stores, GCC assigns retail's menuDefs
     base to $a0 and trafficFlags to $a1, with no reload or extra instruction. */
  tGlobalMenuDefs *ptVar1;
  void *pvVar2;
  __vtbl_ptr_type (*menuVtbl) [11];
  uint cmdResult;
  tTrackInformation trackInfo;

  if (keyval == kInput_KeyType_Square) {
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               &trackInfo);
    uint trafficFlags;

    ptVar1 = menuDefsA[0];
    trafficFlags = (ptVar1->itemTraffic).fFlags & 0xfffffffe;
    (ptVar1->itemTraffic).fFlags = trafficFlags;
    if ((frontEnd.gameMode != '\x01') && (frontEnd.oppNumber == '\x02')) {
      (ptVar1->itemTraffic).fFlags = trafficFlags | 1;
    }
    if (2 < trackInfo.fTrackDifficulty) {
      (menuDefsA[0]->itemTraffic).fFlags =
           (menuDefsA[0]->itemTraffic).fFlags | 1;
    }
    if (trackInfo.fIsEgg != '\0') {
      (menuDefsA[0]->itemTraffic).fFlags =
           (menuDefsA[0]->itemTraffic).fFlags | 1;
    }
    if (frontEnd.gameMode == '\x01') {
      if (frontEnd.raceType != '\x01') goto ProcInpLocSpch_setFlags;
      (menuDefsA[0]->itemTraffic).fFlags =
           (menuDefsA[0]->itemTraffic).fFlags | 1;
    }
    if ((frontEnd.raceType == '\x01') &&
       (pvVar2 = Front_EnableLocalSpeech(), pvVar2 != (void *)0x0))
    {
      (menuDefsA[0]->itemLocalSpeech).fFlags =
           (menuDefsA[0]->itemLocalSpeech).fFlags & 0xfffffffe;
      return;
    }
ProcInpLocSpch_setFlags:
    (menuDefsA[0]->itemLocalSpeech).fFlags =
         (menuDefsA[0]->itemLocalSpeech).fFlags | 1;
    return;
  }
  if (keyval == kInput_KeyType_Triangle) {
    menuVtbl = FEAppA[0]->fCurrentMenu[0]->_vf;
    cmdResult = (*(*menuVtbl)[8].pfn)
                      ((int)FEAppA[0]->fCurrentMenu[0]->fItemList + -0x10 + (*menuVtbl)[8].delta);
    if ((cmdResult ^ 1) != 0) {
      TurnOffInstant(&this->fVideoWall);
    }
  }
  /* NO return statement -- the SYM types this FCN VOID and the oracle's tail
     falls straight into the epilogue ($v0 incidental).  A literal `return 0;`
     emits three un-merged `addu $v0,$zero,$zero`. */
}



/* ---- tScreenTrackSelect::dtor ---- */
tScreenTrackSelect::~tScreenTrackSelect()

{
  return;
}



/* end of screentracks.cpp */
