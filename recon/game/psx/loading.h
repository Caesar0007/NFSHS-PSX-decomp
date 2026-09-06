/* game/psx/loading.h — reconstructed from game/psx/loading.cpp (3 fns) */
#ifndef _GAME_PSX_LOADING_H_
#define _GAME_PSX_LOADING_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void Loading_DrawLoadingScreen(void);   /* SYM 4312e4 @0x800db0b8 */
void Loading_UpdateLoadingScreen(int checkpoint);   /* SYM 43130f @0x800db200 */
void Loading_GetInitialMemory(void);   /* SYM 43133c @0x800db2f8 */

#endif /* _GAME_PSX_LOADING_H_ */
