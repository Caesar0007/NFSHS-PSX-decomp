/* game/common/aiperson.h — reconstructed from game/common/aiperson.cpp (8 fns) */
#ifndef _GAME_COMMON_AIPERSON_H_
#define _GAME_COMMON_AIPERSON_H_
#include "../../nfs4_types.h"

void AIPerson_LoadGridAndSetPersonalityIndexes__Fv(void);   /* :31 */
void AIPerson_SetPersonality__FP8Car_tObji(Car_tObj *carObj, int personalityIndex);   /* :79 */
void AIPerson_SetPersonalityPointers__Fv(void);   /* :112 */
void AIPerson_LoadPersonalityData__FP10Udff_tInfo(Udff_tInfo *handle);   /* :121 */
void AIPerson_LoadScriptData__FP10Udff_tInfo(Udff_tInfo *handle);   /* :208 */
void AIPerson_LoadGlue__FP10Udff_tInfo(Udff_tInfo *handle);   /* :449 */
void AIPerson_Startup__Fv(void);   /* :488 */
void AIPerson_Cleanup__Fv(void);   /* :541 */

#endif /* _GAME_COMMON_AIPERSON_H_ */
