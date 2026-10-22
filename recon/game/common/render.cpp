/* game/common/render.cpp -- RECONSTRUCTED (NFS4 PSX render orchestration; C++ TU)
 *   23 retail-debug-covered render orchestration and primitive functions.
 *   GTE-free. Full SYM-locals applied.
 */
#include "render_types.h"
#include "render_externs.h"

/* retail: this object's read-only data opens with the unreferenced "SimpleMem" tag (0x80056534): the unused inline of the
 * SimpleMem class header leaves it behind in every object that saw the header (tools/psyq_pipe/simplemem_apply.py). */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

struct Render_PTag { /* SOURCE-REVIEW-UNRESOLVED: reconstruction view/name, not supplied by retail; SDK typedef trials add unmatched records. */
  unsigned int addr : 24;
  unsigned int len : 8;
  u_char r0, g0, b0, code;
};

/* PsyQ 4.3 LIBGPU.H interfaces/argument counts, over the existing tag view.
 * The unresolved view type is NOT made canonical by these macro names. */
#define setlen(p,_len) (((Render_PTag *)(p))->len = (u_char)(_len))
#define setaddr(p,_addr) (((Render_PTag *)(p))->addr = (u_long)(_addr))
#define setcode(p,_code) (((Render_PTag *)(p))->code = (u_char)(_code))
#define getcode(p) ((u_char)(((Render_PTag *)(p))->code))
#define getaddr(p) ((u_long)(((Render_PTag *)(p))->addr))
#define addPrim(ot,p) (setaddr((p),getaddr(ot)),setaddr((ot),(p)))
#define setPolyF4(p) (setlen((p),5),setcode((p),0x28))
#define setPolyFT4(p) (setlen((p),9),setcode((p),0x2c))
#define setSemiTrans(p,abe) \
  ((abe) ? setcode((p),getcode(p)|0x02) : setcode((p),getcode(p)&~0x02))
#define setXY4(p,_x0,_y0,_x1,_y1,_x2,_y2,_x3,_y3) \
  ((p)->x0=(_x0),(p)->y0=(_y0),(p)->x1=(_x1),(p)->y1=(_y1), \
   (p)->x2=(_x2),(p)->y2=(_y2),(p)->x3=(_x3),(p)->y3=(_y3))
#define setRGB0(p,_r0,_g0,_b0) \
  ((p)->r0=(_r0),(p)->g0=(_g0),(p)->b0=(_b0))
#define setXYWH(p,_x0,_y0,_w,_h) \
  ((p)->x0=(_x0),(p)->y0=(_y0),(p)->x1=(_x0)+(_w),(p)->y1=(_y0), \
   (p)->x2=(_x0),(p)->y2=(_y0)+(_h),(p)->x3=(_x0)+(_w),(p)->y3=(_y0)+(_h))
#define setUVWH(p,_u0,_v0,_w,_h) \
  ((p)->u0=(_u0),(p)->v0=(_v0),(p)->u1=(_u0)+(_w),(p)->v1=(_v0), \
   (p)->u2=(_u0),(p)->v2=(_v0)+(_h),(p)->u3=(_u0)+(_w),(p)->v3=(_v0)+(_h))
#define getTPage(tp,abr,x,y) \
  ((((tp)&0x3)<<7)|(((abr)&0x3)<<5)|(((y)&0x100)>>4)|(((x)&0x3ff)>>6)|(((y)&0x200)<<2))

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

/* PSX scratchpad fields are not linked render.obj storage.  Retail addresses
   them through literal 0x1F8000xx constants and the typed draw-cache views;
   Render_gPacketPtr/Render_gPalettePtr and gScratchLastWord are the surviving
   fixed-address lvalue macros.  Do not materialize scratchpad offsets as BSS. */

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


/* ---- Render_CreatePlayerViews__Fv  [RENDER.CPP:92-124] SLD-CHECK-REQUIRED ---- */
#line 90 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_CreatePlayerViews(void)

{

  if (GameSetup_gData.commMode == 1) {





    Draw_gPlayer1View = Draw_SetView(0,0x100,0x140,0x100,0x140,0x78,0,1,2000);




    Draw_gPlayer2View = Draw_SetView(0,0x178,0x140,0x178,0x140,0x78,0,1,2000);
  }
  else {







    Draw_gPlayer1View = Draw_SetView(0,0x100,0x140,0x100,0x140,0xf0,0,1,3000);








    Draw_gPlayer2View = -1; } return; }

/* ---- Render_CreatePauseMenuViews__Fv  [RENDER.CPP:140-145] SLD-CHECK-REQUIRED ---- */
#line 138 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_CreatePauseMenuViews(void)

{




  Render_gPauseMenuView = Draw_SetView(0,0x100,0x140,0x100,0x140,0xf0,0,0,1); return; }

