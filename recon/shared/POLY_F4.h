/* POLY_F4 -- the one definition of this type, shared by 7 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_POLY_F4_H
#define NFS4_SHARED_POLY_F4_H

struct POLY_F4 {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0, x1, y1, x2, y2, x3, y3;
};
#endif
