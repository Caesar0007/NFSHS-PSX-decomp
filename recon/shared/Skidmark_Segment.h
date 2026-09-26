/* Skidmark_Segment -- the one definition of this type, shared by 17 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_SKIDMARK_SEGMENT_H
#define NFS4_SHARED_SKIDMARK_SEGMENT_H

struct Skidmark_Segment {
    SVECTOR svx[2];
    CVECTOR rgb;
    int type;
    Skidmark_Segment *next;
};
#endif
