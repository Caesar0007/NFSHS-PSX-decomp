/* game/psx/draw.cpp -- RECONSTRUCTED (NFS4 PSX base render-management; C++ TU)
 *   25 fns: view/OT setup (Draw_SetView/InitViews/InitViewOT[InGame]/DeInitViews), primitive-buffer
 *   alloc/clear, frame render start/stop (Start/StopRenderingView, Start/StopFrameRender), draw
 *   environment, render-engine init. GTE-free (0 cop2 stubs). Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "draw_externs.h"

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
int Draw_SetView(int x0,int y0,int x1,int y1,int w,int h,int dtd,int isbg,int otsize);
void Draw_InitViews(void);
void Draw_InitViewOT(void);
void Draw_InitViewOTInGame(void);
void Draw_DeInitViews(void);
void Draw_DeInitViewsInGame(void);
DRAWENV * Draw_GetDRAWENV(int viewid,int page);
void Draw_SetViewMemBudget(int viewid,int totalmem);
void Draw_SetViewColor(int viewid,int r,int g,int b);
void AllocatePrimitivesBuffer(void);
void ClearPrimitivesBuffer(void);
void ClearPlatformPrimitivesBuffer(void);
void Draw_StartRenderingView(int viewid);
void Draw_StopRenderingView(int viewid);
void Draw_CheckFirstFrameRender(void);
void Draw_StartFrameRender(void);
void Draw_SetDrawSyncCallback(fn_void *p);
void Draw_StopFrameRender(void);
void Draw_DrawDirectScreen(shapetbl *tile,int x,int y);
void Draw_DirectSetEnvironment(int x,int y,int w,int h,int edraw,int edisplay,int erase,int r,int g,int b);
void Draw_SetEnvironment(int w,int h,int edraw,int edisplay,int erase,int r,int g,int b);
void Draw_InitRenderEngine(int x0,int y0,int x1,int y1,int w,int h);
void Draw_RestartRenderEngine(void);
void Draw_DeInitRenderEngine(void);
void Draw_InitLibRender(void);


/* ---- Draw_SetView__Fiiiiiiiii  [DRAW.CPP:72-101] SLD-VERIFIED ---- */
int Draw_SetView(int x0,int y0,int x1,int y1,int w,int h,int dtd,int isbg,int otsize)

{
  int iVar1;
  int iVar2;
  Draw_tView *newview;
  Draw_tView *pDVar3;
  DRAWENV *e10;
  DRAWENV *e00;
  
  iVar1 = Draw_gNumView;
  pDVar3 = Draw_gView + Draw_gNumView;
  SetDefDrawEnv(Draw_gView[Draw_gNumView].drawenv,x0,y0,w,h);
  SetDefDrawEnv(Draw_gView[iVar1].drawenv + 1,x1,y1,w,h);
  Draw_gView[iVar1].drawenv[0].r0 = '\0';
  Draw_gView[iVar1].drawenv[0].g0 = '\0';
  Draw_gView[iVar1].drawenv[0].b0 = '\0';
  Draw_gView[iVar1].drawenv[1].r0 = '\0';
  Draw_gView[iVar1].drawenv[1].g0 = '\0';
  Draw_gView[iVar1].drawenv[1].b0 = '\0';
  Draw_gView[iVar1].drawenv[1].isbg = (u_char)isbg;
  Draw_gView[iVar1].drawenv[0].isbg = (u_char)isbg;
  Draw_gView[iVar1].drawenv[1].dtd = (u_char)dtd;
  Draw_gView[iVar1].drawenv[0].dtd = (u_char)dtd;
  iVar2 = Draw_gNumView;
  pDVar3->otsize = otsize;
  Draw_gView[iVar1].membudget = 0;
  Draw_gNumView = Draw_gNumView + 1;
  return iVar2;
}

/* ---- Draw_InitViews__Fv  [DRAW.CPP:113-114] SLD-VERIFIED ---- */
void Draw_InitViews(void)

{
  Draw_gNumView = 0;
  return;
}

