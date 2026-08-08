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
 * DID have filled), so padinit belongs to the Tier-2 ASPSX-fill bin.
 * w34-a10 RE-VERDICT: FLOOR HOLDS, evidence class STRONG. Prototype re-audit
 * against the SYM (the w33/w34 "floors are prototype-conditional" rule):
 * `94 Def class EXT type FCN VOID size 0 name padinit` + an `8c Function
 * start` block with fsize=24, mask=$80010000 (ra+s0), maskoffs=-4 and NO
 * locals and NO REGPARM records -- so the `void padinit(void)` signature,
 * the return type and the arity are all confirmed correct, and the 3
 * residual diffs are exclusively the epilogue delay-slot fill.
 * w49-a9 CLASSIFIED (re-gated 3, ours 27 / oracle 28): this one IS the pure w48
 * EPILOGUE-SWAP class -- retail's return slot is EMPTY (`lw ra; lw s0; addiu sp;
 * jr ra; nop`) and ours steals `addiu sp` into it (`lw ra; lw s0; jr ra; addiu
 * sp`); un-filling the return slot adds exactly the missing 28th insn and fixes
 * all three diffs.  The mechanism is build.py's PER_FN_EPILOGUE_UNFILL table
 * (per-fn, textual, still 100% real cc1 output) -- NOT the -fno-delayed-branch
 * splice, which this TU's note above already measures as a net loss here.
 * This worker was barred from editing build.py; wiring `padinit` (and
 * PAD_update) into PER_FN_EPILOGUE_UNFILL is the outstanding action. */
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
 * on the Tier-2 ASPSX-fill emulation.
 * w34-a10 RE-VERDICT: FLOOR HOLDS, evidence class STRONG. SYM prototype
 * re-audit: `94 Def class EXT type FCN USHORT size 0 name PAD_state` with a
 * single `94 Def class REGPARM type INT size 0 name padID` ($00000004 = the
 * $a0 home) and fsize=24 / mask=$80000000 (ra only) / maskoffs=-8 -- the
 * u_short return, the one int parameter and the leaf frame all match what
 * this reconstruction emits, so nothing about the declaration is left to
 * reopen; the 4 diffs are purely `addiu sp; jr ra; nop` vs `jr ra; addiu sp`.
 * w49-a9 CLASS CORRECTION (re-gated 4, 20/20): this is NOT the w48
 * PER_FN_EPILOGUE_UNFILL class -- un-filling our return slot would emit
 * `lw ra; nop; addiu sp; jr ra; nop` = 21 insns, one MORE than the oracle's 20.
 * Retail has NO load-delay nop after `lw ra` because its `addiu sp` covers the
 * hazard; that is the `#nop` PLACEHOLDER class (see spchinit.c SPCH_Init's note):
 * mips.c emits the epilogue as TEXT after `.set reorder` with a `#nop` comment,
 * maspsx resolves it by INSERTING a nop, a reorder-mode assembler resolves it by
 * SCHEDULING the sp-adjust into the gap.  ⚠ that note's "ASPSX 2.77 schedules it"
 * attribution is FALSIFIED by w47-a6/w48-a10's real-ASPSX differential (real
 * ASPSX does NO delay-slot filling at all, any version); per w48-04K the shape
 * IS reproduced by GNU as in `.set reorder` mode, so the owner is the pending
 * maspsx "stop injecting .set noreorder" option, not ASPSX and not any source form. */
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

   SYM ground truth (w34-a10, the record this fn had never been read against):
   the `8c Function start` block for PAD_update carries fsize=32, mask=$80070000
   (ra+s0+s1+s2) and EXACTLY ONE `90 Block start` containing EXACTLY ONE local --
   `$00000008 94 Def class REG type INT size 0 name i` = an int in REGISTER 8 =
   $t0.  Two consequences, both applied below:
     * $t0 is LOOP 2's counter, so retail's `i` is live ONLY across loop 2.
       Loop 1's counter has NO SYM record at all => retail's loop.c ELIMINATED
       it (all three of loop 1's address values became givs: $s0 = the *8
       Padglobal byte offset, $s1/$s2 = the gPadinfo.buf walkers, and the exit
       test was rewritten onto $s0 as `slti $v0,$s0,0x10`).  Our cc1 refuses
       that biv elimination from the index spelling `Padglobal[i]`, so loop 1
       is written HERE over the byte offset retail's giv holds -- that is a
       compiler-behaviour compensation, not a different algorithm.
     * `active` / `debCount` / `btnOff` are NOT retail locals (only `i` is).
       They survive here as expression temps only; `btnOff` in particular has
       to stay an explicit source variable because combine_givs otherwise
       merges the stride-8 buf giv into the stride-2 gPadinfo.state walkers
       (catalog: "explicit pointer walkers are the only faithful shape there")
       -- `((byte *)gPadinfo.buf)[i * 8]` gives 20 diffs / 64 insns.

   30 -> 9 diffs (w34-a10), two levers:
     1. LOOP 1 OVER THE BYTE OFFSET (`for (off = 0; off < 16; off += 8)`, all
        three addresses derived from `off`): reproduces retail's eliminated-biv
        loop EXACTLY -- the whole loop-1 body is now byte-identical.  The
        earlier wave's note that this costs a 4th callee-saved reg was a
        property of ITS spelling (it kept `&Padglobal[i]`-style typed indexing
        alongside); deriving BOTH Padglobal references from `off` with a plain
        `(char *)` base keeps &Padglobal rematerialized in the else arm.
     2. LOOP 2's `i` AND `btnOff` IN ONE `for` HEADER
        (`for (i = 0, btnOff = 0; i < 8; i++, btnOff += 8)`): SLD line 363 owns
        both inits AND the whole increment block, which is exactly what a comma
        `for` header emits.  This alone is worth 10 diffs -- it fixes the
        increment ORDER (a0, a2, i, test, btnOff-in-the-delay-slot) and gives
        `i` $t0 / `btnOff` $a3 as the SYM demands.  With `btnOff += 8` as the
        last BODY statement instead, the increments come out btnOff, a0, i,
        test, a2 and the two registers swap (19 diffs).

   RESIDUAL 9 diffs, ours 65 / oracle 66, three items -- all downstream of the
   one biv elimination our loop.c will not do:
     1. (4) prologue emission ORDER: retail's `sw $s0/addu $s0,$zero,$zero`
        pair sits AFTER the $s2 and $s1 pairs because ALL THREE are loop.c
        givs, emitted in reverse creation order ($s2,$s1,$s0); ours is a real
        source biv whose init has the lowest luid, so it is emitted first.
     2. (2) `addu $a3,$t0,$zero` vs retail `addu $a3,$zero,$zero`: cse reuses
        `i`'s just-materialized 0 for `btnOff`'s.  Retail's two zeros are
        independent because retail's `btnOff` is a GIV whose preheader init is
        emitted after the $a0/$a2 giv inits, with no live 0 to reuse.
     3. (3) the epilogue-fill identity (`addiu sp; jr ra; nop`), same class as
        padinit / PAD_state; the -fno-delayed-branch splice costs 10 more.
   w49-a9 re-gate 9 (65/66) confirmed; three more source forms falsified for
   items 1+2 (the biv-elimination lead), each measured:
     - loop 1 as `for (i = 0; i < 2; i++)` with i*8 / i*32 / i*32+8 offsets (to
       hand loop.c a biv it WOULD eliminate): 46 diffs, frame 40 -- `i` stays a
       real biv in $s2 and buys a 4th callee-saved reg;
     - explicit source walkers `pb`/`pb8` initialised before the `for` (to force
       the two giv inits ahead of the counter init): 30 diffs at frame 40 with
       pb8 declared first, 32 with pb first -- the walkers become their own
       saved regs instead of loop.c givs;
     - both loop rewrites together: 57.
   Item 3 is the w48 EPILOGUE-SWAP class in its pure form (retail's return slot
   is EMPTY, ours steals `addiu sp`) => the mechanism is build.py's
   PER_FN_EPILOGUE_UNFILL table, not a source lever.  This worker is barred from
   editing build.py; padinit and PAD_update are the two candidates here
   (PAD_state is NOT -- see its own note).

   w50-a9 2026-08-09 re-gate 9 (65/66) confirmed again; SIX more forms falsified,
   which closes the biv-elimination lead (item 1) for the FOURTH time and adds a
   first falsification round for item 2:
     item 1 (prologue giv-init order) -- hand loop.c a biv it should eliminate by
       assigning the byte offset IN-BODY as a giv of a 0..1 counter:
         `for (i = 0; i < 2; i++) { off = i << 3; ... }`  24 diffs / 66 insns
         `for (i = 0; i < 2; i++) { off = i * 8;  ... }`  28 diffs / 66 insns
         same two with a SEPARATE counter `n` (so loop 2 keeps the SYM's `i`):
                                                          26 and 30 / 66 insns
       In every one cc1 KEEPS the counter as a real biv and adds a per-iteration
       `sll $v1,$s0,3` (that is the extra insn, not the epilogue nop) -- the byte
       offset never becomes the exit-test giv.  A depth-1 `do{}while(0)` wrapper
       on loop 1's body is diff-NEUTRAL (9), so the zero-cost ref-inflator family
       does not reach a loop.c *elimination* decision either.
     item 2 (`addu $a3,$t0,$zero` vs retail `addu $a3,$zero,$zero`) -- cse reusing
       `i`'s just-materialised 0 for `btnOff`:
         init order swapped in the comma header                       17
         `btnOff` init hoisted above loop 1                           27 / 67 (frame 40)
         opacity fence on btnOff's 0 (fence AFTER the plain init)      9 (neutral)
         opaque zero source `int z=0; fence(z); btnOff = z`           10 / 66 -- it
           DOES make the two zeros independent, but the z materialisation is a REAL
           extra insn, so it buys parity with the wrong instruction;
         the same opaque-zero on `i` instead                          28 / 70
         depth-2 wrapper on loop 2's body                             29
     Verdict unchanged: 9 = item 1 (4, loop.c biv elimination our cc1 will not do)
     + item 2 (2, cse zero-reuse) + item 3 (3, the w48 EPILOGUE-SWAP class, whose
     only instrument is build.py's PER_FN_EPILOGUE_UNFILL table -- still the single
     highest-value action on this function and still outside a worker's remit). */
void PAD_update(void)
{
  int i;
  int off;
  int btnOff;
  int active;
  uint debCount;

  for (off = 0; off < 16; off += 8) {
    if (((PAD_COMMON *)((char *)Padglobal + off))->nopad != 0) {
      blockfill((char *)gPadinfo.buf + off * 4, 0x20, 0xff);
    }
    else {
      blockmove((char *)Padglobal + off, (char *)gPadinfo.buf + off * 4, 8);
      blockfill((char *)gPadinfo.buf + off * 4 + 8, 0x18, 0xff);
    }
  }
  for (i = 0, btnOff = 0; i < 8; i++, btnOff += 8) {
    active = (((byte *)gPadinfo.buf)[btnOff] == 0);
    if (active != gPadinfo.state[i].bActive) {
      debCount = gPadinfo.state[i].time;
      gPadinfo.state[i].time = debCount + 1;
      if (debCount > 5) {
        gPadinfo.state[i].bActive = active;
        gPadinfo.state[i].time = 0;
      }
    }
  }
}

/* end of pad.c (~line 375 per SLD) */
