/* CTrackSpec -- the one definition of this type, shared by 9 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_CTRACKSPEC_H
#define NFS4_SHARED_CTRACKSPEC_H

struct CTrackSpec {
    short fogstate, weatherstate, horizonstate, skystate;
    short nightstate, depthcuestate, worldcolorstate, pad0;
    CFogSpec fogspec;
    CWeatherSpec weatherspec;
    CHorizonSpec horizonspec;
    CSkySpec skyspec;
    CNightSpec nightspec;
    CDepthCueSpec depthcuespec;
    CWorldColor worldcolorspec;
};
#if defined(NFS4_TU_TRACKSPEC)   /* owner object: retail records the C-style `typedef struct CTrackSpec {..} CTrackSpec;` form (TPDEF twice) */
typedef struct CTrackSpec CTrackSpec;
#endif
#endif
