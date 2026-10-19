/* frontend/common/feinput_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FEINPUT_EXTERNS_H_
#define _FE_SCREENS_FEINPUT_EXTERNS_H_
#include "feinput_types.h"

/* ===== globals ===== */
/* pad.obj records gPadinfo as anonymous .63fake (84 bytes), not a named
 * FEInput_PadCodegenView/tPadModuleState type. Restore its known fields;
 * exact foreign-header visibility in FEInput.obj remains source-review work. */
extern struct {
    int initialized;
    PAD_COMMON buf[8];
    struct {
        u_char bActive, time;
    } state[8];
} gPadinfo;
extern tfrontEnd        frontEnd;
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/vars.h"
}
extern int              FeTools_gScrollTicksOut;        /* @0x800517d0; SYM INT */
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
