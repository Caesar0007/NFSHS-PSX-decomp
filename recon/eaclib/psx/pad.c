/* eaclib/psx/pad.c  -- RECONSTRUCTED  (SLD source D:\nfs4\EACLIB\PSX\PAD.C)
 *   C TU: SLD-proven .C -> CC1PSX lane (methodology 3.25; migrated from pad.cpp, task #90).
 *   Self-contained per C-lane convention (local types; unmangled C symbols match the SYM).
 *   Bodies      : Ghidra decompiler (nfs4-f.exe MIPS code).
 *   Line numbers: PsyQ SLD per-instruction stream (the 8c 'Function start line' is unreliable
 *                 for PAD_convert/PAD_update by +21/+22; SLD is authoritative).
 *   Signatures  : SYM-faithful.  padinit/PAD_restore = void (SYM FCN VOID; the prior 'int'
 *                 was a decompiler $v0-liveness artifact - SYM records 0 locals for both).
 *                 PAD_convert = class STAT -> file-local static (not exported).
 *   pad.c = EXACTLY 5 functions filling 0x800E40E8-0x800E4318. Inter-fn line gaps are
 *   static data / macros / comments, NOT hidden functions. Original EA source is not public.
 *   LOCAL NAMES: only PAD_update's 'i' is SYM-authentic (REG $t0 loop index); all other local
 *   names across all 5 fns are SEMANTIC reconstructions (debug info preserved no other locals).
 */

typedef unsigned char  u_char;
typedef unsigned char  byte;
typedef unsigned short u_short;
typedef unsigned int   uint;

/* ---- local mirrors of the shared pad types (nfs4_types.h is C++-only) ---- */
typedef struct PAD_PSX {              /* 6 bytes */
    u_short state;                    /* +0x0 */
    u_short unused[2];                /* +0x2 */
} PAD_PSX;

typedef union tPadVariantData {       /* 6 bytes (only .standard read in this TU) */
    PAD_PSX standard;
} tPadVariantData;

typedef struct PAD_COMMON {           /* 8 bytes */
    u_char          nopad, ID;        /* +0x0 */
    tPadVariantData data;             /* +0x2 */
} PAD_COMMON;

typedef struct tActiveTime {          /* 2 bytes */
    u_char bActive, time;             /* +0x0 */
} tActiveTime;

typedef struct tPadModuleState {      /* 84 bytes */
    int         initialized;          /* +0x0 */
    PAD_COMMON  buf[8];               /* +0x4 */
    tActiveTime state[8];             /* +0x44 */
} tPadModuleState;

/* ---- pad.obj data globals (eaclib/psx, from canonical Globals) ---- */
extern PAD_COMMON      Padglobal[2];  /* 0x8013e8f0  per-port pad buffers   */
extern tPadModuleState gPadinfo;      /* 0x8013e89c  module state (84 B)    */

/* ---- PsyQ libpad (direct mode) ---- */
extern void PadInitDirect(unsigned char *pad1, unsigned char *pad2);
extern void PadStartCom(void);
extern void PadStopCom(void);

/* ---- eaclib (EACPSXZ) ---- */
extern void blockclear(void *dst, int size);
extern void blockmove(void *src, void *dst, int size);
extern void blockfill(void *dst, int size, int val);
extern int  addtimer(void (*proc)(void));
extern int  deltimer(void (*proc)(void));

/* PAD_convert is SYM class STAT (file-local static); forward-declared for PAD_state. */
static u_short PAD_convert(PAD_COMMON *pad);
void PAD_update(void);

/* lines 1-65: file header, #includes, static data, macros (no symbols emitted) */

/* ---- padinit  (PAD.C:66, code lines 66-79) ---- */
/* RESIDUAL 3 diffs (was 23; w33-a10): body is instruction-for-instruction
 * identical to the oracle once PAD.OBJ's -mno-split-addresses lane is used
 * (see PAD_restore). The 3 that remain are ONLY the epilogue-fill identity
 * -- ours `jr ra; addiu sp,sp,24`, retail `addiu sp; jr ra; nop`. The
 * -fno-delayed-branch splice that PASSes PAD_restore costs 6 more here
 * (3 -> 9: it also empties the four `jal` argument-setup slots that retail
 * DID have filled), so padinit belongs to the Tier-2 ASPSX-fill bin. */
void padinit(void)
{
  if (gPadinfo.initialized == 0) {
    PadInitDirect(&Padglobal[0].nopad, &Padglobal[1].nopad);
    PadStartCom();
    blockclear(&gPadinfo, 0x54);
    gPadinfo.initialized = 1;
    addtimer(PAD_update);
  }
}

/* lines 80-82: (static data / macros / comments - no emitted code) */

/* ---- PAD_restore  (PAD.C:83, code lines 83-89) ---- */
void PAD_restore(void)
{
  /* MATCHED (w33-a10). Two per-obj toolchain-identity facts, both now
   * reproduced by the build rather than documented as floors:
   *   1. PAD.OBJ was compiled -mno-split-addresses (PER_TU_FLAGS in
   *      tools/build.py) -- that is where the unfused `la $s0,gPadinfo`
   *      (lui %hi + addiu %lo into a callee-saved reg, then plain 0($s0)
   *      accesses across the calls) comes from. It is a COMPILER address-
   *      lowering mode, NOT a source shape: no `T *p = &g;` local can
   *      produce it, which is why every prior wave's lever-#16 attempt
   *      failed here.
   *   2. The last 3 diffs were the canonical Tier-1 epilogue-fill signature
   *      (ours `jr ra; addiu sp` vs the oracle's `addiu sp; jr ra; nop`),
   *      cleared by the per-FUNCTION -fno-delayed-branch splice
   *      (PER_FN_NO_DELAYED_BRANCH). The same flag is a NET LOSS on this
   *      TU's other four functions -- per-function granularity is load-
   *      bearing. */
  if (gPadinfo.initialized != 0) {
    deltimer(PAD_update);
    PadStopCom();
    gPadinfo.initialized = 0;
  }
}

