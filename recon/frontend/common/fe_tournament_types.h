/* Tournament records shared by the retail FECars.obj and FETourn.obj owners. */
#ifndef NFS4_FRONTEND_COMMON_FE_TOURNAMENT_TYPES_H
#define NFS4_FRONTEND_COMMON_FE_TOURNAMENT_TYPES_H

#include "fe_track_types.h"

#ifndef NFS4_TCARCLASSTYPE_DEFINED
#define NFS4_TCARCLASSTYPE_DEFINED
typedef enum tCarClassType {
    cct_Roadster = 0, cct_PonyCar = 1, cct_SaloonCar = 2,
    cct_SportsCar = 3, cct_SuperCar = 4, cct_GTRCar = 5,
    cct_BonusCar = 6, cct_CopCar = 7, cct_TrafficCar = 8,
    cct_Helicopter = 9, cct_OpenClass = 10, cct_NumCarClasses = 11
} tCarClassType;
#endif

#include "shared/tCarLineup.h"







#include "shared/tTierInfo.h"




#include "shared/tTourneyInfo.h"














#include "shared/tTrackInfo.h"








#include "shared/tTournamentDefinition.h"





#include "shared/tAwardInformation.h"


















#include "shared/tCompetitor.h"








#endif
