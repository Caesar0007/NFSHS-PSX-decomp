/* game/common/aiinit.h — reconstructed from game/common/aiinit.cpp (17 fns) */
#ifndef _GAME_COMMON_AIINIT_H_
#define _GAME_COMMON_AIINIT_H_
#include "../../nfs4_types.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */

void AIInit_StartUp1(void);   /* :38 */
void AIInit_StartUp2(void);   /* :56 */
void AIInit_Reset1(void);   /* :87 */
void AIInit_Reset2(void);   /* :93 */
void AIInit_CleanUp1(void);   /* :130 */
void AIInit_CleanUp2(void);   /* :138 */
void AI_TrafficStartUp(void);   /* :170 */
void AI_TrafficCleanUp(void);   /* :195 */
void AIInit_LoadConfigs(void);   /* :225 */
void AIInit_LoadPhysicsConfig(Udff_tInfo *handle);   /* :257 */
void AIInit_ClearAICar(Car_tObj *carObj);   /* :304 */
void AIInit_RestartAICar(Car_tObj *carObj);   /* :326 */
void AIInit_InitAICar(Car_tObj *carObj, Udff_tInfo *handle);   /* :399 */
void AIInit_DeInitAICar(Car_tObj *carObj);   /* :466 */
void AIInit_InitAICar2(Car_tObj *carObj);   /* :480 */
void AIInit_DeInitAICar2(Car_tObj *carObj);   /* :498 */
int AIInit_IsNonStandardCarFile(int index);   /* :517 */

#endif /* _GAME_COMMON_AIINIT_H_ */
