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

#include "shared/CdlLOC.h"



#include "shared/charactertbl.h"






struct DR_OFFSET {
    u_long tag;
    u_long code[2];
};

#include "shared/eacelement.h"



#include "shared/POLY_F4.h"





#include "shared/POLY_FT4.h"
















#include "shared/POLY_G4.h"











#include "shared/POLY_GT4.h"



















#include "shared/SNDSYSCAP.h"






#include "shared/SNDSYSSET.h"








#include "shared/SNDSYSVEC.h"



#include "shared/SNDSAMPLEFORMAT.h"




typedef void (*CdlCB)(u_char intr, u_char *result); /* PsyQ 4.3 <libcd.h> */
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
