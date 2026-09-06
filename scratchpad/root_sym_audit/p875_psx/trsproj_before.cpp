/* Frozen original recon/game/psx/trsproj.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
void TrsProj_SetTransPrecision__Fi(int val);   /* :29 */
void TrsProj_ResetTransPrecision__Fv(void);   /* :41 */
void TrsProj_SetProjection__Fiiii(int cx, int cy, int w, int h);   /* :52 */
void TrsProj_SetMenuProjection__Fiiii(int cx, int cy, int w, int h);   /* :67 */
void TrsProj_SetViewTrsProjEnviro__FP13DRender_tView(DRender_tView *Vi);   /* :76 */
void TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef(matrixtdef *m, coorddef *t);   /* :137 */
void TrsProj_SetPsxTrans__FP8coorddef(coorddef *t);   /* :157 */
void TrsProj_SetPsxTransZero__Fv(void);   /* :168 */
void TrsProj_TransPt__FP8coorddefT0(coorddef *s, coorddef *d);   /* :177 */
void TrsProj_TransPtN16__FP10RelCoord16P8coorddefi(RelCoord16 *s, coorddef *d, int n);   /* :224 */
void TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex(matrixtdef *m, coorddef *t, int n, coorddef *s, Draw_tVertex *v);   /* :250 */
void (*p875_probe_0)(int val) = &TrsProj_SetTransPrecision__Fi;
void (*p875_probe_1)(void) = &TrsProj_ResetTransPrecision__Fv;
void (*p875_probe_2)(int cx, int cy, int w, int h) = &TrsProj_SetProjection__Fiiii;
void (*p875_probe_3)(int cx, int cy, int w, int h) = &TrsProj_SetMenuProjection__Fiiii;
void (*p875_probe_4)(DRender_tView *Vi) = &TrsProj_SetViewTrsProjEnviro__FP13DRender_tView;
void (*p875_probe_5)(matrixtdef *m, coorddef *t) = &TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef;
void (*p875_probe_6)(coorddef *t) = &TrsProj_SetPsxTrans__FP8coorddef;
void (*p875_probe_7)(void) = &TrsProj_SetPsxTransZero__Fv;
void (*p875_probe_8)(coorddef *s, coorddef *d) = &TrsProj_TransPt__FP8coorddefT0;
void (*p875_probe_9)(RelCoord16 *s, coorddef *d, int n) = &TrsProj_TransPtN16__FP10RelCoord16P8coorddefi;
void (*p875_probe_10)(matrixtdef *m, coorddef *t, int n, coorddef *s, Draw_tVertex *v) = &TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex;
