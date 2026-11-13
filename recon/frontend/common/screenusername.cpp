/* frontend/screens/screenusername.cpp  --  RECONSTRUCTED  (username-entry screen; C++ TU)
 *   6 MEMBER functions of class tScreenUserName (: public tScreen, real virtuals).
 *   Member-fn decls live in nfs4_types.h (non-virtual, ABI-neutral). Bodies: Ghidra decompiler.
 *   P866: GetShapeInfo filename references checked against SYM and the raw oracle. */
#define NFS4_KEY_OBJECT_SCREENUSERNAME   /* this object defines the class's virtuals: in-class inline setters are left out here (cc1plus would emit standalone copies) */
#include "screenusername.h"

/* 2026-11-02: the real char-array string initializer at its copy phase
 * supplies the two-byte alignment-one move without an invented aggregate.
 * Its earlier declaration-site control does not match. No artificial type
 * or alignment attribute is retained. Original literal spelling is unproved.
 * Receipt: build/tmp/v/username_init_private_20261102/receipt.json. */


/* ---- tScreenUserName::Initialize  (screenusername.cpp:33) ---- */
  /* MATCH: SLD records only the short loop index; the decompiler's rowLabel,
     n_rows, and fixed-point idx temporaries distort the retail induction chain. */
#line 30 "C:/nfs4/FRONTEND/COMMON/SCREENUSERNAME.CPP"
void tScreenUserName::Initialize()


{
  short i;
  this->fTextFade = 0x80;





  MENUUSERNAME_STARTY = 0x82 - (short)(menu_kUserNameRows * 0xf >> 1);


  i = 0; if (0 < menu_kUserNameRows) { do {

      sprintf(this->fRowList[i],TextSys_Word(i + 0x1fb));
      i = i + 1; } while (i < menu_kUserNameRows);
  }
  this->tScreen::Initialize(); return;
}

/* ---- tScreenUserName::GetShapeInfo  (screenusername.cpp:54) ---- */
  /* P866: both pointers are SYM UserPermFileName at 800529b8, not an empty
     literal.  The normalized gate cannot distinguish those relocation targets. */
#line 50 "C:/nfs4/FRONTEND/COMMON/SCREENUSERNAME.CPP"
void tScreenUserName::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)


{
  

  *swapFileName = (char *)0x0; numSwapShapes = 0;
  numPermShapes = 0x5c;
  sprintf(UserPermFileName,"zUser%d",(uint)(byte)frontEnd.language);
  *permFileName = UserPermFileName; return;
}

/* ---- tScreenUserName::DrawVerticalLine  (screenusername.cpp:65) ---- */
  /* W86-S4 SYM: the `8c` block lists ONLY the four REGPARMs -- no locals at
     all -- so the former `int depth` carrier was a hard fiction.  Folded back
     into the three tests; the sll/sra SPELLING is what is load-bearing (retail
     sign-extends the short param once, `sll $v0,$a3,16 / sra $v1,$v0,16`, and
     TESTS that value while the clamp stores back into $a3).  A plain
     `(int)gridpos` spelling costs 17 diffs; the folded sll/sra form is
     PASS 32/32, identical to the carrier form. */
#line 62 "C:/nfs4/FRONTEND/COMMON/SCREENUSERNAME.CPP"
void tScreenUserName::DrawVerticalLine(short x,short y,short gridpos)


{
  if (!(0 < (((int)(uint)(ushort)gridpos << 16) >> 16)) || !(0x3f < ((int)(((uint)(ushort)gridpos << 16)) >> 16))) { if ((((int)(uint)(ushort)gridpos << 16) >> 16) < 0) { gridpos = 0; } } else { gridpos = 0x40; }

  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,2,0xa2,1,
                       ((int)gridpos << 0x10) >> 0xf,0); return;
}

/* ---- tScreenUserName::DrawHorizontalLine  (screenusername.cpp:73) ---- */
  /* W86-S4 SYM: same as DrawVerticalLine -- the `8c` block lists only the four
     REGPARMs, so the former `int depth` carrier was folded away.  PASS 33/33. */
#line 70 "C:/nfs4/FRONTEND/COMMON/SCREENUSERNAME.CPP"
void tScreenUserName::DrawHorizontalLine(short x,short y,short gridpos)


