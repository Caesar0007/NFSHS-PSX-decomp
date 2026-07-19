/* game/common/anim.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   anim.obj = 18 fns: AnimScript C++ class (3 ctors + SetAnimAttrib/GetAnimFrameInfo/
 *   GetTimedAnimPosRot[x2 overload]/GetStatus) + 10 free Anim_* fns. AnimScript non-virtual
 *   (20 B, declared in nfs4_types.h). Faithful C++: `new AnimScript(..)`, obj->Method(..).
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "anim_externs.h"


/* ---- anim.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
AnimScript   *animSlots[32];   /* @0x8010e14c  (bss(zero)) */
Trk_AnimateInst *Anim_gInstanceFromIndex[32];   /* @0x8010e1cc  (bss(zero)) */
Trk_AnimateInst *animScripts[10];   /* @0x8010e24c  (bss(zero)) */


/* ---- Anim_Restart  [@0x80073a94] ---- */
void Anim_Restart(void)
{
  AnimScript *deleteMe;
  AnimScript **ppAVar1;
  
  /* DISGUISED BARE-VA FIX (w14-a2): -0x7fef1e34 == 0x8010E1CC == &Anim_gInstanceFromIndex[0],
   * which sits directly after animSlots[32] in the data segment -- the real bound is
   * animSlots+32 (sizeof(animSlots)/sizeof(animSlots[0])), materialized as the next symbol's
   * address; verify_asm normalizes %hi/%lo so either symbol name diffs identically. */
  for (ppAVar1 = animSlots; ppAVar1 < animSlots + 32; ppAVar1 = ppAVar1 + 1) {
    deleteMe = *ppAVar1;
    if (deleteMe != (AnimScript *)0x0) {
      if (deleteMe->inst != (Trk_AnimateInst **)0x0) {
        __builtin_vec_delete(deleteMe->inst);
      }
      __builtin_delete(deleteMe);
    }
    *ppAVar1 = (AnimScript *)0x0;
  }
  DrawW_ResetAnimationTimer();
  return;
}

/* ---- Anim_InitSystem  [@0x80073b1c] ---- */
int Anim_InitSystem(char *trackName)
{
  int i;
  char fname[80];
  char*bigFile;
  char*mem;
  int size;
  int numParts;
  Trk_AnimateInst*objInstance;
  int *src;
  void *pThis;
  Trk_AnimateInst *pTVar1;
  int iVar2;
  Trk_AnimateInst **ppTVar3;
  char acStack_68 [80];
  
  Anim_Restart();
  sprintf(acStack_68,"%sA.viv",trackName);
  src = (int *)loadfileadrz(acStack_68,(void *)0x0);
  iVar2 = 9;
  if (src == (int *)0x0) {
    ppTVar3 = animScripts + 9;
    do {
      *ppTVar3 = (Trk_AnimateInst *)0x0;
      iVar2 = iVar2 + -1;
      ppTVar3 = ppTVar3 + -1;
    } while (-1 < iVar2);
  }
  else {
    iVar2 = filesize(acStack_68);
    pThis = 
           Platform_GetDCTBuffer(iVar2,"animScripts");
    blockmove(src,(int *)pThis,iVar2);
    purgememadr(src);
    strstr(trackName,"Tr");
    iVar2 = 0;
    ppTVar3 = animScripts;
    do {
      sprintf(acStack_68,"tr00a%02d.can",iVar2);
      pTVar1 = (Trk_AnimateInst *)locatebig(pThis, acStack_68);   /* locatebig is genuinely 2-arg (locatbig.cpp:178); oracle sets up only a0/a1 before the jal */
      *ppTVar3 = pTVar1;
      iVar2 = iVar2 + 1;
      ppTVar3 = ppTVar3 + 1;
    } while (iVar2 < 10);
  }
  if (gPersistObjInst != (Group *)0x0) {
    iVar2 = gPersistObjInst->m_num_elements;
    pTVar1 = (Trk_AnimateInst *)(gPersistObjInst + 1);
    while (iVar2 = iVar2 + -1, iVar2 != -1) {
      if (((pTVar1->type == '\x03') || (pTVar1->type == '\a')) && (pTVar1->objectIndex != 0)) {
        Anim_gInstanceFromIndex[pTVar1->objectIndex] = pTVar1;
      }
      pTVar1 = (Trk_AnimateInst *)((int)&pTVar1->size + (int)pTVar1->size);
    }
  }
  return 0;
}

