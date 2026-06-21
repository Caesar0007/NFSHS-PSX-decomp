/* game/common/aih_traf.h — reconstructed from game/common/aih_traf.cpp (5 fns) */
#ifndef _GAME_COMMON_AIH_TRAF_H_
#define _GAME_COMMON_AIH_TRAF_H_
#include "../../nfs4_types.h"

void * CheckForCops__14AIHigh_TrafficPi(AIHigh_Traffic *self, int *closestDistance);   /* :32 */
void * CopCheck__14AIHigh_TrafficPi(AIHigh_Traffic *self, int *blockade);   /* :61 */
void HighExecute__14AIHigh_Traffic(AIHigh_Traffic *self);   /* :129 */
void * __14AIHigh_TrafficP8Car_tObj(AIHigh_Traffic *self, Car_tObj *carObj);   /* :343 */
void * CheckForNewTriggers__14AIHigh_Traffic(AIHigh_Traffic *self);   /* :353 */

#endif /* _GAME_COMMON_AIH_TRAF_H_ */
