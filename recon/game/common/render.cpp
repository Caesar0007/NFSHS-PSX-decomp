/* game/common/render.cpp -- RECONSTRUCTED (NFS4 PSX render orchestration; C++ TU)
 *   6 fns: Scene_Init/DeInit/PurgeScene/BuildCustomSceneList/LoadSceneFile + GetPlaneY.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "render_externs.h"

/* ---- link-harness owned-global definition (extern-declared, never defined) ---- */
short Render_gPacketLenLo, Render_gPacketLenHi;  /* render.obj-owned packet-length accumulators (BSS) */

/* ---- render.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero) ---- */
DRender_tView gCView;   /* @0x80116f7c  (bss(zero)) */
int          Render_gBlurEffectDepth1;   /* @0x8013d3c0  (bss(zero)) */
int          Render_gBlurEffectDepth2;   /* @0x8013d3c4  (bss(zero)) */
int          Render_gBlurEffectMode;   /* @0x8013d3c8  (bss(zero)) */
int          Draw_gPlayer1View;   /* @0x8013d3cc  (bss(zero)) */
int          Draw_gPlayer2View;   /* @0x8013d3d0  (bss(zero)) */
RECT         gPauseMenuRect;   /* @0x8013d3d4  (bss(zero)) */
int          gPauseRender;   /* @0x8013d3dc  (bss(zero)) */
int          Draw_gRearView;   /* @0x8013d3e0  (bss(zero)) */
int          Render_gDebugView;   /* @0x8013d3e4  (bss(zero)) */
int          Render_gPauseMenuView;   /* @0x8013d3e8  (bss(zero)) */

/* ---- PSX scratchpad (0x1F800000 region) Render_-owned globals -- lost-symbols (NOT in SYM;
   render.cpp is canonical owner of the Render_ packet/scratchpad namespace; draww + FE extern
   these). Defined here so the project links self-contained. ---- */
int     Render_gMenuRenderFlag;   /* render mirror/menu render flag (render-owned scratch) */
/* Render_gPacketPtr (@0x1F800004) / Render_gPalettePtr (@0x1F800000) are NOT storage globals:
   they live at fixed PSX scratchpad addresses, so they are fixed-address lvalue macros defined
   in nfs4_types.h (the universal include). The oracle materializes them as literal `lui;ori`/
   `lui;lw` constants, which a linked symbol can't reproduce. Do NOT re-add a definition here. */
u_char *Render_gPacketEnd;        /* GPU OT packet-buffer end pointer */
MATRIX  Render_gWorldMat;         /* @0x1F800014  world->view matrix (scratchpad) */
MATRIX  Render_gNightMat;         /* night-lighting matrix (scratchpad) */
matrixtdef Render_gCopMat;        /* cop-car matrix (scratchpad) */
/* ownerless Ghidra-named scratchpad slots (shared draww/r3dcar; no module prefix) -- centralized
   here as render owns the un-prefixed PSX scratchpad (0x1F8000xx) region. */
int     INT_1f800084, INT_1f800088, INT_1f80008c, INT_1f800090;   /* @0x1F800084  scratch matrix-t slot */
/* gScratchLastWord: fixed-address scratchpad lvalue macro @0x1F8003FC, see nfs4_types.h
   (matches oracle's literal lui/ori address materialization, not a %hi/%lo(sym) reloc). */

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Render_CreatePlayerViews(void);
void Render_CreatePauseMenuViews(void);
void Render_CreateViews(void);
void Render_StartRenderingWorldView(int viewid);
void Render_StopRenderingWorldView(int viewid);
void Render_RenderWorld(DRender_tView *Vi);
void Render_RenderPlayerView(int ViewID,int Player);
void Render_RenderDebugView(void);
void Render_StartFrameRender(void);
void Render_StopFrameRender(void);
void Render_InitPauseMenu(void);
void Render_RenderPauseMenuView(void);
void Render_KillPauseMenu(void);
void Render_Render(int pause);
void FlareThing(void);
void Render_InitTrackRender(void);
void Render_RestartTrackRender(void);
void Render_InitTrackRenderPostSim(void);
void Render_KillTrackRender(void);
void Render_InitLibRender(void);
void StampImage(int xo,int depth);
void Render_InitBlurMode(void);
void Render_InsertDepthOfField(void);