/* ---- Anim_DeInitSystem  [@0x80073cb0] ---- */
void Anim_DeInitSystem(void)
{
  int i;
  bool bVar1;
  Trk_AnimateInst **ppTVar2;
  int iVar3;
  
  iVar3 = 9;
  do {
    iVar3 = iVar3 - 1;
  } while (-1 < iVar3);
  iVar3 = 0x1f;
  ppTVar2 = Anim_gInstanceFromIndex;
  ppTVar2 = ppTVar2 + 0x1f;
  do {
    *ppTVar2 = (Trk_AnimateInst *)0x0;
    iVar3 = iVar3 + -1;
    ppTVar2 = ppTVar2 + -1;
  } while (-1 < iVar3);
  return;
}

/* ---- Anim_Handle  [@0x80073ce8] ---- */
int Anim_Handle(int num)
{
  int handle;
  AnimScript *pAVar1;
  int iVar2;
  AnimScript **ppAVar3;
  
  iVar2 = 0;
  ppAVar3 = animSlots;
  do {
    if (*ppAVar3 == (AnimScript *)0x0) break;
    iVar2 = iVar2 + 1;
    ppAVar3 = ppAVar3 + 1;
  } while (iVar2 < 0x20);
  pAVar1 = new AnimScript(num);
  animSlots[iVar2] = pAVar1;
  return iVar2;
}

/* ---- Anim_FreeHandle  [@0x80073d6c] ---- */
int Anim_FreeHandle(int handle)
{
  AnimScript *deleteMe;
  
  deleteMe = animSlots[handle];
  if (deleteMe != (AnimScript *)0x0) {
    if (deleteMe->inst != (Trk_AnimateInst **)0x0) {
      __builtin_vec_delete(deleteMe->inst);
    }
    __builtin_delete(deleteMe);
  }
  animSlots[handle] = (AnimScript *)0x0;
  return 0;
}

/* ---- Anim_GetAnim  [@0x80073dec] ---- */
AnimScript * Anim_GetAnim(int handle)
{
  return animSlots[handle];
}

/* ---- Anim_GetLastRotPos  [@0x80073e08] ---- */
void Anim_GetLastRotPos(Trk_AnimateInst *animInst,coorddef *pt,matrixtdef *mat)
{
  Anim_tFrame*animFrames;
  int animInd;
  tQuat q;
  u_char *puVar1;
  u_int uVar2;
  u_int *puVar3;
  int *piVar4;
  u_int uVar5;
  int iVar6;
  int iVar7;
  tQuat tStack_10;
  
  piVar4 = (int *)((int)animInst + (animInst->count + -1) * 0x14 + 0xc);
  tStack_10 = *(tQuat *)((char *)piVar4 + 0xc);   /* @0x63E30 lastFrame.quat (clean copy) */
  iVar6 = piVar4[1];
  iVar7 = piVar4[2];
  pt->x = *piVar4;
  pt->y = iVar6;
  pt->z = iVar7;
  Quatern_QuatToMat(&tStack_10,mat);
  return;
}

/* ---- Anim_GetLastAnimPosRot  [@0x80073e80] ---- */
int Anim_GetLastAnimPosRot(int animNum,int flags,coorddef *pt,matrixtdef *mat)
{
  int tmp;
  int iVar1;
  int iVar2;
  int iVar3;
  
  Anim_GetLastRotPos(animScripts[animNum],pt,mat);
  if ((flags & 4U) != 0) {
    iVar1 = mat->m[3];
    iVar2 = mat->m[4];
    iVar3 = mat->m[5];
    mat->m[3] = mat->m[6];
    mat->m[6] = -iVar1;
    mat->m[4] = mat->m[7];
    mat->m[7] = -iVar2;
    mat->m[5] = mat->m[8];
    mat->m[8] = -iVar3;
  }
  return 1;
}

