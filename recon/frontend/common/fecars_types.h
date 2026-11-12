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


#include "fetourn_manager_class.h"   /* class tTournamentManager: one definition (header-truth 4l) */



















#include "shared/tSaveCarInfo.h"






#endif