/* ---- Render_CreatePlayerViews__Fv  [RENDER.CPP:92-124] SLD-VERIFIED ---- */
void Render_CreatePlayerViews(void)

{
  
  if (GameSetup_gData.commMode == 1) {
    Draw_gPlayer1View = Draw_SetView(0,0x100,0x140,0x100,0x140,0x78,0,1,2000);
    Draw_gPlayer2View = Draw_SetView(0,0x178,0x140,0x178,0x140,0x78,0,1,2000);
  }
  else {
    Draw_gPlayer1View = Draw_SetView(0,0x100,0x140,0x100,0x140,0xf0,0,1,3000);
    Draw_gPlayer2View = -1;
  }
  return;
}

/* ---- Render_CreatePauseMenuViews__Fv  [RENDER.CPP:140-145] SLD-VERIFIED ---- */
void Render_CreatePauseMenuViews(void)

{
  
  Render_gPauseMenuView =
       Draw_SetView(0,0x100,0x140,0x100,0x140,0xf0,0,0,1);
  return;
}

/* ---- Render_CreateViews__Fv  [RENDER.CPP:151-163] SLD-VERIFIED ---- */
void Render_CreateViews(void)

{
  Draw_InitViews();
  Render_CreatePlayerViews();
  Hud_CreateHudViews();
  Render_CreatePauseMenuViews();
  return;
}

/* ---- Render_StartRenderingWorldView__Fi  [RENDER.CPP:169-209] SLD-VERIFIED ---- */
void Render_StartRenderingWorldView(int viewid)

{
  
  Camera_SetCamera(&gCView);
  Track_AnimateTrackLighting();
  Draw_StartRenderingView(viewid);
  *(int *)0x1F80000C = GameSetup_gData.mirrorTrack;
  Fog_Update(gCView.player);
  DrawC_SetEnviroment();
  TrsProj_ResetTransPrecision();
  Night_SetEnviroment(&gCView);
  return;
}

/* ---- Render_StopRenderingWorldView__Fi  [RENDER.CPP:215-217] SLD-VERIFIED ---- */
void Render_StopRenderingWorldView(int viewid)

{
  Draw_StopRenderingView(viewid);
  return;
}

/* ---- Render_RenderWorld__FP13DRender_tView  [RENDER.CPP:223-255] SLD-VERIFIED ---- */
void Render_RenderWorld(DRender_tView *Vi)

{
  void *pvVar1;
  int savesp;
  
  BWorld_OnyxBuildFacets(Vi);
  pvVar1 = SetSp(&gScratchLastWord);
  Skidmark_OnyxBuildFacets(Vi);
  SetSp(pvVar1);
  pvVar1 = SetSp(&gScratchLastWord);
  Souffle_InsertFacet(Vi);
  SetSp(pvVar1);
  R3DCar_InsertAllListFacet(Vi);
  Hrz_BuildHorizon(Vi);
  pvVar1 = SetSp(&gScratchLastWord);
  Weather_BuildWeather(Vi);
  SetSp(pvVar1);
  Render_InsertDepthOfField();
  return;
}

/* ---- Render_RenderPlayerView__Fii  [RENDER.CPP:270-280] SLD-VERIFIED ---- */
void Render_RenderPlayerView(int ViewID,int Player)

{
  
  gCView.id = ViewID;
  gCView.player = Player;
  Render_StartRenderingWorldView(ViewID);
  Render_RenderWorld(&gCView);
  Render_StopRenderingWorldView(ViewID);
  return;
}

/* ---- Render_RenderDebugView__Fv  [RENDER.CPP:332-354] SLD-VERIFIED ---- */
void Render_RenderDebugView(void)

{
  return;
}

/* ---- Render_StartFrameRender__Fv  [RENDER.CPP:359-371] SLD-VERIFIED ---- */
void Render_StartFrameRender(void)

{
  BWorld_StartLoop();
  Track_AnimateTextures();
  Souffle_DoSouffle();
  Draw_CheckFirstFrameRender();
  Draw_StartFrameRender();
  return;
}

/* ---- Render_StopFrameRender__Fv  [RENDER.CPP:375-379] SLD-VERIFIED ---- */
void Render_StopFrameRender(void)

{
  Draw_StopFrameRender();
  return;
}

/* ---- Render_InitPauseMenu__Fv  [RENDER.CPP:387-389] SLD-VERIFIED ---- */
void Render_InitPauseMenu(void)

