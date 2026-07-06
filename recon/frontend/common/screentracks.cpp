/* frontend/screens/screentracks.cpp -- RECONSTRUCTED (track-select screen; C++ TU)
 *   10 member fns of tScreenTrackSelect (embeds tScreen base as _base_tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom regs resolved vs disasm.
 */
#include "screentracks.h"


/* ---- tScreenTrackSelect::DrawBackground ---- */
void tScreenTrackSelect::DrawBackground()

{
  short tpage;
  short creditsTextVal;
  short tpage2;
  int videoState;
  int frameAdvanced;
  VIDEOSTATE state;
  int pkt_addr24;
  short bright;
  int pkt_addr24_2;
  uint tu1;
  byte swapShapesReady;
  byte videoFinished;
  short shapeY;
  int movieFrame_p;
  RECT r;
  RECT r2;
  tTrackInformation trackInfo;
  char moviename [80];
  u_char *cur_pkt;
  u_char *prev_pkt;
  u_char *cur_pkt_2;
  byte frameEven;
  int movieRetCode;
  u_char *prev_pkt_2;
  void *tp1;
  
  r.x = 0x140;
  r.y = 200;
  r.w = 0xaa;
  r.h = 0xc;
  creditsTextVal = TextValue(&menuDefs->iteratorTrack,kPlayerBoth);
  DrawShape_NFS4RoundRectangle((int)creditsTextVal,&r,0);
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[0],&trackInfo);
  this->UpdateBrightness(trackInfo);
  this->UpdateVideoWall(trackInfo);
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  if (((this->fSwapShapes.fFile != (char *)0x0) &&
      ((this->fVideoWall).fTransitionDirection != -1)) && (this->fBrightness == 0)) {
    ::UploadSwapShapes((tScreen *)this,10);
    TurnOn(&this->fVideoWall);
  }
  frameEven = (this->fFrame & 1U) == 0;
  swapShapesReady = frameEven << 7;
  videoState = VIDEO_state(this->hVideo);
  if (videoState == 1) {
    r2.w = 0xaa;
    r2.x = 0x200;
    r2.y = 0;
    r2.h = 0x100;
    ClearImage(&r2,'\0','\0','\0');
    DrawSync(0);
    movieRetCode = ticks[0];
    this->fBrightness = 0;
    this->fStartTicks = movieRetCode - 0x14;
  }
  else if (videoState == 3) {
    frameAdvanced = VIDEO_updateframexy
                    (this->hVideo,0x200,((uint)frameEven << 0x17) >> 0x10);
    if (frameAdvanced != 0) {
      tu1 = this->fFrame + 1;
      swapShapesReady = ((tu1 & 1) == 0) << 7;
      this->fFrame = tu1;
    }
  }
  else if (((this->fTicksSet != 0) || (this->fDestBrightness < this->fBrightness)) &&
          (0x100 < ticks[0] - this->fVideoTicks)) {
    if (this->fBrightness <= this->fDestBrightness) {
      bright = 0x20;
      if (trackInfo.fAvailable != '\0') {
        bright = 0x80;
      }
      this->SetBrightness(bright);
    }
    sprintf
              (moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],(int)this->fMovieTrack);
    VIDEO_spoolfile(this->hVideo,moviename);
    VIDEO_startplayback(this->hVideo);
  }
  cur_pkt = Render_gPacketPtr;
  prev_pkt = Render_gPalettePtr;
  if (0 < this->fBrightness) {
    videoFinished = swapShapesReady | 0x7f;
    *(uint *)Render_gPacketPtr =
         *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
    pkt_addr24 = (uint)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x28;
    *(uint *)prev_pkt = *(uint *)prev_pkt & 0xff000000 | pkt_addr24;
    pkt_addr24_2 = (int)this->fBrightness;
    cur_pkt[3] = 9;
    *(u_short *)(cur_pkt + 10) = 0x69;
    *(u_short *)(cur_pkt + 0x12) = 0x69;
    *(u_short *)(cur_pkt + 8) = 0x99;
    *(u_short *)(cur_pkt + 0x18) = 0x99;
    *(u_short *)(cur_pkt + 0x10) = 0x139;
    *(u_short *)(cur_pkt + 0x1a) = 0xe8;
    *(u_short *)(cur_pkt + 0x20) = 0x139;
    *(u_short *)(cur_pkt + 0x22) = 0xe8;
    cur_pkt[0xc] = 0;
    cur_pkt[0xd] = swapShapesReady;
    cur_pkt[0x14] = 0x50;
    cur_pkt[0x15] = swapShapesReady;
    cur_pkt[0x1c] = 0;
    cur_pkt[0x1d] = videoFinished;
    cur_pkt[0x24] = 0x50;
    cur_pkt[0x25] = videoFinished;
    *(int *)(cur_pkt + 4) = pkt_addr24_2 << 0x10 | pkt_addr24_2 << 8 | pkt_addr24_2;
    cur_pkt[7] = 0x2e;
    tpage = GetTPage(2,1,0x200,0);
    *(short *)(cur_pkt + 0x16) = tpage;
    *(u_short *)(cur_pkt + 0xe) = 0;
    prev_pkt_2 = Render_gPacketPtr;
    cur_pkt_2 = Render_gPalettePtr;
    *(uint *)Render_gPacketPtr =
         *(uint *)Render_gPacketPtr & 0xff000000 | *(uint *)Render_gPalettePtr & 0xffffff;
    *(uint *)cur_pkt_2 = *(uint *)cur_pkt_2 & 0xff000000 | (uint)Render_gPacketPtr & 0xffffff;
    tu1 = (uint)this->fBrightness;
    tp1 = Render_gPacketPtr + 3;
    Render_gPacketPtr = Render_gPacketPtr + 0x28;
    *(u_char *)tp1 = 9;
    *(u_short *)(prev_pkt_2 + 0x10) = 0x1d9;
    *(u_short *)(prev_pkt_2 + 0x20) = 0x1d9;
    prev_pkt_2[0x14] = 0x60;
    prev_pkt_2[0x24] = 0x60;
    *(u_short *)(prev_pkt_2 + 10) = 0x69;
    *(u_short *)(prev_pkt_2 + 0x12) = 0x69;
    *(uint *)(prev_pkt_2 + 4) = tu1 << 0x10 | tu1 << 8 | tu1;
    *(u_short *)(prev_pkt_2 + 8) = 0x139;
    *(u_short *)(prev_pkt_2 + 0x18) = 0x139;
    *(u_short *)(prev_pkt_2 + 0x1a) = 0xe8;
    *(u_short *)(prev_pkt_2 + 0x22) = 0xe8;
    prev_pkt_2[0xc] = 0x10;
    prev_pkt_2[0xd] = swapShapesReady;
    prev_pkt_2[0x15] = swapShapesReady;
    prev_pkt_2[0x1c] = 0x10;
    prev_pkt_2[0x1d] = videoFinished;
    prev_pkt_2[0x25] = videoFinished;
    prev_pkt_2[7] = 0x2e;
    tpage2 = GetTPage(2,1,0x240,0);
    *(short *)(prev_pkt_2 + 0x16) = tpage2;
    *(u_short *)(prev_pkt_2 + 0xe) = 0;
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
            (moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],(int)trackInfo.fTrackID);
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
  iVar1 = ticks[0];
  this->fTicksSet = 1;
  this->fVideoTicks = iVar1 - 0x100;
  this->fMovieTrack = (short)trackInfo.fTrackID;
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



