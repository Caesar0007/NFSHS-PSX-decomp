/* frontend/screens/screenpinkslips.cpp -- RECONSTRUCTED (pink-slips betting setup screen; C++ TU)
 *   single class tScreenPinkSlips : tScreen ; 8 fns (no ctor emitted in this TU).
 *   Phantoms (DrawShapeExtended/PSXDrawTransSquare loop args, gSwapFileName, imageTVOrder,
 *   void ProcessInput) resolved via m2c oracle C:\Temp\nfs4-split\cur_c\front\*.c
 */
#include "screenpinkslips.h"


/* ---- tScreenPinkSlips::DrawBackground  [SCREENPINKSLIPS.CPP:71-194] ---- */
void tScreenPinkSlips::DrawBackground()

{
  bool bVar1;
  short index;
  ushort uVar2;
  uint uVar3;
  int iVar4;
  uint uVar5;
  int j;
  int flare_intensity;
  tMenuTextState textState;
  short i;
  short tv;
  int iVar8;
  RECT r;
  tTrackInformation trackInfo;
  char moviename [80];
  short shapeY;
  
  i = 0;
  r.x = 0x15b;
  r.y = 0x8f;
  r.w = 0x90;
  r.h = 0xe;
  while( true ) {
    iVar4 = (int)i;
    textState = textState_Selected;
    if ((int)(uint)(byte)frontEnd.pinkSlipsNumTracks <= iVar4) break;
    flare_intensity = (int)(short)this->fMenu->fCurrentItem;
    bVar1 = false;
    if ((iVar4 == flare_intensity + -1) || ((iVar4 == 0 && (flare_intensity == 0)))) {
      bVar1 = true;
    }
    if (bVar1) {
      flareextra_248 = flareextra_248 + 1;
      if (0x3c < flareextra_248) {
        flareextra_248 = 0;
      }
      uVar3 = (uint)flareextra_248 >> 0x1f;
      uVar5 = flareextra_248;
      if (0x1e < flareextra_248) {
        uVar3 = 0x3c - flareextra_248;
        uVar5 = uVar3 >> 0x1f;
      }
      iVar4 = (((int)(uVar5 + uVar3) >> 1) + 0x14) * (0x80 - this->fScreenFadeVal);
      if (0 < iVar4) {
        Flare_2DHalo(r.x + -0xf,r.y + 6,iVar4 / 2,(iVar4 * 2) / 3,0x17);
        DrawShapeExtended(0x38,0,r.x + -0x12,r.y,
                   (int)this->fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
      }
      textState = textState_Hilighted;
    }
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[i],&trackInfo);
    frontEnd.pinkSlipsTrackIndex = (char)i;
    index = TextValue(&menuDefs->iteratorTrack,kPlayerBoth);
    FETextRender_MenuTextPositionedJustify(index,r.x + 10,r.y + 3,0,textState,textType_FlybyHelp);
    DrawShape_NFS4RoundRectangle(-1,&r,1);
    i = i + 1;
    r.y = r.y + 0xe;
  }
  uVar2 = (ushort)this->fMenu->fCurrentItem;
  frontEnd.pinkSlipsTrackIndex = (char)uVar2;
  if ((uVar2 & 0xff) != 0) {
    frontEnd.pinkSlipsTrackIndex = frontEnd.pinkSlipsTrackIndex + -1;
  }
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
             &trackInfo);
  this->UpdateVideoWall(trackInfo);
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  if ((this->fSwapShapes.fFile != (char *)0x0) && (-1 < this->fTransitionDirection)) {
    ::UploadSwapShapes((tScreen *)this,4);
    this->fTransitionDirection = '\x01';
    this->fTVTicks = ticks;
  }
  this->DrawVideoWall();
  bVar1 = (this->fFrame & 1U) == 0;
  shapeY = (ushort)bVar1 << 7;
  iVar4 = VIDEO_state(this->hVideo);
  if (iVar4 == 0) {
    if (0x100 < ticks - this->fTVTicks) {
      sprintf(moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],(int)trackInfo.fTrackID);
      VIDEO_spoolfile(this->hVideo,moviename);
      VIDEO_startplayback(this->hVideo);
    }
  }
  else {
    iVar4 = VIDEO_updateframexy(this->hVideo,0x200,(uint)bVar1 << 7);
    tv = 0;
    if (iVar4 != 0) {
      uVar5 = this->fFrame + 1;
      shapeY = (ushort)((uVar5 & 1) == 0) << 7;
      this->fFrame = uVar5;
    }
    iVar4 = 0;
    do {
      j = 0;
      iVar8 = (short)iVar4 * 0x40;
      do {
        this->fTrackTVs[tv].x = (short)j * 0x50 + 0xa0;
        this->fTrackTVs[tv].y = (short)iVar8 + 0x19;
        this->fTrackTVs[tv].w = 0x50;
        this->fTrackTVs[tv].h = 0x40;
        this->fTrackTVs[tv].u = (char)j * '(';
        this->fTrackTVs[tv].v = (char)iVar8 + (char)shapeY;
        this->fTrackTVs[tv].uw = '(';
        this->fTrackTVs[tv].vh = '@';
        if ((short)iVar4 == 1) {
          this->fTrackTVs[tv].vh = '?';
        }
        uVar2 = GetTPage(2,0,0x200,(int)shapeY);
        j = j + 1;
        this->fTrackTVs[tv].tpage = uVar2;
        this->fTrackTVs[tv].clut = 0;
        this->fTrackTVs[tv].flags = 0x20;
        this->fTrackTVs[tv].tint = 0x808080;
        this->fTrackTVs[tv].state = tv_StateOn;
        tv = tv + 1;
      } while (j * 0x10000 >> 0x10 < 4);
      iVar4 = iVar4 + 1;
    } while (iVar4 * 0x10000 >> 0x10 < 2);
  }
  iVar4 = 0xf0;
  do {
    PSXDrawTransSquare(0x303030,iVar4,0xf,2,0x81,1);
    iVar4 = iVar4 + 0x50;
  } while (iVar4 * 0x10000 >> 0x10 < 0x1e0);
  iVar4 = 0x4f;
  do {
    PSXDrawTransSquare(0x202020,0xa0,iVar4,0x141,1,1);
    iVar4 = iVar4 + 0x40;
  } while (iVar4 * 0x10000 >> 0x10 < 0x8f);
  FeDraw_SetABRMode(2);
  iVar4 = 0;
  do {
    DrawTV(this->fTrackTVs + (short)iVar4);
    iVar4 = iVar4 + 1;
  } while (iVar4 * 0x10000 >> 0x10 < 8);
  return;
}



