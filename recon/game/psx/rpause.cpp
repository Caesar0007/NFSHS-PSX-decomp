/* game/psx/rpause.cpp -- RECONSTRUCTED (NFS4 PSX replay pause-menu buffer mgmt; C++ TU)
 *   3 fns: RPause_CopyBackToFrontBuffer (blit back->front buffer pause-menu rect),
 *   RPause_StartPauseMenu (begin frame render), RPause_StopPauseMenu (flush disp/OT, flip). No GTE.
 */
#include "rpause_types.h"
#include "rpause_externs.h"


/* ---- RPause_CopyBackToFrontBuffer__Fv  [RPAUSE.CPP:25-42] SLD-VERIFIED ---- */
void RPause_CopyBackToFrontBuffer(void)

{
  RECT rscreen;
  DRAWENV *drawenv;

  drawenv = Draw_GetDRAWENV(Draw_gPlayer1View,1);
  rscreen = drawenv->clip;
  rscreen.x = rscreen.x + gPauseMenuRect;
  rscreen.y = rscreen.y + D_8013D3D6;
  rscreen.w = D_8013D3D8;
  rscreen.h = D_8013D3DA;
  drawenv = Draw_GetDRAWENV(Draw_gPlayer1View,0);
  MoveImage(&rscreen,drawenv->clip.x + gPauseMenuRect,drawenv->clip.y + D_8013D3D6);
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
  
  PutDispEnv(&RPAUSE_ENVIRO1_DISP);
  DrawSync(0);
  VSync(0);
  RPause_CopyBackToFrontBuffer();
  /* MATCH: zero-byte raw-base receipt keeps GCC's shared Draw_gView anchor at
     offset zero; RPause_ViewOTAt then retains retail's +192 load displacement. */
  __asm__("" : : "m"(RPause_DrawViewRows[0][0]));
  DrawOTag(RPAUSE_VIEW_OT(Render_gPauseMenuView,gFlip) +
             RPAUSE_VIEW_OTSIZE(Render_gPauseMenuView) + -1);
  systemtask(0);
  gFlip = 1 - gFlip;
  return;
}

/* end of rpause.cpp */
