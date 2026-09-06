/* P875 follow-up typed API references; compile-only, never a game input. */
#include "C:/Temp/nfs4-decomp/recon/game/common/render.h"
void (*p875_common2_render_0)(void) = &Render_CreatePlayerViews;
void (*p875_common2_render_1)(void) = &Render_CreatePauseMenuViews;
void (*p875_common2_render_2)(void) = &Render_CreateViews;
void (*p875_common2_render_3)(int viewid) = &Render_StartRenderingWorldView;
void (*p875_common2_render_4)(int viewid) = &Render_StopRenderingWorldView;
void (*p875_common2_render_5)(DRender_tView *Vi) = &Render_RenderWorld;
void (*p875_common2_render_6)(int ViewID,int Player) = &Render_RenderPlayerView;
void (*p875_common2_render_7)(void) = &Render_RenderDebugView;
void (*p875_common2_render_8)(void) = &Render_StartFrameRender;
void (*p875_common2_render_9)(void) = &Render_StopFrameRender;
void (*p875_common2_render_10)(void) = &Render_InitPauseMenu;
void (*p875_common2_render_11)(void) = &Render_RenderPauseMenuView;
void (*p875_common2_render_12)(void) = &Render_KillPauseMenu;
void (*p875_common2_render_13)(int pause) = &Render_Render;
void (*p875_common2_render_14)(void) = &FlareThing;
void (*p875_common2_render_15)(void) = &Render_InitTrackRender;
void (*p875_common2_render_16)(void) = &Render_RestartTrackRender;
void (*p875_common2_render_17)(void) = &Render_InitTrackRenderPostSim;
void (*p875_common2_render_18)(void) = &Render_KillTrackRender;
void (*p875_common2_render_19)(void) = &Render_InitLibRender;
void (*p875_common2_render_20)(int xo,int depth) = &StampImage;
void (*p875_common2_render_21)(void) = &Render_InitBlurMode;
void (*p875_common2_render_22)(void) = &Render_InsertDepthOfField;
