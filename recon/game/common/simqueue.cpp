/* game/psx/simqueue.cpp -- RECONSTRUCTED (NFS4 PSX sim input queue; C++ TU)
 *   8 fns: SimQueue_StartUp/Reset/CleanUp/Put/SetCurrentInput/GetCurrentInput/SetLag/IsBlocking.
 *   GTE-free. Full SYM-locals applied.
 */
#include "simqueue_types.h"
#include "simqueue_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
/* W65-A8 REAL DEFECT, decoded from rom/nfs4-f.exe 0x8013d434..0x8013d440:
 *   gSimQueue_Ticker     = ff ff ff ff = -1
 *   gSimQueue_BlockSelf  = 01 00 00 00 =  1
 *   gSimQueue_BlockOther = 01 00 00 00 =  1
 * all three were zero-valued tentative definitions here, so every one of
 * them held the WRONG value until SimQueue_StartUp/Reset ran.  Retail's
 * order is Ticker, BlockSelf, BlockOther -- keep it. */
int gSimQueue_Ticker     = -1;
int gSimQueue_BlockSelf  = 1;
int gSimQueue_BlockOther = 1;

/* simqueue.obj file-static storage from SYM.  Named BSS sections isolate the
 * two large objects around the gp-relative maxTicksPerFrame word while keeping
 * all three as natural zero-initialized statics. */
static Input_tResults output[2]
    __attribute__((section(".bss.simqueue_output")));
static int maxTicksPerFrame;
static sim_queue inputQueue
    __attribute__((section(".bss.simqueue_input_queue")));
/* gSimQueue_Ticker is defined with its siblings at the top of this TU (W65-A8). */

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void SimQueue_StartUp(void);
void SimQueue_Reset(void);
void SimQueue_CleanUp(void);
int SimQueue_Put(int pIndex,Input_tResults *val);
void SimQueue_SetCurrentInput(int time);
void SimQueue_GetCurrentInput(int pIndex,Input_tResults *out);
static void SimQueue_SetLag(void);
static int SimQueue_IsBlocking(int pIndex);


/* ---- SimQueue_StartUp__Fv  [SIMQUEUE.CPP:93-101] SLD-VERIFIED ---- */
void SimQueue_StartUp(void)

{
  gSimQueue_BlockSelf = 1;
  gSimQueue_BlockOther = 1;
  SimQueue_SetLag();
  return;
}

/* ---- SimQueue_Reset__Fv  [SIMQUEUE.CPP:115-155] SLD-VERIFIED ---- */
void SimQueue_Reset(void)

{
  int i;
  int j;

  gSimQueue_BlockSelf = 1;
  gSimQueue_BlockOther = 1;

  for (i = 0; i < 2; i = i + 1) {

    j = 0;

    do {

      if (j < 4) {
        inputQueue.Validity[i][j] = 1;
      }
      else {
        inputQueue.Validity[i][j] = 0;
      }

      inputQueue.Buffer[i][j].steering = 0;
      inputQueue.Buffer[i][j].gas = 0;
      inputQueue.Buffer[i][j].brake = 0;
      inputQueue.Buffer[i][j].flags = 0;
      j = j + 1;

    } while (j < 0x20);

    inputQueue.TailTime[i] = 4;

  }

  inputQueue.HeadTime = 0;
  gSimQueue_Ticker = 3;
  gSimQueue_BlockOther = 0;
  gSimQueue_BlockSelf = 0;
  return;
}

/* ---- SimQueue_CleanUp__Fv  [SIMQUEUE.CPP:169-174] SLD-VERIFIED ---- */
void SimQueue_CleanUp(void)

{
  gSimQueue_BlockSelf = 1;
  gSimQueue_BlockOther = 1;
  return;
}

/* ---- SimQueue_Put__FiP14Input_tResults  [SIMQUEUE.CPP:201-249] SLD-VERIFIED ---- */
int SimQueue_Put(int pIndex,Input_tResults *val)

