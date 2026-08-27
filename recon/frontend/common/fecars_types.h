/* Owner-specific type surface for FECars.obj. */
#ifndef NFS4_FRONTEND_COMMON_FECARS_TYPES_H
#define NFS4_FRONTEND_COMMON_FECARS_TYPES_H

/* Neighboring owners need only the common manager fields.  Retain that exact
 * layout as a private codegen carrier here, then spell FECars' real manager
 * with its complete owner method surface below. */
#define tCarManager FECars_CoreCarManagerCodegenView
#include "fe_core_types.h"
#undef tCarManager

#include "fe_player_types.h"
#include "fe_tournament_types.h"

/* Source spellings/constants do not create records in FECars.obj. */
#define uchar unsigned char
#define RaceType_SingleRace 0
#define RaceType_HotPursuit 1
#define RaceType_Tournament 2

typedef enum tCarListType {
    clt_Stock = 1, clt_GarageCar = 2, clt_Cop = 4, clt_Pursuit = 8,
    clt_Traffic = 16, clt_PinkSlips = 32, clt_Tournament = 64,
    clt_Dealer = 128
} tCarListType;

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

    bool ValidCar(tCarInfo &carInfo);
};

struct tSaveCarInfo {
    tOwnedCarInfo fSaveInfo[32];
    u_char fSaveAvailable[48], fSaveViewable[48];
};

struct tCarManager {
    u_long fNumCars;
    tCarInfo *fCars;
    tOwnedCarInfo fCarGarage[2][32], fPinkSlipsCars[2][32];
    u_char fAvailableCars[48], fViewableCars[48];
    u_char fPinkSlipsAvailableCars[2][48];
    u_char fPinkSlipsViewableCars[2][48];
    short fCarTextList[49];

    void Initialize();
    tCarInfo *GetCarFromID(short carID);
    tCarInfo *GetCarFromSimID(short carID);
    long CheapestCarStockPrice();
    long CalcUsedPrice(short garageNumber);
    long PurchaseCar(short carModel, short color, short playerNum);
    long SellCar(short garageNumber, short playerNum);
    long PurchaseUpgrade(short garageNumber, short upgradeFlags, short playerNum);
    void RemoveFromPinkSlipsList(short garageNumber, short playerNum);
    void AddToPinkSlipsList(short carModel, short color, short playerNum);
    void AddUpgradesToPinkSlipsList(short garageNumber, short upgradeFlags, short playerNum);
    void LoadCars(tSaveCarInfo &load, short playerNum);
    void SaveCars(tSaveCarInfo &save);
    void LoadPinkSlipsCars(tSaveCarInfo &load, short playerNum);
    void SavePinkSlipsCars(tSaveCarInfo &save, short playerNum,
                           short withoutCarInGarageNumber);
    void SetClassAvailable(tCarClassType carClass, bool avail);
    void SetCarAvailable(tCarModels carModel, bool avail);
    void SetClassViewable(tCarClassType carClass, bool view);
    void SetCarViewable(tCarModels carModel, bool view);
    void GetStockCar(short carNumber, tCarInfo &carInfo);
    void GetGarageCar(short garageNumber, tCarInfo &carInfo, short playerNum);
    void GetPinkSlipsCar(short garageNumber, tCarInfo &carInfo, short playerNum);
    void LoadDescription();
    void ReleaseDescription();
    short GetNumOwnedCars(short playerNum);
    short GetNumTourneyCars(short playerNum);
    short GetNumPinkSlipsCars(short playerNum);
    short GetClassList(tCarClassType carClass, short numElements,
                       tCarModels *models);
    void InitializeIngameCarList();
    bool IsCarAnAddedModel(tCarModels &model, char &color);
    void AddCarToIngameList(tCarModels &model, char &color);
    bool FindSimilarCar(tCarModels &model, char &color, short count,
                        tCarModels *models);
};

struct tListIteratorCar : public tListIterator {
    int fCarListFilter;
    tCarManager *fCarManager;
    tCarNameLength fNameLength;

    tListIteratorCar(char *valPtr, tCarManager *carManager);
    ~tListIteratorCar();
    char Value(tPlayer atIndex);
    short TextValue(tPlayer atIndex);
    void AdjustPosition(tPlayer atIndex, short direction);
    void Increment(tPlayer atIndex);
    void Decrement(tPlayer atIndex);
    bool ValidCar(tPlayer atIndex, char carNumber);
};

struct tListIteratorCarColor : public tListIterator {
    char *fPlayer, *fPlayerCar;
    int fIndexSize;
    tCarManager *fCarManager;

    tListIteratorCarColor(char *value, char *player, char *playerCar,
                          int indexSize, tCarManager *carManager);
    ~tListIteratorCarColor();
    char Value(tPlayer atIndex);
    short TextValue(tPlayer atIndex);
    void Increment(tPlayer atIndex);
    void Decrement(tPlayer atIndex);
};

#endif