/* ---- Draw_InitViewOT__Fv  [DRAW.CPP:127-134] SLD-VERIFIED ---- */
void Draw_InitViewOT(void)

{
  u_long *puVar1;
  Draw_tView *pDVar2;
  int i;
  int iVar3;
  
  pDVar2 = Draw_gView;
  for (iVar3 = 0; iVar3 < Draw_gNumView; iVar3 = iVar3 + 1) {
    puVar1 = reservememadr("ot0",pDVar2->otsize << 2,0x10);
    pDVar2->ot[0] = puVar1;
    puVar1 = reservememadr("ot1",pDVar2->otsize << 2,0x10);
    pDVar2->ot[1] = puVar1;
    pDVar2 = pDVar2 + 1;
  }
  return;
}

/* ---- Draw_InitViewOTInGame__Fv  [DRAW.CPP:138-145] SLD-VERIFIED ---- */
void Draw_InitViewOTInGame(void)

{
  u_long *puVar1;
  Draw_tView *pDVar2;
  int i;
  int iVar3;
  
  pDVar2 = Draw_gView;
  for (iVar3 = 0; iVar3 < Draw_gNumView; iVar3 = iVar3 + 1) {
    puVar1 = (u_long *)Platform_ReserveMemory(pDVar2->otsize << 2,"ot0");
    pDVar2->ot[0] = puVar1;
    puVar1 = (u_long *)Platform_ReserveMemory(pDVar2->otsize << 2,"ot1");
    pDVar2->ot[1] = puVar1;
    pDVar2 = pDVar2 + 1;
  }
  return;
}

/* ---- Draw_DeInitViews__Fv  [DRAW.CPP:157-168] SLD-VERIFIED ---- */
void Draw_DeInitViews(void)

{
  Draw_tView *pDVar1;
  int i;
  int iVar2;
  
  pDVar1 = Draw_gView;
  for (iVar2 = 0; iVar2 < Draw_gNumView; iVar2 = iVar2 + 1) {
    if (pDVar1->ot[0] != (u_long *)0x0) {
      purgememadr(pDVar1->ot[0]);
    }
    if (pDVar1->ot[1] != (u_long *)0x0) {
      purgememadr(pDVar1->ot[1]);
    }
    pDVar1->ot[0] = (u_long *)0x0;
    pDVar1->ot[1] = (u_long *)0x0;
    pDVar1 = pDVar1 + 1;
  }
  return;
}

/* ---- Draw_DeInitViewsInGame__Fv  [DRAW.CPP:172-183] SLD-VERIFIED ---- */
void Draw_DeInitViewsInGame(void)

{
  bool bVar1;
  int iVar2;
  Draw_tView *pDVar3;
  int iVar4;
  int i;
  
  iVar2 = Draw_gNumView;
  iVar4 = 0;
  pDVar3 = Draw_gView;
  while (bVar1 = iVar4 < iVar2, iVar4 = iVar4 + 1, bVar1) {
    pDVar3->ot[0] = (u_long *)0x0;
    pDVar3->ot[1] = (u_long *)0x0;
    pDVar3 = pDVar3 + 1;
  }
  return;
}

/* ---- Draw_GetDRAWENV__Fii  [DRAW.CPP:187-188] SLD-VERIFIED ---- */
DRAWENV * Draw_GetDRAWENV(int viewid,int page)

{
  return &Draw_gView[viewid].drawenv[page];
}

/* ---- Draw_SetViewMemBudget__Fii  [DRAW.CPP:197-198] SLD-VERIFIED ---- */
void Draw_SetViewMemBudget(int viewid,int totalmem)

{
  Draw_gView[viewid].membudget = totalmem;
  return;
}

/* ---- Draw_SetViewColor__Fiiii  [DRAW.CPP:213-219] SLD-VERIFIED ---- */
void Draw_SetViewColor(int viewid,int r,int g,int b)

