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

/* ---- header-defined (inline / class) functions ---- */

#endif /* _GAME_COMMON_AISTATE_H_ */
