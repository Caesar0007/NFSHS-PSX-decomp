/* Owner-specific type surface for Front.obj. */
#if !defined(NFS4_FRONTEND_COMMON_FRONT_TYPES_H) || defined(NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR)
#ifndef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR   /* else: the screendisplay_types.h after-color hook pass (Force_tGlobal, tRecordBuffer, tScreenControllerConfig) */
#define NFS4_FRONTEND_COMMON_FRONT_TYPES_H
/* Front.obj retains the FEMenuDefs shared graph, but not FEMenuDefs' three owner records or its pointer-only screen views. */
#define NFS4_SCREENDISPLAY_HOOK_AFTER_COLOR "front_types.h"   /* retail Front: Force_tGlobal + tScreenControllerConfig + tRecordBuffer after the color graph */
#define NFS4_SCREENDISPLAY_HOOK_BEFORE_ACTIVELINE "front_processing_type.h"   /* retail: tFront_ProcessingType right after tfrontEnd */

#define NFS4_FEMENUDEFS_NO_SCREENMAIN_VIEW
#define NFS4_FEMENUDEFS_NO_SCREENTROPHYROOM_VIEW
#define NFS4_FEMENUDEFS_NO_GAMESETUP_VIEW
#define NFS4_FEMENUDEFS_NO_DIALOGYESNOTRI
#define NFS4_FEMENUDEFS_NO_FEAPPLICATION

#include "femenudefs_types.h"

#undef NFS4_FEMENUDEFS_NO_FEAPPLICATION
#undef NFS4_FEMENUDEFS_NO_DIALOGYESNOTRI
#undef NFS4_FEMENUDEFS_NO_GAMESETUP_VIEW
#undef NFS4_FEMENUDEFS_NO_SCREENTROPHYROOM_VIEW
#undef NFS4_FEMENUDEFS_NO_SCREENMAIN_VIEW
#include "front_processing_type.h"

#endif
#ifdef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR
#include "shared/Force_tGlobal.h"




#include "cls_tScreenControllerConfig.h"   /* class tScreenControllerConfig: no private copy (header-truth 4u) */



























#include "shared/tRecordBuffer.h"   /* retail: right after tScreenControllerConfig (2 pairs off; the struct keeps its lines) */
#endif
#ifndef NFS4_SCREENDISPLAY_IN_HOOK_AFTER_COLOR
#include "screenmain.h"
#include "front_cs_screens.h"   /* tScreenCarSelectDuel, tScreenPinkSlipsCarSelect (moved verbatim) */


#include "screentournselect.h"

#include "front_standings_screen.h"   /* tScreenPinkSlipStandings (moved verbatim) */

#include "screentrophyroom.h"

#include "screentrophyinfo.h"

#include "screendisplay.h"

#include "screenaudio.h"

#include "front_tournamenttrophy.h"   /* tScreenTournamentTrophy (moved verbatim) */










#include "cls_tScreenBeTheCopCongrats.h"   /* class tScreenBeTheCopCongrats: no private copy (header-truth 4u) */







#include "cls_tScreenTournamentCongrats.h"   /* class tScreenTournamentCongrats: no private copy (header-truth 4u) */







#include "screentrackrecords.h"

#include "femenudefs_mission.h"   /* retail Front: mission records right after tScreenTrackRecords */
#include "screentracks.h"

#include "screentrackinfo.h"

#include "screenpinkslips.h"
#include "shared/copLevel_t.h"
#include "shared/copGame_t.h"
enum crimeType {
    CRIME_NONE = 0,
    CRIME_SPEEDER = 1,
    CRIME_WRONGSIDE = 2,
    CRIME_BUMPCOP = 3,
    CRIME_SMASHCOP = 4
};









































struct tAllScreens {
    tScreenMain screenMain;
    tScreenCarSelect screenCarSelect;
    tScreenCarSelectDuel screenCarSelectDuel;
    tScreenCarSelectTwoPlayer screenCarSelectTwoPlayer, screenCarSelectPlayerTwo;
    tScreenPinkSlipsCarSelect screenPinkSlipsCarSelectTwoPlayer;
    tScreenPinkSlipsCarSelect screenPinkSlipsCarSelectPlayerTwo;
    tScreenTrackRecords screenTrackRecords;
    tScreenTrackInfo screenTrackInfo;
    tScreenTrackSelect screenTrackSelect;
    tScreenTournSelect screenTournSelect;
    tScreenTournamentStandings screenTournamentStandings;
    tScreenTournamentTrophy screenTournamentTrophy;
    tScreenTrophyRoom screenTrophyRoom;
    tScreenTrophyInfo screenTrophyInfo;
    tScreenControllerConfig screenControllerConfig;
    tScreenDisplay screenDisplay;
    tScreenAudio screenAudio;
    tScreenMemcard screenMemcard;
    tScreenUserName screenUserName;
    tScreenPinkSlipCongrats screenPinkSlipCongrats;
    tScreenPinkSlipStandings screenPinkSlipStandings;
    tScreenTournamentStandings3item screenTournamentStandings3item;
    tScreenPinkSlips screenPinkSlips;
    tScreenBeTheCopCongrats screenBeTheCopCongrats;
    tScreenTournamentCongrats screenTournamentCongrats;
#line 226 "C:/nfs4/FRONTEND/COMMON/FRONT.CPP"
};
#line 190 "front_types.h"

struct tPerpModelList {
    tCarModels carModel;
    char carColor;
};

struct tFEStream {
    short totalCars, totalModels, currentCar, numPlayers;
    tCarInfo playerCars[2];
    short numOpponents;
    tCarLineup carLineup[6];
    short numCops, numSuperCops;
    tCarModels copCars[6];
    short copCountry[6];
    short numTraffic;
    short trafficCars[6];
    short numPerpObjects, numPerps;
    tMissionInfo *pMission;
    tStageInfo *pStages;
    tPerpModelList perps[6];
    tTrackInformation trackInfo;
    tTrackInfo track;
};

struct tCarInLineup {
    char isPlayerCar, isAlive, AIPersonality, LineupPosition;
};

/* These foreign objects are complete at their allocation/use sites, but their
 * tags are not retained in Front.obj. Exact-size views preserve codegen while
 * keeping the owner graph honest. */
#include "feapp_class.h"   /* class tFEApplication: no private copy (header-truth 4j) */







#include "femenudefs_globalmenudefs.h"   /* the real tGlobalMenuDefs (no opaque view; header-truth 4w) */





#include "shared/tMissionManager.h"   /* the real tMissionManager (no codegen view / asm aliases; header-truth 4w) */










/* GameSetup_gData: Front.obj records no GameSetup type -- read through a word-pair view of the same 2600
   bytes (front_externs.h: `extern int GameSetup_gData[325][2];`): replayMode [4][1], pinkSlipsForfeit [23][0],
   controllerData.X[i] -> [12..22][i] (controllerConfig 12, deadSpot 13, steeringRange 14, IImaxRange 15,
   ImaxRange 16, shockMode 21, shockImpact 22). */
#define GameSetup_tData int
#define NFS4_FRONT_GS_DIMS [325][2]




#include "shared/tCreditManager.h"   /* one tCreditManager definition (no opaque view; header-truth 4t) */





#endif
#endif
