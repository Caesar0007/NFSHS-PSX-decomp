/* tSaveTournament -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TSAVETOURNAMENT_H
#define NFS4_SHARED_TSAVETOURNAMENT_H

struct tSaveTournament {
    long fSaveMoney;
    u_char fSaveTier, fSaveTournament, fSaveTrack, fSaveNumRacers;
    tCompetitor fSaveCompetitors[6];
    u_char fSaveBestPlacement[64];
    short fSaveTierFinishPrize[4];
};
#endif
