/* game/psx/draw.h — reconstructed from game/psx/draw.cpp (25 fns) */
#ifndef _GAME_PSX_DRAW_H_
#define _GAME_PSX_DRAW_H_
#include "../../nfs4_types.h"
/* P875: source identifiers and signatures checked against native SYM/linkage. */

int Draw_SetView(int x0,int y0,int x1,int y1,int w,int h,int dtd,int isbg,int otsize);   /* SYM 3adde5 @0x800bdac0 */
void Draw_InitViews(void);   /* SYM 3ade0b @0x800bdbd4 */
void Draw_InitViewOT(void);   /* SYM 3ade2b @0x800bdbe0 */
void Draw_InitViewOTInGame(void);   /* SYM 3ade4c @0x800bdc64 */
void Draw_DeInitViews(void);   /* SYM 3ade73 @0x800bdce0 */
void Draw_DeInitViewsInGame(void);   /* SYM 3ade95 @0x800bdd68 */
DRAWENV * Draw_GetDRAWENV(int viewid,int page);   /* SYM 3adebd @0x800bdd9c */
void Draw_SetViewMemBudget(int viewid,int totalmem);   /* SYM 3adee9 @0x800bddd8 */
void Draw_SetViewColor(int viewid,int r,int g,int b);   /* SYM 3adf11 @0x800bde00 */
void AllocatePrimitivesBuffer(void);   /* SYM 3adf37 @0x800bde60 */
void ClearPrimitivesBuffer(void);   /* SYM 3adf61 @0x800bdf9c */
void ClearPlatformPrimitivesBuffer(void);   /* SYM 3adf88 @0x800be004 */
void Draw_StartRenderingView(int viewid);   /* SYM 3adfb7 @0x800be060 */
void Draw_StopRenderingView(int viewid);   /* SYM 3adfe0 @0x800be118 */
void Draw_CheckFirstFrameRender(void);   /* SYM 3ae008 @0x800be230 */
void Draw_StartFrameRender(void);   /* SYM 3ae034 @0x800be2c0 */
void Draw_SetDrawSyncCallback(void (* p)(void));   /* SYM 3ae05b @0x800be360 */
void Draw_StopFrameRender(void);   /* SYM 3ae089 @0x800be36c */
void Draw_DrawDirectScreen(shapetbl * tile,int x,int y);   /* SYM 3ae0af @0x800be450 */
void Draw_DirectSetEnvironment(int x,int y,int w,int h,int edraw,int edisplay,int erase,int r,int g,int b);   /* SYM 3ae0e1 @0x800be478 */
void Draw_SetEnvironment(int w,int h,int edraw,int edisplay,int erase,int r,int g,int b);   /* SYM 3ae115 @0x800be57c */
void Draw_InitRenderEngine(int x0,int y0,int x1,int y1,int w,int h);   /* SYM 3ae141 @0x800be5d8 */
void Draw_RestartRenderEngine(void);   /* SYM 3ae16d @0x800be67c */
void Draw_DeInitRenderEngine(void);   /* SYM 3ae197 @0x800be684 */
void Draw_InitLibRender(void);   /* SYM 3ae1c0 @0x800be6a8 */

#endif /* _GAME_PSX_DRAW_H_ */
