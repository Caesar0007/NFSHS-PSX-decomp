/* Trk_SimpleInst -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRK_SIMPLEINST_H
#define NFS4_SHARED_TRK_SIMPLEINST_H

struct Trk_SimpleInst {
    short size;
    u_char type, objectIndex, zoffset, flags;
    short pad;
    int x, y, z;
};
#endif
