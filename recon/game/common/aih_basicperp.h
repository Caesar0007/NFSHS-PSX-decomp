/* game/common/aih_basicperp.h — reconstructed from game/common/aih_basicperp.cpp (8 fns) */
#ifndef _GAME_COMMON_AIH_BASICPERP_H_
#define _GAME_COMMON_AIH_BASICPERP_H_
#include "../../nfs4_types.h"

void CheckForCrimes__16AIHigh_BasicPerp(AIHigh_BasicPerp *self);   /* :43 */
int CheckIfCaught__16AIHigh_BasicPerp(AIHigh_BasicPerp *self);   /* :180 */
void RemoveCloseCops__16AIHigh_BasicPerp(AIHigh_BasicPerp *self);   /* :296 */
void RemoveChaser__16AIHigh_BasicPerpii7copType(AIHigh_BasicPerp *self, int copIndex, int carIndex, int type);   /* :331 */
int AddChaser__16AIHigh_BasicPerpii7copType(AIHigh_BasicPerp *self, int copIndex, int carIndex, int type);   /* :343 */
int CheckChaserPosition__16AIHigh_BasicPerpii(AIHigh_BasicPerp *self, int copIndex, int carIndex);   /* :359 */
void Clear__16AIHigh_BasicPerp(AIHigh_BasicPerp *self);   /* :406 */
void * __16AIHigh_BasicPerpP8Car_tObj(AIHigh_BasicPerp *self, Car_tObj *carObj);   /* :419 */

#endif /* _GAME_COMMON_AIH_BASICPERP_H_ */
