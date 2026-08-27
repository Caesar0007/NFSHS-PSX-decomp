/* frontend/common/feinput_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FEINPUT_EXTERNS_H_
#define _FE_SCREENS_FEINPUT_EXTERNS_H_
#include "feinput_types.h"

/* ===== globals ===== */
/* FEInput.obj contains PAD_COMMON but no 84-byte tPadModuleState tag.  SYM
 * proves gPadinfo is owned as anonymous .63fake by pad.obj; raw instructions
 * require the symbol base itself plus a +4 member displacement.  This private
 * foreign-symbol view is therefore a codegen carrier, not a recovered source
 * tag; the canonical type audit accepts only this exact owner/layout. */
struct FEInput_PadCodegenView {
    int initialized;
    PAD_COMMON buf[8];
    u_char stateBytes[16];
};
extern FEInput_PadCodegenView gPadinfo;
extern tfrontEnd        frontEnd;
extern int              ticks[];                       /* MATCH: unsized -> separate-temp base load (%3.12 #5) */
extern int              FeTools_gScrollTicksOut[];      /* @0x800517d0 -- unsized, see above */
extern tPSXToFEMapping  getKeyMappings[];               /* @0x8005173c */

/* ===== input helpers ===== */
void  Front_ResetPSXController(int controller, int mode);

extern "C" {
u_short PAD_state(int padID);
void PAD_update(void);
}

/* same-TU fns (forward decls so callers earlier in the file resolve) */
void  FEInput_VerifyControllerValues(int controller);
int   FEInput_GetNoDebounceKey(int key, int controller);
int   FEInput_GetDebounceKey(int key, int controller);

#endif
