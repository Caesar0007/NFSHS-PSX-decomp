/* nfs4_types.h -- the shared platform type core.  Retail's SYM records exactly these types in (nearly) every
 * object, in this order: the PsyQ graphics/geometry structs, EA's shape and CD-stream structs, then SYS/TYPES.H
 * and EA's file/thread typedefs (tools/psyq_pipe/tagset_cmp.py --core lists them).  cc1 -g records every struct a
 * translation unit defines, used or not, so ONLY the retail-universal core belongs here; game types stay in their
 * module headers (the old mega nfs4_types.h leaked hundreds of them into every object and was removed). */
#ifndef NFS4_TYPES_H
#define NFS4_TYPES_H
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
#ifdef NFS4_CORE_FEMISSION_FIRST   /* retail FEMission.obj: mission records ahead of the core */
#include "frontend/common/femission_first.h"
#endif
/* The SDK's complete referent in every owner: retail records physadr at
 * size 4 everywhere.  Its `_physadr` tag records are not in the SYM because
 * PSYLINK drops '_'-prefixed type records (an incomplete-tag variant for
 * three frontend owners was removed 2026-11-07: it gave physadr size 0). */
struct _physadr { int r[1]; };
#if defined(NFS4_CORE_SPCH_FIRST) || defined(NFS4_CORE_SND_FIRST)   /* speech.obj / audiocmn.obj first-header structs ahead of the core (shared/spchnfs_first.h) */
#include "shared/spchnfs_first.h"
#endif

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

/* Retail declaration order (round 11 TYPEONLY): a TU whose first include is the common-game graph
 * (game_common_min_types.h: NFS4_CORE_EA) or the draw-leaf graph (draw_leaf_types.h: NFS4_CORE_FULL) sees the
 * EA/PsyQ leaf types at their place in the original headers -- MATRIX before VECTOR, DR_MODE after DISPENV,
 * coorddef/matrixtdef before the CD stream, linedef/SHAPETABLEENTRY/PCOORD16/COORD16 after it.  The units are
 * include-guarded, so including them here only moves them earlier; the NFS4_HAVE_* flags keep each companion
 * typedef single. */
