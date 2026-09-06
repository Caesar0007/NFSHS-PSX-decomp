/* game/common/trgsfx.h — reconstructed from game/common/trgsfx.cpp (11 fns) */
#ifndef _GAME_COMMON_TRGSFX_H_
#define _GAME_COMMON_TRGSFX_H_
#include "../../nfs4_types.h"

/* P875: native source names/signatures; C++ supplies linkage mangling.
 * File-private functions stay in the implementation; class members remain
 * exposed by the included types without duplicate free declarations. */

void TrgSfx_AddEnviroEffect(int obj,int type,coorddef *emitterpt,coorddef *vec);   /* :45 */
void TrgSfx_AddCarSfx(int car,coorddef *skidpt,int type,coorddef *vec);   /* :64 */
void TrgSfx_AddCarWheelSfx(int car,int wheel,coorddef *skidpt,int type,coorddef *vec,int delay);   /* :77 */
bool TrgSfx_AddCarExtraCheck(int car,int wheel);   /* :93 */
void TrgSfx_AddCarExtraSfx(int car,int wheel,coorddef *skidpt,int type,coorddef *vec,int velY,int ground, int colour);   /* :101 */
void TrgSfx_AddCarSplash(int car,int wheel,coorddef *skidpt,int type,coorddef *vec,int delay,int velXZ);   /* :122 */
void TrgSfx_CrashCar(coorddef *location);   /* :146 */
void TrgSfx_AddSkidmark(int car,int wheel,coorddef *skidpt,int end,int intensity,Car_tObj *carObj,int type);   /* :179 */
void TrgSfx_InitTrgSfx(void);   /* :286 */
void TrgSfx_RestartTrgSfx(void);   /* :316 */
void TrgSfx_KillTrgSfx(void);   /* :322 */

#endif /* _GAME_COMMON_TRGSFX_H_ */
