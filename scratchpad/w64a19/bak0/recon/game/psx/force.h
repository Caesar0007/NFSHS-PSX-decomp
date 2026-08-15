/* game/psx/force.h — reconstructed from game/psx/force.cpp (9 fns) */
#ifndef _GAME_PSX_FORCE_H_
#define _GAME_PSX_FORCE_H_
#include "../../nfs4_types.h"

void Force_Vbl__Fv(void);   /* :61 */
void Force_Update__FP8Car_tObj(Car_tObj *car);   /* :105 */
void Force_StartUp__Fv(void);   /* :230 */
void Force_Disable__Fv(void);   /* :250 */
int Force_IsForceOn__FP8Car_tObj(Car_tObj *car);   /* :264 */
void Force_Pause__Fv(void);   /* :279 */
void Force_UnPause__Fv(void);   /* :291 */
void Force_HitSign__FP8Car_tObj(Car_tObj *car);   /* :298 */
void Force_HitWall__Fi(int impulse);   /* :301 */

#endif /* _GAME_PSX_FORCE_H_ */
