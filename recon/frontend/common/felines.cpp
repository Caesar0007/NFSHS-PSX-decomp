/* frontend/common/felines.cpp  --  RECONSTRUCTED  (FE bright-end gradient lines; C++ TU)
 *   Bodies: Ghidra decompiler. Line numbers: PsyQ SLD (8c decl, 8e end).
 *   2 EXT functions; C++ linkage (cfront-mangled). PSXDrawBrightEndLine wraps the Trans one.
 *   NOTE: Ghidra lost the x/y reads at the final PSXDrawTransSquare (named tx/ty, decl-only).
 */
#include "felines.h"

/* lines 1-23: file header, #includes, static data, macros (no symbols emitted) */

/* ---- PSXDrawBrightEndLine  (felines.cpp:24, code lines 24-25) ---- */
void PSXDrawBrightEndLine(int col,int x,int y,int w,int h,int side,int fade,int darksides)

{
  PSXTransDrawBrightEndLine(col,x,y,w,h,side,fade,darksides,0);
  return;
}

/* lines 26-29: (static data / macros / comments - no emitted code) */

/* ---- PSXTransDrawBrightEndLine  (felines.cpp:30, code lines 30-116) ---- */
/* W65 (2026-08-10): 163 diffs -> PASS (161/161).  SYM identifies only ww,
   hh, BrightCol, and endbit as retail locals.  Direct branch-local Gouraud
   calls preserve the four color orders, while keeping ww/hh separate from
   w/h restores the saved-register allocation and final-dimension lifetime. */
void PSXTransDrawBrightEndLine(int col,int x,int y,int w,int h,int side,int fade,int darksides,int opacity)

{
  int BrightCol;
  int endbit;
  int hh;
  int ww;
  
  if (fade == 0x80) {
    return;
  }
  BrightCol = CalcFadeVal(col,0xffffff,0x40);
  if (fade != 0) {
    if ((unsigned int)side < 2) {
      hh = h * (0x80 - fade) / 0x80;
      endbit = hh >> 3;
      ww = w;
      if (8 < endbit) {
        endbit = 8;
      }
      if (side == 1) {
        PSXDrawGouraudSquare(x,(y + hh) - endbit,ww,endbit,
                             col,col,BrightCol,BrightCol);
      }
      else {
        y = (y + h) - hh;
        PSXDrawGouraudSquare(x,y,ww,endbit,
                             BrightCol,BrightCol,col,col);
      }
    }
    else {
      ww = w * (0x80 - fade) / 0x80;
      endbit = ww >> 3;
      hh = h;
      if (8 < endbit) {
        endbit = 8;
      }
      if (side == 2) {
        x = (x + w) - ww;
        PSXDrawGouraudSquare(x,y,endbit,hh,
                             BrightCol,col,BrightCol,col);
      }
      else {
        PSXDrawGouraudSquare((x + ww) - endbit,y,endbit,hh,
                             col,BrightCol,col,BrightCol);
      }
    }
  }
  else {
    ww = w;
    hh = h;
  }
  if (darksides != 0) {
    if ((side == 2) || (fade == 0)) {
      PSXDrawGouraudSquare((x + ww) - darksides,y,darksides,hh,col,0,col,0);
    }
    if ((side == 3) || (fade == 0)) {
      PSXDrawGouraudSquare(x,y,darksides,hh,0,col,0,col);
    }
  }
  if (opacity == 0) {
    PSXDrawSquare(col,x,y,ww,hh);
  }
  else {
    PSXDrawTransSquare(col,x,y,ww,hh,1);   /* H12: was tx,ty (uninitialized; Ghidra lost the x/y reads) -- oracle 0x8004BDB0 $a1=$s2=x, $a2=$s4=y */
  }
  return;
}

/* end of felines.cpp */
