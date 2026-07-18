/* hud_externs.h -- externs for game/psx/hud.cpp (NFS4 PSX in-race HUD).
   All 62 fns reconstructed with full SYM-locals applied. */
#ifndef _GAME_PSX_HUD_EXTERNS_H_
#define _GAME_PSX_HUD_EXTERNS_H_

#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* Ghidra-ism helpers (3-byte type + byte-concat macro used by color packing) */
typedef unsigned int undefined3;
static inline u_int CONCAT31(u_int hi3, u_char lo1) { return (hi3 << 8) | lo1; }

/* ---- module-local sprite/prim scratch + map state ---- */
// [owned->defined in hud.cpp] extern SPRT          *gSprite0;          /* 0x... HUD sprite array 0 */
// [owned->defined in hud.cpp] extern SPRT          *gSprite1;          /* HUD sprite array 1 */
extern SPRT          *gSprt1;
// [owned->defined in hud.cpp] extern POLY_F4        gHudF4[];
// [owned->defined in hud.cpp] extern POLY_F4 gHudF4[];
// [owned->defined in hud.cpp] extern POLY_FT4       gHudFT4[];
// [owned->defined in hud.cpp] extern POLY_FT4 gHudFT4[];
// [owned->defined in hud.cpp] extern POLY_G4        gHudG4[];
// [owned->defined in hud.cpp] extern POLY_G4 gHudG4[];
// [owned->defined in hud.cpp] extern DR_MODE       *gTPage0[];
// [owned->defined in hud.cpp] extern DR_MODE *gTPage0[];
// [owned->defined in hud.cpp] extern DR_MODE       *gTPage1[];
// [owned->defined in hud.cpp] extern DR_MODE *gTPage1[];
extern u_short        gFontClut;
extern int            gFlip;             /* 0x8013d7b4 */
// [owned->defined in hud.cpp] extern int            gMapOffX, gMapOffY, gMapRotate, gMapScaleX, gMapScaleY;
// [owned->defined in hud.cpp] extern int gMapOffX, gMapOffY, gMapRotate, gMapScaleX, gMapScaleY;
extern DRender_tView  gCView;            /* 0x80116f7c */

/* ---- GPU packet cursors (scratchpad linked-list) ---- */

/* ---- HUD module globals ---- */
// [owned->defined in hud.cpp] extern int            Hud_gHudView[2], Hud_gMapView[2], Hud_gTacView[2];
// [owned->defined in hud.cpp] extern int Hud_gHudView[2], Hud_gMapView[2], Hud_gTacView[2];
// [owned->defined in hud.cpp] extern int            Hud_gStatsView;
// [owned->defined in hud.cpp] extern int Hud_gStatsView;
// [owned->defined in hud.cpp] extern char           Hud_gWingmanInterface[2];
// [owned->defined in hud.cpp] extern char Hud_gWingmanInterface[2];
// [owned->defined in hud.cpp] extern int            Hud_gWingmanFlashTicks[2];
// [owned->defined in hud.cpp] extern int Hud_gWingmanFlashTicks[2];
// [owned->defined in hud.cpp] extern char           Hud_gWingmanFlashIcon[2];
// [owned->defined in hud.cpp] extern char Hud_gWingmanFlashIcon[2];
// [owned->defined in hud.cpp] extern tSmallCoordXY  Hud_gElementPositions[][19];
// [owned->defined in hud.cpp] extern tSmallCoordXY Hud_gElementPositions[][19];
// [owned->defined in hud.cpp] extern tSmallCoordXY *g1Player;          /* active element-position row (set per-frame) */
// [owned->defined in hud.cpp] extern CVECTOR        Hud_gMarkerColor[];
// [owned->defined in hud.cpp] extern CVECTOR Hud_gMarkerColor[];
// [owned->defined in hud.cpp] extern CVECTOR        Hud_gCopMarkerColor[];
// [owned->defined in hud.cpp] extern CVECTOR Hud_gCopMarkerColor[];
// [owned->defined in hud.cpp] extern int            Hud_gCdActive, Hud_gCdScrollTitle, Hud_gCdLastTick, Hud_gShowedCDPlayer;
// [owned->defined in hud.cpp] extern int Hud_gCdActive, Hud_gCdScrollTitle, Hud_gCdLastTick, Hud_gShowedCDPlayer;
// [owned->defined in hud.cpp] extern int            Hud_BeTheCop;
// [owned->defined in hud.cpp] extern int Hud_BeTheCop;
extern short          Hud_NextPerp[2];
extern int            StatsTimer[2];
// [owned->defined in hud.cpp] extern int            FinalBTC_Countdown;
// [owned->defined in hud.cpp] extern int FinalBTC_Countdown;

