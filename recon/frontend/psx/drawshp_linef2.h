/* DrawShp.obj: LINE_F2 next to DR_MODE in the core (nfs4_types.h DRMODE hook; retail has it right after POLY_G4). */
#ifndef NFS4_FRONTEND_PSX_DRAWSHP_LINEF2_H
#define NFS4_FRONTEND_PSX_DRAWSHP_LINEF2_H
typedef struct {
    u_long tag;
    u_char r0, g0, b0, code;
    short x0, y0, x1, y1;
} LINE_F2;
#endif
