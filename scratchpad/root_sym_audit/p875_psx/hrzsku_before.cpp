/* Frozen original recon/game/psx/hrzsku.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
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
void (*p875_probe_0)(DVECTOR *sc, DVECTOR *s0, DVECTOR *s1, int *percentage, int n, int bPercentageArray) = &Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii;
void (*p875_probe_1)(void) = &Sky_InitStars__Fv;
void (*p875_probe_2)(void) = &Sky_KillStars__Fv;
void (*p875_probe_3)(void) = &Hrz_InitSkyColor__Fv;
void (*p875_probe_4)(void) = &Hrz_InitSky__Fv;
void (*p875_probe_5)(void) = &Hrz_Init2DRing__Fv;
void (*p875_probe_6)(Draw_tPixMap *p) = &Hrz_GetHorizonPixMap__FP12Draw_tPixMap;
void (*p875_probe_7)(void) = &Hrz_InitHorizon__Fv;
void (*p875_probe_8)(void) = &Hrz_KillHorizon__Fv;
void (*p875_probe_9)(signed char direction, signed char column, signed char row) = &Hrz_LightningAddFork__FScScSc;
void (*p875_probe_10)(void) = &Hrz_CalculateLightning__Fv;
void (*p875_probe_11)(DVECTOR *pt, char type, char bright, Draw_DCache *sd) = &Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache;
void (*p875_probe_12)(DRender_tView *Vi) = &Hrz_SetLightingPosInSky__FP13DRender_tView;
void (*p875_probe_13)(Draw_DCache *sd) = &Hrz_BuildForkLightning__FP11Draw_DCache;
void (*p875_probe_14)(int on) = &Hrz_LightningFlicker__Fi;
void (*p875_probe_15)(matrixtdef *m) = &HrzSetPsxMatrix__FP10matrixtdef;
void (*p875_probe_16)(coorddef *t) = &HrzSetPsxTranslation__FP8coorddef;
void (*p875_probe_17)(int n, SVECTOR *s, int *z, DVECTOR *p) = &Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR;
void (*p875_probe_18)(int dither, int otz) = &Hrz_SetDitheringPrim__Fii;
void (*p875_probe_19)(void) = &Hrz_BuildSky__Fv;
void (*p875_probe_20)(Draw_SkyCache *sd, int otz) = &Sky_RenderStars__FP13Draw_SkyCachei;
void (*p875_probe_21)(DRender_tView *Vi) = &Hrz_BuildHorizon__FP13DRender_tView;
