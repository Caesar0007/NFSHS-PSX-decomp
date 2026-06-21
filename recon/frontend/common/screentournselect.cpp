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

  (this->_base_tScreen)._vf = (__vtbl_ptr_type (*)[10])tScreenTournSelect_vtable;
  return;
}



/* ---- tScreenTournSelect::dtor  [SCREENTOURNSELECT.CPP:65-68] ---- */
tScreenTournSelect::~tScreenTournSelect()

{
  (this->_base_tScreen)._vf = (__vtbl_ptr_type (*)[10])tScreenTournSelect_vtable;
  tScreen_dtor(&this->_base_tScreen);
  return;
}



/* ---- tScreenTournSelect::GetShapeInfo  [SCREENTOURNSELECT.CPP:69-87] ---- */
void tScreenTournSelect::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  byte useSpecial;
  byte tournOffset;
  tTournamentDefinition *def;
  
  def = tournamentManager.fDefinition;
  useSpecial = frontEnd.tournament;
  if (frontEnd.tier != '\0') {
    useSpecial = frontEnd.specialevent;
  }
  tournOffset = (tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset;
  numPermShapes = 0x40;
  numSwapShapes = 0x20;
  *permFileName = "ztourn";
  GetTrophyName(&tournamentManager,def->fTournaments + (uint)useSpecial + (uint)tournOffset,ts_Medium,gSwapFileName,-1);
  *swapFileName = gSwapFileName;
  return;
}



/* ---- tScreenTournSelect::Initialize  [SCREENTOURNSELECT.CPP:88-139] ---- */
void tScreenTournSelect::Initialize()

{
  byte useSpecial;
  ushort flags;
  int tvIdx;
  short js;
  short j;
  short i;
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
  this->_base_tScreen.Initialize();
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
      js = (short)j;
      tvIdx = (short)i * 2 + (int)js;
      InitTV(this->trophyTV + tvIdx,(this->_base_tScreen).fPermShapes.fShapes,0);
      j = j + 1;
      this->trophyTV[tvIdx].y = js * 0x25 + 0x8e;
      this->trophyTV[tvIdx].w = 0x4c;
      flags = this->trophyTV[tvIdx].flags;
      this->trophyTV[tvIdx].x = (short)i * 0x4c + 0xa5;
      this->trophyTV[tvIdx].h = 0x25;
      this->trophyTV[tvIdx].flags = flags | 0x30;
    } while (j * 0x10000 >> 0x10 < 2);
    i = i + 1;
  } while (i * 0x10000 >> 0x10 < 2);
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
  this->_base_tScreen.Cleanup();
  return;
}



/* ---- tScreenTournSelect::UpdateVideoWall  [SCREENTOURNSELECT.CPP:150-167] ---- */
void tScreenTournSelect::UpdateVideoWall(tTourneyInfo *tourn)

