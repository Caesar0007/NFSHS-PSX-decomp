/* Draw_SVertex -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DRAW_SVERTEX_H
#define NFS4_SHARED_DRAW_SVERTEX_H

struct Draw_SVertex {
    short vx, vy, vz;
    u_char u, v;
    short dvx, dvy;
    u_char r, g, b, a;
};
#endif
