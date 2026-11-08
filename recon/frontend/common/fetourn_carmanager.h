/* fetourn_carmanager.h -- FETourn.obj tCarManager (owner method surface), moved verbatim from fetourn_types.h; reached through
 * fe_core_cars.h NFS4_FE_CORE_CARS_HOOK_MANAGER (retail: between tCarNameLength and tPersonalities). */
#ifndef NFS4_FRONTEND_COMMON_FETOURN_CARMANAGER_H
#define NFS4_FRONTEND_COMMON_FETOURN_CARMANAGER_H
typedef struct tCarManager {
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
#if !defined(NFS4_FRONT_SURFACE) && !defined(NFS4_FE_CORE_SCREENCARSELECT_METHODS) && !defined(NFS4_GAME_COMMON_NFS3_TYPES_H) && !defined(NFS4_TSCREENCONGRATS_OWNER)   /* Front/ScreenCarSelect/NFS3: own tCarManager bodies already give retail's run */
    /* INFERRED bodies (user ruling 2026-11-08): retail records `tCarManager x2 | tCarInfo, tOwnedCarInfo | tCarManager, tCarInfo` in
       every object (ORDERG_state ANALYSIS): body #1 this-only (first request -> field types), body #2 this + a tCarInfo parameter; never called */
    u_long CarCount() { return fNumCars; }
    int CarIndex(tCarInfo *car) { return car - fCars; }
#endif
} tCarManager;
#endif
