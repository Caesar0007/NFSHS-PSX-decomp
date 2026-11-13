/* PauseMenu.obj's exact source-visible type surface reconstructed from SYM. */
#if !defined(NFS4_GAME_COMMON_PAUSEMENU_TYPES_H)
#define NFS4_GAME_COMMON_PAUSEMENU_TYPES_H
#define NFS4_MPAUSE_PAUSEMENU_ORDER   /* retail pausemenu.obj: kernpair tTexture frontend after tInputKeyType (mpause_types.h second pass) */
#define NFS4_CORE_POLY_GT4   /* POLY_GT4 at its retail place (after DISPENV; nfs4_types.h) */
#define NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES
#define NFS4_MPAUSE_OMIT_INPUT_DEVICE_CALL
#include "mpause_types.h"
#undef NFS4_MPAUSE_OMIT_INPUT_DEVICE_CALL
#undef NFS4_MPAUSE_OMIT_PAUSEMENU_FOREIGN_TYPES

#define Render_gPacketPtr (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

#include "shared/POLY_GT4.h"





















































/* Canonical hudpmx.obj aggregate used by this translation unit. */
#include "shared/HudPmx_tShape.h"




#elif defined(NFS4_MPAUSE_IN_PAUSEMENU) && !defined(NFS4_PAUSEMENU_FE_DONE)
#define NFS4_PAUSEMENU_FE_DONE
#include "shared/kernpair.h"
#include "shared/tTexture_ShapeInfo.h"










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
enum tCarNameLength {
    cnl_Medium = 0, cnl_Short = 1, cnl_Long = 2
};




#include "../../frontend/common/fecars_manager.h"   /* class tCarManager: no private copy (header-truth 4k) */













enum tPersonalities {
    kPersonalityNemesis = 0, kPersonalityBlurrr = 1,
    kPersonalityZippy = 2, kPersonalityJetBoy = 3,
    kPersonalityMenace = 4, kPersonalityCop1 = 5,
    kPersonalityCop2 = 6, kPersonalityCop3 = 7,
    kPersonalityTraffic = 8, kPersonalityNUM = 9
};

#include "shared/tfrontEnd.h"
#endif
