/* frontend/screens/screentrophyinfo.cpp -- RECONSTRUCTED (trophy-info screen; C++ TU)
 *   3 member fns of tScreenTrophyInfo (embeds tScreen base as _base_tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom stack-args resolved vs disasm.
 */
#include "screentrophyinfo.h"


/* ---- tScreenTrophyInfo::GetShapeInfo  [SCREENTROPHYINFO.CPP:47-61] ---- */
void tScreenTrophyInfo::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  /* SYM 8c @0x80041008: the ONLY declared local is `tTourneyInfo *tourn` (REG $05); the
     tournOffset/curTourn/placement temps in the Ghidra body are compiler temps.  Crucially
     `tourn` is the ELEMENT pointer, not the array base -- the oracle folds the whole
     `fTournaments + idx*84` (plus the +0x24 field offset of fTournaments inside the
     definition) into ONE address and reuses it for both the fTournamentID load and the
     GetTrophyName argument; indexing an array-base `tourn[off+cur]` duplicates the
     index math (ours was 87 insns vs the oracle's 76).  fTournamentID is read SIGNED
     (`lb`) -- the shared-header plain `char` is unsigned on this build, hence the cast.
     71 -> 27 diffs, 75/76 insns.  RESIDUAL: retail materializes the screenTrophyRoom
     chain (lui/lw + `->tier` scale) BEFORE the frontEnd.tier/fDefinition chain; swapping
     the two addends of the index sum was measured WORSE (37), so the load order is an
     emission/statement-position dial that still needs a named angle.  (W55-A15) */
  tTourneyInfo *tourn;
  int placement;

  tourn = (tournamentManager.fDefinition)->fTournaments +
          ((uint)(tournamentManager.fDefinition)->fTiers[(byte)frontEnd.tier].fTournOffset +
           (uint)(byte)screenTrophyRoom->fRealCurrentTourn[screenTrophyRoom->tier]);
  placement = 0;
  if ((u_int)(tournamentManager.fBestPlacement[(signed char)tourn->fTournamentID] - 1) < 3) {
    placement = tournamentManager.fBestPlacement[(signed char)tourn->fTournamentID];
  }
  this->BannerCol = kBannerColors[placement];
  GetTrophyName(&tournamentManager,tourn,ts_Large,gSwapFileNameTI,-1);
  numSwapShapes = 0x20;
  *swapFileName = gSwapFileNameTI;
  *permFileName = "zSTI";
  numPermShapes = 0xb;
  return;
}

/* ---- tScreenTrophyInfo::DrawBackground  [SCREENTROPHYINFO.CPP:64-153 (body @67)] ---- */
void tScreenTrophyInfo::DrawBackground()

{
  int FadePartI;
  int FadePartIITheRevenge;
  int col;
  int yyy;
  RECT r;
  tDrawShapeExtended drawFlags;
  tDrawShapeExtended drawFlags2;
  int i;
  
  {
    int fade = (int)this->fScreenFadeVal + -0x40;

    FadePartIITheRevenge = (int)this->fScreenFadeVal << 1;
    if (fade < 0) {
      fade = 0;
    }
    FadePartI = fade << 1;
  }
  if (FadePartIITheRevenge < 0) {
    FadePartIITheRevenge = 0;
  }
  if (0x80 < FadePartIITheRevenge) {
    FadePartIITheRevenge = 0x80;
  }
  int tournID;

  {
    int tournamentIndex;
    tTournamentDefinition *definition;
    tTourneyInfo *tournaments;

    definition = tournamentManager.fDefinition;
    tournamentIndex =
        (uint)definition->fTiers[(byte)frontEnd.tier].fTournOffset +
        (uint)(byte)screenTrophyRoom->fRealCurrentTourn[screenTrophyRoom->tier];
    tournaments = definition->fTournaments + tournamentIndex;
    tournID = tournaments->fTournamentID;
  }
  col = kRGBVals[(byte)textDefinitions[4][5]];
  col = CalcFadeVal(col,FadePartI);
  yyy = 0xaf;
  FETextRender_FullTextRGB(TextSys_Word(tournID + 0x341),0x1e,0x19,col,'\x03',3);
  if (strlen(TextSys_Word(tournID + 0x37a)) != 0) {
    char *word;

    FETextRender_MenuTextPositionedJustifyFade(FadePartI,0x3db,0x8c,0xaf,1,textState_Hilighted,textType_ScreenInfo);
    word = TextSys_Word(tournID + 0x37a);
    col = CalcFadeVal(0x505050,FadePartI);
    FETextRender_FullTextRGB(word,0x91,0xaf,col,'\0',0);
    yyy = 0xb7;
  }
  if (strlen(TextSys_Word(tournID + 0x3a0)) != 0) {
    FETextRender_MenuTextPositionedJustifyFade(FadePartI,0x3dd,0x8c,yyy,1,textState_Hilighted,textType_ScreenInfo);
    r.x = 0x91;
    r.w = 0x15b;
    r.h = 100;
    r.y = yyy;
    FETextRender_WordWrapTextRGB(TextSys_Word(tournID + 0x3a0),r,
        CalcFadeVal(0x505050,FadePartI));
    yyy = yyy + (short)FETextRender_WordWrapHeight(0x15b,
        TextSys_Word(tournID + 0x3a0));
  }
  if (strlen(TextSys_Word(tournID + 0x38d)) != 0) {
    FETextRender_MenuTextPositionedJustifyFade(FadePartI,0x3dc,0x8c,yyy,1,textState_Hilighted,textType_ScreenInfo);
    r.x = 0x91;
    r.w = 0x15b;
    r.h = 100;
    r.y = yyy;
    FETextRender_WordWrapTextRGB(TextSys_Word(tournID + 0x38d),r,
        CalcFadeVal(0x505050,FadePartI));
    FETextRender_WordWrapHeight(0x15b,TextSys_Word(tournID + 0x38d));
  }
  ::IsShapeFileLoaded((tScreen *)this,&this->fSwapShapes);
  if (this->fSwapShapes.fFile != (char *)0x0) {
    ::UploadSwapShapes((tScreen *)this,0x20);
  }
  r.x = 0x23;
  r.y = 0x2d;
  r.w = 0x1c4;
  r.h = 100;
  FETextRender_WordWrapTextRGBJustify(TextSys_Word(tournID + 0x367),r,
      CalcFadeVal(0x505050,FadePartI),3,0,false);
  drawFlags.custom_shapes = this->fSwapShapes.fShapes;
  ScaleShapeExtended((ticks / 12) % 32,0x600,0x46,-5,FadePartI,0,&drawFlags);
  drawFlags2.tint[0] = this->BannerCol;
  i = 1;
  do {
    if ((i % 3) != 0) {
      DrawShapeExtended(0,0x410,i << 1,0,FadePartIITheRevenge,0,&drawFlags2);
    }
    i = i + 1;
  } while (i < 0x1e);
  i = 0x22;
  do {
    if ((i % 3) != 0) {
      DrawShapeExtended(0,0x410,i << 1,0,FadePartIITheRevenge,0,&drawFlags2);
    }
    i = i + 1;
  } while (i < 0x3f);
  return;
}



/* ---- tScreenTrophyInfo::dtor  [SCREENTROPHYINFO.CPP:153 (~dtor inlined from SCREENTROPHYINFO.H:30)] ---- */
tScreenTrophyInfo::~tScreenTrophyInfo()

{
  return;
}



/* end of screentrophyinfo.cpp */
