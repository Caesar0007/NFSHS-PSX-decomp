/* Draw_tCacheHeader -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRAW_TCACHEHEADER_H
#define NFS4_SHARED_DRAW_TCACHEHEADER_H

struct Draw_tCacheHeader {
    Draw_PrimStruct cprim;
    int mirror;
    short clipW, clipH;
};
#endif
