/* nfs4_types.h -- the shared platform type core.  Retail's SYM records exactly these types in (nearly) every
 * object, in this order: the PsyQ graphics/geometry structs, EA's shape and CD-stream structs, then SYS/TYPES.H
 * and EA's file/thread typedefs (tools/psyq_pipe/tagset_cmp.py --core lists them).  cc1 -g records every struct a
 * translation unit defines, used or not, so ONLY the retail-universal core belongs here; game types stay in their
 * module headers (the old mega nfs4_types.h leaked hundreds of them into every object and was removed). */
#ifndef NFS4_TYPES_H
#define NFS4_TYPES_H


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
    unsigned char r, g, b, cd;
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
    unsigned char  uv[2];
    unsigned short pad;
    CVECTOR c;
    DVECTOR sxy;
    unsigned long  sz;
};
#ifndef __cplusplus
typedef struct RVECTOR RVECTOR;
#endif

struct CRVECTOR3 {
    RVECTOR r01, r12, r20;
    RVECTOR *r0, *r1, *r2;
    unsigned long  *rtn;
};
#ifndef __cplusplus
typedef struct CRVECTOR3 CRVECTOR3;
#endif

struct CRVECTOR4 {
    RVECTOR r01, r02, r31, r32, rc;
    RVECTOR *r0, *r1, *r2, *r3;
    unsigned long  *rtn;
};
#ifndef __cplusplus
typedef struct CRVECTOR4 CRVECTOR4;
#endif

#include "shared/RECT.h"

struct DR_ENV {
    unsigned long tag;
    unsigned long code[15];
};
#ifndef __cplusplus
typedef struct DR_ENV DR_ENV;
#endif

/* NFS4_PSYQ_DDV_TYPES: the graphics-primitive subset seen by Ddvfont.obj (retail SYM block: VECTOR..DR_ENV and
 * SYS/TYPES only -- no DRAWENV/DISPENV/shapetbl, no CD stream, no wchar_t/VOIDFN/file/thread typedefs). */
#ifndef NFS4_PSYQ_DDV_TYPES
struct DRAWENV {
    RECT    clip;
    short   ofs[2];
    RECT    tw;
    unsigned short tpage;
    unsigned char  dtd, dfe, isbg, r0, g0, b0;
    DR_ENV  dr_env;
};
#ifndef __cplusplus
typedef struct DRAWENV DRAWENV;
#endif

struct DISPENV {
    RECT   disp, screen;
    unsigned char isinter, isrgb24, pad0, pad1;
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

/* NFS4_EAC_OLD_TYPES: the older EA/PsyQ header revision seen by the FRONTEND\PSX library objects (cache.obj):
 * no CD-stream block, no wchar_t / file / thread typedefs, MEMBLOCK before VOIDFN (retail cache.obj SYM block). */
#ifndef NFS4_EAC_OLD_TYPES
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
#endif
#endif /* NFS4_PSYQ_DDV_TYPES */

/* PsyQ SYS/TYPES.H.  The SYM retains physadr's tag and referent size while
 * filtering the private `_physadr` tag block itself. */
typedef unsigned int size_t;
/* retail records the unsigned shorthands here, after size_t: SYS/TYPES.H follows the graphics headers, whose
   structs spell their fields with the plain unsigned types */
typedef unsigned char  u_char;
typedef unsigned short u_short;
typedef unsigned int   u_int;
#include "shared/u_long.h"
typedef unsigned short ushort;
/* The SDK's complete referent in every owner: retail records physadr at
 * size 4 everywhere.  Its `_physadr` tag records are not in the SYM because
 * PSYLINK drops '_'-prefixed type records (an incomplete-tag variant for
 * three frontend owners was removed 2026-11-07: it gave physadr size 0). */
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
#ifndef NFS4_PSYQ_DDV_TYPES
#ifndef NFS4_EAC_OLD_TYPES
#ifdef NFS4_PSYQ_WCHAR_TYPE
typedef NFS4_PSYQ_WCHAR_TYPE wchar_t;
#else
typedef u_char wchar_t;
#endif
#else
typedef unsigned char *MEMBLOCK;
#endif

typedef void (*VOIDFN)();
#ifndef NFS4_EAC_OLD_TYPES
typedef int FILEOP;
typedef void FILE_CALLBACK();
typedef int FILE_ATOM();
typedef void THREADPROC();
typedef void THREAD2PROC();
typedef int SYSTEMTASK();
typedef int THREAD;
#endif
#endif /* NFS4_PSYQ_DDV_TYPES */

#endif
