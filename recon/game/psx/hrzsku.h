/* game/psx/hrzsku.h — reconstructed from game/psx/hrzsku.cpp (22 fns) */
#ifndef _GAME_PSX_HRZSKU_H_
#define _GAME_PSX_HRZSKU_H_
#include "../../nfs4_types.h"

void Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii(DVECTOR *sc, DVECTOR *s0, DVECTOR *s1, int *percentage, int n, int bPercentageArray);   /* :128 */
void Sky_InitStars__Fv(void);   /* :185 */
void Sky_KillStars__Fv(void);   /* :216 */
void Hrz_InitSkyColor__Fv(void);   /* :227 */
void Hrz_InitSky__Fv(void);   /* :257 */
void Hrz_Init2DRing__Fv(void);   /* :337 */
void Hrz_GetHorizonPixMap__FP12Draw_tPixMap(Draw_tPixMap *p);   /* :419 */
void Hrz_InitHorizon__Fv(void);   /* :432 */
void Hrz_KillHorizon__Fv(void);   /* :447 */
void Hrz_LightningAddFork__FScScSc(signed char direction, signed char column, signed char row);   /* :783 */
void Hrz_CalculateLightning__Fv(void);   /* :826 */
void Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache(DVECTOR *pt, char type, char bright, Draw_DCache *sd);   /* :833 */
void Hrz_SetLightingPosInSky__FP13DRender_tView(DRender_tView *Vi);   /* :862 */
void Hrz_BuildForkLightning__FP11Draw_DCache(Draw_DCache *sd);   /* :872 */
void Hrz_LightningFlicker__Fi(int on);   /* :901 */
void HrzSetPsxMatrix__FP10matrixtdef(matrixtdef *m);   /* :982 */
void HrzSetPsxTranslation__FP8coorddef(coorddef *t);   /* :1021 */
void Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR(int n, SVECTOR *s, int *z, DVECTOR *p);   /* :1032 */
void Hrz_SetDitheringPrim__Fii(int dither, int otz);   /* :1050 */
void Hrz_BuildSky__Fv(void);   /* :1060 */
void Sky_RenderStars__FP13Draw_SkyCachei(Draw_SkyCache *sd, int otz);   /* :1284 */
void Hrz_BuildHorizon__FP13DRender_tView(DRender_tView *Vi);   /* :1338 */

#endif /* _GAME_PSX_HRZSKU_H_ */