{
  MPause_InitMPause();
  return;
}

/* ---- Render_RenderPauseMenuView__Fv  [RENDER.CPP:393-407] SLD-VERIFIED ---- */
void Render_RenderPauseMenuView(void)

{
  int iVar1;
  int ogFlip;
  
  gCView.id = Render_gPauseMenuView;
  Draw_StartRenderingView(Render_gPauseMenuView);
  MPause_Render();
  iVar1 = gFlip;
  gFlip = 0;
  Draw_StopRenderingView(Render_gPauseMenuView);
  gFlip = iVar1;
  return;
}

/* ---- Render_KillPauseMenu__Fv  [RENDER.CPP:411-413] SLD-VERIFIED ---- */
void Render_KillPauseMenu(void)

{
  MPause_KillMPause();
  return;
}

/* ---- Render_Render__Fi  [RENDER.CPP:417-525] SLD-VERIFIED ---- */
void Render_Render(int pause)

{
  bool bVar1;
  int ViewID;
  
  if (pause == 0) {
    if (gPauseRender == 0) {
      bVar1 = GameSetup_gData.commMode != 1;
      if (bVar1) {
        Render_StartFrameRender();
        ViewID = Draw_gPlayer1View;
      }
      else {
        Render_StartFrameRender();
        Render_RenderPlayerView(Draw_gPlayer1View,0);
        ViewID = Draw_gPlayer2View;
      }
      Render_RenderPlayerView(ViewID,(u_int)!bVar1);
      Hud_Render();
      Render_RenderDebugView();
      Render_StopFrameRender();
    }
    else {
      gPauseRender = 0;
    }
  }
  else {
    if (gPauseRender == 0) {
      gPauseMenuRect.w = 0x140;
      gPauseRender = 1;
      gPauseMenuRect.x = 0;
      gPauseMenuRect.y = 0;
      gPauseMenuRect.h = 0xf0;
      DrawSync(0);
      RPause_CopyBackToFrontBuffer();
      MPause_StartPauseMenu();
      gMPauseUpdate = 1;
      gMPauseUpdateNextTime = 0;
    }
    gPauseMenuRect.x = 0x4e;
    gPauseMenuRect.y = 0x62;
    gPauseMenuRect.w = 0xa4;
    gPauseMenuRect.h = 0x8b;
    if (gMPauseUpdate != 0) {
      RPause_StartPauseMenu();
      Render_RenderPauseMenuView();
      RPause_StopPauseMenu();
    }
  }
  return;
}

/* ---- FlareThing__Fv  [RENDER.CPP:535-555] SLD-VERIFIED ---- */
void FlareThing(void)

{
  int i;
  int i_2;
  u_short *screen_walk;
  int players;
  int n_players;
  FLARE_DEF *flare_walk;
  RECT rec;
  
  n_players = 1;
  if (GameSetup_gData.commMode == 1) {
    n_players = 2;
  }
  flare_walk = &gFlare_LensFlare;
  screen_walk = (u_short *)gFlare_LensFlare.screenData;
  for (i_2 = 0; i_2 < n_players; i_2 = i_2 + 1) {
    if (gFlare_LensFlare.isDrawn[i_2] != '\0') {
      rec.x = gEnviro[gFlip].disp.disp.x + flare_walk->oldpos[0].vx + -2;
      rec.w = 5;
      rec.h = 5;
      rec.y = gEnviro[gFlip].disp.disp.y + flare_walk->oldpos[0].vy + -2;
      StoreImage(&rec,(u_long *)screen_walk);
      gFlare_LensFlare.isDrawn[i_2] = '\0';
    }
    screen_walk = screen_walk + 0x19;
    flare_walk = (FLARE_DEF *)(flare_walk->pos + 1);
  }
  return;
}

/* ---- Render_InitTrackRender__Fv  [RENDER.CPP:563-596] SLD-VERIFIED ---- */
void Render_InitTrackRender(void)