/* ---- HudPmx shape tables ---- */
extern HudPmx_tShape  HudPmx_gShapes[];
extern HudPmx_tUV     HudPmx_gHudNumberUV[];

/* ---- Cars / sim / setup / camera / dashhud ---- */
extern Car_tObj      *Cars_gRaceCarList[];      /* 0x8010fa00 */
extern Car_tObj      *Cars_gHumanRaceCarList[]; /* 0x8010fa48 */
extern Car_tObj      *Cars_gCopCarList[];
extern Car_tObj      *Cars_gList[];
extern Car_tObj      *Cars_gSortedList[];
extern int            Cars_gNumRaceCars;        /* 0x8013c7f8 */
extern int            Cars_gNumHumanRaceCars;   /* 0x8013c800 */
extern int            Cars_gNumCars;
extern int            Cars_gNumCopCars;
extern GameSetup_tData    GameSetup_gData;      /* 0x801131ec */
extern Sim_tSimGlobalVar  simGlobal;            /* 0x8011e0ac */
extern camera_info        Camera_gInfo[2];      /* 0x8010f2ac */
extern dashhud_info       DashHUD_gInfo;
extern int            Input_gLookBehind[2];
extern tPadModuleState gPadinfo;                /* 0x8013e89c */
extern tBTCPerpInfo   BTCPerpInfo[2][10];       /* 0x80120bc0 */

/* ---- PsyQ libgpu primitive helpers ---- */

/* ---- PsyQ libgte / soft-float helpers ---- */

/* ---- eaclib memstd ---- */

/* ---- font / textsys ---- */
extern int   Font_GetUVWH(char c, int *u, int *v, int *w, int *h, int *yo);
extern int   Font_Getcharacter(int c);
extern void  Font_TextColor(int idx);
extern void  Font_TextXY(char *s, int x, int y);
extern char *TextSys_Word(int id);
extern int   textpixels(char *s);

/* ---- draw / view ---- */
extern int   Draw_SetView(int a, int b, int c, int d, int e, int f, int g, int h, int i);
extern void  Draw_StartRenderingView(int id);
extern void  Draw_StopRenderingView(int id);

/* ---- other game helpers ---- */
extern void  Flare_2DHalo(int a, int b, int c, int d, int e);
extern int   Stats_GetPosition(Car_tObj *car);
extern int   Input_WingCommandMode(int player);
extern int   DashHUD_CheckWrongWay(int player);
extern int   DashHUD_HUDCalc(int player);
extern void  CopSpeak_Debug(void);
extern int   AudioMus_Buffered(void);
extern int   AudioMus_GetCurrentSong(void);
extern int   AudioMus_Threshold(void);
extern void  AudioCmn_PlayWrongWaySFX(void);
extern void  HudPmx_Kill(void);
extern void  Hud_RenderStatsView(void);   /* defined in overlays.cpp */
extern void  Hud_BTCStats(short player, bool flag);   /* defined in overlays.cpp -- HIDDEN-PHANTOM FIX (w14-a2): was `char` (mangles __Fsc, LINK MISMATCH vs the real __Fsb def) */

