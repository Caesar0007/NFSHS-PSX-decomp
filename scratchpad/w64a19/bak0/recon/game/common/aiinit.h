/* game/common/aiinit.h — reconstructed from game/common/aiinit.cpp (17 fns) */
#ifndef _GAME_COMMON_AIINIT_H_
#define _GAME_COMMON_AIINIT_H_
#include "../../nfs4_types.h"

void AIInit_StartUp1__Fv(void);   /* :38 */
void AIInit_StartUp2__Fv(void);   /* :56 */
void AIInit_Reset1__Fv(void);   /* :87 */
void AIInit_Reset2__Fv(void);   /* :93 */
void AIInit_CleanUp1__Fv(void);   /* :130 */
void AIInit_CleanUp2__Fv(void);   /* :138 */
void AI_TrafficStartUp__Fv(void);   /* :170 */
void AI_TrafficCleanUp__Fv(void);   /* :195 */
void AIInit_LoadConfigs__Fv(void);   /* :225 */
void AIInit_LoadPhysicsConfig__FP10Udff_tInfo(Udff_tInfo *handle);   /* :257 */
void AIInit_ClearAICar__FP8Car_tObj(Car_tObj *carObj);   /* :304 */
void AIInit_RestartAICar__FP8Car_tObj(Car_tObj *carObj);   /* :326 */
void AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo(Car_tObj *carObj, Udff_tInfo *handle);   /* :399 */
void AIInit_DeInitAICar__FP8Car_tObj(Car_tObj *carObj);   /* :466 */
void AIInit_InitAICar2__FP8Car_tObj(Car_tObj *carObj);   /* :480 */
void AIInit_DeInitAICar2__FP8Car_tObj(Car_tObj *carObj);   /* :498 */
int AIInit_IsNonStandardCarFile__Fi(int index);   /* :517 */

#endif /* _GAME_COMMON_AIINIT_H_ */
