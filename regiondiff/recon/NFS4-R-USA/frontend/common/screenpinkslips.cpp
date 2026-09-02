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

/* ---- callees the REGIONAL Cleanup adds.  All three are already reconstructed
   in the base tree; they are declared locally here only because
   screenpinkslips_externs.h is a base-tree file this regional agent must not
   edit.
   IDENTIFICATION of the three regional VAs (a regional address is NEVER looked
   up in configs/symbol_addrs.txt -- README trap).  The region->base delta was
   taken from the INDEX.tsv rows BRACKETING each callee and then confirmed by a
   base symbol sitting at EXACTLY that delta:
     func_8007AA48 - 0xA6C = 0x80079FDC = AudioMus_Buffered__Fv
                             (0xA6C is the delta of AudioMus_Fail, the next
                              INDEX.tsv row after this address)
     func_8007A9C4 - 0xA6C = 0x80079F58 = AudioMus_Threshold__Fv
     func_80015A70 - 0x128 = 0x80015948 = FeAudio_systemtask__Fi
                             (0x128 = the delta of GetCarFromID, the next row)
   Cross-check on the same slice's UNCHANGED callees, whose identity is fixed by
   the base body: func_80051328-0x4E8 = VIDEO_destroy__Fi,
   func_800E612C-0xBEC = purgememadr, func_800261C0-0x20 = Cleanup__7tScreen. */
extern "C" {
int  AudioMus_Buffered(void);
int  AudioMus_Threshold(void);
void FeAudio_systemtask(int);
int  textpixels(char *);
}
char *TextSys_Word(int id);
void  PSXDrawSquare(int col, int x, int y, int w, int h);
/* fefades_types.h's tMenuTextType enumerator; this TU's own types header only
   spells out textType_FlybyHelp. */
#define textType_ScreenInfo 4

/* Same delta-bracketing identification as above, for the callees the REGIONAL
   DrawBackground adds:
     func_800B9F18 - 0xCF0 = 0x800B9228 ... TextSys_* block; the pairing is
       fixed SEMANTICALLY, not by delta alone: its result is fed straight to
       func_800E4A2C, and func_800E4A2C - 0xC0C = 0x800E3E20 = `textpixels`
       (0xC0C is exactly the delta of padinit, the next INDEX.tsv row).  The
       only `int textpixels(char *)` producer taking an int word id is
       `char *TextSys_Word(int)` -- the base tree already carries the identical
       idiom `textpixels(TextSys_Word(0xfc))` in feapp.cpp:224.
     func_8004F12C - 0x4E8 = 0x8004EC44 = PSXDrawSquare__Fiiiii (0x4E8 = the
       delta of videodecode, the next INDEX.tsv row; arity 5 matches).
     func_800212E0 - 0x160 = 0x80021180 =
       FETextRender_MenuTextPositionedJustify (0x160 = the delta of
       FECheat_HandleActivation, the next row; and this same callee appears in
       the UNCHANGED part of this very function's body, which pins it). */

/* ---- tScreenPinkSlips::DrawBackground  [SCREENPINKSLIPS.CPP:71-194] ---- */
void tScreenPinkSlips::DrawBackground()

