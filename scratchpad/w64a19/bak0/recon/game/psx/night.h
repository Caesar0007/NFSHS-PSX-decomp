/* game/psx/night.h — reconstructed from game/psx/night.cpp (19 fns) */
#ifndef _GAME_PSX_NIGHT_H_
#define _GAME_PSX_NIGHT_H_
#include "../../nfs4_types.h"

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

#endif /* _GAME_PSX_NIGHT_H_ */
