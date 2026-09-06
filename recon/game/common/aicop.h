/* game/common/aicop.h — reconstructed from game/common/aicop.cpp (4 fns) */
#ifndef _GAME_COMMON_AICOP_H_
#define _GAME_COMMON_AICOP_H_
#include "../../nfs4_types.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */

void AICop_StartUp(void);   /* :107 */
void AICop_Restart(void);   /* :142 */
void AICop_CleanUp(void);   /* :158 */
int AICop_NoCopsInArea(int slice, int sliceDistance);   /* :173 */

#endif /* _GAME_COMMON_AICOP_H_ */
