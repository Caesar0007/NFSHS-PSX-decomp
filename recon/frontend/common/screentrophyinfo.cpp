/* frontend/screens/screentrophyinfo.cpp -- RECONSTRUCTED (trophy-info screen; C++ TU)
 *   3 member fns of tScreenTrophyInfo (embeds tScreen base as _base_tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom stack-args resolved vs disasm.
 */
#include "screentrophyinfo_types.h"
#include "screentrophyinfo_externs.h"

/* retail's SYM records an inline-call pair at every tick read in this TU: the tick counter is read
   through an inline getter, not directly */
static inline int FE_Ticks(void) { return ticks; }


/* retail: this object's .rodata opens with the unreferenced "SimpleMem" tag (its vtables' 8-byte alignment proves the
 * section starts there).  An unused inline leaves exactly that behind: the literal is emitted, the body is not. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }


/* ---- tScreenTrophyInfo::GetShapeInfo  [SCREENTROPHYINFO.CPP:47-61] ---- */
/* SOURCE-REVIEW-UNRESOLVED: placement, feTier and currentTourn are not
   recovered original locals. Definition getter calls reproduce the two
   retail inline pairs; staged idx and the artificial scope are removed.
   Byte feTier is debug-elided but not thereby certified original. Failed
   direct placement/current-tournament forms are recorded in sym-match.md.
   No post-compile instruction-move rule is used for this reconstruction. */
void tScreenTrophyInfo::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  tTourneyInfo *tourn;
  short placement;
  byte feTier = (byte)frontEnd.tier;
  byte currentTourn;
  tourn = (currentTourn = (uint)(byte)screenTrophyRoom->fRealCurrentTourn[screenTrophyRoom->tier],
           tournamentManager.Definition()->fTournaments +
               ((uint)tournamentManager.Definition()->fTiers[feTier].fTournOffset + currentTourn));
  placement = 0;
  if ((u_int)((signed char)tournamentManager.fBestPlacement[(signed char)tourn->fTournamentID] - 1) < 3) {
    placement = (signed char)tournamentManager.fBestPlacement[(signed char)tourn->fTournamentID];
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
/* SOURCE-REVIEW-UNRESOLVED: tournID, tourn, feTier and currentTourn are
   behavior-backed saved values, not uniquely recovered original locals.
   The definition accessor calls and removal of the old staging scope reproduce
   all seven retail regions. Byte feTier elides its debug row, not its source
   object. Failed signed-byte/reused-i variants are recorded in sym-match.md;
   neither proves that a distinct ID capture was required in original source. */
void tScreenTrophyInfo::DrawBackground()

{
  int FadePartI;
  int FadePartIITheRevenge;
  RECT r;
  int col;
  int yyy;
  tDrawShapeExtended drawFlags;
  tDrawShapeExtended drawFlags2;
  int i;
  
  /* P864: publish SYM's FadePartI only after the lower-clamp and shift;
     the unnamed pre-clamp value belongs to GCC, not a source local `fade`.
     This expression retains PASS298 and the REG19/REG20 fade ownership. */
  FadePartI = (0 < (int)this->fScreenFadeVal - 0x40 ?
      (int)this->fScreenFadeVal - 0x40 : 0) << 1;
  /* P864: the period GNU C++ min/max operators form one clamp expression,
     matching SLD72 (80041178..80041190) and keeping the result in REG20.
     Compiler support is explicit in gcc-2.8.1 cp/lex.c and cp/typeck.c.
     This is a verified expression reconstruction, not recovered macro text. */
  FadePartIITheRevenge = (((int)this->fScreenFadeVal << 1) >? 0) <? 0x80;
  int tournID;
  tTourneyInfo *tourn;

  byte feTier;
  byte currentTourn;
  feTier = (byte)frontEnd.tier;
  tourn = tournamentManager.Definition()->fTournaments +
      (currentTourn = (byte)screenTrophyRoom->fRealCurrentTourn[screenTrophyRoom->tier],
       (uint)tournamentManager.Definition()->fTiers[feTier].fTournOffset + currentTourn);
  tournID = (signed char)tourn->fTournamentID;
  col = CalcFadeVal(kRGBVals[(byte)textDefinitions[4][5]],FadePartI);
  yyy = 0xaf;
  FETextRender_FullTextRGB(TextSys_Word((signed char)tourn->fTournamentID + 0x341),0x1e,0x19,col,'\x03',3);
  if (strlen(TextSys_Word(tournID + 0x37a)) != 0) {
    FETextRender_MenuTextPositionedJustifyFade(FadePartI,0x3db,0x8c,0xaf,1,textState_Hilighted,textType_ScreenInfo);
    /* P864: retail SLD94 is one call expression, including both nested
       calls. No separate `word` declaration or later `col` assignment. */
    FETextRender_FullTextRGB(TextSys_Word(tournID + 0x37a),0x91,0xaf,
        CalcFadeVal(0x505050,FadePartI),'\0',0);
    yyy = 0xb7;
  }
  if (strlen(TextSys_Word(tournID + 0x3a0)) != 0) {
    FETextRender_MenuTextPositionedJustifyFade(FadePartI,0x3dd,0x8c,yyy,1,textState_Hilighted,textType_ScreenInfo);
    r.x = 0x91;
    r.w = 0x15b;
    r.y = yyy;
    r.h = 100;
    FETextRender_WordWrapTextRGB(TextSys_Word(tournID + 0x3a0),r,
        CalcFadeVal(0x505050,FadePartI));
    /* WordWrapHeight returns int; the old short declaration inserted a false sign extend. */
    yyy = yyy + FETextRender_WordWrapHeight(0x15b,
        TextSys_Word(tournID + 0x3a0));
  }
  if (strlen(TextSys_Word(tournID + 0x38d)) != 0) {
    FETextRender_MenuTextPositionedJustifyFade(FadePartI,0x3dc,0x8c,yyy,1,textState_Hilighted,textType_ScreenInfo);
    r.x = 0x91;
    r.w = 0x15b;
    r.y = yyy;
    r.h = 100;
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
  ScaleShapeExtended((FE_Ticks() / 12) % 32,0x600,0x46,-5,FadePartI,0,&drawFlags);
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
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);



/* end of screentrophyinfo.cpp */
