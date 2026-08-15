/* game/psx/weather.h — reconstructed from game/psx/weather.cpp (25 fns) */
#ifndef _GAME_PSX_WEATHER_H_
#define _GAME_PSX_WEATHER_H_
#include "../../nfs4_types.h"

int Weather_GetNumParticles__Fi(int player);   /* :107 */
void Weather_SetMatrix__FP10matrixtdef(matrixtdef *m);   /* :112 */
void Weather_SetIdentMatrix__Fv(void);   /* :127 */
void Weather_InitSnow__Fv(void);   /* :150 */
void Weather_InitRain__Fv(void);   /* :166 */
void Weather_InitSplats__Fv(void);   /* :182 */
int Weather_GetNewState__Fv(void);   /* :238 */
void Weather_ChangeDensityState__Fv(void);   /* :253 */
void Weather_ChangeIntensityState__Fv(void);   /* :273 */
void Weather_ChangeDensityBasedOnTime__Fv(void);   /* :296 */
void Weather_ChangeIntensityBasedOnTime__Fv(void);   /* :323 */
void Weather_InitStateControls__Fv(void);   /* :355 */
void Weather_Restart__Fv(void);   /* :391 */
void Weather_Init__Fv(void);   /* :414 */
void Weather_DeInit__Fv(void);   /* :501 */
void Weather_TransformVertex__FP10matrixtdefiP7SVECTOR(matrixtdef *m, int n, SVECTOR *s);   /* :581 */
short Weather_CheckAndResetParticles__FP7SVECTOR(SVECTOR *pt);   /* :623 */
void Weather_QuickReOrthogonalize__FP10matrixtdefT0(matrixtdef *rot, matrixtdef *rotNew);   /* :673 */
void Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc(DRender_tView *Vi, int num, SVECTOR *wpt, char *wd);   /* :704 */
void Weather_CreateSnow__FP7SVECTOR(SVECTOR *pt);   /* :923 */
void Weather_CreateRain__FP7SVECTORP7DVECTORPc(SVECTOR *pt0, DVECTOR *pt1, char *wd);   /* :967 */
void Weather_CreateSplat__FP18Weather_tSplatInfo(Weather_tSplatInfo *splat);   /* :1009 */
void Weather_DoSplats__FiP18Weather_tSplatInfo(int num, Weather_tSplatInfo *splats);   /* :1039 */
void Weather_DoWeather__FP13DRender_tView(DRender_tView *Vi);   /* :1069 */
void Weather_BuildWeather__FP13DRender_tView(DRender_tView *Vi);   /* :1159 */

#endif /* _GAME_PSX_WEATHER_H_ */
