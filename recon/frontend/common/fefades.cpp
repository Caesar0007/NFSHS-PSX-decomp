/* frontend/common/fefades.cpp  --  RECONSTRUCTED  (FE menu colour-fade math; C++ TU)
 *   Bodies: Ghidra decompiler. Line numbers: PsyQ SLD (8c decl, 8e end).
 *   6 EXT functions; C++ linkage. CalcFadeVal is OVERLOADED (2/3/4-arg, resolved by arity).
 *   CalcOnOffFade takes int& output refs (OnColor/OffColor).
 */
#include "fefades.h"

/* lines 1-20: file header, #includes, static data, macros (no symbols emitted) */

/* ---- CalcFadeVal3  (fefades.cpp:21, code lines 21-30) ---- */
int CalcFadeVal(int col1,int col2,int amount)

{
  int b;
  int g;
  int inv;
  int r;
  
  inv = 0x80 - amount;
  r = (int)(inv * (col1 >> 0x10 & 0xffU) + amount * (col2 >> 0x10 & 0xffU)) >> 7;
  g = (int)(inv * (col1 >> 8 & 0xffU) + amount * (col2 >> 8 & 0xffU)) >> 7;
  b = (int)(inv * (col1 & 0xffU) + amount * (col2 & 0xffU)) >> 7;
  return r << 0x10 | g << 8 | b;
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
  int result;
  
  result = CalcFadeVal(kRGBVals[(byte)textDefinitions[type][3]],
                             kRGBVals[(byte)textDefinitions[type][4]],(int)fSelFade,(int)fFade);
  return result;
}

/* lines 50-52: (static data / macros / comments - no emitted code) */

/* ---- CalcTextFadeSelToHi  (fefades.cpp:53, code lines 53-59) ---- */
int CalcTextFadeSelToHi(tMenuTextType type,short fSelFade,short fFade)

{
  int result;
  
  result = CalcFadeVal(kRGBVals[(byte)textDefinitions[type][4]],
                            kRGBVals[(byte)textDefinitions[type][5]],(int)fSelFade);
  result = CalcFadeVal(result,0,(int)fFade);
  return result;
}

/* lines 60-64: (static data / macros / comments - no emitted code) */

/* ---- CalcOnOffFade  (fefades.cpp:65, code lines 65-79) ---- */
void CalcOnOffFade(tMenuTextType type,short fOnOffFade,short fSelFade,short fFade,int &OnColor,
               int &OffColor)

{
  int baseA;
  int baseB;
  int baseC;
  int ColUnSelOn;
  int result;
  int ColUnSelOff;
  int amount;
  int ColSelOn;
  int ColSelOff;
  
  amount = (int)fOnOffFade;
  baseA = kRGBVals[(byte)textDefinitions[type][4]];
  baseB = kRGBVals[(byte)textDefinitions[type][5]];
  baseC = kRGBVals[(byte)textDefinitions[type][3]];
  ColSelOn = CalcFadeVal(baseA,baseB,amount);
  ColSelOff = CalcFadeVal(baseB,baseA,amount);
  ColUnSelOn = CalcFadeVal(baseC,baseA,amount);
  ColUnSelOff = CalcFadeVal(baseA,baseC,amount);
  result = CalcFadeVal(ColUnSelOn,ColSelOn,(int)fSelFade,(int)fFade);
  OnColor = result;
  result = CalcFadeVal(ColUnSelOff,ColSelOff,(int)fSelFade,(int)fFade);
  OffColor = result;
  return;
}

/* end of fefades.cpp */