/* ---- Anim_GetRotPos  [@0x80073f18] ---- */
int Anim_GetRotPos(Trk_AnimateInst *animInst,int flags,int ticks,coorddef *pt,matrixtdef *mat)
{
  Anim_tFrame*animFrames;
  int animInd0;
  int animInd1;
  coorddef objcp0;
  coorddef objcp1;
  tQuat q;
  int interval;
  u_char *puVar1;
  u_int uVar2;
  u_int *puVar3;
  int iVar4;
  u_char *puVar5;
  int iVar6;
  u_char *puVar7;
  int iVar8;
  Trk_AnimateInst *pTVar9;
  u_int uVar10;
  u_int uVar11;
  u_int uVar12;
  int iVar13;
  coorddef local_40;
  coorddef local_30;
  tQuat tStack_20;
  u_char auStack_18 [8];
  tQuat tStack_10;
  
  if ((animInst->type == '\x03') ||
     (pTVar9 = (Trk_AnimateInst *)&animInst[1].zoffset, animInst->type == '\a')) {
    pTVar9 = animInst + 1;
  }
  if ((u_short)animInst->interval - 1 < 400) {
    iVar6 = (int)animInst->interval;
  }
  else {
    iVar6 = 6;
  }
  iVar13 = ticks / iVar6;
  if (((flags & 2U) == 0) || (iVar4 = 0, iVar13 < animInst->count + -1)) {
    iVar4 = animInst->count + -1;
    iVar8 = ticks % iVar6 << 0x10;
    puVar7 = (u_char *)((iVar13 % iVar4) * 0x14 + (int)pTVar9);
    puVar5 = (u_char *)((iVar13 % iVar4 + 1) * 0x14 + (int)pTVar9);
        *(tQuat *)auStack_18 = *(tQuat *)((char *)puVar7 + 0xc);   /* @0x64088 q0 = frame[idx0].quat */
    tStack_10 = *(tQuat *)((char *)puVar5 + 0xc);              /* @0x640A8 q1 = frame[idx0+1].quat */
    local_40.x = *(int *)puVar7;
    local_40.y = *(int *)(puVar7 + 4);
    local_40.z = *(int *)(puVar7 + 8);
    local_30.x = *(int *)puVar5;
    local_30.y = *(int *)(puVar5 + 4);
    local_30.z = *(int *)(puVar5 + 8);
    Quatern_Interpolate((tQuat *)auStack_18,&tStack_10,&local_40,&local_30,iVar8 / iVar6,&tStack_20,pt);
    Quatern_QuatToMat(&tStack_20,mat);
    iVar4 = 1;
  }
  return iVar4;
}

/* ---- Anim_GetPos  [@0x8007412c] ---- */
int Anim_GetPos(Trk_AnimateInst *animInst,int flags,int ticks,coorddef *pt,int *animTicks,
              int *animLength)
{
  Anim_tFrame*animFrames;
  int animInd0;
  int animInd1;
  coorddef objcp0;
  coorddef objcp1;
  int interval;
  int iVar1;
  int *piVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  coorddef local_38;
  coorddef local_28;
  
  if ((u_short)animInst->interval - 1 < 400) {
    iVar4 = (int)animInst->interval;
  }
  else {
    iVar4 = 6;
  }
  iVar5 = ticks / iVar4;
  if (((flags & 2U) == 0) || (iVar1 = 0, iVar5 < animInst->count + -1)) {
    iVar1 = animInst->count + -1;
    iVar3 = ticks % iVar4 << 0x10;
    piVar2 = (int *)((int)animInst + (iVar5 % iVar1) * 0x14 + 0xc);
    local_38.x = *piVar2;
    local_38.y = piVar2[1];
    local_38.z = piVar2[2];
    piVar2 = (int *)((int)animInst + (iVar5 % iVar1 + 1) * 0x14 + 0xc);
    local_28.x = *piVar2;
    local_28.y = piVar2[1];
    local_28.z = piVar2[2];
    Quatern_VecInterpolate(&local_38,&local_28,iVar3 / iVar4,pt);
    if (animTicks != (int *)0x0) {
      iVar5 = (animInst->count + -1) * iVar4;
      *animTicks = ticks % iVar5;
    }
    iVar1 = 1;
    if (animLength != (int *)0x0) {
      *animLength = (animInst->count + -1) * iVar4;
      iVar1 = 1;
    }
  }
  return iVar1;
}

/* ---- AnimScript::AnimScript  [@0x80074360] ---- */
AnimScript::AnimScript(int num)
{
  int iVar1;
  Trk_AnimateInst **ppTVar2;
  
  ppTVar2 = __builtin_vec_new(4);
  this->inst = ppTVar2;
  *ppTVar2 = animScripts[num];
  iVar1 = simGlobal.gameTicks;
  this->flags = 6;
  this->baseTicks = iVar1;
  return;
}

/* ---- AnimScript::AnimScript  [@0x800743cc] ---- */
AnimScript::AnimScript(int num,int numParts)
{
  int i;
  Trk_AnimateInst **ppTVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  
  ppTVar1 = __builtin_vec_new(numParts << 2);
  iVar4 = 0;
  this->inst = ppTVar1;
  if (0 < numParts) {
    iVar3 = 0;
    do {
      iVar2 = num + iVar4;
      iVar4 = iVar4 + 1;
      *(Trk_AnimateInst **)(iVar3 + (int)this->inst) = animScripts[iVar2];
      iVar3 = iVar4 * 4;
    } while (iVar4 < numParts);
  }
  iVar4 = simGlobal.gameTicks;
  this->flags = 6;
  this->baseTicks = iVar4;
  return;
}

