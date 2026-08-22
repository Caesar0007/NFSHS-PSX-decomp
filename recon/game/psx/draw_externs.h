/* draw_externs.h -- extern decls for game/psx/draw.cpp (NFS4 PSX base render-management). */
#ifndef DRAW_EXTERNS_H
#define DRAW_EXTERNS_H

/* ---- PsyQ libgpu/libgte/eaclib ---- */
extern int timerhz;  /* global tick-rate (used as value: timerhz>>1) */
  /* DR_ENV pkt + env (2-arg libgpu form) */

/* ---- harvested from sealed *_externs.h ---- */
extern Draw_tView     Draw_gView[];                  /* @0x8011ec54 */
extern int Draw_GameSetupWords[] asm("GameSetup_gData");
extern char *Render_gPacketEnd;
extern dflip          gEnviro[2];                    /* @0x8011f424 */
extern int            Draw_gPlayer1View, Draw_gPlayer2View;
extern int            Draw_gPlayer1View;             /* @0x8013d3cc */
extern int Draw_gDoVSync;
extern int Draw_gMidGroundOtz;
extern int Draw_gViewOtSize;
extern int gFlip;  extern int Draw_gPlayer1View;
extern short          Render_gPacketLenLo, Render_gPacketLenHi;

/* ---- SYM Globals (type+dims) + free fns ---- */
extern char *Draw_gMaxPrim;
extern int Draw_gNumView;
extern int gLoop;
extern int gTotalMem;
extern void *Platform_ReserveMemory(int, char *);
extern void Texture_Vramcf(shapetbl *, int, int, int, int);

extern int Render_gMenuRenderFlag;

extern "C" u_long *ClearOTagR(...);
extern "C" void DrawOTag(...);
extern "C" long DrawSync(...);
extern "C" DISPENV *PutDispEnv(...);
extern "C" DRAWENV *PutDrawEnv(...);
extern "C" DISPENV *SetDefDispEnv(...);
extern "C" DRAWENV *SetDefDrawEnv(...);
extern "C" void SetDispMask(...);
extern "C" void SetDrawEnv(...);
extern "C" void InitGeom(...);
extern "C" int VSync(...);
extern "C" int purgememadr(...);
extern "C" void *reservememadr(...);
extern "C" void timedwait(...);

#endif