/* ---- Render_CreateViews__Fv  [RENDER.CPP:151-163] SLD-CHECK-REQUIRED ---- */
#line 149 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_CreateViews(void)

{

  Draw_InitViews();

  Render_CreatePlayerViews();

  Hud_CreateHudViews();





  Render_CreatePauseMenuViews(); return; }

/* ---- Render_StartRenderingWorldView__Fi  [RENDER.CPP:169-209] SLD-CHECK-REQUIRED ---- */
#line 167 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_StartRenderingWorldView(int viewid)

{


  Camera_SetCamera(&gCView);







  Track_AnimateTrackLighting();




  Draw_StartRenderingView(viewid);












  *(int *)0x1F80000C = GameSetup_gData.mirrorTrack;




  Fog_Update(gCView.player);

  DrawC_SetEnviroment();

  TrsProj_ResetTransPrecision();

  Night_SetEnviroment(&gCView); return; }

/* ---- Render_StopRenderingWorldView__Fi  [RENDER.CPP:215-217] SLD-CHECK-REQUIRED ---- */
#line 213 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_StopRenderingWorldView(int viewid)

{

  Draw_StopRenderingView(viewid);
}

/* ---- Render_RenderWorld__FP13DRender_tView  [RENDER.CPP:223-255] SLD-CHECK-REQUIRED ---- */
#line 221 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_RenderWorld(DRender_tView *Vi)

{
  int savesp;



  BWorld_OnyxBuildFacets(Vi);



  savesp = (int)SetSp((u_long)&gScratchLastWord);
  Skidmark_OnyxBuildFacets(Vi);
  SetSp((u_long)savesp);


  savesp = (int)SetSp((u_long)&gScratchLastWord);
  Souffle_InsertFacet(Vi);
  SetSp((u_long)savesp);


  R3DCar_InsertAllListFacet(Vi);



  Hrz_BuildHorizon(Vi);


  savesp = (int)SetSp((u_long)&gScratchLastWord);
  Weather_BuildWeather(Vi);
  SetSp((u_long)savesp);

  Render_InsertDepthOfField();

  return; }

/* ---- Render_RenderPlayerView__Fii  [RENDER.CPP:270-280] SLD-CHECK-REQUIRED ---- */
#line 268 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_RenderPlayerView(int ViewID,int Player)

{

  gCView.id = ViewID;
  gCView.player = Player;


  Render_StartRenderingWorldView(ViewID);

  Render_RenderWorld(&gCView);

  Render_StopRenderingWorldView(ViewID); return; }

/* ---- Render_RenderDebugView__Fv  [RENDER.CPP:332-354] SLD-CHECK-REQUIRED ---- */
#line 330 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_RenderDebugView(void)

{





















}

/* ---- Render_StartFrameRender__Fv  [RENDER.CPP:359-371] SLD-CHECK-REQUIRED ---- */
#line 357 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_StartFrameRender(void)

{

  BWorld_StartLoop();

  Track_AnimateTextures();

  Souffle_DoSouffle();



  Draw_CheckFirstFrameRender();

  Draw_StartFrameRender(); return; }

/* ---- Render_StopFrameRender__Fv  [RENDER.CPP:375-379] SLD-CHECK-REQUIRED ---- */
#line 373 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_StopFrameRender(void)

{



  Draw_StopFrameRender(); return; }

/* ---- Render_InitPauseMenu__Fv  [RENDER.CPP:387-389] SLD-CHECK-REQUIRED ---- */
#line 385 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_InitPauseMenu(void)

{

  MPause_InitMPause();
}

/* ---- Render_RenderPauseMenuView__Fv  [RENDER.CPP:393-407] SLD-CHECK-REQUIRED ---- */
#line 391 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_RenderPauseMenuView(void)

{
  int ogFlip;


  gCView.id = Render_gPauseMenuView;

  Draw_StartRenderingView(Render_gPauseMenuView);


  MPause_Render();

  ogFlip = gFlip; gFlip = 0;

  Draw_StopRenderingView(Render_gPauseMenuView);
  gFlip = ogFlip; return; }

/* ---- Render_KillPauseMenu__Fv  [RENDER.CPP:411-413] SLD-CHECK-REQUIRED ---- */
#line 409 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_KillPauseMenu(void)

{

  MPause_KillMPause();
}

/* ---- Render_Render__Fi  [RENDER.CPP:417-525] SLD-CHECK-REQUIRED ---- */
/* Per-arm frame completion is real work, performed once on either mode path.
 * Stock GCC merges these tails; the split-arm return supplies retail's489.
 * Erased-copy call coordinates/literal original spelling remain unproved.
 * Receipts: build/nc12/render_pause_tail_20261022. */
#line 415 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_Render(int pause)

