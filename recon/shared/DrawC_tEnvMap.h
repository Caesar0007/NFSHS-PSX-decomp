/* DrawC_tEnvMap -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRAWC_TENVMAP_H
#define NFS4_SHARED_DRAWC_TENVMAP_H

struct DrawC_tEnvMap {
    short slice, tex, extra;
};
#ifdef NFS4_TU_DRAWC   /* owner object: retail records the C-style `typedef struct DrawC_tEnvMap {..} DrawC_tEnvMap;` form (TPDEF twice) */
typedef struct DrawC_tEnvMap DrawC_tEnvMap;
#endif
#endif
