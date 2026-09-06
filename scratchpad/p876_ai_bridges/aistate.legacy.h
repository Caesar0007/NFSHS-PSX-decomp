/* game/common/aistate.h — reconstructed from game/common/aistate.cpp, game/common/aistate.h (64 fns) */
#ifndef _GAME_COMMON_AISTATE_H_
#define _GAME_COMMON_AISTATE_H_
#include "nfs4_types.before.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */
/* P875: class methods/constructors are already exposed by the included type
   surface; redundant encoded non-member declarations were removed after
   native-symbol and canonical-member probes. Remaining ABI-spelled destructor
   or static-member declarations are retained for separate linkage review. */

void AIState_StartUp(void);   /* :25 */
void AIState_Restart(void);   /* :30 */
void AIState_CleanUp(void);   /* :36 */
void ___13AIState_Chase(AIState_Chase *self, int __in_chrg);   /* :205 */
void ___15AIState_Offroad(AIState_Offroad *self, int __in_chrg);   /* :887 */
void ___17AIState_Purgatory(AIState_Purgatory *self, int __in_chrg);   /* :1021 */
void StartUp__17AIState_Purgatory(void);   /* :1090 */
void ___14AIState_Donuts(AIState_Donuts *self, int __in_chrg);   /* :1248 */

/* ---- header-defined (inline / class) functions ---- */
void ___12AIState_Base(AIState_Base *self, int __in_chrg);   /* :24 */
// dup: void ___12AIState_Base(AIState_Base *self, int __in_chrg);   /* :24 */
// dup: void ___12AIState_Base(AIState_Base *self, int __in_chrg);   /* :24 */
// dup: void ___12AIState_Base(AIState_Base *self, int __in_chrg);   /* :24 */
void ___12AIState_None(AIState_None *self, int __in_chrg);   /* :34 */
void ___14AIState_Normal(AIState_Normal *self, int __in_chrg);   /* :45 */
void ___12AIState_Idle(AIState_Idle *self, int __in_chrg);   /* :58 */
void ___17AIState_NonActive(AIState_NonActive *self, int __in_chrg);   /* :170 */
// dup: void ___17AIState_NonActive(AIState_NonActive *self, int __in_chrg);   /* :170 */
// dup: void ___17AIState_NonActive(AIState_NonActive *self, int __in_chrg);   /* :170 */
void ___21AIState_RovingTraffic(AIState_RovingTraffic *self, int __in_chrg);   /* :204 */
void ___17AIState_GotoSlice(AIState_GotoSlice *self, int __in_chrg);   /* :238 */
void ___14AIState_Cruise(AIState_Cruise *self, int __in_chrg);   /* :262 */

#endif /* _GAME_COMMON_AISTATE_H_ */