{
  if (!(0 < (((int)(uint)(ushort)gridpos << 16) >> 16)) || !(0x3f < ((int)(((uint)(ushort)gridpos << 16)) >> 16))) { if ((((int)(uint)(ushort)gridpos << 16) >> 16) < 0) { gridpos = 0; } } else { gridpos = 0x40; }

  PSXDrawBrightEndLine(0x785a5a,(int)x,(int)y,0xc0,1,2, ((int)gridpos << 0x10) >> 0xf,0xc); return;
}

/* ---- tScreenUserName::DrawBackground  (screenusername.cpp:80) ---- */
#line 77 "C:/nfs4/FRONTEND/COMMON/SCREENUSERNAME.CPP"
void tScreenUserName::DrawBackground()


{
  short i;
  short k;
  short x;
  short y;
  int gray;
  short fade;
  short fadebox;
  short gridpos; short row; short col; fade = this->callingMenu->GetScreenFade();
  fadebox = (fade >> 1) - 0x80;
  fadebox = (((fadebox < 0x80) ? fadebox : 0x80) > 0) ? ((fadebox < 0x80) ? fadebox : 0x80) : 0;


  gridpos = fade >> 2; gridpos = (((gridpos < 0x80) ? gridpos : 0x80) > 0) ? ((gridpos < 0x80) ? gridpos : 0x80) : 0;

  this->fTextFade = (((fade < 0x80) ? fade : 0x80) > 0) ? ((fade < 0x80) ? fade : 0x80) : 0;




  gray = 0x80808;






  SubtractiveBox(0xf0,0x2a,0xc2,0x55,gray,gray,0,0);
  SubtractiveBox(0xf0,0x7f,0xc2,0x55,0,0,gray,gray);



  if (this->fTextFade) y = 0;






  char output[2] = " ";


  y = MENUUSERNAME_STARTY;
  for (row = 0; row < menu_kUserNameRows; row++) {


    x = 0x102;

    for (col = 0; this->fRowList[0][col + row * 9] != '\0'; col++) {
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
          PSXDrawSquare(0,x + k * 0x1c - 6,y - 2,2,0xe); }
        break;
      case '#':
        FETextRender_FullTextRGB(TextSys_Word(0x206),x + 0x16,y - 1,colText,1,2);
        PSXDrawSquare(0,x + 0x16,y - 2,2,0xe);

        break;
      case '$':

        FETextRender_FullTextRGB(TextSys_Word(0x206),x + 0x24,y - 1,colText,1,2);
        for (k = 1; k < 3; k++) {
          PSXDrawSquare(0,x + k * 0x1c - 6,y - 2,2,0xe); }
        break;
      case '&':

        FETextRender_FullTextRGB(TextSys_Word(0x207),x + 0x16,y - 1,colText,1,2);
        PSXDrawSquare(0,x + 0x16,y - 2,2,0xe);
        break;
      case '^':


        FETextRender_FullTextRGB(TextSys_Word(0x207),x + 0x4e,y - 1,colText,1,2);
        for (k = 1; k < 6; k++) {
          PSXDrawSquare(0,x + k * 0x1c - 6,y - 2,2,0xe); }
        break;
      default:

        FETextRender_FullTextRGB(output,x + 8,y - 1,colText,1,2);
        break;
      case '-':
        break; } x = x + 0x1c;
    }



    y = y + 0xf;
  }



  gray = 0x505050;










  SubtractiveBox(0xf0,0x2a,0xc2,0x55,gray,gray,0,0);
  SubtractiveBox(0xf0,0x7f,0xc2,0x55,0,0,gray,gray);











  x = 0xfc;
  i = 0;
  do {
    DrawVerticalLine(x,0x2e,gridpos - i * 2);

    i++; x = x + 0x1c; } while (i < 7);

  y = MENUUSERNAME_STARTY - 3;
  k = 0; if (0 < menu_kUserNameRows + 1) { do {

      DrawHorizontalLine(0xf0,y,gridpos - (menu_kUserNameRows - k) * 2);
      y = y + 0xf;
      k++; } while (k < menu_kUserNameRows + 1);
  }



  i = 0; do {

    DrawShapeExtended(i,0,0,0,fadebox,0,(tDrawShapeExtended *)0x0);
    i++; } while (i < 0x20);
}

/* ---- tScreenUserName::dtor  (screenusername.cpp:97) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */


extern "C" void ___7tScreen(void *);

/* end of screenusername.cpp */
