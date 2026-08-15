/* game/common/trgsfx.h — reconstructed from game/common/trgsfx.cpp (11 fns) */
#ifndef _GAME_COMMON_TRGSFX_H_
#define _GAME_COMMON_TRGSFX_H_
#include "../../nfs4_types.h"

void TrgSfx_AddEnviroEffect__FiiP8coorddefT2(int obj, int type, coorddef *emitterpt, coorddef *vec);   /* :45 */
void TrgSfx_AddCarSfx__FiP8coorddefiT1(int car, coorddef *skidpt, int type, coorddef *vec);   /* :64 */
void TrgSfx_AddCarWheelSfx__FiiP8coorddefiT2i(int car, int wheel, coorddef *skidpt, int type, coorddef *vec, int delay);   /* :77 */
BOOL TrgSfx_AddCarExtraCheck__Fii(int car, int wheel);   /* :93 */
void TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii(int car, int wheel, coorddef *skidpt, int type, coorddef *vec, int velY, int ground, int colour);   /* :101 */
void TrgSfx_AddCarSplash__FiiP8coorddefiT2ii(int car, int wheel, coorddef *skidpt, int type, coorddef *vec, int delay, int velXZ);   /* :122 */
void TrgSfx_CrashCar__FP8coorddef(coorddef *location);   /* :146 */
void TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji(int car, int wheel, coorddef *skidpt, int end, int intensity, Car_tObj *carObj, int type);   /* :179 */
void TrgSfx_InitTrgSfx__Fv(void);   /* :286 */
void TrgSfx_RestartTrgSfx__Fv(void);   /* :316 */
void TrgSfx_KillTrgSfx__Fv(void);   /* :322 */

#endif /* _GAME_COMMON_TRGSFX_H_ */
