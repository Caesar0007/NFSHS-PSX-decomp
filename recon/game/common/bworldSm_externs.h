/* game/common/bworldSm_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_BWORLDSM_EXTERNS_H_
#define _GAME_COMMON_BWORLDSM_EXTERNS_H_
#include "bworldSm_types.h"

extern CVECTOR * Chunk_lightTable;
extern Chunk *Track_chunkList;
extern coorddef * Chunk_chunkCenters;
extern int  xzsquaredist32(coorddef *, coorddef *);
extern int BWorld_gChunkBuildList[];
int  Math_DistXZ(coorddef *a, coorddef *b);
void Math_NormalizeVector(coorddef *v);
extern "C" {
#include "eaclib/psx/eacpsxz/crossprd.h"
}
/* eaclib (EACPSXZ.LIB) -- the library's own headers for the members this TU uses. */
extern "C" {
#include "eaclib/psx/eacpsxz/fixdmult.h"
}

#endif /* _GAME_COMMON_BWORLDSM_EXTERNS_H_ */