/* Objects whose first header is the kernel and/or controller-pad graph (retail SYM: TCB EXEC DIRENTRY and/or PAD_PSX..PAD_COMMON ahead of MATRIX/VECTOR), one macro defined by the owner's first header: NFS4_CORE_KERNEL_FIRST, NFS4_CORE_PADS_FIRST, NFS4_CORE_KERNEL_PADS_FIRST, NFS4_CORE_PADS_KERNEL_FIRST. */
#if defined(NFS4_CORE_KERNEL_FIRST) || defined(NFS4_CORE_KERNEL_PADS_FIRST)
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#endif
#if defined(NFS4_CORE_PADS_FIRST) || defined(NFS4_CORE_KERNEL_PADS_FIRST) || defined(NFS4_CORE_PADS_KERNEL_FIRST)
#include "shared/PAD_PSX.h"
#include "shared/PAD_NEGCON.h"
#include "shared/PAD_ANALOG.h"
#include "shared/PAD_MOUSE.h"
#include "shared/PAD_COMMON.h"
#endif
#ifdef NFS4_CORE_HOOK_AFTER_PADS   /* an owner's own types right after the early pads (device.obj: Input_tDeviceList) */
#include NFS4_CORE_HOOK_AFTER_PADS
#endif
#ifdef NFS4_CORE_PADS_KERNEL_FIRST
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#endif
#ifdef NFS4_CORE_FULL
#include "shared/MATRIX.h"
#endif
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
#ifdef NFS4_CORE_FULL
/* retail: the owner's libgpu.h primitives right after DISPENV, in libgpu.h order (NFS4_PRIM_* from the owner's first header) */
#ifdef NFS4_PRIM_POLY_F3
struct POLY_F3 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0,x1,y1,x2,y2;
};
#endif
#ifdef NFS4_PRIM_POLY_F4
#include "shared/POLY_F4.h"
#endif
#ifdef NFS4_PRIM_POLY_FT3
struct POLY_FT3 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    short x1,y1; u_char u1,v1; u_short tpage; short x2,y2; u_char u2,v2;
    u_short pad1;
};
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
struct POLY_GT3 {
    u_long tag;
    u_char r0, g0, b0, code; short x0, y0; u_char u0, v0; u_short clut;
    u_char r1, g1, b1, p1; short x1, y1; u_char u1, v1; u_short tpage;
    u_char r2, g2, b2, p2; short x2, y2; u_char u2, v2; u_short pad2;
};
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
struct TILE_1 { u_long tag; u_char r0,g0,b0,code; short x0,y0; };
#endif
#include "shared/DR_MODE.h"
#ifdef NFS4_CORE_HOOK_AFTER_DRMODE   /* owner types right after DR_MODE (drawdbg.obj: TCB/EXEC/DIRENTRY) */
#include NFS4_CORE_HOOK_AFTER_DRMODE
#endif
#ifdef NFS4_PRIM_DR_TWIN
struct DR_TWIN { u_long tag, code[2]; };
#endif
#ifdef NFS4_PRIM_DR_STP
struct DR_STP { u_long tag; u_long code[2]; };
#endif
#ifdef NFS4_PRIM_DR_AREA
#include "shared/DR_AREA.h"
#endif
#ifdef NFS4_PRIM_DR_OFFSET
#include "shared/DR_OFFSET.h"
#endif
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
#ifdef NFS4_CORE_EA
#include "shared/coorddef.h"
typedef struct coorddef LIBCOORD;
#define NFS4_HAVE_LIBCOORD
#if defined(NFS4_CORE_FULL) || defined(NFS4_CORE_MATRIXT)   /* NFS4_CORE_MATRIXT: retail MathNfs/quatern: matrixtdef right after coorddef */
#include "shared/matrixtdef.h"
typedef struct matrixtdef MATRIX3DT;
#define NFS4_HAVE_MATRIX3DT
#endif
#endif

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
    void *emptyblock, *head, *tail, *block;  int  timer, blocktime, streamfull, getable, releaseable;
};
typedef struct cdstreamstruct CDSTREAM;
#endif
#ifdef NFS4_CORE_HOOK_AFTER_CD   /* a TU's own types right after the CD stream (audiotrk.obj: SND* + scheduler) */
#include NFS4_CORE_HOOK_AFTER_CD
#endif
#ifdef NFS4_CORE_EA   /* nfs2mem: kernpair right after the CD stream; movie: the kernel types, then kernpair, there. */
#ifdef NFS4_CORE_KERNEL_KERN_AFTER_CD
#include "frontend/psx/movie_cd_early.h"   /* movie.obj (the only owner of this key): CdlLOC/CdlFILE first */
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#endif
#if defined(NFS4_CORE_KERN_AFTER_CD) || defined(NFS4_CORE_KERNEL_KERN_AFTER_CD)
#include "shared/kernpair.h"
#endif
#ifdef NFS4_CORE_PADS_EARLY
/* frontend family (fecars felines fefades fecolor femission fetracks fecheats fememcard femenudefs femenuextended femenuoptions screenpinkslips screentracks): retail emits the controller pads after the CD stream, before linedef. */
#include "shared/PAD_PSX.h"
#include "shared/PAD_NEGCON.h"
#include "shared/PAD_ANALOG.h"
#include "shared/PAD_MOUSE.h"
#include "shared/PAD_COMMON.h"
#endif
#include "shared/linedef.h"
typedef struct linedef LINE;
#define NFS4_HAVE_LINE
#include "shared/SHAPETABLEENTRY.h"
#ifdef NFS4_CORE_AFTER_SHAPETABLE   /* retail PSXFront: eacelement CdlLOC kernpair charactertbl */
#include "shared/core_after_shapetable.h"
#endif
#if defined(NFS4_CORE_FULL) && !defined(NFS4_DRAW_LEAF_CORE_ONLY)   /* CORE_ONLY: draw_leaf_types.h phase 2 emits these */
#include "shared/PCOORD16.h"
#include "shared/COORD16.h"
#ifdef NFS4_CORE_CCOORD16
#include "shared/CCOORD16.h"
#endif
#endif
#endif
#endif /* NFS4_PSYQ_DDV_TYPES */

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