{
  Draw_tView *view;

  view = &Draw_gView[viewid];
  if (view->drawenv[0].isbg != '\0') {
    view->drawenv[0].r0 = (u_char)r;
    view->drawenv[0].g0 = (u_char)g;
    view->drawenv[0].b0 = (u_char)b;
  }
  if (view->drawenv[1].isbg != '\0') {
    view->drawenv[1].r0 = (u_char)r;
    view->drawenv[1].g0 = (u_char)g;
    view->drawenv[1].b0 = (u_char)b;
  }
  return;
}

/* ---- AllocatePrimitivesBuffer__Fv  [DRAW.CPP:237-292] SLD-VERIFIED ---- */
void AllocatePrimitivesBuffer(void)

{
  Draw_tView * view0;
  Draw_tView * view1;
  Draw_tView *view;
  int iVar1;
  int iVar2;
  
  if (GameSetup_gData.commMode == 1) {
    Draw_InitViewOT();
  }
  else {
    Draw_InitViewOTInGame();
  }
  if (GameSetup_gData.commMode == 1) {
    gTotalMem = 0x22500;
  }
  else {
    gTotalMem = 0x1f600;
  }
  gEnviro[0].server = Platform_ReserveMemory(gTotalMem,"ps0");
  gEnviro[1].server = Platform_ReserveMemory(gTotalMem,"ps1");
  iVar1 = Draw_gPlayer2View;
  if (GameSetup_gData.commMode == 1) {
    iVar2 = (gTotalMem >> 1) + -0x1a00;
    Draw_gView[Draw_gPlayer1View].membudget = iVar2;
  }
  else {
    iVar2 = gTotalMem + -0x1a00;
    iVar1 = Draw_gPlayer1View;
  }
  Draw_gView[iVar1].membudget = iVar2;
  return;
}

/* ---- ClearPrimitivesBuffer__Fv  [DRAW.CPP:312-320] SLD-VERIFIED ---- */
void ClearPrimitivesBuffer(void)

{
  DrawSync(0);
  if (gEnviro[0].server != (char *)0x0) {
    purgememadr(gEnviro[0].server);
  }
  if (gEnviro[1].server != (char *)0x0) {
    purgememadr(gEnviro[1].server);
  }
  gEnviro[1].server = (char *)0x0;
  gEnviro[0].server = (char *)0x0;
  Draw_DeInitViews();
  return;
}

/* ---- ClearPlatformPrimitivesBuffer__Fv  [DRAW.CPP:325-339] SLD-VERIFIED ---- */
void ClearPlatformPrimitivesBuffer(void)

{
  DrawSync(0);
  gEnviro[1].server = (char *)0x0;
  gEnviro[0].server = (char *)0x0;
  if (GameSetup_gData.commMode == 1) {
    Draw_DeInitViews();
  }
  else {
    Draw_DeInitViewsInGame();
  }
  return;
}

/* ---- Draw_StartRenderingView__Fi  [DRAW.CPP:352-374] SLD-VERIFIED ---- */
void Draw_StartRenderingView(int viewid)

{
  int iVar1;
  Draw_tView *view;
  Draw_DCache *sd;
  
  view = Draw_gView + viewid;
  iVar1 = view->otsize * 7;
  Draw_gViewOtSize = view->otsize;
  if (iVar1 < 0) {
    iVar1 = iVar1 + 7;
  }
  Render_gPacketLenLo = Draw_gView[viewid].drawenv[0].clip.w;
  Render_gPacketLenHi = Draw_gView[viewid].drawenv[0].clip.h;
  Draw_gMidGroundOtz = iVar1 >> 3;
  Render_gPalettePtr = (u_char *)view->ot[gFlip];
  if ((viewid == Draw_gPlayer1View) || (viewid == Draw_gPlayer2View)) {
    Render_gPacketEnd = Render_gPacketPtr + Draw_gView[viewid].membudget;
  }
  else {
    Render_gPacketEnd = Draw_gMaxPrim;
  }
  Render_gMenuRenderFlag = 0;
  return;
}

/* ---- Draw_StopRenderingView__Fi  [DRAW.CPP:387-398] SLD-VERIFIED ---- */
void Draw_StopRenderingView(int viewid)

