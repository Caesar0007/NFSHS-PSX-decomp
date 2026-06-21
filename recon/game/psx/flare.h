/* game/psx/flare.h — reconstructed from game/psx/flare.cpp (27 fns) */
#ifndef _GAME_PSX_FLARE_H_
#define _GAME_PSX_FLARE_H_
#include "../../nfs4_types.h"

void Flare_Tri__FPlN20i(long *cp, long *p1, long *p2, int otz);   /* :75 */
void Flare_SetMatrix__FP10matrixtdef(matrixtdef *m);   /* :184 */
void Flare_IdentMatrix__FP6MATRIX(MATRIX *mtx);   /* :196 */
void Flare_OctFlare__FPli(long *center, int otz);   /* :208 */
void Flare_OctFlareSpikes__FPli(long *center, int otz);   /* :247 */
void Flare_Spikes__FPli(long *center, int otz);   /* :323 */
void Flare_HexFlare__FPli(long *center, int otz);   /* :370 */
void Flare_ReflectHexFlare__FPli(long *center, int otz);   /* :407 */
void Flare_QuadFlare__FPli(long *center, int otz);   /* :443 */
void Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache(int type, COORD16 *ptCenter, COORD16 *pt1, COORD16 *pt2, int flag, int otz, Draw_FlareCache *sd);   /* :591 */
void Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache(DRender_tView *Vi, int scale, int type, coorddef *fpt, coorddef *fpt2, Draw_FlareCache *arg5);   /* :845 */
void Flare_Halo__FP13DRender_tViewiiP8coorddefP15Draw_FlareCache(DRender_tView *Vi, int scale, int type, coorddef *fpt, Draw_FlareCache *sd);   /* :1097 */
void Flare_2DSpike__FPlT0i(long *center, long *end, int otz);   /* :1105 */
void Flare_2DHalo__Fiiiii(int x, int y, int scalex, int scaley, int type);   /* :1125 */
void Flare_PreCalcHexLightBeam__FPli(long *center, int otz);   /* :1229 */
void Flare_Quad__FPlP7CVECTORi(long *pt, CVECTOR *color, int otz);   /* :1305 */
void Flare_QuadNotTransparent__FPlP7CVECTORi(long *pt, CVECTOR *color, int otz);   /* :1319 */
void Flare_QuadRing__FPlP7CVECTORi(long *pt, CVECTOR *color, int otz);   /* :1335 */
void Flare_TextureQuad__FPlP7CVECTORci(long *pt, CVECTOR *color, char type, int otz);   /* :1368 */
void Flare_SingleColorTex__FP7DVECTORP7CVECTORiici(DVECTOR *xy, CVECTOR *color, int width, int height, int type, int otz);   /* :1386 */
void Flare_SingleColorHex__FP7DVECTORP7CVECTORiii(DVECTOR *xy, CVECTOR *color, int width, int height, int otz);   /* :1405 */
void Flare_SingleColorOct__FP7DVECTORP7CVECTORiii(DVECTOR *xy, CVECTOR *color, int width, int height, int otz);   /* :1443 */
void Flare_SingleColorOctRing__FP7DVECTORP7CVECTORiii(DVECTOR *xy, CVECTOR *color, int width, int height, int otz);   /* :1460 */
void Flare_InitLensFlare__Fv(void);   /* :1568 */
void Flare_LensFlare__FP7DVECTORP15Draw_FlareCache(DVECTOR *screenPos, Draw_FlareCache *sd);   /* :1578 */
void Flare_Sun__FP7SVECTORP15Draw_FlareCache(SVECTOR *worldPos, Draw_FlareCache *sd);   /* :1742 */
void Flare_Moon__FP7SVECTORP15Draw_FlareCache(SVECTOR *worldPos, Draw_FlareCache *sd);   /* :1822 */

#endif /* _GAME_PSX_FLARE_H_ */
