/* Owner-specific type surface for FECheats.obj. */
#ifndef NFS4_FRONTEND_COMMON_FECHEATS_TYPES_H
#define NFS4_FRONTEND_COMMON_FECHEATS_TYPES_H

#ifndef NFS4_FECHEATS_NO_CHEAT_RECORDS
typedef enum tCheatCode {
    cheat_Roadster = 0,
    cheat_Pony = 1,
    cheat_Saloon = 2,
    cheat_Sports = 3,
    cheat_SuperCar = 4,
    cheat_GTRCar = 5,
    cheat_BonusCar = 6,
    cheat_CopCar = 7,
    cheat_FiveFingerDiscount = 8,
    cheat_FreeRepairs = 9,
    cheat_NoDamage = 10,
    cheat_AllCars = 11,
    cheat_AllCops = 12,
    cheat_AllTracks = 13,
    cheat_MoreMoney = 14,
    cheat_BonusTrack1 = 15,
    cheat_BonusTrack2 = 16,
    cheat_BonusTrack3 = 17,
    cheat_BonusTrack4 = 18,
    cheat_AllCheats = 19,
    cheat_NFSTeamRecords = 20,
    cheat_MyMomSaysImCool = 21,
    cheat_BonusMoney = 22,
    cheat_LotsaMoney = 23,
    cheat_FullGridTraffic = 24,
    cheat_FinishedTournament = 25,
    cheat_FinishedSpecialEvent = 26,
    cheat_AllNotRaced = 27,
    cheat_AllGold = 28,
    cheat_AllSilver = 29,
    cheat_AllBronze = 30,
    cheat_NumCheats = 31
} tCheatCode;
#endif

/* The retail owner contains color.obj's complete physics/AI/car graph. */
#include "../../game/common/color_types.h"

#define NFS4_TCARCLASSTYPE_DEFINED
typedef enum tCarClassType {
    cct_Roadster = 0, cct_PonyCar = 1, cct_SaloonCar = 2,
    cct_SportsCar = 3, cct_SuperCar = 4, cct_GTRCar = 5,
    cct_BonusCar = 6, cct_CopCar = 7, cct_TrafficCar = 8,
    cct_Helicopter = 9, cct_OpenClass = 10, cct_NumCarClasses = 11
} tCarClassType;

/* FECheats retains the input enum but not the foreign tPlayer enum. */
#define NFS4_FE_INPUT_NO_PLAYER
#include "fe_input_enums.h"
#undef NFS4_FE_INPUT_NO_PLAYER

/* Add only the one car-manager member used by this owner. */
#define NFS4_FE_CORE_FECHEATS_METHODS
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER
#undef NFS4_FE_CORE_FECHEATS_METHODS

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
};

#include "shared/tActiveLine.h"





#include "shared/tShapeInformation.h"








#include "fescreen_virtual_types.h"
struct tMenu;
#include "fescreen.h"

#include "fedialog.h"












/* FECheats needs this foreign class's MemCardDialog offset.  Its exact layout
 * is pair-locked by the canonical audit because the linked owner attributes
 * the class definition to FEApp.obj instead of repeating it here. */
struct tFEApplication {
    unsigned int fCurrentMusic;
    tMenu *fCurrentMenu[2];
    tScreen *fCurrentScreen[2];
    tMenu *fTransitionToMenu[2];
    tScreen *fTransitionToScreen[2];
    tMenu *fParentMenu[2];
    tDialogMessageString messagePopup;
    tMenu *backList[2][16];
    int backDepth[2];
    tInputKeyType fLastKeyPressed[2];
    short fYOffset;
    tDialogHelp helpPopup;
    char fPlayer, fInputPlayer;
    bool waitingForOtherPlayer[2];
    tDialogMessageStringWithTimeout MemCardDialog;
    tDialogNoInputMessage NoInputMemCardDialog;
    bool gotName[2], needName[2];
    int speechToPlay[2];
};

/* The owner retains tSaveRecords but attributes this already-seen element tag
 * body elsewhere in the linked SYM.  The canonical audit pair-locks both. */
#ifndef NFS4_FECHEATS_NO_RECORD_BUFFER
#include "shared/tRecordBuffer.h"



typedef tRecordBuffer tSaveRecords[187];
#endif

#ifndef NFS4_FECHEATS_NO_CHEAT_RECORDS
struct tCheat {
    u_char name[8];
    tCheatCode cheat;
};
#endif

#endif
