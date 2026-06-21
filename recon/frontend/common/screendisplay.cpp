/* frontend/screens/screendisplay.cpp  --  RECONSTRUCTED  (display-options screen; C++ TU)
 *   3 MEMBER fns of tScreenDisplay : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
#include "screendisplay.h"

tScreenDisplay *screenDisplay;   /* global instance pointer owned by this TU (SYM EXT @0x800528d8) */

/* ---- tScreenDisplay::DrawBackground  (screendisplay.cpp:30) ---- */
void tScreenDisplay::DrawBackground()

{
  short fade;
  int i;

  fade = (short)((menuDefs->menuDisplayOptions).fScreenFade >> 1);
  i = 0;
  if (0x80 < fade) {
    fade = 0x80;
  }
  do {
    DrawShapeExtended(0xB,0,0,0,(int)fade,0,    /* H15: args 0-3 were uninitialized; oracle 0x80045998 $a0=$s0+0xB=11 (const, set once before loop), $a1=$a2=$a3=0 */
               (tDrawShapeExtended *)0x0);
    i = i + 1;
  } while (i < 0x20);
  return;
}

/* ---- tScreenDisplay::GetShapeInfo  (screendisplay.cpp:46) ---- */
void tScreenDisplay::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)

{
  *swapFileName = (char *)0x0;
  numSwapShapes = 0;
  numPermShapes = 0x2b;
  *permFileName = "zDsply";
  return;
}

/* ---- tScreenDisplay::~tScreenDisplay  (screendisplay.cpp:41) ---- */
tScreenDisplay::~tScreenDisplay()

{
  return;
}

/* end of screendisplay.cpp */