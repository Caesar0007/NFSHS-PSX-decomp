/* game/common/render.cpp -- RECONSTRUCTED (NFS4 PSX render orchestration; C++ TU)
 *   6 fns: Scene_Init/DeInit/PurgeScene/BuildCustomSceneList/LoadSceneFile + GetPlaneY.
 *   GTE-free. Full SYM-locals applied.
 */
#include "render_types.h"
#include "render_externs.h"

struct Render_PTag {
  unsigned int addr : 24;
  unsigned int len : 8;
  u_char r0, g0, b0, code;
};

#define RENDER_SETADDR(p,a) (((Render_PTag *)(p))->addr = (u_long)(a))
#define RENDER_GETADDR(p)   ((u_long)((Render_PTag *)(p))->addr)
#define RENDER_ADDPRIM(ot,p) \
  (RENDER_SETADDR((p),RENDER_GETADDR(ot)),RENDER_SETADDR((ot),(p)))
#define RENDER_SETPOLYF4(p) \
  (((Render_PTag *)(p))->len = 5,((Render_PTag *)(p))->code = 0x28)
#define RENDER_SETSEMITRANS(p) \
  (((Render_PTag *)(p))->code = ((Render_PTag *)(p))->code | 2)
#define RENDER_SETXY4(p,_x0,_y0,_x1,_y1,_x2,_y2,_x3,_y3) \
  ((p)->x0=(_x0),(p)->y0=(_y0),(p)->x1=(_x1),(p)->y1=(_y1), \
   (p)->x2=(_x2),(p)->y2=(_y2),(p)->x3=(_x3),(p)->y3=(_y3))
#define RENDER_SETRGB0(p,_r,_g,_b) \
  ((p)->r0=(_r),(p)->g0=(_g),(p)->b0=(_b))

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
/* SYM declares one 8-byte RECT at 0x8013d3d4.  render.obj's proven -G8 build
   identity keeps that honest aggregate gp-relative and makes Render_Render
   byte-exact.  rpause.obj intentionally keeps zero-storage short views of the
   four addresses because its retail object names the interior addresses
   independently; those declarations do not create additional storage. */
