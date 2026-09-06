/* game/common/aitune.h — reconstructed from game/common/aitune.cpp (7 fns) */
#ifndef _GAME_COMMON_AITUNE_H_
#define _GAME_COMMON_AITUNE_H_
#include "../../nfs4_types.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */

int AITune_GetOneWay(void);   /* :103 */
int AITune_GetDriveSide(void);   /* :111 */
int AITune_GetRoughLapTimes(void);   /* :119 */
void AITune_StartUp1(void);   /* :128 */
void AITune_StartUp2(void);   /* :138 */
void AITune_CleanUp1(void);   /* :142 */
void AITune_CleanUp2(void);   /* :146 */

#endif /* _GAME_COMMON_AITUNE_H_ */
