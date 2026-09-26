/* nfs3.obj's exact source-visible delta over the shared CopSpeak graph. */
#ifndef NFS4_GAME_COMMON_NFS3_TYPES_H
#define NFS4_GAME_COMMON_NFS3_TYPES_H

#define cheat_Roadster 0
#define kFront_InitialLoad 0

typedef enum tCarClassType {
    cct_Roadster = 0, cct_PonyCar = 1, cct_SaloonCar = 2,
    cct_SportsCar = 3, cct_SuperCar = 4, cct_GTRCar = 5,
    cct_BonusCar = 6, cct_CopCar = 7, cct_TrafficCar = 8,
    cct_Helicopter = 9, cct_OpenClass = 10, cct_NumCarClasses = 11
} tCarClassType;

#define NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#define NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#define NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#define NFS4_COPSPEAK_KEEP_FORCE_FOCUS
#define NFS4_COPSPEAK_KEEP_BW_CONTEXT
#define NFS4_AUDIOCMN_KEEP_INPUT_DEVICE_CALL
#define NFS4_AUDIOCMN_DECLARE_CAR_MANAGER_METHODS
#include "copspeak_types.h"
#undef NFS4_AUDIOCMN_DECLARE_CAR_MANAGER_METHODS
#undef NFS4_AUDIOCMN_KEEP_INPUT_DEVICE_CALL
#undef NFS4_COPSPEAK_KEEP_BW_CONTEXT
#undef NFS4_COPSPEAK_KEEP_FORCE_FOCUS
#undef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#undef NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#undef NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS

typedef enum tTrackClassType {
    tct_Beginner = 0,
    tct_Intermediate = 1,
    tct_Expert = 2,
    tct_GTR = 3,
    tct_Bonus = 4
} tTrackClassType;

struct tNfsSystemInfo { int userRam; };

#include "shared/Sim_tSimSystemVar.h"




struct tListIteratorIndexed : public tListIterator { char *fIndex; };

#include "shared/tShapeInformation.h"








struct tMenuCommand;
struct tScreen {
    tShapeInformation fPermShapes, fSwapShapes;
    int fTransitionTicks;
    bool fTransitionOff;
    int fInternalScreenFadeVal;
    short fScreenFadeVal;
/* retail slot list (10 slots); NFS3.obj defines neither tPlayer nor tInputKeyType */
#define tPlayer int
#define tInputKeyType int
#include "../../frontend/common/fescreen_virtuals.inc"
#undef tPlayer
#undef tInputKeyType
};

#include "shared/tCarLineup.h"







#include "shared/tTrackInformation.h"











struct tTrackManager {
    u_long fNumTracks;
    tTrackInformation *fTracks;
    bool fAvailableTracks[16], fViewableTracks[16];

    void Initialize();
    void LoadDescription();
    void ReleaseDescription();
};

#include "shared/tTierInfo.h"




#include "shared/tTourneyInfo.h"














#include "shared/tTrackInfo.h"








#include "shared/tTournamentDefinition.h"





#include "shared/tAwardInformation.h"


















#include "shared/tCompetitor.h"








struct tTournamentManager {
    char fNumTiers;
    int fTier, fTournament, fCurrentTrack;
    int fNumRacers;
    long fMoney;
    tTournamentDefinition *fDefinition;
    short fTierList[4], fTierFinishPrize[4], fTierFinishPrizeChange[4];
    short fTournamentList[65];
    short fTrackList[17];
    char fDirection[16], fMirror[16], fTimeOfDay[16], fWeather[16];
    tCompetitor fCompetitors[6];
    tCarLineup fCarLineup[6];
    signed char fBestPlacement[64];
    char fPrevBestPlacement;
    u_char fFinishPoints[6], fRanking[6];
    tAwardInformation fAwards;

    void Initialize();
    void LoadDescription();
    void ReleaseDescription();
};

#include "shared/tMissionTierInfo.h"



#include "shared/tMissionInfo.h"







#include "shared/tStageInfo.h"









#include "shared/tAcademyDefinition.h"





struct tMissionManager {
    char fNumTiers;
    tAcademyDefinition *fDefinition;

    void Initialize();
    void LoadDescription(bool LoadHotPursuit);
    void ReleaseDescription();
};

#include "shared/tActiveLine.h"





struct tDialogBase : public tScreen {
    short specificPlayer, left, top, width, height, reservedheight;
    bool currentlyOn;
    long startTicks, timeOutTicks;
    short OffsetX, OffsetY, MaxW, MaxH;
    bool fFullyOpen;
    short fDefault, ReturnValue;
    int fFadeText;
};

struct tDialogMessageString : public tDialogBase {
    char *string;
    bool Centerit;
};

struct tDialogInteractive : public tDialogMessageString {
    bool ReadyToReturnValue, fCurrentlyRunning;
};

struct tDialogYesNo : public tDialogInteractive { int yesnowords[2]; };

#include "shared/tCredit.h"






struct tCreditManager {
    tCredit *CreditBuffer;
    int fTVFade, fTextFade, fTextFadeDir;
    bool fCreditsInitialized, fRequestDeInit;
    int fNumCredits, fShowCreditNum, fCurrCredit;
    bool StartedTransition, StartedLines, StartedTextFade;
    int fLineTicks, fStartTicks;
};

#include "shared/tRecordBuffer.h"




typedef tRecordBuffer tSaveRecords[187];
typedef u_char Night_tLightingTable[256][16];
typedef u_char Night_tWeatherLightingTable[256];
typedef u_char Night_tCopLightingTable[256][8];

#endif
