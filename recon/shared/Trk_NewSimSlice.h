/* Trk_NewSimSlice -- the one definition of this type, shared by 5 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRK_NEWSIMSLICE_H
#define NFS4_SHARED_TRK_NEWSIMSLICE_H

struct Trk_NewSimSlice {
    u_char stripIndex, quadCount, simquadIndex, simquadCount, simquadStartIndex;
};
#endif
