/* Owner-specific type surface for FECars.obj. */
#ifndef NFS4_FRONTEND_COMMON_FECARS_TYPES_H
#define NFS4_FRONTEND_COMMON_FECARS_TYPES_H
/* FECars spells its own car manager + iterators at their retail places through fe_core_cars.h owner hooks. */
#define NFS4_FE_CORE_CARS_SAVEINFO
#define NFS4_FE_CORE_CARS_CLASSTYPE
#define NFS4_FE_CORE_CARS_LINEUP
#define NFS4_FE_CORE_CARS_HOOK_AFTER_OWNED "fecars_carlist.h"
#define NFS4_FE_CORE_CARS_HOOK_MANAGER "fecars_manager.h"
#define NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER "fecars_iters.h"
#include "fe_core_types.h"

#include "fe_player_types.h"
#include "fe_tournament_types.h"

/* Source spellings/constants do not create records in FECars.obj. */
#define uchar unsigned char
#define RaceType_SingleRace 0
#define RaceType_HotPursuit 1
#define RaceType_Tournament 2


typedef struct tTournamentManager {
    char fNumTiers;
    int fTier, fTournament, fCurrentTrack;
    int fNumRacers;
    long fMoney;
    tTournamentDefinition *fDefinition;
    short fTierList[4], fTierFinishPrize[4], fTierFinishPrizeChange[4];
    short fTournamentList[65]; short fTrackList[17];
    char fDirection[16], fMirror[16], fTimeOfDay[16], fWeather[16];
    tCompetitor fCompetitors[6];
    tCarLineup fCarLineup[6];
    signed char fBestPlacement[64];
    char fPrevBestPlacement;
    u_char fFinishPoints[6], fRanking[6];
    tAwardInformation fAwards;
#include "shared/tTournamentManager_inl.h"   /* retail in-class inline bodies (see file) */

    bool ValidCar(tCarInfo &carInfo);
} tTournamentManager;

#include "shared/tSaveCarInfo.h"






#endif
