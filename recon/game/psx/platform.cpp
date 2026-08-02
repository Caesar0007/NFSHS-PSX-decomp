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
/* NEAR-MISS 6 diffs (19/19), was 12 (w39-a4).  Structure now 1:1 with the oracle:
 *   - round-up-to-4 is gcc-2.8's inline SIGNED /4 (`addiu v0,a0,3; bgez v0,L;
 *     addu v1,v0,zero; addiu v1,v0,3; L: sra v0,v1,2`), on the IN-PLACE-mutated `size`
 *     (SYM REGPARM size = $2 = $v0, so `size = size + 3;` is the source form);
 *   - BRANCH POLARITY: the FAILURE arm is the early return (`if (gTotal < newmem-gLow)
 *     return 0;`), which makes the success path the fall-through, puts `addu v0,a1,zero`
 *     (mem) in the `bnez` delay slot and leaves the two `jr ra` tails UNMERGED, exactly
 *     as the oracle @0x800DC318-0x800DC330.  The old `if (... <= gTotal) {success}` form
 *     put v0=0 in the slot (that was the documented 12-diff residual (b)).
 * w45-a3: PASS 19/19 (was 6).  THE LAST LEVER = keep the ROUNDED value in `size` as its
 * own statement (`size = size + 3; size = (size / 4) * 4;`) instead of consuming the divide
 * inline in the `newmem` expression.  MECHANISM: expand_divmod's sdiv-by-power-of-2 always
 * emits `t1 = op0; if (op0 >= 0) goto L; t1 = t1 + 3; L: q = t1 >> 2`.  When the divide is
 * consumed inline, op0 is a dead anonymous temp, local-alloc's combine_regs coalesces t1
 * onto it and the `t1 = op0` copy VANISHES -- leaving the bgez delay slot empty (our `nop`).
 * Assigning the quotient back into the `size` VARIABLE keeps op0's pseudo live across the
 * guard, the two qtys conflict, combine_regs declines, and the copy survives as retail's
 * `addu v1,v0,zero` in the bgez delay slot ($v1 = the distinct t1).
 * NOTE this is the EXACT INVERSE of the sibling Platform_TempReserveMemory lever above --
 * there the arithmetic must stay ANONYMOUS, here it must stay in the VARIABLE.  The
 * discriminator is which pseudo retail keeps live, read straight off the delay slot:
 * empty bgez slot = ours coalesced = give the value a variable home.
 * Measured this session: rounded-into-size 0, base 6, bias-inline 6, named `n` 6, separate
 * `rounded` local 6, mem-before-newmem 8, mem-drives-newmem 8, `>>2` instead of `/4` 11 (-3 insns,
 * drops the guard). */
char *Platform_ReserveMemory(int size,char *string)

{
  int newmem;
  char *mem;

  size = size + 3;
  size = (size / 4) * 4;
  newmem = gCurrentMemory + size;
  mem = (char *)gCurrentMemory;
  if ((int)gTotalMemory < newmem - gLowMemory) {
    return (char *)0x0;
  }
  gCurrentMemory = newmem;
  return mem;
}

/* ---- Platform_TempReserveMemory__FiPc  [PLATFORM.CPP:161-178] SLD-VERIFIED ---- */
/* w45-a3: PASS 17/17 (was 7 diffs / 18 insns).  THE LEVER = the address arithmetic
 * INLINE IN THE `if` CONDITION as an ANONYMOUS temp -- NOT assigned back into `size`.
 * SYM has NO named locals here, so the anonymous form is also the faithful one.
 * MECHANISM (gcc-2.8 local-alloc.c/global.c, read this session): assigning the sum back
 * into `size` keeps ONE pseudo for the variable that spans the div-guard branch -> a
 * GLOBAL allocno; global_alloc's pass 0 only reuses registers already in `regs_used_so_far`
 * (`IOR_COMPL_HARD_REG_SET (used, regs_used_so_far)` -- "we never allocate a register for
 * the first time in pass 0"), so the block-local gLowMemory qty had already taken $a0 from
 * local_alloc and `size` was pushed off its REGPARM home, rotating the whole function.
 * Written inline, the sum is a fresh block-local temp, `size` keeps $a0, and cur/low/tot
 * land in $a2/$a1/$v1 exactly as retail.  OPERAND ORDER is load-bearing: `gCurrentMemory +
 * size` = PASS, `size + gCurrentMemory` = 2 diffs (addu operand order only).
 * Measured this session: inline-if curfirst 0, inline-if addfirst 2, `int cur;` + inline-if 0,
 * low-read-at-top (makes low global too) 8 count-exact, add-first split 18, sub-first split 10,
 * separate `newmem` local 22, fully-inlined incl. the +3 22, param-untouched `int n` 18.
 * Prototype re-checked vs the raw oracle: 2 args ($a0 size read at insn 1, $a1 string never
 * read), returns char* in $v0. */
char *Platform_TempReserveMemory(int size,char *string)

{
  size = size + 3;
  size = (size / 4) * 4;
  if ((int)gTotalMemory < (gCurrentMemory + size) - gLowMemory) {
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
