/* Owner-specific type tail for FEMission.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEMISSION_TYPES_H
#define NFS4_FRONTEND_COMMON_FEMISSION_TYPES_H

#include "fe_core_types.h"

#include "shared/tMissionTierInfo.h"



#include "shared/tMissionInfo.h"







#include "shared/tStageInfo.h"









#include "shared/tAcademyDefinition.h"





struct tMissionManager {
    char fNumTiers;
    tAcademyDefinition *fDefinition;

    void Initialize();
    void LoadDescription(bool LoadHotPursuit);
    void ReleaseDescription();
    short GetMissionStages(short tier, short mission, tStageInfo **pStages);
    void GetMissionToRace(tMissionInfo **mission);
};

#endif
