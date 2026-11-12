/* frontend/common/fe_core_cars.h -- the car-manager tail of fe_core_types.h (tCarModels .. tfrontEnd).  A separate
 * piece only so that the ScreenDisplay graph can place it after its screen records (retail type order). */
#ifndef NFS4_FRONTEND_COMMON_FE_CORE_CARS_H
#define NFS4_FRONTEND_COMMON_FE_CORE_CARS_H

#ifndef NFS4_FE_CORE_NO_CAR_TYPES
enum tCarModels {
    cm_MercedesSLK = 0, cm_BMWZ3 = 1, cm_HoldenHSVT = 2,
    cm_FordFalcon = 3, cm_ChevyCamaro = 4, cm_TransAm = 5,
    cm_AstonMartinDB7 = 6, cm_JaguarXKR = 7, cm_BMWM5 = 8,
    cm_ChevyCorvette = 9, cm_Ferrari550 = 10, cm_Porsche911 = 11,
    cm_FerrariF50 = 12, cm_DiabloSV = 13, cm_MercedesCLK = 14,
    cm_McLarenF1 = 15, cm_XPerimentalPorsche = 16,
    cm_XPerimentalF50 = 17, cm_XPerimentalF1 = 18, cm_BonusCar1 = 19,
    cm_BonusCar2 = 20, cm_BonusCar3 = 21, cm_CapriceCop = 22,
    cm_HoldenHSVTCop = 23, cm_BMWM5Cop = 24, cm_CorvetteCop = 25,
    cm_PorscheCop = 26, cm_DiabloCop = 27, cm_Helicopter = 28,
    cm_AudiA4 = 29, cm_BMW530i = 30, cm_Mercedes500SL = 31,
    cm_VolvoWagon = 32, cm_SchoolBus = 33, cm_LandCruiser = 34,
    cm_Miata = 35, cm_ArmyTruck = 36, cm_JeepCommanche = 37,
    cm_OneTonTruck = 38, cm_OneTonTruckDirty = 39, cm_MercedesVan = 40,
    cm_JeepCherokee = 41, cm_Satellite = 42, cm_OldChevyPickup = 43,
    cm_FordF150 = 44, cm_Barracuda = 45, cm_TaxiCab = 46,
    cm_TourBus = 47, cm_LoggingTruck = 48, cm_TransitBus = 49,
    cm_NumCarModels = 50
};

#include "shared/tCarInfo.h"
#include "shared/tOwnedCarInfo.h"
#ifdef NFS4_FE_CORE_CARS_SAVEINFO   /* retail FEMemcard: tSaveCarInfo right after tOwnedCarInfo */
#include "shared/tSaveCarInfo.h"
#endif
#ifdef NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType right after tOwnedCarInfo */
#include "shared/tCarClassType.h"
#endif
#ifdef NFS4_FE_CORE_CARS_HOOK_AFTER_OWNED   /* owner hook: records after tOwnedCarInfo/tSaveCarInfo/tCarClassType (fecars: tCarListType) */
#define NFS4_FE_CORE_CARS_IN_HOOK
#include NFS4_FE_CORE_CARS_HOOK_AFTER_OWNED
#undef NFS4_FE_CORE_CARS_IN_HOOK
#endif

enum tCarNameLength {
    cnl_Medium = 0,
    cnl_Short = 1,
    cnl_Long = 2
};
#ifdef NFS4_FE_CORE_CARS_HOOK_BEFORE_MANAGER   /* owner hook: between tCarNameLength and tCarManager (retail ScreenCarSelect: tCarStatType) */
#define NFS4_FE_CORE_CARS_IN_HOOK
#include NFS4_FE_CORE_CARS_HOOK_BEFORE_MANAGER
#undef NFS4_FE_CORE_CARS_IN_HOOK
#endif

#include "fecars_manager.h"   /* class tCarManager: one definition (header-truth 4k) */

































































#ifdef NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER   /* owner hook: right after tCarManager (retail: tListIteratorCar, tListIteratorCarColor) */
#define NFS4_FE_CORE_CARS_IN_HOOK
#include NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER
#undef NFS4_FE_CORE_CARS_IN_HOOK
#endif

#include "../../game/common/gamesetup_leaf_types.h"   /* retail: GameSetup after tCarManager */

enum tPersonalities {
    kPersonalityNemesis = 0, kPersonalityBlurrr = 1,
    kPersonalityZippy = 2, kPersonalityJetBoy = 3,
    kPersonalityMenace = 4, kPersonalityCop1 = 5,
    kPersonalityCop2 = 6, kPersonalityCop3 = 7,
    kPersonalityTraffic = 8, kPersonalityNUM = 9
};

#ifdef NFS4_FE_CORE_CARS_HOOK_AFTER_PERSONALITIES   /* owner hook: right after tPersonalities */
#define NFS4_FE_CORE_CARS_IN_HOOK
#include NFS4_FE_CORE_CARS_HOOK_AFTER_PERSONALITIES
#undef NFS4_FE_CORE_CARS_IN_HOOK
#endif
#ifdef NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup right after tPersonalities, before tfrontEnd */
#include "shared/tCarLineup.h"
#endif
#include "shared/tfrontEnd.h"
#endif

#endif
