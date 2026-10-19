/* game/common/AIWORLD_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AIWORLD_EXTERNS_H_
#define _GAME_COMMON_AIWORLD_EXTERNS_H_
#include "aiworld_types.h"

/* AIWORLD.obj's SYM deliberately does not emit Trk_NewSlice.  Keep the owner
 * pointer opaque and use the retail 32-byte slice ABI at the access sites. */
extern char          *BWorldSm_slices;
extern int                AITune_driveSide;
extern int            gNumSlices;
extern int Newton_CalculateSliceYaw(int slice);
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/fixdmult.h"
}

#endif /* _GAME_COMMON_AIWORLD_EXTERNS_H_ */
