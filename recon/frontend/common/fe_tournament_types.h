/* Tournament records shared by the retail FECars.obj and FETourn.obj owners. */
#ifndef NFS4_FRONTEND_COMMON_FE_TOURNAMENT_TYPES_H
#define NFS4_FRONTEND_COMMON_FE_TOURNAMENT_TYPES_H

#include "fe_track_types.h"

#ifndef NFS4_TCARCLASSTYPE_DEFINED
#define NFS4_TCARCLASSTYPE_DEFINED
typedef enum tCarClassType {
    cct_Roadster = 0, cct_PonyCar = 1, cct_SaloonCar = 2,
    cct_SportsCar = 3, cct_SuperCar = 4, cct_GTRCar = 5,
    cct_BonusCar = 6, cct_CopCar = 7, cct_TrafficCar = 8,
    cct_Helicopter = 9, cct_OpenClass = 10, cct_NumCarClasses = 11
} tCarClassType;
#endif

struct tCarLineup {
    bool isPlayerCar;
    tPersonalities personality;
    char position;
    tCarModels carModel;
    char carColor, carUpgrades;
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

#endif