RECT         gPauseMenuRect;   /* @0x8013d3d4  (bss(zero)); x/y/w/h @ +0/+2/+4/+6 */
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
  
  if (Render_GameSetupWords[3] == 1) {
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
  *(int *)0x1F80000C = Render_GameSetupWords[11];
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
  int ViewID;
  int Player;

  if (pause != 0) {
    if (gPauseRender == 0) {
      gPauseRender = 1;
      gPauseMenuRect.w = 0x140;
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
  else {
    if (gPauseRender != 0) {
      gPauseRender = 0;
    }
    else {
      if (Render_GameSetupWords[3] == 1) {
        Render_StartFrameRender();
        Render_RenderPlayerView(Draw_gPlayer1View,0);
        ViewID = Draw_gPlayer2View;
        Player = 1;
      }
      else {
        Render_StartFrameRender();
        ViewID = Draw_gPlayer1View;
        Player = 0;
      }
      Render_RenderPlayerView(ViewID,Player);
      Hud_Render();
      Render_RenderDebugView();
      Render_StopFrameRender();
    }
  }
  return;
}

/* ---- FlareThing__Fv  [RENDER.CPP:535-555] SLD-VERIFIED ---- */
void FlareThing(void)

{
  int players;
  
  players = 1;
  if (Render_GameSetupWords[3] == 1) {
    players = 2;
  }
  for (int i = 0; i < players; i++) {
    if (gFlare_LensFlare.isDrawn[i] != '\0') {
      RECT rec;

      rec.x = gEnviro[gFlip].disp.disp.x + gFlare_LensFlare.oldpos[i].vx - 2;
      rec.y = gEnviro[gFlip].disp.disp.y + gFlare_LensFlare.oldpos[i].vy - 2;
      rec.w = 5;
      rec.h = 5;
      StoreImage(&rec,(u_long *)gFlare_LensFlare.screenData[i]);
      gFlare_LensFlare.isDrawn[i] = '\0';
    }
  }
  return;
}

/* ---- Render_InitTrackRender__Fv  [RENDER.CPP:563-596] SLD-VERIFIED ---- */
void Render_InitTrackRender(void)

{
  TrackSpec_Load(Render_GameSetupWords[18],Render_GameSetupWords[21]);
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
  Draw_SetDrawSyncCallback((void (*)(void))0x0);
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
  struct StampTag {
    u_int addr : 24;
    u_int len : 8;
  };
  POLY_FT4 *ft4_p;
  int frame;
  int i;
  int tpageX;
  int x;

  if ((Render_gBlurEffectMode & 2U) != 0) {
    frame = gFlip;
  }
  else {
    frame = 1 - gFlip;
  }
  if ((Render_gBlurEffectMode & 4U) == 0) {
    xo = 0;
  }
  for (i = 0; i < 5; i = i + 1) {
    x = xo + (i << 6);
    ft4_p = (POLY_FT4 *)Render_gPacketPtr;
    ((StampTag *)ft4_p)->addr =
        ((StampTag *)(Render_gPalettePtr + depth * 4))->addr;
    Render_gPacketPtr = (u_char *)ft4_p + 0x28;
    ((StampTag *)(Render_gPalettePtr + depth * 4))->addr = (u_int)ft4_p;
    ((u_char *)ft4_p)[3] = 9;
    ft4_p->code = 0x2e;
    ft4_p->x1 = x + 0x40;
    ft4_p->x3 = x + 0x40;
    ft4_p->u0 = 0;
    ft4_p->v0 = 0;
    ft4_p->u1 = 0x40;
    ft4_p->v1 = 0;
    ft4_p->u2 = 0;
    ft4_p->v2 = 0xf0;
    ft4_p->u3 = 0x40;
    ft4_p->v3 = 0xf0;
    ft4_p->x0 = x;
    ft4_p->y0 = 0;
    ft4_p->y1 = 0;
    ft4_p->x2 = x;
    ft4_p->y2 = 0xf0;
    ft4_p->y3 = 0xf0;
    ft4_p->r0 = 0x80;
    ft4_p->g0 = 0x80;
    ft4_p->b0 = 0x80;
    tpageX = i << 6;
    ft4_p->tpage =
        (u_short)(((frame == 0 ? (i + 5) << 6 : tpageX) & 0x3ff) >> 6 | 0x110);
  }
  return;
}

/* ---- Render_InitBlurMode__Fv  [RENDER.CPP:773-785] SLD-VERIFIED ---- */
void Render_InitBlurMode(void)

{
  switch (Render_GameSetupWords[14]) {
  case 0x10:
    Render_gBlurEffectMode = 0xb;
    break;
  case 0x20:
    Render_gBlurEffectMode = 0x1b;
    break;
  case 0x40:
    Render_gBlurEffectMode = 0x1f;
    break;
  }
  return;
}

/* ---- Render_InsertDepthOfField__Fv  [RENDER.CPP:790-836] SLD-VERIFIED ---- */
void Render_InsertDepthOfField(void)

{
  /* MATCH/SYM(8c @800b3a6c, W57-A12 05A+rule-8 pass): the SYM lists EXACTLY three locals --
     prim (REG $6 = $a2), stp_prim (REG $4 = $a0), dr_mode (REG $0x10 = $s0) -- each in its OWN
     block scope (three 90/92 Block start/end pairs, all at $800b3ac8). Applied here: (a) the
     Ghidra `tpage` local is NOT in the SYM -> GetTPage feeds SetDrawMode inline; (b) the OT-slot
     pointer is a PER-BLOCK temp (fresh pseudo per block) -> reproduces the oracle's a0/a2/t0
     rotation instead of one function-scope $t0; (c) SLD 819 groups all EIGHT halfword stores as
     ONE statement (setXY4 order x0,y0,x1,y1,x2,y2,x3,y3), SLD 820 the setRGB0 triple after it
     (Ghidra had emitted r0/g0/b0 in the middle of the XY chain).
     RESULT: blocks 2 and 3 now carry the oracle's exact register map (stp_prim=$a0/ot=$a2;
     dr_mode=$s0/ot=$t0). RESIDUAL = block 1 only, a pure $a0<->$a2 swap (prim=$a0 ours vs $a2
     retail) with the instruction COUNT exact (120/120).
     NAMED ANGLE (blocked-window receipt, for the sched1/local-alloc instrument lane): the whole
     if-body is ONE basic block, so prim/ot/stp_prim/dr_mode are all local_alloc QTYs. stp_prim and
     dr_mode are GROUP-1 (copy-suggested $a0 from SetDrawStp/SetDrawMode arg 1); dr_mode crosses the
     GetTPage call so it is pushed to a callee-saved $s0. In GROUP 2 prim has the top QTY_CMP_PRI and
     takes the first free reg by numeric scan: $v0/$v1 live, $a1 pinned by the hoisted `li a1,1`
     (SetDrawStp arg 2), so the ONLY thing that can push prim off $a0 is stp_prim's $a0 window
     OVERLAPPING prim's. In retail sched1 hoisted stp_prim's `lw $a0,0($s3)` up INTO prim's setXY4
     chain (oracle idx 61, before prim's last use at 65) -> windows overlap -> prim = $a2. Our sched1
     hoists the OT-slot `lw $v0,0($gp)` there instead and emits stp_prim's load at idx 67, 2 insns
     after prim dies -> no overlap -> prim = $a0. All 8 statement-order permutations of the three
     blocks were measured: byte-identical output (92) -- sched1's ready-list tie-break is
     source-invariant here. => the 06E/07E LOCAL-ALLOC/SCHED1 instrument gap, not a source shape. */
  if ((Render_gBlurEffectMode & 1U) != 0) {
    if ((Render_gBlurEffectMode & 8U) != 0) {
      StampImage(1,Render_gBlurEffectDepth1);
    }
    if ((Render_gBlurEffectMode & 0x10U) != 0) {
      StampImage(2,Render_gBlurEffectDepth2);
    }
    {
      POLY_F4 *prim;

      prim = (POLY_F4 *)Render_gPacketPtr;
      RENDER_ADDPRIM(Render_gPalettePtr + Render_gBlurEffectDepth1 * 4,prim);
      Render_gPacketPtr = (u_char *)prim + 0x18;
      RENDER_SETPOLYF4(prim);
      RENDER_SETSEMITRANS(prim);
      RENDER_SETXY4(prim,0,0,0x140,0,0,0xf0,0x140,0xf0);
      RENDER_SETRGB0(prim,0,0,0);
    }
    {
      DR_STP *stp_prim;

      stp_prim = (DR_STP *)Render_gPacketPtr;
      RENDER_ADDPRIM(Render_gPalettePtr + Render_gBlurEffectDepth1 * 4,stp_prim);
      Render_gPacketPtr = (u_char *)stp_prim + 0xc;
      SetDrawStp(stp_prim,1);
    }
    {
      DR_MODE *dr_mode;

      dr_mode = (DR_MODE *)Render_gPacketPtr;
      RENDER_ADDPRIM(Render_gPalettePtr + Render_gBlurEffectDepth1 * 4,dr_mode);
      Render_gPacketPtr = (u_char *)dr_mode + 0xc;
      SetDrawMode(dr_mode,0,0,(u_int)(u_short)GetTPage(2,1,0,0x100),(RECT *)0x0);
    }
  }
  return;
}

/* end of render.cpp */
