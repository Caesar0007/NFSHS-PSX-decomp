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

struct Nfs3_SimSystemCodegenView {
    int restartGame, endSimGame, pauseSim, keyRelease;
    int quickPauseSim, goalClockTicks, currentClockTicks;
};
#define Sim_tSimSystemVar Nfs3_SimSystemCodegenView

struct tListIteratorIndexed : public tListIterator { char *fIndex; };

struct tShapeInformation {
    tTexture_ShapeInfo *fShapes;
    char *fFile, *fDestFile;
    unsigned int async_handle;
    u_short fNumShapes, fFlags;
    char fFilename[16];
    bool fLoadCancelled;
};

struct tScreen {
    tShapeInformation fPermShapes, fSwapShapes;
    int fTransitionTicks;
    bool fTransitionOff;
    int fInternalScreenFadeVal;
    short fScreenFadeVal;
    __vtbl_ptr_type (*_vf)[10];
};

struct tCarLineup {
    bool isPlayerCar;
    tPersonalities personality;
    char position;
    tCarModels carModel;
    char carColor, carUpgrades;
};

struct tTrackInformation {
    char fTrackID;
    u_char fSimNumber, fTrackDifficulty, fAvailable, fIsEgg;
    u_char fLengthKM, fLengthMiles, fNumMoments;
    char fShapeName[8], fSplineName[8];
    char fCountry, fDispatch, fReverseCall, fLanguage;
    char fTrafficCars[6];
    short fTX, fTY, fSX, fSY;
    u_char fSpeedoCountry, fPad;
    long fRotate;
};

struct tTrackManager {
    u_long fNumTracks;
    tTrackInformation *fTracks;
    bool fAvailableTracks[16], fViewableTracks[16];

    void Initialize();
    void LoadDescription();
    void ReleaseDescription();
};

struct tTierInfo {
    u_char fNumTournaments, fDescriptionID, fTournOffset, fPad;
    u_char fReserved[8];
};

struct tTourneyInfo {
    char fTournamentID;
    u_char fNumTracks, fTrackOffset, fOpponentCarClass, fTraffic, fKnockout;
    u_char fNumCars, fAwardCar, fAwardCarModel, fAwardCarUpgrades;
    u_short fActivateFlags, fRequiredFlags;
    u_char fActivatedTrack, fActivatedCarClass, fActivatedCar;
    u_char fRequiredTournamentID, fRequiredCar, fRequiredUpgrades;
    u_char fSpecificUpgrades, fRequiredCheatID, fTrophyID, fPad;
    long fPrize[6];
    long fEntranceFee;
    u_char fPersonalities[5], fOpponentCar[5], fOpponentUpgrades[5];
    u_char fActivatedTrackClass, fActivatedCheat, fNumLaps;
    u_char fReserved[14];
};

struct tTrackInfo {
    signed char fTrackNumber;
    u_char fDirection, fMirrored, fTimeOfDay, fWeather;
    u_char fRandom, fSituations, fPad;
    long fPrize[6];
    u_long fDifficulty;
    u_char fReserved[4];
};

struct tTournamentDefinition {
    tTierInfo fTiers[3];
    tTourneyInfo fTournaments[64];
    tTrackInfo fTracks[128];
};

struct tAwardInformation {
    long fMoney, fTournMoney;
    u_short fActivateFlags;
    char fActivateTrack;
    tCarClassType fActivateCarClass;
    tCarModels fActivateCar;
    tTrackClassType fActivateTrackClass;
    long fActivateCheat;
    bool fAwardCar, fAwardCarGarageFull;
    long fAwardCarBonusMoney;
    tCarModels fAwardCarModel;
    char fAwardCarColor, fAwardCarUpgrades;
    bool fCompletedTier;
    short fCompletedText;
    tCarModels fCompletedCar;
    bool fCompletedGarageFull;
    long fCompletedBonusMoney;
};

struct tCompetitor {
    tPersonalities fPersonality;
    u_char fVariation;
    signed char fIsPlayerCar;
    bool fEliminated;
    u_short fPoints;
    u_char fPosition;
};

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

struct tMissionTierInfo {
    u_char fNumMissions, fDescriptionID, fMissionOffset, fPad;
};

struct tMissionInfo {
    u_char fDescriptionID, fTrackNumber, fDirection, fMirrored;
    u_char fTimeOfDay, fWeather, fTraffic, fPad;
    u_short fStageOffset;
    u_char fNumStages;
    u_char fReserved[9];
};

struct tStageInfo {
    u_char fCarModel, fColor, fAIPersonality, fDirection;
    short fTimeLimit, fWingman, fSpikeBelt, fBlockadeCop;
    u_char fPlacement, fStyle;
    u_short fDistance;
    u_long fSpeed, fWeight, fGlue;
    u_char fSpeechColor;
    u_char fReserved[15];
};

struct tAcademyDefinition {
    tMissionTierInfo fTiers[8];
    tMissionInfo fMissions[64];
    tStageInfo fStages[256];
};

struct tMissionManager {
    char fNumTiers;
    tAcademyDefinition *fDefinition;

    void Initialize();
    void LoadDescription(bool LoadHotPursuit);
    void ReleaseDescription();
};

struct tActiveLine {
    short startTick, endTick, x1, y1;
    char type;
    short data;
};

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

struct tCredit {
    short titleTextID, subTitleTextID, titleX, titleY, titleJustify, titleWidth;
    short subTitleX, subTitleY, subTitleJustify, subTitleWidth;
    short textX, textY, textJustify, creditType, bgNumber, pad;
    char text[292];
};

struct tCreditManager {
    tCredit *CreditBuffer;
    int fTVFade, fTextFade, fTextFadeDir;
    bool fCreditsInitialized, fRequestDeInit;
    int fNumCredits, fShowCreditNum, fCurrCredit;
    bool StartedTransition, StartedLines, StartedTextFade;
    int fLineTicks, fStartTicks;
};

struct tRecordBuffer {
    char sName[8];
    int nCar, nTime, nBestLap;
};

typedef tRecordBuffer tSaveRecords[187];
typedef u_char Night_tLightingTable[256][16];
typedef u_char Night_tWeatherLightingTable[256];
typedef u_char Night_tCopLightingTable[256][8];

#endif
