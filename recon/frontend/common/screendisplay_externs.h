/* frontend/screens/screendisplay_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_SCREENDISPLAY_EXTERNS_H_
#define _FE_SCREENS_SCREENDISPLAY_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

extern tfrontEnd   frontEnd;
extern int  ticks;
extern tGlobalMenuDefs *menuDefs;
/* (gFE_bgIndex/gFE_bgFadeVal are NOT globals: SYM STAT = DrawBackground-local statics
   lastpercentage/perfade @0x800528e0/e4 -- Ghidra mis-named them. Defined in the .cpp.) */
extern int  gMasterSFXLevel, gMasterMusicLevel, gMasterEngineLevel, gMasterAmbientLevel;
extern int  gMasterFENarrationLevel, gStereoMode, Audio_direct3davail;
extern SndBnk_t gSndBnk[7];
extern SPEECHINFO ginfo;
extern int  kRGBVals[28];
extern char textDefinitions[14][6];
int  CalcFadeVal(int col1, int col2, int amount);   /* 3-arg overload */
void DrawShapeExtended(int index, int flags, int x, int y, int fade, int abr, tDrawShapeExtended *extra);
int  textpixels(char *str);
void SetMenu(tMenuItemSlidingMenu *thisobj, short i, void *menu);   /* sliding-menu method; menu is tMenu-derived */
void *TransitionIsFinished(tOptionsMenu *thisobj);   /* method on the options menu */
int CalcFadeVal(int col1, int amount);            /* 2-arg overload */
int CalcFadeVal(int col1, int col2, int f1, int f2);  /* 4-arg overload */

/* called game/FE/audio/PsyQ functions (Ghidra-dumped signatures) */

#endif