{
  int iVar1;
  DRAWENV *pDVar2;
  int drawEnv_offs;
  int src_iter;
  int src_next;
  DR_ENV *pEnv;
  Draw_tView *view;
  int viewSlot;
  int pkt_addr24;
  int lEnv_iter;
  int src_w1;
  u_int tu13;
  int src_w2;
  u_int tu14;
  int src_w3;
  DRAWENV LEnv;
  u_char *prev_pkt;
  u_char *cur_pkt;
  
  cur_pkt = Render_gPacketPtr;
  prev_pkt = Render_gPalettePtr;
  viewSlot = (int)(Draw_gView + viewid);
  drawEnv_offs = viewSlot + gFlip * 0x5c;
  iVar1 = drawEnv_offs + 8;
  pDVar2 = &LEnv;
  do {
    lEnv_iter = (int)pDVar2;
    src_iter = iVar1;
    src_w1 = *(int *)(src_iter + 4);
    src_w2 = *(int *)(src_iter + 8);
    src_w3 = *(int *)(src_iter + 0xc);
    *(u_int *)lEnv_iter = *(u_int *)src_iter;
    *(int *)(lEnv_iter + 4) = src_w1;
    *(int *)(lEnv_iter + 8) = src_w2;
    *(int *)(lEnv_iter + 0xc) = src_w3;
    src_next = src_iter + 0x10;
    iVar1 = src_next;
    pDVar2 = (DRAWENV *)(lEnv_iter + 0x10);
  } while (src_next != drawEnv_offs + 0x58);
  tu13 = *(u_int *)(src_iter + 0x14);
  tu14 = *(u_int *)(src_iter + 0x18);
  *(u_int *)(lEnv_iter + 0x10) = *(u_int *)src_next;
  *(u_int *)(lEnv_iter + 0x14) = tu13;
  *(u_int *)(lEnv_iter + 0x18) = tu14;
  *(u_int *)Render_gPacketPtr =
       *(u_int *)Render_gPacketPtr & 0xff000000 |
       *(u_int *)(Render_gPalettePtr + *(int *)viewSlot * 4 + -4) & 0xffffff;
  pkt_addr24 = (u_int)Render_gPacketPtr & 0xffffff;
  Render_gPacketPtr = Render_gPacketPtr + 0x40;
  *(u_int *)(prev_pkt + *(int *)viewSlot * 4 + -4) =
       *(u_int *)(prev_pkt + *(int *)viewSlot * 4 + -4) & 0xff000000 | pkt_addr24;
  SetDrawEnv((DR_ENV *)cur_pkt,&LEnv);
  return;
}

/* ---- Draw_CheckFirstFrameRender__Fv  [DRAW.CPP:409-419] SLD-VERIFIED ---- */
void Draw_CheckFirstFrameRender(void)

{
  if (gFlip == -1) {
    Draw_DirectSetEnvironment(0x140,0x100,0x140,0xf0,1,0,1,0,0,0);
    Draw_DirectSetEnvironment(0,0x100,0x140,0xf0,1,1,1,0,0,0);
    gFlip = 1;
    AllocatePrimitivesBuffer();
  }
  return;
}

/* ---- Draw_StartFrameRender__Fv  [DRAW.CPP:432-443] SLD-VERIFIED ---- */
void Draw_StartFrameRender(void)

{
  bool bVar1;
  int *piVar2;
  u_long **ppuVar3;
  Draw_tView *pDVar4;
  int i;
  int iVar5;
  
  iVar5 = 0;
  pDVar4 = Draw_gView;
  while (bVar1 = iVar5 < Draw_gNumView, iVar5 = iVar5 + 1, bVar1) {
    piVar2 = &pDVar4->otsize;
    ppuVar3 = pDVar4->ot;
    pDVar4 = pDVar4 + 1;
    ClearOTagR(ppuVar3[gFlip],*piVar2);
  }
  Render_gPacketPtr = gEnviro[gFlip].server;
  Draw_gMaxPrim = gEnviro[gFlip].server + gTotalMem;
  return;
}

