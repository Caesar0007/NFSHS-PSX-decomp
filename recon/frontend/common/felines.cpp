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
void PSXTransDrawBrightEndLine(int col,int x,int y,int w,int h,int side,int fade,int darksides,int opacity)

{
  int BrightCol;
  int scaled;
  int capW;
  int ga;
  int gb;
  int endbit;
  int hh;
  int ww;
  int gc;
  int gd;
  
  if (fade == 0x80) {
    return;
  }
  BrightCol = CalcFadeVal(col,0xffffff,0x40);
  if (fade == 0) goto TransBrightEnd_darksidesProcess;
  if ((uint)side < 2) {
    scaled = h * (0x80 - fade);
    if (scaled < 0) {
      scaled = scaled + 0x7f;
    }
    hh = scaled >> 7;
    endbit = scaled >> 10;
    if (8 < endbit) {
      endbit = 8;
    }
    capW = w;
    ww = w;
    if (side != 1) {
      y = (y + h) - hh;
      h = endbit;
      ga = BrightCol;
      gb = col;
TransBrightEnd_gouraudEmit:
      PSXDrawGouraudSquare(x,y,capW,h,BrightCol,ga,gb,col);
      h = hh;
      w = ww;
      goto TransBrightEnd_darksidesProcess;
    }
    ga = x;
    gb = (y + hh) - endbit;
    h = endbit;
    gc = col;
    gd = BrightCol;
  }
  else {
    scaled = w * (0x80 - fade);
    if (scaled < 0) {
      scaled = scaled + 0x7f;
    }
    ww = scaled >> 7;
    capW = scaled >> 10;
    if (8 < capW) {
      capW = 8;
    }
    hh = h;
    if (side == 2) {
      x = (x + w) - ww;
      ga = col;
      gb = BrightCol;
      goto TransBrightEnd_gouraudEmit;
    }
    ga = (x + ww) - capW;
    gb = y;
    gc = BrightCol;
    gd = col;
  }
  PSXDrawGouraudSquare(ga,gb,capW,h,col,gc,gd,BrightCol);
  h = hh;
  w = ww;
TransBrightEnd_darksidesProcess:
  if (darksides != 0) {
    if ((side == 2) || (fade == 0)) {
      PSXDrawGouraudSquare((x + w) - darksides,y,darksides,h,col,0,col,0);
    }
    if ((side == 3) || (fade == 0)) {
      PSXDrawGouraudSquare(x,y,darksides,h,0,col,0,col);
    }
  }
  if (opacity == 0) {
    PSXDrawSquare(col,x,y,w,h);
  }
  else {
    PSXDrawTransSquare(col,x,y,w,h,1);   /* H12: was tx,ty (uninitialized; Ghidra lost the x/y reads) -- oracle 0x8004BDB0 $a1=$s2=x, $a2=$s4=y */
  }
  return;
}

/* end of felines.cpp */