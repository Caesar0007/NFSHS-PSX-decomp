/* game/common/simplemem.h — reconstructed from game/common/simplemem.cpp (3 fns) */
#ifndef _GAME_COMMON_SIMPLEMEM_H_
#define _GAME_COMMON_SIMPLEMEM_H_
#include "../../nfs4_types.h"

void * Alloc__9SimpleMemii(SimpleMem *self, int len, int feign);   /* :10 */
void * FeignAlloc__9SimpleMemi(SimpleMem *self, int len);   /* :45 */
void ResizeToFit__9SimpleMem(SimpleMem *self);   /* :57 */

#endif /* _GAME_COMMON_SIMPLEMEM_H_ */
