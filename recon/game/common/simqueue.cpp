/* game/common/simqueue.cpp -- RECONSTRUCTED (NFS4 PSX sim input queue; C++ TU)
 *   8 fns: SimQueue_StartUp/Reset/CleanUp/Put/SetCurrentInput/GetCurrentInput/SetLag/IsBlocking.
 *   GTE-free. Full SYM-locals applied.
 */
#include "simqueue_types.h"
#include "simqueue_externs.h"

/* SOURCE-REVIEW-UNRESOLVED: this holder preserves the unreferenced "SimpleMem" literal at0x800565CC.
 * Retail type/header-family evidence does not recover this helper or the original literal producer.
 * See build/nc12/simplemem_source_producer_20261023/;no constructor/default/inline identity is claimed. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

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

/* simqueue.obj file-static storage from SYM: output[2] (8 bytes, -G8 -> .sbss @0x8013ddc8)
 * then maxTicksPerFrame (@0x8013ddd0), natural zero-initialized statics in this order. */
static Input_tResults output[2];
static int maxTicksPerFrame;
static sim_queue inputQueue;

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


/* ---- SimQueue_StartUp__Fv  [SIMQUEUE.CPP:93-101] COVERED-SLD-PASS ---- */
#line 91 "C:/nfs4/GAME/COMMON/SIMQUEUE.CPP"
void SimQueue_StartUp(void)

{



  gSimQueue_BlockSelf = 1;
  gSimQueue_BlockOther = 1;


  SimQueue_SetLag();
}

/* ---- SimQueue_Reset__Fv  [SIMQUEUE.CPP:115-155] COVERED-SLD-PASS ---- */
#line 113 "C:/nfs4/GAME/COMMON/SIMQUEUE.CPP"
void SimQueue_Reset(void)

{ int i; int j;








  gSimQueue_BlockSelf = 1;
  gSimQueue_BlockOther = 1;

  for (i = 0; i < 2; i = i + 1)
  {
    for (j = 0; j < 0x20; j = j + 1)
    {
      if (j < 4)

        inputQueue.Validity[i][j] = 1;

      else
        inputQueue.Validity[i][j] = 0;

      inputQueue.Buffer[i][j].steering = 0;
      inputQueue.Buffer[i][j].gas = 0;
      inputQueue.Buffer[i][j].brake = 0;
      inputQueue.Buffer[i][j].flags = 0;
    }
    inputQueue.TailTime[i] = 4;
  }
  inputQueue.HeadTime = 0;
  gSimQueue_Ticker = 3;







  gSimQueue_BlockOther = 0;
  gSimQueue_BlockSelf = 0;
}

/* ---- SimQueue_CleanUp__Fv  [SIMQUEUE.CPP:169-174] COVERED-SLD-PASS ---- */
#line 167 "C:/nfs4/GAME/COMMON/SIMQUEUE.CPP"
void SimQueue_CleanUp(void)

{



  gSimQueue_BlockSelf = 1;
  gSimQueue_BlockOther = 1;
}

/* ---- SimQueue_Put__FiP14Input_tResults  [SIMQUEUE.CPP:201-249] COVERED-SLD-PASS ---- */
#line 199 "C:/nfs4/GAME/COMMON/SIMQUEUE.CPP"
int SimQueue_Put(int pIndex,Input_tResults *val)

{ int tail;
  tail = inputQueue.TailTime[pIndex] & 0x1f;







  if (SimQueue_IsBlocking(pIndex) != 0) return 0;





  if (inputQueue.Validity[pIndex][tail] != kINVALID) return 0;

  inputQueue.Buffer[pIndex][tail] = *val;
  inputQueue.Validity[pIndex][tail] = kVALID;






  inputQueue.TailTime[pIndex] = inputQueue.TailTime[pIndex] + 1;



  switch (SIMQUEUE_COMMMODE) {




  case 1: if (pIndex != 0) {
    gSimQueue_Ticker = gSimQueue_Ticker + 1;
  } break;


  case 0: if ((SIMQUEUE_NUM_PLAYER_RACE_CARS < 2) || (pIndex != 0)) {

    gSimQueue_Ticker = gSimQueue_Ticker + 1;
  } break;
  default: break; }




  return 1; }

/* ---- SimQueue_SetCurrentInput__Fi  [SIMQUEUE.CPP:271-290] COVERED-SLD-PASS ---- */
/* Historical compiler-basin receipts are preserved in build/nc12/simqueue_layout_20261027/simqueue-before.cpp. Current selected G8 source matches48 words and all supplied local/SLD facts;the two real for loops need no address helper or output rewrite. */
#line 269 "C:/nfs4/GAME/COMMON/SIMQUEUE.CPP"
void SimQueue_SetCurrentInput(int time)

{ int i; int pIndex;







  for (pIndex = 0, i = time & 0x1f; pIndex < SIMQUEUE_NUM_PLAYER_RACE_CARS; pIndex = pIndex + 1) {

    output[pIndex] = inputQueue.Buffer[pIndex][i];
  }


  for (pIndex = 0; pIndex < SIMQUEUE_NUM_PLAYER_RACE_CARS; pIndex = pIndex + 1) {

    inputQueue.Validity[pIndex][i] = 0;

  }
  inputQueue.HeadTime = inputQueue.HeadTime + 1;
}

/* ---- SimQueue_GetCurrentInput__FiP14Input_tResults  [SIMQUEUE.CPP:295-296] COVERED-SLD-PASS ---- */
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
#line 293 "C:/nfs4/GAME/COMMON/SIMQUEUE.CPP"
void SimQueue_GetCurrentInput(int pIndex,Input_tResults *out)

{
  *out = *(output + pIndex);
}

/* ---- SimQueue_SetLag__Fv  [SIMQUEUE.CPP:326-343] COVERED-SLD-PASS ---- */
#line 324 "C:/nfs4/GAME/COMMON/SIMQUEUE.CPP"
static void SimQueue_SetLag(void)

{
  switch (SIMQUEUE_COMMMODE) {













  case 1: maxTicksPerFrame = 4; break; case 0: maxTicksPerFrame = 4; break;

  default: return; } }

/* ---- SimQueue_IsBlocking__Fi  [SIMQUEUE.CPP:382-407] COVERED-SLD-PASS ---- */ /* 2026-10-27: actual mode case returns remove check_mode/calculate/return_zero labels;all21 words and supplied SYM/SLD fields agree. Literal original spelling remains unproved. Receipt: build/nc12/simqueue_blocking_20261027/. */
#line 380 "C:/nfs4/GAME/COMMON/SIMQUEUE.CPP"
static int SimQueue_IsBlocking(int pIndex)

{

  if (pIndex != 0)
    return 0;

  switch (SIMQUEUE_COMMMODE)
  {









  case 0: if (inputQueue.TailTime[0] >= inputQueue.HeadTime + maxTicksPerFrame)



    return 1; else return 0; case 1: return inputQueue.TailTime[0] >= inputQueue.HeadTime + maxTicksPerFrame;




  default: return 0; } }

/* end of simqueue.cpp */
