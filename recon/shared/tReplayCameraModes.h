/* tReplayCameraModes -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TREPLAYCAMERAMODES_H
#define NFS4_SHARED_TREPLAYCAMERAMODES_H

struct tReplayCameraModes {
    int defaultCamera, timeCounter, cameraMode, cutToNextCamera;
};
#ifdef NFS4_TU_REPLAY   /* owner object: retail records the C-style `typedef struct tReplayCameraModes {..} tReplayCameraModes;` form (TPDEF twice) */
typedef struct tReplayCameraModes tReplayCameraModes;
#endif
#endif
