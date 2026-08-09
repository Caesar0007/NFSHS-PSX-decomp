/* frontend/screens/screentournselect.cpp -- RECONSTRUCTED (tournament-select screen; C++ TU)
 *   9 member fns (incl ctor) of tScreenTournSelect (embeds tScreen base as _base_tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom stack-args resolved vs disasm.
 */
#include "screentournselect.h"

/* M13: DrawVideoWall (below) now indexes the real trophyTVOrder[4]={1,2,0,3} @0x80052058 (already
 * materialized in screentournselect_externs.h, EXE bytes 01 02 00 03) instead of an inlined truncated
 * literal "\x01\x02" (={1,2,0}+NUL) that read OUT OF BOUNDS at i=3 where the real table holds 3. */


/* ---- tScreenTournSelect::ctor  [SCREENTOURNSELECT.CPP:64] ---- */
tScreenTournSelect::tScreenTournSelect()

{

  this->_vf = (__vtbl_ptr_type (*)[10])tScreenTournSelect_vtable;
  return;
}



/* ---- tScreenTournSelect::dtor  [SCREENTOURNSELECT.CPP:65-68] ---- */
tScreenTournSelect::~tScreenTournSelect()

{
  /* MATCH: no manual tScreen_dtor — declared base dtor auto-fires (vptr store
     lands in its jal delay slot; __in_chrg forwarded in $a1). */
  this->_vf = (__vtbl_ptr_type (*)[10])tScreenTournSelect_vtable;
  return;
}



/* ---- tScreenTournSelect::GetShapeInfo  [SCREENTOURNSELECT.CPP:69-87] ---- */
void tScreenTournSelect::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  /* MATCH (SLD 79/81/82/84/86/87): no `def`/`tournOffset` temps - the whole
     tourney index is ONE grouped expression on the call line (a single x84
     chain), and gSwapFileName's address is held in $s0 across the call. */
  byte useSpecial;
  char *swapName;

  /* MATCH: an if/ELSE (both arms load) - the oracle jumps over the else arm;
     a default+override form emits no `j`. */
  if (frontEnd.tier != '\0') {
    useSpecial = frontEnd.specialevent;
  }
  else {
    useSpecial = frontEnd.tournament;
  }
  numPermShapes = 0x40;
  numSwapShapes = 0x20;
  *permFileName = "ztourn";
  swapName = gSwapFileName;
  GetTrophyName(&tournamentManager,
             (tournamentManager.fDefinition)->fTournaments +
             ((uint)useSpecial +
              (uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset),
             ts_Medium,swapName,-1);
  *swapFileName = swapName;
  return;
}




/* ---- tScreenTournSelect::Initialize  [SCREENTOURNSELECT.CPP:88-139] ---- */
void tScreenTournSelect::Initialize()

