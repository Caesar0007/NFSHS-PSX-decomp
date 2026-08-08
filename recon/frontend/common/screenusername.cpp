/* frontend/screens/screenusername.cpp  --  RECONSTRUCTED  (username-entry screen; C++ TU)
 *   6 MEMBER functions of class tScreenUserName (: tScreen via _base_tScreen + manual vtable).
 *   Member-fn decls live in nfs4_types.h (non-virtual, ABI-neutral). Bodies: Ghidra decompiler.
 *   NOTE: Ghidra lost several draw-call args (boxY, dse-args, sprintf dest) -- decl-only, honest.
 */
#include "screenusername.h"

static const char *MOD = "ScreenUserName.obj globals: menu_kUserNameRows/MENUUSERNAME_STARTY/screenUserName/UserPermFileName (EXT, in .h)";

/* ---- tScreenUserName::Initialize  (screenusername.cpp:33) ---- */
void tScreenUserName::Initialize()

{
  /* MATCH: SLD records only the short loop index; the decompiler's rowLabel,
     n_rows, and fixed-point idx temporaries distort the retail induction chain. */
  short i;
  
  i = 0;
  this->fTextFade = 0x80;
  MENUUSERNAME_STARTY = 0x82 - (short)(menu_kUserNameRows * 0xf >> 1);
  if (0 < menu_kUserNameRows) {
    do {
      sprintf(this->fRowList[i],TextSys_Word(i + 0x1fb));
      i = i + 1;
    } while (i < menu_kUserNameRows);
  }
  this->Initialize();
  return;
}

/* ---- tScreenUserName::GetShapeInfo  (screenusername.cpp:54) ---- */
void tScreenUserName::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)

{
  
  *swapFileName = (char *)0x0;
  numSwapShapes = 0;
  numPermShapes = 0x5c;
  sprintf("","zUser%d",(uint)(byte)frontEnd.language);
  *permFileName = "";
  return;
}

/* ---- tScreenUserName::DrawVerticalLine  (screenusername.cpp:65) ---- */
void tScreenUserName::DrawVerticalLine(short x,short y,short gridpos)

{
  /* MATCH: SLD has no depth local.  Clamp the parameter itself and keep the
     retail exit-in-the-middle CFG; this removes the unsigned depth masks. */
  if (0 < gridpos) {
    if (0x3f < gridpos) goto DrawVerticalLine_high;
  }
  if (gridpos < 0) {
    gridpos = 0;
  }
  goto DrawVerticalLine_draw;
DrawVerticalLine_high:
  gridpos = 0x40;
DrawVerticalLine_draw:
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,2,0xa2,1,
                       ((int)gridpos << 0x10) >> 0xf,0);
  return;
}

/* ---- tScreenUserName::DrawHorizontalLine  (screenusername.cpp:73) ---- */
void tScreenUserName::DrawHorizontalLine(short x,short y,short gridpos)

{
  /* Same parameter-clamp source shape as DrawVerticalLine. */
  if (0 < gridpos) {
    if (0x3f < gridpos) goto DrawHorizontalLine_high;
  }
  if (gridpos < 0) {
    gridpos = 0;
  }
  goto DrawHorizontalLine_draw;
DrawHorizontalLine_high:
  gridpos = 0x40;
DrawHorizontalLine_draw:
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,0xc0,1,2,
                       ((int)gridpos << 0x10) >> 0xf,0xc);
  return;
}

/* ---- tScreenUserName::DrawBackground  (screenusername.cpp:80) ---- */
void tScreenUserName::DrawBackground()

