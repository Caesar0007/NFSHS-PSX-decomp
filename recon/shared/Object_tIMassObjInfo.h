/* Object_tIMassObjInfo -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_OBJECT_TIMASSOBJINFO_H
#define NFS4_SHARED_OBJECT_TIMASSOBJINFO_H

struct Object_tIMassObjInfo {
    Trk_AnimateInst *animInst;
    coorddef dimension, lastPos;
    int lastTick;
};
#endif