/* ---- tScreenPinkSlips::GetShapeInfo  [SCREENPINKSLIPS.CPP:202-214] ---- */
void tScreenPinkSlips::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName
               ,char **swapFileName)

{
  tTrackInformation trackInfo;
  
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[0],&trackInfo);
  numPermShapes = 0x39;
  numSwapShapes = 4;
  *permFileName = "zPink";
  sprintf(gSwapFileName,"TR%02dPS",(int)(signed char)trackInfo.fTrackID);
  *swapFileName = gSwapFileName;
  this->fPreviousTrack = (short)(signed char)trackInfo.fTrackID;
  return;
}



/* ---- tScreenPinkSlips::Initialize  [SCREENPINKSLIPS.CPP:219-259] ---- */
void tScreenPinkSlips::Initialize()

{
  int iVar1;
  int tmp;
  RECT r;
  char moviename [80];
  tTrackInformation trackInfo;
  
  r.x = 0x200;
  r.w = 0xaa;
  r.y = 0;
  r.h = 0x100;
  ClearImage(&r,'\0','\0','\0');
  DrawSync(0);
  frontEnd.pinkSlipsTrackIndex = '\0';
  Decrement(&menuDefs->iteratorTrack,kPlayerBoth);
  Increment(&menuDefs->iteratorTrack,kPlayerBoth);
  this->fMenu = FEApp->fCurrentMenu[0];
  this->Initialize();
  this->fTVsInitialized = 0;
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[0],&trackInfo);
  sprintf(moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],(int)trackInfo.fTrackID);
  tmp = VIDEO_create(0xa0,0x80,0xf0000,0x20000,0x10);
  this->hVideo = tmp;
  VIDEO_spoolfile(tmp,moviename);
  VIDEO_startplayback(this->hVideo);
  iVar1 = ticks;
  this->fFrame = 0;
  this->fBrightness = 0;
  this->fDestBrightness = 0;
  this->fTVsInitialized = 0;
  this->fTransitionDirection = '\x01';
  this->fTVTicks = iVar1;
  return;
}



/* ---- tScreenPinkSlips::Cleanup  [SCREENPINKSLIPS.CPP:263-269] ---- */
void tScreenPinkSlips::Cleanup()

{
  
  VIDEO_destroy(this->hVideo);
  purgememadr((void *)this->hVideo);
  frontEnd.pinkSlipsTrackIndex = '\0';
  this->Cleanup();
  return;
}



/* ---- tScreenPinkSlips::UpdateVideoWall  [SCREENPINKSLIPS.CPP:300-315] ---- */
void tScreenPinkSlips::UpdateVideoWall(tTrackInformation &trackInfo)

