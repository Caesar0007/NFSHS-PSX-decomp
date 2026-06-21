/* game/common/aih_basiccop.h — reconstructed from game/common/aih_basiccop.cpp (8 fns) */
#ifndef _GAME_COMMON_AIH_BASICCOP_H_
#define _GAME_COMMON_AIH_BASICCOP_H_
#include "../../nfs4_types.h"

void * __15AIHigh_BasicCopP8Car_tObji(AIHigh_BasicCop *self, Car_tObj *carObj, int copIndex);   /* :18 */
void CheckSpikeBelt__15AIHigh_BasicCop(AIHigh_BasicCop *self);   /* :41 */
int ShouldIPerformCutOffBlock__15AIHigh_BasicCopiP8Car_tObj(AIHigh_BasicCop *self, int chancePerSecond, Car_tObj *target);   /* :83 */
void Blockade_AddRoadFlare__FP8coorddef(coorddef *pos);   /* :119 */
void Blockade_AddObject__FiP8coorddefi(int slice, coorddef *pos, int objectID);   /* :134 */
void PlacePointOnRoad__FiP8coorddef(int slice, coorddef *offset);   /* :165 */
void SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t(AIHigh_BasicCop *self, blockade_t *blockade);   /* :198 */
void HandleBlockadeSpeech__15AIHigh_BasicCop(AIHigh_BasicCop *self);   /* :298 */

#endif /* _GAME_COMMON_AIH_BASICCOP_H_ */
