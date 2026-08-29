/* PSXFront.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_FRONTEND_PSX_PSXFRONT_TYPES_H
#define NFS4_FRONTEND_PSX_PSXFRONT_TYPES_H

/* Fetools.obj contributes the exact 95-definition shared graph.  Its four
 * menu-only classes and Fecntl's Input_tDeviceCall typedef are absent from
 * PSXFront.obj and therefore omitted only for this composition. */
#define NFS4_FETOOLS_OMIT_MENU_CLASSES
#define NFS4_FECNTL_NO_INPUT_DEVICE_CALL
#include "../common/fetools_types.h"
#undef NFS4_FECNTL_NO_INPUT_DEVICE_CALL
#undef NFS4_FETOOLS_OMIT_MENU_CLASSES

/* Scratchpad render cursors are fixed-address lvalues, not owned globals. */
#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

struct CdlLOC {
    u_char minute, second, sector, track;
};

struct charactertbl {
    u_char index[2];
    u_char width, height;
    u_char u[2], v[2];
    char advance, xoffset, yoffset;
};

struct DR_OFFSET {
    u_long tag;
    u_long code[2];
};

struct eacelement {
    eacelement *link;
};

struct POLY_F4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0, x1, y1, x2, y2, x3, y3;
};

struct POLY_FT4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    short x1, y1;
    u_char u1, v1;
    u_short tpage;
    short x2, y2;
    u_char u2, v2;
    u_short pad1;
    short x3, y3;
    u_char u3, v3;
    u_short pad2;
};

struct POLY_G4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char r1, g1, b1, pad1;
    short x1, y1;
    u_char r2, g2, b2, pad2;
    short x2, y2;
    u_char r3, g3, b3, pad3;
    short x3, y3;
};

struct POLY_GT4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0;
    u_char u0, v0;
    u_short clut;
    u_char r1, g1, b1, p1;
    short x1, y1;
    u_char u1, v1;
    u_short tpage;
    u_char r2, g2, b2, p2;
    short x2, y2;
    u_char u2, v2;
    u_short pad2;
    u_char r3, g3, b3, p3;
    short x3, y3;
    u_char u3, v3;
    u_short pad3;
};

struct SNDSYSCAP {
    u_short outputratemin, outputratemax;
    u_char outputchannelsmin, outputchannelsmax;
    u_char inputvoicesmax, input3dvoicesmax, eax, voicemanager;
    char pad[2];
};

struct SNDSYSSET {
    u_short maxbanks, outputrate;
    u_char outputchannels, inputvoices, useeax;
    u_char use3dacceleration, use3dmixing;
    char pad;
    u_short emulationsubtype;
    u_short spkrcfg3d[4][4];
};

struct SNDSYSVEC {
    int (*issurfacelocked)(void);
};

struct SNDSAMPLEFORMAT {
    u_short samplerate;
    u_char channels, samplerep;
};

typedef void (*CdlCB)();
typedef charactertbl FONTFILECHAR;
typedef eacelement EACELEMENT;
typedef unsigned int qfunc();

/* These completed foreign-owner tags are absent from PSXFront.obj.  Exact
 * private compiler-boundary views preserve the known extents and field
 * offsets used by the byte-matched bodies without claiming foreign types. */
struct PSXFront_GameSetupCodegenView {
    int raceType, numLaps, skill, commMode, tournamentMultiplier, cops;
    int trafficDensity, localCar, catchupLogic, replayMode, instantReplay;
    int mirrorTrack, reverseTrack, measurement, sgge, track, trackSegment;
    int song, Weather, Fog, Damage, Time, randSeed, easter;
    GameSetup_tControllerData controllerData;
    int pinkSlipsForfeit, checkpointType;
    int checkpointHUD[2];
    int dispatchSpeech, reverseCallSpeech, languageSpeech;
    int SceneNumber, SceneStartLap, SceneEndLap;
    GameSetup_tUserSetting userSetting;
    int numPerps, stageOffset, perpArrests, finalPerpArrests;
    GameSetup_tPerpData perpInfo[10];
    int numCars, numPlayerRaceCars, numOpponentRaceCars, opponentCarType;
    GameSetup_tCarData carInfo[9];
};

struct PSXFront_DRenderCodegenView {
    int id, player;
    DRender_tCalcView cview;
};

struct PSXFront_DFlipCodegenView {
    DISPENV disp;
    char *server;
};

#endif
