/* game/common/aihigh.h — reconstructed from game/common/aihigh.cpp, game/common/aihigh.h (22 fns) */
#ifndef _GAME_COMMON_AIHIGH_H_
#define _GAME_COMMON_AIHIGH_H_
#include "../../nfs4_types.h"

void AIHigh_StartUp__Fv(void);   /* :58 */
void AIHigh_Restart1__Fv(void);   /* :110 */
void AIHigh_Restart2__Fv(void);   /* :115 */
void AIHigh_CleanUp__Fv(void);   /* :122 */
void AIHigh_Execute__Fv(void);   /* :134 */
void * __11AIHigh_BaseP8Car_tObj(AIHigh_Base *self, Car_tObj *carObj);   /* :158 */
void ___11AIHigh_Base(AIHigh_Base *self, int __in_chrg);   /* :169 */

/* ---- header-defined (inline / class) functions ---- */
void HighExecute__11AIHigh_None(AIHigh_None *self);   /* :132 */
void ___11AIHigh_None(AIHigh_None *self, int __in_chrg);   /* :134 */
void ___16AIHigh_BasicPerp(AIHigh_BasicPerp *self, int __in_chrg);   /* :164 */
void ___13AIHigh_Player(AIHigh_Player *self, int __in_chrg);   /* :202 */
void ___12AIHigh_Human(AIHigh_Human *self, int __in_chrg);   /* :219 */
void ___15AIHigh_Opponent(AIHigh_Opponent *self, int __in_chrg);   /* :242 */
void ___15AIHigh_BTC_Perp(AIHigh_BTC_Perp *self, int __in_chrg);   /* :267 */
// dup: void ___15AIHigh_BTC_Perp(AIHigh_BTC_Perp *self, int __in_chrg);   /* :267 */
void ___20AIHigh_BTC_HumanPerp(AIHigh_BTC_HumanPerp *self, int __in_chrg);   /* :281 */
void ___15AIHigh_BasicCop(AIHigh_BasicCop *self, int __in_chrg);   /* :414 */
void ___10AIHigh_Cop(AIHigh_Cop *self, int __in_chrg);   /* :448 */
void ___14AIHigh_BTC_Cop(AIHigh_BTC_Cop *self, int __in_chrg);   /* :471 */
void ___19AIHigh_BTC_HumanCop(AIHigh_BTC_HumanCop *self, int __in_chrg);   /* :527 */
void ___18AIHigh_BTC_Wingman(AIHigh_BTC_Wingman *self, int __in_chrg);   /* :548 */
void ___14AIHigh_Traffic(AIHigh_Traffic *self, int __in_chrg);   /* :584 */

#endif /* _GAME_COMMON_AIHIGH_H_ */
