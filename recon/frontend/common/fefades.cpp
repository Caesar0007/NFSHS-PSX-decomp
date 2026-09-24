/* frontend/common/fefades.cpp  --  RECONSTRUCTED  (FE menu colour-fade math; C++ TU)
 *   Bodies: Ghidra decompiler. Line numbers: PsyQ SLD (8c decl, 8e end).
 *   6 EXT functions; C++ linkage. CalcFadeVal is OVERLOADED (2/3/4-arg, resolved by arity).
 *   CalcOnOffFade takes int& output refs (OnColor/OffColor).
 */
#include "fefades.h"

static inline int TextDefinitionColor(tMenuTextType type, int column)
{
  /* The retail SYM records a nested inline block for each lookup. */
  return kRGBVals[(byte)textDefinitions[type][column]];
}

/* lines 1-20: file header, #includes, static data, macros (no symbols emitted) */

/* ---- CalcFadeVal3  (fefades.cpp:21, code lines 21-30) ---- */
/* SYM 8c: locals r($04) g($03) b($02) only -- NO `inv` local (0x80-amount is a CSE).
   SLD statement order = 26 (r, the LOW byte) / 27 (g) / 28 (b, the HIGH byte) / 30
   (the packed return).  The channel packing is PSX BGR: 0xBBGGRR. */
int CalcFadeVal(int col1,int col2,int amount)

{
  int r;
  int g;
  int b;

  r = (int)((0x80 - amount) * (col1 & 0xffU) + amount * (col2 & 0xffU)) >> 7;
  g = (int)((0x80 - amount) * (col1 >> 8 & 0xffU) + amount * (col2 >> 8 & 0xffU)) >> 7;
  b = (int)((0x80 - amount) * (col1 >> 0x10 & 0xffU) + amount * (col2 >> 0x10 & 0xffU)) >> 7;

  return b << 0x10 | g << 8 | r;
}

/* lines 31-33: (static data / macros / comments - no emitted code) */

/* ---- CalcFadeVal2  (fefades.cpp:34, code lines 34-35) ---- */
int CalcFadeVal(int col1,int amount)

{
  return CalcFadeVal(col1,0,amount);
}

/* lines 36-38: (static data / macros / comments - no emitted code) */

/* ---- CalcFadeVal4  (fefades.cpp:39, code lines 39-40) ---- */
int CalcFadeVal(int col1,int col2,int amount,int fFade)

{
  return CalcFadeVal(CalcFadeVal(col1,col2,amount),0,fFade);
}

/* lines 41-43: (static data / macros / comments - no emitted code) */

/* ---- CalcTextFadeUnselToSel  (fefades.cpp:44, code lines 44-49) ---- */
/* Two inline lookups retain separate row bases and 3/4 displacements. */
int CalcTextFadeUnselToSel(tMenuTextType type,short fSelFade,short fFade)

{
  const int color = CalcFadeVal(TextDefinitionColor(type,3),
                                TextDefinitionColor(type,4),
                                (int)fSelFade,
                                (int)fFade);
  return color;

}

/* lines 50-52: (static data / macros / comments - no emitted code) */

/* ---- CalcTextFadeSelToHi  (fefades.cpp:53, code lines 53-59) ---- */
/* Two inlined accessor calls reproduce the SYM block nesting. */
int CalcTextFadeSelToHi(tMenuTextType type,short fSelFade,short fFade)

{

  const int selectedColor = CalcFadeVal(TextDefinitionColor(type,4),
                                        TextDefinitionColor(type,5),
                                        (int)fSelFade);
  const int color = CalcFadeVal(selectedColor,0,(int)fFade);
  return color;
}

/* lines 60-64: (static data / macros / comments - no emitted code) */

/* ---- CalcOnOffFade  (fefades.cpp:65, code lines 65-79) ---- */
/* SYM 8c: the named REG locals are ColSelOn($12=$s2) / ColSelOff($16=$s6) /
   ColUnSelOn+ColUnSelOff (both $10=$s0) plus the two int& REGPARM->REG copies
   ($17, $1e).  SLD statements:
   72 / 73 / 75 / 76 / 78 / 79 -- the order kept here.
   MATCH 2026-08-13 (12->2): the three SYM inline-block pairs were accessor calls.
   PASS 2026-08-26 (2->0, 88/88): initialize the three SYM-unnamed value carriers
   in column 5/4/3 order.  The order changes only sched2's address-chain
   priority and places `%lo(kRGBVals)` immediately after its `%hi`; the six named
   SLD statements below, register allocation, row bases, displacements, and calls
   remain exact.
   NFS4 SYM cannot recover names for the three values that retail CSE-hoists
   before the first call.  Removing them with inline-accessor expressions is
   FAIL 135 (103/88); raw expressions are FAIL 93 (97/88), and raw expressions
   with these value webs are FAIL 14 (86/88). */
/* Source-only column-color value webs preserve retail scheduling;
   their original names are not recoverable from SYM. */
void CalcOnOffFade(tMenuTextType type,short fOnOffFade,short fSelFade,short fFade,int &OnColor,
               int &OffColor)

{
  int ColSelOn, ColSelOff, ColUnSelOn, ColUnSelOff;
  int colorColumn4, colorColumn5, colorColumn3;

  colorColumn5 = TextDefinitionColor(type,5);
  colorColumn4 = TextDefinitionColor(type,4);
  colorColumn3 = TextDefinitionColor(type,3);
  ColSelOn = CalcFadeVal(colorColumn4,colorColumn5,(int)fOnOffFade);
  ColSelOff = CalcFadeVal(colorColumn5,colorColumn4,(int)fOnOffFade);

  ColUnSelOn = CalcFadeVal(colorColumn3,colorColumn4,(int)fOnOffFade);
  ColUnSelOff = CalcFadeVal(colorColumn4,colorColumn3,(int)fOnOffFade);

  OnColor = CalcFadeVal(ColUnSelOn,ColSelOn,(int)fSelFade,(int)fFade);
  OffColor = CalcFadeVal(ColUnSelOff,ColSelOff,(int)fSelFade,(int)fFade);
}

/* end of fefades.cpp */
