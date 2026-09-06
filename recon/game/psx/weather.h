/* game/psx/weather.h — reconstructed from game/psx/weather.cpp (25 fns) */
#ifndef _GAME_PSX_WEATHER_H_
#define _GAME_PSX_WEATHER_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

int Weather_GetNumParticles(int player);   /* SYM 486ee5 @0x800e1dc0 */
void Weather_SetMatrix(matrixtdef * m);   /* SYM 486f0e @0x800e1dd0 */
void Weather_SetIdentMatrix(void);   /* SYM 486f3d @0x800e1e94 */
void Weather_InitSnow(void);   /* SYM 486f65 @0x800e1f18 */
void Weather_InitRain(void);   /* SYM 486f87 @0x800e1f78 */
void Weather_InitSplats(void);   /* SYM 486fa9 @0x800e1fd8 */
int Weather_GetNewState(void);   /* SYM 486fcd @0x800e20ec */
void Weather_ChangeDensityState(void);   /* SYM 486ff2 @0x800e212c */
void Weather_ChangeIntensityState(void);   /* SYM 48701e @0x800e21a0 */
void Weather_ChangeDensityBasedOnTime(void);   /* SYM 48704c @0x800e2218 */
void Weather_ChangeIntensityBasedOnTime(void);   /* SYM 48707e @0x800e22f0 */
void Weather_InitStateControls(void);   /* SYM 4870b2 @0x800e23e8 */
void Weather_Restart(void);   /* SYM 4870dd @0x800e24b4 */
void Weather_Init(void);   /* SYM 4870fe @0x800e2530 */
void Weather_DeInit(void);   /* SYM 48711c @0x800e287c */
void Weather_TransformVertex(matrixtdef * m,int n,SVECTOR * s);   /* SYM 48713c @0x800e2910 */
short Weather_CheckAndResetParticles(SVECTOR * pt);   /* SYM 48717b @0x800e29d4 */
void Weather_QuickReOrthogonalize(matrixtdef * rot,matrixtdef * rotNew);   /* SYM 4871b3 @0x800e2d50 */
void Weather_ProcessParticles(DRender_tView * Vi,int num,SVECTOR * wpt,char * wd);   /* SYM 4871ef @0x800e2fd0 */
void Weather_CreateSnow(SVECTOR * pt);   /* SYM 487234 @0x800e33bc */
void Weather_CreateRain(SVECTOR * pt0,DVECTOR * pt1,char * wd);   /* SYM 487260 @0x800e356c */
void Weather_CreateSplat(Weather_tSplatInfo * splat);   /* SYM 487297 @0x800e3730 */
void Weather_DoSplats(int num,Weather_tSplatInfo * splats);   /* SYM 4872d0 @0x800e3858 */
void Weather_DoWeather(DRender_tView * Vi);   /* SYM 487307 @0x800e3a1c */
void Weather_BuildWeather(DRender_tView * Vi);   /* SYM 487339 @0x800e3d30 */

#endif /* _GAME_PSX_WEATHER_H_ */
