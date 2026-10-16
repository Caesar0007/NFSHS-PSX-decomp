/* frontend/screens/screentournselect.cpp -- RECONSTRUCTED (tournament-select screen; C++ TU)
 *   9 member fns (incl ctor) of tScreenTournSelect (embeds tScreen base as _base_tScreen).
 *   Bodies from Ghidra; namespaces stripped, phantom stack-args resolved vs disasm.
 */
#include "screentournselect_types.h"
#include "screentournselect_externs.h"

/* retail's SYM records an inline-call pair at every tick read in this TU: the tick counter is read
   through an inline getter, not directly */
static inline int FE_Ticks(void) { return ticks; }

/* Explicit frontend selection, not the manager's cached tier/tournament.
   Same inferred lookup spelling as the trophy-room reconstruction; original
   inline name/signature/parameter spellings are not uniquely supplied by SYM. */
static inline tTourneyInfo *TourneyInTier(byte tier, byte tournament)
{
  return tournamentManager.fDefinition->fTournaments +
      (tournament + tournamentManager.fDefinition->fTiers[tier].fTournOffset);
}

/* Inferred value-query spelling (the other owner surface uses GetMoney).
   Restores the second empty pair at +84 without new records or code.
   The original inline name/signature is not supplied by retail SYM. */
static inline long TourneyMoney(void) { return tournamentManager.fMoney; }


/* Retail screentournselect.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

/* M13: DrawVideoWall (below) now indexes the real trophyTVOrder[4]={1,2,0,3} @0x80052058 (already
 * materialized in screentournselect_externs.h, EXE bytes 01 02 00 03) instead of an inlined truncated
 * literal "\x01\x02" (={1,2,0}+NUL) that read OUT OF BOUNDS at i=3 where the real table holds 3. */


/* ---- tScreenTournSelect::ctor  [SCREENTOURNSELECT.CPP:64] ---- */
tScreenTournSelect::tScreenTournSelect()

{

  return;
}



/* ---- tScreenTournSelect::dtor  [SCREENTOURNSELECT.CPP:65-68] ---- */
tScreenTournSelect::~tScreenTournSelect()

{
  /* MATCH: no manual tScreen_dtor — declared base dtor auto-fires (vptr store
     lands in its jal delay slot; __in_chrg forwarded in $a1). */
  return;
}



/* ---- tScreenTournSelect::GetShapeInfo  [SCREENTOURNSELECT.CPP:69-87] ---- */

/* MATCH51: no caller-side selection/address objects. The real output
   assignments in the manager argument keep numSwapShapes live through the
   selection lookup, reproducing the t1 copy and original load/store order.
   This source grouping and the query spelling are inferred, not recovered
   literal macro text. Full SLD attribution remains open. */
void tScreenTournSelect::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  GetTrophyName((numPermShapes = 0x40,
                numSwapShapes = 0x20,
                *permFileName = "ztourn", &tournamentManager),
      TourneyInTier((byte)frontEnd.tier,
          (byte)(frontEnd.tier != '\0' ? frontEnd.specialevent : frontEnd.tournament)),
      ts_Medium,gSwapFileName,-1);
  *swapFileName = gSwapFileName;
  return;
}




/* ---- tScreenTournSelect::Initialize  [SCREENTOURNSELECT.CPP:88-139] ---- */
void tScreenTournSelect::Initialize()

{
  /* MATCH146: keep the full VIDEO_create result in hVideo. Real counted TV
     loops and a common indexed InitTV argument need no tvIdx capture. The
     byte-parameter trophy query preserves the frontend selection/address
     web without useSpecial or fe. All five retail records and region pairs
     agree; query spelling and full SLD still require original-source review. */
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
  this->tScreen::Initialize();
  this->fCurrentMovie = 0;
  this->fPreviousMovie = 0;
  sprintf(moviename,"%szzzTRN.dct",Paths_Paths[0x29]);
  VIDEO_spoolfile(this->hVideo = VIDEO_create(0x50,0x50,0xf0000,0x25800,0x10),
                  moviename);
  i = 0;
  VIDEO_startplayback(this->hVideo);
  this->fFrame = 0;
  for (; i < 2; i++) {
    for (j = 0; j < 2; j++) {
      InitTV(&this->trophyTV[i * 2 + j],this->fPermShapes.fShapes,0);
      this->trophyTV[i * 2 + j].y = j * 0x25 + 0x8e;
      this->trophyTV[i * 2 + j].w = 0x4c;
      this->trophyTV[i * 2 + j].x = i * 0x4c + 0xa5;
      this->trophyTV[i * 2 + j].h = 0x25;
      this->trophyTV[i * 2 + j].flags |= 0x30;
    }
  }
  this->fPreviousTrophy = TourneyInTier((byte)frontEnd.tier,
      (byte)(frontEnd.tier != '\0' ? frontEnd.specialevent : frontEnd.tournament))->fTrophyID;
  this->fTransitionDirection = 1;
  this->fTVTicks = FE_Ticks();
  return;
}



