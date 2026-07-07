/* frontend/screens/screentrophyinfo.cpp -- RECONSTRUCTED (trophy-info screen; C++ TU)
 *   3 member fns of tScreenTrophyInfo (embeds tScreen base as _base_tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom stack-args resolved vs disasm.
 */
#include "screentrophyinfo.h"


/* ---- tScreenTrophyInfo::GetShapeInfo  [SCREENTROPHYINFO.CPP:47-61] ---- */
void tScreenTrophyInfo::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  byte tournOffset;
  tTourneyInfo *tourn;
  short curTourn;
  int placement;
  
  tournOffset = (tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset;
  curTourn = screenTrophyRoom->fRealCurrentTourn[screenTrophyRoom->tier];
  tourn = (tournamentManager.fDefinition)->fTournaments;
  placement = 0;
  if ((int)tournamentManager.fBestPlacement[tourn[(uint)tournOffset + (uint)(byte)curTourn].fTournamentID] -
      1U < 3) {
    placement = (int)tournamentManager.fBestPlacement
                 [tourn[(uint)tournOffset + (uint)(byte)curTourn].fTournamentID];
  }
  this->BannerCol = kBannerColors[placement];
  GetTrophyName(&tournamentManager,tourn + (uint)tournOffset + (uint)(byte)curTourn,ts_Large,gSwapFileNameTI,-1);
  numSwapShapes = 0x20;
  *swapFileName = gSwapFileNameTI;
  *permFileName = "zSTI";
  numPermShapes = 0xb;
  return;
}



/* ---- tScreenTrophyInfo::DrawBackground  [SCREENTROPHYINFO.CPP:64-153 (body @67)] ---- */
void tScreenTrophyInfo::DrawBackground()

{
  tTourneyInfo *tournaments;
  int ti_col;
  char *word;
  uint len;
  int ti_fade;
  int i;
  int yyy;
  int FadePartI;
  int FadePartIITheRevenge;
  int col;
  int colIdx;
  int tournID;
  int bannerXOff = 0;   /* banner x-offset (stack-passed, lost by decompiler) */
  RECT r;
  tDrawShapeExtended drawFlags;
  tDrawShapeExtended drawFlags2;
  
  FadePartIITheRevenge = (int)this->fScreenFadeVal;
  FadePartI = FadePartIITheRevenge + -0x40;
  FadePartIITheRevenge = FadePartIITheRevenge << 1;
  if (FadePartI < 0) {
    FadePartI = 0;
  }
  FadePartI = FadePartI << 1;
  if (FadePartIITheRevenge < 0) {
    FadePartIITheRevenge = 0;
  }
  if (0x80 < FadePartIITheRevenge) {
    FadePartIITheRevenge = 0x80;
  }
  ti_fade = (uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset +
          (uint)(byte)screenTrophyRoom->fRealCurrentTourn[screenTrophyRoom->tier];
  tournaments = (tournamentManager.fDefinition)->fTournaments;
  tournID = (int)tournaments[ti_fade].fTournamentID;
  col = kRGBVals[(byte)textDefinitions[4][5]];
  ti_col = CalcFadeVal(col,ti_fade);
  yyy = 0xaf;
  word = TextSys_Word(tournaments[ti_fade].fTournamentID + 0x341);
  ti_fade = 0x19;
  FETextRender_FullTextRGB(word,0x1e,0x19,ti_col,'\x03',3);
  word = TextSys_Word(tournID + 0x37a);
  len = strlen(word);
  if (len != 0) {
    ti_col = 0x8c;
    FETextRender_MenuTextPositionedJustifyFade(FadePartI,0x3db,0x8c,0xaf,1,textState_Hilighted,textType_ScreenInfo);
    word = TextSys_Word(tournID + 0x37a);
    ti_col = CalcFadeVal(0x505050,ti_col);
    ti_fade = 0xaf;
    FETextRender_FullTextRGB(word,0x91,0xaf,ti_col,'\0',0);
    yyy = 0xb7;
  }
  ti_col = tournID + 0x3a0;
  word = TextSys_Word(ti_col);
  len = strlen(word);
  if (len != 0) {
    ti_fade = 0x8c;
    FETextRender_MenuTextPositionedJustifyFade(FadePartI,0x3dd,0x8c,yyy,1,textState_Hilighted,textType_ScreenInfo);
    r.x = 0x91;
    r.w = 0x15b;
    r.h = 100;
    r.y = yyy;
    word = TextSys_Word(ti_col);
    ti_fade = CalcFadeVal(0x505050,ti_fade);
    FETextRender_WordWrapTextRGB(word,r,ti_fade);
    word = TextSys_Word(ti_col);
    ti_col = FETextRender_WordWrapHeight(0x15b,word);
    yyy = yyy + (short)ti_col;
  }
  ti_col = tournID + 0x38d;
  word = TextSys_Word(ti_col);
  len = strlen(word);
  if (len != 0) {
    ti_fade = 0x8c;
    FETextRender_MenuTextPositionedJustifyFade(FadePartI,0x3dc,0x8c,yyy,1,textState_Hilighted,textType_ScreenInfo);
    r.x = 0x91;
    r.w = 0x15b;
    r.h = 100;
    r.y = yyy;
    word = TextSys_Word(ti_col);
    ti_fade = CalcFadeVal(0x505050,ti_fade);
    FETextRender_WordWrapTextRGB(word,r,ti_fade);
    word = TextSys_Word(ti_col);
    FETextRender_WordWrapHeight(0x15b,word);
  }
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  if (this->fSwapShapes.fFile != (char *)0x0) {
    ::UploadSwapShapes((tScreen *)this,0x20);
  }
  r.x = 0x23;
  r.y = 0x2d;
  r.w = 0x1c4;
  r.h = 100;
  word = TextSys_Word(tournID + 0x367);
  FETextRender_WordWrapTextRGBJustify(word,r,CalcFadeVal(0x505050,ti_fade),3,0,false);
  drawFlags.custom_shapes = this->fSwapShapes.fShapes;
  ScaleShapeExtended(bannerXOff,0x600,0x46,-5,FadePartI,0,&drawFlags);
  i = 1;
  drawFlags2.tint[0] = this->BannerCol;
  colIdx = 0;
  do {
    if (i != (colIdx - (i >> 0x1f)) * 3) {
      DrawShapeExtended(colIdx,0x410,i << 1,0,FadePartIITheRevenge,0,&drawFlags2);
    }
    i = i + 1;
    colIdx = i / 3 + (i >> 0x1f);
  } while (i < 0x1e);
  i = 0x22;
  colIdx = 0xb;
  do {
    if (i != (colIdx - (i >> 0x1f)) * 3) {
      DrawShapeExtended(colIdx,0x410,i << 1,0,FadePartIITheRevenge,0,&drawFlags2);
    }
    i = i + 1;
    colIdx = i / 3 + (i >> 0x1f);
  } while (i < 0x3f);
  return;
}



/* ---- tScreenTrophyInfo::dtor  [SCREENTROPHYINFO.CPP:153 (~dtor inlined from SCREENTROPHYINFO.H:30)] ---- */
tScreenTrophyInfo::~tScreenTrophyInfo()

{
  return;
}



/* end of screentrophyinfo.cpp */
