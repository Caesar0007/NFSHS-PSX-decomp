/* tReplayCameraModes -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TREPLAYCAMERAMODES_H
#define NFS4_SHARED_TREPLAYCAMERAMODES_H

struct tReplayCameraModes {
    int defaultCamera, timeCounter, cameraMode, cutToNextCamera;
};
#endif
