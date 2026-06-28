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
  this->_base_tScreen.Initialize();
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
  this->_base_tScreen.Cleanup();
  return;
}

/* ---- tScreenTrackRecords::DrawOneRecord  (screentrackrec.cpp:113) ---- */
void tScreenTrackRecords::DrawOneRecord(int index,bool newrecord,int y)

{
  int sign;
  short y_00;
  int wx2;
  tMenuTextState rowState;
  char *word;
  int newrecordU;
  int wx;
  tMenuTextState textState;
  int shapeFlags;
  int shapeX;
  int shapeY;
  char sBuildOutput [80];
  
  newrecordU = newrecord;
  textState = (tMenuTextState)((uint)(newrecordU != 0) << 1);
  if (-1 < this->TrackRecords[index].nBestLap) {
    if (newrecordU != 0) {
      wx2 = TextSys_WordX(0x247);
      wx = this->flare_intensity << 1;
      sign = wx >> 0x1f;
      wx = wx / 3 + sign;
      Flare_2DHalo(wx2 + 3,y + 4,this->flare_intensity / 2,wx - sign,0x17);
      TextSys_WordX(0x247);
      DrawShapeExtended(wx,shapeFlags,shapeX,shapeY,0,0,
                 (tDrawShapeExtended *)0x0);
    }
    wx = TextSys_WordX(0x24b);
    y_00 = (short)y;
    if (newrecordU == 0) {
      rowState = textState_Selected;
    }
    else {
      rowState = textState_Hilighted;
    }
    FETextRender_FullText
              (this->TrackRecords[index].sName,(short)wx,y_00,textType_TrackRecords,rowState,0);
    word = TextSys_Word(this->TrackRecords[index].nCar + 0x153);
    wx = TextSys_WordX(0x24c);
    FETextRender_FullText
              (word,(short)wx,y_00,textType_TrackRecords,textState,0);
    wx = this->TrackRecords[index].nTime;
    if (wx == 0) {
      word = TextSys_Word(0x261);
      sprintf(sBuildOutput,word);
    }
    else {
      Stattool_ParseTime(wx,sBuildOutput);
    }
    wx = TextSys_WordX(0x24d);
    if (newrecordU == 0) {
      rowState = (tMenuTextState)(index != 0);
    }
    else {
      rowState = textState_Hilighted;
    }
    FETextRender_FullText
              (sBuildOutput,(short)wx,y_00,textType_TrackRecords,rowState,0);
    Stattool_ParseTime
              (this->TrackRecords[index].nBestLap,sBuildOutput);
    wx = TextSys_WordX(0x24e);
    if ((index == 0) && ((newrecordU != 0) == 0)) {
      textState = textState_Selected;
    }
    FETextRender_FullText
              (sBuildOutput,(short)wx,y_00,textType_TrackRecords,textState,0);
  }
  return;
}

/* ---- tScreenTrackRecords::DrawRecords  (screentrackrec.cpp:161) ---- */
void tScreenTrackRecords::DrawRecords(short maxitem)

{
  short nLapIndicator;
  int kk;
  uint flareSign;
  char *sMenuText;
  int idx;
  int wy;
  uint flareTmp;
  short k;
  tMenuTextState textState;
  
  kk = this->flareextra + 1;
  this->flareextra = kk;
  if (0x3c < kk) {
    this->flareextra = 0;
  }
  flareTmp = this->flareextra;
  flareSign = flareTmp >> 0x1f;
  if (0x1e < (int)flareTmp) {
    flareSign = 0x3c - flareTmp;
    flareTmp = flareSign >> 0x1f;
  }
  this->flare_intensity = (int)(flareTmp + flareSign) >> 1;
  this->flare_intensity = (this->flare_intensity + 0x14) * 0x80;
  kk = Front_GetLapsForType();
  nLapIndicator = 9;
  if (kk == 2) {
    nLapIndicator = 1;
  }
  k = 0;
  kk = 0;
  do {
    kk = kk >> 0x10;
    if (maxitem <= kk) break;
    sMenuText = TextSys_Word(kk + 599);
    idx = TextSys_WordX(0x249);
    wy = TextSys_WordY(kk + 599);
    if (NewRecords[kk] == 0) {
      textState = textState_Unselected;
    }
    else {
      textState = textState_Hilighted;
    }
    FETextRender_FullText(sMenuText,(short)idx,(short)wy,textType_TrackRecords,textState,0);
    idx = (int)(short)k;
    kk = TextSys_WordY(idx + 599);
    this->DrawOneRecord(idx + nLapIndicator,NewRecords[idx],kk);
    k = k + 1;
    kk = k * 0x10000;
  } while (k * 0x10000 >> 0x10 < 8);
  if (8 < maxitem) {
    kk = TextSys_WordY(0x260);
    this->DrawOneRecord(0,NewBestLap,kk);
  }
  return;
}

/* ---- tScreenTrackRecords::DrawBackground  (screentrackrec.cpp:210) ---- */
void tScreenTrackRecords::DrawBackground()

