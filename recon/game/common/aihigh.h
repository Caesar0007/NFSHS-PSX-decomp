/* game/common/aihigh.h — reconstructed from game/common/aihigh.cpp, game/common/aihigh.h (22 fns) */
#ifndef _GAME_COMMON_AIHIGH_H_
#define _GAME_COMMON_AIHIGH_H_
#include "../../nfs4_types.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */
/* P876: native members, static members and destructors are exposed by the
   included C++ classes. Removed encoded non-member declarations that either
   emitted nonexistent double-mangled exports or hid a real static member.
   Native-reference and shared-header regression receipts: scratchpad/p876_ai_bridges. */

void AIHigh_StartUp(void);   /* :58 */
void AIHigh_Restart1(void);   /* :110 */
void AIHigh_Restart2(void);   /* :115 */
void AIHigh_CleanUp(void);   /* :122 */
void AIHigh_Execute(void);   /* :134 */

#endif /* _GAME_COMMON_AIHIGH_H_ */