{
  int iVar1;
  
  if ((short)trackInfo.fTrackID != this->fPreviousTrack) {
    sprintf(gSwapFileName,"TR%02dPS",(int)trackInfo.fTrackID);
    ::AsyncLoadSwapShapeFile((tScreen *)this,gSwapFileName);
    this->fTVsInitialized = 0;
    this->fPreviousTrack = (short)trackInfo.fTrackID;
    iVar1 = ticks;
    if (-1 < this->fTransitionDirection) {
      this->fTransitionDirection = -1;
      this->fTVTicks = iVar1;
    }
    VIDEO_abortplayback(this->hVideo);
  }
  return;
}



/* ---- tScreenPinkSlips::DrawVideoWall  [SCREENPINKSLIPS.CPP:324-367] ---- */
void tScreenPinkSlips::DrawVideoWall()

{
  short tv_ticks;
  int iVar1;
  int j;
  int i_packed;
  int i;
  int iVar2;
  
  i = 0;
  do {
    DrawShapeExtended((short)i,0,0,0,0,0,
               (tDrawShapeExtended *)0x0);
    i = i + 1;
  } while (i * 0x10000 >> 0x10 < 0x24);
  if (((this->fSwapShapes.fFlags & 1) != 0) && (this->fTVsInitialized == 0)) {
    iVar2 = 0;
    i_packed = 0;
    do {
      InitTV(this->fImageTVs + (i_packed >> 0x10),this->fSwapShapes.fShapes,
                 (short)((uint)i_packed >> 0x10));
      iVar2 = iVar2 + 1;
      i_packed = iVar2 * 0x10000;
    } while (iVar2 * 0x10000 >> 0x10 < 4);
    this->fTVsInitialized = 1;
  }
  tv_ticks = (short)(ticks - this->fTVTicks >> 2);
  if (this->fTransitionDirection < '\x01') {
    j = 0;
    if (0 < tv_ticks) {
      iVar1 = 0;
      do {
        if (3 < iVar1 >> 0x10) break;
        if (this->fImageTVs[imageTVOrder[iVar1 >> 0x10]].state == tv_StateOn) {
          TurnOffTV(this->fImageTVs + imageTVOrder[iVar1 >> 0x10]);
        }
        j = j + 1;
        iVar1 = j * 0x10000;
      } while (j * 0x10000 >> 0x10 < (int)tv_ticks);
    }
    iVar2 = 0;
    if (tv_ticks < 8) goto DrawVidWall_drawTVLoop;
    this->fTransitionDirection = '\0';
  }
  else {
    j = 0;
    if (0 < tv_ticks) {
      iVar1 = 0;
      while (iVar1 < 4) {
        if (this->fImageTVs[imageTVOrder[iVar1]].state == tv_StateOff) {
          TurnOnTV(this->fImageTVs + imageTVOrder[iVar1]);
        }
        j = j + 1;
        if ((int)tv_ticks <= j * 0x10000 >> 0x10) break;
        iVar1 = (int)(short)j;
      }
    }
  }
  iVar2 = 0;
DrawVidWall_drawTVLoop:
  do {
    DrawTV(this->fImageTVs + (short)iVar2);
    iVar2 = iVar2 + 1;
  } while (iVar2 * 0x10000 >> 0x10 < 4);
  return;
}



/* ---- tScreenPinkSlips::ProcessInput  [SCREENPINKSLIPS.CPP:371-389] ---- */
void tScreenPinkSlips::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command
              )

{
  uint uVar2;
  tTrackInformation trackInfo;
  
  if (keyval == kInput_KeyType_Square) {
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               &trackInfo);
    uVar2 = (menuDefs->itemTraffic).fFlags &
            0xfffffffe;
    (menuDefs->itemTraffic).fFlags = uVar2;
    if ((frontEnd.gameMode != '\x01') && (frontEnd.oppNumber == '\x02')) {
      (menuDefs->itemTraffic).fFlags =
           uVar2 | 1;
    }
    if (2 < trackInfo.fTrackDifficulty) {
      (menuDefs->itemTraffic).fFlags =
           (menuDefs->itemTraffic).fFlags |
           1;
    }
    if (trackInfo.fIsEgg != '\0') {
      (menuDefs->itemTraffic).fFlags =
           (menuDefs->itemTraffic).fFlags |
           1;
    }
    if ((frontEnd.gameMode == '\x01') && (frontEnd.raceType == '\x01')) {
      (menuDefs->itemTraffic).fFlags =
           (menuDefs->itemTraffic).fFlags |
           1;
    }
    uVar2 = (menuDefs->itemLocalSpeech).
            fFlags | 1;
    (menuDefs->itemLocalSpeech).fFlags =
         uVar2;
  }
  return;
}



/* ---- tScreenPinkSlips::dtor  [SCREENPINKSLIPS.CPP:82-389] ---- */
tScreenPinkSlips::~tScreenPinkSlips()

{
  /* base ~tScreen() runs implicitly (non-poly inheritance) */
  return;
}



/* end of screenpinkslips.cpp */
