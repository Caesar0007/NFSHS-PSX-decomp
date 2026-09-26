/* LINE_G2 -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_LINE_G2_H
#define NFS4_SHARED_LINE_G2_H

struct LINE_G2 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char r1,g1,b1,p1;
    short x1,y1;
};
#endif
