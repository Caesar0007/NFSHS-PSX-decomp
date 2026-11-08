/* AITune_BTC_t -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_AITUNE_BTC_T_H
#define NFS4_SHARED_AITUNE_BTC_T_H

struct AITune_BTC_t {
    int glueMult, speedMult, weightMult, baseChaseTime;
    int wingmanTime, blockaderTime, spikeBeltTime;
};
#ifdef NFS4_TU_AITUNE   /* owner object: retail records the C-style `typedef struct AITune_BTC_t {..} AITune_BTC_t;` form (TPDEF twice) */
typedef struct AITune_BTC_t AITune_BTC_t;
#endif
#endif
