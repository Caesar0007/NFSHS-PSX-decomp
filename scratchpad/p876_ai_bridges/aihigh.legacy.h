/* game/common/aihigh.h — reconstructed from game/common/aihigh.cpp, game/common/aihigh.h (22 fns) */
#ifndef _GAME_COMMON_AIHIGH_H_
#define _GAME_COMMON_AIHIGH_H_
#include "nfs4_types.before.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */
/* P875: class methods/constructors are already exposed by the included type
   surface; redundant encoded non-member declarations were removed after
   native-symbol and canonical-member probes. Remaining ABI-spelled destructor
   or static-member declarations are retained for separate linkage review. */

void AIHigh_StartUp(void);   /* :58 */
void AIHigh_Restart1(void);   /* :110 */
void AIHigh_Restart2(void);   /* :115 */
void AIHigh_CleanUp(void);   /* :122 */
void AIHigh_Execute(void);   /* :134 */
void ___11AIHigh_Base(AIHigh_Base *self, int __in_chrg);   /* :169 */

/* ---- header-defined (inline / class) functions ---- */
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
