/* frontend/common/fetools.cpp -- RECONSTRUCTED (front-end utility helpers; C++ TU)
 *   6 free fns: s_upper/s_lower (in-place case convert), FeTools_DrawPSXButton (pad-glyph
 *   draw), FeTools_init/deinit (font load/purge), FeTools_FormatMoney (money string format).
 *   Free fns in ns nfs4::FRONTEND::COMMON::Fetools.
 */
#include "fetools.h"

/* ---- Fetools.obj-OWNED globals -- DEFINED here (self-contained; .bss zero / real bytes).
   font12/font18/fontTitle = FE font pointers (set in FeTools_init); currentSize[0] = current font
   size (SYM short -- fetextrender uses it). FeTools_gScrollTicksOut=30 defined below. ---- */
/* MATCH: font ptrs live in regular .data (defined in asm/data/front_data.data.s), reached
 * absolutely (%hi/%lo) in every oracle, and a global VALUE loaded into an ARG reg uses a SEPARATE
 * $v0 scratch (`lui v0; lw a0,(v0)`), not self-temp (`lui a0; lw a0,(a0)`). The unsized ARRAY shape
 * `[]` + `[0]` access (§3.15) forces gcc to materialize the base in a separate reg before the load
 * (a scalar folds the addr into the dest). Declared extern here (front_data.data.s owns the defn);
 * currentSize[0] stays a scalar but pinned to .data (it's stored, addressed absolutely). */
extern char *font12[];
extern char *font18[];
extern char *fontTitle[];             /* @0x800517d4..dc  FE font pointers (.data) */
short currentSize[1] __attribute__((section(".data")));   /* @0x800517e0  current FE font size */


/* ---- s_upper  [FETOOLS.CPP:90-95] SLD-VERIFIED ---- */

void s_upper(char *string)

{
  int len;
  int n;
  u_char *pbVar2;

  len = strlen(string);
  n = 0;
  if (0 < (int)len) {
    do {
      /* MATCH: index form string[n] rematerializes (s0 + a0) each iteration (incl. n==0 ->
       * `addu a1,s0,a0`, not the hoisted `addu a1,s0,zero`). (u_int) cast forces sltiu. */
      pbVar2 = (u_char *)(string + n);
      if ((u_int)(*pbVar2 - 0x61) < 0x1a) {
        /* MATCH: oracle emits `addiu v0,v1,0xE0` (=-0x20 mod 256, stored to u_char). Writing
         * the constant as +0xE0 reproduces it; -0x20 would emit `addiu v0,v1,-32`. */
        *pbVar2 = *pbVar2 + 0xe0;
      }
      n = n + 1;
    } while (n < (int)len);
  }
  return;
}



/* ---- s_lower  [FETOOLS.CPP:98-103] SLD-VERIFIED ---- */

void s_lower(char *string)

{
  int len;
  int n;
  u_char *pbVar2;

  len = strlen(string);
  n = 0;
  if (0 < (int)len) {
    do {
      /* MATCH: index form string[n] rematerializes (s0 + a0) each iteration (incl. n==0 ->
       * `addu a1,s0,a0`, not the hoisted `addu a1,s0,zero`). (u_int) cast forces sltiu. */
      pbVar2 = (u_char *)(string + n);
      if ((u_int)(*pbVar2 - 0x41) < 0x1a) {
        *pbVar2 = *pbVar2 + 0x20;
      }
      n = n + 1;
    } while (n < (int)len);
  }
  return;
}



