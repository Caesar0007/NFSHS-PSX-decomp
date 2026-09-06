/* game/common/aihigh.h — reconstructed from game/common/aihigh.cpp, game/common/aihigh.h (22 fns) */
#ifndef _GAME_COMMON_AIHIGH_H_
#define _GAME_COMMON_AIHIGH_H_
#include "../../nfs4_types.h"

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

/* ---- header-defined (inline / class) functions ---- */

#endif /* _GAME_COMMON_AIHIGH_H_ */