/* ---- AnimScript::AnimScript  [@0x80074468] ---- */
AnimScript::AnimScript(Group *instanceGroup,int type,int boomIndex,int numParts)
{
  int numElems;
  Trk_AnimateBoomInst*objInstance;
  int i;
  int iVar1;
  Trk_AnimateInst **ppTVar2;
  int iVar3;
  Trk_AnimateInst *pTVar4;
  int iVar5;
  
  pTVar4 = (Trk_AnimateInst *)(instanceGroup + 1);
  iVar5 = instanceGroup->m_num_elements;
  ppTVar2 = __builtin_vec_new(numParts << 2);
  this->inst = ppTVar2;
  iVar1 = 0;
  iVar3 = simGlobal.gameTicks;
  while (iVar5 = iVar5 + -1, simGlobal.gameTicks = iVar3, iVar5 != -1) {
    iVar3 = iVar1;
    if (((u_int)pTVar4->type == type) && ((u_int)*(u_char *)((int)&pTVar4[1].size + 1) == boomIndex)) {
      iVar3 = iVar1 + 1;
      this->inst[iVar1] = pTVar4;
    }
    pTVar4 = (Trk_AnimateInst *)((int)&pTVar4->size + (int)pTVar4->size);
    iVar1 = iVar3;
    iVar3 = simGlobal.gameTicks;
  }
  this->flags = 6;
  this->baseTicks = iVar3;
  return;
}

/* ---- AnimScript::SetAnimAttrib  [@0x80074534] ---- */
void AnimScript::SetAnimAttrib(int flags)
{
  this->flags = flags;
  return;
}

/* ---- AnimScript::GetAnimFrameInfo  [@0x8007453c] ---- */
void AnimScript::GetAnimFrameInfo(int *frame,int *numFrames)
{
  Trk_AnimateInst*animInst;
  int interval;
  int ticks;
  int iVar1;
  int iVar2;
  Trk_AnimateInst *pTVar3;
  int iVar4;
  
  pTVar3 = *this->inst;
  iVar2 = simGlobal.gameTicks - this->baseTicks;
  if ((u_short)pTVar3->interval - 1 < 400) {
    iVar1 = (int)pTVar3->interval;
  }
  else {
    iVar1 = 6;
  }
  iVar4 = iVar2 / iVar1;
  iVar2 = pTVar3->count + -1;
  *frame = iVar4 % iVar2;
  *numFrames = pTVar3->count + -1;
  return;
}

/* ---- AnimScript::GetTimedAnimPosRot  [@0x800745f8] ---- */
int AnimScript::GetTimedAnimPosRot(coorddef *pt,matrixtdef *mat)
{
  int iVar1;
  
  iVar1 = this->GetTimedAnimPosRot(0,pt,mat);
  return iVar1;
}

/* ---- AnimScript::GetTimedAnimPosRot  [@0x80074624] ---- */
int AnimScript::GetTimedAnimPosRot(int index,coorddef *pt,matrixtdef *mat)
{
  int tmp;
  int iVar1;
  int iVar2;
  int iVar3;
  
  iVar1 = this->GetStatus();
  iVar2 = -1;
  if (iVar1 == 1) {
    iVar1 = Anim_GetRotPos(this->inst[index],this->flags,simGlobal.gameTicks - this->baseTicks,pt,mat);
    iVar2 = 0;
    if (iVar1 == 0) {
      this->baseTicks = -1;
      this->inst[index] = (Trk_AnimateInst *)0x0;
    }
    else {
      iVar2 = 1;
      if ((this->flags & 4U) != 0) {
        iVar1 = mat->m[3];
        iVar2 = mat->m[4];
        iVar3 = mat->m[5];
        mat->m[3] = mat->m[6];
        mat->m[6] = -iVar1;
        mat->m[4] = mat->m[7];
        mat->m[7] = -iVar2;
        mat->m[5] = mat->m[8];
        mat->m[8] = -iVar3;
        iVar2 = 1;
      }
    }
  }
  return iVar2;
}

/* ---- AnimScript::GetStatus  [@0x8007471c] ---- */
int AnimScript::GetStatus()
{
  return (u_int)(*this->inst != (Trk_AnimateInst *)0x0);
}
