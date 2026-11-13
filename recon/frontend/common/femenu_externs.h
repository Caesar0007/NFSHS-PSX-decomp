/* frontend/common/femenu_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FEMENU_EXTERNS_H_
#define _FE_SCREENS_FEMENU_EXTERNS_H_
#include "femenu_types.h"

/* ===== class vtables ===== */

/* ===== globals ===== */
extern tFEApplication *FEApp;
extern tPlayer        gMenu_SubMenuPlayer;   /* SYM 563d74: scalar ENUM tPlayer */

/* ===== text / audio / app ===== */
int   TextSys_Word(int id);
int   TextSys_WordX(int id);
int   TextSys_WordY(int id);
void  FETextRender_Title(short word);
void  FETextRender_MenuTextPositioned(short word, short x, short y,
                                      int state, int type)
    __asm__("FETextRender_MenuTextPositioned__Fsss14tMenuTextState13tMenuTextType");
void  AudioCmn_PlayFESFX(int sfx);
void  AudioCmn_PlayFESFXVol(int sfx, int vol);
/* w64 unlock (A19 sec-2.4): member fn taking short -- the free-fn int decl
 * emitted the phantom DisplayHelp__FP14tFEApplicationi. */
/* DisplayHelp: tFEApplication member (feapp_class.h) */

/* ===== fefades.obj fade helper (overloaded) + libgpu ===== */
int   CalcFadeVal(int color, int fade);
int   CalcFadeVal(int color, int packedRGB, int fade);

extern "C" {
void SetPolyF4(POLY_F4 *p);
void SetSemiTrans(void *p, int abe);
}

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x800110B8): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */

static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

/* Retail Initialize retains tMenuItem receivers, not a free helper's item.
 * IsEnabled reuses the existing inferred member spelling. The interface-only
 * definition avoids a non-retail standalone getter in this key-function TU. */
/* (no #pragma: user ruling 2026-11-07) */
/* IsEnabled: defined right after the class (NFS4_FEMENU_TMENUITEM_STRIPPED_DEFS, shared/tpdef_keys.h; FESCR2) */
/* ORIGINAL-NAME-UNRESOLVED: fNewMenu getter; retail GoToMenuButton::ProcessInput records its tMenuItem `this`
 * pairs at the test (904) and the nextMenu store (916). Interface-only like IsEnabled (no standalone copy). */
/* NewMenu: defined right after the class (NFS4_FEMENU_TMENUITEM_STRIPPED_DEFS, shared/tpdef_keys.h; FESCR2) */

#endif
