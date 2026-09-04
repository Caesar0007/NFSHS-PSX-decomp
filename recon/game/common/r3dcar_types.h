/* R3DCar.obj's exact source-visible extension of the shared DrawC graph. */
#ifndef NFS4_GAME_COMMON_R3DCAR_TYPES_H
#define NFS4_GAME_COMMON_R3DCAR_TYPES_H

#define NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES
#include "../psx/drawc_types.h"
#undef NFS4_DRAWC_OMIT_R3DCAR_PRIVATE_TYPES

/* Retail exposes these fixed scratchpad cells as lvalues, not storage owned by
 * R3DCar.obj. Keep the address-bearing source expressions without importing
 * the broad project type header. */
#define Render_gPalettePtr (*(u_char **)0x1F800000)
#define gScratchLastWord   (*(int *)0x1F8003FC)

struct Texture_pal8bit;

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct Transformer_zScene {
    Transformer_zObj *obj[57];
    Transformer_zOverlay overlay[90];
};

struct R3DCar_tEnvMapInfo {
    int eScaleX, eScaleY, rideHeight, upgradeHeight;
};

/* Canonical AITune.obj aggregate used by this translation unit. */
struct AITune_tTrackInfo {
    int oneWay, driveSide, roughLapTimeSeconds;
};

/* Canonical camera.obj aggregate used by this translation unit. */
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

/* Canonical sim.obj aggregates used by this translation unit. */
struct Sim_tSimGlobalVar {
    int gameStarted, gameTicks, time32Hz;
    Sched_tSchedule *schedule64Hz, *schedule32Hz, *schedule32Hz2;
};

struct Sim_tSimSystemVar {
    int restartGame, endSimGame, pauseSim, keyRelease, quickPauseSim;
    int goalClockTicks, currentClockTicks;
};

/* Canonical replay.obj aggregate used by this translation unit. */
struct tReplayInterface {
    int pause, speed, end, camera, selection, depressed, changeCamera, statsScreen;
};

/* Canonical DrawC.obj aggregate used by this translation unit. */
struct DrawC_tEnvMap {
    short slice, tex, extra;
};

typedef int Input_tDeviceCall();

#endif
