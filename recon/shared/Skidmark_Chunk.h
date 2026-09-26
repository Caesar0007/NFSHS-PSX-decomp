/* Skidmark_Chunk -- the one definition of this type, shared by 17 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_SKIDMARK_CHUNK_H
#define NFS4_SHARED_SKIDMARK_CHUNK_H

struct Skidmark_Chunk {
    coorddef cp;
    short n, slice;
    Skidmark_Segment seg[24];
};
#endif