{
  int tail;

  tail = inputQueue.TailTime[pIndex] & 0x1f;
  if (SimQueue_IsBlocking(pIndex) != 0) {
    return 0;
  }
  if (inputQueue.Validity[pIndex][tail] != kINVALID) {
    return 0;
  }
  inputQueue.Buffer[pIndex][tail] = *val;
  inputQueue.Validity[pIndex][tail] = kVALID;
  inputQueue.TailTime[pIndex] = inputQueue.TailTime[pIndex] + 1;
  if (SIMQUEUE_COMMMODE != 0) {
    if (SIMQUEUE_COMMMODE == 1) {
      if (pIndex != 0) {
        gSimQueue_Ticker = gSimQueue_Ticker + 1;
      }
    }
  }
  else {
    if (SIMQUEUE_NUM_PLAYER_RACE_CARS < 2) {
      gSimQueue_Ticker = gSimQueue_Ticker + 1;
    }
    else if (pIndex != 0) {
      gSimQueue_Ticker = gSimQueue_Ticker + 1;
    }
  }
  return 1;
}

/* ---- SimQueue_SetCurrentInput__Fi  [SIMQUEUE.CPP:271-290] SLD-VERIFIED ---- */
/*
 * NEAR-MISS 4 (count-exact 48/48).  Structure is SYM-exact: the 8c block lists
 * exactly `i` (REG $4 = $a0) and `pIndex` (REG $3 = $v1), and both are ours.
 * The whole residual is the %hi SCRATCH of the FIRST loop's `output` base:
 *     ours    lui $v0,%hi(output) ; addiu $a2,$v0,%lo(output)   (separate temp)
 *     oracle  lui $a2,%hi(output) ; addiu $a2,$a2,%lo(output)   (self temp)
 * i.e. local-alloc COMBINED the HIGH pseudo with the LO_SUM dest in retail and
 * did not in ours (3.15 v0-vs-a2 tie-break).  The SECOND loop's base uses the
 * separate-temp form in BOTH builds, so it is a per-site allocator decision,
 * not a flag or a declaration.
 * FALSIFIED (W61-A13, 2026-08-15, each a real gate run, all 4 diffs / 48-48
 * unless noted): for-loop form; `pIndex++`; cast-int index-term-first subscript
 * `*(Input_tResults *)((pIndex << 2) + (int)output)`; explicit `&inputQueue...`
 * source cast; per-iteration `Input_tResults *dst = output + pIndex` (28 @46);
 * statement order `i` before `pIndex`; a void-tail fence before the first loop
 * (9 @49); and -- in simqueue_externs.h -- `output[]` unsized and `output[64]`
 * (3.12 #5 declaration-shape lever), both inert.
 * NOT tentative-def-able: no oracle in the tree reaches `output` via %gp_rel, so
 * the 3.12 #6 ownership gate forbids it.
 * NEXT ANGLE: read the local-alloc handout (-dl) for this TU and find which
 * pseudo blocks combine_regs on the HIGH (11A: "not local to this block OR DIES
 * MORE THAN ONCE").  Do not spend more spellings.
 * W62-A12 (2026-08-15) -- re-gated 4 @48/48.  This is the SAME class as
 * audiocmn CheckState site (2), and the device that buys the self-temp `la` there
 * was re-tested here: an arm-local pointer carrying a 13B identity launder.  It
 * costs the count here too (12E: register XOR count).  Measured, all real gate runs:
 *   explicit walking dest `Input_tResults *dst = output; *dst = ...; dst++` .. 4 (inert)
 *   the same laundered `__asm__ ("" : "=r" (dst) : "0" (dst))` ............... 9 @49
 *   array form through a laundered base local ............................... 18 @50
 *   array form through a PLAIN base local ................................... 48 @48
 * The last row is the interesting one: it is count-EXACT but rotates the whole
 * function, i.e. a genuinely different basin exists at 48/48 -- worth a permuter
 * re-seed rather than more hand spellings.
 * W71-A21 -- three more axes measured, all inert or worse (real gate runs):
 *   BLOCK-LOCAL loop counters (the 13A device that landed r3dcar this wave):
 *     one block-local `pIndex` per loop ............................ 28 @48
 *     block-local only for the FIRST loop .......................... 28 @48
 *     block-local `Input_tResults *dst = output;` + dst[pIndex] ..... 48 @48
 *   SECTION-ATTRIBUTE shape of the two file statics (the `.bss.simqueue_*`
 *   named sections are a recon invention, so they were a live suspect for the
 *   address-materialization form): dropping BOTH, or either one alone, is
 *   BYTE-NEUTRAL -- 4 diffs and 7/8 TU PASS in all three cases.  So the
 *   self-vs-separate %hi temp is NOT a section/relocation question.
 * The 28 @48 rows are a THIRD count-exact basin (distinct from the 48 @48 one
 * above), so there are now at least three; the permuter re-seed is the priced
 * next step and it now has three seeds to start from, not one.
 *
 * W72-A12 2026-08-22 -- *** SOLVED (PASS 48/48 under one PER_TU_FLAGS row; see
 * (3)).  Everything above is a two-year chase of the wrong axis: this was NEVER
 * an allocator tie-break, it is the -G SMALL-DATA THRESHOLD deciding whether the
 * address gets SPLIT at all.  Three facts:
 *  (1) THE MECHANISM.  Our pair is a genuine expand-time SPLIT-ADDRESS pair:
 *          (set (reg 132) (high  (symbol_ref "output")))      <- BLOCK-LOCAL qty
 *          (set (reg 136) (lo_sum (reg 132) (symbol_ref "output")))
 *      and p136 is the loop's walking pointer, live across blocks => a GLOBAL
 *      allocno with reg_qty == -1.  local-alloc.c:1875 (`sreg >= FIRST_PSEUDO
 *      && reg_qty[sreg] == -1`) makes combine_regs REFUSE the tie, so the HIGH
 *      is a free-standing local qty and find_free_reg gives it the lowest free
 *      register.  In this block there are TWO such highs (inputQueue and
 *      output) with DISJOINT windows, so BOTH take $v0 -- which is exactly what
 *      we emit (`lui $2,%hi(inputQueue); addiu $8,$2,%lo` then
 *      `lui $2,%hi(output); addiu $6,$2,%lo`).  Nothing in this picture can hand
 *      the second high a NON-lowest register, which is why 20+ source spellings,
 *      3 fence flavours and 2 permuter basins have all been inert: there is no
 *      dial, because the answer is not a dial.
 *  (2) WHAT RETAIL ACTUALLY HAS.  Retail is MIXED inside this one function:
 *          lui $v0,%hi(inputQueue) ; addiu $t0,$v0,%lo(inputQueue)   <- SPLIT pair
 *          lui $a2,%hi(output)     ; addiu $a2,$a2,%lo(output)       <- `la $a2,output`
 *      The second is not a split pair that got lucky -- it is the ASSEMBLER's
 *      expansion of a SINGLE `la` (a plain `(set (reg) (symbol_ref))` movsi),
 *      which always self-temps (IDT Ch9 / methodology 3.16).  PROVEN by a raw
 *      CC1PLPSX A/B (scratchpad/W72_A12/rawcc1.py): with -mno-split-addresses
 *      cc1 emits `la $8,inputQueue` + `la $6,output` -- i.e. the `la` form
 *      reproduces retail's `output` pair EXACTLY and simultaneously BREAKS the
 *      `inputQueue` one.  So the two addresses in retail were materialised by
 *      DIFFERENT mechanisms, and the `output` one was created AFTER the
 *      split-address expansion (loop.c's biv initial value).
 *  (3) *** SOLVED -- IT IS THE -G THRESHOLD, AND THE WIRING IS `g_value: "8"`.
 *      mips.c `mips_check_split()` refuses to split a symbol whose
 *      SYMBOL_REF_FLAG is SET, and ENCODE_SECTION_INFO sets that flag for any
 *      object whose size is <= the -G threshold.  `output` is EXACTLY 8 bytes
 *      (2 x 4-byte Input_tResults), `inputQueue` is huge.  So at -G8 gcc splits
 *      `inputQueue`'s address (separate temp) and does NOT split `output`'s
 *      (plain movsi -> assembler `la` -> SELF temp) -- retail's mixed pair,
 *      exactly.  At -G4 (our default) `output` is over threshold, gets split
 *      too, and there is no dial that can recover the self temp.
 *      MEASURED on a scratchpad copy of build.py (scratchpad/W72_A12/ptools),
 *      PER_TU_FLAGS "recon/game/common/simqueue.cpp": {"g_value": "8"}:
 *        SimQueue_SetCurrentInput  4 @48/48 -> PASS 48/48
 *        whole TU                  7/8 -> 8/8 PASS
 *          (GetCurrentInput needs the pointer-add spelling landed below; it is
 *           byte-neutral at -G4, so it is already in-source and safe either way)
 *      PLACEMENT IS BYTE-NEUTRAL: `objdump -t` of the -G8 object is identical to
 *      the -G4 one -- output -> .bss.simqueue_output, inputQueue ->
 *      .bss.simqueue_input_queue, maxTicksPerFrame -> .sbss, the three globals
 *      -> .sdata.  The named-section attributes above are what keep the now
 *      under-threshold `output` out of .sbss, so KEEP THEM (dropping them still
 *      gates 8/8, but only the section attribute guarantees the placement).
 *      => ORCHESTRATOR ACTION: add the g_value "8" PER_TU_FLAGS row.
 *      (Falsified alternative, same probe: whole-TU no_split_addresses makes
 *       BOTH addresses `la` -- this fn 32 @48 and the TU 2/8 PASS: SetLag 4,
 *       GetCurrentInput 16, IsBlocking 16, Put 46, Reset 47.  A hard NO.)
 *     Everything else measured this wave, all real gate runs, all 4 @48/48
 *     unless noted (so the W62/W71 basins are re-confirmed from scratch):
 *       walking dest declared at the TOP of the function .............. 4
 *       walking dest assigned just before the loop ................... 4
 *       do/while (guarded) loop shape ............................... 4
 *       BOTH bases named, dest first ......................... 39 @47 (-1 insn)
 *       BOTH bases named, source first ....................... 39 @47
 *     PERMUTER (the W71 priced next step, DONE): three job dirs seeded from the
 *     three known count-exact basins (permuter_work/SimQueue_SetCurrentInput__Fi,
 *     SQ_basin2 = plain base local, SQ_basin3 = block-local counters), ~9k
 *     iterations each; base score 10, NO score-0 and no candidate below base in
 *     basin 1.  Consistent with (1): the permuter mutates C, and no C mutation
 *     changes whether an address is split.  DO NOT re-run the permuter here. */
