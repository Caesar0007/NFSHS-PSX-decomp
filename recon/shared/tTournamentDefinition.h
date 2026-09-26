/* tTournamentDefinition -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TTOURNAMENTDEFINITION_H
#define NFS4_SHARED_TTOURNAMENTDEFINITION_H

struct tTournamentDefinition {
    tTierInfo fTiers[3];
    tTourneyInfo fTournaments[64];
    tTrackInfo fTracks[128];
};
#endif