/* ---- tScreenTournSelect::Cleanup  [SCREENTOURNSELECT.CPP:140-149] ---- */
void tScreenTournSelect::Cleanup()

{
  
  VIDEO_destroy(this->hVideo);
  purgememadr((void *)this->hVideo);
  this->tScreen::Cleanup();
  return;
}



/* ---- tScreenTournSelect::UpdateVideoWall  [SCREENTOURNSELECT.CPP:150-167] ---- */
void tScreenTournSelect::UpdateVideoWall(tTourneyInfo *tourn)

{
  if (tourn->fTrophyID != (signed char)this->fPreviousTrophy) {
    GetTrophyName(&tournamentManager,tourn,ts_Medium,gSwapFileName,-1);
    ::AsyncLoadSwapShapeFile((tScreen *)this,gSwapFileName);
    this->fTVsInitialized = 0;
    this->fPreviousTrophy = tourn->fTrophyID;
    if (-1 < this->fTransitionDirection) {
      this->fTransitionDirection = -1;
      this->fTVTicks = FE_Ticks();
    }
  }
  return;
}



/* ---- tScreenTournSelect::DrawVideoWall  [SCREENTOURNSELECT.CPP:168-229] ---- */
/* MATCH W62: retail falls through the positive-direction TurnOn arm and branches
   to the nonpositive TurnOff/reset arm.  SYM has no `onState` local; both arms
   are bounded directly by transition count and four TVs.  Reusing only SYM's
   `long i`/`long j` across the phases, delaying the first loop initializer until
   after DrawBackgroundImage, and spelling the final walk as `trophyTV[j]`
   restores retail's complete lifetime/address shape: 101 diffs to PASS. */
void tScreenTournSelect::DrawVideoWall()

{
  long i;
  long j;
  tDrawShapeExtended drawFlags;

  drawFlags.custom_shapes = this->fSwapShapes.fShapes;
  ::DrawBackgroundImage((tScreen *)this,0,0x22,this->fPermShapes.fShapes,0);
  i = 0xf4;
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
  i = FE_Ticks() - this->fTVTicks >> 2;
  if (this->fTransitionDirection > 0) {
    for (j = 0; (j < i) && (j < 4); j++) {
      if (this->trophyTV[trophyTVOrder[j]].state == tv_StateOff) {
        TurnOnTV(this->trophyTV + trophyTVOrder[j]);
      }
    }
  }
  else {
    for (j = 0; (j < i) && (j < 4); j++) {
      if (this->trophyTV[trophyTVOrder[j]].state == tv_StateOn) {
        TurnOffTV(this->trophyTV + trophyTVOrder[j]);
      }
    }
    if (3 < i) {
      this->fTransitionDirection = 0;
    }
  }
  /* Oracle 8003FD84 / 8003FDAC: the two closing squares' x/y are literals, not phantom zeros. */
  PSXDrawTransSquare(0x303030,0xf1,0x8e,2,0x4a,1);
  PSXDrawTransSquare(0x202020,0xa5,0xb3,0x98,1,1);
  /* W55-A2 BUGFIX: retail passes literal 2 (oracle 8003FDCC delay slot); recon passed 0xA5. */
  FeDraw_SetABRMode(2);
  i = 0;
  j = 0;
  do {
    DrawTV(this->trophyTV + j);
    i = i + 1;
    j = j + 1;
  } while (i < 4);
  /* Oracle 8003FDF4-8003FE34: a0 = (FE_Ticks() >> 4) % 0x20, then 0x600,0xB6,0x93,0,0,&drawFlags. */
  ScaleShapeExtended(((int)FE_Ticks() >> 4) % 0x20,0x600,0xb6,0x93,0,0,&drawFlags);
  return;
}



