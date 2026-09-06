/* Frozen original recon/game/psx/draw.h prototype surface for reproducible before probing. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"
int Draw_SetView__Fiiiiiiiii(int x0, int y0, int x1, int y1, int w, int h, int dtd, int isbg, int otsize);   /* :72 */
void Draw_InitViews__Fv(void);   /* :113 */
void Draw_InitViewOT__Fv(void);   /* :127 */
void Draw_InitViewOTInGame__Fv(void);   /* :138 */
void Draw_DeInitViews__Fv(void);   /* :157 */
void Draw_DeInitViewsInGame__Fv(void);   /* :172 */
void * Draw_GetDRAWENV__Fii(int viewid, int page);   /* :187 */
void Draw_SetViewMemBudget__Fii(int viewid, int totalmem);   /* :197 */
void Draw_SetViewColor__Fiiii(int viewid, int r, int g, int b);   /* :213 */
void AllocatePrimitivesBuffer__Fv(void);   /* :237 */
void ClearPrimitivesBuffer__Fv(void);   /* :312 */
void ClearPlatformPrimitivesBuffer__Fv(void);   /* :325 */
void Draw_StartRenderingView__Fi(int viewid);   /* :352 */
void Draw_StopRenderingView__Fi(int viewid);   /* :387 */
void Draw_CheckFirstFrameRender__Fv(void);   /* :409 */
void Draw_StartFrameRender__Fv(void);   /* :432 */
void Draw_SetDrawSyncCallback__FPFv_v(void *p);   /* :448 */
void Draw_StopFrameRender__Fv(void);   /* :463 */
void Draw_DrawDirectScreen__FP8shapetblii(shapetbl *tile, int x, int y);   /* :493 */
void Draw_DirectSetEnvironment__Fiiiiiiiiii(int x, int y, int w, int h, int edraw, int edisplay, int erase, int r, int g, int b);   /* :513 */
void Draw_SetEnvironment__Fiiiiiiii(int w, int h, int edraw, int edisplay, int erase, int r, int g, int b);   /* :551 */
void Draw_InitRenderEngine__Fiiiiii(int x0, int y0, int x1, int y1, int w, int h);   /* :577 */
void Draw_RestartRenderEngine__Fv(void);   /* :596 */
void Draw_DeInitRenderEngine__Fv(void);   /* :600 */
void Draw_InitLibRender__Fv(void);   /* :609 */
int (*p875_probe_0)(int x0, int y0, int x1, int y1, int w, int h, int dtd, int isbg, int otsize) = &Draw_SetView__Fiiiiiiiii;
void (*p875_probe_1)(void) = &Draw_InitViews__Fv;
void (*p875_probe_2)(void) = &Draw_InitViewOT__Fv;
void (*p875_probe_3)(void) = &Draw_InitViewOTInGame__Fv;
void (*p875_probe_4)(void) = &Draw_DeInitViews__Fv;
void (*p875_probe_5)(void) = &Draw_DeInitViewsInGame__Fv;
void * (*p875_probe_6)(int viewid, int page) = &Draw_GetDRAWENV__Fii;
void (*p875_probe_7)(int viewid, int totalmem) = &Draw_SetViewMemBudget__Fii;
void (*p875_probe_8)(int viewid, int r, int g, int b) = &Draw_SetViewColor__Fiiii;
void (*p875_probe_9)(void) = &AllocatePrimitivesBuffer__Fv;
void (*p875_probe_10)(void) = &ClearPrimitivesBuffer__Fv;
void (*p875_probe_11)(void) = &ClearPlatformPrimitivesBuffer__Fv;
void (*p875_probe_12)(int viewid) = &Draw_StartRenderingView__Fi;
void (*p875_probe_13)(int viewid) = &Draw_StopRenderingView__Fi;
void (*p875_probe_14)(void) = &Draw_CheckFirstFrameRender__Fv;
void (*p875_probe_15)(void) = &Draw_StartFrameRender__Fv;
void (*p875_probe_16)(void *p) = &Draw_SetDrawSyncCallback__FPFv_v;
void (*p875_probe_17)(void) = &Draw_StopFrameRender__Fv;
void (*p875_probe_18)(shapetbl *tile, int x, int y) = &Draw_DrawDirectScreen__FP8shapetblii;
void (*p875_probe_19)(int x, int y, int w, int h, int edraw, int edisplay, int erase, int r, int g, int b) = &Draw_DirectSetEnvironment__Fiiiiiiiiii;
void (*p875_probe_20)(int w, int h, int edraw, int edisplay, int erase, int r, int g, int b) = &Draw_SetEnvironment__Fiiiiiiii;
void (*p875_probe_21)(int x0, int y0, int x1, int y1, int w, int h) = &Draw_InitRenderEngine__Fiiiiii;
void (*p875_probe_22)(void) = &Draw_RestartRenderEngine__Fv;
void (*p875_probe_23)(void) = &Draw_DeInitRenderEngine__Fv;
void (*p875_probe_24)(void) = &Draw_InitLibRender__Fv;
