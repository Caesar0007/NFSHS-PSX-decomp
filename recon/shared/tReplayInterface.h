/* tReplayInterface -- the one definition of this type, shared by 6 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TREPLAYINTERFACE_H
#define NFS4_SHARED_TREPLAYINTERFACE_H

struct tReplayInterface {
    int pause, speed, end, camera, selection, depressed, changeCamera, statsScreen;
};
#if defined(NFS4_TU_REPLAY)   /* owner object: retail records the C-style `typedef struct tReplayInterface {..} tReplayInterface;` form (TPDEF twice) */
typedef struct tReplayInterface tReplayInterface;
#endif
#endif