/* ---- module-scope statics / cross-module globals (Ghidra-recovered names) ---- */
extern int            ticks;                 /* global frame tick */
extern int trap_unused;
extern int trap_unused;
extern void           trap(int code);        /* HW/debug trap */
// [owned->defined in hud.cpp] extern int            HudBustedOverlay, HudBustedOverlayPlayer;
// [owned->defined in hud.cpp] extern int HudBustedOverlay, HudBustedOverlayPlayer;
// [owned->defined in hud.cpp] extern int            HudMapOffsetY;
// [owned->defined in hud.cpp] extern int HudMapOffsetY;
// [owned->defined in hud.cpp] extern int            HudSplitTimeDiff1[2], HudSplitTimeDiff2[2];
// [owned->defined in hud.cpp] extern int HudSplitTimeDiff1[2], HudSplitTimeDiff2[2];
// [owned->defined in hud.cpp] extern int            Hud_Character[];        /* per-char glyph bitmask table */
// [owned->defined in hud.cpp] extern int            Hud_kTurnSongOffNext;
// [owned->defined in hud.cpp] extern int Hud_kTurnSongOffNext;
extern int            Replay_ReplayMode;
extern tReplayInterface Replay_ReplayInterface;
// [owned->defined in hud.cpp] extern int            currentSpriteColor;
// [owned->defined in hud.cpp] extern int currentSpriteColor;
// [owned->defined in hud.cpp] extern char           currentSpriteTransparent;
// [owned->defined in hud.cpp] extern char currentSpriteTransparent;
// [owned->defined in hud.cpp] extern short          fMapOffX[], fMapOffY[], fMapRotate[];  /* short tables (lh), indexed by track */
// [owned->defined in hud.cpp] extern float          fMapScaleX[], fMapScaleY[];            /* float scale tables */
// [owned->defined in hud.cpp] extern int            mapMarkerMSin, mapMarkerMCos;
// [owned->defined in hud.cpp] extern int mapMarkerMSin, mapMarkerMCos;
// [owned->defined in hud.cpp] extern void          *day_needle, *night_needle;
// [owned->defined in hud.cpp] extern void *day_needle, *night_needle;
extern Trk_NewSlice  *BWorldSm_slices;   /* POINTER (as every other TU declares it) -- the old coorddef[] array decl was a wrong-shape bug (address-of vs load, wrong stride) */
extern Sim_tSimSystemVar simVar;
/* BTC state */
// [owned->defined in hud.cpp] extern int            BTC_BonusTime, BTC_BonusTimeTick, BTC_Countdown;
// [owned->defined in hud.cpp] extern int BTC_BonusTime, BTC_BonusTimeTick, BTC_Countdown;
// [owned->defined in hud.cpp] extern int            BTC_UserHasControl, BTC_playedsoundalready;
// [owned->defined in hud.cpp] extern int BTC_UserHasControl, BTC_playedsoundalready;
// [owned->defined in hud.cpp] extern char           BTC_CurrentPerpName[];
// [owned->defined in hud.cpp] extern char BTC_CurrentPerpName[];
// [owned->defined in hud.cpp] extern int            BigBTCTime_state1, BigBTCTime_state2;
// [owned->defined in hud.cpp] extern int BigBTCTime_state1, BigBTCTime_state2;
// [owned->defined in hud.cpp] extern int            PerpOverlayOn[], PerpOverlayMessage[];
// [owned->defined in hud.cpp] extern int PerpOverlayOn[], PerpOverlayMessage[];
// [owned->defined in hud.cpp] extern int            countdown, oldCountdown, countdownTick_216;
extern char countdown; extern int countdownTick_216;   /* countdown was stale int (4B); owner
                                     audiocmn.cpp defines it char (1B), packed before FadingMusic --
                                     hud.cpp's unguarded `countdown == '\0'`/`!= '\0'` compares (no
                                     (u_char) cast) would pull in 3 garbage neighbor bytes as an int */
// [owned->defined in hud.cpp] extern int countdown, oldCountdown, countdownTick_216;
extern char countdown; extern int countdownTick_216;   /* countdown was stale int (4B); owner
                                     audiocmn.cpp defines it char (1B), packed before FadingMusic --
                                     hud.cpp's unguarded `countdown == '\0'`/`!= '\0'` compares (no
                                     (u_char) cast) would pull in 3 garbage neighbor bytes as an int */
// [owned->defined in hud.cpp] extern int            Hud_ActivateCDPlayer;
// [owned->defined in hud.cpp] extern int Hud_ActivateCDPlayer;

/* ---- Ghidra unnamed module statics (BTC area @0x8013d8xx); TODO name in DAT pass ---- */

/* (intra-TU forward declarations are auto-emitted into hud.cpp itself) */

#endif
