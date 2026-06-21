/* game/common/aih_cop.h — reconstructed from game/common/aih_cop.cpp (9 fns) */
#ifndef _GAME_COMMON_AIH_COP_H_
#define _GAME_COMMON_AIH_COP_H_
#include "../../nfs4_types.h"

void * __10AIHigh_CopP8Car_tObji(AIHigh_Cop *self, Car_tObj *carObj, int copIndex);   /* :95 */
void SetTuningLevers__10AIHigh_Cop(AIHigh_Cop *self);   /* :110 */
void HighExecute__10AIHigh_Cop(AIHigh_Cop *self);   /* :147 */
int CheckForNeedyPlayers__10AIHigh_Cop(AIHigh_Cop *self);   /* :819 */
void CheckForWipeOut__10AIHigh_Cop(AIHigh_Cop *self);   /* :845 */
int CheckForNewTarget__10AIHigh_Cop(AIHigh_Cop *self);   /* :891 */
void AssignToPlayer__10AIHigh_CopP13AIHigh_Player(AIHigh_Cop *self, AIHigh_Player *target);   /* :975 */
int GetCheckChasePosition__10AIHigh_CopP8coorddef(AIHigh_Cop *self, coorddef *pos);   /* :995 */
void * CheckForNewTriggers__10AIHigh_Cop(AIHigh_Cop *self);   /* :1021 */

#endif /* _GAME_COMMON_AIH_COP_H_ */
