/* blockade_t -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_BLOCKADE_T_H
#define NFS4_SHARED_BLOCKADE_T_H

struct blockade_t {
    blockadeMode_t mode;
    AIHigh_Player *target;
    int flags, chaseLevel, requestSpikeBeltAtSlice, slice, direction;
    int latPos, rotation, reverse, releaseTime, initialPlayerDistanceMetersInt;
    short blockadeSpeechFlags;
};
#endif
