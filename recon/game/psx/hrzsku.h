/* game/psx/hrzsku.h — reconstructed from game/psx/hrzsku.cpp (22 fns) */
#ifndef _GAME_PSX_HRZSKU_H_
#define _GAME_PSX_HRZSKU_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void Horizon_InterpolateLineSCoords(DVECTOR * sc,DVECTOR * s0,DVECTOR * s1,int * percentage,int n,int bPercentageArray);   /* SYM 40d7e5 @0x800cf574 */
void Sky_InitStars(void);   /* SYM 40d824 @0x800cf6b4 */
void Sky_KillStars(void);   /* SYM 40d843 @0x800cf89c */
void Hrz_InitSkyColor(void);   /* SYM 40d862 @0x800cf8e0 */
void Hrz_InitSky(void);   /* SYM 40d884 @0x800cfa3c */
void Hrz_Init2DRing(void);   /* SYM 40d8a1 @0x800cfd80 */
void Hrz_GetHorizonPixMap(Draw_tPixMap * p);   /* SYM 40d8c1 @0x800d0064 */
void Hrz_InitHorizon(void);   /* SYM 40d8f5 @0x800d0118 */
void Hrz_KillHorizon(void);   /* SYM 40d916 @0x800d0184 */
void Hrz_LightningAddFork(signed char direction,signed char column,signed char row);   /* SYM 40d937 @0x800d01b0 */
void Hrz_CalculateLightning(void);   /* SYM 40d962 @0x800d03c8 */
void Hrz_TextureQuad(DVECTOR * pt,char type,char bright,Draw_DCache * sd);   /* SYM 40d98a @0x800d0404 */
void Hrz_SetLightingPosInSky(DRender_tView * Vi);   /* SYM 40d9c3 @0x800d0534 */
void Hrz_BuildForkLightning(Draw_DCache * sd);   /* SYM 40d9fb @0x800d0644 */
void Hrz_LightningFlicker(int on);   /* SYM 40da30 @0x800d0760 */
void HrzSetPsxMatrix(matrixtdef * m);   /* SYM 40da56 @0x800d083c */
void HrzSetPsxTranslation(coorddef * t);   /* SYM 40da83 @0x800d091c */
void Hrz_RotProj16(int n,SVECTOR * s,int * z,DVECTOR * p);   /* SYM 40dab2 @0x800d096c */
void Hrz_SetDitheringPrim(int dither,int otz);   /* SYM 40dae5 @0x800d09b0 */
void Hrz_BuildSky(void);   /* SYM 40db0c @0x800d0a38 */
void Sky_RenderStars(Draw_SkyCache * sd,int otz);   /* SYM 40db2a @0x800d1160 */
void Hrz_BuildHorizon(DRender_tView * Vi);   /* SYM 40db5b @0x800d131c */

#endif /* _GAME_PSX_HRZSKU_H_ */
