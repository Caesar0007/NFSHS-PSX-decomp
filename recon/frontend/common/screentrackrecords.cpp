/* frontend/screens/screentrackrec.cpp  --  RECONSTRUCTED  (track-records screen; C++ TU)
 *   7 member fns of tScreenTrackRecords : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
#include "../../nfs4_types.h"
#include "screentrackrecords_externs.h"

/* ---- tScreenTrackRecords::GetShapeInfo  (screentrackrec.cpp:67) ---- */
void tScreenTrackRecords::GetShapeInfo(short &numPermShapes,short &numSwapShapes,
               char **permFileName,char **swapFileName)

{
  numPermShapes = 0x28;
  numSwapShapes = 0;
  *permFileName = "zRec";
  *swapFileName = (char *)0x0;
  return;
}

/* ---- tScreenTrackRecords::Initialize  (screentrackrec.cpp:78) ---- */
void tScreenTrackRecords::Initialize()

{
  short nShowTrack;
  tRecordBuffer *recs;
  
  this->flareextra = 0;
  this->tScreen::Initialize();
  recs = (tRecordBuffer *)reservememadr("trkrcrds",0x168,0x10);
  this->TrackRecords = recs;
  nShowTrack = Front_GetTrackRaced();
  Stattool_GetRecords(nShowTrack,this->TrackRecords);
  this->fReadNewData = 0;
  return;
}

/* ---- tScreenTrackRecords::Cleanup  (screentrackrec.cpp:97) ---- */
void tScreenTrackRecords::Cleanup()

{
  
  purgememadr(this->TrackRecords);
  this->TrackRecords = (tRecordBuffer *)0x0;
  StatChk_ClearNewRecords();
  this->tScreen::Cleanup();
  return;
}

/* ---- tScreenTrackRecords::DrawOneRecord  (screentrackrec.cpp:113) ---- */
void tScreenTrackRecords::DrawOneRecord(int index,bool newrecord,int y)

{
  tMenuTextState textState;
  char sBuildOutput [80];

  textState = (tMenuTextState)((newrecord != 0) << 1);
  if (-1 < this->TrackRecords[index].nBestLap) {
    if (newrecord != 0) {
      Flare_2DHalo(TextSys_WordX(0x247) + 3,y + 4,
                   this->flare_intensity / 2,
                   (this->flare_intensity * 2) / 3,0x17);
      DrawShapeExtended(0,0,TextSys_WordX(0x247),y,0,0,
                        (tDrawShapeExtended *)0x0);
    }
    FETextRender_FullText
              (this->TrackRecords[index].sName,(short)TextSys_WordX(0x24b),
               (short)y,textType_TrackRecords,
               newrecord != 0 ? textState_Hilighted : textState_Selected,0);
    FETextRender_FullText
              (TextSys_Word(this->TrackRecords[index].nCar + 0x153),
               (short)TextSys_WordX(0x24c),(short)y,
               textType_TrackRecords,textState,0);
    if (this->TrackRecords[index].nTime != 0) {
      Stattool_ParseTime(this->TrackRecords[index].nTime,sBuildOutput);
    }
    else {
      sprintf(sBuildOutput,TextSys_Word(0x261));
    }
    FETextRender_FullText
              (sBuildOutput,(short)TextSys_WordX(0x24d),(short)y,
               textType_TrackRecords,
               newrecord ? textState_Hilighted
                              : (tMenuTextState)(index != 0),0);
    Stattool_ParseTime(this->TrackRecords[index].nBestLap,sBuildOutput);
    FETextRender_FullText
              (sBuildOutput,(short)TextSys_WordX(0x24e),(short)y,
               textType_TrackRecords,
               index != 0 || textState != textState_Unselected
                 ? textState : textState_Selected,0);
  }
  return;
}

/* ---- tScreenTrackRecords::DrawRecords  (screentrackrec.cpp:161) ---- */
/* MATCH: unsized-array asm-label view -- the oracle loads NewBestLap through a
   SEPARATE %hi scratch (`lui $v1; lw $a2,%lo(..)($v1)`), not the self-temp form. */
extern bool NewBestLapA[] asm("NewBestLap");

void tScreenTrackRecords::DrawRecords(short maxitem)

