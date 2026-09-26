/* Trk_AnimateInst -- the one definition of this type, shared by 15 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRK_ANIMATEINST_H
#define NFS4_SHARED_TRK_ANIMATEINST_H

struct Trk_AnimateInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad, count, interval;
};
#endif
