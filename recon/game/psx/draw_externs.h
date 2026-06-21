#include "../../lib/libfns.h"
/* draw_externs.h -- extern decls for game/psx/draw.cpp (NFS4 PSX base render-management). */
#ifndef DRAW_EXTERNS_H
#define DRAW_EXTERNS_H

/* ---- SYM typedef ---- */
typedef void fn_void(void);  /* SYM callback type: void(*)(void) */

/* ---- PsyQ libgpu/libgte/eaclib ---- */
extern int timerhz;  /* global tick-rate (used as value: timerhz>>1) */
  /* DR_ENV pkt + env (2-arg libgpu form) */

/* ---- harvested from sealed *_externs.h ---- */
extern Draw_tView     Draw_gView[];                  /* @0x8011ec54 */
extern GameSetup_tData   GameSetup_gData;
extern char *Render_gPacketEnd;
extern dflip          gEnviro[2];                    /* @0x8011f424 */
extern int            Draw_gPlayer1View, Draw_gPlayer2View;
extern int            Draw_gPlayer1View;             /* @0x8013d3cc */
extern int Draw_gDoVSync;
extern int Draw_gMidGroundOtz;
extern int Draw_gViewOtSize;
extern int gFlip;  extern int Draw_gPlayer1View;
extern short          Render_gPacketLenLo, Render_gPacketLenHi;
extern u_char           *Render_gPacketPtr, *Render_gPalettePtr;
extern u_char *Render_gPacketPtr;      /* PSX scratchpad 0x1F800004: GPU packet build ptr */

/* ---- SYM Globals (type+dims) + free fns ---- */
extern int Draw_gMaxPrim;
extern int Draw_gNumView;
extern fn_void *Draw_gSyncCallback;  /* void(*)(void) drawsync cb */
extern int gLoop;
extern int gTotalMem;
extern void *Platform_ReserveMemory(int, char *);
extern void Texture_Vramcf(shapetbl *, int, int, int, int);

extern int Render_gMenuRenderFlag;

#endif