{
  short i;
  short k;
  short x;
  short y;
  int gray;
  short fade;
  char output[2];
  short fadebox;
  short gridpos;
  short row;
  short col;
  short *colp;

  fade = *(volatile int *)&this->callingMenu->fScreenFade;
  if ((short)((fade >> 1) - 0x80) < 0x80) {
    if ((short)((fade >> 1) - 0x80) <= 0) goto DrawBgUser_fadeboxZero;
  }
  if ((short)((fade >> 1) - 0x80) < 0x81) goto DrawBgUser_fadeboxNormal;
  fadebox = 0x80;
  goto DrawBgUser_fadeboxDone;
DrawBgUser_fadeboxZero:
  fadebox = 0;
  goto DrawBgUser_fadeboxDone;
DrawBgUser_fadeboxNormal:
  fadebox = (fade >> 1) - 0x80;
DrawBgUser_fadeboxDone:
  if ((short)(fade >> 2) < 0x80) {
    if ((short)(fade >> 2) <= 0) goto DrawBgUser_gridposZero;
  }
  if ((short)(fade >> 2) < 0x81) goto DrawBgUser_gridposNormal;
  gridpos = 0x80;
  goto DrawBgUser_gridposDone;
DrawBgUser_gridposZero:
  gridpos = 0;
  goto DrawBgUser_gridposDone;
DrawBgUser_gridposNormal:
  gridpos = fade >> 2;
DrawBgUser_gridposDone:
  if (fade < 0x80) {
    if (fade <= 0) goto DrawBgUser_textFadeZero;
  }
  if (fade < 0x81) goto DrawBgUser_textFadeNormal;
  this->fTextFade = 0x80;
  goto DrawBgUser_textFadeDone;
DrawBgUser_textFadeZero:
  this->fTextFade = 0;
  goto DrawBgUser_textFadeDone;
DrawBgUser_textFadeNormal:
  this->fTextFade = fade;
DrawBgUser_textFadeDone:
  gray = 0x80808;
  SubtractiveBox(0xf0,0x2a,0xc2,0x55,gray,gray,0,0);
  SubtractiveBox(0xf0,0x7f,0xc2,0x55,0,0,gray,gray);
  y = MENUUSERNAME_STARTY;
  row = 0;
  colp = &col;
  strcpy(output," ");
  while (row < menu_kUserNameRows) {
    x = 0x102;
    *colp = 0;
    while (this->fRowList[0][*colp + row * 9] != '\0') {
      int colText;

      output[0] = this->fRowList[0][*colp + row * 9];
      colText = CalcFadeVal(0xb54200,this->fTextFade);
      switch(output[0]) {
      case '@':
        FETextRender_FullTextRGB(TextSys_Word(0x205),x + 0x24,y - 1,colText,1,2);
        k = 1;
        do {
          PSXDrawSquare(0,x + k * 0x1c - 6,y - 2,2,0xe);
          k++;
        } while (k < 3);
        break;
      case '#':
        i = 0x206;
        goto DrawBg4b1ac_emitText;
      case '$':
        FETextRender_FullTextRGB(TextSys_Word(0x206),x + 0x24,y - 1,colText,1,2);
        k = 1;
        do {
          PSXDrawSquare(0,x + k * 0x1c - 6,y - 2,2,0xe);
          k++;
        } while (k < 3);
        break;
      case '&':
        i = 0x207;
        goto DrawBg4b1ac_emitText;
      case '!':
        i = 0x205;
DrawBg4b1ac_emitText:
        FETextRender_FullTextRGB(TextSys_Word(i),x + 0x16,y - 1,colText,1,2);
        PSXDrawSquare(0,x + 0x16,y - 2,2,0xe);
        break;
      case '^':
        FETextRender_FullTextRGB(TextSys_Word(0x207),x + 0x4e,y - 1,colText,1,2);
        k = 1;
        do {
          PSXDrawSquare(0,x + k * 0x1c - 6,y - 2,2,0xe);
          k++;
        } while (k < 6);
        break;
      default:
        FETextRender_FullTextRGB(output,x + 8,y - 1,colText,1,2);
        break;
      case '-':
        break;
      }
      x = x + 0x1c;
      *colp = *colp + 1;
    }
    y = y + 0xf;
    row++;
  }
  gray = 0x505050;
  SubtractiveBox(0xf0,0x2a,0xc2,0x55,gray,gray,0,0);
  SubtractiveBox(0xf0,0x7f,0xc2,0x55,0,0,gray,gray);
  x = 0xfc;
  i = 0;
  do {
    DrawVerticalLine(x,0x2e,gridpos - i * 2);
    i++;
    x = x + 0x1c;
  } while (i < 7);
  k = 0;
  y = MENUUSERNAME_STARTY - 3;
  if (0 < menu_kUserNameRows + 1) {
    do {
      DrawHorizontalLine(0xf0,y,gridpos - (menu_kUserNameRows - k) * 2);
      k++;
      y = y + 0xf;
    } while (k < menu_kUserNameRows + 1);
  }
  i = 0;
  do {
    DrawShapeExtended(i,0,0,0,fadebox,0,(tDrawShapeExtended *)0x0);
    i++;
  } while (i < 0x20);
}

/* ---- tScreenUserName::dtor  (screenusername.cpp:97) ---- */
tScreenUserName::~tScreenUserName()

{
  return;
}

/* end of screenusername.cpp */
