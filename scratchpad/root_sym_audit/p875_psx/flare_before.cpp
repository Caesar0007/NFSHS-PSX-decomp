/* Frozen original recon/game/psx/flare.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
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
void (*p875_probe_0)(long *cp, long *p1, long *p2, int otz) = &Flare_Tri__FPlN20i;
void (*p875_probe_1)(matrixtdef *m) = &Flare_SetMatrix__FP10matrixtdef;
void (*p875_probe_2)(MATRIX *mtx) = &Flare_IdentMatrix__FP6MATRIX;
void (*p875_probe_3)(long *center, int otz) = &Flare_OctFlare__FPli;
void (*p875_probe_4)(long *center, int otz) = &Flare_OctFlareSpikes__FPli;
void (*p875_probe_5)(long *center, int otz) = &Flare_Spikes__FPli;
void (*p875_probe_6)(long *center, int otz) = &Flare_HexFlare__FPli;
void (*p875_probe_7)(long *center, int otz) = &Flare_ReflectHexFlare__FPli;
void (*p875_probe_8)(long *center, int otz) = &Flare_QuadFlare__FPli;
void (*p875_probe_9)(int type, COORD16 *ptCenter, COORD16 *pt1, COORD16 *pt2, int flag, int otz, Draw_FlareCache *sd) = &Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache;
void (*p875_probe_10)(DRender_tView *Vi, int scale, int type, coorddef *fpt, coorddef *fpt2, Draw_FlareCache *arg5) = &Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache;
void (*p875_probe_11)(DRender_tView *Vi, int scale, int type, coorddef *fpt, Draw_FlareCache *sd) = &Flare_Halo__FP13DRender_tViewiiP8coorddefP15Draw_FlareCache;
void (*p875_probe_12)(long *center, long *end, int otz) = &Flare_2DSpike__FPlT0i;
void (*p875_probe_13)(int x, int y, int scalex, int scaley, int type) = &Flare_2DHalo__Fiiiii;
void (*p875_probe_14)(long *center, int otz) = &Flare_PreCalcHexLightBeam__FPli;
void (*p875_probe_15)(long *pt, CVECTOR *color, int otz) = &Flare_Quad__FPlP7CVECTORi;
void (*p875_probe_16)(long *pt, CVECTOR *color, int otz) = &Flare_QuadNotTransparent__FPlP7CVECTORi;
void (*p875_probe_17)(long *pt, CVECTOR *color, int otz) = &Flare_QuadRing__FPlP7CVECTORi;
void (*p875_probe_18)(long *pt, CVECTOR *color, char type, int otz) = &Flare_TextureQuad__FPlP7CVECTORci;
void (*p875_probe_19)(DVECTOR *xy, CVECTOR *color, int width, int height, int type, int otz) = &Flare_SingleColorTex__FP7DVECTORP7CVECTORiici;
void (*p875_probe_20)(DVECTOR *xy, CVECTOR *color, int width, int height, int otz) = &Flare_SingleColorHex__FP7DVECTORP7CVECTORiii;
void (*p875_probe_21)(DVECTOR *xy, CVECTOR *color, int width, int height, int otz) = &Flare_SingleColorOct__FP7DVECTORP7CVECTORiii;
void (*p875_probe_22)(DVECTOR *xy, CVECTOR *color, int width, int height, int otz) = &Flare_SingleColorOctRing__FP7DVECTORP7CVECTORiii;
void (*p875_probe_23)(void) = &Flare_InitLensFlare__Fv;
void (*p875_probe_24)(DVECTOR *screenPos, Draw_FlareCache *sd) = &Flare_LensFlare__FP7DVECTORP15Draw_FlareCache;
void (*p875_probe_25)(SVECTOR *worldPos, Draw_FlareCache *sd) = &Flare_Sun__FP7SVECTORP15Draw_FlareCache;
void (*p875_probe_26)(SVECTOR *worldPos, Draw_FlareCache *sd) = &Flare_Moon__FP7SVECTORP15Draw_FlareCache;
