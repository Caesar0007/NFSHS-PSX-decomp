/* pausemenu_externs.h -- extern decls for game/common/pausemenu.cpp (NFS4 in-race pause menu).
 *   Types (tPMenu*, tPListIterator*, tInputKeyType, tPMenuCommand, POLY_GT4, HudPmx_tShape) live in
 *   nfs4_types.h. This declares cross-TU globals/functions + this TU's manual vtable symbols.
 *   gPause_CurrentY is STAT-owned by PauseMenu.obj -> defined file-static in the .cpp.
 */
#ifndef PAUSEMENU_EXTERNS_H
#define PAUSEMENU_EXTERNS_H

#include "pausemenu_types.h"

extern void trap(int code);   /* gcc MIPS div/overflow break helper */

/* ---- cross-TU globals ---- */
extern bool             gMPauseUpdateNextTime;        /* mpause.obj; SYM BOOL */
extern PauseMenu_GameSetupCodegenView GameSetup_gData asm("GameSetup_gData");
extern PauseMenu_HudShapeCodegenView HudPmx_gShapes[] asm("HudPmx_gShapes");

/* ---- cross-TU functions (demangled) ---- */
extern "C" int textpixels(char *s);                                 /* textpix.obj */
extern void  Font_TextColor(int c);                               /* font.obj */
extern void  Font_TextXY(char *s, int x, int y);                  /* font.obj */
extern int   TextSys_WordFlags(int id);                           /* textsys.obj */
extern int   TextSys_WordX(int id);                               /* textsys.obj */
extern char *TextSys_Word(int id);                                /* textsys.obj */
extern void  AudioCmn_PlayPauseSound(int patch);                  /* audiocmn.obj */
extern void  Hud_BuildGT4(POLY_GT4 *prim, PauseMenu_HudShapeCodegenView *shape, int x, int y, u_long color)
    asm("Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl");   /* hud.obj */
extern void  Hud_FBuildF4(int transparent, int x, int y, int w, int h, u_long col1, char c0, char c1);  /* hud.obj */

/* ---- PauseMenu.obj manual vtable symbols ---- */
extern __vtbl_ptr_type tPListIterator_vtable[], tPListIteratorIndexed_vtable[],
  tPMenuItem_vtable[], tPMenuItemNonInteractiveText_vtable[], tPMenuItemInteractive_vtable[],
  tPMenuItemLeftRightChoice_vtable[], tPMenuItemLeftRightSlider_vtable[],
  tPMenuItemLeftRightSliderIndexed_vtable[], tPMenuItemGoToMenuButton_vtable[],
  tPMenuItemCommandButton_vtable[], tPMenu_vtable[];

#endif
