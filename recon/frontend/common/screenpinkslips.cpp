/* frontend/screens/screenpinkslips.cpp -- RECONSTRUCTED (pink-slips betting setup screen; C++ TU)
 *   single class tScreenPinkSlips : tScreen ; 8 fns (no ctor emitted in this TU).
 *   Phantoms (DrawShapeExtended/PSXDrawTransSquare loop args, gSwapFileName, imageTVOrder,
 *   void ProcessInput) resolved via m2c oracle C:\Temp\nfs4-split\cur_c\front\*.c
 */
#include "screenpinkslips.h"


/* MATCH (w35-a10): unsized-array asm-label views -- these globals are reached
   ABSOLUTELY by every oracle (%hi/%lo as an RTL pseudo, CSE-able and
   delay-slot schedulable); a plain extern leaves cc1plus emitting the lw/sw
   assembler macro, which GNU-as expands per-access (self-temp / $at). */
extern tFEApplication *A_FEApp[] __asm__("FEApp");
#define FEApp A_FEApp[0]
extern tGlobalMenuDefs *A_menuDefs[] __asm__("menuDefs");
#define menuDefs A_menuDefs[0]
extern int A_ticks[] __asm__("ticks");
#define ticks A_ticks[0]

/* ---- tScreenPinkSlips::DrawBackground  [SCREENPINKSLIPS.CPP:71-194] ---- */
void tScreenPinkSlips::DrawBackground()

