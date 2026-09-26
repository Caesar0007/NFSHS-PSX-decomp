/* tAcademyDefinition -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TACADEMYDEFINITION_H
#define NFS4_SHARED_TACADEMYDEFINITION_H

struct tAcademyDefinition {
    tMissionTierInfo fTiers[8];
    tMissionInfo fMissions[64];
    tStageInfo fStages[256];
};
#endif