/* lines 90-171: (static data / macros / comments - no emitted code) */

/* ---- PAD_state  (PAD.C:172, code lines 172-186) ---- */
/* RESIDUAL 4 diffs, insn parity 20/20 (w33-a10; was 21 diffs).
 * FIXED HERE: (a) the address form -- PAD.OBJ is -mno-split-addresses, so
 * the oracle's unfused `la $v1,gPadinfo` is a build-lane fact (see
 * PAD_restore); (b) the branch polarity -- retail's TWO beqz's to ONE label
 * is the natural lowering of the POSITIVE test `if (init && padID < 8)
 * { convert } else { 0 }`, not of the negated `|| ... { 0 } else ...` form
 * this reconstruction used to carry. The 4 that remain are purely the
 * epilogue-fill identity (`addiu sp; jr ra; nop` vs our `jr ra; addiu sp`);
 * unlike PAD_restore the -fno-delayed-branch splice does NOT clear them
 * here (it costs 4 more elsewhere in the body: 4 -> 8), so this one waits
 * on the Tier-2 ASPSX-fill emulation. */
u_short PAD_state(int padID)
{
  uint buttons;

  if (gPadinfo.initialized != 0 && (uint)padID < 8) {
    buttons = PAD_convert(gPadinfo.buf + padID);
    buttons = buttons & 0xffff;
  }
  else {
    buttons = 0;
  }
  return buttons;
}

/* lines 187-277: (static data / macros / comments - no emitted code) */

/* ---- PAD_convert  (PAD.C:278, code lines 278-278)  [static] ---- */
static u_short PAD_convert(PAD_COMMON *pad)
{
  return ~(uint)(pad->data).standard.state & 0xffff;
}

/* lines 279-319: (static data / macros / comments - no emitted code) */

/* ---- PAD_update  (PAD.C:320, code lines 320-375) ---- */
/* locals provenance: 'i' = SYM-authentic (REG $t0 loop index; note OUR build
   still colors it $s0 -- see residual 3 below); all other local names are
   SEMANTIC reconstructions (debug info preserved no other locals).

   SHAPE IS NOW SLD-PROVEN (w33-a10). D:
fs4\EACLIB\PSX\PAD.C is the ONLY
   eaclib TU with SLD line records in nfs4-f-v3.txt, and its address->line map
   for 0x800E4210-0x800E4314 settles three things this reconstruction had
   guessed wrong:
     * L347/L350 vs L353/L354: blockfill is called ONCE PER ARM of the if
       (gcc cross-jumps the two `jal blockfill; addiu a2,0xFF` tails into the
       fall-through block), NOT once after the if with fillDst/fillLen
       variables. The old two-variable form could never produce the oracle's
       arm-local $a0/$a1 setup.
     * L365 / L366 / L368 / L370 / L371 = five separate statement lines, i.e.
       a NAMED `active` local on its own line followed by NESTED ifs -- not
       the `&&` + comma-expression one-liner this file used to carry.
     * L363 owns both the loop init and the increment block => a `for`.

   RESIDUAL 30 diffs at exact insn parity 66/66 (was 78), three items:
     1. loop 1 counter: gcc keeps `i` as the biv and recomputes `sll v1,i,3`
        each iteration; retail eliminated `i` and made the *8 giv the loop
        variable (`addiu $s0,$s0,8` / `slti $v0,$s0,0x10`). Writing the loop
        over a byte offset DOES produce retail's giv, but then gcc hoists
        `&Padglobal` into a 4th callee-saved reg instead of rematerializing
        it in the else-arm (38 diffs, frame -40) -- the two halves are
        mutually exclusive under this cc1. Best of the three spellings kept.
     2. loop 2 `i` lands in $s0 (reused from loop 1) where retail used $t0.
        Splitting the two loops' counters into separate named variables makes
        it WORSE (30 -> 36).
     3. the epilogue-fill identity (`addiu sp; jr ra; nop`), same as padinit /
        PAD_state; the -fno-delayed-branch splice costs 10 more here. */
void PAD_update(void)
{
  int i;
  int btnOff;
  int active;
  uint debCount;

  for (i = 0; i < 2; i++) {
    if (Padglobal[i].nopad != 0) {
      blockfill(&gPadinfo.buf[i * 4], 0x20, 0xff);
    }
    else {
      blockmove(&Padglobal[i], &gPadinfo.buf[i * 4], 8);
      blockfill(&gPadinfo.buf[i * 4 + 1], 0x18, 0xff);
    }
  }
  btnOff = 0;
  for (i = 0; i < 8; i++) {
    active = (((byte *)gPadinfo.buf)[btnOff] == 0);
    if (active != gPadinfo.state[i].bActive) {
      debCount = gPadinfo.state[i].time;
      gPadinfo.state[i].time = debCount + 1;
      if (debCount > 5) {
        gPadinfo.state[i].bActive = active;
        gPadinfo.state[i].time = 0;
      }
    }
    btnOff += 8;
  }
}

/* end of pad.c (~line 375 per SLD) */
