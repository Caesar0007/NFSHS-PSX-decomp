/* game/common/aih_btcperp.h — reconstructed from game/common/aih_btcperp.cpp (20 fns) */
#ifndef _GAME_COMMON_AIH_BTCPERP_H_
#define _GAME_COMMON_AIH_BTCPERP_H_
#include "../../nfs4_types.h"

void ReleaseCops__15AIHigh_BTC_Perp(AIHigh_BTC_Perp *self);   /* :63 */
void HandleCops__15AIHigh_BTC_Perp(AIHigh_BTC_Perp *self);   /* :82 */
int IsFalseArrest__15AIHigh_BTC_Perp(AIHigh_BTC_Perp *self);   /* :93 */
int CheckForControlsPressed__15AIHigh_BTC_Perp(AIHigh_BTC_Perp *self);   /* :130 */
void HandlePullOver__15AIHigh_BTC_Perp(AIHigh_BTC_Perp *self);   /* :153 */
void NotifyCopsOfArrest__15AIHigh_BTC_Perp(AIHigh_BTC_Perp *self);   /* :233 */
void NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp(AIHigh_BTC_Perp *self);   /* :251 */
void NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp(AIHigh_BTC_Perp *self);   /* :271 */
void NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp(AIHigh_BTC_Perp *self);   /* :288 */
void ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop(AIHigh_BTC_Perp *self, AIHigh_BTC_HumanCop *chaserCop);   /* :304 */
void * CheckForActivation__15AIHigh_BTC_Perp(AIHigh_BTC_Perp *self);   /* :322 */
void NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop(AIHigh_BTC_HumanPerp *self, AIHigh_BTC_HumanCop *chaserCop);   /* :366 */
void HighExecute__20AIHigh_BTC_HumanPerp(AIHigh_BTC_HumanPerp *self);   /* :421 */
void * __17AIHigh_BTC_AIPerpP8Car_tObj(AIHigh_BTC_AIPerp *self, Car_tObj *carObj);   /* :441 */
void ___17AIHigh_BTC_AIPerp(AIHigh_BTC_AIPerp *self, int __in_chrg);   /* :461 */
void AvoidCops__17AIHigh_BTC_AIPerp(AIHigh_BTC_AIPerp *self);   /* :488 */
void CalculateTimeTillContact__17AIHigh_BTC_AIPerp(AIHigh_BTC_AIPerp *self);   /* :557 */
void FindClosestCop__17AIHigh_BTC_AIPerp(AIHigh_BTC_AIPerp *self);   /* :582 */
void HighExecute__17AIHigh_BTC_AIPerp(AIHigh_BTC_AIPerp *self);   /* :620 */
void NewStage__17AIHigh_BTC_AIPerpP19AIHigh_BTC_HumanCop(AIHigh_BTC_AIPerp *self, AIHigh_BTC_HumanCop *chaserCop);   /* :807 */

#endif /* _GAME_COMMON_AIH_BTCPERP_H_ */
