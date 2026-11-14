/* root type graph, part 1 of 5 (cut from nfs4_types.h at its order hooks) */
#ifndef NFS4_CORE_1_GPU_H
#define NFS4_CORE_1_GPU_H
#ifdef NFS4_CORE_PADS_KERNEL_FIRST
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#endif
#ifdef NFS4_CORE_FULL
#include "shared/MATRIX.h"
#endif
typedef struct {
    long vx, vy, vz, pad;
} VECTOR;




typedef struct {
    short vx, vy, vz, pad;
} SVECTOR;




typedef struct {
    unsigned char r, g, b, cd;
} CVECTOR;




typedef struct {
    short vx, vy;
} DVECTOR;




typedef struct {
    SVECTOR v;
    unsigned char  uv[2];
    unsigned short pad;
    CVECTOR c;
    DVECTOR sxy;
    unsigned long  sz;
} RVECTOR;




typedef struct {
    RVECTOR r01, r12, r20;
    RVECTOR *r0, *r1, *r2;
    unsigned long  *rtn;
} CRVECTOR3;




typedef struct {
    RVECTOR r01, r02, r31, r32, rc;
    RVECTOR *r0, *r1, *r2, *r3;
    unsigned long  *rtn;
} CRVECTOR4;




#include "shared/RECT.h"

typedef struct {
    unsigned long tag;
    unsigned long code[15];
} DR_ENV;




/* NFS4_PSYQ_DDV_TYPES: the graphics-primitive subset seen by Ddvfont.obj (retail SYM block: VECTOR..DR_ENV and
 * SYS/TYPES only -- no DRAWENV/DISPENV/shapetbl, no CD stream, no wchar_t/VOIDFN/file/thread typedefs). */
#ifndef NFS4_PSYQ_DDV_TYPES
typedef struct {
    RECT    clip;
    short   ofs[2];
    RECT    tw;
    unsigned short tpage;
    unsigned char  dtd, dfe, isbg, r0, g0, b0;
    DR_ENV  dr_env;
} DRAWENV;




typedef struct {
    RECT   disp, screen;
    unsigned char isinter, isrgb24, pad0, pad1;
} DISPENV;



#ifdef NFS4_CORE_FULL
/* retail: the owner's libgpu.h primitives right after DISPENV, in libgpu.h order (NFS4_PRIM_* from the owner's first header) */
#ifdef NFS4_PRIM_POLY_F3
typedef struct {
    u_long tag; u_char r0,g0,b0,code; short x0,y0,x1,y1,x2,y2;
} POLY_F3;
#endif
#ifdef NFS4_PRIM_POLY_F4
#include "shared/POLY_F4.h"
#endif
#ifdef NFS4_PRIM_POLY_FT3
typedef struct {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    short x1,y1; u_char u1,v1; u_short tpage; short x2,y2; u_char u2,v2;
    u_short pad1;
} POLY_FT3;
#endif
#ifdef NFS4_PRIM_POLY_FT4
#include "shared/POLY_FT4.h"
#endif
#ifdef NFS4_PRIM_POLY_G3
#include "shared/POLY_G3.h"
#endif
#ifdef NFS4_PRIM_POLY_G4
#include "shared/POLY_G4.h"
#endif
#ifdef NFS4_PRIM_POLY_GT3
typedef struct {
    u_long tag;
    u_char r0, g0, b0, code; short x0, y0; u_char u0, v0; u_short clut;
    u_char r1, g1, b1, p1; short x1, y1; u_char u1, v1; u_short tpage;
    u_char r2, g2, b2, p2; short x2, y2; u_char u2, v2; u_short pad2;
} POLY_GT3;
#endif
#ifdef NFS4_CORE_POLY_GT4   /* headers that include shared/POLY_GT4.h: retail emits POLY_GT4 right after DISPENV in every object that records it */
#include "shared/POLY_GT4.h"
#endif
#ifdef NFS4_PRIM_LINE_G2
#include "shared/LINE_G2.h"
#endif
#ifdef NFS4_PRIM_SPRT
#include "shared/SPRT.h"
#endif
#ifdef NFS4_PRIM_TILE_1
typedef struct { u_long tag; u_char r0,g0,b0,code; short x0,y0; } TILE_1;
#endif
#include "shared/DR_MODE.h"
#endif   /* (block continues in the next part) */
#endif   /* (block continues in the next part) */
#endif
