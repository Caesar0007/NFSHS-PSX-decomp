/* Frozen original recon/game/psx/force.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void Force_Vbl__Fv(void);   /* :61 */
void Force_Update__FP8Car_tObj(Car_tObj *car);   /* :105 */
void Force_StartUp__Fv(void);   /* :230 */
void Force_Disable__Fv(void);   /* :250 */
int Force_IsForceOn__FP8Car_tObj(Car_tObj *car);   /* :264 */
void Force_Pause__Fv(void);   /* :279 */
void Force_UnPause__Fv(void);   /* :291 */
void Force_HitSign__FP8Car_tObj(Car_tObj *car);   /* :298 */
void Force_HitWall__Fi(int impulse);   /* :301 */
void (*p875_probe_0)(void) = &Force_Vbl__Fv;
void (*p875_probe_1)(Car_tObj *car) = &Force_Update__FP8Car_tObj;
void (*p875_probe_2)(void) = &Force_StartUp__Fv;
void (*p875_probe_3)(void) = &Force_Disable__Fv;
int (*p875_probe_4)(Car_tObj *car) = &Force_IsForceOn__FP8Car_tObj;
void (*p875_probe_5)(void) = &Force_Pause__Fv;
void (*p875_probe_6)(void) = &Force_UnPause__Fv;
void (*p875_probe_7)(Car_tObj *car) = &Force_HitSign__FP8Car_tObj;
void (*p875_probe_8)(int impulse) = &Force_HitWall__Fi;