/* ---- Draw_SetDrawSyncCallback__FPFv_v  [DRAW.CPP:448-449] SLD-VERIFIED ---- */
void Draw_SetDrawSyncCallback(fn_void *p)

{
  
  Draw_gSyncCallback = p;
  return;
}

/* ---- Draw_StopFrameRender__Fv  [DRAW.CPP:463-487] SLD-VERIFIED ---- */
void Draw_StopFrameRender(void)

{
  bool bVar1;
  Draw_tView *pDVar2;
  int i;
  int iVar3;
  
  DrawSync(0);
  gLoop = gLoop + 1;
  if (Draw_gSyncCallback != (void *)0x0) {
    (*Draw_gSyncCallback)();
  }
  if (Draw_gDoVSync != 0) {
    VSync(0);
  }
  iVar3 = 0;
  PutDispEnv(&gEnviro[gFlip].disp);
  pDVar2 = Draw_gView;
  while (bVar1 = iVar3 < Draw_gNumView, iVar3 = iVar3 + 1, bVar1) {
    DrawOTag(pDVar2->ot[gFlip] + pDVar2->otsize + -1);
    pDVar2 = pDVar2 + 1;
  }
  gFlip = 1 - gFlip;
  return;
}

/* ---- Draw_DrawDirectScreen__FP8shapetblii  [DRAW.CPP:493-498] SLD-VERIFIED ---- */
void Draw_DrawDirectScreen(shapetbl *tile,int x,int y)

{
  
  Texture_Vramcf(tile,x,y + 0x100,0,0);
  return;
}

/* ---- Draw_DirectSetEnvironment__Fiiiiiiiiii  [DRAW.CPP:513-546] SLD-VERIFIED ---- */
void Draw_DirectSetEnvironment(int x,int y,int w,int h,int edraw,int edisplay,int erase,int r,int g,int b)

{
  DISPENV e;
  
  if (edraw != 0) {
    SetDefDrawEnv((DRAWENV *)&e,x,y,w,h);
    PutDrawEnv((DRAWENV *)&e);
  }
  if (edisplay != 0) {
    SetDefDispEnv(&e,x,y,w,h);
    SetDispMask(0);
    PutDispEnv(&e);
    timedwait(timerhz >> 1);
    SetDispMask(1);
  }
  return;
}

/* ---- Draw_SetEnvironment__Fiiiiiiii  [DRAW.CPP:551-553] SLD-VERIFIED ---- */
void Draw_SetEnvironment(int w,int h,int edraw,int edisplay,int erase,int r,int g,int b)

{
  
  Draw_DirectSetEnvironment(0,0x100,w,h,edraw,edisplay,erase,r,g,b);
  return;
}

/* ---- Draw_InitRenderEngine__Fiiiiii  [DRAW.CPP:577-591] SLD-VERIFIED ---- */
void Draw_InitRenderEngine(int x0,int y0,int x1,int y1,int w,int h)

{
  
  gFlip = -1;
  gEnviro[0].server = (char *)0x0;
  gEnviro[1].server = (char *)0x0;
  SetDefDispEnv(&gEnviro[0].disp,x0,y0,w,h);
  SetDefDispEnv(&gEnviro[1].disp,x1,y1,w,h);
  Draw_SetDrawSyncCallback((fn_void *)0x0);
  return;
}

/* ---- Draw_RestartRenderEngine__Fv  [DRAW.CPP:596-597] SLD-VERIFIED ---- */
void Draw_RestartRenderEngine(void)

{
  return;
}

/* ---- Draw_DeInitRenderEngine__Fv  [DRAW.CPP:600-603] SLD-VERIFIED ---- */
void Draw_DeInitRenderEngine(void)

{
  ClearPlatformPrimitivesBuffer();
  gFlip = -1;
  return;
}

/* ---- Draw_InitLibRender__Fv  [DRAW.CPP:609-613] SLD-VERIFIED ---- */
void Draw_InitLibRender(void)

{
  gLoop = 1;
  InitGeom();
  return;
}

/* end of draw.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
fn_void *Draw_gSyncCallback;