{
  int now;
  char *fileName;
  
  if ((uint)tourn->fTrophyID != (int)this->fPreviousTrophy) {
    fileName = gSwapFileName;
    GetTrophyName(&tournamentManager,tourn,ts_Medium,gSwapFileName,-1);
    AsyncLoadSwapShapeFile(&this->_base_tScreen,fileName);
    this->fTVsInitialized = 0;
    this->fPreviousTrophy = tourn->fTrophyID;
    now = ticks;
    if (-1 < this->fTransitionDirection) {
      this->fTransitionDirection = -1;
      this->fTVTicks = now;
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
  int transX = 0, transY = 0;   /* PSXDrawTransSquare x/y (reg, lost by decompiler) */
  uint transCount;
  tDrawShapeExtended drawFlags;
  
  i = 0xf4;
  drawFlags.custom_shapes = (this->_base_tScreen).fSwapShapes.fShapes;
  DrawBackgroundImage(&this->_base_tScreen,0,0x22,(this->_base_tScreen).fPermShapes.fShapes,0);
  do {
    PSXDrawTransSquare(0x202020,transX,transY,2,0x61,1);
    i = i + 0x50;
  } while (i < 0x1e5);
  i = 0x59;
  do {
    abr = 0xa5;
    PSXDrawTransSquare(0x141414,transX,transY,0x141,1,1);
    i = i + 0x30;
  } while (i < 0x89);
  FeDraw_SetABRMode(abr);
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
  PSXDrawTransSquare(0x303030,transX,transY,2,0x4a,1);
  i = 0xa5;
  PSXDrawTransSquare(0x202020,transX,transY,0x98,1,1);
  FeDraw_SetABRMode(i);
  abr = 0;
  i = 0x1ec;
  do {
    DrawTV((tTVConfig *)((this->_base_tScreen).fPermShapes.fFilename + i + -0x14));
    abr = abr + 1;
    i = i + 0x30;
  } while (abr < 4);
  ScaleShapeExtended(transX,transY,0,0,0,0,&drawFlags);
  return;
}



/* ---- tScreenTournSelect::DrawBackground  [SCREENTOURNSELECT.CPP:230-380] ---- */
void tScreenTournSelect::DrawBackground()

{
  byte tb1;
  long number;
  ushort tu2;
  int YellowCol;
  int row, col, tvIdx;
  int DarkGreyCol;
  int GreyCol;
  int ti6;
  int ti7;
  char *tstr8;
  tListIteratorTournament *tp9;
  tTournamentDefinition *amount;
  RECT *r_00;
  short shapeY;
  short j;
  short i;
  int ti10;
  short y;
  tTourneyInfo *tourn;
  char buffer [64];
  RECT r;
  char moviename [80];
  u_long movieRGB;
  
  tb1 = frontEnd.tournament;
  if (frontEnd.tier != '\0') {
    tb1 = frontEnd.specialevent;
  }
  ti10 = 0;
  tourn = (tournamentManager.fDefinition)->fTournaments +
             (uint)tb1 +
             (uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset;
  amount = tournamentManager.fDefinition;
  YellowCol = CalcFadeVal(0xbebe,(int)tournamentManager.fDefinition);
  DarkGreyCol = CalcFadeVal(0x232323,(int)amount);
  GreyCol = CalcFadeVal(0x505050,(int)amount);
  number = tournamentManager.fMoney;
  FETextRender_MenuTextFade((int)(this->_base_tScreen).fScreenFadeVal,0x7b,textState_Selected,textType_ScreenInfo);
  ti6 = TextSys_WordX(0x7b);
  ti7 = TextSys_WordY(0x7b);
  DrawMoney(ti6 + 0x8c,ti7 + 9,6,number,YellowCol,DarkGreyCol);
  FETextRender_MenuTextFade((int)(this->_base_tScreen).fScreenFadeVal,0x99,textState_Selected,textType_Default);
  ti6 = TextSys_WordX(0x99);
  ti7 = TextSys_WordY(0x99);
  DrawMoney(ti6 + 0x8c,ti7 + 9,6,tourn->fEntranceFee,YellowCol,DarkGreyCol);
  FETextRender_MenuTextFade((int)(this->_base_tScreen).fScreenFadeVal,0x9a,textState_Selected,textType_Default);
  ti6 = TextSys_WordY(0x9a);
  do {
    ti6 = ti6 + 9;
    tstr8 = TextSys_Word((short)ti10 + 0x2d4);
    ti7 = TextSys_WordX(0x9a);
    FETextRender_FullTextRGB(tstr8,(short)ti7,(short)((uint)(ti6 * 0x10000) >> 0x10),GreyCol,'\0',0);
    ti7 = TextSys_WordX(0x99);
    DrawMoney(ti7 + 0x8c,ti6 * 0x10000 >> 0x10,6,tourn->fPrize[(short)ti10],YellowCol,DarkGreyCol);
    ti10 = ti10 + 1;
  } while (ti10 * 0x10000 >> 0x10 < 3);
  this->UpdateVideoWall(tourn);
  IsShapeFileLoaded(&this->_base_tScreen,&(this->_base_tScreen).fSwapShapes);
  if (((this->_base_tScreen).fSwapShapes.fFile != (char *)0x0) && (-1 < this->fTransitionDirection)) {
    UploadSwapShapes(&this->_base_tScreen,0x20);
    ti6 = ticks;
    this->fTransitionDirection = 1;
    this->fTVTicks = ti6;
  }
  this->DrawVideoWall();
  ti6 = 0;
  if ((this->fFrame & 1U) == 0) {
    ti6 = 0x50;
  }
  row = 0;
  do {
    col = 0;
    do {
      tvIdx = (col + (short)row * 4) * 0x10000 >> 0x10;
      this->tvConfigs[tvIdx].x = (short)col * 0x50 + 0xa5;
      this->tvConfigs[tvIdx].w = 0x50;
      this->tvConfigs[tvIdx].h = 0x30;
      this->tvConfigs[tvIdx].uw = '\x14';
      this->tvConfigs[tvIdx].y = (short)row * 0x30 + 0x29;
      this->tvConfigs[tvIdx].u = (char)col * '\x14';
      this->tvConfigs[tvIdx].v = (char)row * '(';
      this->tvConfigs[tvIdx].vh = '(';
      tu2 = GetTPage(2,0,0x200,(int)(short)ti6);
      col = col + 1;
      this->tvConfigs[tvIdx].tpage = tu2;
      this->tvConfigs[tvIdx].state = tv_StateOn;
      this->tvConfigs[tvIdx].clut = 0;
      this->tvConfigs[tvIdx].flags = 0x22;
      this->tvConfigs[tvIdx].tint = 0x2c1e1e;
      this->tvConfigs[tvIdx].destBrightness = 0x80;
      this->tvConfigs[tvIdx].transition = 0x80;
    } while (col * 0x10000 >> 0x10 < 4);
    row = row + 1;
  } while (row * 0x10000 >> 0x10 < 2);
  row = VIDEO_state(this->hVideo);
  if (row == 0) {
    this->fCurrentMovie = 0;
    sprintf(moviename,"%szzzTRN.dct",Paths_Paths[0x29]);
    VIDEO_spoolfile(this->hVideo,moviename);
    VIDEO_startplayback(this->hVideo);
  }
  else {
    ti6 = VIDEO_updateframexy(this->hVideo,0x200,ti6);
    if (ti6 != 0) {
      this->fFrame = this->fFrame + 1;
    }
  }
  ti6 = 0;
  do {
    DrawTVLines(this->tvConfigs + (short)ti6);
    ti6 = ti6 + 1;
  } while (ti6 * 0x10000 >> 0x10 < 8);
  r.x = 0x145;
  r.y = 0x2b;
  r.w = 0x13a;
  r.h = 10;
  if (frontEnd.tier == '\0') {
    tp9 = &menuDefs->iteratorTournament;
  }
  else {
    tp9 = &menuDefs->iteratorSpecialEvent;
  }
  ti6 = TextValue(tp9,kPlayerBoth);
  r_00 = &r;
  FETextRender_WordWrapFade((int)(this->_base_tScreen).fScreenFadeVal,(short)ti6,r_00,textState_Hilighted,
             textType_VideoWall);
  r.x = 0xaa;
  r.w = r.w + -10;
  if (frontEnd.tier == '\0') {
    tp9 = &menuDefs->iteratorTournament;
  }
  else {
    tp9 = &menuDefs->iteratorSpecialEvent;
  }
  ti6 = TextValue(tp9,kPlayerBoth);
  row = (ti6 + 0x26) * 0x10000 >> 0x10;
  if ((row != this->fPrevi) || (this->PreCalculatedTournamentY == -1)) {
    this->fPrevi = row;
    tstr8 = TextSys_Word(row);
    row = FETextRender_WordWrapHeight(r.w,tstr8);
    this->PreCalculatedTournamentY = 0x75 - row;
  }
  r.y = (short)this->PreCalculatedTournamentY;
  col = 0;
  tstr8 = TextSys_Word((int)(short)(ti6 + 0x26));
  row = CalcFadeVal(0x505050,(int)r_00);
  FETextRender_WordWrapTextRGB(tstr8,&r,row);
  FETextRender_MenuTextPositionedJustifyFade((int)(this->_base_tScreen).fScreenFadeVal,0x3db,0xaa,0x75,0,textState_Selected,
             textType_ScreenInfo);
  FETextRender_MenuTextPositionedJustifyFade((int)(this->_base_tScreen).fScreenFadeVal,(short)((uint)((ti6 + 0x39) * 0x10000) >> 0x10),
             0xaa,0x7d,0,textState_Hilighted,textType_ScreenInfo);
  do {
    DrawTV(this->tvConfigs + (short)col);
    col = col + 1;
  } while (col * 0x10000 >> 0x10 < 8);
  return;
}



/* ---- tScreenTournSelect::DrawForeground  [SCREENTOURNSELECT.CPP:381-387] ---- */
void tScreenTournSelect::DrawForeground()

{
  short shapeY;
  short y;
  int DarkGreyCol;
  int YellowCol;
  char buffer [64];
  RECT r;
  uint movieRGB;
  tDrawShapeExtended drawFlags;
  
  PSXDrawBrightEndLine(0x232323,0xa7,0x29,0x13c,1,3,(int)(this->_base_tScreen).fScreenFadeVal,0x14);
  PSXDrawBrightEndLine(0x232323,0xa7,0x4a,0x13c,1,2,(int)(this->_base_tScreen).fScreenFadeVal,0x14);
  return;
}



/* end of screentournselect.cpp */
