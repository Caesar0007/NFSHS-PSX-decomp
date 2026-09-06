/* game/common/aiperson.h — reconstructed from game/common/aiperson.cpp (8 fns) */
#ifndef _GAME_COMMON_AIPERSON_H_
#define _GAME_COMMON_AIPERSON_H_
#include "../../nfs4_types.h"

/* P872: use the source names; C++ supplies the GCC-v2 linkage mangling. */
void AIPerson_LoadGridAndSetPersonalityIndexes(void);   /* :31 */
void AIPerson_SetPersonality(Car_tObj *carObj, int personalityIndex);   /* :79 */
void AIPerson_SetPersonalityPointers(void);   /* :112 */
void AIPerson_LoadPersonalityData(Udff_tInfo *handle);   /* :121 */
void AIPerson_LoadScriptData(Udff_tInfo *handle);   /* :208 */
void AIPerson_LoadGlue(Udff_tInfo *handle);   /* :449 */
void AIPerson_Startup(void);   /* :488 */
void AIPerson_Cleanup(void);   /* :541 */

#endif /* _GAME_COMMON_AIPERSON_H_ */
