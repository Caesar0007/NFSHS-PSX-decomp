/* game/psx/drawc.h — reconstructed from game/psx/drawc.cpp (20 fns) */
#ifndef _GAME_PSX_DRAWC_H_
#define _GAME_PSX_DRAWC_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

void ChangeTPage(u_short * tpage,int nabr);   /* SYM 3c0dd1 @0x800be6d0 */
void DrawC_SetEnviroment(void);   /* SYM 3c0df1 @0x800be6e8 */
void DrawC_ReadLightingData(void);   /* SYM 3c0e16 @0x800be6f0 */
void DrawC_ReadeMapData(void);   /* SYM 3c0e3e @0x800be8f8 */
void DrawC_BuildRenderingData(void);   /* SYM 3c0e62 @0x800be918 */
void DrawC_KillRenderingData(void);   /* SYM 3c0e8c @0x800be948 */
void DrawC_NightHeadlight(Car_tObj * carObj);   /* SYM 3c0eb5 @0x800be978 */
void DrawC_MenuColorData(int color,Car_tObj * carObj,int player);   /* SYM 3c0ee4 @0x800beb24 */
int DrawC_PrimStart(Draw_tVertex * center,Car_tObj * carObj,int lightAvg,Draw_CarCache * sd);   /* SYM 3c0f14 @0x800bed44 */
void DrawC_PrimStop(Car_tObj * carObj,Draw_CarCache * sd);   /* SYM 3c0f5e @0x800bfc84 */
void DrawC_Prim(matrixtdef * m,coorddef * t,Transformer_zObj * obj,Transformer_zOverlay * overlay,int envmap,Draw_CarCache * sd);   /* SYM 3c0f97 @0x800bfd44 */
void DrawC_DividePrim(COORD16 * vt0,COORD16 * vt1,COORD16 * vt2,u_short * u0,u_short * u1,u_short * u2,Draw_tPixMap * pmx,Draw_CarCache * sd);   /* SYM 3c1004 @0x800c12f8 */
void DrawC_PrimClip(matrixtdef * m,coorddef * t,Transformer_zObj * obj,Transformer_zOverlay * overlay,int envmap,Draw_CarCache * sd);   /* SYM 3c1056 @0x800c155c */
void DrawC_PrimMenu(matrixtdef * m,coorddef * t,Transformer_zObj * obj,Transformer_zOverlay * overlay,int envmap,Draw_CarCache * sd);   /* SYM 3c10c7 @0x800c32b0 */
void DrawC_PrimHalo(matrixtdef * m,coorddef * t,Transformer_zObj * obj,int type,int index,int reflect,Draw_CarCache * sd);   /* SYM 3c1138 @0x800c3a30 */
void DrawC_ShadowPrim(Draw_tVertex * shadowVT,Draw_CarCache * sd);   /* SYM 3c1194 @0x800c3ed8 */
void DrawC_DivideShadowPrim(COORD16 * vt0,COORD16 * vt1,COORD16 * vt2,COORD16 * vt3,u_short * u0,u_short * u1,u_short * u2,u_short * u3,Draw_tPixMap * pmx,Draw_CarCache * sd);   /* SYM 3c11d4 @0x800c40dc */
void DrawC_ShadowPrimClip(Draw_tVertex * shadowVT,Draw_CarCache * sd);   /* SYM 3c122c @0x800c42c4 */
void DrawC_SpotPrims(matrixtdef * m,coorddef * t,Draw_CarCache * sd);   /* SYM 3c1270 @0x800c4800 */
void DrawC_ShowroomPrims(matrixtdef * m,coorddef * t,Draw_CarCache * sd);   /* SYM 3c12b7 @0x800c4b84 */

#endif /* _GAME_PSX_DRAWC_H_ */