void SimQueue_SetCurrentInput(int time)

{
  int i;
  int pIndex;

  pIndex = 0;
  i = time & 0x1f;
  while (pIndex < SIMQUEUE_NUM_PLAYER_RACE_CARS) {
    output[pIndex] = inputQueue.Buffer[pIndex][i];
    pIndex = pIndex + 1;
  }
  pIndex = 0;
  while (pIndex < SIMQUEUE_NUM_PLAYER_RACE_CARS) {
    inputQueue.Validity[pIndex][i] = 0;
    pIndex = pIndex + 1;
  }
  inputQueue.HeadTime = inputQueue.HeadTime + 1;
  return;
}

/* ---- SimQueue_GetCurrentInput__FiP14Input_tResults  [SIMQUEUE.CPP:295-407] SLD-VERIFIED ---- */
/* MATCH (W72-A12): the POINTER-ADD spelling `*(output + pIndex)`, not the
   subscript `output[pIndex]`.  Both are PASS under the shipped -G4 build (the
   change is byte-neutral there), but under the -G8 wiring recommended for this
   TU (see the SetCurrentInput block above) the subscript form emits
   `sll a0,a0,2` BEFORE the address pair while retail emits it AFTER; the
   pointer-add (and equally `Input_tResults *p = output; p[pIndex]`, or the
   int-cast base-first form) puts the base pair first and PASSes both ways.
   Measured under -G8: subscript 2 @10 | `(pIndex<<2)+(int)output` 2 | a
   `p = output + pIndex` local 2 | `p = &output[pIndex]` local 2 |
   pointer-add PASS | `p = output; p[pIndex]` PASS | int-cast base-first PASS. */
