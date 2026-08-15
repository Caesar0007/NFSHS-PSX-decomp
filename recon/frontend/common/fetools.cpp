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
/* THIS IS Fetools.obj's WHOLE retail .data RUN, IN RETAIL ORDER -- DO NOT RE-SORT.
   SYM Fetools.obj block (W66-A5 symown.py): 0x800517d0 FeTools_gScrollTicksOut ->
   d4 font12 -> d8 font18 -> dc fontTitle -> e0 currentSize (SHORT).  gScrollTicksOut
   holds 1e 00 00 00 = 30 on disk, so it is the run's one INITIALISED object and leads;
   the four zero cells follow it as TENTATIVE definitions in FIRST-DECLARATION order
   (17B EXTERN-ORDER LAW) -- which is exactly these four lines.  Migrated here W66-A5:
   nothing in the 508 recon objects defined the first four, they were still in the blob.
   All keep the unsized-array `[]` + `[0]` access shape (§3.15): a global VALUE loaded
   into an ARG reg then uses the oracle's SEPARATE $v0 scratch (`lui v0; lw a0,(v0)`)
   rather than dest-as-temp (`lui a0; lw a0,(a0)`), which a scalar would fold. */
int   FeTools_gScrollTicksOut[1] = { 30 };   /* @0x800517d0 */
char *font12[1];                             /* @0x800517d4 */
char *font18[1];                             /* @0x800517d8 */
char *fontTitle[1];                          /* @0x800517dc */
short currentSize[1];                        /* @0x800517e0  current FE font size (SYM SHORT) */


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
  int type;

  type = 0;
  drawFlags.tint[0] = 0xBEBE;
  y = y + 1;
  switch (button) {
  case 0x50:
    DrawShapeExtended(0x1A,0x18,x + 3,y - 2,0,0,&drawFlags);
    DrawShapeExtended(0x1B,0x18,x + 4,y + 4,0,0,&drawFlags);
    return;
  case 0xA0:
    DrawShapeExtended(0x1C,0x18,x,y - 1,0,0,&drawFlags);
    y = y - 1;
    DrawShapeExtended(0x1D,0x18,x + 0xA,y,0,0,&drawFlags);
    return;
  default:
    if (padType == 0x23) {
      switch (button) {
      case 0x1000:
        type = 0x12;
        y = y - 3;
        break;
      case 0x4000:
        type = 0x13;
        y = y - 4;
        break;
      case 0x8000:
        type = 0x14;
        y = y - 2;
        break;
      case 8:
        type = 0x15;
        y = y - 1;
        break;
      }
    }
    else {
      switch (button) {
      case 0x1000:
        type = 0xF;
        y = y - 3;
        break;
      case 0x4000:
        type = 0xC;
        y = y - 3;
        break;
      case 0x8000:
        type = 0xE;
        y = y - 3;
        break;
      case 8:
        type = 0x10;
        x = x + 2;
        break;
      }
    }
    break;
  }
  DrawShapeExtended(type,0x18,x,y,0,0,&drawFlags);
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
/* SYM 8c @0x80026ce0: locals are EXACTLY absnum(REG LONG $10=$s0) + neg(REG CHAR
   $11=$s1); string REGPARM $12=$s2, amount REGPARM $05=$a1.  So the param `amount`
   is NEVER reassigned -- retail keeps it in $a1 (dies before the first call) and
   works the absolute value in a SEPARATE $s0.  (W56-A10: 68->64; the old body
   reassigned `amount = -amount`, forcing it into $s0 and losing the a1 identity.)
   W57-A7 (2026-08-09) 64 -> PASS 93/93: TWO independent defects -- (1) the >= 1e6 arm was
   missing a whole numeric field (real bug, see the in-body receipt), (2) the abs was
   hand-rolled instead of `abs()`.  See the in-body MATCH blocks. */

void FeTools_FormatMoney(char *string,long amount)

{
  char *format;
  int lo;
  int hi;
  long absnum;
  char neg;

  /* MATCH (W57-A7, 5 -> PASS): the first block IS gcc's INLINE ABS idiom
     (`bgez a1,L; addu s0,a1,zero [slot]; negu s0,s0; L:`) -- so the source was
     `absnum = abs(amount);`, NOT a hand-rolled `if (amount<0) absnum = -absnum;`.
     Written by hand, the two `amount < 0` tests are one condition to jump.c and get
     merged into a single `bgez $s0` (every split-if / fence spelling still merged:
     two ifs 5, +identity fence on amount 6, on absnum 6-7, read-only fence 6, order
     swap 8).  `__builtin_abs` is opaque to the merge AND keeps `amount` in its
     REGPARM $a1 exactly as the SYM says, so the sign test stays a second `bgez $a1`. */
  neg = 0x20;
  absnum = __builtin_abs(amount);
  if (amount < 0) {
    neg = 0x2d;
  }
  /* 🔴 REAL BUG FIXED (W57-A7, 64 -> 5 diffs, ours 92 / oracle 93): the >= 1,000,000 arm
     passes THREE numeric fields, not two -- `sprintf(s,fmt,neg, n/1000000, (n%1000000)/1000,
     n%1000)`.  The old body shared ONE `sprintf(...,neg,hi,lo)` across both big arms, so a
     money value >= 1,000,000 lost its last group and read a 6th argument off uninitialised
     stack.  The oracle proves it: the >=1e6 arm runs THREE magic multiplies (0x431BDE83
     for /1000000 and 0x10624DD3 TWICE) and stores 0x10(sp) AND 0x14(sp), while the middle
     arm stores only 0x10(sp) -- the two arms then cross-jump-merge on the shared
     `sw v0,0x10(sp); jal sprintf` tail, which is exactly what per-arm sprintf calls emit.
     (The census tell was `mult 3v4 / mfhi 3v4` = one whole divide missing.) */
  if (absnum < 1000) {
    format = TextSys_Word(0x83);
    sprintf(string,format,neg,absnum);
  }
  else if (absnum < 1000000) {
    format = TextSys_Word(0x84);
    sprintf(string,format,neg,absnum / 1000,absnum % 1000);
  }
  else {
    format = TextSys_Word(0x85);
    sprintf(string,format,neg,absnum / 1000000,(absnum % 1000000) / 1000,absnum % 1000);
  }
  return;
}



/* end of fetools.cpp */
