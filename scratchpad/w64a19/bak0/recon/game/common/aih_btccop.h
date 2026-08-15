/* game/common/aih_btccop.h — reconstructed from game/common/aih_btccop.cpp (33 fns) */
#ifndef _GAME_COMMON_AIH_BTCCOP_H_
#define _GAME_COMMON_AIH_BTCCOP_H_
#include "../../nfs4_types.h"

void * __14AIHigh_BTC_CopP8Car_tObji(AIHigh_BTC_Cop *self, Car_tObj *carObj, int copIndex);   /* :107 */
void AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp(AIHigh_BTC_Cop *self, AIHigh_BTC_Perp *target);   /* :115 */
int GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef(AIHigh_BTC_Cop *self, coorddef *pos);   /* :130 */
int CheckForNewTarget__14AIHigh_BTC_Cop(AIHigh_BTC_Cop *self);   /* :154 */
void StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp(AIHigh_BTC_Cop *self, AIHigh_BTC_Perp *arrestMe);   /* :213 */
void FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp(AIHigh_BTC_Cop *self, AIHigh_BTC_Perp *arrestMe);   /* :253 */
void FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp(AIHigh_BTC_Cop *self, AIHigh_BTC_Perp *cantArrestMe);   /* :283 */
void FreezeAndEndChase__14AIHigh_BTC_Cop(AIHigh_BTC_Cop *self);   /* :296 */
void HudOff__14AIHigh_BTC_Cop(AIHigh_BTC_Cop *self);   /* :305 */
void * __19AIHigh_BTC_HumanCopP8Car_tObji(AIHigh_BTC_HumanCop *self, Car_tObj *carObj, int copIndex);   /* :326 */
int FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii(AIHigh_BTC_HumanCop *self, int startSlice, int safetyZone, int randomDistance);   /* :379 */
void ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp(AIHigh_BTC_HumanCop *self, AIHigh_BTC_Perp *newPerp);   /* :399 */
void FreezeAndEndChase__19AIHigh_BTC_HumanCop(AIHigh_BTC_HumanCop *self);   /* :425 */
void CheckConditionWithCop0__19AIHigh_BTC_HumanCop(AIHigh_BTC_HumanCop *self);   /* :461 */
void NewStage__19AIHigh_BTC_HumanCopiii(AIHigh_BTC_HumanCop *self, int copSlice, int direction, int movement);   /* :490 */
void UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop(AIHigh_BTC_HumanCop *self);   /* :624 */
void UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop(AIHigh_BTC_HumanCop *self);   /* :692 */
void RequestWingman__19AIHigh_BTC_HumanCop(AIHigh_BTC_HumanCop *self);   /* :727 */
void RequestBlockader__19AIHigh_BTC_HumanCopi(AIHigh_BTC_HumanCop *self, int spikeBeltRequest);   /* :752 */
int CheckForWingmanRequest__19AIHigh_BTC_HumanCop(AIHigh_BTC_HumanCop *self);   /* :785 */
int CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi(AIHigh_BTC_HumanCop *self, int *spikeBeltRequest);   /* :794 */
void UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role(AIHigh_BTC_HumanCop *self, int currentRole);   /* :812 */
void ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop(AIHigh_BTC_HumanCop *self);   /* :832 */
void ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop(AIHigh_BTC_HumanCop *self);   /* :842 */
void SetDesiredSpeed__19AIHigh_BTC_HumanCop(AIHigh_BTC_HumanCop *self);   /* :854 */
void HighExecute__19AIHigh_BTC_HumanCop(AIHigh_BTC_HumanCop *self);   /* :863 */
void HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj(AIHigh_BTC_HumanCop *self, AIHigh_BTC_Perp *arrestMe, int gameOver, Car_tObj *arrestingCop);   /* :938 */
void * __18AIHigh_BTC_WingmanP8Car_tObji(AIHigh_BTC_Wingman *self, Car_tObj *carObj, int copIndex);   /* :964 */
void HighExecute__18AIHigh_BTC_Wingman(AIHigh_BTC_Wingman *self);   /* :976 */
int CheckForActivation__18AIHigh_BTC_Wingman(AIHigh_BTC_Wingman *self);   /* :1270 */
int UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman(AIHigh_BTC_Wingman *self);   /* :1311 */
void SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop(AIHigh_BTC_Wingman *self, AIHigh_BTC_HumanCop *humanCop);   /* :1334 */
void SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi(AIHigh_BTC_Wingman *self, AIHigh_BTC_HumanCop *humanCop, int spikeBeltRequest);   /* :1352 */

#endif /* _GAME_COMMON_AIH_BTCCOP_H_ */
