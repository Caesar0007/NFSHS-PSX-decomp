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

/* ---- pad.obj data globals (eaclib/psx, from canonical Globals) ----
 * W65-A6 DATA-MAT: these were `extern`-only tree-wide (never defined), i.e. 115+6
 * reloc-referenced undefined symbols at link.  Retail has them in .bss (VA >
 * the PS-X EXE's t_addr+t_size = 0x8013E000, so they carry NO file bytes: pure
 * zero-init BSS), CONTIGUOUS and in this order:
 *      gPadinfo  @0x8013E89C size 84   (SYM: `96 Def2 class EXT type STRUCT size 84`)
 *      Padglobal @0x8013E8F0 size 16   (= 0x8013E900 memclass - 0x8013E8F0)
 * A tentative definition is the right shape here: cc1 emits `.comm sym,size`,
 * maspsx re-emits it as a REAL `.section .bss` + `.globl` + `.space` definition
 * (sdata_limit=0 in build.py's maspsx invocation), so the object owns the storage
 * instead of leaving it a linker-placed COMMON.  Both are > -G8, so address
 * materialization stays absolute `%hi/%lo` (the §3.12 #6 gp-rel lever cannot
 * fire) -- pad.c re-gates identically (see scratchpad/w65a6/RECEIPTS.md).
 * Declaration order IS emission order (catalog 16E), so they are declared in
 * retail VA order.  */
struct {                              /* SYM tag .63fake, 84 bytes */
    int initialized;                  /* +0x0 */
    PAD_COMMON buf[8];                /* +0x4 */
    struct {                          /* SYM tag .62fake, 2 bytes */
        u_char bActive, time;         /* +0x0 */
    } state[8];                       /* +0x44 */
} gPadinfo;                           /* @0x8013e89c [BSS] */
PAD_COMMON      Padglobal[2];         /* @0x8013e8f0  per-port pad buffers [BSS] */

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
 * maspsx "stop injecting .set noreorder" option, not ASPSX and not any source form.
 *
 * W52-A8 2026-08-09 -- SOLVED, 4 -> PASS 20/20.  The w49-a9 CLASS CORRECTION above was a
 * PREDICTION, never a measurement, and it is FALSIFIED: it argued that un-filling our
 * return slot would emit `lw ra; nop; addiu sp; jr ra; nop` = 21 insns.  MEASURED, it
 * emits exactly the oracle's 20: `lw ra; addiu sp; jr ra; nop`.  Why the prediction was
 * wrong: the load-delay nop after `lw ra` is NOT unconditional -- once the unfill moves
 * `addiu sp` out of the return slot it lands directly after `lw ra`, where it COVERS the
 * $ra load-use hazard itself, so maspsx never resolves a `#nop` at all.  That is exactly
 * retail's shape, which is why the two are byte-identical.
 *   ACTION (orchestrator, build.py -- this worker is barred from editing it):
 *     add "PAD_state" to PER_FN_EPILOGUE_UNFILL["recon/eaclib/psx/pad.c"]
 *     (that entry already exists and lists padinit + PAD_update).
 *   Whole-TU gate, reproduced twice from a clean object, with control:
 *     WITH the entry: padinit PASS | PAD_restore PASS | PAD_state PASS |
 *                     PAD_convert PASS | PAD_update FAIL 6 (66/66)
 *     WITHOUT:        PAD_state FAIL 4, every other function identical
 *   => +1 PASS, ZERO PASS->FAIL.  pad.c goes 3/5 -> 4/5.
 *   The same patch was swept over ALL 13 remaining sndpsxz/spchpsxz/pad.c FAILs and
 *   PAD_state is its ONLY member (every other function unchanged or worse), so this
 *   closure is measured, not assumed.
 *   LESSON (catalog-worthy): a `#nop`-placeholder verdict reached by PREDICTING the
 *   unfill mechanism's output must be RE-MEASURED -- the mechanism's own output can
 *   cover the very hazard the prediction assumed would need a nop.
 *
 * W52-A8 GCC-LADDER (04U lane, NFS4_FORCE_CC1_ALT=<ver>, UNCHANGED source).  The forced
 * lane also swaps the ASSEMBLER route (direct GNU-as reorder, no maspsx) and drops this
 * TU's no_split_addresses + PER_FN_EPILOGUE_UNFILL wiring, so read it against the
 * forced-2.8.0 CONTROL row, not against the default row:
 *   lane      | padinit | PAD_restore | PAD_state  | PAD_convert | PAD_update
 *   default   |  PASS   |    PASS     |  4 (20/20) |    PASS     |  6 (66/66)
 *   2.6.0     |  3      |    6        |  PASS      |    PASS     | 24 (64/66)
 *   2.6.3     |  3      |    6        |  PASS      |    PASS     | 24 (64/66)
 *   2.7.2     |  3      |    6        |  PASS      |    PASS     | 21 (65/66)
 *   2.8.0 CTL | 23      |   10        | 15 (19/20) |    PASS     | 69 (63/66)
 *   (PAD_state also: 2.7.2-970404 11 | 2.91.66 19 | 2.95.2 15 -- all worse)
 * READING: every pre-2.8 rung reproduces PAD_state's epilogue shape from the SOURCE side,
 * which independently corroborates that its residual was the epilogue class and nothing
 * else.  The rung is NOT wireable though: padinit/PAD_restore fall out of PASS (their
 * alt-lane residuals are the same epilogue / `la`-split shapes).  Probed with pad.c added
 * to PER_FN_EPILOGUE_UNFILL_272 as well: padinit PASS, PAD_restore 3, PAD_state PASS,
 * PAD_convert PASS, PAD_update 21 -- still net-negative.  The build.py unfill entry above
 * reaches the same PASS with zero collateral, so that is the action, not a lane change. */
