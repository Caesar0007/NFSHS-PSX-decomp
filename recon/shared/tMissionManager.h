/* tMissionManager -- FEMISSION.H, one definition for every includer (header-truth 4t). Members are defined in femission.cpp. */
#ifndef NFS4_SHARED_TMISSIONMANAGER_H
#define NFS4_SHARED_TMISSIONMANAGER_H
struct tAcademyDefinition; struct tStageInfo; struct tMissionInfo;
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