{













  if (pause != 0) {


    if (gPauseRender == 0) {

      gPauseRender = 1;


      gPauseMenuRect.x = 0;
      gPauseMenuRect.y = 0;
      gPauseMenuRect.w = 0x140;
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

      if (GameSetup_gData.commMode == 1) {


        Render_StartFrameRender();

        Render_RenderPlayerView(Draw_gPlayer1View,0);

        Render_RenderPlayerView(Draw_gPlayer2View,1);

        Hud_Render();
        Render_RenderDebugView();
        Render_StopFrameRender();

        return; }





      else {




        Render_StartFrameRender();

        Render_RenderPlayerView(Draw_gPlayer1View,0);





      }



      Hud_Render();

      Render_RenderDebugView();

      Render_StopFrameRender();








    } } return; }

/* ---- FlareThing__Fv  [RENDER.CPP:535-555] SLD-CHECK-REQUIRED ---- */
#line 533 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void FlareThing(void)

{
  int players;

  players = 1;
  if (GameSetup_gData.commMode == 1) {
    players = 2;
  }
  for (int i = 0; i < players; i++) {

    if (gFlare_LensFlare.isDrawn[i] != '\0')
    {
      RECT rec;
      rec.x = gEnviro[gFlip].disp.disp.x + gFlare_LensFlare.oldpos[i].vx - 2;
      rec.y = gEnviro[gFlip].disp.disp.y + gFlare_LensFlare.oldpos[i].vy - 2;
      rec.w = 5;
      rec.h = 5;

      StoreImage(&rec,(u_long *)gFlare_LensFlare.screenData[i]);
      gFlare_LensFlare.isDrawn[i] = '\0'; }

  } return; }

/* ---- Render_InitTrackRender__Fv  [RENDER.CPP:563-596] SLD-CHECK-REQUIRED ---- */
#line 561 "C:/nfs4/GAME/COMMON/RENDER.CPP"
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
  Render_InitBlurMode(); return; }

/* ---- Render_RestartTrackRender__Fv  [RENDER.CPP:600-608] SLD-CHECK-REQUIRED ---- */
#line 598 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_RestartTrackRender(void)

{
  Draw_RestartRenderEngine();

  DepthCue_Init();

  Night_RestartNightDriving();
  Skidmark_RestartSkidmark();
  Souffle_RestartTrackSouffle();
  TrgSfx_RestartTrgSfx(); return; }

/* ---- Render_InitTrackRenderPostSim__Fv  [RENDER.CPP:612-619] SLD-CHECK-REQUIRED ---- */
#line 610 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_InitTrackRenderPostSim(void)

{

  gPauseRender = 0;
  Texture_DeInitPaletteSharing();



  CV_InitColorVertices(); return; }

/* ---- Render_KillTrackRender__Fv  [RENDER.CPP:624-634] SLD-CHECK-REQUIRED ---- */
#line 622 "C:/nfs4/GAME/COMMON/RENDER.CPP"
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
}

/* ---- Render_InitLibRender__Fv  [RENDER.CPP:640-641] ----
 * One call plus implicit void fallthrough matches all eight retail words,
 * SLD tags and block/function-end source lines. */
#line 638 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_InitLibRender(void)

{
  Draw_InitLibRender(); }

/* ---- StampImage__Fii  [RENDER.CPP:711-769] SLD-CHECK-REQUIRED ---- */
/* SDK tag-view provenance remains unresolved; see the source/type receipts.
 * The primitive header, UV/XY rectangle, RGB and texture-page operations below
 * use canonical SDK interfaces, with retail-derived statement coordinates.
 * Exact original macro/comment spelling is not uniquely proved by SLD. */
#line 709 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void StampImage(int xo,int depth)

{
  POLY_FT4 *ft4_p;
  int frame;

  if ((Render_gBlurEffectMode & 2U) != 0) {
    frame = gFlip;
  } else {
    frame = 1 - gFlip;
  }
  if ((Render_gBlurEffectMode & 4U) == 0) {
    xo = 0;
  }









  for (int i = 0; i < 5; i = i + 1) {


    ft4_p = (POLY_FT4 *)Render_gPacketPtr; addPrim(Render_gPalettePtr + depth * 4,ft4_p); Render_gPacketPtr = (u_char *)ft4_p + 0x28;

    setPolyFT4(ft4_p);
    setSemiTrans(ft4_p,1);

    setUVWH(ft4_p,0,0,0x40,0xf0);
    setXYWH(ft4_p,xo + (i << 6),0,0x40,0xf0);
    setRGB0(ft4_p,0x80,0x80,0x80);
    ft4_p->tpage = (u_short)getTPage(2,0,(frame == 0 ? (i + 5) << 6 : i << 6),0x100);

























  } return; }