/* ---- tScreenTournSelect::DrawBackground  [SCREENTOURNSELECT.CPP:230-380] ---- */
/* MATCH415: the shared inferred tournament lookup needs neither fe nor
   tournament. Keep the signed-short index conversion in each TV ARRAY_REF:
   direct uncast indexing was 54 diffs/413 words, but the narrowed expression
   preserves 415/415 without tvIdx. Other captures and full SLD remain open. */
void tScreenTournSelect::DrawBackground()

{
  short y;
  char buffer [64];
  short i;
  short j;
  RECT r;
  tTourneyInfo *tourn;
  int YellowCol;
  int DarkGreyCol;
  int GreyCol;
  /* SOURCE-REVIEW-UNRESOLVED: number is absent from retail. A direct money
     query argument, including a sequenced label-render/X argument, is
     9 diffs/414 versus415: the load moves beyond the label and coordinate
     calls. Retain this unresolved snapshot, not a claim it was original. */
  long number;
  /* SOURCE-REVIEW-UNRESOLVED: descriptionText is absent from retail.
     Deriving its word index from j with a sequenced i reset is9dif/416;
     direct TextSys_Word(i) plus final for initialization is11dif/414.
     Neither establishes that a distinct source object was required. */
  char *descriptionText;
  short shapeY;
  /* SYM-CODEGEN-CARRIER: shapeX -- repeating literal 0x200 is FAIL 43 at
     410/415; retail retains the signed-short coordinate in `$s6`. */
  short shapeX;
  u_long movieRGB;
  tourn = TourneyInTier((byte)frontEnd.tier,
      (byte)(frontEnd.tier != '\0' ? frontEnd.specialevent : frontEnd.tournament));
  YellowCol = CalcFadeVal(0xbebe,this->fScreenFadeVal);
  DarkGreyCol = CalcFadeVal(0x232323,this->fScreenFadeVal);
  GreyCol = CalcFadeVal(0x505050,this->fScreenFadeVal);
  number = TourneyMoney();
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
    this->fTVTicks = FE_Ticks();
  }
  this->DrawVideoWall();
  shapeY = 0;
  if ((this->fFrame & 1U) == 0) {
    shapeY = 0x50;
  }
  shapeX = 0x200;
  movieRGB = 0x2c1e1e;
  i = 0;
  do {
    j = 0;
    do {
      this->tvConfigs[(short)(j + i * 4)].x = j * 0x50 + 0xa5;
      this->tvConfigs[(short)(j + i * 4)].w = 0x50;
      this->tvConfigs[(short)(j + i * 4)].h = 0x30;
      this->tvConfigs[(short)(j + i * 4)].y = i * 0x30 + 0x29;
      this->tvConfigs[(short)(j + i * 4)].u = j * 0x14;
      this->tvConfigs[(short)(j + i * 4)].uw = 0x14;
      this->tvConfigs[(short)(j + i * 4)].v = i * 0x28;
      this->tvConfigs[(short)(j + i * 4)].vh = 0x28;
      this->tvConfigs[(short)(j + i * 4)].tpage = GetTPage(2,0,shapeX,shapeY);
      this->tvConfigs[(short)(j + i * 4)].state = tv_StateOn;
      this->tvConfigs[(short)(j + i * 4)].clut = 0;
      this->tvConfigs[(short)(j + i * 4)].flags = 0x22;
      this->tvConfigs[(short)(j + i * 4)].tint = movieRGB;
      this->tvConfigs[(short)(j + i * 4)].destBrightness = 0x80;
      this->tvConfigs[(short)(j + i * 4)].transition = 0x80;
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
    /* SYM 65e013-65e03a: this buffer belongs to the nested block at
       80040254-80040288 (source 331-336), AUTO -136, not function scope. */
    char moviename [80];
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
  /* P865: select complete calls so GCC tail-merges them without an unrecorded
     word local. PASS 415; the title-render expression shares retail SLD 347.
     Selecting only the TextValue receiver is FAIL 15 at 414/415. This is an
     inferred source expression, not recovered original macro spelling. */
  frontEnd.tier != '\0' ?
    FETextRender_WordWrapFade((int)this->fScreenFadeVal,
               TextValue(&menuDefs->iteratorSpecialEvent,kPlayerBoth),&r,textState_Hilighted,
               textType_VideoWall) :
    FETextRender_WordWrapFade((int)this->fScreenFadeVal,
               TextValue(&menuDefs->iteratorTournament,kPlayerBoth),&r,textState_Hilighted,
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
