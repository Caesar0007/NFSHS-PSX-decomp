/* nfs4_core_1_gpu_d5 -- moved verbatim out of nfs4_core_1_gpu.h so that header holds only its include list. */
#ifndef NFS4_NFS4_CORE_1_GPU_D5_H
#define NFS4_NFS4_CORE_1_GPU_D5_H
typedef struct {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    short x1,y1; u_char u1,v1; u_short tpage; short x2,y2; u_char u2,v2;
    u_short pad1;
} POLY_FT3;
#endif
