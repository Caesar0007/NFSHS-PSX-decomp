/* P875 follow-up typed API references; compile-only, never a game input. */
#include "C:/Temp/nfs4-decomp/recon/game/common/bworld.h"
int (*p875_common2_bworld_0)(coorddef *c1,coorddef *c2) = &xzsquaredist32;
void (*p875_common2_bworld_1)(DRender_tView *Vi,int contextHandle) = &UpdateContext;
void (*p875_common2_bworld_2)(DRender_tView *Vi,Draw_DCache *sd,Group *group) = &BWorld_BuildGlareEffects;
void (*p875_common2_bworld_3)(void) = &BWorld_InitSpikeBelt;
void (*p875_common2_bworld_4)(int slice,int x,int width) = &BWorld_SetSpikeBelt;
int (*p875_common2_bworld_5)(int *slice,int *x,int *width) = &BWorld_GetSpikeBelt;
void (*p875_common2_bworld_6)(DRender_tView *Vi,Draw_DCache *sd) = &SetupBuildMatrices;
int (*p875_common2_bworld_7)(BWorldSm_Pos *slicePosSource,BWorldSm_Pos *slicePosTest) = &BWorld_CheckChunkVisible;
int (*p875_common2_bworld_8)(int dist) = &GetRezIndex;
int (*p875_common2_bworld_9)(DRender_tView *Vi) = &SetupChunkBuildList;
bool (*p875_common2_bworld_10)(int slice) = &BWorld_IsSliceInBuildList;
void (*p875_common2_bworld_11)(DRender_tView *Vi) = &BWorld_OnyxBuildFacets;
char * (*p875_common2_bworld_12)(long size) = &BWAllocMem;
void (*p875_common2_bworld_13)(void) = &BWorld_InitContexts;
void (*p875_common2_bworld_14)(void) = &BWorld_DeInitContexts;
void (*p875_common2_bworld_15)(int contextHandle) = &SetContext;
int (*p875_common2_bworld_16)(int contextType,int client) = &BWorld_OpenContext;
void (*p875_common2_bworld_17)(void) = &BWorld_Restart;
void (*p875_common2_bworld_18)(void) = &BWorld_StartLoop;
void (*p875_common2_bworld_19)(void) = &BWorld_Init;
void (*p875_common2_bworld_20)(void) = &BWorld_DeInit;
