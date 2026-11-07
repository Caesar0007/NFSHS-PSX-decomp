/* frontend/screens/screenpinkslips.cpp -- RECONSTRUCTED (pink-slips betting setup screen; C++ TU)
 *   single class tScreenPinkSlips : tScreen ; 8 fns (no ctor emitted in this TU).
 *   Phantoms (DrawShapeExtended/PSXDrawTransSquare loop args, gSwapFileName, imageTVOrder,
 *   void ProcessInput) resolved via m2c oracle C:\Temp\nfs4-split\cur_c\front\*.c
 */
#include "screenpinkslips_types.h"
#include "screenpinkslips_externs.h"

#line 10 "feticks.h"
static inline void MenuItem_Enable(tMenuItem *item) { item->fFlags &= ~1; }
static inline void MenuItem_Disable(tMenuItem *item) { item->fFlags |= 1; }
static inline tFEApplication * App(void) { return FEApp; }
static inline tGlobalMenuDefs * MenuDefs(void) { return menuDefs; }
static inline int FE_Ticks(void) { return *(int *)&ticks; }
#line 23 "C:\\Temp\\nfs4-decomp\\recon\\frontend\\common\\screenpinkslips.cpp"

/* Retail screenpinkslips.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

/* ---- tScreenPinkSlips::DrawBackground  [SCREENPINKSLIPS.CPP:71-194] ---- */
#line 68 "C:/nfs4/FRONTEND/COMMON/SCREENPINKSLIPS.CPP"
void tScreenPinkSlips::DrawBackground()


{
  RECT r;
  short i;
  short j;
  short tv;
  tMenuTextState textState;
  tTrackInformation trackInfo;
  static int flareextra; short shapeY; short movieVramX = 0x200; r.x = 0x15b; r.y = 0x8f; r.w = 0x90; r.h = 0xe;
  for (i = 0; i < (short)(byte)frontEnd.pinkSlipsNumTracks; i++) {

    textState = textState_Selected;
    if ((i == this->fMenu->CurrentItem() - 1) || ((i == 0) && (this->fMenu->CurrentItem() == 0)))
    {
      int flare_intensity;
      flareextra = flareextra + 1;
      if (0x3c < flareextra) flareextra = 0;
      if (0x1e < flareextra) flare_intensity = (0x3c - flareextra) / 2;
      else flare_intensity = flareextra / 2;
      flare_intensity += 0x14;
      flare_intensity *= 0x80 - this->fScreenFadeVal;
      if (0 < flare_intensity)
      {
        short rx = r.x; int dx = rx + 1;
        short ry = r.y; int dy = ry + 1;
        Flare_2DHalo(rx + -0xf,ry + 6,flare_intensity / 2, (flare_intensity * 2) / 3,0x17);
        DrawShapeExtended(0x38,0,rx + -0x12,ry, (int)this->fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
      }


      textState = textState_Hilighted;
    }

    trackManager.GetTrack((ushort)(byte)frontEnd.track[i],trackInfo);

    frontEnd.pinkSlipsTrackIndex = (char)i;
    FETextRender_MenuTextPositionedJustify( menuDefs->iteratorTrack.TextValue((tPlayer)kPlayerBoth),r.x + 10,r.y + 3,0, textState,textType_FlybyHelp);
    DrawShape_NFS4RoundRectangle(-1,r,1);
    r.y = r.y + 0xe;
  }


  frontEnd.pinkSlipsTrackIndex = (char)this->fMenu->CurrentItem();
  if (frontEnd.pinkSlipsTrackIndex != 0) {
    frontEnd.pinkSlipsTrackIndex -= 1;
  }
  trackManager.GetTrack((ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex], trackInfo);
  this->UpdateVideoWall(trackInfo);

  this->IsShapeFileLoaded(this->fSwapShapes);
  if ((this->fSwapShapes.fFile != (char *)0x0) && (-1 < *(signed char *)&this->fTransitionDirection))
  {
    this->UploadSwapShapes(4);
    this->fTransitionDirection = '\x01';
    this->fTVTicks = FE_Ticks();
  }


  this->DrawVideoWall();






  shapeY = (ushort)((this->fFrame & 1U) == 0) << 7;

  if (VIDEO_state(this->hVideo) != 0) {

    if (VIDEO_updateframexy(this->hVideo,0x200,shapeY) != 0) {

      this->fFrame = this->fFrame + 1;
      shapeY = (ushort)((this->fFrame & 1U) == 0) << 7;
    }
    tv = 0;

    i = 0; do {

      j = 0; do {

        this->fTrackTVs[tv].x = j * 0x50 + 0xa0;
        this->fTrackTVs[tv].y = i * 0x40 + 0x19;
        this->fTrackTVs[tv].w = 0x50;
        this->fTrackTVs[tv].h = 0x40;

        this->fTrackTVs[tv].u = j * '(';
        this->fTrackTVs[tv].v = i * 0x40 + (char)shapeY;
        this->fTrackTVs[tv].uw = '(';
        this->fTrackTVs[tv].vh = '@';
        if (i == 1) {
          this->fTrackTVs[tv].vh--;
        }
        this->fTrackTVs[tv].tpage = GetTPage(2,0,movieVramX,(int)shapeY);
        this->fTrackTVs[tv].clut = 0;

        this->fTrackTVs[tv].state = tv_StateOn;
        this->fTrackTVs[tv].flags = 0x20;
        this->fTrackTVs[tv].tint = 0x808080;


        j = j + 1; tv = tv + 1; } while (j < 4);
      i = i + 1; } while (i < 2);
  }
  else if (0x100 < FE_Ticks() - this->fTVTicks)
  {
    char moviename [80];

    sprintf(moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],*(signed char *)&trackInfo.fTrackID);  /* MATCH: lb -- plain char is unsigned on this build */
    VIDEO_spoolfile(this->hVideo,moviename);
    VIDEO_startplayback(this->hVideo);
  }
  i = 0xf0;


  do {
    PSXDrawTransSquare(0x303030,i,0xf,2,0x81,1); i = i + 0x50; } while (i < 0x1e0);

  i = 0x4f; do {
    PSXDrawTransSquare(0x202020,0xa0,i,0x141,1,1); i = i + 0x40; } while (i < 0x8f);

  FeDraw_SetABRMode(2);


  i = 0;
  do { DrawTV(this->fTrackTVs[i]); i = i + 1; } while (i < 8); return;
}