{
  /* MATCH: the SYM 8c block lists exactly TWO locals -- short nLapIndicator($a0)
     and short k($s2) (this=$s4, maxitem=$fp; fsize 64, mask $c0ff0000).
     Ghidra's kk/flareSign/sMenuText/idx/wy/flareTmp/textState are fabricated;
     they forced a stack home for the short parameter and hid the shared
     signed-/2 of the ping-pong flare counter (SLD 163-197). */
  short nLapIndicator;
  short k;

  this->flareextra = this->flareextra + 1;
  if (0x3c < this->flareextra) {
    this->flareextra = 0;
  }
  /* MATCH: the signed /2 is written in BOTH arms -- gcc cross-jump-merges the
     shared `addu; sra 1` tail, leaving the oracle's `slti 0x1F; bnez` that skips
     only the 60-x subtraction.  A ternary shares the divide in source but emits
     the addu operands the other way round (addu v0,v0,v1 vs v1,v0). */
  if (0x1e < this->flareextra) {
    this->flare_intensity = (0x3c - this->flareextra) / 2;
  }
  else {
    this->flare_intensity = this->flareextra / 2;
  }
  /* MATCH: the oracle STORES then RE-READS flare_intensity here (sw/lw pair).
     Our cc1 forward-propagates the value and then dead-store-eliminates the
     first store; a volatile view of the second read restores retail's
     store->reload (value-preserving codegen device, cf. catalog SF). */
  this->flare_intensity = (*(volatile int *)&this->flare_intensity + 0x14)
                          * 0x80;
  /* MATCH: explicit if/ELSE -- the `= 9` lands in the `bne` DELAY SLOT after the
     call, so nLapIndicator lives in the caller-saved $a0 the SYM records.  A
     plain `nLapIndicator = 9;` before the call forces a callee-saved reg. */
  if (Front_GetLapsForType() == 2) {
    nLapIndicator = 1;
  }
  else {
    nLapIndicator = 9;
  }
  for (k = 0; k < 8; k = k + 1) {
    if (maxitem <= k) break;
    FETextRender_FullText(TextSys_Word(k + 599),(short)TextSys_WordX(0x249),
                          (short)TextSys_WordY(k + 599),textType_TrackRecords,
                          (NewRecords[k] == 0) ? textState_Unselected : textState_Hilighted,0);
    this->DrawOneRecord(k + nLapIndicator,NewRecords[k],TextSys_WordY(k + 599));
  }
  if (8 < maxitem) {
    this->DrawOneRecord(0,NewBestLapA[0],TextSys_WordY(0x260));
  }
  return;
}

/* ---- tScreenTrackRecords::DrawBackground  (screentrackrec.cpp:210) ---- */
static inline int TrackRecordLineY(short y)
{
  return y - 0xc;
}

void tScreenTrackRecords::DrawBackground()

