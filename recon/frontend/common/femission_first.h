/* femission_first.h -- FEMission.obj's own records (moved verbatim from femission_types.h): retail emits them ahead
 * of the platform core (nfs4_types.h NFS4_CORE_FEMISSION_FIRST hook) and femission_types.h includes this in place. */
#ifndef NFS4_FRONTEND_COMMON_FEMISSION_FIRST_H
#define NFS4_FRONTEND_COMMON_FEMISSION_FIRST_H
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
