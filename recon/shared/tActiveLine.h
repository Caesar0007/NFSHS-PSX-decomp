/* tActiveLine -- the one definition of this type, shared by 14 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TACTIVELINE_H
#define NFS4_SHARED_TACTIVELINE_H

struct tActiveLine {
    short startTick, endTick, x1, y1;
    char type;
    short data;
};
#endif
