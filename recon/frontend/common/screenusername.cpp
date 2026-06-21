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
  char *rowLabel;
  int n_rows;
  int idx;
  int i;
  
  i = 0;
  n_rows = (int)menu_kUserNameRows;
  this->fTextFade = 0x80;
  MENUUSERNAME_STARTY = 0x82 - (short)(n_rows * 0xf >> 1);
  if (0 < n_rows) {
    idx = 0;
    do {
      rowLabel = TextSys_Word((idx >> 0x10) + 0x1fb);
      sprintf(this->fRowList[0] + (idx >> 0x10) * 9,rowLabel);
      i = i + 1;
      idx = i * 0x10000;
    } while (i * 0x10000 >> 0x10 < (int)menu_kUserNameRows);
  }
  this->_base_tScreen.Initialize();
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
  uint depth;
  
  depth = (uint)(ushort)gridpos;
  if ((gridpos < 1) || (gridpos < 0x40)) {
    if (gridpos < 0) {
      depth = 0;
    }
  }
  else {
    depth = 0x40;
  }
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,2,0xa2,1,(int)(depth << 0x10) >> 0xf,0);
  return;
}

/* ---- tScreenUserName::DrawHorizontalLine  (screenusername.cpp:73) ---- */
void tScreenUserName::DrawHorizontalLine(short x,short y,short gridpos)

{
  uint depth;
  
  depth = (uint)(ushort)gridpos;
  if ((gridpos < 1) || (gridpos < 0x40)) {
    if (gridpos < 0) {
      depth = 0;
    }
  }
  else {
    depth = 0x40;
  }
  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,0xc0,1,2,(int)(depth << 0x10) >> 0xf,0xc);
  return;
}

/* ---- tScreenUserName::DrawBackground  (screenusername.cpp:80) ---- */
void tScreenUserName::DrawBackground()

{
  char ch;
  short x;
  int colText;
  char *word;
  int fade;
  uint startY;
  short y;
  int yShift;
  uint lineFade;
  int rowY;
  int boxY;
  int yAcc;
  int dseY;
  int dseFade;
  int dseAbr;
  char output [2];
  short row;
  short col;
  int t;
  
  t = this->callingMenu->fScreenFade;
  x = (short)t;
  fade = ((t << 0x10) >> 0x11) + -0x80;
  if ((fade < 0x80) && (fade < 1)) {
    fade = 0;
  }
  else if (0x80 < fade) {
    fade = 0x80;
  }
  startY = (t << 0x10) >> 0x12;
  if (((0x7f < (int)startY) || (lineFade = 0, 0 < (int)startY)) && (lineFade = startY, 0x80 < (int)startY)) {
    lineFade = 0x80;
  }
  if ((x < 0x80) && (x < 1)) {
    this->fTextFade = 0;
  }
  else {
    if (0x80 < x) {
      x = 0x80;
    }
    this->fTextFade = x;
  }
  SubtractiveBox(0xf0,boxY,0xc2,0x55,0x80808,0x80808,0,0);
  SubtractiveBox
            (0xf0,boxY,0xc2,0x55,0,0,0x80808,0x80808);
  startY = (uint)(ushort)MENUUSERNAME_STARTY;
  row = 0;
  rowY = 0;            /* @0x800125e9 = 0x00 (rodata byte after "zUser%d") */
  output[0] = ' ';     /* @0x800125e8 = 0x20 */
  output[1] = '\0';    /* @0x800125e9 = 0x00 */
  do {
    if (menu_kUserNameRows <= row) {
      SubtractiveBox
                (0xf0,boxY,0xc2,0x55,0x505050,0x505050,0,0);
      SubtractiveBox
                (0xf0,boxY,0xc2,0x55,0,0,0x505050,0x505050);
      x = 0xfc;
      t = 0;
      do {
        DrawVerticalLine(x,0x2e,
                         (short)(((lineFade & 0xffff) - ((t << 0x10) >> 0xf)) * 0x10000 >> 0x10));
        t = t + 1;
        x = x + 0x1c;
      } while (t * 0x10000 >> 0x10 < 7);
      t = 0;
      x = MENUUSERNAME_STARTY + -3;
      if (0 < menu_kUserNameRows + 1) {
        do {
          DrawHorizontalLine(0xf0,x,(short)lineFade + (menu_kUserNameRows - (short)t) * -2
                            );
          t = t + 1;
          x = x + 0xf;
        } while (t * 0x10000 >> 0x10 < menu_kUserNameRows + 1);
      }
      t = 0;
      do {
        DrawShapeExtended
                  (rowY,dseY,dseFade,dseAbr,(int)(short)fade,0,
                   (tDrawShapeExtended *)0x0);
        t = t + 1;
      } while (t * 0x10000 >> 0x10 < 0x20);
      return;
    }
    x = 0x102;
    col = 0;
    yAcc = (startY - 1) * 0x10000;
    rowY = (int)(short)startY;
    while (ch = this->fRowList[0][(int)col + row * 9], ch != '\0') {
      output[0] = ch;
      colText = CalcFadeVal(0xb54200,t);
      yShift = yAcc >> 0x10;
      y = (short)((uint)yAcc >> 0x10);
      switch(output[0]) {
      case '!':
        t = 0x205;
        goto DrawBg4b1ac_emitText;
      default:
        FETextRender_FullTextRGB
                  (output,x + 8,y,colText,'\x01',2);
        t = yShift;
        break;
      case '#':
        t = 0x206;
        goto DrawBg4b1ac_emitText;
      case '$':
        word = TextSys_Word(0x206);
        FETextRender_FullTextRGB
                  (word,x + 0x24,y,colText,'\x01',2);
        colText = 1;
        do {
          t = rowY + -2;
          PSXDrawSquare
                    (0,(int)x + (short)colText * 0x1c + -6,t,2,0xe);
          colText = colText + 1;
        } while (colText * 0x10000 >> 0x10 < 3);
        break;
      case '&':
        t = 0x207;
DrawBg4b1ac_emitText:
        word = TextSys_Word(t);
        FETextRender_FullTextRGB
                  (word,x + 0x16,y,colText,'\x01',2);
        t = rowY + -2;
        PSXDrawSquare(0,x + 0x16,t,2,0xe);
        break;
      case '-':
        break;
      case '@':
        word = TextSys_Word(0x205);
        FETextRender_FullTextRGB
                  (word,x + 0x24,y,colText,'\x01',2);
        colText = 1;
        do {
          t = rowY + -2;
          PSXDrawSquare
                    (0,(int)x + (short)colText * 0x1c + -6,t,2,0xe);
          colText = colText + 1;
        } while (colText * 0x10000 >> 0x10 < 3);
        break;
      case '^':
        word = TextSys_Word(0x207);
        FETextRender_FullTextRGB
                  (word,x + 0x4e,y,colText,'\x01',2);
        colText = 1;
        do {
          t = rowY + -2;
          PSXDrawSquare
                    (0,(int)x + (short)colText * 0x1c + -6,t,2,0xe);
          colText = colText + 1;
        } while (colText * 0x10000 >> 0x10 < 6);
      }
      x = x + 0x1c;
      col = col + 1;
    }
    startY = startY + 0xf;
    rowY = (ushort)row + 1;
    row = (short)rowY;
  } while( true );
}

/* ---- tScreenUserName::dtor  (screenusername.cpp:97) ---- */
tScreenUserName::~tScreenUserName()

{
  return;
}

/* end of screenusername.cpp */