{
  char string[50];
  char string2[50];
  int fade;
  int fadeAmt;
  int clampTmp;
  int lineFadeCalc;
  short linefadeval;
  short maxitem;
  short boxx;
  short boxy;
  short boxw;
  short midy;
  short j;
  int Col;
  int ColTextSel;
  int ColTextBright;
  tTexture_ShapeInfo *shape;
  int lbx;
  int tt;
  tDrawShapeExtended drawflags;

  fade = (this->fScreenFadeVal * 0x134) / 0x80;
  fadeAmt = fade - 0xb4;
  if (fadeAmt < 0) {
    fadeAmt = 0;
  }
  if (0x80 < fadeAmt) {
    fadeAmt = 0x80;
  }
  clampTmp = fade;
  if (clampTmp < 0) {
    clampTmp = 0;
  }
  if (0xb4 < clampTmp) {
    clampTmp = 0xb4;
  }
  lineFadeCalc = (fade * 0x80) / 0xb4;
  if (lineFadeCalc < 0) {
    lineFadeCalc = 0;
  }
  if (0x80 < lineFadeCalc) {
    lineFadeCalc = 0x80;
  }
  linefadeval = lineFadeCalc;
  maxitem = (0xb4 - (short)clampTmp) / 0x14;
  boxx = TextSys_WordX(0x248);
  boxy = TextSys_WordY(0x256);
  boxw = TextSys_WordX(0x24f) - boxx;
  midy = TextSys_WordY(0x25f);
  Col = 0x232323;
  ColTextSel = CalcFadeVal(kRGBVals[(byte)textDefinitions[0xb][4]],(short)fadeAmt);
  ColTextBright = CalcFadeVal(kRGBVals[(byte)textDefinitions[0xb][5]],(short)fadeAmt);
  this->DrawRecords(maxitem);
  sprintf(string2,TextSys_Word(0x251),Front_GetLapsForType());
  sprintf(string,"%s %s",TextSys_Word((short)Front_GetTrackRaced() + 0xd5),string2);
  FETextRender_FullTextRGB(string,0x104,(short)TextSys_WordY(0x255),ColTextBright,0,2);
  PSXDrawSquare(0,0x104 - (textpixels(string) >> 1),TextSys_WordY(0x255),textpixels(string),9);
  shape = &gCurrentShapes[0][0x26];
  /* MATCH (W57-A7, 28 -> 24): fold's constant reassociation is STATEMENT-granular --
     written flat, `((w>>1) - cx) - 2` folds to `subu; addiu -2`; retail has
     `addiu v0,v0,-2; subu s3,v0,a0`, i.e. the -2 is applied to the half-width FIRST.
     Only a separate statement stops fold from re-associating it back. */
  {
    short half = ((short)shape->width >> 1) - 2;

    lbx = half - shape->centerx;
  }
  tt = ticks[0] % (short)shape->width;
  if (((short)shape->width / 2) < tt) {
    tt = (short)shape->width - tt;
  }
  DrawShapeExtended(0x27,0,lbx + tt,TextSys_WordY(0x255) + 1,
                    (int)this->fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  DrawShapeExtended(0x27,0,lbx - tt,TextSys_WordY(0x255) + 1,
                    (int)this->fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  drawflags.tint[0] = 0x505050;
  DrawShapeExtended(0x26,0x410,-2,0,(int)this->fScreenFadeVal,0,&drawflags);
  for (j = 0; j < 3; j++) {
    int xx = TextSys_WordX(j + 0x24c);
    FETextRender_FullTextRGB(TextSys_Word(j + 0x252),(short)xx,(short)(boxy + 4),
                             ColTextSel,0,0);
    if (0 < maxitem) {
      PSXDrawSquare(Col,xx - 6,(short)boxy + 2,2,(0x80 - linefadeval) / 0x10);
    }
  }
  FETextRender_FullTextRGB(TextSys_Word(0x262),(short)TextSys_WordX(0x249),
                           (short)(midy + 3),ColTextSel,0,0);
  PSXDrawBrightEndLine(Col,boxx,(short)boxy + 3,boxw,-1,2,linefadeval,0x23);
  /* MATCH (W57-A7/W66, 24 -> 6 -> PASS): the SECOND instance of the statement-granular
     constant-reassociation -- inline, fold rewrites `(midy-0xc) - boxy` into
     `midy - (boxy+0xc)` (ours emitted `addiu s0,s0,12; subu v0,v0,s0`), and the
     resulting extra pseudo also flipped the two short temps' $s0/$s1 homes.
     Naming the `midy - 0xc` half in its own statement fixed both at once.  The
     final lever is the inlined TrackRecordLineY helper: its short formal creates
     the retail conversion boundary (`sll; sra; addiu -12`) without the live int
     local that rotates the saved-register band.  Falsified: direct cast expression
     (24), `int liney` (52), in-place subtraction, and a separate short local (6). */
  {
    PSXDrawBrightEndLine(Col,TextSys_WordX(0x24c) - 6,(short)boxy + 4,2,
                         TrackRecordLineY((short)midy) - (short)boxy,
                         1,linefadeval,0);
  }
  if (8 < maxitem) {
    PSXDrawSquare(Col,TextSys_WordX(0x24c) - 6,TextSys_WordY(0x260) - 1,2,8);
  }
  ::DrawBackgroundImage((tScreen *)this,0xb,0x1b,gCurrentShapes[0],0);
  return;
}

/* ---- tScreenTrackRecords::~tScreenTrackRecords  (screentrackrec.cpp:55) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);
extern "C" void ___19tScreenTrackRecords(void *thisp) { ___7tScreen(thisp); }

/* end of screentrackrec.cpp */

tScreenTrackRecords *screenTrackRecords;   /* @0x800520d0; SYM EXT */
