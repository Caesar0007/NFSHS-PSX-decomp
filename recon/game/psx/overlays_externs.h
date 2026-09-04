/* overlays_externs.h -- externs for game/psx/overlays.cpp (NFS4 PSX race-summary / stats HUD).
   All 5 fns reconstructed with full SYM-locals applied. */
#ifndef _GAME_PSX_OVERLAYS_EXTERNS_H_
#define _GAME_PSX_OVERLAYS_EXTERNS_H_

/* ---- globals ---- */
/* StatsTimer[2] is modelled as its TWO retail per-element gp-rel symbols (the same
   scalar+alias pair replay_externs.h already uses): the oracle reaches every CONSTANT
   index through a one-instruction %gp_rel (RaceSummary [0], RaceStatistics [1],
   Hud_RenderStatsView both), which an 8-byte object can never produce under -G4, while
   the one VARIABLE-index site (Hud_BTCStats' StatsTimer[player]) materializes the base
   absolutely with %hi/%lo(StatsTimer) -- reproduced here as (&StatsTimer)[player].
   Hud_NextPerp[2] is only 4 bytes, so it stays a real array and just needs its owning-TU
   tentative definition (overlays.obj is where the SYM defines it) to become gp-rel. */
extern int            StatsTimer;              /* logical StatsTimer[0] */
extern int            StatsTimerPlayer2Value asm("D_8013D99C");
extern short          Hud_NextPerp[2];         /* 0x8013d994 */
extern int            Cars_gNumRaceCars;       /* 0x8013c7f8 */
extern int            Cars_gNumHumanRaceCars;  /* 0x8013c800 */
extern Car_tObj      *Cars_gHumanRaceCarList[];/* 0x8010fa48 */
/* w42-a4: the retail per-element splat DATA LABEL for Cars_gHumanRaceCarList[1]
   (catalog w41 -> SS D).  Hud_RenderStatsView's .L800DAF88 join reaches element [1]
   through its OWN %hi/%lo(D_8010FA4C) self-temp load, NOT through the CSE'd array base
   -- which is what stops jump.c threading the identical `[1]->carFlags & 0x200` test
   from the .L800DAF30 edge and keeps the block a 2-predecessor join. */
extern Car_tObj      *D_8010FA4C;              /* 0x8010fa4c = Cars_gHumanRaceCarList[1] */
extern Car_tObj      *Cars_gRaceCarList[];     /* 0x8010fa00 */
extern GameSetup_tData GameSetup_gData;
extern Sim_tSimGlobalVar simGlobal;
extern tBTCPerpInfo   BTCPerpInfo[2][10];       /* 0x80120bc0 */
extern int            FinalBTC_Countdown;       /* 0x8013d938 */

/* ---- HUD / text helpers ---- */
extern void  Hud_GoTpage(int page);
extern int   Hud_BuildString(char *str, int x, int y, int rgb, int flag, int center) asm("Hud_BuildString__FPciiiib");
extern void  Hud_FBuildF4(int x, int y, int yy, int w, int h, u_long col, char c0, char c1);
extern char *TextSys_Word(int id);
extern "C" int textpixels(char *s);
extern "C" int sprintf(...);
extern void  Font_TextColor(int idx);
extern void  Font_TextXY(char *s, int x, int y);
extern void  OptionsBarThing(int x, int y, int w, int h);
extern void  Hud_RenderPauseBox(int x, int y, int w, int h);
extern void  Hud_ParseTime(int t, char *out);

/* ---- this module (forward decls for intra-TU calls) ---- */
extern void  RaceSummary(void);
extern void  RaceStatistics(void);
extern void  Hud_BTCStats(short player, bool flag);   /* HIDDEN-PHANTOM FIX (w14-a2): was `int` (mangles __Fsi, LINK MISMATCH vs the real __Fsb def) */

#endif
