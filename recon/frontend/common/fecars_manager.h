/* frontend/common/fecars_manager.h -- FECars.obj owner records emitted through the fe_core_cars.h hook NFS4_FE_CORE_CARS_HOOK_MANAGER (retail order). */
#ifndef NFS4_FRONTEND_COMMON_FECARS_MANAGER_H
#define NFS4_FRONTEND_COMMON_FECARS_MANAGER_H
typedef struct tCarManager {
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
#if !defined(NFS4_FRONT_SURFACE) && !defined(NFS4_FE_CORE_SCREENCARSELECT_METHODS) && !defined(NFS4_GAME_COMMON_NFS3_TYPES_H) && !defined(NFS4_TSCREENCONGRATS_OWNER)   /* Front/ScreenCarSelect/NFS3: own tCarManager bodies already give retail's run */
    /* INFERRED bodies (user ruling 2026-11-08): retail records `tCarManager x2 | tCarInfo, tOwnedCarInfo | tCarManager, tCarInfo` in
       every object (ORDERG_state ANALYSIS): body #1 this-only (first request -> field types), body #2 this + a tCarInfo parameter; never called */
    u_long CarCount() { return fNumCars; }
    int CarIndex(tCarInfo *car) { return car - fCars; }
#endif
} tCarManager;
#endif
