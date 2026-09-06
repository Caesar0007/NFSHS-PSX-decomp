/* Frozen original recon/game/psx/night.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
int Night_FindClosestColor__FG7CVECTORPi(CVECTOR colorMatch, int *bestIndex);   /* :134 */
void Night_CreateNightTableElement__FiliPUc(int colorIndex, long colorH, int bright, u_char *colorval);   /* :181 */
void Night_CreateNightTable__FiliPA256_A16_Uc(int colorIndex, long colorH, int bright, u_char *tbl[256][16]);   /* :236 */
void Night_GenerateNextLightningEvent__Fv(void);   /* :347 */
void Night_PauseLightningEffect__Fi(int player);   /* :381 */
void Night_DoLightningEffect__FP13DRender_tView(DRender_tView *Vi);   /* :423 */
void Night_SetCopColor__FP18GameSetup_tCarData(GameSetup_tCarData *carinfo);   /* :473 */
void Night_InitPlayerHeadLightColor__Fi(int player);   /* :488 */
void Night_SetPlayerHeadLightColor__Fiii(int player, int colorIndex, int bright);   /* :501 */
void Night_InitCopLightColors__Fv(void);   /* :507 */
void Night_SetCopLightColors__Fii(int colorIndex, int brighten);   /* :519 */
void Night_InitWeatherTables__Fv(void);   /* :532 */
void Night_SetWeatherColors__Fi(int colorIndex);   /* :544 */
void Night_GenerateAllLightTables__Fv(void);   /* :556 */
void Night_InitNightDriving__Fv(void);   /* :631 */
void Night_KillNightDriving__Fv(void);   /* :687 */
void Night_RestartNightDriving__Fv(void);   /* :723 */
void Night_SetEnviroment__FP13DRender_tView(DRender_tView *Vi);   /* :736 */
void Night_AdditiveNightCalc__FP6VECTORP7CVECTOR(VECTOR *v, CVECTOR *color);   /* :811 */
int (*p875_probe_0)(CVECTOR colorMatch, int *bestIndex) = &Night_FindClosestColor__FG7CVECTORPi;
void (*p875_probe_1)(int colorIndex, long colorH, int bright, u_char *colorval) = &Night_CreateNightTableElement__FiliPUc;
void (*p875_probe_2)(int colorIndex, long colorH, int bright, u_char *tbl[256][16]) = &Night_CreateNightTable__FiliPA256_A16_Uc;
void (*p875_probe_3)(void) = &Night_GenerateNextLightningEvent__Fv;
void (*p875_probe_4)(int player) = &Night_PauseLightningEffect__Fi;
void (*p875_probe_5)(DRender_tView *Vi) = &Night_DoLightningEffect__FP13DRender_tView;
void (*p875_probe_6)(GameSetup_tCarData *carinfo) = &Night_SetCopColor__FP18GameSetup_tCarData;
void (*p875_probe_7)(int player) = &Night_InitPlayerHeadLightColor__Fi;
void (*p875_probe_8)(int player, int colorIndex, int bright) = &Night_SetPlayerHeadLightColor__Fiii;
void (*p875_probe_9)(void) = &Night_InitCopLightColors__Fv;
void (*p875_probe_10)(int colorIndex, int brighten) = &Night_SetCopLightColors__Fii;
void (*p875_probe_11)(void) = &Night_InitWeatherTables__Fv;
void (*p875_probe_12)(int colorIndex) = &Night_SetWeatherColors__Fi;
void (*p875_probe_13)(void) = &Night_GenerateAllLightTables__Fv;
void (*p875_probe_14)(void) = &Night_InitNightDriving__Fv;
void (*p875_probe_15)(void) = &Night_KillNightDriving__Fv;
void (*p875_probe_16)(void) = &Night_RestartNightDriving__Fv;
void (*p875_probe_17)(DRender_tView *Vi) = &Night_SetEnviroment__FP13DRender_tView;
void (*p875_probe_18)(VECTOR *v, CVECTOR *color) = &Night_AdditiveNightCalc__FP6VECTORP7CVECTOR;
