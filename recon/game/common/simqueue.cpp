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
  int iVar1;
  int j;
  int iVar2;
  int iVar3;
  int i;
  SIM_QUEUE *pSVar4;
  
  iVar3 = 0;
  pSVar4 = &inputQueue;
  do {
    iVar2 = 0;
    iVar1 = iVar3 << 7;
    do {
      if (iVar2 < 4) {
        *(u_int *)((int)inputQueue.Validity[0] + iVar1) = 1;
      }
      else {
        *(u_int *)((int)inputQueue.Validity[0] + iVar1) = 0;
      }
      iVar2 = iVar2 + 1;
      (&inputQueue.Buffer[0][0].steering)[iVar1] = '\0';
      (&inputQueue.Buffer[0][0].gas)[iVar1] = '\0';
      (&inputQueue.Buffer[0][0].brake)[iVar1] = '\0';
      (&inputQueue.Buffer[0][0].flags)[iVar1] = '\0';
      iVar1 = iVar1 + 4;
    } while (iVar2 < 0x20);
    pSVar4->TailTime[0] = 4;
    pSVar4 = (SIM_QUEUE *)(pSVar4->Buffer[0] + 1);
    iVar3 = iVar3 + 1;
  } while (iVar3 < 2);
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
  u_int uVar1;
  u_int uVar2;
  u_int *puVar3;
  int iVar4;
  u_int lwlBits;
  Input_tResults IVar5;
  int tail;
  u_int uVar6;
  
  uVar6 = inputQueue.TailTime[pIndex] & 0x1f;
  iVar4 = SimQueue_IsBlocking(pIndex);
  if (iVar4 != 0) {
    return 0;
  }
  if (inputQueue.Validity[pIndex * 0x10][uVar6] != kINVALID) {
    return 0;
  }
  uVar1 = (u_int)&val->flags & 3;
  uVar2 = (u_int)val & 3;
  *(u_int *)&IVar5 =
          ((*(int *)(&val->flags + -uVar1) << (3 - uVar1) * 8 |
           lwlBits & 0xffffffffU >> (uVar1 + 1) * 8) & -1 << (4 - uVar2) * 8 |
          *(u_int *)((int)val - uVar2) >> uVar2 * 8);
  uVar1 = uVar6 * 4 + pIndex * 0x80 + ((u_int)&inputQueue + 3);   /* @0x8013e0f7 = (u_int)&inputQueue + 3 (Ghidra-flattened unaligned packed store into inputQueue) */
  uVar2 = uVar1 & 3;
  puVar3 = (u_int *)(uVar1 - uVar2);
  *puVar3 = *puVar3 & -1 << (uVar2 + 1) * 8 | (*(u_int *)&IVar5) >> (3 - uVar2) * 8;
  inputQueue.Buffer[pIndex * 0x10][uVar6] = IVar5;
  inputQueue.Validity[pIndex * 0x10][uVar6] = kVALID;
  inputQueue.TailTime[pIndex] = inputQueue.TailTime[pIndex] + 1;
  if (GameSetup_gData.commMode == 0) {
    if ((1 < GameSetup_gData.numPlayerRaceCars) && (pIndex == 0)) {
      return 1;
    }
  }
  else {
    if (GameSetup_gData.commMode != 1) {
      return 1;
    }
    if (pIndex == 0) {
      return 1;
    }
  }
  gSimQueue_Ticker = gSimQueue_Ticker + 1;
  return 1;
}

/* ---- SimQueue_SetCurrentInput__Fi  [SIMQUEUE.CPP:271-290] SLD-VERIFIED ---- */
void SimQueue_SetCurrentInput(int time)

{
  Input_tResults IVar1;
  u_int uVar2;
  u_char *puVar3;
  int pIndex;
  int i;
  int iVar4;
  int iVar5;
  Input_tResults *pIVar6;
  
  pIndex = 0;
  if (0 < GameSetup_gData.numPlayerRaceCars) {
    pIVar6 = output;
    iVar5 = (time & 0x1fU) << 2;
    do {
      IVar1 = *(Input_tResults *)(&inputQueue.Buffer[0][0].steering + iVar5);
      uVar2 = (u_int)&pIVar6->flags & 3;
      puVar3 = &pIVar6->flags + -uVar2;
      *(u_int *)puVar3 = *(u_int *)puVar3 & -1 << (uVar2 + 1) * 8 | (*(u_int *)&IVar1) >> (3 - uVar2) * 8;
      *pIVar6 = IVar1;
      pIVar6 = pIVar6 + 1;
      pIndex = pIndex + 1;
      iVar5 = iVar5 + 0x80;
    } while (pIndex < GameSetup_gData.numPlayerRaceCars);
  }
  iVar5 = 0;
  if (0 < GameSetup_gData.numPlayerRaceCars) {
    iVar4 = (time & 0x1fU) << 2;
    do {
      *(u_int *)((int)inputQueue.Validity[0] + iVar4) = 0;
      iVar5 = iVar5 + 1;
      iVar4 = iVar4 + 0x80;
    } while (iVar5 < GameSetup_gData.numPlayerRaceCars);
  }
  inputQueue.HeadTime = inputQueue.HeadTime + 1;
  return;
}

/* ---- SimQueue_GetCurrentInput__FiP14Input_tResults  [SIMQUEUE.CPP:295-407] SLD-VERIFIED ---- */
void SimQueue_GetCurrentInput(int pIndex,Input_tResults *out)

{
  Input_tResults IVar1;
  u_int uVar2;
  u_char *puVar3;
  
  IVar1 = output[pIndex];
  uVar2 = (u_int)&out->flags & 3;
  puVar3 = &out->flags + -uVar2;
  *(u_int *)puVar3 = *(u_int *)puVar3 & -1 << (uVar2 + 1) * 8 | (*(u_int *)&IVar1) >> (3 - uVar2) * 8;
  uVar2 = (u_int)out & 3;
  *(u_int *)((int)out - uVar2) =
       *(u_int *)((int)out - uVar2) & 0xffffffffU >> (4 - uVar2) * 8 | (*(int *)&IVar1) << uVar2 * 8;
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
  int i;
  int tail;
  
  if (pIndex != 0) {
    return 0;
  }
  if ((GameSetup_gData.commMode != 0) && (GameSetup_gData.commMode != 1)) {
    return 0;
  }
  return inputQueue.TailTime[0] < inputQueue.HeadTime + maxTicksPerFrame ^ 1;
}

/* end of simqueue.cpp */

/* owning-TU def (extern-declared, never defined; link-harness) */
int maxTicksPerFrame;
