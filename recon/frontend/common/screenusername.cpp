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
  this->tScreen::Initialize();
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
  /* MATCH: retail sign-extends the short param ONCE into a separate int
     (oracle sll $v0,$a3,16 / sra $v1,$v0,16) and TESTS that int, while the
     clamp STORES back into the short param register $a3.  One variable for
     both roles makes gcc clamp+test in the same reg + an extra copy. */
  int depth;

  /* MATCH (W54-A7): retail keeps the SHORT param in its home $a3 for the whole
     clamp and sign-extends ONCE into a separate int ($v0->$v1) for the three
     tests.  gcc-2.8 instead spills the param to $v1 (the parm copy survives -
     global-allocno tie refusal) and lets the sign_extend eat $a3.  The identity
     fence right after the parm copy re-pins gridpos to $a3: 17 diffs -> 2,
     count-exact 32/32.  DO NOT "simplify" it away.
     KNOWN RESIDUAL: reorg's stop_search_p() stops the backward delay-slot scan
     at ANY asm, so the prologue `sw $ra` can no longer be stolen into the blez
     slot (retail has it there).  A non-asm allocno-promotion device would
     finish this fn; see the W54-A7 report. */
  __asm__("" : "=r"(gridpos) : "0"(gridpos));
  depth = gridpos;
  if (0 < depth) {
    if (0x3f < depth) goto DrawVerticalLine_high;
  }
  if (depth < 0) {
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
  /* Same parameter-clamp source shape as DrawVerticalLine (same fence receipt). */
  int depth;

  __asm__("" : "=r"(gridpos) : "0"(gridpos));
  depth = gridpos;
  if (0 < depth) {
    if (0x3f < depth) goto DrawHorizontalLine_high;
  }
  if (depth < 0) {
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

/* MATCH W61-A17 (93 -> 89 diffs, 391/394 insns): COMPLETE-THE-FUNNEL on all
   three fade clamps.  Retail funnels each clamp's arms through ONE register
   and stores ONCE (`sh a0,40(sp)`, `sh a3,48(sp)`, `sh a0,104(t0)`); ours
   stored the destination inside every arm -- the frame census showed sp+40
   touched 4 times vs retail's 2 and sp+48 5 vs 3.  A per-clamp funnel local
   (fadeboxv / gridposv / textfadev) assigned in the arms with a single store
   at the join reproduces retail's single-store shape.  Priced: clamp1 alone
   94, clamp1+2 89, all three 89, clamp3 alone 93.
   FALSIFIED: VALUE-FIRST staging (funnel local initialised to the normal
   value, arms overwrite it, `if (v < 0x81) goto Done` keeping it) -- the shape
   suggested by retail's `nop`-filled normal-arm delay slot -- 136 / 131 / 130.
   RESIDUAL (named angles): (a) retail's `strcpy(output, " ")` expands
   BYTE-wise (`addiu t2,v0,0; lb; lb; sb 32(sp); sb 33(sp)` -- the oracle's
   only sp+33 access) while ours emits a halfword `lhu/sh` pair: retail's
   source string has alignment 1, our string constant is 2-aligned;
   (b) the funnel register is v0 for us and a0/a3 for retail, and retail's
   normal arm needs no copy in clamp 1 because the funnel reg already holds
   the computed value (dead-pseudo staging, 12D).  */
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
  short fadeboxv;
  short gridposv;
  short textfadev;

  fade = *(volatile int *)&this->callingMenu->fScreenFade;
  if ((short)((fade >> 1) - 0x80) < 0x80) {
    if ((short)((fade >> 1) - 0x80) <= 0) goto DrawBgUser_fadeboxZero;
  }
  if ((short)((fade >> 1) - 0x80) < 0x81) goto DrawBgUser_fadeboxNormal;
  fadeboxv = 0x80;
  goto DrawBgUser_fadeboxDone;
DrawBgUser_fadeboxZero:
  fadeboxv = 0;
  goto DrawBgUser_fadeboxDone;
DrawBgUser_fadeboxNormal:
  fadeboxv = (fade >> 1) - 0x80;
DrawBgUser_fadeboxDone:
  fadebox = fadeboxv;
  if ((short)(fade >> 2) < 0x80) {
    if ((short)(fade >> 2) <= 0) goto DrawBgUser_gridposZero;
  }
  if ((short)(fade >> 2) < 0x81) goto DrawBgUser_gridposNormal;
  gridposv = 0x80;
  goto DrawBgUser_gridposDone;
DrawBgUser_gridposZero:
  gridposv = 0;
  goto DrawBgUser_gridposDone;
DrawBgUser_gridposNormal:
  gridposv = fade >> 2;
DrawBgUser_gridposDone:
  gridpos = gridposv;
  if (fade < 0x80) {
    if (fade <= 0) goto DrawBgUser_textFadeZero;
  }
  if (fade < 0x81) goto DrawBgUser_textFadeNormal;
  textfadev = 0x80;
  goto DrawBgUser_textFadeDone;
DrawBgUser_textFadeZero:
  textfadev = 0;
  goto DrawBgUser_textFadeDone;
DrawBgUser_textFadeNormal:
  textfadev = fade;
DrawBgUser_textFadeDone:
  this->fTextFade = textfadev;
  gray = 0x80808;
  SubtractiveBox(0xf0,0x2a,0xc2,0x55,gray,gray,0,0);
  SubtractiveBox(0xf0,0x7f,0xc2,0x55,0,0,gray,gray);
  y = MENUUSERNAME_STARTY;
  row = 0;
  strcpy(output," ");
  while (row < menu_kUserNameRows) {
    x = 0x102;
    col = 0;
    while (this->fRowList[0][col + row * 9] != '\0') {
      int colText;

      output[0] = this->fRowList[0][col + row * 9];
      colText = CalcFadeVal(0xb54200,this->fTextFade);
      switch(output[0]) {
      case '!':
        FETextRender_FullTextRGB(TextSys_Word(0x205),x + 0x16,y - 1,colText,1,2);
        PSXDrawSquare(0,x + 0x16,y - 2,2,0xe);
        break;
      case '@':
        FETextRender_FullTextRGB(TextSys_Word(0x205),x + 0x24,y - 1,colText,1,2);
        for (k = 1; k < 3; k++) {
          PSXDrawSquare(0,x + k * 0x1c - 6,y - 2,2,0xe);
        }
        break;
      case '#':
        FETextRender_FullTextRGB(TextSys_Word(0x206),x + 0x16,y - 1,colText,1,2);
        PSXDrawSquare(0,x + 0x16,y - 2,2,0xe);
        break;
      case '$':
        FETextRender_FullTextRGB(TextSys_Word(0x206),x + 0x24,y - 1,colText,1,2);
        for (k = 1; k < 3; k++) {
          PSXDrawSquare(0,x + k * 0x1c - 6,y - 2,2,0xe);
        }
        break;
      case '&':
        FETextRender_FullTextRGB(TextSys_Word(0x207),x + 0x16,y - 1,colText,1,2);
        PSXDrawSquare(0,x + 0x16,y - 2,2,0xe);
        break;
      case '^':
        FETextRender_FullTextRGB(TextSys_Word(0x207),x + 0x4e,y - 1,colText,1,2);
        for (k = 1; k < 6; k++) {
          PSXDrawSquare(0,x + k * 0x1c - 6,y - 2,2,0xe);
        }
        break;
      default:
        FETextRender_FullTextRGB(output,x + 8,y - 1,colText,1,2);
        break;
      case '-':
        break;
      }
      x = x + 0x1c;
      col++;
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
