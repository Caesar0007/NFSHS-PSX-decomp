/* game/common/chunk.h — reconstructed from game/common/chunk.cpp (4 fns) */
#ifndef _GAME_COMMON_CHUNK_H_
#define _GAME_COMMON_CHUNK_H_
#include "../../nfs4_types.h"

/* P875: native signatures and defining exports verified by typed-reference
 * probes. Source names let the compiler emit the original C++ linkage. */

/* InstanceGroup is a real Chunk member (struct Chunk, nfs4_types.h) -> chunk->InstanceGroup(...) */
void Chunk_UpdateSys(DRender_tView *Vi);   /* :274 */
void Chunk_Init(void);   /* :291 */
void Chunk_DeInit(void);   /* :310 */

#endif /* _GAME_COMMON_CHUNK_H_ */
