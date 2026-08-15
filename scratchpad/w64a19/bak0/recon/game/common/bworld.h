/* game/common/bworld.h — reconstructed from game/common/bworld.cpp (21 fns) */
#ifndef _GAME_COMMON_BWORLD_H_
#define _GAME_COMMON_BWORLD_H_
#include "../../nfs4_types.h"

int xzsquaredist32__FP8coorddefT0(coorddef *c1, coorddef *c2);   /* :127 */
void UpdateContext__FP13DRender_tViewi(DRender_tView *Vi, int contextHandle);   /* :140 */
void BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group(DRender_tView *Vi, Draw_DCache *sd, Group *group);   /* :228 */
void BWorld_InitSpikeBelt__Fv(void);   /* :324 */
void BWorld_SetSpikeBelt__Fiii(int slice, int x, int width);   /* :352 */
int BWorld_GetSpikeBelt__FPiN20(int *slice, int *x, int *width);   /* :363 */
void SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache(DRender_tView *Vi, Draw_DCache *sd);   /* :393 */
int BWorld_CheckChunkVisible__FP12BWorldSm_PosT0(BWorldSm_Pos *slicePosSource, BWorldSm_Pos *slicePosTest);   /* :590 */
int GetRezIndex__Fi(int dist);   /* :657 */
int SetupChunkBuildList__FP13DRender_tView(DRender_tView *Vi);   /* :676 */
BOOL BWorld_IsSliceInBuildList__Fi(int slice);   /* :847 */
void BWorld_OnyxBuildFacets__FP13DRender_tView(DRender_tView *Vi);   /* :906 */
char * BWAllocMem__Fl(long size);   /* :1107 */
void BWorld_InitContexts__Fv(void);   /* :1146 */
void BWorld_DeInitContexts__Fv(void);   /* :1165 */
void SetContext__Fi(int contextHandle);   /* :1178 */
int BWorld_OpenContext__Fii(int contextType, int client);   /* :1189 */
void BWorld_Restart__Fv(void);   /* :1232 */
void BWorld_StartLoop__Fv(void);   /* :1261 */
void BWorld_Init__Fv(void);   /* :1280 */
void BWorld_DeInit__Fv(void);   /* :1389 */

#endif /* _GAME_COMMON_BWORLD_H_ */
