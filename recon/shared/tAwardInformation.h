/* tAwardInformation -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TAWARDINFORMATION_H
#define NFS4_SHARED_TAWARDINFORMATION_H

struct tAwardInformation {
    long fMoney, fTournMoney;
    u_short fActivateFlags;
    char fActivateTrack;
    tCarClassType fActivateCarClass;
    tCarModels fActivateCar;
    tTrackClassType fActivateTrackClass;
    long fActivateCheat;
    bool fAwardCar, fAwardCarGarageFull;
    long fAwardCarBonusMoney;
    tCarModels fAwardCarModel;
    char fAwardCarColor, fAwardCarUpgrades;
    bool fCompletedTier;
    short fCompletedText;
    tCarModels fCompletedCar;
    bool fCompletedGarageFull;
    long fCompletedBonusMoney;
};
#endif
