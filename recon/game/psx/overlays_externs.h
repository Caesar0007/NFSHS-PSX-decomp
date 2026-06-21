/* overlays_externs.h -- externs for game/psx/overlays.cpp (NFS4 PSX race-summary / stats HUD).
   All 5 fns reconstructed with full SYM-locals applied. */
#ifndef _GAME_PSX_OVERLAYS_EXTERNS_H_
#define _GAME_PSX_OVERLAYS_EXTERNS_H_

#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- globals ---- */
extern int            StatsTimer[2];           /* 0x8013d998 */
extern short          Hud_NextPerp[2];         /* 0x8013d994 */
extern int            Cars_gNumRaceCars;       /* 0x8013c7f8 */
extern int            Cars_gNumHumanRaceCars;  /* 0x8013c800 */
extern Car_tObj      *Cars_gHumanRaceCarList[];/* 0x8010fa48 */
extern Car_tObj      *Cars_gRaceCarList[];     /* 0x8010fa00 */
extern GameSetup_tData GameSetup_gData;         /* 0x801131ec */
extern Sim_tSimGlobalVar simGlobal;             /* 0x8011e0ac */
extern tBTCPerpInfo   BTCPerpInfo[2][10];       /* 0x80120bc0 */
extern int            FinalBTC_Countdown;       /* 0x8013d938 */

/* ---- HUD / text helpers ---- */
extern void  Hud_GoTpage(int page);
extern int   Hud_BuildString(char *str, int x, int y, int rgb, int flag, int center);
extern void  Hud_FBuildF4(int x, int y, int yy, int w, int h, u_long col, char c0, char c1);
extern char *TextSys_Word(int id);
extern int   textpixels(char *s);
extern void  Font_TextColor(int idx);
extern void  Font_TextXY(char *s, int x, int y);
extern void  OptionsBarThing(int x, int y, int w, int h);
extern void  Hud_RenderPauseBox(int x, int y, int w, int h);
extern void  Hud_ParseTime(int t, char *out);

/* ---- this module (forward decls for intra-TU calls) ---- */
extern void  RaceSummary(void);
extern void  RaceStatistics(void);
extern void  Hud_BTCStats(short player, int flag);

#endif
