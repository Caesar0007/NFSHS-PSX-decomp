/* nfs4_core_1_gpu_d1 -- moved verbatim out of nfs4_core_1_gpu.h so that header holds only its include list. */
#ifndef NFS4_NFS4_CORE_1_GPU_D1_H
#define NFS4_NFS4_CORE_1_GPU_D1_H
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
#endif
