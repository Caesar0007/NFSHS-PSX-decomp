/* game/psx/trsproj.h — reconstructed from game/psx/trsproj.cpp (11 fns) */
#ifndef _GAME_PSX_TRSPROJ_H_
#define _GAME_PSX_TRSPROJ_H_
#include "../../nfs4_types.h"

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

#endif /* _GAME_PSX_TRSPROJ_H_ */
