/* game/common/aidelaycar_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_CAMERA_EXTERNS_H_
#define _GAME_COMMON_CAMERA_EXTERNS_H_
#include "aidelaycar_types.h"

/* ---- (AIDelayCar has no vtable) ---- */
extern int            gNumSlices;
extern int AIWorld_LaneIndex(int slice,int position);
int AIWorld_ApxSplineDistance(Car_tObj *a, Car_tObj *b);
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/fixdmult.h"
}

#endif /* _GAME_COMMON_CAMERA_EXTERNS_H_ */
