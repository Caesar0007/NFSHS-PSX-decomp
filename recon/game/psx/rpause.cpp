/* game/psx/rpause.cpp -- RECONSTRUCTED (NFS4 PSX replay pause-menu buffer mgmt; C++ TU)
 *   3 fns: RPause_CopyBackToFrontBuffer (blit back->front buffer pause-menu rect),
 *   RPause_StartPauseMenu (begin frame render), RPause_StopPauseMenu (flush disp/OT, flip). No GTE.
 */
#include "../../nfs4_types.h"
#include "rpause_externs.h"


/* ---- RPause_CopyBackToFrontBuffer__Fv  [RPAUSE.CPP:25-42] SLD-VERIFIED ---- */
void RPause_CopyBackToFrontBuffer(void)

{
  RECT rscreen;
  DRAWENV *drawenv;

  drawenv = Draw_GetDRAWENV(Draw_gPlayer1View,1);
  rscreen = drawenv->clip;
  rscreen.h = gPauseMenuRect.h;
  rscreen.w = gPauseMenuRect.w;
  rscreen.y = rscreen.y + gPauseMenuRect.y;
  rscreen.x = rscreen.x + gPauseMenuRect.x;
  drawenv = Draw_GetDRAWENV(Draw_gPlayer1View,0);
  MoveImage(&rscreen,drawenv->clip.x + gPauseMenuRect.x,drawenv->clip.y + gPauseMenuRect.y);
  return;
}

/* ---- RPause_StartPauseMenu__Fv  [RPAUSE.CPP:46-48] SLD-VERIFIED ---- */
void RPause_StartPauseMenu(void)

{
  Draw_StartFrameRender();
  return;
}

/* ---- RPause_StopPauseMenu__Fv  [RPAUSE.CPP:52-73] SLD-VERIFIED ---- */
void RPause_StopPauseMenu(void)

{
  
  PutDispEnv(&gEnviro[1].disp);
  DrawSync(0);
  VSync(0);
  RPause_CopyBackToFrontBuffer();
  DrawOTag(Draw_gView[Render_gPauseMenuView].ot[gFlip] +
             Draw_gView[Render_gPauseMenuView].otsize + -1);
  systemtask(0);
  gFlip = 1 - gFlip;
  return;
}

/* end of rpause.cpp */
