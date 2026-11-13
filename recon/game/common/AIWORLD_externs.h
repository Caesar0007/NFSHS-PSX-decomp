/* game/common/AIWORLD_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AIWORLD_EXTERNS_H_
#define _GAME_COMMON_AIWORLD_EXTERNS_H_
#include "aiworld_types.h"

#include "shared/Trk_NewSlice.h"
extern Trk_NewSlice  *BWorldSm_slices;   /* real type; was a char* view with offset access */
extern int                AITune_driveSide;
extern int            gNumSlices;
extern int Newton_CalculateSliceYaw(int slice);
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/fixdmult.h"
}

#endif /* _GAME_COMMON_AIWORLD_EXTERNS_H_ */