{
  RECT r;
  short i;
  short j;
  short tv;
  tMenuTextState textState;
  tTrackInformation trackInfo;
  short shapeY;
  /* MATCH: the tpage x is a SHORT local (oracle rematerializes it as
     `li $t2,0x200` then sign-extends `sll/sra` into $a2); an int/cast literal
     folds to a bare `li $a2,512`.  14 -> 10 diffs, count-exact 364/364. */
  short movieVramX = 0x200;
  i = 0;
  r.x = 0x15b;
  r.y = 0x8f;
  r.w = 0x90;
  r.h = 0xe;
  while (i < (short)(byte)frontEnd.pinkSlipsNumTracks) {
    BOOL selected;

    textState = textState_Selected;
    selected = false;
    if ((i == (short)this->fMenu->fCurrentItem - 1) ||
        ((i == 0) && ((short)this->fMenu->fCurrentItem == 0))) {
      selected = true;
    }
    if (selected) {
      int pulse;
      int flare_intensity;

      flareextra_248 = flareextra_248 + 1;
      if (0x3c < flareextra_248) {
        flareextra_248 = 0;
      }
      pulse = flareextra_248;
      /* MATCH: ONE statement (oracle SLD groups the subu+srl on one line) and
         the arms in THIS order - the reversed test picks the oracle's commutative
         `addu $v0,$v1,$v0` in the signed /2 idiom. */
      flare_intensity = (0x1e >= pulse ? pulse : 0x3c - pulse) / 2;
      flare_intensity += 0x14;
      flare_intensity *= 0x80 - this->fScreenFadeVal;
      if (0 < flare_intensity) {
        short rx = r.x;
        short ry = r.y;

        Flare_2DHalo(rx + -0xf,ry + 6,flare_intensity / 2,
                    (flare_intensity * 2) / 3,0x17);
        DrawShapeExtended(0x38,0,rx + -0x12,ry,
                   (int)this->fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
      }
      textState = textState_Hilighted;
    }
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[i],&trackInfo);
    frontEnd.pinkSlipsTrackIndex = (char)i;
    FETextRender_MenuTextPositionedJustify(
        TextValue(&menuDefs->iteratorTrack,kPlayerBoth),r.x + 10,r.y + 3,0,
        textState,textType_FlybyHelp);
    DrawShape_NFS4RoundRectangle(-1,&r,1);
    i = i + 1;
    r.y = r.y + 0xe;
  }
  {
    u_short currentItem = (u_short)this->fMenu->fCurrentItem;
    char trackIndex = (char)currentItem;

    frontEnd.pinkSlipsTrackIndex = trackIndex;
    /* MATCH: the guard tests the CHAR local (unsigned char on this build),
       not a fresh `currentItem & 0xff` - that is what makes the `andi` read
       currentItem's copy ($a0) instead of the raw load ($v0). */
    if (trackIndex != 0) {
      frontEnd.pinkSlipsTrackIndex = (char)(currentItem - 1);
    }
  }
  GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
             &trackInfo);
  this->UpdateVideoWall(trackInfo);
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  if ((this->fSwapShapes.fFile != (char *)0x0) &&
      (-1 < *(signed char *)&this->fTransitionDirection)) {
    ::UploadSwapShapes((tScreen *)this,4);
    this->fTransitionDirection = '\x01';
    this->fTVTicks = ticks;
  }
  this->DrawVideoWall();
  shapeY = (ushort)((this->fFrame & 1U) == 0) << 7;
  if (VIDEO_state(this->hVideo) != 0) {
    if (VIDEO_updateframexy(this->hVideo,0x200,shapeY) != 0) {
      this->fFrame = this->fFrame + 1;
      shapeY = (ushort)((this->fFrame & 1U) == 0) << 7;
    }
    tv = 0;
    i = 0;
    do {
      j = 0;
      do {
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
        j = j + 1;
        tv = tv + 1;
      } while (j < 4);
      i = i + 1;
    } while (i < 2);
  }
  else if (0x100 < ticks - this->fTVTicks) {
    char moviename [80];

    sprintf(moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],*(signed char *)&trackInfo.fTrackID);  /* MATCH: lb -- plain char is unsigned on this build */
    VIDEO_spoolfile(this->hVideo,moviename);
    VIDEO_startplayback(this->hVideo);
  }
  i = 0xf0;
  do {
    PSXDrawTransSquare(0x303030,i,0xf,2,0x81,1);
    i = i + 0x50;
  } while (i < 0x1e0);
  i = 0x4f;
  do {
    PSXDrawTransSquare(0x202020,0xa0,i,0x141,1,1);
    i = i + 0x40;
  } while (i < 0x8f);
  FeDraw_SetABRMode(2);
  i = 0;
  do {
    DrawTV(this->fTrackTVs + i);
    i = i + 1;
  } while (i < 8);
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
  sprintf(moviename,"%szzzTR%02d.dct",Paths_Paths[0x29],*(signed char *)&trackInfo.fTrackID);  /* MATCH: lb -- plain char is unsigned on this build */
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
  /* MATCH: fTrackID is a SIGNED byte (this build's plain `char` is unsigned, so
     every read needs the explicit signed-char view -> lbu + sll/sra 24); the
     ONE sign-extended value feeds both the compare and the sprintf arg (oracle
     `addu $a2,$v0,$zero`), while the fPreviousTrack store RE-READS the field
     (the two calls may alias).  fPreviousTrack is a signed short -> `lh`. */
  int trackID = (signed char)trackInfo.fTrackID;

  if (trackID != this->fPreviousTrack) {
    sprintf(gSwapFileName,"TR%02dPS",trackID);
    ::AsyncLoadSwapShapeFile((tScreen *)this,gSwapFileName);
    this->fTVsInitialized = 0;
    this->fPreviousTrack = (short)(signed char)trackInfo.fTrackID;
    if (-1 < *(signed char *)&this->fTransitionDirection) {
      int iVar1 = ticks;

      *(signed char *)&this->fTransitionDirection = -1;
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
  int n;
  short i;
  short j;

  /* MATCH: every counter is a real `short` (gcc re-sign-extends per use, which
     is the oracle's sll/sra pairs); the tick delta is an UNSIGNED >>2 (srl);
     the fTransitionDirection>0 (TurnOn) arm is the FALL-THROUGH (retail's
     `blez` jumps to the TurnOff arm), and both reveal loops are
     exit-in-the-middle with a top `< 4` guard and a bottom `< bound` guard. */
  for (i = 0; i < 0x24; i = i + 1) {
    DrawShapeExtended(i,0,0,0,0,0,(tDrawShapeExtended *)0x0);
  }
  if (((this->fSwapShapes.fFlags & 1) != 0) && (this->fTVsInitialized == 0)) {
    for (i = 0; i < 4; i = i + 1) {
      InitTV(&this->fImageTVs[i],this->fSwapShapes.fShapes,i);
    }
    this->fTVsInitialized = 1;
  }
  tv_ticks = (short)((u_int)(ticks - this->fTVTicks) >> 2);
  if (0 < *(signed char *)&this->fTransitionDirection) {
    if (0 < tv_ticks) {
      n = tv_ticks;
      j = 0;
      while (true) {
        if (3 < j) break;
        if (this->fImageTVs[imageTVOrder[j]].state == tv_StateOff) {
          TurnOnTV(&this->fImageTVs[imageTVOrder[j]]);
        }
        j = j + 1;
        if (n <= j) break;
      }
    }
  }
  else {
    if (0 < tv_ticks) {
      n = tv_ticks;
      j = 0;
      while (true) {
        if (3 < j) break;
        if (this->fImageTVs[imageTVOrder[j]].state == tv_StateOn) {
          TurnOffTV(&this->fImageTVs[imageTVOrder[j]]);
        }
        j = j + 1;
        if (n <= j) break;
      }
    }
    if (7 < tv_ticks) {
      this->fTransitionDirection = 0;
    }
  }
  for (i = 0; i < 4; i = i + 1) {
    DrawTV(&this->fImageTVs[i]);
  }
  return;
}




/* ---- tScreenPinkSlips::ProcessInput  [SCREENPINKSLIPS.CPP:371-389] ---- */
void tScreenPinkSlips::ProcessInput(tPlayer fromPlayer,tInputKeyType &keyval,tMenuCommand &command
              )

{
  uint uVar2;
  tTrackInformation trackInfo;
  tGlobalMenuDefs *defs;
  
  if (keyval == kInput_KeyType_Square) {
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               &trackInfo);
    /* Keep the first traffic-item base live across the short mode/traffic
       test.  GCC 2.8.1 then retains it in $a0, as in the retail object,
       instead of rematerializing menuDefs for the conditional store. */
    defs = menuDefs;
    uVar2 = (defs->itemTraffic).fFlags &
            0xfffffffe;
    (defs->itemTraffic).fFlags = uVar2;
    if ((frontEnd.gameMode != '\x01') && (frontEnd.oppNumber == '\x02')) {
      (defs->itemTraffic).fFlags =
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
    (menuDefs->itemLocalSpeech).fFlags =
         (menuDefs->itemLocalSpeech).fFlags | 1;
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