{
  byte useSpecial;
  ushort flags;
  int tvIdx;
  short i;
  short j;
  RECT r;
  char moviename [80];
  
  this->PreCalculatedTournamentY = -1;
  this->fPrevi = -1;
  r.x = 0x200;
  r.w = 0x50;
  r.y = 0;
  r.h = 0xa0;
  ClearImage(&r,'\0','\0','\0');
  DrawSync(0);
  this->Initialize();
  this->fCurrentMovie = 0;
  this->fPreviousMovie = 0;
  sprintf(moviename,"%szzzTRN.dct",Paths_Paths[0x29]);
  i = VIDEO_create(0x50,0x50,0xf0000,0x25800,0x10);
  this->hVideo = i;
  VIDEO_spoolfile(i,moviename);
  i = 0;
  VIDEO_startplayback(this->hVideo);
  this->fFrame = 0;
  do {
    j = 0;
    do {
      tvIdx = i * 2 + j;
      InitTV(this->trophyTV + tvIdx,this->fPermShapes.fShapes,0);
      this->trophyTV[tvIdx].y = j * 0x25 + 0x8e;
      j = j + 1;
      this->trophyTV[tvIdx].w = 0x4c;
      flags = this->trophyTV[tvIdx].flags;
      this->trophyTV[tvIdx].x = i * 0x4c + 0xa5;
      this->trophyTV[tvIdx].h = 0x25;
      this->trophyTV[tvIdx].flags = flags | 0x30;
    } while (j < 2);
    i = i + 1;
  } while (i < 2);
  useSpecial = frontEnd.tournament;
  if (frontEnd.tier != '\0') {
    useSpecial = frontEnd.specialevent;
  }
  this->fPreviousTrophy =
       (tournamentManager.fDefinition)->fTournaments
       [(uint)useSpecial +
        (uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset].fTrophyID;
  i = ticks;
  this->fTransitionDirection = 1;
  this->fTVTicks = i;
  return;
}



/* ---- tScreenTournSelect::Cleanup  [SCREENTOURNSELECT.CPP:140-149] ---- */
void tScreenTournSelect::Cleanup()

{
  
  VIDEO_destroy(this->hVideo);
  purgememadr((void *)this->hVideo);
  this->Cleanup();
  return;
}



/* ---- tScreenTournSelect::UpdateVideoWall  [SCREENTOURNSELECT.CPP:150-167] ---- */
void tScreenTournSelect::UpdateVideoWall(tTourneyInfo *tourn)

{
  char *fileName;

  if (tourn->fTrophyID != (signed char)this->fPreviousTrophy) {
    fileName = gSwapFileName;
    GetTrophyName(&tournamentManager,tourn,ts_Medium,gSwapFileName,-1);
    ::AsyncLoadSwapShapeFile((tScreen *)this,fileName);
    this->fTVsInitialized = 0;
    this->fPreviousTrophy = tourn->fTrophyID;
    if (-1 < this->fTransitionDirection) {
      this->fTransitionDirection = -1;
      this->fTVTicks = ticks;
    }
  }
  return;
}



/* ---- tScreenTournSelect::DrawVideoWall  [SCREENTOURNSELECT.CPP:168-229] ---- */
void tScreenTournSelect::DrawVideoWall()

{
  bool onState;
  int abr;
  long j;
  long i;
  uint transCount;
  tDrawShapeExtended drawFlags;

  i = 0xf4;
  drawFlags.custom_shapes = this->fSwapShapes.fShapes;
  ::DrawBackgroundImage((tScreen *)this,0,0x22,this->fPermShapes.fShapes,0);
  /* W55-A2 BUGFIX: the x/y args were transcribed as phantom `transX/transY` zeros and the
     loop counter `i` was never passed. Oracle 8003FC18: a1=$s1(=i), a2=0x29. */
  do {
    PSXDrawTransSquare(0x202020,i,0x29,2,0x61,1);
    i = i + 0x50;
  } while (i < 0x1e5);
  i = 0x59;
  /* Oracle 8003FC50: a1=0xA5, a2=$s1(=i). */
  do {
    PSXDrawTransSquare(0x141414,0xa5,i,0x141,1,1);
    i = i + 0x30;
  } while (i < 0x89);
  /* W55-A2 BUGFIX: retail passes literal 2 (oracle 8003FC7C delay slot `addiu a0,zero,2`);
     the recon passed the stale coordinate 0xA5 via a phantom `abr`. */
  FeDraw_SetABRMode(2);
  transCount = ticks - this->fTVTicks >> 2;
  if (this->fTransitionDirection < 1) {
    i = 0;
    if (transCount != 0) {
      onState = true;
      do {
        if (!onState) break;
        if (this->trophyTV[trophyTVOrder[i]].state == tv_StateOn) {
          TurnOffTV(this->trophyTV + trophyTVOrder[i]);
        }
        i = i + 1;
        onState = i < 4;
      } while (i < (int)transCount);
    }
    if (3 < transCount) {
      this->fTransitionDirection = 0;
    }
  }
  else {
    i = 0;
    if (transCount != 0) {
      onState = true;
      do {
        if (!onState) break;
        if (this->trophyTV[trophyTVOrder[i]].state == tv_StateOff) {
          TurnOnTV(this->trophyTV + trophyTVOrder[i]);
        }
        i = i + 1;
        onState = i < 4;
      } while (i < (int)transCount);
    }
  }
  /* Oracle 8003FD84 / 8003FDAC: the two closing squares' x/y are literals, not phantom zeros. */
  PSXDrawTransSquare(0x303030,0xf1,0x8e,2,0x4a,1);
  PSXDrawTransSquare(0x202020,0xa5,0xb3,0x98,1,1);
  /* W55-A2 BUGFIX: retail passes literal 2 (oracle 8003FDCC delay slot); recon passed 0xA5. */
  FeDraw_SetABRMode(2);
  abr = 0;
  i = 0x1ec;
  do {
    DrawTV((tTVConfig *)(this->fPermShapes.fFilename + i + -0x14));
    abr = abr + 1;
    i = i + 0x30;
  } while (abr < 4);
  /* Oracle 8003FDF4-8003FE34: a0 = (ticks >> 4) % 0x20, then 0x600,0xB6,0x93,0,0,&drawFlags. */
  ScaleShapeExtended(((int)ticks >> 4) % 0x20,0x600,0xb6,0x93,0,0,&drawFlags);
  return;
}



/* ---- tScreenTournSelect::DrawBackground  [SCREENTOURNSELECT.CPP:230-380] ---- */
void tScreenTournSelect::DrawBackground()

{
  short y;
  char buffer [64];
  short i;
  short j;
  short tvIdx;
  RECT r;
  tTourneyInfo *tourn;
  int YellowCol;
  int DarkGreyCol;
  int GreyCol;
  long number;
  int word;
  char *descriptionText;
  short shapeY;
  short shapeX;
  char moviename [80];
  u_long movieRGB [1];
  byte tournament;
  tfrontEnd *fe = &frontEnd;

  if (fe->tier != 0) {
    tournament = fe->specialevent;
  }
  else {
    tournament = fe->tournament;
  }
  tourn = &tournamentManager.fDefinition->fTournaments
            [tournament +
             tournamentManager.fDefinition->fTiers[(byte)fe->tier].fTournOffset];
  YellowCol = CalcFadeVal(0xbebe,this->fScreenFadeVal);
  DarkGreyCol = CalcFadeVal(0x232323,this->fScreenFadeVal);
  GreyCol = CalcFadeVal(0x505050,this->fScreenFadeVal);
  number = tournamentManager.fMoney;
  FETextRender_MenuTextFade((int)this->fScreenFadeVal,0x7b,textState_Selected,textType_ScreenInfo);
  DrawMoney(TextSys_WordX(0x7b) + 0x8c,TextSys_WordY(0x7b) + 9,6,
            number,YellowCol,DarkGreyCol);
  FETextRender_MenuTextFade((int)this->fScreenFadeVal,0x99,textState_Selected,textType_Default);
  DrawMoney(TextSys_WordX(0x99) + 0x8c,TextSys_WordY(0x99) + 9,6,
            tourn->fEntranceFee,YellowCol,DarkGreyCol);
  FETextRender_MenuTextFade((int)this->fScreenFadeVal,0x9a,textState_Selected,textType_Default);
  y = TextSys_WordY(0x9a) + 9;
  i = 0;
  do {
    FETextRender_FullTextRGB(TextSys_Word(i + 0x2d4),TextSys_WordX(0x9a),
                             y,GreyCol,'\0',0);
    DrawMoney(TextSys_WordX(0x99) + 0x8c,y,6,tourn->fPrize[i],
              YellowCol,DarkGreyCol);
    y += 9;
    i++;
  } while (i < 3);
  this->UpdateVideoWall(tourn);
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  if ((this->fSwapShapes.fFile != (char *)0x0) && (-1 < this->fTransitionDirection)) {
    ::UploadSwapShapes((tScreen *)this,0x20);
    this->fTransitionDirection = 1;
    this->fTVTicks = ticks;
  }
  this->DrawVideoWall();
  shapeY = 0;
  if ((this->fFrame & 1U) == 0) {
    shapeY = 0x50;
  }
  shapeX = 0x200;
  movieRGB[0] = 0x2c1e1e;
  i = 0;
  do {
    j = 0;
    do {
      tvIdx = (short)(j + i * 4);
      this->tvConfigs[tvIdx].x = j * 0x50 + 0xa5;
      this->tvConfigs[tvIdx].w = 0x50;
      this->tvConfigs[tvIdx].h = 0x30;
      this->tvConfigs[tvIdx].y = i * 0x30 + 0x29;
      this->tvConfigs[tvIdx].u = j * 0x14;
      this->tvConfigs[tvIdx].uw = 0x14;
      this->tvConfigs[tvIdx].v = i * 0x28;
      this->tvConfigs[tvIdx].vh = 0x28;
      this->tvConfigs[tvIdx].tpage = GetTPage(2,0,shapeX,shapeY);
      this->tvConfigs[tvIdx].state = tv_StateOn;
      this->tvConfigs[tvIdx].clut = 0;
      this->tvConfigs[tvIdx].flags = 0x22;
      this->tvConfigs[tvIdx].tint = movieRGB[0];
      this->tvConfigs[tvIdx].destBrightness = 0x80;
      this->tvConfigs[tvIdx].transition = 0x80;
      j++;
    } while (j < 4);
    i++;
  } while (i < 2);
  if (VIDEO_state(this->hVideo) != 0) {
    if (VIDEO_updateframexy(this->hVideo,shapeX,shapeY) != 0) {
      this->fFrame++;
    }
  }
  else {
    this->fCurrentMovie = 0;
    sprintf(moviename,"%szzzTRN.dct",Paths_Paths[0x29]);
    VIDEO_spoolfile(this->hVideo,moviename);
    VIDEO_startplayback(this->hVideo);
  }
  i = 0;
  do {
    DrawTVLines(&this->tvConfigs[i]);
    i++;
  } while (i < 8);
  r.x = 0x145;
  r.y = 0x2b;
  r.w = 0x13a;
  r.h = 10;
  if (frontEnd.tier != '\0') {
    word = TextValue(&menuDefs->iteratorSpecialEvent,kPlayerBoth);
  }
  else {
    word = TextValue(&menuDefs->iteratorTournament,kPlayerBoth);
  }
  FETextRender_WordWrapFade((int)this->fScreenFadeVal,(short)word,&r,textState_Hilighted,
             textType_VideoWall);
  r.x = 0xaa;
  r.w = r.w + -10;
  if (frontEnd.tier != '\0') {
    i = TextValue(&menuDefs->iteratorSpecialEvent,kPlayerBoth);
  }
  else {
    i = TextValue(&menuDefs->iteratorTournament,kPlayerBoth);
  }
  i += 0x26;
  if ((i != this->fPrevi) || (this->PreCalculatedTournamentY == -1)) {
    this->fPrevi = i;
    this->PreCalculatedTournamentY =
      0x75 - FETextRender_WordWrapHeight(r.w,TextSys_Word(i));
  }
  r.y = (short)this->PreCalculatedTournamentY;
  j = i - 0x367;
  descriptionText = TextSys_Word(i);
  i = 0;
  FETextRender_WordWrapTextRGB(descriptionText,r,
                               CalcFadeVal(0x505050,this->fScreenFadeVal));
  FETextRender_MenuTextPositionedJustifyFade((int)this->fScreenFadeVal,0x3db,0xaa,0x75,0,textState_Selected,
             textType_ScreenInfo);
  j += 0x37a;
  FETextRender_MenuTextPositionedJustifyFade((int)this->fScreenFadeVal,j,
             0xaa,0x7d,0,textState_Hilighted,textType_ScreenInfo);
  do {
    DrawTV(&this->tvConfigs[i]);
    i++;
  } while (i < 8);
  return;
}



/* ---- tScreenTournSelect::DrawForeground  [SCREENTOURNSELECT.CPP:381-387] ---- */
void tScreenTournSelect::DrawForeground()

{
  /* MATCH: SLD records no locals; the decompiler's unused buffer, RECT,
     colors, and draw-flags aggregate inflated the frame from 48 to 144. */
  PSXDrawBrightEndLine(0x232323,0xa7,0x29,0x13c,1,3,(int)this->fScreenFadeVal,0x14);
  PSXDrawBrightEndLine(0x232323,0xa7,0x4a,0x13c,1,2,(int)this->fScreenFadeVal,0x14);
  return;
}



/* end of screentournselect.cpp */
