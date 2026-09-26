/* tCompetitor -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TCOMPETITOR_H
#define NFS4_SHARED_TCOMPETITOR_H

struct tCompetitor {
    tPersonalities fPersonality;
    u_char fVariation;
    signed char fIsPlayerCar;
    bool fEliminated;
    u_short fPoints;
    u_char fPosition;
};
#endif