{
  short fade;
  int fadeCalc;
  int boxy;
  int boxx;
  int midy;
  int Col;
  int ColTextBright;
  char *word;
  int wy;
  int boxw;
  int maxitem;
  int clampTmp;
  int fadeAmt;
  short linefadeval;
  int shapeFlags;
  int shapeX;
  int shapeY;
  char string [50];
  char string2 [50];
  tDrawShapeExtended drawflags;
  
  fadeCalc = (this->_base_tScreen).fScreenFadeVal * 0x134;
  if (fadeCalc < 0) {
    fadeCalc = fadeCalc + 0x7f;
  }
  fadeCalc = fadeCalc >> 7;
  clampTmp = fadeCalc;
  if (fadeCalc < 0) {
    clampTmp = 0;
  }
  fade = (short)clampTmp;
  if (0xb4 < fadeCalc) {
    fade = 0xb4;
  }
  fadeCalc = (fadeCalc * 0x80) / 0xb4;
  clampTmp = fadeCalc;
  if (fadeCalc < 0) {
    clampTmp = 0;
  }
  linefadeval = (short)clampTmp;
  if (0x80 < fadeCalc) {
    linefadeval = 0x80;
  }
  fadeCalc = (0xb4 - fade) / 0x14;
  clampTmp = TextSys_WordX(0x248);
  boxy = TextSys_WordY(0x256);
  boxx = TextSys_WordX(0x24f);
  midy = TextSys_WordY(0x25f);
  Col = CalcFadeVal(kRGBVals[(byte)textDefinitions[0xb][4]],fadeAmt);
  ColTextBright = CalcFadeVal(kRGBVals[(byte)textDefinitions[0xb][5]],fadeAmt);
  maxitem = fadeCalc * 0x10000;
  this->DrawRecords((short)((uint)maxitem >> 0x10));
  word = TextSys_Word(0x251);
  wy = Front_GetLapsForType();
  sprintf(string2,word,wy);
  fade = Front_GetTrackRaced();
  word = TextSys_Word(fade + 0xd5);
  sprintf(string,"%s %s",word,string2);
  wy = TextSys_WordY(0x255);
  FETextRender_FullTextRGB
            (string,0x104,(short)wy,ColTextBright,'\0',2);
  ColTextBright = textpixels(string);
  wy = TextSys_WordY(0x255);
  boxw = textpixels(string);
  PSXDrawSquare(0,0x104 - (ColTextBright >> 1),wy,boxw,9);
  TextSys_WordY(0x255);
  DrawShapeExtended
            ((int)this,shapeFlags,shapeX,shapeY,
             (int)(this->_base_tScreen).fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  TextSys_WordY(0x255);
  DrawShapeExtended
            ((int)this,shapeFlags,shapeX,shapeY,
             (int)(this->_base_tScreen).fScreenFadeVal,1,(tDrawShapeExtended *)0x0);
  drawflags.tint[0] = 0x505050;
  DrawShapeExtended
            ((int)this,shapeFlags,shapeX,shapeY,
             (int)(this->_base_tScreen).fScreenFadeVal,0,&drawflags);
  for (fade = 0; ColTextBright = (int)fade, ColTextBright < 3; fade = fade + 1) {
    wy = TextSys_WordX(ColTextBright + 0x24c);
    word = TextSys_Word(ColTextBright + 0x252);
    FETextRender_FullTextRGB
              (word,(short)wy,(short)((uint)((boxy + 4) * 0x10000) >> 0x10),Col,'\0',0);
    if (0 < maxitem >> 0x10) {
      ColTextBright = -(int)linefadeval + 0x80;
      if (ColTextBright < 0) {
        ColTextBright = -(int)linefadeval + 0x8f;
      }
      PSXDrawSquare
                (0x232323,wy + -6,(short)boxy + 2,2,ColTextBright >> 4);
    }
  }
  word = TextSys_Word(0x262);
  ColTextBright = TextSys_WordX(0x249);
  FETextRender_FullTextRGB
            (word,(short)ColTextBright,(short)midy + 3,Col,'\0',0);
  boxy = (int)(short)boxy;
  PSXDrawBrightEndLine
            (0x232323,(int)(short)clampTmp,boxy + 3,(int)(short)((short)boxx - (short)clampTmp),-1,2,
             (int)linefadeval,0x23);
  clampTmp = TextSys_WordX(0x24c);
  PSXDrawBrightEndLine
            (0x232323,clampTmp + -6,boxy + 4,2,((short)midy + -0xc) - boxy,1,(int)linefadeval,0);
  if (8 < (short)fadeCalc) {
    fadeCalc = TextSys_WordX(0x24c);
    clampTmp = TextSys_WordY(0x260);
    PSXDrawSquare(0x232323,fadeCalc + -6,clampTmp + -1,2,8);
  }
  DrawBackgroundImage(&this->_base_tScreen,0xb,0x1b,gCurrentShapes,0);
  return;
}

/* ---- tScreenTrackRecords::~tScreenTrackRecords  (screentrackrec.cpp:55) ---- */
tScreenTrackRecords::~tScreenTrackRecords()

{
  return;
}

/* end of screentrackrec.cpp */