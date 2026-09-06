/* game/common/bworld.h — reconstructed from game/common/bworld.cpp (21 fns) */
#ifndef _GAME_COMMON_BWORLD_H_
#define _GAME_COMMON_BWORLD_H_
#include "bworld_types.h"

/* P875: native signatures and defining exports verified by typed-reference
 * probes. Source names let the compiler emit the original C++ linkage. */

int xzsquaredist32(coorddef *c1, coorddef *c2);   /* :127 */
void UpdateContext(DRender_tView *Vi, int contextHandle);   /* :140 */
void BWorld_BuildGlareEffects(DRender_tView *Vi, Draw_DCache *sd, Group *group);   /* :228 */
void BWorld_InitSpikeBelt(void);   /* :324 */
void BWorld_SetSpikeBelt(int slice, int x, int width);   /* :352 */
int BWorld_GetSpikeBelt(int *slice, int *x, int *width);   /* :363 */
void SetupBuildMatrices(DRender_tView *Vi, Draw_DCache *sd);   /* :393 */
int BWorld_CheckChunkVisible(BWorldSm_Pos *slicePosSource, BWorldSm_Pos *slicePosTest);   /* :590 */
int GetRezIndex(int dist);   /* :657 */
int SetupChunkBuildList(DRender_tView *Vi);   /* :676 */
bool BWorld_IsSliceInBuildList(int slice);   /* :847 */
void BWorld_OnyxBuildFacets(DRender_tView *Vi);   /* :906 */
char * BWAllocMem(long size);   /* :1107 */
void BWorld_InitContexts(void);   /* :1146 */
void BWorld_DeInitContexts(void);   /* :1165 */
void SetContext(int contextHandle);   /* :1178 */
int BWorld_OpenContext(int contextType, int client);   /* :1189 */
void BWorld_Restart(void);   /* :1232 */
void BWorld_StartLoop(void);   /* :1261 */
void BWorld_Init(void);   /* :1280 */
void BWorld_DeInit(void);   /* :1389 */

#endif /* _GAME_COMMON_BWORLD_H_ */