/* ---- tScreenTrackSelect::UpdateBrightness ---- */
void tScreenTrackSelect::UpdateBrightness(tTrackInformation &trackInfo)

{
  long elapsed;
  
  elapsed = ticks[0] - this->fStartTicks;
  if ((int)this->fDestBrightness != (int)this->fBrightness) {
    if (elapsed < 0x80) {
      if (elapsed < 0) {
        this->fBrightness = 0;
      }
      else {
        elapsed = ((int)this->fDestBrightness - (int)this->fStartBrightness) * elapsed;
        if (elapsed < 0) {
          elapsed = elapsed + 0x7f;
        }
        this->fBrightness = this->fStartBrightness + (short)(elapsed >> 7);
      }
    }
    else {
      this->fBrightness = this->fDestBrightness;
    }
  }
  elapsed = (this->fBrightness == 0 && this->fDestBrightness == 0) ? 0 : 1;
  if ((elapsed == 0) &&
     (VIDEO_abortplayback(this->hVideo), elapsed = ticks[0],
     this->fTicksSet == 0)) {
    this->fTicksSet = 1;
    this->fVideoTicks = elapsed;
    this->fMovieTrack = (short)trackInfo.fTrackID;
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
int tScreenTrackSelect::ProcessInput(tPlayer player,tInputKeyType &keyval,
              tMenuCommand &command)

{
  tGlobalMenuDefs *ptVar1;
  void *pvVar2;
  __vtbl_ptr_type (*menuVtbl) [11];
  uint cmdResult;
  tTrackInformation trackInfo;
  
  if (keyval != kInput_KeyType_Square) {
    if (keyval != kInput_KeyType_Triangle) {
      return -0x7ffb0000;
    }
    menuVtbl = FEApp->fCurrentMenu[0]->_vf;
    cmdResult = (*(*menuVtbl)[8].pfn)
                      ((int)FEApp->fCurrentMenu[0]->fItemList + (*menuVtbl)[8].delta + -0x10);
    cmdResult = cmdResult ^ 1;
    if (cmdResult == 0) {
      return 0;
    }
    TurnOffInstant(&this->fVideoWall);
    return cmdResult;
  }
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
             &trackInfo);
  ptVar1 = menuDefs;
  cmdResult = (menuDefs->itemTraffic).fFlags &
          0xfffffffe;
  (menuDefs->itemTraffic).fFlags = cmdResult;
  if ((frontEnd.gameMode != '\x01') && (frontEnd.oppNumber == '\x02')) {
    (ptVar1->itemTraffic).fFlags = cmdResult | 1
    ;
  }
  if (2 < trackInfo.fTrackDifficulty) {
    (menuDefs->itemTraffic).fFlags =
         (menuDefs->itemTraffic).fFlags | 1;
  }
  if (trackInfo.fIsEgg != '\0') {
    (menuDefs->itemTraffic).fFlags =
         (menuDefs->itemTraffic).fFlags | 1;
  }
  if (frontEnd.gameMode == '\x01') {
    if (frontEnd.raceType != '\x01') goto ProcInpLocSpch_setFlags;
    (menuDefs->itemTraffic).fFlags =
         (menuDefs->itemTraffic).fFlags | 1;
  }
  if ((frontEnd.raceType == '\x01') &&
     (pvVar2 = Front_EnableLocalSpeech(), pvVar2 != (void *)0x0))
  {
    cmdResult = (menuDefs->itemLocalSpeech).
            fFlags & 0xfffffffe;
    (menuDefs->itemLocalSpeech).fFlags =
         cmdResult;
    return cmdResult;
  }
ProcInpLocSpch_setFlags:
  cmdResult = (menuDefs->itemLocalSpeech).fFlags
          | 1;
  (menuDefs->itemLocalSpeech).fFlags = cmdResult
  ;
  return cmdResult;
}



/* ---- tScreenTrackSelect::dtor ---- */
tScreenTrackSelect::~tScreenTrackSelect()

{
  return;
}



/* end of screentracks.cpp */