{
  TrackSpec_Load(GameSetup_gData.Weather,GameSetup_gData.Time);
  Render_CreateViews();
  Draw_InitRenderEngine(0x140,0x100,0,0x100,0x140,0xf0);
  DrawC_BuildRenderingData();
  Texture_InitTrackTexture();
  GenericPMX_LoadTexture();
  Souffle_InitTrackSouffle();
  Skidmark_InitSkidmark();
  TrgSfx_InitTrgSfx();
  DashHUD_InitHUD();
  Loading_UpdateLoadingScreen(3);
  Fog_InitFogTriggers();
  Draw_SetDrawSyncCallback(FlareThing);
  Render_InitBlurMode();
  return;
}

/* ---- Render_RestartTrackRender__Fv  [RENDER.CPP:600-608] SLD-VERIFIED ---- */
void Render_RestartTrackRender(void)

{
  Draw_RestartRenderEngine();
  DepthCue_Init();
  Night_RestartNightDriving();
  Skidmark_RestartSkidmark();
  Souffle_RestartTrackSouffle();
  TrgSfx_RestartTrgSfx();
  return;
}

/* ---- Render_InitTrackRenderPostSim__Fv  [RENDER.CPP:612-619] SLD-VERIFIED ---- */
void Render_InitTrackRenderPostSim(void)

{
  gPauseRender = 0;
  Texture_DeInitPaletteSharing();
  CV_InitColorVertices();
  return;
}

/* ---- Render_KillTrackRender__Fv  [RENDER.CPP:624-634] SLD-VERIFIED ---- */
void Render_KillTrackRender(void)

{
  Draw_DeInitRenderEngine();
  DrawC_KillRenderingData();
  Night_KillNightDriving();
  Texture_KillTrackTexture();
  Souffle_KillTrackSouffle();
  Skidmark_KillSkidmark();
  TrgSfx_KillTrgSfx();
  DashHUD_KillHUD();
  Draw_SetDrawSyncCallback((fn_void *)0x0);
  Fog_DeInitFogTriggers();
  return;
}

/* ---- Render_InitLibRender__Fv  [RENDER.CPP:640-641] SLD-VERIFIED ---- */
void Render_InitLibRender(void)

{
  Draw_InitLibRender();
  return;
}

/* ---- StampImage__Fii  [RENDER.CPP:711-769] SLD-VERIFIED ---- */
void StampImage(int xo,int depth)

{
  POLY_FT4 * ft4_p;
  int addr_24;
  int tu1;
  u_int *pal_link;
  int i;
  int x_pos;
  int x_remain;
  int frame;
  int buf_idx;
  u_char *ft4_packet;
  short ts1;
  
  buf_idx = gFlip;
  if ((Render_gBlurEffectMode & 2U) == 0) {
    buf_idx = 1 - gFlip;
  }
  x_pos = 0;
  if ((Render_gBlurEffectMode & 4U) == 0) {
    xo = 0;
  }
  x_remain = 0x140;
  do {
    ft4_packet = Render_gPacketPtr;
    pal_link = (u_int *)(Render_gPalettePtr + depth * 4);
    *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *pal_link & 0xffffff;
    addr_24 = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x28;
    *pal_link = *pal_link & 0xff000000 | addr_24;
    ft4_packet[3] = 9;
    ft4_packet[7] = 0x2e;
    ts1 = (short)xo;
    *(short *)(ft4_packet + 0x10) = ts1 + 0x40;
    *(short *)(ft4_packet + 0x20) = ts1 + 0x40;
    ft4_packet[0xc] = 0;
    ft4_packet[0xd] = 0;
    ft4_packet[0x14] = 0x40;
    ft4_packet[0x15] = 0;
    ft4_packet[0x1c] = 0;
    ft4_packet[0x1d] = 0xf0;
    ft4_packet[0x24] = 0x40;
    ft4_packet[0x25] = 0xf0;
    *(short *)(ft4_packet + 8) = ts1;
    *(u_short *)(ft4_packet + 10) = 0;
    *(u_short *)(ft4_packet + 0x12) = 0;
    *(short *)(ft4_packet + 0x18) = ts1;
    *(u_short *)(ft4_packet + 0x1a) = 0xf0;
    *(u_short *)(ft4_packet + 0x22) = 0xf0;
    ft4_packet[4] = 0x80;
    ft4_packet[5] = 0x80;
    ft4_packet[6] = 0x80;
    if (buf_idx == 0) {
      tu1 = x_remain & 0x3ff;
    }
    else {
      tu1 = (x_pos & 0xfU) << 6;
    }
    *(u_short *)(ft4_packet + 0x16) = (u_short)(tu1 >> 6) | 0x110;
    x_remain = x_remain + 0x40;
    x_pos = x_pos + 1;
    xo = xo + 0x40;
  } while (x_pos < 5);
  return;
}

