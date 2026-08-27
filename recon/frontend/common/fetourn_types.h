/* Owner-specific type surface for FETourn.obj. */
#ifndef NFS4_FRONTEND_COMMON_FETOURN_TYPES_H
#define NFS4_FRONTEND_COMMON_FETOURN_TYPES_H

/* The retail owner contains color.obj's complete 71-record graph. */
#include "../../game/common/color_types.h"

/* Preserve the shared manager layout before declaring FETourn's real class
 * with the owner-specific method surface below. */
#define tCarManager FETourn_CoreCarManagerCodegenView
#include "fe_core_types.h"
#undef tCarManager

/* FETourn retains tListIteratorIndexed's layout but not the foreign tPlayer
 * enum or its method declarations. */
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER

/* Source spellings/constants that do not create retail type records. */
#define byte unsigned char
#define uchar unsigned char
#define uint unsigned int
#define tPlayer int
#define NULL 0
#define Tourn_StartMoney 20000
#define Tourn_RacersCount 6
#define Tourn_TRN_HeaderSize 0x6
#define Tourn_TRN_EntriesStart 0x7
#define cheat_FinishedTournament 25

typedef enum tTrophySize {
    ts_Small = 0,
    ts_Medium = 1,
    ts_Large = 2
} tTrophySize;

struct tSaveTournament {
    long fSaveMoney;
    u_char fSaveTier, fSaveTournament, fSaveTrack, fSaveNumRacers;
    tCompetitor fSaveCompetitors[6];
    u_char fSaveBestPlacement[64];
    short fSaveTierFinishPrize[4];
};

/* The linked FETourn SYM retains this public array typedef while attributing
 * the already-defined element tag body to its earlier owner. */
struct tRecordBuffer {
    char sName[8];
    int nCar, nTime, nBestLap;
};
typedef tRecordBuffer tSaveRecords[187];

struct tCarManager {
    u_long fNumCars;
    tCarInfo *fCars;
    tOwnedCarInfo fCarGarage[2][32], fPinkSlipsCars[2][32];
    u_char fAvailableCars[48], fViewableCars[48];
    u_char fPinkSlipsAvailableCars[2][48];
    u_char fPinkSlipsViewableCars[2][48];
    short fCarTextList[49];

    tCarInfo *GetCarFromID(short carID);
    long PurchaseCar(short carModel, short color, short playerNum);
    long PurchaseUpgrade(short garageNumber, short upgradeFlags, short playerNum);
    void SetClassAvailable(tCarClassType carClass, bool avail);
    void SetCarAvailable(tCarModels carModel, bool avail);
    void SetCarViewable(tCarModels carModel, bool view);
    void GetStockCar(short carNumber, tCarInfo &carInfo);
    void GetGarageCar(short garageNumber, tCarInfo &carInfo, short playerNum);
    short GetNumOwnedCars(short playerNum);
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
    void UpdateTrackList(short tier, short tournament);
    short *GetTrackList(short tier, short tournament);
    void GetTrackToRace(tTrackInfo &track);
    void StartNewTournament(unsigned char tier, unsigned char tournament);
    short IsTournamentFinished();
    void UpdateTournFinishMoney();
    void UpdateTrackFinishMoney();
    void CalcTrackFinishDamageBill(bool recalculate, long &bill, long &bonus);
    void UpdateTrackFinishPoints();
    short AdvanceToNextTrack();
    short GetLastTrackRaced();
    void SaveTournament(tSaveTournament &save);
    void LoadTournament(tSaveTournament &load);
    short GetNumCompetitors();
    void UpdateCarLineup();
    long GetTrackFinishPrize(short position);
    long GetTournamentFinishPrize(short position);
    void GetAwardInformation(tAwardInformation &info);
    void UpdateAwardInformation();
    short TournPointTotal(short *points);
    short PlayerRanking(short position);
    void CalcTierFinishPrize();
    void GetTrophyName(tTourneyInfo *tourn, tTrophySize size,
                       char *buffer, int place);
    bool ValidCar(tCarInfo &carInfo);
};

struct tListIteratorTournament : public tListIterator {
    tTournamentManager *fTournamentManager;

    tListIteratorTournament() {}
    tListIteratorTournament(char *valPtr, tTournamentManager *tournManager);
    ~tListIteratorTournament();
    char Value(int) __asm__("Value__23tListIteratorTournament7tPlayer");
    short TextValue(int) __asm__("TextValue__23tListIteratorTournament7tPlayer");
    void Increment(int) __asm__("Increment__23tListIteratorTournament7tPlayer");
    void Decrement(int) __asm__("Decrement__23tListIteratorTournament7tPlayer");
    bool ValidTournament(char tourn);
};

#endif
