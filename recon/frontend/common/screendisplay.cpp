/* frontend/screens/screendisplay.cpp  --  RECONSTRUCTED  (display-options screen; C++ TU)
 *   3 MEMBER fns of tScreenDisplay : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
#include "screendisplay_types.h"
#include "screendisplay_externs.h"

/* Retail's empty inline pair belongs to the existing options-menu fade getter. */



tScreenDisplay *screenDisplay;   /* global instance pointer owned by this TU (SYM EXT @0x800528d8) */

/* ---- tScreenDisplay::DrawBackground  (screendisplay.cpp:30) ---- */
#line 27 "C:/nfs4/FRONTEND/COMMON/SCREENDISPLAY.CPP"
void tScreenDisplay::DrawBackground()


{
  int i;
  short fade;
  fade = (short)(((tOptionsMenu *)((char *)menuDefs + 0x2a68))->tOptionsMenu::GetScreenFade() >> 1);
  i = 0; if (0x80 < fade) { fade = 0x80;
  }

  do {
    DrawShapeExtended(i + 0xB,0,0,0,(int)fade,0,    /* oracle 0x80045998: $a0=$s0+0xB (loop counter i + 11), $a1=$a2=$a3=0 */
               (tDrawShapeExtended *)0x0);
    i = i + 1; } while (i < 0x20); return;
}

/* ---- tScreenDisplay::GetShapeInfo  (screendisplay.cpp:46) ---- */
#line 42 "C:/nfs4/FRONTEND/COMMON/SCREENDISPLAY.CPP"
void tScreenDisplay::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)


{
  *swapFileName = (char *)0x0;
  numSwapShapes = 0;
  numPermShapes = 0x2b;
  *permFileName = "zDsply";
}

/* ---- tScreenDisplay::~tScreenDisplay  (screendisplay.cpp:41) ---- */
extern "C" void ___7tScreen(void *);

/* end of screendisplay.cpp */
