/* platform_externs.h -- externs for game/psx/platform.cpp (NFS4 PSX platform memory + system init) */
#ifndef _GAME_PSX_PLATFORM_EXTERNS_H_
#define _GAME_PSX_PLATFORM_EXTERNS_H_

#include "../../nfs4_types.h"
#include "../../lib/libfns.h"

/* ---- module globals (simple bump-allocator arena + DCT scratch) ---- */
extern u_int           gTotalMemory;    /* 0x8013dabc  arena size */
extern int             gLowMemory;      /* 0x8013dab0  arena low/base addr */
extern int             gHighMemory;     /* 0x8013dab4  arena high addr */
extern int             gCurrentMemory;  /* 0x8013dab8  bump cursor */
extern int             gSysStartUp;     /* 0x8013da9c  init flag (+4 = cwd path buf) */
extern char           *gDctXtraMem;     /* 0x8013daac  DCT scratch bump cursor */
extern int             disablecd;       /* 0x8013dc58 */
extern tNfsSystemInfo  nfs_sysInfo;     /* 0x8013d2b4 */

/* ---- link-time markers / scratch buffers (no SYM name; raw addresses) ---- */
extern char gPlatformInitMem[];   /* 0x80054d10  end-of-init-memory marker (arena high) */
extern char gEAMemPoolBase[];     /* 0x80148b0c  arena base = end of code/data */
extern char gDctBuffer[];         /* 0x80124038  DCT scratch buffer base */

/* ---- eaclib / syslib / sibling helpers ---- */
extern "C" int ResetGraph(int mode);   /* @0x800ED670 libgpu (real target of the old "Eac_vars") */
extern void  Draw_SetEnvironment(int w, int h, int a, int b, int c, int d, int e, int f);
extern void  Paths_StartUp(void);

/* ---- this module ---- */
extern void  nfs2eacinit(void);

#endif