/* ---- Render_InitBlurMode__Fv  [RENDER.CPP:773-785] SLD-CHECK-REQUIRED ---- */
#line 771 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_InitBlurMode(void)

{
  switch (GameSetup_gData.sgge) {
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
  return; }

/* ---- Render_InsertDepthOfField__Fv  [RENDER.CPP:790-836] SLD-CHECK-REQUIRED ---- */
  /* HISTORICAL W57-A12 notes; current SOURCE-ONLY gate is120/120 PASS. SYM lists three locals --
     prim (REG $6 = $a2), stp_prim (REG $4 = $a0), dr_mode (REG $0x10 = $s0) -- each in its OWN
     block scope (three 90/92 Block start/end pairs, all at $800b3ac8) directly under the function
     block (an `if` around them would add two scopes, so the mode test is an early return). Applied
     here: (a) the Ghidra `tpage` local is NOT in the SYM -> GetTPage feeds SetDrawMode inline; (b)
     the OT-slot pointer is a PER-BLOCK temp (fresh pseudo per block) -> reproduces the oracle's
     a0/a2/t0 rotation instead of one function-scope $t0; (c) SLD 819 groups all EIGHT halfword
     stores as ONE statement (setXY4 order x0,y0,x1,y1,x2,y2,x3,y3), SLD 820 the setRGB0 triple
     after it (Ghidra had emitted r0/g0/b0 in the middle of the XY chain).
     RESULT: blocks 2 and 3 now carry the oracle's exact register map (stp_prim=$a0/ot=$a2;
     dr_mode=$s0/ot=$t0). RESIDUAL = block 1 only, a pure $a0<->$a2 swap (prim=$a0 ours vs $a2
     retail) with the instruction COUNT exact (120/120).
     HISTORICAL ANGLE (then-current window, not a present floor or exemption): the whole
     if-body is ONE basic block, so prim/ot/stp_prim/dr_mode are all local_alloc QTYs. stp_prim and
     dr_mode are GROUP-1 (copy-suggested $a0 from SetDrawStp/SetDrawMode arg 1); dr_mode crosses the
     GetTPage call so it is pushed to a callee-saved $s0. In GROUP 2 prim has the top QTY_CMP_PRI and
     takes the first free reg by numeric scan: $v0/$v1 live, $a1 pinned by the hoisted `li a1,1`
     (SetDrawStp arg 2), so the ONLY thing that can push prim off $a0 is stp_prim's $a0 window
     OVERLAPPING prim's. In retail sched1 hoisted stp_prim's `lw $a0,0($s3)` up INTO prim's setXY4
     chain (oracle idx 61, before prim's last use at 65) -> windows overlap -> prim = $a2. Our sched1
     hoists the OT-slot `lw $v0,0($gp)` there instead and emits stp_prim's load at idx 67, 2 insns
     after prim dies -> no overlap -> prim = $a0. Eight old statement-order trials were bounded
     then-source controls, not proof of source invariance. The present strict gate PASSes;
     full SLD and the unprovided global tag-view producer/name remain separate review work. */
#line 788 "C:/nfs4/GAME/COMMON/RENDER.CPP"
void Render_InsertDepthOfField(void)

{












  if ((Render_gBlurEffectMode & 1U) == 0) return;


  if ((Render_gBlurEffectMode & 8U) != 0) {
    StampImage(1,Render_gBlurEffectDepth1);
  }
  if ((Render_gBlurEffectMode & 0x10U) != 0) {
    StampImage(2,Render_gBlurEffectDepth2);
  }
  {
    POLY_F4 *prim;


    prim = (POLY_F4 *)Render_gPacketPtr; addPrim(Render_gPalettePtr + Render_gBlurEffectDepth1 * 4,prim); Render_gPacketPtr = (u_char *)prim + 0x18;
    setPolyF4(prim);
    setSemiTrans(prim,1);
    setXY4(prim,0,0,0x140,0,0,0xf0,0x140,0xf0);
    setRGB0(prim,0,0,0);
  }
  {
    DR_STP *stp_prim;


    stp_prim = (DR_STP *)Render_gPacketPtr; addPrim(Render_gPalettePtr + Render_gBlurEffectDepth1 * 4,stp_prim); Render_gPacketPtr = (u_char *)stp_prim + 0xc;
    SetDrawStp(stp_prim,1);
  }
  {
    DR_MODE *dr_mode;


    dr_mode = (DR_MODE *)Render_gPacketPtr; addPrim(Render_gPalettePtr + Render_gBlurEffectDepth1 * 4,dr_mode); Render_gPacketPtr = (u_char *)dr_mode + 0xc;
    SetDrawMode(dr_mode,0,0,GetTPage(2,1,0,0x100),(RECT *)0x0);
  }
}

/* end of render.cpp */
