/* game/common/simqueue.h — reconstructed from game/common/simqueue.cpp (8 fns) */
#ifndef _GAME_COMMON_SIMQUEUE_H_
#define _GAME_COMMON_SIMQUEUE_H_
#include "../../nfs4_types.h"

void SimQueue_StartUp__Fv(void);   /* :93 */
void SimQueue_Reset__Fv(void);   /* :115 */
void SimQueue_CleanUp__Fv(void);   /* :169 */
int SimQueue_Put__FiP14Input_tResults(int pIndex, Input_tResults *val);   /* :201 */
void SimQueue_SetCurrentInput__Fi(int time);   /* :271 */
void SimQueue_GetCurrentInput__FiP14Input_tResults(int pIndex, Input_tResults *out);   /* :295 */
void SimQueue_SetLag__Fv(void);   /* :326 */
int SimQueue_IsBlocking__Fi(int pIndex);   /* :382 */

#endif /* _GAME_COMMON_SIMQUEUE_H_ */
