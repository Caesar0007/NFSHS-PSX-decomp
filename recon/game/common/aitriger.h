/* game/common/aitriger.h — reconstructed from game/common/aitriger.cpp (10 fns) */
#ifndef _GAME_COMMON_AITRIGER_H_
#define _GAME_COMMON_AITRIGER_H_
#include "../../nfs4_types.h"

void Init__24AITrigger_TriggerManagerPc(AITrigger_TriggerManager *self, char *rawTriggers);   /* :21 */
int InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb(AITrigger_TriggerManager *self, trigger_t *trigger, BOOL fromFile);   /* :73 */
void * GetNextTrigger__24AITrigger_TriggerManageri(AITrigger_TriggerManager *self, int car);   /* :128 */
void * GetPrevTrigger__24AITrigger_TriggerManageri(AITrigger_TriggerManager *self, int car);   /* :138 */
int CheckForTriggerAtSlice__24AITrigger_TriggerManagerii(AITrigger_TriggerManager *self, int car, int slice);   /* :149 */
void * GetTrigger__24AITrigger_TriggerManageriPi(AITrigger_TriggerManager *self, int trigger, int *used);   /* :192 */
int CheckForClosestTriggerOfType__24AITrigger_TriggerManageri11triggerTypei(AITrigger_TriggerManager *self, int slice, int type, int direction);   /* :206 */
void DescribeTrigger__24AITrigger_TriggerManagerP9trigger_t(AITrigger_TriggerManager *self, trigger_t *trigger);   /* :278 */
int AITrigger_Compare__FPCvT0(void *op1, void *op2);   /* :289 */
void Sort__24AITrigger_TriggerManager(AITrigger_TriggerManager *self);   /* :298 */

#endif /* _GAME_COMMON_AITRIGER_H_ */