void SimQueue_GetCurrentInput(int pIndex,Input_tResults *out)

{
  *out = *(output + pIndex);
  return;
}

/* ---- SimQueue_SetLag__Fv  [SIMQUEUE.CPP:326-407] SLD-VERIFIED ---- */
static void SimQueue_SetLag(void)

{
  if (SIMQUEUE_COMMMODE == 0) {
    maxTicksPerFrame = 4;
  }
  else if (SIMQUEUE_COMMMODE == 1) {
    maxTicksPerFrame = 4;
  }
  return;
}

/* ---- SimQueue_IsBlocking__Fi  [SIMQUEUE.CPP:382-407] SLD-VERIFIED ---- */
static int SimQueue_IsBlocking(int pIndex)

{
  /* Retail keeps two physical zero-return blocks: the nonzero-index fast path
   * here and the unsupported-comm-mode tail below. */
  if (pIndex == 0) goto check_mode;
  return 0;

check_mode:
  if (SIMQUEUE_COMMMODE == 0) goto calculate;
  if (SIMQUEUE_COMMMODE != 1) goto return_zero;

calculate:
  return inputQueue.TailTime[0] < inputQueue.HeadTime + maxTicksPerFrame ^ 1;

return_zero:
  return 0;
}

/* end of simqueue.cpp */
