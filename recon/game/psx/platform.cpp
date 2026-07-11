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
/* SEALED (12/12 PASS): oracle's subu-then-addu = an IN-PLACE mutate of the compiler temp
 * holding gPlatformInitMem (m -= tempLow -> sw gTotal; m += tempLow -> gHigh recovery).
 * MATCH: in-place +=/-= two-step (SS 3.12 #14 family) -- the single-expression forms let cse
 * reuse the still-live address pseudo and drop the addu. */
void Platform_InitMemory(void)

{
  u_int tempLow;

  u_int m;

  tempLow = 0x80010080;   /* PSX prog base 0x80010000 + 0x80 EXE-header = low-mem bound; memory-map constant (no data symbol), not a VA to migrate */
  m = (u_int)gPlatformInitMem;
  m -= tempLow;
  gTotalMemory = m;
  m += tempLow;
  gLowMemory = tempLow;
  gHighMemory = m;
  gCurrentMemory = tempLow;
  return;
}

/* ---- Platform_ReserveMemory__FiPc  [PLATFORM.CPP:139-156] SLD-VERIFIED ---- */
/* NEAR-MISS 24 diffs (19/19): same round-up-to-4 v0/v1-vs-a1 allocator floor as the
 * Platform_TempReserveMemory note above (the compiler back-substitutes `newmem+3` to
 * `size+6` regardless of source form -- confirmed by testing both). Accepted near-miss. */
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
/* NEAR-MISS 20 diffs (17/17, improved from 22 via direct-return): the round-up-to-4 divide
 * (`newmem = (size+3); if(newmem<0) newmem = size+6; then >>2<<2`) oracle keeps LIVE IN a0
 * (self-mutates the dead param register throughout, incl. reusing it later for the
 * candidate-address subtraction: `sll a0,v0,2; addu a0,a2,a0; subu a0,a0,a1`); ours always
 * allocates a fresh v0/v1 pseudo instead of reusing a0. Tried: mutating `size` in place,
 * mutating `newmem` in place, direct-return vs cached-`mem`-var, both branch polarities --
 * all land on the same v0/v1-vs-a0 tie-break (genuine allocator coloring floor, same family
 * as the Night_SetWeatherColors v0-vs-dest note). Accepted near-miss. */
char *Platform_TempReserveMemory(int size,char *string)

{
  int newmem;

  newmem = size + 3;
  if (newmem < 0) {
    newmem = size + 6;
  }
  if ((gCurrentMemory + (newmem >> 2) * 4) - gLowMemory <= (int)gTotalMemory) {
    return (char *)gCurrentMemory;
  }
  return (char *)0x0;
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