/* ---- FeTools_DrawPSXButton  [FETOOLS.CPP:182-278] SLD-VERIFIED ---- */
void FeTools_DrawPSXButton(u_char padType, u_short button, int x, int y)
{
  tDrawShapeExtended drawFlags;
  int idx;       /* shape index of the button glyph (var_a0 / var_t0) */
  int drawX;     /* var_a2 */
  int drawY;     /* var_a3 */
  int px;        /* var_s2 -- running X */
  int py;        /* var_s1 -- running Y (= y + 1) */
  int btn;       /* button & 0xFFFF */
  int tmpY;      /* var_s1 - 1 (case 0xA0) */

  px = x;
  py = y + 1;
  btn = button & 0xFFFF;
  drawFlags.tint[0] = 0xBEBE;
  switch (btn) {
  case 0x50:
    DrawShapeExtended(0x1A, 0x18, px + 3, py - 2, 0, 0, &drawFlags);
    idx = 0x1B;
    drawX = px + 4;
    drawY = py + 4;
    break;
  case 0xA0:
    tmpY = py - 1;
    DrawShapeExtended(0x1C, 0x18, px, tmpY, 0, 0, &drawFlags);
    idx = 0x1D;
    drawX = px + 0xA;
    drawY = tmpY;
    break;
  default:
    if ((padType & 0xFF) == 0x23) {
      if (btn != 0x1000) {
        if (btn < 0x1001) {
          idx = 0;
          if (btn == 8) { idx = 0x15; py -= 1; }
        } else if (btn != 0x4000) {
          idx = 0;
          if (btn == 0x8000) { idx = 0x14; py -= 2; }
        } else { idx = 0x13; py -= 4; }
      } else { idx = 0x12; py -= 3; }
    } else {
      if (btn != 0x1000) {
        if (btn < 0x1001) {
          idx = 0;
          if (btn == 8) { idx = 0x10; px += 2; }
        } else if (btn != 0x4000) {
          idx = 0;
          if (btn == 0x8000) { idx = 0xE; py -= 3; }
        } else { idx = 0xC; py -= 3; }
      } else { idx = 0xF; py -= 3; }
    }
    drawX = px;
    drawY = py;
    break;
  }
  DrawShapeExtended(idx, 0x18, drawX, drawY, 0, 0, &drawFlags);
  return;
}

/* ---- FeTools_init  [FETOOLS.CPP:287-331] SLD-VERIFIED ---- */

void FeTools_init(void)

{
  char filename [256];
  
  Font_ExitFromGame();
  sprintf(filename,"%stiny.pfn",Paths_Paths[0x21]);
  font12[0] = (char *)loadfileadrz(filename,(void *)0x0);
  Font_LoadFont(font12[0],0x3c0,0x181,'\0');
  sprintf(filename,"%ssmall.pfn",Paths_Paths[0x21]);
  font18[0] = (char *)loadfileadrz(filename,(void *)0x0);
  Font_LoadFont(font18[0],0x380,0x100,'\0');
  sprintf(filename,"%stitle.pfn",Paths_Paths[0x21]);
  fontTitle[0] = (char *)loadfileadrz(filename,(void *)0x0);
  Font_LoadFont(fontTitle[0],0x3c0,0x100,'\0');
  currentSize[0] = 3;
  return;
}



/* ---- FeTools_deinit  [FETOOLS.CPP:337-342] SLD-VERIFIED ---- */

void FeTools_deinit(void)

{
  purgememadr(font18[0]);
  purgememadr(fontTitle[0]);
  purgememadr(font12[0]);
  Font_DeInit();
  return;
}



/* ---- FeTools_FormatMoney  [FETOOLS.CPP:369-377] SLD-VERIFIED ---- */

void FeTools_FormatMoney(char *string,long amount)

{
  char *format;
  int lo;
  int hi;
  int sign;
  
  sign = 0x20;
  if (amount < 0) {
    amount = -amount;
    sign = 0x2d;
  }
  if (amount < 1000) {
    format = TextSys_Word(0x83);
    sprintf(string,format,sign,amount);
  }
  else {
    if (amount < 1000000) {
      format = TextSys_Word(0x84);
      hi = amount / 1000;
      lo = amount % 1000;
    }
    else {
      format = TextSys_Word(0x85);
      hi = amount / 1000000;
      lo = (amount % 1000000) / 1000;
    }
    sprintf(string,format,sign,hi,lo);
  }
  return;
}



/* end of fetools.cpp */