/* ---- tScreenPinkSlips::GetShapeInfo  [SCREENPINKSLIPS.CPP:202-214] ---- */
#line 198 "C:/nfs4/FRONTEND/COMMON/SCREENPINKSLIPS.CPP"
void tScreenPinkSlips::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName
               ,char **swapFileName)


{
  tTrackInformation trackInfo;
  
  trackManager.GetTrack((ushort)(byte)frontEnd.track[0],trackInfo);

  numPermShapes = 0x39;
  numSwapShapes = 4;

  *permFileName = "zPink";
  sprintf(gSwapFileName,"TR%02dPS",(int)(signed char)trackInfo.fTrackID);
  *swapFileName = gSwapFileName;

  this->fPreviousTrack = (short)(signed char)trackInfo.fTrackID; return;
}

/* retail ScreenPinkSlips.obj front.data: flareextra (DrawBackground's static, above) 0x80051E5C,
 * then these two, emitted here at their definitions. */
static char imageTVOrder[4] = { 1, 2, 0, 3 };          /* STAT @0x80051E60 - TV reveal order */
tScreenPinkSlips *screenPinkSlips = 0;                 /* @0x80051E64 */

/* ---- tScreenPinkSlips::Initialize  [SCREENPINKSLIPS.CPP:219-259] ---- */
#line 216 "C:/nfs4/FRONTEND/COMMON/SCREENPINKSLIPS.CPP"
void tScreenPinkSlips::Initialize()


{
  RECT r;
  char moviename [80];
  tTrackInformation trackInfo;

  r.x = 0x200;
  r.y = 0;
  r.w = 0xaa;
  r.h = 0x100;
  ClearImage(&r,'\0','\0','\0');
  DrawSync(0);



  frontEnd.pinkSlipsTrackIndex = '\0';
  menuDefs->iteratorTrack.Decrement((tPlayer)kPlayerBoth);
  menuDefs->iteratorTrack.Increment((tPlayer)kPlayerBoth); this->fMenu = FEApp->CurrentMenu(0);



  this->tScreen::Initialize();

  this->fTVsInitialized = 0;





  trackManager.GetTrack((ushort)(byte)frontEnd.track[0],trackInfo);

  sprintf(moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],*(signed char *)&trackInfo.fTrackID);  /* MATCH: lb -- plain char is unsigned on this build */
  this->hVideo = VIDEO_create(0xa0,0x80,0xf0000,0x20000,0x10);
  VIDEO_spoolfile(this->hVideo,moviename);
  VIDEO_startplayback(this->hVideo);
  this->fFrame = 0;

  this->fBrightness = 0;
  this->fDestBrightness = 0;
  this->fTVsInitialized = 0;
  this->fTVTicks = FE_Ticks();
  this->fTransitionDirection = '\x01'; return;
}



