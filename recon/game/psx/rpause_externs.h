/* rpause_externs.h -- externs for game/psx/rpause.cpp (NFS4 replay pause-menu buffer mgmt) */
#ifndef _GAME_PSX_RPAUSE_EXTERNS_H_
#define _GAME_PSX_RPAUSE_EXTERNS_H_

/* ---- globals ---- */
/* rpause.obj's SYM does not expose Draw_tView.  Keep the owner-neutral raw
   200-byte rows here; this inline address accessor emits no standalone symbol
   and preserves the retail row/flip/field address tree. */
extern u_char     RPause_DrawViewRows[][200] asm("Draw_gView");
extern u_char     RPause_EnviroBytes[] asm("gEnviro");
static inline u_long *RPause_ViewOTAt(int offset, u_char *base)
{
    return *(u_long **)(base + offset + 192);
}
#define RPAUSE_VIEW_OTSIZE(view) (*(int *)&RPause_DrawViewRows[(view)][0])
#define RPAUSE_VIEW_OT(view, flip) \
    RPause_ViewOTAt((view) * 200 + (flip) * 4, \
                    &RPause_DrawViewRows[0][0])
#define RPAUSE_ENVIRO1_DISP (*(DISPENV *)(RPause_EnviroBytes + 24))
extern int        Draw_gPlayer1View;     /* 0x8013d3cc */
/* Zero-storage scalar views of render.obj's RECT fields.  Retail rpause.obj
   addresses these four locations as independent symbols; only render.cpp owns
   the actual 8-byte storage. */
extern short      gPauseMenuRect, D_8013D3D6, D_8013D3D8, D_8013D3DA;
extern int        Render_gPauseMenuView; /* 0x8013d3e8 */
extern int        gFlip;                 /* 0x8013d7b4 */

/* ---- PSX::Draw / libgpu / libetc / eaclib helpers ---- */
extern DRAWENV *Draw_GetDRAWENV(int view, int buf);
extern void     Draw_StartFrameRender(void);
extern "C" {
void DrawOTag(u_long *p);
long DrawSync(long mode);
int MoveImage(RECT *rect, int x, int y);
DISPENV *PutDispEnv(DISPENV *env);
int systemtask(int taskFlag);
int VSync(int mode);
}

/* ---- this module ---- */
extern void RPause_CopyBackToFrontBuffer(void);

#endif
