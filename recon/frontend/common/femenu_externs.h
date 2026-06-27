/* frontend/common/femenu_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FEMENU_EXTERNS_H_
#define _FE_SCREENS_FEMENU_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ===== class vtables ===== */
extern __vtbl_ptr_type tListIterator_vtable[];
extern __vtbl_ptr_type tListIteratorIndexed_vtable[];
extern __vtbl_ptr_type tListIteratorDoubleIndexed_vtable[];
extern __vtbl_ptr_type tListIteratorMultiPlayer_vtable[];
extern __vtbl_ptr_type tListIteratorRange_vtable[];
extern __vtbl_ptr_type tListIteratorRangeIndexed_vtable[];
extern __vtbl_ptr_type tMenuItem_vtable[];
extern __vtbl_ptr_type tMenuItemInteractive_vtable[];
extern __vtbl_ptr_type tMenuItemLeftRightChoice_vtable[];
extern __vtbl_ptr_type tMenuItemLeftRightSlider_vtable[];
extern __vtbl_ptr_type tMenuItemGoToMenuButton_vtable[];
extern __vtbl_ptr_type tMenu_vtable[];

/* ===== globals ===== */
extern u_char        *Render_gPacketPtr, *Render_gPalettePtr;
extern tFEApplication *FEApp;
extern tPlayer        gMenu_SubMenuPlayer[];   /* unsized array (§3.12 #5): forces separate-$v0 scratch on value-load (oracle lui/lw, not gp-rel) */

/* ===== text / audio / app ===== */
int   TextSys_Word(int id);
int   TextSys_WordX(int id);
int   TextSys_WordY(int id);
void  FETextRender_Title(short word);
void  FETextRender_MenuTextPositioned(short word, short x, short y, tMenuTextState state, tMenuTextType type);
void  AudioCmn_PlayFESFX(int sfx);
void  AudioCmn_PlayFESFXVol(int sfx, int vol);
void  DisplayHelp(tFEApplication *app, int which);

/* ===== fefades.obj fade helper (overloaded) + libgpu ===== */
int   CalcFadeVal(int color, int fade);
int   CalcFadeVal(int color, int packedRGB, int fade);

#endif
