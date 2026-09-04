/* hud_externs.h -- externs for game/psx/hud.cpp (NFS4 PSX in-race HUD).
   All 62 fns reconstructed with full SYM-locals applied. */
#ifndef _GAME_PSX_HUD_EXTERNS_H_
#define _GAME_PSX_HUD_EXTERNS_H_

#include "hud_types.h"

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
struct Hud_CViewCodegenView {
    int id, player;
    u_char cviewBytes[132];
};
extern Hud_CViewCodegenView Hud_CView asm("gCView"); /* 0x80116f7c */
#define HUD_CVIEW_ID Hud_CView.id

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
extern int            HudPmx_gHudNumberUV[];

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
/* Layout-locked exact-symbol views.  These names are reconstruction-only
 * codegen carriers: hud.obj's retail graph deliberately omits the foreign
 * owner tags, while its instructions retain their member-MEM shapes.  The
 * canonical-type audit filters only these exact owner/name/layout tuples. */
struct Hud_GameSetupCodegenView {
    int raceType, numLaps, skill, commMode;
    int setup04_10[7];
    int mirrorTrack, reverseTrack, measurement, sgge, track, trackSegment;
    int song, Weather, Fog, Damage, Time, randSeed, easter;
    int controllerWords[22];
    int pinkSlipsForfeit, checkpointType, checkpointHUD[2];
    int dispatchSpeech, reverseCallSpeech, languageSpeech;
    int SceneNumber, SceneStartLap, SceneEndLap;
    GameSetup_tUserSetting userSetting;
    int numPerps, stageOffset, perpArrests, finalPerpArrests;
    GameSetup_tPerpData perpInfo[10];
    int numCars, numPlayerRaceCars, numOpponentRaceCars, opponentCarType;
    GameSetup_tCarData carInfo[9];
};
struct Hud_SimGlobalCodegenView {
    int gameStarted, gameTicks, time32Hz;
    void *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};
struct Hud_CameraCodegenView {
    BO_tNewtonObj *anchor, *target;
    u_char remaining[264];
};
struct Hud_DashCodegenView {
    int splitscreen;
    char name[9];
    char align13_15[3];
    int conversion, flashtime, flashlap;
    int showhud[2], showmap[2], wrongway[2];
    int laptime, lap, maxlaps, rpm, redline, gear, speed, topspeed;
    int position, opponents, record, tutor, warning[2];
};
extern Hud_GameSetupCodegenView Hud_GameSetup asm("GameSetup_gData");
extern Hud_SimGlobalCodegenView Hud_SimGlobal asm("simGlobal");
extern Hud_CameraCodegenView Hud_Camera[2] asm("Camera_gInfo");
extern Hud_DashCodegenView Hud_Dash asm("DashHUD_gInfo");
extern int Hud_DashWords[] asm("DashHUD_gInfo");
#define HUD_GS_RACE_TYPE        Hud_GameSetup.raceType
#define HUD_GS_COMM_MODE        Hud_GameSetup.commMode
#define HUD_GS_MIRROR_TRACK     Hud_GameSetup.mirrorTrack
#define HUD_GS_REVERSE_TRACK    Hud_GameSetup.reverseTrack
#define HUD_GS_TRACK            Hud_GameSetup.track
#define HUD_GS_TIME             Hud_GameSetup.Time
#define HUD_GS_CHECKPOINT_TYPE  Hud_GameSetup.checkpointType
#define HUD_GS_CHECKPOINT_HUD(p) Hud_GameSetup.checkpointHUD[p]
#define HUD_GS_LANGUAGE         Hud_GameSetup.userSetting.language
#define HUD_GS_NUM_CARS         Hud_GameSetup.numCars
#define HUD_GS_NUM_PLAYER_CARS  Hud_GameSetup.numPlayerRaceCars
#define HUD_GS_NUM_OPP_CARS     Hud_GameSetup.numOpponentRaceCars
#define HUD_GS_CAR_TYPE(p)        Hud_GameSetup.carInfo[p].carType
#define HUD_GS_CAR_CLASS(p)       Hud_GameSetup.carInfo[p].carClass
#define HUD_GS_CAR_HUD_SPEED(p)   Hud_GameSetup.carInfo[p].HudSpeed
#define HUD_GS_CAR_SPEED_MULT(p)  Hud_GameSetup.carInfo[p].HudSpeedMult
#define HUD_GS_CAR_HUD_TACH(p)    Hud_GameSetup.carInfo[p].HudTach
#define HUD_GS_CAR_HUD_MAP(p)     Hud_GameSetup.carInfo[p].HudMap
#define HUD_GS_CAR_OPPONENT_ID(p) Hud_GameSetup.carInfo[p].HudOpponentID
#define HUD_GS_CAR_HUD_TIME(p)    Hud_GameSetup.carInfo[p].HudTime
#define HUD_GS_CAR_HUD_LAPNUM(p)  Hud_GameSetup.carInfo[p].HudLapnum
#define HUD_GS_CAR_POSITION(p)    Hud_GameSetup.carInfo[p].HudPosition
#define HUD_GAME_TICKS          Hud_SimGlobal.gameTicks
#define HUD_CAMERA_ANCHOR(p)    Hud_Camera[p].anchor
#define HUD_DASH_SPLITSCREEN    Hud_Dash.splitscreen
#define HUD_DASH_FLASHTIME      Hud_Dash.flashtime
#define HUD_DASH_SHOWHUD        Hud_Dash.showhud
#define HUD_DASH_WRONGWAY       Hud_Dash.wrongway
#define HUD_DASH_SHOWHUD_AT(p)  Hud_Dash.showhud[p]
#define HUD_DASH_WRONGWAY_AT(p) Hud_Dash.wrongway[p]
#define HUD_DASH_LAPTIME        Hud_Dash.laptime
#define HUD_DASH_LAP            Hud_Dash.lap
#define HUD_DASH_MAXLAPS        Hud_Dash.maxlaps
#define HUD_DASH_RPM            Hud_Dash.rpm
#define HUD_DASH_REDLINE        Hud_Dash.redline
#define HUD_DASH_GEAR           Hud_Dash.gear
#define HUD_DASH_SPEED          Hud_Dash.speed
#define HUD_DASH_TOPSPEED       Hud_Dash.topspeed
#define HUD_DASH_POSITION       Hud_Dash.position
#define HUD_DASH_OPPONENTS      Hud_Dash.opponents
#define HUD_DASH_RECORD         Hud_Dash.record
#define HUD_DASH_TUTOR          Hud_Dash.tutor
extern int            Input_gLookBehind[2];
struct Hud_PadCodegenView {
    int initialized;
    PAD_COMMON buf[8];
    u_char stateBytes[16];
};
extern Hud_PadCodegenView Hud_Pad asm("gPadinfo"); /* 0x8013e89c */
#define HUD_PAD_BUF Hud_Pad.buf
extern int Hud_BTCPerpInfoWords[][10][4] asm("BTCPerpInfo"); /* 0x80120bc0 */
#define HUD_BTC_NAME(p,n)    ((char *)&Hud_BTCPerpInfoWords[p][n][0])
#define HUD_BTC_TIME(p,n)    Hud_BTCPerpInfoWords[p][n][2]
#define HUD_BTC_CAUGHT(p,n)  Hud_BTCPerpInfoWords[p][n][3]

