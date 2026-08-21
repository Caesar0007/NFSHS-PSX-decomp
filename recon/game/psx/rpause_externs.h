/* rpause_externs.h -- externs for game/psx/rpause.cpp (NFS4 replay pause-menu buffer mgmt) */
#ifndef _GAME_PSX_RPAUSE_EXTERNS_H_
#define _GAME_PSX_RPAUSE_EXTERNS_H_

#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- globals ---- */
extern Draw_tView Draw_gView[];          /* 0x8011ec54 */
extern dflip      gEnviro[2];            /* 0x8011f424 */
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
     /* syslib libgpu */
                 /* eaclib EACPSXZ systask */

/* ---- this module ---- */
extern void RPause_CopyBackToFrontBuffer(void);

#endif