/* ---- Render_InitBlurMode__Fv  [RENDER.CPP:773-785] SLD-VERIFIED ---- */
void Render_InitBlurMode(void)

{
  if (GameSetup_gData.sgge == 0x20) {
    Render_gBlurEffectMode = 0x1b;
    return;
  }
  if (GameSetup_gData.sgge < 0x21) {
    if (GameSetup_gData.sgge != 0x10) {
      return;
    }
    Render_gBlurEffectMode = 0xb;
    return;
  }
  if (GameSetup_gData.sgge != 0x40) {
    return;
  }
  Render_gBlurEffectMode = 0x1f;
  return;
}

/* ---- Render_InsertDepthOfField__Fv  [RENDER.CPP:790-836] SLD-VERIFIED ---- */
void Render_InsertDepthOfField(void)

{
  POLY_F4 * prim;
  DR_STP * stp_prim;
  short tpage;
  int pkt_addr24_a;
  int pkt_addr24_b;
  u_int *puVar1;
  int frame;
  DR_MODE *dr_mode;
  int i;
  int pkt_addr24_c;
  int players;
  RECT rec;
  void *prev_pkt_drm2;
  void *prev_pkt_drm;
  u_char *cur_pkt_poly;
  u_char *cur_pkt_stp;
  void *prev_pkt_stp;
  u_char *cur_pkt_drm;
  
  if ((Render_gBlurEffectMode & 1U) != 0) {
    if ((Render_gBlurEffectMode & 8U) != 0) {
      StampImage(1,Render_gBlurEffectDepth1);
    }
    if ((Render_gBlurEffectMode & 0x10U) != 0) {
      StampImage(2,Render_gBlurEffectDepth2);
    }
    cur_pkt_poly = Render_gPacketPtr;
    puVar1 = (u_int *)(Render_gPalettePtr + Render_gBlurEffectDepth1 * 4);
    *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *puVar1 & 0xffffff;
    pkt_addr24_a = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0x18;
    *puVar1 = *puVar1 & 0xff000000 | pkt_addr24_a;
    cur_pkt_poly[3] = 5;
    cur_pkt_poly[7] = 0x2a;
    *(u_short *)(cur_pkt_poly + 8) = 0;
    *(u_short *)(cur_pkt_poly + 10) = 0;
    *(u_short *)(cur_pkt_poly + 0xc) = 0x140;
    *(u_short *)(cur_pkt_poly + 0xe) = 0;
    *(u_short *)(cur_pkt_poly + 0x10) = 0;
    cur_pkt_poly[4] = 0;
    cur_pkt_poly[5] = 0;
    cur_pkt_poly[6] = 0;
    cur_pkt_stp = Render_gPacketPtr;
    *(u_short *)(cur_pkt_poly + 0x12) = 0xf0;
    *(u_short *)(cur_pkt_poly + 0x14) = 0x140;
    *(u_short *)(cur_pkt_poly + 0x16) = 0xf0;
    puVar1 = (u_int *)(Render_gPalettePtr + Render_gBlurEffectDepth1 * 4);
    *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *puVar1 & 0xffffff;
    pkt_addr24_b = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0xc;
    *puVar1 = *puVar1 & 0xff000000 | pkt_addr24_b;
    SetDrawStp((DR_STP *)cur_pkt_stp,1);
    cur_pkt_drm = Render_gPacketPtr;
    puVar1 = (u_int *)(Render_gPalettePtr + Render_gBlurEffectDepth1 * 4);
    *(u_int *)Render_gPacketPtr = *(u_int *)Render_gPacketPtr & 0xff000000 | *puVar1 & 0xffffff;
    pkt_addr24_c = (u_int)Render_gPacketPtr & 0xffffff;
    Render_gPacketPtr = Render_gPacketPtr + 0xc;
    *puVar1 = *puVar1 & 0xff000000 | pkt_addr24_c;
    tpage = GetTPage(2,1,0,0x100);
    SetDrawMode((DR_MODE *)cur_pkt_drm,0,0,(u_int)(u_short)tpage,(RECT *)0x0);
  }
  return;
}

/* end of render.cpp */