/* ---- tScreenPinkSlips::Cleanup  [SCREENPINKSLIPS.CPP:263-269] ---- */
#line 260 "C:/nfs4/FRONTEND/COMMON/SCREENPINKSLIPS.CPP"
void tScreenPinkSlips::Cleanup()


{
  
  VIDEO_destroy(this->hVideo);
  purgememadr((void *)this->hVideo);

  frontEnd.pinkSlipsTrackIndex = '\0';
  this->tScreen::Cleanup();
}



/* ---- tScreenPinkSlips::UpdateVideoWall  [SCREENPINKSLIPS.CPP:300-315] ---- */
#line 297 "C:/nfs4/FRONTEND/COMMON/SCREENPINKSLIPS.CPP"
void tScreenPinkSlips::UpdateVideoWall(tTrackInformation &trackInfo)


{
  if ((signed char)(u_char)trackInfo.fTrackID != this->fPreviousTrack)
  {
    sprintf(gSwapFileName,"TR%02dPS",(signed char)(u_char)trackInfo.fTrackID);
    this->AsyncLoadSwapShapeFile(gSwapFileName);
    this->fTVsInitialized = 0;

    this->fPreviousTrack = (short)(signed char)trackInfo.fTrackID;
    if (-1 < *(signed char *)&this->fTransitionDirection)
    {
      this->fTVTicks = FE_Ticks();
      *(signed char *)&this->fTransitionDirection = -1;
    }


    VIDEO_abortplayback(this->hVideo); } return; }



/* ---- tScreenPinkSlips::DrawVideoWall  [SCREENPINKSLIPS.CPP:324-367] ---- */
#line 321 "C:/nfs4/FRONTEND/COMMON/SCREENPINKSLIPS.CPP"
void tScreenPinkSlips::DrawVideoWall()


{
  short i;
  short j;
  for (i = 0; i < 0x24; i = i + 1) {

    DrawShapeExtended(i,0,0,0,0,0,(tDrawShapeExtended *)0x0);
  }

  if ((this->fSwapShapes.fFlags & 1) != 0) {

    if (this->fTVsInitialized == 0) {

    for (i = 0; i < 4; i = i + 1) {

      InitTV(this->fImageTVs[i],this->fSwapShapes.fShapes,i);
    }
    this->fTVsInitialized = 1;
  } }


  i = (short)((u_int)(FE_Ticks() - this->fTVTicks) >> 2);
  if (0 < *(signed char *)&this->fTransitionDirection) {
    j = 0;
    while ((j < i) && (j < 4)) {

      if (this->fImageTVs[imageTVOrder[j]].state == tv_StateOff) {
        TurnOnTV(this->fImageTVs[imageTVOrder[j]]);
      } j = j + 1;
    }
  }
  else {
    j = 0; while ((j < i) && (j < 4)) {

      if (this->fImageTVs[imageTVOrder[j]].state == tv_StateOn) {
        TurnOffTV(this->fImageTVs[imageTVOrder[j]]);
      } j = j + 1;
    } if (7 < i) {
      this->fTransitionDirection = 0;
    }
  }
  for (i = 0; i < 4; i = i + 1) {

    DrawTV(this->fImageTVs[i]);
  } return;
}




/* ---- tScreenPinkSlips::ProcessInput  [SCREENPINKSLIPS.CPP:371-389] ---- */

#line 369 "C:/nfs4/FRONTEND/COMMON/SCREENPINKSLIPS.CPP"
void tScreenPinkSlips::ProcessInput(tPlayer,tInputKeyType &keyval,tMenuCommand &
              )
{
  tTrackInformation trackInfo;

  if (keyval == kInput_KeyType_Square)
  {
    trackManager.GetTrack((ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex], trackInfo); MenuItem_Enable(&menuDefs->itemTraffic);




    if ((frontEnd.gameMode != '\x01') && (frontEnd.oppNumber == '\x02'))
    { MenuItem_Disable(&menuDefs->itemTraffic); }
    if (2 < trackInfo.fTrackDifficulty)
    { MenuItem_Disable(&menuDefs->itemTraffic); }
    if (trackInfo.fIsEgg != '\0')
    { MenuItem_Disable(&menuDefs->itemTraffic); }
    if ((frontEnd.gameMode == '\x01') && (frontEnd.raceType == RaceType_HotPursuit))
    { MenuItem_Disable(&menuDefs->itemTraffic); }
    MenuItem_Disable(&menuDefs->itemLocalSpeech); } }


extern "C" void ___7tScreen(void *);



/* end of screenpinkslips.cpp */
