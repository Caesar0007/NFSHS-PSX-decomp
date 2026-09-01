/* game/common/anim.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   anim.obj = 18 fns: AnimScript C++ class (3 ctors + SetAnimAttrib/GetAnimFrameInfo/
 *   GetTimedAnimPosRot[x2 overload]/GetStatus) + 10 free Anim_* fns. AnimScript non-virtual
 *   (20 B, declared in nfs4_types.h). Faithful C++: `new AnimScript(..)`, obj->Method(..).
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "anim_types.h"
#include "anim_externs.h"


/* ---- anim.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
AnimScript   *animSlots[32];   /* @0x8010e14c  (bss(zero)) */
Trk_AnimateInst *Anim_gInstanceFromIndex[32];   /* @0x8010e1cc  (bss(zero)) */
Trk_AnimateInst *animScripts[10];   /* @0x8010e24c  (bss(zero)) */


/* ---- Anim_Restart  [@0x80073a94] ---- */
void Anim_Restart(void)
{
  AnimScript *deleteMe;
  AnimScript **p;
  AnimScript **pEnd;

  p = animSlots;
  pEnd = animSlots + 32;
AnimRestart_Test:
  if (!((int)p < (int)pEnd)) goto AnimRestart_End;
  deleteMe = *p;
  if (deleteMe != (AnimScript *)0x0) {
    if (deleteMe->inst != (Trk_AnimateInst **)0x0) {
      __builtin_vec_delete(deleteMe->inst);
    }
    __builtin_delete(deleteMe);
  }
  *p = (AnimScript *)0x0;
  p = p + 1;
  goto AnimRestart_Test;
AnimRestart_End:;
  DrawW_ResetAnimationTimer();
  return;
}

