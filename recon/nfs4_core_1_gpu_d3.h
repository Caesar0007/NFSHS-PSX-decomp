/* nfs4_core_1_gpu_d3 -- moved verbatim out of nfs4_core_1_gpu.h so that header holds only its include list. */
#ifndef NFS4_NFS4_CORE_1_GPU_D3_H
#define NFS4_NFS4_CORE_1_GPU_D3_H
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
#endif
