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
 * Residual 6 = the divide guard: gcc rematerializes `size+6` from $a0 and DUPLICATES the
 * `sra` into both arms, where the oracle keeps a copy `addu v1,v0,zero` on the positive
 * path plus ONE shared `sra`.  Tried: separate quotient local (8), extra `q = size` copy
 * (6, same shape), hand-written guard `if (size<0)` (22, folds wrong).  $a0 stays live so
 * combine can always refold (size+3)+3 -> a0+6; no source form found that kills it. */
char *Platform_ReserveMemory(int size,char *string)

{
  int newmem;
  char *mem;

  size = size + 3;
  newmem = gCurrentMemory + (size / 4) * 4;
  mem = (char *)gCurrentMemory;
  if ((int)gTotalMemory < newmem - gLowMemory) {
    return (char *)0x0;
  }
  gCurrentMemory = newmem;
  return mem;
}

/* ---- Platform_TempReserveMemory__FiPc  [PLATFORM.CPP:161-178] SLD-VERIFIED ---- */
/* NEAR-MISS 7 diffs (18 ours / 17 oracle), was 20 (w39-a4).  SYM: NO named locals,
 * REGPARM size = $4 ($a0) -- the source reuses the `size` param as the running scratch.
 * Two levers landed here:
 *   (1) the `*4` multiply-back is its OWN statement (`size = (size / 4) * 4;`), which is
 *       what puts the rounded value back into size's own register (oracle `sll $a0,$v0,2`);
 *   (2) the address arithmetic is ONE expression `(size + gCurrentMemory) - gLowMemory`.
 *       Split into two statements gcc rotates the whole function one register over
 *       (size->$a1, gLowMemory->$a0 -- 18 diffs, insn-exact); as one expression the
 *       prologue/divide/compare/tail are all byte-identical.
 * Residual 7 = ONE scheduling slot: the oracle issues `lw $a1,%gp_rel(gLowMemory)` right
 * after the gCurrentMemory load (filling its load-delay) and then does the in-place
 * `addu $a0,$a2,$a0; subu $a0,$a0,$a1`; ours emits `nop` + `addu $a1,$a0,$a2` into a fresh
 * reg + a later gLowMemory load.  Tried (all worse or neutral): the two-statement split
 * (18), `size + gCurrentMemory` order (18), `gCurrentMemory - gLowMemory + size` (18),
 * `size - gLowMemory + gCurrentMemory` (18), `size + (gCurrentMemory - gLowMemory)` (18),
 * subtract folded into the compare (20), multiply-back fused with the add (20/22).
 * w42-a4 -- a STRICTLY BETTER STRUCTURAL BASE exists, banked but NOT adopted (it gates
 * 10 vs the current 7, and the gate is the wave metric): writing the two statements
 * SUB-FIRST -- `size = size - gLowMemory; size = size + gCurrentMemory;` (or the
 * compound `size -= gLowMemory; size += gCurrentMemory;`, identical) -- is count-EXACT
 * 17/17 AND keeps `size` in its REGPARM home $a0 for the whole function, so the entire
 * prologue/divide/round/compare/tail is byte-identical and the residual is ONLY the
 * batching of the three gp-rel loads (retail issues all three, then `addu a0,a2,a0;
 * subu a0,a0,a1`; ours interleaves `subu` between them and reuses $v1 for gLowMemory).
 * The ADD-first split (the semantic order retail used) is the one that rotates $a0<->$a1
 * (18 diffs) -- i.e. STATEMENT ORDER, not operand order, is what holds the param home
 * here.  Measured: sub-first split 10, sub-first compound 10, add-first split 18,
 * add-first compound 18, `gCurrentMemory - gLowMemory + size` 18, one-expression
 * sub-first `(size - gLowMemory) + gCurrentMemory` 18, one-expression add-first 7 (current).
 * NEXT IDEA: from the 10-diff base, get the three gp loads to batch (a load-scheduling
 * lever), not another algebraic spelling -- the register allocation is already retail's.
 * Prototype re-checked vs the raw oracle: 2 args ($a0 size read at insn 1, $a1 string never
 * read), returns char* in $v0. */
char *Platform_TempReserveMemory(int size,char *string)

{
  size = size + 3;
  size = (size / 4) * 4;
  size = (size + gCurrentMemory) - gLowMemory;
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
