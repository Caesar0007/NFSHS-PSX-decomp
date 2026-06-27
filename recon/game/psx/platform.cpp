/* game/psx/platform.cpp -- RECONSTRUCTED (NFS4 PSX platform memory + system init; C++ TU)
 *   8 fns: Platform_InitMemory (set up bump arena), Platform_ReserveMemory/TempReserveMemory
 *   (bump alloc), Platform_SysStartUp (PSX boot: heap/eaclib/display/FS/timers), nfs2eacinit
 *   (eaclib boot), Platform_DebuggerPollHost (stub), Platform_Reset/GetDCTBuffer (DCT scratch). No GTE.
 */
#include "../../nfs4_types.h"
#include "platform_externs.h"

/* D_8013DAA0 = path/directory string buffer immediately following gSysStartUp (0x8013DA9C+4).
 * Declared here so gcc emits lui+jal+addiu(delay) for setdirectory(D_8013DAA0) instead
 * of lui+addiu+jal+nop for &gSysStartUp+4. */
extern char D_8013DAA0[];

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
int gCurrentMemory;
int gHighMemory;
int gLowMemory;
int gSysStartUp;
u_int gTotalMemory;

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
char gDctBuffer[64]; char *gDctXtraMem; char gEAMemPoolBase[64]; char gPlatformInitMem[64];  /* FIXME sizes approx */


/* ---- Platform_InitMemory__Fv  [PLATFORM.CPP:125-135] SLD-VERIFIED ---- */
/* NEAR-MISS 7 diffs (11/12): oracle uses subu v0,v0,v1 + addu recovery for gHigh
 * (v0=gPlatformInitMem, v1=const). Our allocator: constant→v0, gPlatformInitMem→v1,
 * result→a0. Register allocator coloring floor (v0/v1/a0 assignment). ACCEPT best-form
 * below (7 diffs: early-stores form, closest to oracle structure). */
void Platform_InitMemory(void)

{
  u_int tempLow;

  tempLow = 0x80010080;   /* PSX prog base 0x80010000 + 0x80 EXE-header = low-mem bound; memory-map constant (no data symbol), not a VA to migrate */
  gLowMemory = tempLow;
  gCurrentMemory = tempLow;
  gTotalMemory = (int)gPlatformInitMem - tempLow;
  gHighMemory = (int)gPlatformInitMem;
  return;
}

/* ---- Platform_ReserveMemory__FiPc  [PLATFORM.CPP:139-156] SLD-VERIFIED ---- */
char *Platform_ReserveMemory(int size,char *string)

{
  int newmem;
  char *mem;

  newmem = size + 3;
  if (newmem < 0) {
    newmem = size + 6;
  }
  newmem = gCurrentMemory + (newmem >> 2) * 4;
  mem = (char *)gCurrentMemory;
  if (newmem - gLowMemory <= (int)gTotalMemory) {
    gCurrentMemory = newmem;
    return mem;
  }
  return (char *)0x0;
}

/* ---- Platform_TempReserveMemory__FiPc  [PLATFORM.CPP:161-178] SLD-VERIFIED ---- */
char *Platform_TempReserveMemory(int size,char *string)

{
  int newmem;
  char *mem;

  newmem = size + 3;
  if (newmem < 0) {
    newmem = size + 6;
  }
  mem = (char *)0x0;
  if ((gCurrentMemory + (newmem >> 2) * 4) - gLowMemory <= (int)gTotalMemory) {
    mem = (char *)gCurrentMemory;
  }
  return mem;
}

/* ---- Platform_SysStartUp__Fv  [PLATFORM.CPP:207-305] SLD-VERIFIED ---- */
void Platform_SysStartUp(void)

{
  char *endofcode;

  disablecd = 0;
  endofcode = (char *)gEAMemPoolBase;
  nfs_sysInfo.userRam = 0x801fc000 - (int)endofcode;   /* 0x801fc000 = PSX RAM top (2MB) - 16KB stack reserve; hardware constant */
  initmemadr(endofcode,nfs_sysInfo.userRam);
  nfs2eacinit();
  Draw_SetEnvironment(0x200,0xf0,1,0,1,0,0,0);
  initlinkmode(0,1,1);
  setdirectory(D_8013DAA0);
  initlinkmode(0,1000,1);
  initlinkmode(0,1000,1);
  gSysStartUp = 1;
  inittimer(0x80);
  Paths_StartUp();
  initasync(0x1e,0x2000,0);
  return;
}

/* ---- Platform_DebuggerPollHost__Fv  [PLATFORM.CPP:326-330] SLD-VERIFIED ---- */
void Platform_DebuggerPollHost(void)

{
  return;
}

/* ---- nfs2eacinit__Fv  [PLATFORM.CPP:369-408] SLD-VERIFIED ---- */
void nfs2eacinit(void)

{
  FlushCache();
  ResetCallback();
  ResetGraph(3);   /* @0x800ED670 (libgpu); was mislabeled "Eac_vars" -- delay-slot arg=3 */
  initjoy(2);
  FILE_init(10,800,0x30);
  return;
}

/* ---- Platform_ResetDCTBuffer__Fv  [PLATFORM.CPP:439-440] SLD-VERIFIED ---- */
void Platform_ResetDCTBuffer(void)

{
  gDctXtraMem = gDctBuffer;
  return;
}

/* ---- Platform_GetDCTBuffer__FiPc  [PLATFORM.CPP:444-461] SLD-VERIFIED ---- */
char * Platform_GetDCTBuffer(int size,char *string)

{
  char *p;
  
  p = gDctXtraMem;
  gDctXtraMem = gDctXtraMem + size;
  return p;
}

/* end of platform.cpp */
