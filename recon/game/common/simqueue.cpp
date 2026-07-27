/* game/psx/simqueue.cpp -- RECONSTRUCTED (NFS4 PSX sim input queue; C++ TU)
 *   8 fns: SimQueue_StartUp/Reset/CleanUp/Put/SetCurrentInput/GetCurrentInput/SetLag/IsBlocking.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "simqueue_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
int gSimQueue_BlockOther;
int gSimQueue_BlockSelf;
int gSimQueue_Ticker;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void SimQueue_StartUp(void);
void SimQueue_Reset(void);
void SimQueue_CleanUp(void);
int SimQueue_Put(int pIndex,Input_tResults *val);
void SimQueue_SetCurrentInput(int time);
void SimQueue_GetCurrentInput(int pIndex,Input_tResults *out);
void SimQueue_SetLag(void);
int SimQueue_IsBlocking(int pIndex);


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
  u_int uVar6;
  int iVar4;
  u_char *entry;

  uVar6 = inputQueue.TailTime[pIndex] & 0x1f;
  iVar4 = SimQueue_IsBlocking(pIndex);
  if (iVar4 != 0) {
    return 0;
  }
  entry = (u_char *)&inputQueue + (uVar6 * 4 + pIndex * 0x80);
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
void SimQueue_SetCurrentInput(int time)

{
  int pIndex;
  int iVar4;
  int iVar5;
  int masked;
  Input_tResults *pIVar6;

  pIndex = 0;
  masked = time & 0x1fU;
  if (0 < GameSetup_gData.numPlayerRaceCars) {
    pIVar6 = output;
    iVar5 = masked << 2;
    do {
      *pIVar6 = *(Input_tResults *)((u_char *)&inputQueue + iVar5);
      pIVar6 = pIVar6 + 1;
      iVar5 = iVar5 + 0x80;
    } while (++pIndex < GameSetup_gData.numPlayerRaceCars);
  }
  if (0 < GameSetup_gData.numPlayerRaceCars) {
    pIndex = 0;
    iVar4 = masked << 2;
    do {
      inputQueue.Validity[pIndex][masked] = 0;
      iVar4 = iVar4 + 0x80;
    } while (++pIndex < GameSetup_gData.numPlayerRaceCars);
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
void SimQueue_SetLag(void)

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
int SimQueue_IsBlocking(int pIndex)

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

/* owning-TU def (extern-declared, never defined; link-harness) */
int maxTicksPerFrame;
