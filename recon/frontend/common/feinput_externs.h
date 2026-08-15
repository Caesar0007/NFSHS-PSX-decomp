/* frontend/common/feinput_externs.h - reconstructed externs. NOT original. */
#ifndef _FE_SCREENS_FEINPUT_EXTERNS_H_
#define _FE_SCREENS_FEINPUT_EXTERNS_H_
#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ===== globals ===== */
extern tPadModuleState  gPadinfo;
extern tfrontEnd        frontEnd;
extern int              ticks[];                       /* MATCH: unsized -> separate-temp base load (%3.12 #5) */
extern int              FeTools_gScrollTicksOut[];      /* @0x800517d0 -- unsized, see above */
extern int              debounce[] __asm__("D_80052B60");                     /* @0x80052b60 */
/* MATCH: UNSIZED array + [0] access -- a scalar extern makes cc1 emit the
   `lw/sw $r,sym` assembler macro (a $at store + a fresh lui per use); the oracle
   materializes the address ONCE into a caller-saved reg and offsets from it. */
extern long             nextTick[] __asm__("D_80051738");                     /* @0x80051738 */
extern tPSXToFEMapping  getKeyMappings[];               /* @0x8005173c */

/* ===== input helpers ===== */
void  Front_ResetPSXController(int controller, int mode);

/* same-TU fns (forward decls so callers earlier in the file resolve) */
void  FEInput_VerifyControllerValues(int controller);
int   FEInput_GetNoDebounceKey(int key, int controller);
int   FEInput_GetDebounceKey(int key, int controller);

#endif
