/* hud.obj's exact source-visible type surface reconstructed from SYM.
 * psxcontroller.obj is an exact 86-record subset; the records below are
 * precisely the 17-name delta retained by the standalone HUD owner. */
#ifndef NFS4_GAME_PSX_HUD_TYPES_H
#define NFS4_GAME_PSX_HUD_TYPES_H

#include "psxcontroller_types.h"

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

typedef int CarLogic_tObservations[1][3];

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

struct Sim_tSimGlobalVar {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};

struct Sim_tSimSystemVar {
    int restartGame, endSimGame, pauseSim, keyRelease, quickPauseSim;
    int goalClockTicks, currentClockTicks;
};

struct tReplayInterface {
    int pause, speed, end, camera, selection, depressed, changeCamera;
    int statsScreen;
};

struct DRender_tView {
    int id, player;
    DRender_tCalcView cview;
};

typedef enum AIDataRecord_RecordMethod_t {
    NORMAL_M = 0, RECORD_M = 1, TEST_M = 2
} AIDataRecord_RecordMethod_t;

struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    AIDataRecord_RecordMethod_t recordMethod_;
    __vtbl_ptr_type (*_vf)[3];
};
struct AIDataRecord_AccTable_t : public AIDataRecord_t { int scale_; };
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {};

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};
struct AudioMus_tCurrentSong {
    int newsong, index, remaining;
    AudioMus_tSongEntry info;
};

/* Canonical dashHUD.obj aggregate retained by the retail SYM. */
struct dashhud_info {
    int splitscreen;
    char name[9];
    int conversion, flashtime, flashlap;
    int showhud[2], showmap[2], wrongway[2];
    int laptime, lap, maxlaps, rpm, redline, gear, speed, topspeed;
    int position, opponents, record, tutor;
    int warning[2];
};

/* Canonical overlays.obj BTC record retained by the retail SYM. */
struct tBTCPerpInfo {
    char name[8];
    int time;
    bool caught;
};

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0, FOCUS_AI = 1, FOCUS_COPANDAI = 2
} forceFocus_t;

struct camera_info {
    BO_tNewtonObj *anchor, *target;
    coorddef position, relpos, audioPos;
    int TVHeight;
    matrixtdef rotation;
    int twist;
    coorddef wallLeft, wallRight;
    short mode, camNum;
    char modechange : 1;
    char pitch : 1;
    char jostling : 1;
    char tracking : 1;
    char checkwalls : 1;
    char noLookBack : 1;
    char checkcollisions : 1;
    char splitscreen : 1;
    char intransition, tumbling;
    char direction : 1;
    char zooming : 2;
    char inCar : 1;
    short circleCounter, circleAngle;
    char animNum;
    signed char animHandle;
    char splineMode;
    forceFocus_t forceFocus;
    signed char focusOnAICar;
    int POInhibitor;
    BWorldSm_Pos slicePos;
};

struct FLARE_PIECE_DEF { int distance, size; CVECTOR color; char type; };

struct POLY_F3 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0,x1,y1,x2,y2;
};
struct POLY_F4 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0,x1,y1,x2,y2,x3,y3;
};
struct POLY_FT4 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    short x1,y1; u_char u1,v1; u_short tpage; short x2,y2; u_char u2,v2;
    u_short pad1; short x3,y3; u_char u3,v3; u_short pad2;
};
struct POLY_G4 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char r1,g1,b1,pad1;
    short x1,y1; u_char r2,g2,b2,pad2; short x2,y2; u_char r3,g3,b3,pad3;
    short x3,y3;
};
struct POLY_GT4 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    u_char r1,g1,b1,p1; short x1,y1; u_char u1,v1; u_short tpage;
    u_char r2,g2,b2,p2; short x2,y2; u_char u2,v2; u_short pad2;
    u_char r3,g3,b3,p3; short x3,y3; u_char u3,v3; u_short pad3;
};
struct SPRT {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0;
    u_short clut; short w,h;
};

struct HudPmx_tShape { Draw_tPixMap pixmap; short width, height; };
struct tSmallCoordXY { short x, y; };

#endif
