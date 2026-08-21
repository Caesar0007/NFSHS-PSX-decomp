/* game/psx/simqueue.cpp -- RECONSTRUCTED (NFS4 PSX sim input queue; C++ TU)
 *   8 fns: SimQueue_StartUp/Reset/CleanUp/Put/SetCurrentInput/GetCurrentInput/SetLag/IsBlocking.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
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
  int iVar4;
  u_char *entry;

  tail = inputQueue.TailTime[pIndex] & 0x1f;
  iVar4 = SimQueue_IsBlocking(pIndex);
  if (iVar4 != 0) {
    return 0;
  }
  entry = (u_char *)&inputQueue + (tail * 4 + pIndex * 0x80);
  if (*(int *)(entry + 0x100) != kINVALID) {
    return 0;
  }
  *(Input_tResults *)entry = *val;
  *(int *)(entry + 0x100) = kVALID;
  inputQueue.TailTime[pIndex] = inputQueue.TailTime[pIndex] + 1;
  if (GameSetup_gData.commMode != 0) {
    if (GameSetup_gData.commMode == 1) {
      if (pIndex != 0) {
        gSimQueue_Ticker = gSimQueue_Ticker + 1;
      }
    }
  }
  else {
    if (GameSetup_gData.numPlayerRaceCars < 2) {
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
 * next step and it now has three seeds to start from, not one. */
void SimQueue_SetCurrentInput(int time)

{
  int i;
  int pIndex;

  pIndex = 0;
  i = time & 0x1f;
  while (pIndex < GameSetup_gData.numPlayerRaceCars) {
    output[pIndex] = inputQueue.Buffer[pIndex][i];
    pIndex = pIndex + 1;
  }
  pIndex = 0;
  while (pIndex < GameSetup_gData.numPlayerRaceCars) {
    inputQueue.Validity[pIndex][i] = 0;
    pIndex = pIndex + 1;
  }
  inputQueue.HeadTime = inputQueue.HeadTime + 1;
  return;
}

/* ---- SimQueue_GetCurrentInput__FiP14Input_tResults  [SIMQUEUE.CPP:295-407] SLD-VERIFIED ---- */
void SimQueue_GetCurrentInput(int pIndex,Input_tResults *out)

{
  *out = output[pIndex];
  return;
}

/* ---- SimQueue_SetLag__Fv  [SIMQUEUE.CPP:326-407] SLD-VERIFIED ---- */
static void SimQueue_SetLag(void)

{
  if (GameSetup_gData.commMode == 0) {
    maxTicksPerFrame = 4;
  }
  else if (GameSetup_gData.commMode == 1) {
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
  if (GameSetup_gData.commMode == 0) goto calculate;
  if (GameSetup_gData.commMode != 1) goto return_zero;

calculate:
  return inputQueue.TailTime[0] < inputQueue.HeadTime + maxTicksPerFrame ^ 1;

return_zero:
  return 0;
}

/* end of simqueue.cpp */
