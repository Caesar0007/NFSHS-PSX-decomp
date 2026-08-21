/* Reduced EA/PsyQ platform type surface reconstructed from the frontend/PSX
 * object-local SYM graphs.  The original header filename is not encoded in
 * the SYM; this file restores the common declarations without exposing the
 * hundreds of unrelated game types from nfs4_types.h. */
#ifndef NFS4_FRONTEND_PSX_EA_PSX_TYPES_H
#define NFS4_FRONTEND_PSX_EA_PSX_TYPES_H

typedef unsigned char  u_char;
typedef unsigned short u_short;
typedef unsigned int   u_int;
typedef unsigned long  u_long;
typedef unsigned short ushort;

struct VECTOR {
    long vx, vy, vz, pad;
};
#ifndef __cplusplus
typedef struct VECTOR VECTOR;
#endif

struct SVECTOR {
    short vx, vy, vz, pad;
};
#ifndef __cplusplus
typedef struct SVECTOR SVECTOR;
#endif

struct CVECTOR {
    u_char r, g, b, cd;
};
#ifndef __cplusplus
typedef struct CVECTOR CVECTOR;
#endif

struct DVECTOR {
    short vx, vy;
};
#ifndef __cplusplus
typedef struct DVECTOR DVECTOR;
#endif

struct RVECTOR {
    SVECTOR v;
    u_char  uv[2];
    u_short pad;
    CVECTOR c;
    DVECTOR sxy;
    u_long  sz;
};
#ifndef __cplusplus
typedef struct RVECTOR RVECTOR;
#endif

struct CRVECTOR3 {
    RVECTOR r01, r12, r20;
    RVECTOR *r0, *r1, *r2;
    u_long  *rtn;
};
#ifndef __cplusplus
typedef struct CRVECTOR3 CRVECTOR3;
#endif

struct CRVECTOR4 {
    RVECTOR r01, r02, r31, r32, rc;
    RVECTOR *r0, *r1, *r2, *r3;
    u_long  *rtn;
};
#ifndef __cplusplus
typedef struct CRVECTOR4 CRVECTOR4;
#endif

struct RECT {
    short x, y, w, h;
};
#ifndef __cplusplus
typedef struct RECT RECT;
#endif

struct DR_ENV {
    u_long tag;
    u_long code[15];
};
#ifndef __cplusplus
typedef struct DR_ENV DR_ENV;
#endif

struct DRAWENV {
    RECT    clip;
    short   ofs[2];
    RECT    tw;
    u_short tpage;
    u_char  dtd, dfe, isbg, r0, g0, b0;
    DR_ENV  dr_env;
};
#ifndef __cplusplus
typedef struct DRAWENV DRAWENV;
#endif

struct DISPENV {
    RECT   disp, screen;
    u_char isinter, isrgb24, pad0, pad1;
};
#ifndef __cplusplus
typedef struct DISPENV DISPENV;
#endif

struct shapetbl {
    unsigned int type : 8;
    int          next : 24;
    short        width, height, centerx, centery;
    int          shapex : 12;
    unsigned int reserved : 1;
    unsigned int twiddled : 1;
    unsigned int transposed : 1;
    unsigned int rotated : 1;
    int          shapey : 12;
    unsigned int mipmaps : 4;
    char         data;
};
typedef struct shapetbl SHAPE;

struct cdstreamstruct {
    long id;
    char *start, *end, *write, *header, *get, *release;
    int  handle, state, control, status, abort, datahascrc;
    int  crcerrors, crcretries, buffersize;
    long blocksize;
    int  readsize, chunksize, relocationsize;
    long fileoffset;
    int  fileend;
    long filesize;
    int  dataoffset, seekposition, seekoffset, idtype, idmask;
    struct cdstreamstruct *nextstream;
    void *emptyblock, *head, *tail, *block;
    int  timer, blocktime, streamfull, getable, releaseable;
};
typedef struct cdstreamstruct CDSTREAM;

/* PsyQ SYS/TYPES.H.  The SYM retains physadr's tag and referent size while
 * filtering the private `_physadr` tag block itself. */
typedef unsigned int size_t;
struct _physadr { int r[1]; };
typedef struct _physadr *physadr;
typedef long daddr_t;
typedef char *caddr_t;
typedef long *qaddr_t;
typedef u_long ino_t;
typedef long swblk_t;
typedef long time_t;
typedef short dev_t;
typedef long off_t;
typedef u_short uid_t;
typedef u_short gid_t;
/* The retail objects preserve two PsyQ header variants: frontend C++ TUs use
 * u_char, while game/PSX unpack.obj records u_long.  An owner may select the
 * latter without leaking it into already-exact neighbors. */
#ifdef NFS4_PSYQ_WCHAR_TYPE
typedef NFS4_PSYQ_WCHAR_TYPE wchar_t;
#else
typedef u_char wchar_t;
#endif

typedef void (*VOIDFN)();
typedef int FILEOP;
typedef void FILE_CALLBACK();
typedef int FILE_ATOM();
typedef void THREADPROC();
typedef void THREAD2PROC();
typedef int SYSTEMTASK();
typedef int THREAD;

#endif
