/* gmesetup.obj source-visible types; full supplied type-copy/order audit remains open. */
#if !defined(NFS4_GAME_COMMON_GMESETUP_TYPES_H) && !defined(NFS4_PADS_IN_HOOK)
#define NFS4_GAME_COMMON_GMESETUP_TYPES_H
#ifndef NFS4_GMESETUP_OMIT_OWNER_RECORDS   /* retail gmesetup.obj: GameSetup records, FEI_tList, Transformer_* right after PAD_COMMON */
#define NFS4_PADS_HOOK_AFTER "gmesetup_types.h"
#endif

#include "color_types.h"

#ifndef NFS4_GMESETUP_OMIT_OWNER_RECORDS
#include "shared/FEI_tList.h"

#include "shared/Input_tDeviceList.h"





#include "shared/GameSetup_tData.h"















#endif

#ifdef NFS4_GMESETUP_HOOK_BEFORE_FE   /* an includer's own types between Car_tObj and the frontend block (r3dcar.obj) */
#define NFS4_GMESETUP_IN_FE_HOOK
#include NFS4_GMESETUP_HOOK_BEFORE_FE
#undef NFS4_GMESETUP_IN_FE_HOOK
#endif
#include "shared/tTexture_ShapeInfo.h"
#include "shared/kernpair.h"










#include "shared/tMenuCommandType.h"   /* one tMenuCommandType definition (header-truth 8a) */












struct tMenuCommand;
struct tMenu;
struct tScreen;

#include "shared/fe_menu_game_surface.h"
































enum tCarModels {
    cm_MercedesSLK = 0, cm_BMWZ3 = 1, cm_HoldenHSVT = 2,
    cm_FordFalcon = 3, cm_ChevyCamaro = 4, cm_TransAm = 5,
    cm_AstonMartinDB7 = 6, cm_JaguarXKR = 7, cm_BMWM5 = 8,
    cm_ChevyCorvette = 9, cm_Ferrari550 = 10, cm_Porsche911 = 11,
    cm_FerrariF50 = 12, cm_DiabloSV = 13, cm_MercedesCLK = 14,
    cm_McLarenF1 = 15, cm_XPerimentalPorsche = 16,
    cm_XPerimentalF50 = 17, cm_XPerimentalF1 = 18,
    cm_BonusCar1 = 19, cm_BonusCar2 = 20, cm_BonusCar3 = 21,
    cm_CapriceCop = 22, cm_HoldenHSVTCop = 23, cm_BMWM5Cop = 24,
    cm_CorvetteCop = 25, cm_PorscheCop = 26, cm_DiabloCop = 27,
    cm_Helicopter = 28, cm_AudiA4 = 29, cm_BMW530i = 30,
    cm_Mercedes500SL = 31, cm_VolvoWagon = 32, cm_SchoolBus = 33,
    cm_LandCruiser = 34, cm_Miata = 35, cm_ArmyTruck = 36,
    cm_JeepCommanche = 37, cm_OneTonTruck = 38,
    cm_OneTonTruckDirty = 39, cm_MercedesVan = 40,
    cm_JeepCherokee = 41, cm_Satellite = 42, cm_OldChevyPickup = 43,
    cm_FordF150 = 44, cm_Barracuda = 45, cm_TaxiCab = 46,
    cm_TourBus = 47, cm_LoggingTruck = 48, cm_TransitBus = 49,
    cm_NumCarModels = 50
};



#include "shared/tCarInfo.h"




















#include "shared/tOwnedCarInfo.h"
enum tCarNameLength { cnl_Medium = 0, cnl_Short = 1, cnl_Long = 2 };




#include "../../frontend/common/fecars_manager.h"   /* class tCarManager: no private copy (header-truth 4k) */













enum tPersonalities {
    kPersonalityNemesis = 0, kPersonalityBlurrr = 1,
    kPersonalityZippy = 2, kPersonalityJetBoy = 3,
    kPersonalityMenace = 4, kPersonalityCop1 = 5,
    kPersonalityCop2 = 6, kPersonalityCop3 = 7,
    kPersonalityTraffic = 8, kPersonalityNUM = 9
};

#include "shared/tfrontEnd.h"















































typedef kernpair KERN;

/* Some object owners retain the shared GameSetup graph but not this callback
 * typedef.  Narrow owner headers may suppress only this row while keeping the
 * remaining canonical surface unchanged. */
#ifndef NFS4_GMESETUP_OMIT_INPUT_DEVICE_CALL
typedef int Input_tDeviceCall();
#endif
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#elif defined(NFS4_PADS_IN_HOOK) && !defined(NFS4_GMESETUP_PADS_DONE)
#define NFS4_GMESETUP_PADS_DONE
#include "gamesetup_leaf_types.h"
#include "shared/GameSetup_tData.h"
#include "shared/FEI_tList.h"
#include "shared/Transformer_z.h"
#endif
