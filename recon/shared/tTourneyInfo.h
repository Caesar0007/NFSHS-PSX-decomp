/* tTourneyInfo -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TTOURNEYINFO_H
#define NFS4_SHARED_TTOURNEYINFO_H

struct tTourneyInfo {
    char fTournamentID;
    u_char fNumTracks, fTrackOffset, fOpponentCarClass, fTraffic, fKnockout;
    u_char fNumCars, fAwardCar, fAwardCarModel, fAwardCarUpgrades;
    u_short fActivateFlags, fRequiredFlags;
    u_char fActivatedTrack, fActivatedCarClass, fActivatedCar;
    u_char fRequiredTournamentID, fRequiredCar, fRequiredUpgrades;
    u_char fSpecificUpgrades, fRequiredCheatID, fTrophyID, fPad;
    long fPrize[6];
    long fEntranceFee;
    u_char fPersonalities[5], fOpponentCar[5], fOpponentUpgrades[5];
    u_char fActivatedTrackClass, fActivatedCheat, fNumLaps;
    u_char fReserved[14];
};
#endif