{
  static int flareextra;
  RECT r;
  short i;
  short j;
  short tv;
  tMenuTextState textState;
  tTrackInformation trackInfo;
  short shapeY;
  /* SYM-CODEGEN-CARRIER: movieVramX -- the tpage x is a SHORT local (retail
     rematerializes it as
     `li $t2,0x200` then sign-extends `sll/sra` into $a2); an int/cast literal
     folds to a bare `li $a2,512`.  14 -> 10 diffs, count-exact 364/364. */
  short movieVramX = 0x200;
  /* REGIONAL DELTA (NFS4-R-*): once the screen has finished fading in
     (fScreenFadeVal >= 100) retail draws a screen-info caption plus the
     right-aligned underline bar under it, ahead of the track list. */
  if (this->fScreenFadeVal >= 100) {
    FETextRender_MenuTextPositionedJustify(638, 480, 220, 1,
                                           textState_Selected,
                                           textType_ScreenInfo);
    PSXDrawSquare(0, 480, 220, -textpixels(TextSys_Word(638)) - 5, 7);
  }
  i = 0;
  r.x = 0x15b;
  r.y = 0x8f;
  r.w = 0x90;
  r.h = 0xe;
  while (i < (short)(byte)frontEnd.pinkSlipsNumTracks) {
    /* SYM-CODEGEN-CARRIER: selected -- folding the predicate into this branch
       is FAIL 7 at 361/364 instructions and removes retail's $a1 value web. */
    BOOL selected;

    textState = textState_Selected;
    selected = false;
    if ((i == (short)this->fMenu->fCurrentItem - 1) ||
        ((i == 0) && ((short)this->fMenu->fCurrentItem == 0))) {
      selected = true;
    }
    if (selected) {
      int flare_intensity;

      flareextra = flareextra + 1;
      if (0x3c < flareextra) {
        flareextra = 0;
      }
      /* MATCH: ONE statement (oracle SLD groups the subu+srl on one line) and
         the arms in THIS order - the reversed test picks the oracle's commutative
         `addu $v0,$v1,$v0` in the signed /2 idiom. */
      flare_intensity =
          (0x1e >= flareextra ? flareextra : 0x3c - flareextra) / 2;
      flare_intensity += 0x14;
      flare_intensity *= 0x80 - this->fScreenFadeVal;
      if (0 < flare_intensity) {
        /* SYM-CODEGEN-CARRIER: rx -- direct RECT member use is FAIL 99 at
           365/364 instructions and rotates the whole saved-register handout. */
        short rx = r.x;
        /* SYM-CODEGEN-CARRIER: ry -- paired coordinate snapshot in that
           receipt; retail keeps both values across Flare_2DHalo. */
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
    /* SYM-CODEGEN-CARRIER: currentItem -- folding this ushort snapshot into
       trackIndex is FAIL 5 at 363/364 and loses retail's $v0->$a0 copy. */
    u_short currentItem = (u_short)this->fMenu->fCurrentItem;
    /* SYM-CODEGEN-CARRIER: trackIndex -- removing the char snapshot is the
       same FAIL-5 basin; its guard must read the copied $a0 value. */
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
  /* SYM-CODEGEN-CARRIER: iVar1 -- direct ticks storage is measured FAIL 9
     (83/82) and changes the final load-delay/store schedule. */
  int iVar1;
  /* SYM-CODEGEN-CARRIER: tmp -- direct hVideo reuse is paired with that
     one-instruction regression. */
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
  this->tScreen::Initialize();
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
  /* REGIONAL DELTA (NFS4-R-*): retail adds a music-buffer drain wait here,
     between clearing the track index and the base-class Cleanup.  It is the
     same idiom the base tree already carries as a guard in
     tScreenMemcard::LoadIcon (`AudioMus_Buffered() < AudioMus_Threshold()`),
     pumped by FeAudio_systemtask(0). */
  while (AudioMus_Buffered() < AudioMus_Threshold()) {
    FeAudio_systemtask(0);
  }
  this->tScreen::Cleanup();
  return;
}



/* ---- tScreenPinkSlips::UpdateVideoWall  [SCREENPINKSLIPS.CPP:300-315] ---- */
void tScreenPinkSlips::UpdateVideoWall(tTrackInformation &trackInfo)

{
  /* SYM records no locals.  Repeating the explicit
     `(signed char)(u_char)fTrackID` expression lets GCC CSE one unsigned byte
     read across the compare and sprintf argument while retaining retail's
     lbu/sll/sra promotion sequence; the calls then force the later
     fPreviousTrack assignment to reread the field.  Writing fTVTicks before
     fTransitionDirection also schedules the ticks load before the -1 store,
     reproducing retail without the former trackID/iVar1 carriers or volatile. */
  if ((signed char)(u_char)trackInfo.fTrackID != this->fPreviousTrack) {
    sprintf(gSwapFileName,"TR%02dPS",(signed char)(u_char)trackInfo.fTrackID);
    ::AsyncLoadSwapShapeFile((tScreen *)this,gSwapFileName);
    this->fTVsInitialized = 0;
    this->fPreviousTrack = (short)(signed char)trackInfo.fTrackID;
    if (-1 < *(signed char *)&this->fTransitionDirection) {
      this->fTVTicks = ticks;
      *(signed char *)&this->fTransitionDirection = -1;
    }
    VIDEO_abortplayback(this->hVideo);
  }
  return;
}



/* ---- tScreenPinkSlips::DrawVideoWall  [SCREENPINKSLIPS.CPP:324-367] ---- */
void tScreenPinkSlips::DrawVideoWall()

{
  short i;
  short j;

  /* MATCH: SLD records only `i` ($s0) and `j` ($s1).  The original reuses `i`
     for the unsigned-shifted tick delta; introducing a separate tick local
     displaces `this` from retail's $s2.  The condition order is also material:
     GCC rotates `j < i && j < 4` into the oracle's entry, top, and bottom tests. */
  for (i = 0; i < 0x24; i = i + 1) {
    DrawShapeExtended(i,0,0,0,0,0,(tDrawShapeExtended *)0x0);
  }
  if (((this->fSwapShapes.fFlags & 1) != 0) && (this->fTVsInitialized == 0)) {
    for (i = 0; i < 4; i = i + 1) {
      InitTV(&this->fImageTVs[i],this->fSwapShapes.fShapes,i);
    }
    this->fTVsInitialized = 1;
  }
  i = (short)((u_int)(ticks - this->fTVTicks) >> 2);
  if (0 < *(signed char *)&this->fTransitionDirection) {
    j = 0;
    while ((j < i) && (j < 4)) {
      if (this->fImageTVs[imageTVOrder[j]].state == tv_StateOff) {
        TurnOnTV(&this->fImageTVs[imageTVOrder[j]]);
      }
      j = j + 1;
    }
  }
  else {
    j = 0;
    while ((j < i) && (j < 4)) {
      if (this->fImageTVs[imageTVOrder[j]].state == tv_StateOn) {
        TurnOffTV(&this->fImageTVs[imageTVOrder[j]]);
      }
      j = j + 1;
    }
    if (7 < i) {
      this->fTransitionDirection = 0;
    }
  }
  for (i = 0; i < 4; i = i + 1) {
    DrawTV(&this->fImageTVs[i]);
  }
  return;
}




/* ---- tScreenPinkSlips::ProcessInput  [SCREENPINKSLIPS.CPP:371-389] ---- */
void tScreenPinkSlips::ProcessInput(tPlayer,tInputKeyType &keyval,tMenuCommand &
              )

{
  tTrackInformation trackInfo;
  /* SYM-CODEGEN-CARRIER: defs -- direct menuDefs access rematerializes the
     global base, expanding this function from 79 to 84 instructions and
     measuring 21 diffs. */
  tGlobalMenuDefs *defs;
  
  if (keyval == kInput_KeyType_Square) {
    GetTrack(&trackManager,(ushort)(byte)frontEnd.track[(byte)frontEnd.pinkSlipsTrackIndex],
               &trackInfo);
    /* Keep the first traffic-item base live across the short mode/traffic
       test.  GCC 2.8.1 then retains it in $a0, as in the retail object,
       instead of rematerializing menuDefs for the conditional store. */
    defs = menuDefs;
    (defs->itemTraffic).fFlags &= 0xfffffffe;
    if ((frontEnd.gameMode != '\x01') && (frontEnd.oppNumber == '\x02')) {
      (defs->itemTraffic).fFlags |= 1;
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
    if ((frontEnd.gameMode == '\x01') && (frontEnd.raceType == RaceType_HotPursuit)) {
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
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___16tScreenPinkSlips(void *thisp) { ___7tScreen(thisp); }



/* end of screenpinkslips.cpp */
