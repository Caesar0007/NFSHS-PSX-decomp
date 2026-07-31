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
/* NEAR-MISS 12 diffs (19/19), was 24. MATCH: the round-up-to-4 is a SIGNED DIVIDE
 * `(size+3)/4*4`, not a hand-guarded `>>2`. Oracle `addiu v0,a0,3; bgez v0,L;
 * addu v1,v0,zero; addiu v1,v0,3; L: sra v0,v1,2` IS gcc-2.8's inline signed /4 (add
 * 2^n-1 on the negative path); the old hand-written `if(newmem<0) newmem = size+6;`
 * rematerializes from the param (`addiu a1,a0,6`) instead of from newmem. SYM: REGPARM
 * size = $2(v0) => `size` is MUTATED IN PLACE here too (`size = size + 3;`), which is
 * what keeps the guard add on the newmem pseudo instead of folding to `size+6`.
 * Residual 12: (a) gcc coalesces the divide's pre-branch copy away (ours `nop` in the
 * bgez slot, oracle `addu v1,v0,zero`); (b) the return funnel picks the other value for
 * the bnez delay slot (ours v0=0, oracle v0=mem). See methodology signed-/2^n codegen. */
char *Platform_ReserveMemory(int size,char *string)

{
  int newmem;
  char *mem;

  size = size + 3;
  newmem = gCurrentMemory + (size / 4) * 4;
  mem = (char *)gCurrentMemory;
  if (newmem - gLowMemory <= (int)gTotalMemory) {
    gCurrentMemory = newmem;
    return mem;
  }
  return (char *)0x0;
}

/* ---- Platform_TempReserveMemory__FiPc  [PLATFORM.CPP:161-178] SLD-VERIFIED ---- */
/* NEAR-MISS 20 diffs (17/17) -- STRUCTURE NOW EXACT (w38-a6): the round-up-to-4 is gcc's
 * inline SIGNED /4 (`bgez x,L; addu t,x,zero; addiu t,x,3; L: sra q,t,2`), NOT a hand-guarded
 * `>>2`; and SYM says this fn has NO named locals + REGPARM size = $4(a0), i.e. the source
 * REUSES the `size` param as the running scratch (size+3 -> rounded -> +gCurrentMemory ->
 * -gLowMemory), with the failure `return 0` written FIRST (early-return) so its v0=0 lands in
 * the bnez delay slot. With that shape every insn matches 1:1 in kind+order; the residual is a
 * pure 2-register rotation (ours size->$a1/temp->$v1, oracle size->$a0/temp->$v0).
 * Tried and rejected: separate `newmem`/`mem` locals (22), separate quotient local (20),
 * inline one-expression `(size+3)/4*4` (combine folds the guard add to `size+6`),
 * opposite branch polarity (structural mismatch in the tail). Prototype re-checked vs oracle:
 * 2 args (a0=size read at insn 1, a1=string never read), returns char* in $v0. */
char *Platform_TempReserveMemory(int size,char *string)

{
  size = size + 3;
  size = gCurrentMemory + (size / 4) * 4;
  size = size - gLowMemory;
  if ((int)gTotalMemory < size) {
    return (char *)0x0;
  }
  return (char *)gCurrentMemory;
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
