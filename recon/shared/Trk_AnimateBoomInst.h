/* Trk_AnimateBoomInst -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRK_ANIMATEBOOMINST_H
#define NFS4_SHARED_TRK_ANIMATEBOOMINST_H

struct Trk_AnimateBoomInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad, count, interval;
    u_char simIndex, boomIndex;
    short pad2;
};
#endif
