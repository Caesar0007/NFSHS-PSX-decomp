/* platform_externs.h -- externs for game/psx/platform.cpp (NFS4 PSX platform memory + system init) */
#ifndef _GAME_PSX_PLATFORM_EXTERNS_H_
#define _GAME_PSX_PLATFORM_EXTERNS_H_

/* ---- module globals (simple bump-allocator arena + DCT scratch) ---- */
extern u_int           gTotalMemory;    /* 0x8013dabc  arena size */
extern int             gLowMemory;      /* 0x8013dab0  arena low/base addr */
extern int             gHighMemory;     /* 0x8013dab4  arena high addr */
extern int             gCurrentMemory;  /* 0x8013dab8  bump cursor */
extern int             gSysStartUp;     /* 0x8013da9c  init flag (+4 = cwd path buf) */
// [owned->file-static in platform.cpp] char *gDctXtraMem; /* 0x8013daac */
extern int             disablecd;       /* 0x8013dc58 */
/* tNfsSystemInfo is completed only in nfs3.obj; platform.obj's SYM does not
 * expose that tag.  Group is a retail-visible one-word aggregate whose field
 * preserves the aggregate MEM form required by this sole word-0 access. */
extern Group Platform_nfsSysInfoCarrier asm("nfs_sysInfo"); /* 0x8013d2b4 */
#define Platform_nfsUserRam (Platform_nfsSysInfoCarrier.m_num_elements)

/* ---- link-time markers / scratch buffers ----
 * CF_DVLC is canonical PsyQ/SYM/MAP data.  The other two retail addresses have
 * no recoverable source identifier; raw labels preserve that evidence boundary
 * without fabricating C storage. */
extern char  D_80054D10[];        /* end-of-init-memory marker */
extern char  D_80148B0C[];        /* heap base, eight bytes past MAP endofcode */
extern u_int CF_DVLC[];            /* canonical PsyQ DCT/VLC work table */

/* ---- eaclib / syslib / sibling helpers ---- */
extern "C" int ResetGraph(int mode);   /* @0x800ED670 libgpu (real target of the old "Eac_vars") */
extern void  Draw_SetEnvironment(int w, int h, int edraw, int edisplay, int erase, int r, int g, int b);
extern void  Paths_StartUp(void);

/* ---- this module ---- */
extern void  nfs2eacinit(void);

extern "C" void ResetCallback(...);
extern "C" void FlushCache(...);
extern "C" void FILE_init(...);
extern "C" void initasync(...);
extern "C" void initjoy(...);
extern "C" void initlinkmode(...);
extern "C" void initmemadr(...);
extern "C" void inittimer(...);
extern "C" void setdirectory(...);

#endif