/* ---- PsyQ libgpu primitive helpers ---- */

/* ---- PsyQ libgte / soft-float helpers ---- */

/* ---- eaclib memstd ---- */

/* ---- font / textsys ---- */
extern int   Font_GetUVWH(char c, int *u, int *v, int *w, int *h, int *yo);
extern int   Font_Getcharacter(int c);
extern void  Font_TextColor(int idx);
extern void  Font_TextXY(char *s, int x, int y);
extern char *TextSys_Word(int id);
extern "C" int textpixels(char *s);

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
extern AudioMus_tCurrentSong *AudioMus_GetCurrentSong(void);
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
struct Hud_ReplayCodegenView {
    int pause, speed, end, camera, selection, depressed, changeCamera, statsScreen;
};
extern Hud_ReplayCodegenView Hud_Replay asm("Replay_ReplayInterface");
#define HUD_REPLAY_PAUSE        Hud_Replay.pause
#define HUD_REPLAY_SPEED        Hud_Replay.speed
#define HUD_REPLAY_CAMERA       Hud_Replay.camera
#define HUD_REPLAY_SELECTION    Hud_Replay.selection
#define HUD_REPLAY_STATS_SCREEN Hud_Replay.statsScreen
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
extern int (*BWorldSm_slices)[8]; /* loaded pointer; 32-byte slice rows */
struct Hud_SimVarCodegenView {
    int restartGame, endSimGame, pauseSim, keyRelease, quickPauseSim;
    int goalClockTicks, currentClockTicks;
};
extern Hud_SimVarCodegenView Hud_SimVar asm("simVar");
#define HUD_QUICK_PAUSE Hud_SimVar.quickPauseSim
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

#define RaceType_HotPursuit 1

extern "C" {
void SetDrawMode(DR_MODE *packet, int dfe, int dtd, int tpage, RECT *window);
void SetSemiTrans(void *packet, int abe);
void SetPolyF3(POLY_F3 *packet);
void SetPolyF4(POLY_F4 *packet);
void SetPolyFT4(POLY_FT4 *packet);
void SetPolyG4(POLY_G4 *packet);
u_short PAD_state(int padID);
int ccos(int angle);
int csin(int angle);
int fixedmult(int a, int b);
void fixedsincos(int angle, int *sine, int *cosine);
int purgememadr(void *ptr);
void *reservememadr(const char *name, int size, int flags);
int sprintf(char *buffer, const char *format, ...);
unsigned int strlen(const char *string);
}

#endif
