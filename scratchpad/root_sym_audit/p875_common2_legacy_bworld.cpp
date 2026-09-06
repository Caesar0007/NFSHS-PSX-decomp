/* P875 follow-up typed API references; compile-only, never a game input. */
#include "p875_common2_original_bworld.h"
int (*p875_common2_bworld_0)(coorddef *c1, coorddef *c2) = &xzsquaredist32__FP8coorddefT0;
void (*p875_common2_bworld_1)(DRender_tView *Vi, int contextHandle) = &UpdateContext__FP13DRender_tViewi;
void (*p875_common2_bworld_2)(DRender_tView *Vi, Draw_DCache *sd, Group *group) = &BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group;
void (*p875_common2_bworld_3)(void) = &BWorld_InitSpikeBelt__Fv;
void (*p875_common2_bworld_4)(int slice, int x, int width) = &BWorld_SetSpikeBelt__Fiii;
int (*p875_common2_bworld_5)(int *slice, int *x, int *width) = &BWorld_GetSpikeBelt__FPiN20;
void (*p875_common2_bworld_6)(DRender_tView *Vi, Draw_DCache *sd) = &SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache;
int (*p875_common2_bworld_7)(BWorldSm_Pos *slicePosSource, BWorldSm_Pos *slicePosTest) = &BWorld_CheckChunkVisible__FP12BWorldSm_PosT0;
int (*p875_common2_bworld_8)(int dist) = &GetRezIndex__Fi;
int (*p875_common2_bworld_9)(DRender_tView *Vi) = &SetupChunkBuildList__FP13DRender_tView;
bool (*p875_common2_bworld_10)(int slice) = &BWorld_IsSliceInBuildList__Fi;
void (*p875_common2_bworld_11)(DRender_tView *Vi) = &BWorld_OnyxBuildFacets__FP13DRender_tView;
char * (*p875_common2_bworld_12)(long size) = &BWAllocMem__Fl;
void (*p875_common2_bworld_13)(void) = &BWorld_InitContexts__Fv;
void (*p875_common2_bworld_14)(void) = &BWorld_DeInitContexts__Fv;
void (*p875_common2_bworld_15)(int contextHandle) = &SetContext__Fi;
int (*p875_common2_bworld_16)(int contextType, int client) = &BWorld_OpenContext__Fii;
void (*p875_common2_bworld_17)(void) = &BWorld_Restart__Fv;
void (*p875_common2_bworld_18)(void) = &BWorld_StartLoop__Fv;
void (*p875_common2_bworld_19)(void) = &BWorld_Init__Fv;
void (*p875_common2_bworld_20)(void) = &BWorld_DeInit__Fv;
