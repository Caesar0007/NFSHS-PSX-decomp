/* game/common/simqueue.h — reconstructed from game/common/simqueue.cpp (8 fns) */
#ifndef _GAME_COMMON_SIMQUEUE_H_
#define _GAME_COMMON_SIMQUEUE_H_
#include "../../nfs4_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

void SimQueue_StartUp(void);   /* :93 */
void SimQueue_Reset(void);   /* :115 */
void SimQueue_CleanUp(void);   /* :169 */
int SimQueue_Put(int pIndex,Input_tResults *val);   /* :201 */
void SimQueue_SetCurrentInput(int time);   /* :271 */
void SimQueue_GetCurrentInput(int pIndex,Input_tResults *out);   /* :295 */

#endif /* _GAME_COMMON_SIMQUEUE_H_ */
