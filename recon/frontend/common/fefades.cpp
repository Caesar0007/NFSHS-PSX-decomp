/* frontend/common/fefades.cpp  --  RECONSTRUCTED  (FE menu colour-fade math; C++ TU)
 *   Bodies: Ghidra decompiler. Line numbers: PsyQ SLD (8c decl, 8e end).
 *   6 EXT functions; C++ linkage. CalcFadeVal is OVERLOADED (2/3/4-arg, resolved by arity).
 *   CalcOnOffFade takes int& output refs (OnColor/OffColor).
 */
#include "fefades.h"

static inline int TextDefinitionColor(tMenuTextType type, int column)
{
  /* The retail SYM records a nested inline block for each lookup.  Keeping
     this as an accessor prevents CSE from merging the row-base expressions. */
  int *colors = kRGBVals;
  return colors[(byte)textDefinitions[type][column]];
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
  int result;
  
  result = CalcFadeVal(col1,0,amount);
  return result;
}

/* lines 36-38: (static data / macros / comments - no emitted code) */

/* ---- CalcFadeVal4  (fefades.cpp:39, code lines 39-40) ---- */
int CalcFadeVal(int col1,int col2,int amount,int fFade)

{
  int result;
  
  result = CalcFadeVal(col1,col2,amount);
  result = CalcFadeVal(result,0,fFade);
  return result;
}

/* lines 41-43: (static data / macros / comments - no emitted code) */

/* ---- CalcTextFadeUnselToSel  (fefades.cpp:44, code lines 44-49) ---- */
int CalcTextFadeUnselToSel(tMenuTextType type,short fSelFade,short fFade)

{
  /* MATCH: the SYM's two nested inline-block pairs reveal two calls to the
     accessor above.  They retain separate row bases and 3/4 load displacements. */
  return CalcFadeVal(TextDefinitionColor(type,3),
                     TextDefinitionColor(type,4),
                     (int)fSelFade,(int)fFade);
}

/* lines 50-52: (static data / macros / comments - no emitted code) */

/* ---- CalcTextFadeSelToHi  (fefades.cpp:53, code lines 53-59) ---- */
int CalcTextFadeSelToHi(tMenuTextType type,short fSelFade,short fFade)

{
  int result;

  /* MATCH: two inlined accessor calls reproduce the SYM block nesting. */
  result = CalcFadeVal(TextDefinitionColor(type,4),
                            TextDefinitionColor(type,5),(int)fSelFade);
  result = CalcFadeVal(result,0,(int)fFade);
  return result;
}

/* lines 60-64: (static data / macros / comments - no emitted code) */

/* ---- CalcOnOffFade  (fefades.cpp:65, code lines 65-79) ---- */
/* SYM 8c: the named REG locals are ColSelOn($12=$s2) / ColSelOff($16=$s6) /
   ColUnSelOn+ColUnSelOff (both $10=$s0) plus the two int& REGPARM->REG copies
   ($17, $1e); baseA/baseB/baseC below are compiler temps in retail (the three
   kRGBVals lookups are hoisted by CSE ahead of the first call).  SLD statements:
   72 / 73 / 75 / 76 / 78 / 79 -- the order kept here.
   MATCH 2026-08-13 (12->2): the three SYM inline-block pairs were accessor calls.
   The sole residual is scheduling of `%lo(kRGBVals)` by six instructions; register
   allocation, instruction count, row bases, displacements, and calls are exact. */
void CalcOnOffFade(tMenuTextType type,short fOnOffFade,short fSelFade,short fFade,int &OnColor,
               int &OffColor)

{
  int ColSelOn;
  int ColSelOff;
  int ColUnSelOn;
  int ColUnSelOff;
  int baseA;
  int baseB;
  int baseC;

  baseA = TextDefinitionColor(type,4);
  baseB = TextDefinitionColor(type,5);
  baseC = TextDefinitionColor(type,3);
  ColSelOn = CalcFadeVal(baseA,baseB,(int)fOnOffFade);
  ColSelOff = CalcFadeVal(baseB,baseA,(int)fOnOffFade);
  ColUnSelOn = CalcFadeVal(baseC,baseA,(int)fOnOffFade);
  ColUnSelOff = CalcFadeVal(baseA,baseC,(int)fOnOffFade);
  OnColor = CalcFadeVal(ColUnSelOn,ColSelOn,(int)fSelFade,(int)fFade);
  OffColor = CalcFadeVal(ColUnSelOff,ColSelOff,(int)fSelFade,(int)fFade);
}

/* end of fefades.cpp */
