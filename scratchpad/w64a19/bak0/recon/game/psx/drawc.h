/* game/psx/drawc.h — reconstructed from game/psx/drawc.cpp (20 fns) */
#ifndef _GAME_PSX_DRAWC_H_
#define _GAME_PSX_DRAWC_H_
#include "../../nfs4_types.h"

void ChangeTPage__FPUsi(u_short *tpage, int nabr);   /* :112 */
void DrawC_SetEnviroment__Fv(void);   /* :119 */
void DrawC_ReadLightingData__Fv(void);   /* :123 */
void DrawC_ReadeMapData__Fv(void);   /* :181 */
void DrawC_BuildRenderingData__Fv(void);   /* :190 */
void DrawC_KillRenderingData__Fv(void);   /* :208 */
void DrawC_NightHeadlight__FP8Car_tObj(Car_tObj *carObj);   /* :214 */
void DrawC_MenuColorData__FiP8Car_tObji(int color, Car_tObj *carObj, int player);   /* :388 */
int DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache(Draw_tVertex *center, Car_tObj *carObj, int lightAvg, Draw_CarCache *sd);   /* :1148 */
void DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache(Car_tObj *carObj, Draw_CarCache *sd);   /* :1535 */
void DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache(matrixtdef *m, coorddef *t, Transformer_zObj *obj, Transformer_zOverlay *overlay, int envmap, Draw_CarCache *sd);   /* :1772 */
void DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache(COORD16 *vt0, COORD16 *vt1, COORD16 *vt2, u_short *u0, u_short *u1, u_short *u2, Draw_tPixMap *pmx, Draw_CarCache *sd);   /* :2554 */
void DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache(matrixtdef *m, coorddef *t, Transformer_zObj *obj, Transformer_zOverlay *overlay, int envmap, Draw_CarCache *sd);   /* :2647 */
void DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache(matrixtdef *m, coorddef *t, Transformer_zObj *obj, Transformer_zOverlay *overlay, int envmap, Draw_CarCache *sd);   /* :3551 */
void DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache(matrixtdef *m, coorddef *t, Transformer_zObj *obj, int type, int index, int reflect, Draw_CarCache *sd);   /* :3881 */
void DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache(Draw_tVertex *shadowVT, Draw_CarCache *sd);   /* :3997 */
void DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache(COORD16 *vt0, COORD16 *vt1, COORD16 *vt2, COORD16 *vt3, u_short *u0, u_short *u1, u_short *u2, u_short *u3, Draw_tPixMap *pmx, Draw_CarCache *sd);   /* :4056 */
void DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache(Draw_tVertex *shadowVT, Draw_CarCache *sd);   /* :4117 */
void DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache(matrixtdef *m, coorddef *t, Draw_CarCache *sd);   /* :4189 */
void DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache(matrixtdef *m, coorddef *t, Draw_CarCache *sd);   /* :4260 */

#endif /* _GAME_PSX_DRAWC_H_ */