u_short PAD_state(int padID)
{
  if (gPadinfo.initialized != 0 && (uint)padID < 8) {
    return PAD_convert(gPadinfo.buf + padID) & 0xffff;
  }
  return 0;
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
     highest-value action on this function and still outside a worker's remit).

   W59-A9 2026-08-14 RE-GATE 6, COUNT-EXACT 66/66.  Item 3 (the epilogue swap) is
   GONE -- PER_FN_EPILOGUE_UNFILL is wired now -- so the residual is exactly
   item 1 (4 diffs) + item 2 (2 diffs).
     * ITEM 1 IS NOW MECHANISED.  It is a PURE EMISSION-ORDER difference (both
       sides have the identical two instructions), so it is reachable by
       build.py's PER_FN_TEXT_MOVES table without any source change.  MEASURED
       spec (probe harness scratchpad/w59a9/probe_moves.py, which patches
       build.PER_FN_TEXT_MOVES in memory and re-uses verify_asm's normalizers):
           "recon/eaclib/psx/pad.c": {
             "PAD_update": [
               {"take": r"\tsw\t\$16,16\(\$sp\)\n", "after": r"\tmove\t\$17,\$2\n"},
               {"take": r"\tmove\t\$16,\$0\n",      "after": r"\tsw\t\$16,16\(\$sp\)\n"},
             ],
           }
       Result: PAD_update 6 -> 2, whole TU 4/5 PASS (no regression; pad.c has no
       prior TEXT_MOVES entry).  This restores retail's giv-init emission order
       ($s2, $s1, $s0) without pretending our loop.c eliminated the biv.
     * ITEM 2 STAYS (2 diffs, `addu $a3,$t0,$zero` vs retail `addu $a3,$zero,$zero`).
       It is an instruction-CONTENT difference, so TEXT_MOVES cannot reach it.
       W59-A9 re-falsified three more source forms, each re-measured from the
       6-diff base (all WORSE, none kept):
         loop 1 AND loop 2 both in index form (`Padglobal[i]` / `gPadinfo.buf[i]`)   26
         loop 1 index form only (loop 2 keeps i/btnOff)                              21
         loop 2 index form only (loop 1 keeps the byte offset)                       17
         identity fence on `i` before a `for (btnOff = 0; ...)` header               25
       In every index spelling cc1 keeps the counter as a real biv and adds a
       per-iteration `sll`, exactly as w50-a9 recorded -- the byte-offset
       spellings in this body ARE the faithful shape.  Item 2's only remaining
       angle is the loop.c giv-creation decision itself (retail's btnOff is a
       preheader giv init emitted AFTER cse, ours is a source variable cse
       rewrites into a copy of i's zero) -- i.e. the instrumented-cc1 lane, not C.

   W63-A7 2026-08-15 re-gate 2 (66/66) after the TEXT_MOVES row: item 1 IS
   landed, and the ONE surviving item is now read off the oracle exactly.
   Retail's preheader group is  t0=0 | lui a0 | addiu a0 | addiu a2,a0,-1 |
   a3=0  -- i.e. btnOff's init is emitted LAST, AFTER the two state walkers,
   and as a FRESH zero.  Ours emits it SECOND (right after i's) and as a COPY
   `addu a3,t0,zero`.  Both halves have ONE cause: retail's btnOff is a loop.c
   GIV (givs' preheader inits are appended after everything already there, in
   reverse creation order -- the same law that explains item 1's $s2/$s1/$s0
   order in loop 1), so it is created AFTER cse has run and there is no live 0
   to copy; ours is a source BIV whose init is a plain statement with the
   lowest luid, which cse then rewrites into a copy of i's just-materialised 0.
   ⇒ position and content are not two dials, they are one: "make btnOff a giv".
   RE-MEASURED IN THIS BASIN (04Z -- the w50/w59 index-form numbers were taken
   from the pre-TEXT_MOVES 6-diff base and are stale; all of these are worse):
     ((byte *)gPadinfo.buf)[i * 8]  / [i << 3]  / gPadinfo.buf[i].nopad, and
     `btnOff = i * 8;` (resp. `i << 3`) assigned INSIDE the loop body so it is
     a giv CANDIDATE rather than a biv .......... all five 13 @65 (1 SHORT)
     explicit source walkers for the two state pointers, btnOff init after them
       (`u_char *pt = &gPadinfo.state[0].time; u_char *pa = pt - 1;`) . 12 @66
       (t0<->a3 swap: the walkers stop being givs and i takes a3)
     the same walkers with both inits back in the comma header ........ 4 @66
       (only i's init moves; the copy stays)
     identity launder on `i` between `i = 0;` and `btnOff = 0;` ....... 21 @71
     the same launder with btnOff's init back in the for header ....... 21 @71
       (both: the asm barrier costs 5 real insns in the preheader)
   The 13 @65 cluster is the same single collapse for every index spelling, so
   the giv route is closed from C in this basin.  NOT expressible as TEXT_MOVES
   either: moving our a3 line after the a2 line leaves the same 2 diffs (the
   line's CONTENT is wrong, and TEXT_MOVES re-inserts the text it took).
   Route: instrumented-cc1 (why loop.c declines the i*8 giv here), or accept.

   W71-A15 2026-08-21 RE-GATE 2, COUNT-EXACT 66/66 (baseline confirmed).  The
   residual is exactly item 2 and the W63 diagnosis is SHARPENED with the
   mechanism that cracked sdmemman.c's twin residual this wave:
   ours' `addu $a3,$t0,$zero` is a cse CONSTANT-SHARING substitution (the const
   0 replaced by the live register holding 0) whose resulting COPY then SURVIVES
   local-alloc -- `i` is a loop counter spanning blocks, so reg_qty[i] < 0 and
   combine_regs (local-alloc.c:1866) refuses to tie the copy away.  Retail has
   no copy because its `btnOff` init is a loop.c GIV init created AFTER cse, so
   no live 0 was in scope.  ⇒ the two halves (the substitution and the copy's
   survival) are one fact, and the ONLY zero-insn instrument that breaks a cse
   value-equivalence is the identity launder -- which W63 already measured at
   21 @71 here (the asm costs 5 real insns in this preheader, and it also risks
   silently unmatching the PER_FN_TEXT_MOVES anchors below).
   NEW FALSIFICATIONS, all re-measured in THIS basin (04Z), none < 2:
     `for (btnOff = 0, i = 0; ...)` init order swapped ................. 10 @66
     `btnOff = 0;` hoisted above the loop, `i = 0` in the header ....... 10 @66
     `i = 0;` hoisted above the loop, `btnOff = 0` in the header ......... 2 @66
     `for (i = 0, btnOff = i; ...)` (init from the counter itself) ....... 2 @66
     `btnOff` declared `unsigned int` .................................... 2 @66
   The two 10-diff rows are the informative ones: making btnOff's zero the
   FIRST one materialised does NOT free the pair, it just moves the copy onto
   `i` and costs 8 more diffs -- confirming the copy is forced by cse having
   ANY live zero at that point, not by which variable owns it.

   W72-A20 2026-08-22 RE-GATE 2, COUNT-EXACT 66/66 (baseline confirmed).  NO
   landing.  The brief's named angle was 21E-5 (fence the FIRST occurrence of the
   shared literal so the second re-materializes -- the device that took ADDDF3.c
   6 -> 2 this same wave).  It is measured here and it does NOT reach this site,
   and the reason is now precise: at ADDDF3's site the shared literal is a CALL
   ARGUMENT, so the launder's own `li` is free (it lands inside the argument
   block); here the shared literal is a LOOP-PREHEADER constant with nothing to
   hide behind, so the launder's barrier costs real instructions before it can
   change any value equivalence.
   NEW FALSIFICATIONS, all in this basin, none < 2:
     21E-5 launder on the FIRST occurrence -- `i = 0; <identity fence on i>;`
       then `for (btnOff = 0; i < 8; i++, btnOff += 8)` .............. 21 @71/66
       (+5 insns: same cost W63 measured for the launder on the other side,
        so the fence family is now falsified from BOTH ends here)
     09H WALKER->INDEX -- drop `btnOff` entirely and subscript with `i * 8`,
       which is what the SYM implies (only `i` is a retail local) ... 13 @65/66
       ⇒ INFORMATIVE, and it retires the "make btnOff a giv" idea: with the
       index form loop.c builds a full ADDRESS giv (`lbu $v0,0($a3)`), which
       DELETES the oracle's indexed-load macro (`lui $at; addu $at,$at,$a3;
       lbu $v0,0($at)`) and the whole address block diverges.  Retail's `a3`
       really is a bare INDEX register feeding an assembler indexed-load macro,
       so `btnOff` must stay an explicit index variable -- the receipt above is
       right that retail's INIT is giv-shaped, but the variable is not.
     `btnOff = off - 16;` (a computed zero cse cannot equate) ......... 30 @66/66
     `for (btnOff = 0, i = 0; i < 8; btnOff += 8, i++)` ............... 12 @66/66
     declaration order swapped, `int btnOff;` before `int i;` (13A
       pseudo-number tie-break) ................................. 2 @66/66 (inert)
   ANGLE UNCHANGED and now bounded from three sides (spelling, fence, index
   form): this is one cse value-equivalence decision on a preheader constant.
   The live route is an instrument read (qtytrace/-dl or a cse-table dump on the
   2.8.0 lane), or PER_FN_TEXT_MOVES -- but note TEXT_MOVES cannot fix it either,
   since the row needs an OPERAND change (`$t0` -> `$zero`), not a relocation.

   🏆🏆 W74-A19 2026-08-23 -- SOLVED.  PAD_update GATES **PASS 66/66** (probe-verified
   twice, whole-TU zero regression: padinit/PAD_restore/PAD_state/PAD_convert all still
   PASS).  It needs THREE orchestrator wirings and NO source change; this worker is barred
   from editing tools/build.py, so the spec is below.  The residual was NEVER a cse
   value-equivalence question -- every wave since w59 had the pass WRONG.

   🔑 THE MECHANISM, gcc-source-cited (NEW LAW -- see the same-wave ADDDF3.c receipt for
   the full statement):  `reload_cse_regs` (gcc-2.8.1 reload1.c:7869; called from
   toplev.c:3501 `if (optimize > 0)`, i.e. NO flag disables it) is a POST-RELOAD,
   HARD-REGISTER-ONLY CSE.  `reload_cse_simplify_set` (reload1.c:8178) rewrites
   `(set <hardreg> <CONSTANT>)` into a copy from ANY hard register its table already
   records as holding that constant -- with NO cost model, no `rtx_cost` test, nothing a
   pre-reload device can see.  Its table is cleared ONLY at (a) every CODE_LABEL
   (reload1.c:7898-7906 "Forget all the register values at a code label"), (b) CALL_INSNs
   for `call_used_regs`, (c) an overwrite of the holding register.
   HERE: `i = 0` -> `move $t0,$0` is emitted first (the loop-1 back-edge LABEL cleared the
   table, which is why our $s0/off zero is fine); `btnOff = 0` follows in the SAME
   label-free preheader run, so reload_cse serves it as `move $a3,$t0`.  Retail has two
   fresh `addu rX,$zero,$zero`.  ⇒ NO source spelling, fence, launder, ref/live dial,
   block scope or declaration order can EVER reach this row (they all act on pseudos,
   before reload) -- which is exactly why the 20+ falsifications above are all inert.

   🔑 THE ESCAPE IS THE COMPILER RUNG, and it is a sharp VERSION FINGERPRINT.  Minimal
   repro `int a=0,b=0; do{ f(a,b); a++; b+=8; }while(a<8);` over the whole
   windows-gcc-psx ladder (scratchpad/W74_A19/t4.c):
     TWO fresh `move rX,$0` (NO substitution): 2.6.0 * 2.6.3 * 2.6.psyq40 * 2.7.2 *
                                               2.91.66 * 2.95.2
     SUBSTITUTION `move $17,$16`:               2.7.2-970404 * 2.8.0 * 2.8.1
   ⇒ "retail re-materializes a constant where we copy it from a live register" is a
   COMPILER-VERSION TELL: retail's object was NOT built by a 970404/2.8.x cc1 at that
   site.  PAD_update on the 2.7.2 rung emits retail's `addu $a3,$zero,$zero` verbatim.

   🔴 AND A MECHANISM DEFECT THAT MADE EVERY PRIOR SUB-2.8 MEASUREMENT VACUOUS:
   `_apply_cc1_ver_splice` (build.py) uniquifies `$L<n>` labels but leaves the alt rung's
   DEBUG labels alone.  The default lane compiles with `-g1`; a 2.6/2.7 cc1 emits
   `.loc 1 0` + `LM<n>:` BEFORE the epilogue where 2.8 emits it after `.end`.  `LM<n>` is
   neither `$L` nor `.L`, so gas keeps it in the symbol table, objdump prints it as a
   block label, and verify_asm's function block ENDS there -- the spliced PAD_update read
   as "ours 59 / oracle 66, 9 diffs" with its whole epilogue counted missing.  With the
   labels stripped it is 66/66 and 2 diffs.  ⇒ EVERY default-lane PER_FN_CC1_VER_SPLICE
   probe against a sub-2.8 rung, in any wave, must be re-run with the strip.

   🔧 ORCHESTRATOR WIRING SPEC (all three parts are required; each measured):
     (1) build.py `_apply_cc1_ver_splice`: after `_uniquify_local_labels`, strip
         `^\t\.loc\t[^\n]*\n` and `^LM\d+:\n` from the spliced region (byte-neutral --
         they emit no code).  Reference implementation + probe harness:
         scratchpad/W74_A19/a19_versplice.py (runs tools/vprobe.py's OWN source with only
         that patch injected, the 12H anti-drift pattern).
     (2) PER_FN_CC1_VER_SPLICE["recon/eaclib/psx/pad.c"] = {"2.7.2": {"PAD_update"}}
         (the DEFAULT-lane per-fn cc1 swap: maspsx route kept, only the cc1 binary
         changes; the TU's existing PER_FN_EPILOGUE_UNFILL + PER_FN_TEXT_MOVES rows all
         still fire against the 2.7.2 text -- verified in the generated .s).
     (3) APPEND one row to PER_FN_TEXT_MOVES["recon/eaclib/psx/pad.c"]["PAD_update"]
         (keep the two existing rows, in order, then):
            {"take": r"\tmove\t\$7,\$0\n", "after": r"\taddu\t\$6,\$4,-1\n"}
         Both anchors are unique in the fn.  The take is NOT a branch and there is no
         `drop_after`, so no brdist pairing is required (17C); the moved `move $7,$0` has
         no use between the two positions, so it is semantically inert.
         Rows file used for the probe: scratchpad/W74_A19/pad_rows.json.
     MEASURED LADDER for PAD_update WITH the (1) strip, per-fn splice, no extra rows:
       2.7.2 = 2 @66/66 (content correct, one POSITION row) | 2.8.1 = 2 | default = 2
       (2.6.x / 970404 not needed once 2.7.2 lands).  With row (3): PASS.
   NOTE for the next reader: the row-(3) position delta is the 2.7.2 rung's own sched2
   choice, not a second defect -- retail emits `move $t0,$0; la $a0; addu $a2,$a0,-1;
   move $a3,$0`, the rung emits the two zeros adjacent. */
void PAD_update(void)
{
  /* MATCH (2026-08-26, strict source-only 6 -> PASS 66/66): the original
     typed two-pad loop is the missing loop.c shape.  `Padglobal[i]` and
     `gPadinfo.buf + i * 4` let the authentic 2.7.2 compiler eliminate the
     first loop's counter and create the retail s2/s1/s0 GIVs; the prior
     byte-offset reconstruction made `off` a real s0 BIV and emitted its save
     first.  In loop 2, explicit byte walkers initialized between `i` and
     `btnOff` reproduce retail's preheader order (t0, a0/a2, then fresh a3=0)
     and its a0/a2 increment pair.  No post-cc1 moves or rewrites are used.
     SYM-CODEGEN-CARRIER: btnOff
     SYM-CODEGEN-CARRIER: active
     SYM-CODEGEN-CARRIER: debCount
     SYM-CODEGEN-CARRIER: pt
     SYM-CODEGEN-CARRIER: pa
     The SLD/compiler-ladder receipt above proves these expression carriers:
     retail records only i, while removing btnOff or restoring an index loop
     changes the retail GIV/address form. */
  int i;
  int btnOff;
  int active;
  uint debCount;
  u_char *pt;
  u_char *pa;

  for (i = 0; i < 2; i++) {
    if (Padglobal[i].nopad != 0) {
      blockfill(gPadinfo.buf + i * 4, 0x20, 0xff);
    }
    else {
      blockmove(Padglobal + i, gPadinfo.buf + i * 4, 8);
      blockfill(gPadinfo.buf + i * 4 + 1, 0x18, 0xff);
    }
  }
  for (i = 0, pt = &gPadinfo.state[0].time, pa = pt - 1, btnOff = 0;
       i < 8;
       pt += 2, pa += 2, i++, btnOff += 8) {
    active = (((byte *)gPadinfo.buf)[btnOff] == 0);
    if (active != *pa) {
      debCount = *pt;
      *pt = debCount + 1;
      if (debCount > 5) {
        *pa = active;
        *pt = 0;
      }
    }
  }
}

/* end of pad.c (~line 375 per SLD) */
