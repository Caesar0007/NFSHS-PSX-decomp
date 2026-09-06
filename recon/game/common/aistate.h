/* game/common/aistate.h — reconstructed from game/common/aistate.cpp, game/common/aistate.h (64 fns) */
#ifndef _GAME_COMMON_AISTATE_H_
#define _GAME_COMMON_AISTATE_H_
#include "../../nfs4_types.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */
/* P876: native members, static members and destructors are exposed by the
   included C++ classes. Removed encoded non-member declarations that either
   emitted nonexistent double-mangled exports or hid a real static member.
   Native-reference and shared-header regression receipts: scratchpad/p876_ai_bridges. */

void AIState_StartUp(void);   /* :25 */
void AIState_Restart(void);   /* :30 */
void AIState_CleanUp(void);   /* :36 */

#endif /* _GAME_COMMON_AISTATE_H_ */
