/* P875 follow-up typed API references; compile-only, never a game input. */
#include "p875_common2_original_render.h"
void (*p875_common2_render_0)(void) = &Render_CreatePlayerViews__Fv;
void (*p875_common2_render_1)(void) = &Render_CreatePauseMenuViews__Fv;
void (*p875_common2_render_2)(void) = &Render_CreateViews__Fv;
void (*p875_common2_render_3)(int viewid) = &Render_StartRenderingWorldView__Fi;
void (*p875_common2_render_4)(int viewid) = &Render_StopRenderingWorldView__Fi;
void (*p875_common2_render_5)(DRender_tView *Vi) = &Render_RenderWorld__FP13DRender_tView;
void (*p875_common2_render_6)(int ViewID, int Player) = &Render_RenderPlayerView__Fii;
void (*p875_common2_render_7)(void) = &Render_RenderDebugView__Fv;
void (*p875_common2_render_8)(void) = &Render_StartFrameRender__Fv;
void (*p875_common2_render_9)(void) = &Render_StopFrameRender__Fv;
void (*p875_common2_render_10)(void) = &Render_InitPauseMenu__Fv;
void (*p875_common2_render_11)(void) = &Render_RenderPauseMenuView__Fv;
void (*p875_common2_render_12)(void) = &Render_KillPauseMenu__Fv;
void (*p875_common2_render_13)(int pause) = &Render_Render__Fi;
void (*p875_common2_render_14)(void) = &FlareThing__Fv;
void (*p875_common2_render_15)(void) = &Render_InitTrackRender__Fv;
void (*p875_common2_render_16)(void) = &Render_RestartTrackRender__Fv;
void (*p875_common2_render_17)(void) = &Render_InitTrackRenderPostSim__Fv;
void (*p875_common2_render_18)(void) = &Render_KillTrackRender__Fv;
void (*p875_common2_render_19)(void) = &Render_InitLibRender__Fv;
void (*p875_common2_render_20)(int xo, int depth) = &StampImage__Fii;
void (*p875_common2_render_21)(void) = &Render_InitBlurMode__Fv;
void (*p875_common2_render_22)(void) = &Render_InsertDepthOfField__Fv;
