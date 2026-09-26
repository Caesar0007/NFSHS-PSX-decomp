/* CFogSpec -- the one definition of this type, shared by 9 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_CFOGSPEC_H
#define NFS4_SHARED_CFOGSPEC_H

struct CFogSpec {
    int contrast;
    CVECTOR color;
    int start, dist2base;
};
#endif