/* ---- Anim_InitSystem  [@0x80073b1c] ---- */
int Anim_InitSystem(char *trackName)
{
  int i;
  char fname[80];
  char *bigFile;

  Anim_Restart();
  sprintf(fname,"%sA.viv",trackName);
  bigFile = (char *)loadfileadrz(fname,(void *)0x0);
  i = 9;
  if (bigFile != (char *)0x0) {
    int size = filesize(fname);
    char *mem = (char *)Platform_GetDCTBuffer(size,"animScripts");

    blockmove((int *)bigFile,(int *)mem,size);
    purgememadr(bigFile);
    strstr(trackName,"Tr");
    for (i = 0; i < 10; i++) {
      sprintf(fname,"tr00a%02d.can",i);
      animScripts[i] = (Trk_AnimateInst *)locatebig(mem,fname);
    }
  }
  else {
    for (; 0 <= i; i--) {
      animScripts[i] = (Trk_AnimateInst *)0x0;
    }
  }
  if (gPersistObjInst != (Group *)0x0) {
    int numParts = gPersistObjInst->m_num_elements;
    Trk_AnimateInst *objInstance = (Trk_AnimateInst *)(gPersistObjInst + 1);

    while (--numParts != -1) {
        if (((objInstance->type == '\x03') || (objInstance->type == '\a')) &&
            (objInstance->objectIndex != 0)) {
          Anim_gInstanceFromIndex[objInstance->objectIndex] = objInstance;
        }
        objInstance = (Trk_AnimateInst *)((int)&objInstance->size +
                                          (int)objInstance->size);
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

  handle = 0;
  while ((handle < 0x20) && (animSlots[handle] != (AnimScript *)0x0)) {
    handle = handle + 1;
  }
  animSlots[handle] = new AnimScript(num);
  return handle;
}

/* ---- Anim_FreeHandle  [@0x80073d6c] ---- */
int Anim_FreeHandle(int handle)
{
  /* SYM-CODEGEN-CARRIER: deleteMe -- SYM records no named local, but direct
   * repeated animSlots[handle] expressions compile to 33 instructions and 19
   * oracle diffs.  Retaining the loaded pointer produces the exact 32-
   * instruction body and the retail saved-register/base-address schedule. */
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
  Anim_tFrame *animFrames;
  int animInd;
  tQuat q;

  animFrames = (Anim_tFrame *)((char *)animInst + 0xc);
  animInd = animInst->count - 1;
  q = *(tQuat *)&animFrames[animInd].qx;
  *pt = *(coorddef *)&animFrames[animInd].x;
  Quatern_QuatToMat(&q,mat);
  return;
}

/* ---- Anim_GetLastAnimPosRot  [@0x80073e80] ---- */
int Anim_GetLastAnimPosRot(int animNum,int flags,coorddef *pt,matrixtdef *mat)
{
  Anim_GetLastRotPos(animScripts[animNum],pt,mat);
  if ((flags & 4U) != 0) {
    int tmp;

    tmp = mat->m[3];
    mat->m[3] = mat->m[6];
    mat->m[6] = -tmp;
    tmp = mat->m[4];
    mat->m[4] = mat->m[7];
    mat->m[7] = -tmp;
    tmp = mat->m[5];
    mat->m[5] = mat->m[8];
    mat->m[8] = -tmp;
  }
  return 1;
}

/* ---- Anim_GetRotPos  [@0x80073f18] ---- */
int Anim_GetRotPos(Trk_AnimateInst *animInst,int flags,int ticks,coorddef *pt,matrixtdef *mat)
{
  Anim_tFrame *animFrames;
  int animInd0;
  int animInd1;
  coorddef objcp0;
  coorddef objcp1;
  tQuat q;
  tQuat q0;
  tQuat q1;
  int interval;

  if ((animInst->type == '\x03') || (animInst->type == '\a')) {
    animFrames = (Anim_tFrame *)((char *)animInst + 0xc);
  }
  else {
    animFrames = (Anim_tFrame *)((char *)animInst + 0x10);
  }
  if ((u_int)((u_short)animInst->interval - 1) < 400) {
    interval = (int)animInst->interval;
  }
  else {
    interval = 6;
  }
  flags &= 2;
  animInd0 = ticks / interval;
  if ((flags != 0) && (animInst->count - 1 <= animInd0)) {
    return 0;
  }
  animInd0 %= animInst->count - 1;
  animInd1 = animInd0 + 1;
  q0 = *(tQuat *)&animFrames[animInd0].qx;
  q1 = *(tQuat *)&animFrames[animInd1].qx;
  objcp0 = *(coorddef *)&animFrames[animInd0];
  objcp1 = *(coorddef *)&animFrames[animInd1];
  Quatern_Interpolate(&q0,&q1,&objcp0,&objcp1,
                      ((ticks % interval) << 0x10) / interval,&q,pt);
  Quatern_QuatToMat(&q,mat);
  return 1;
}

/* ---- Anim_GetPos  [@0x8007412c] ---- */
int Anim_GetPos(Trk_AnimateInst *animInst,int flags,int ticks,coorddef *pt,int *animTicks,
              int *animLength)
{
  Anim_tFrame *animFrames;
  int animInd0;
  int animInd1;
  coorddef objcp0;
  coorddef objcp1;
  int interval;

  animFrames = (Anim_tFrame *)((char *)animInst + 0xc);
  if ((u_int)((u_short)animInst->interval - 1) < 400) {
    interval = (int)animInst->interval;
  }
  else {
    interval = 6;
  }
  flags &= 2;
  animInd0 = ticks / interval;
  if ((flags != 0) && (animInst->count - 1 <= animInd0)) {
    return 0;
  }
  animInd0 %= animInst->count - 1;
  animInd1 = animInd0 + 1;
  objcp0 = *(coorddef *)&animFrames[animInd0];
  objcp1 = *(coorddef *)&animFrames[animInd1];
  Quatern_VecInterpolate(&objcp0,&objcp1,
                         ((ticks % interval) << 0x10) / interval,pt);
  if (animTicks != (int *)0x0) {
    *animTicks = ticks % ((animInst->count - 1) * interval);
  }
  if (animLength != (int *)0x0) {
    *animLength = (animInst->count - 1) * interval;
  }
  return 1;
}

/* ---- AnimScript::AnimScript  [@0x80074360] ---- */
AnimScript::AnimScript(int num)
{
  /* SYM-CODEGEN-CARRIER: iVar1 -- assigning Anim_simGlobalWords[1] directly
   * to baseTicks keeps 27 instructions but produces 26 oracle diffs. */
  int iVar1;

  this->inst = __builtin_vec_new(4);
  *this->inst = animScripts[num];
  iVar1 = Anim_simGlobalWords[1];
  this->flags = 6;
  this->baseTicks = iVar1;
  return;
}

/* ---- AnimScript::AnimScript  [@0x800743cc] ---- */
AnimScript::AnimScript(int num,int numParts)
{
  /* SYM-CODEGEN-CARRIER: ppTVar1 -- assigning __builtin_vec_new directly to
   * inst grows the function from 39 to 41 instructions with 44 oracle diffs. */
  Trk_AnimateInst **ppTVar1;
  /* SYM-CODEGEN-CARRIER: iVar2 -- assigning Anim_simGlobalWords[1] directly
   * to baseTicks keeps 39 instructions but produces 10 oracle diffs. */
  int iVar2;
  int i;

  ppTVar1 = __builtin_vec_new(numParts << 2);
  i = 0;
  this->inst = ppTVar1;
  if (0 < numParts) {
    do {
      this->inst[i] = animScripts[num + i];
      i = i + 1;
    } while (i < numParts);
  }
  iVar2 = Anim_simGlobalWords[1];
  this->flags = 6;
  this->baseTicks = iVar2;
  return;
}

/* ---- AnimScript::AnimScript  [@0x80074468] ---- */
AnimScript::AnimScript(Group *instanceGroup,int type,int boomIndex,int numParts)
{
  int i;
  /* SYM-CODEGEN-CARRIER: iVar3 -- assigning Anim_simGlobalWords[1] directly
   * to baseTicks keeps 51 instructions but produces 10 oracle diffs. */
  int iVar3;
  Trk_AnimateBoomInst *objInstance;
  int numElems;

  objInstance = (Trk_AnimateBoomInst *)(instanceGroup + 1);
  numElems = instanceGroup->m_num_elements;
  this->inst = __builtin_vec_new(numParts << 2);
  i = 0;
  numElems = numElems - 1;
  if (numElems != -1) {
    do {
      if (((u_int)objInstance->type == type) && ((u_int)objInstance->boomIndex == boomIndex)) {
        this->inst[i] = (Trk_AnimateInst *)objInstance;
        i = i + 1;
      }
      objInstance = (Trk_AnimateBoomInst *)((int)&objInstance->size + (int)objInstance->size);
      numElems = numElems - 1;
    } while (numElems != -1);
  }
  iVar3 = Anim_simGlobalWords[1];
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
  Trk_AnimateInst *animInst;
  int interval;
  int ticks;

  ticks = Anim_simGlobalWords[1] - this->baseTicks;
  animInst = *this->inst;
  if ((u_int)((u_short)animInst->interval - 1) < 400) {
    interval = (int)animInst->interval;
  }
  else {
    interval = 6;
  }
  *frame = (ticks / interval) % (animInst->count - 1);
  *numFrames = animInst->count - 1;
  return;
}

/* ---- AnimScript::GetTimedAnimPosRot  [@0x800745f8] ---- */
int AnimScript::GetTimedAnimPosRot(coorddef *pt,matrixtdef *mat)
{
  return this->GetTimedAnimPosRot(0,pt,mat);
}

/* ---- AnimScript::GetTimedAnimPosRot  [@0x80074624] ---- */
int AnimScript::GetTimedAnimPosRot(int index,coorddef *pt,matrixtdef *mat)
{
  int tmp;

  if (this->GetStatus() != 1) {
    return -1;
  }
  tmp = Anim_simGlobalWords[1] - this->baseTicks;
  if (Anim_GetRotPos(this->inst[index],this->flags,tmp,pt,mat) == 0) {
    this->baseTicks = -1;
    this->inst[index] = (Trk_AnimateInst *)0x0;
    return 0;
  }
  if ((this->flags & 4U) != 0) {
    tmp = mat->m[3];
    mat->m[3] = mat->m[6];
    mat->m[6] = -tmp;
    tmp = mat->m[4];
    mat->m[4] = mat->m[7];
    mat->m[7] = -tmp;
    tmp = mat->m[5];
    mat->m[5] = mat->m[8];
    mat->m[8] = -tmp;
  }
  return 1;
}

/* ---- AnimScript::GetStatus  [@0x8007471c] ---- */
int AnimScript::GetStatus()
{
  return (u_int)(*this->inst != (Trk_AnimateInst *)0x0);
}
