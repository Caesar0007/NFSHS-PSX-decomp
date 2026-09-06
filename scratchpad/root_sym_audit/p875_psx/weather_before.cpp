/* Frozen original recon/game/psx/weather.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
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
int (*p875_probe_0)(int player) = &Weather_GetNumParticles__Fi;
void (*p875_probe_1)(matrixtdef *m) = &Weather_SetMatrix__FP10matrixtdef;
void (*p875_probe_2)(void) = &Weather_SetIdentMatrix__Fv;
void (*p875_probe_3)(void) = &Weather_InitSnow__Fv;
void (*p875_probe_4)(void) = &Weather_InitRain__Fv;
void (*p875_probe_5)(void) = &Weather_InitSplats__Fv;
int (*p875_probe_6)(void) = &Weather_GetNewState__Fv;
void (*p875_probe_7)(void) = &Weather_ChangeDensityState__Fv;
void (*p875_probe_8)(void) = &Weather_ChangeIntensityState__Fv;
void (*p875_probe_9)(void) = &Weather_ChangeDensityBasedOnTime__Fv;
void (*p875_probe_10)(void) = &Weather_ChangeIntensityBasedOnTime__Fv;
void (*p875_probe_11)(void) = &Weather_InitStateControls__Fv;
void (*p875_probe_12)(void) = &Weather_Restart__Fv;
void (*p875_probe_13)(void) = &Weather_Init__Fv;
void (*p875_probe_14)(void) = &Weather_DeInit__Fv;
void (*p875_probe_15)(matrixtdef *m, int n, SVECTOR *s) = &Weather_TransformVertex__FP10matrixtdefiP7SVECTOR;
short (*p875_probe_16)(SVECTOR *pt) = &Weather_CheckAndResetParticles__FP7SVECTOR;
void (*p875_probe_17)(matrixtdef *rot, matrixtdef *rotNew) = &Weather_QuickReOrthogonalize__FP10matrixtdefT0;
void (*p875_probe_18)(DRender_tView *Vi, int num, SVECTOR *wpt, char *wd) = &Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc;
void (*p875_probe_19)(SVECTOR *pt) = &Weather_CreateSnow__FP7SVECTOR;
void (*p875_probe_20)(SVECTOR *pt0, DVECTOR *pt1, char *wd) = &Weather_CreateRain__FP7SVECTORP7DVECTORPc;
void (*p875_probe_21)(Weather_tSplatInfo *splat) = &Weather_CreateSplat__FP18Weather_tSplatInfo;
void (*p875_probe_22)(int num, Weather_tSplatInfo *splats) = &Weather_DoSplats__FiP18Weather_tSplatInfo;
void (*p875_probe_23)(DRender_tView *Vi) = &Weather_DoWeather__FP13DRender_tView;
void (*p875_probe_24)(DRender_tView *Vi) = &Weather_BuildWeather__FP13DRender_tView;
