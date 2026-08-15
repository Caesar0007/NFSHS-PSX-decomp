#include "../../lib/libfns.h"
/* render_externs.h -- extern decls for game/psx/render.cpp (NFS4 PSX render orchestration). */
#ifndef RENDER_EXTERNS_H
#define RENDER_EXTERNS_H

typedef void fn_void(void);   /* Draw_SetDrawSyncCallback callback (void(*)(void)) */

/* ---- render globals ---- */
// [owned->defined in render.cpp] extern DRender_tView   gCView;                 /* 0x... (DRender_tView, 140B) */
// [owned->defined in render.cpp] extern int   Draw_gPlayer1View, Draw_gPlayer2View, Render_gPauseMenuView;
// [owned->defined in render.cpp] extern int   Render_gBlurEffectMode, Render_gBlurEffectDepth1, Render_gBlurEffectDepth2;
extern int   Render_gMenuRenderFlag;
// gScratchLastWord: fixed-address scratchpad macro, see nfs4_types.h
// [owned->defined in render.cpp] extern int   gFlip, gPauseRender, gMPauseUpdate, gMPauseUpdateNextTime;
extern int gFlip, gMPauseUpdate, gMPauseUpdateNextTime;
// [owned->defined in render.cpp] extern short gPauseMenuRect, D_8013D3D6, D_8013D3D8, D_8013D3DA;  /* was RECT gPauseMenuRect (x/y/w/h), split for gp-rel -- see render.cpp */
extern dflip gEnviro[];
extern FLARE_DEF gFlare_LensFlare;
extern GameSetup_tData GameSetup_gData;

/* ---- functions ---- */
extern void BWorld_OnyxBuildFacets(DRender_tView *v);
extern void BWorld_StartLoop(void);
extern void CV_InitColorVertices(void);
extern void Camera_SetCamera(DRender_tView *v);
extern void DashHUD_InitHUD(void);
extern void DashHUD_KillHUD(void);
extern void DepthCue_Init(void);
extern void DrawC_BuildRenderingData(void);
extern void DrawC_KillRenderingData(void);
extern void DrawC_SetEnviroment(void);
extern void Draw_CheckFirstFrameRender(void);
extern void Draw_DeInitRenderEngine(void);
extern void Draw_InitLibRender(void);
extern void Draw_InitRenderEngine(int,int,int,int,int,int);
extern void Draw_InitViews(void);
extern void Draw_RestartRenderEngine(void);
extern void Draw_SetDrawSyncCallback(fn_void *cb);
extern int Draw_SetView(int,int,int,int,int,int,int,int,int);
extern void Draw_StartFrameRender(void);
extern void Draw_StartRenderingView(int viewid);
extern void Draw_StopFrameRender(void);
extern void Draw_StopRenderingView(int viewid);
extern void Fog_DeInitFogTriggers(void);
extern void Fog_InitFogTriggers(void);
extern void Fog_Update(int player);
extern void GenericPMX_LoadTexture(void);
extern void Hrz_BuildHorizon(DRender_tView *v);
extern void Hud_CreateHudViews(void);
extern void Hud_Render(void);
extern void Loading_UpdateLoadingScreen(int n);
extern void MPause_InitMPause(void);
extern void MPause_KillMPause(void);
extern void MPause_Render(void);
extern void MPause_StartPauseMenu(void);
extern void Night_KillNightDriving(void);
extern void Night_RestartNightDriving(void);
extern void Night_SetEnviroment(DRender_tView *v);
extern void R3DCar_InsertAllListFacet(DRender_tView *v);
extern void RPause_CopyBackToFrontBuffer(void);
extern void RPause_StartPauseMenu(void);
extern void RPause_StopPauseMenu(void);
extern void Skidmark_InitSkidmark(void);
extern void Skidmark_KillSkidmark(void);
extern void Skidmark_OnyxBuildFacets(DRender_tView *v);
extern void Skidmark_RestartSkidmark(void);
extern void Souffle_DoSouffle(void);
extern void Souffle_InitTrackSouffle(void);
extern void Souffle_InsertFacet(DRender_tView *v);
extern void Souffle_KillTrackSouffle(void);
extern void Souffle_RestartTrackSouffle(void);
extern void Texture_DeInitPaletteSharing(void);
extern void Texture_InitTrackTexture(void);
extern void Texture_KillTrackTexture(void);
extern void TrackSpec_Load(int weather, int time);
extern void Track_AnimateTextures(void);
extern void Track_AnimateTrackLighting(void);
extern void TrgSfx_InitTrgSfx(void);
extern void TrgSfx_KillTrgSfx(void);
extern void TrgSfx_RestartTrgSfx(void);
extern void TrsProj_ResetTransPrecision(void);
extern void Weather_BuildWeather(DRender_tView *v);

#endif
