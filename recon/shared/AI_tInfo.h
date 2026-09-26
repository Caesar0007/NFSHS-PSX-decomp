/* AI_tInfo -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_AI_TINFO_H
#define NFS4_SHARED_AI_TINFO_H

struct AI_tInfo {
    Car_tObj *blockingCars[3];
    int blockingCarsDist[3], laneSpeeds[3], laneSpeedsAhead[3], laneWeights[3];
    int desiredLane, desiredLaneSide, deltaYaw;
};
#endif
