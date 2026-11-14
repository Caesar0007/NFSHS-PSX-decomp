/* Tournament records shared by the retail FECars.obj and FETourn.obj owners. */
#ifndef NFS4_FRONTEND_COMMON_FE_TOURNAMENT_TYPES_H
#define NFS4_FRONTEND_COMMON_FE_TOURNAMENT_TYPES_H

#include "fe_track_types.h"

#ifndef NFS4_TCARCLASSTYPE_DEFINED
#define NFS4_TCARCLASSTYPE_DEFINED
#include "shared/tCarClassType.h"





#endif

#include "shared/tCarLineup.h"
#include "shared/tTierInfo.h"
#include "shared/tTourneyInfo.h"
#include "shared/tTrackInfo.h"
#include "shared/tTournamentDefinition.h"
#include "shared/tAwardInformation.h"
#include "shared/tCompetitor.h"
#ifdef NFS4_FE_TRACK_SAVEINFO   /* retail FEMemcard: tSaveTournament right after tCompetitor */
#include "shared/tSaveTournament.h"
#endif

#endif
