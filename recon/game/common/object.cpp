/* game/common/object.cpp -- RECONSTRUCTED (track-object collision + custom-object pool +
 *   IMass scene props + ObjectMultiAnim/SignAnim animation classes; C++ TU, 36 fns).
 *   4 anim classes (: ObjectAnim) emitted as free fns (Class_ct/_dt/_Class_Draw) per
 *   track.obj convention (ctors explicitly called on __builtin_new memory).
 */
#include "object_types.h"
#include "object_externs.h"


/* EXT/STAT data OWNED by object.obj */
AnimDef gAnimDefs[14] = {
  {0, 1, -1, 2, 0},
  {1, 10, 0, 0, 1},
  {1, 20, 0, 0, 1},
  {1, 6, 0, 0, 1},
  {1, 2, 0, 0, 1},
  {1, 1, 0, 0, 1},
  {1, 10, 0, 0, 1},
  {1, 14, 0, 0, 1},
  {1, 5, 0, 0, 1},
  {1, 5, 0, 0, 1},
  {1, 1, 0, 0, 1},
  {1, 8, 0, 0, 1},
  {0, 1, -1, 2, 0},
  {0, 1, -1, 2, 0}
};   /* @0x80115c48; SYM EXT AnimDef[14] */
Group              *Object_customObjInst;   /* 0x8013d2c8 */
Group              *Object_customSimObjs;   /* 0x8013d2cc */
Group              *Object_customSFXInst;   /* 0x8013d2d0 */
int                 Object_customSliceNum;  /* 0x8013d2d4 */
ObjectAnim         *gSimObjAnims[450];
int                 gNumIMassObjects;
Object_tIMassObjInfo *Object_IMassObjInst;

/* ---- forward decls (VA-order) ---- */
int CalcObjYawAngle(CCOORD16 *pts);
void CalcObjExtentPoints(coorddef *cp,CCOORD16 *pts,coorddef *resultPts,tQuat *quat);
void BuildObjCollisionMatrix(int weight,int objAngle,int impactAngle,matrixtdef *mat);
Trk_SimpleInst * FindObjInstanceFromSerialNum(Group *group,int index);
void Object_InitCollisionCheckLoop(BWorldSm_Pos *slicePos,Object_tSimObjList *objList,int *numObj);
Trk_SimObject * GetSimObj(int objIndex,Object_tSimObjList *objList,int *chunk);
int Object_GetRadiusCollisionData(Object_tSimObjList *objList,int objIndex,coorddef *pos,int *radius);
void Object_GetPointsCollisionData(Object_tSimObjList *objList,int objIndex,int *numPoints,coorddef *resultPoints);
void Object_InitStatus(void);
void Object_KillStatus(void);
ObjectAnim * Object_GetAnim(Trk_SimObject *simObj);
int Object_CheckCollisionResults(Object_tSimObjList *objList,int objIndex,BO_tNewtonObj *N);
void Object_InitCustomObjects(void);
void Object_DeInitCustomObjects(void);
void Object_ClearCustomObjects(void);
void SetCautionSurface(coorddef *pt,BWorldSm_Pos *slicePos);
int Object_AddCustomSimObject(SceneElem *objectData,int serialNum,int instIndex);
int Object_GetObjDefID(int index);
int Object_FindDefWithThisID(int ID);
void Object_AddCustomObject(SceneElem *objectData,int setupSimDataFlag);
void GetObjMaxDimensions(Trk_ObjectDef **pObjDefs,Trk_SimpleInst *objInstance,coorddef *dimensions);
void Object_InitIMassObjectInfo(void);
void Object_DeInitIMassObjectInfo(void);
int Object_GetNumIMassObjects(void);
void Object_GetIMassObjectDimensions(int objIndex,coorddef *dimensions);
void Object_GetIMassObjectMotion(int objIndex,coorddef *cpoint,matrixtdef *orientMat,coorddef *velocity);
extern "C" void ___14ObjectSignAnim(ObjectSignAnim *pThis,int __in_chrg);
extern "C" void ___22ObjectFinishedSignAnim(ObjectFinishedSignAnim *pThis,int __in_chrg);
extern "C" void ___15ObjectMultiAnim(ObjectMultiAnim *pThis,int __in_chrg);
extern "C" void ___23ObjectFinishedMultiAnim(ObjectFinishedMultiAnim *pThis,int __in_chrg);

/* ---- CalcObjYawAngle  [OBJECT.CPP:69-74] SLD-VERIFIED ---- */


int CalcObjYawAngle(CCOORD16 *pts)

{
  int angle;
  
  angle = fixedatan((int)pts[1].x - (int)pts->x,(int)pts[1].z - (int)pts->z);
  return angle + -0x4000 >> 8;
}



/* ---- CalcObjExtentPoints  [OBJECT.CPP:78-98] SLD-VERIFIED ---- */
void CalcObjExtentPoints(coorddef *cp,CCOORD16 *pts,coorddef *resultPts,tQuat *quat)

{
  int tmpx;
  int cpx;
  int cpz;
  matrixtdef matrix;
  coorddef pt0;
  coorddef pt1;

  cpx = cp->x;
  cpz = cp->z;
  pt0.x = (int)pts->x << 10;
  pt0.z = (int)pts->z << 10;
  pt1.x = (int)pts[1].x << 10;
  pt1.z = (int)pts[1].z << 10;
  resultPts->x = cpx;
  resultPts->z = cpz;
  Quatern_QuatToMat(quat,&matrix);
  transform(&pt0.x,matrix.m,&resultPts[1].x);
  transform(&pt1.x,matrix.m,&resultPts[2].x);
  resultPts[1].x = resultPts[1].x + cpx;
  tmpx = resultPts[2].x;
  resultPts[1].z = resultPts[1].z + cpz;
  resultPts[2].x = tmpx + cpx;
  resultPts[2].z = resultPts[2].z + cpz;
  return;
}

/* ---- BuildObjCollisionMatrix  [OBJECT.CPP:121-140] SLD-VERIFIED ---- */


void BuildObjCollisionMatrix(int weight,int objAngle,int impactAngle,matrixtdef *mat)

{
  int impactComp;
  int objComp;
  matrixtdef impactMat;
  matrixtdef objAngleMat;
  matrixtdef tmpMat;
  
  impactComp = fixedmult(-impactAngle,0x10000 - weight);
  objComp = fixedmult(-objAngle,weight);
  fixedxformy(&objAngleMat,impactComp + objComp);
  fixedxformy(&impactMat,impactAngle);
  Math_fasttransmult(&objAngleMat,mat,&tmpMat);
  Math_fasttransmult(&tmpMat,&impactMat,mat);
  return;
}



/* ---- FindObjInstanceFromSerialNum  [OBJECT.CPP:144-176] SLD-VERIFIED ---- */


Trk_SimpleInst *
FindObjInstanceFromSerialNum(Group *group,int index)

{
  Trk_SimpleInst *objInstance;

  if ((u_int)(index - 126) < 2) {
    return (Trk_SimpleInst *)0x0;
  }
  if ((index & 0x80) != 0) {
    group = Object_customObjInst;
    index &= ~0x80;
    if (index < group->m_num_elements) {
      goto valid_index;
    }
  }
  else {
    if (index < group->m_num_elements) {
      goto valid_index;
    }
  }
  return (Trk_SimpleInst *)0x0;
valid_index:
  objInstance = (Trk_SimpleInst *)(group + 1);
  while (index-- != 0) {
    objInstance = (Trk_SimpleInst *)((char *)objInstance + objInstance->size);
  }
  return objInstance;
}



/* ---- Object_InitCollisionCheckLoop  [OBJECT.CPP:190-243] SLD-VERIFIED ---- */
void Object_InitCollisionCheckLoop(BWorldSm_Pos *slicePos,Object_tSimObjList *objList,int *numObj)

{
  int altChunk;
  Object_SliceCodegenView *altSlice;

  if (Track_chunkList[slicePos->chunk].simObjBuf != (Group *)0x0) {
    objList->numObjects = Track_chunkList[slicePos->chunk].simObjBuf->m_num_elements;
  } else {
    objList->numObjects = 0;
  }
  objList->chunk = (int)slicePos->chunk;
  objList->numObjects2 = 0;
  altChunk = slicePos->slice + 1;
  if (altChunk < gNumSlices) {
    altSlice = BWorldSm_slices + altChunk;
    altChunk = (int)altSlice->chunkIndex;
  } else {
    altSlice = BWorldSm_slices + (slicePos->slice - (gNumSlices - 1));
    altChunk = (int)altSlice->chunkIndex;
  }
  if ((altChunk != slicePos->chunk) &&
      (Track_chunkList[altChunk].simObjBuf != (Group *)0x0)) {
    objList->numObjects2 = Track_chunkList[altChunk].simObjBuf->m_num_elements;
    objList->chunk2 = altChunk;
    *numObj = objList->numObjects + objList->numObjects2;
  } else {
    altChunk = (int)BWorldSm_slices[
        (slicePos->slice - 1 < 0)
            /* MATCH: WRAP-ARM = the STEPPED value first, wrap term last.  `slice - 1 + gNumSlices`
             * reassociates to the oracle's `addiu G,-1; addu slice,G-1`; `slice + gNumSlices - 1`
             * emits addu-then-addiu, and `slice + (gNumSlices - 1)` lets cse steal the condition's
             * own `slice-1` (=> `(slice-1)+G`, +2 insns).  Mirrors line 202's `(slice+1) - gNumSlices`. */
            ? slicePos->slice - 1 + gNumSlices
            : slicePos->slice - 1].chunkIndex;
    if ((altChunk != slicePos->chunk) &&
        (Track_chunkList[altChunk].simObjBuf != (Group *)0x0)) {
      objList->numObjects2 = Track_chunkList[altChunk].simObjBuf->m_num_elements;
      objList->chunk2 = altChunk;
      *numObj = objList->numObjects + objList->numObjects2;
    } else {
      *numObj = objList->numObjects;
    }
  }
  if (Object_customSimObjs != (Group *)0x0) {
    if (0 < Object_customSimObjs->m_num_elements) {
      if (Math_DistXZ((coorddef *)(BWorldSm_slices + Object_customSliceNum),
                      (coorddef *)(BWorldSm_slices + slicePos->slice)) <= 0xbfffff) {
        *numObj = *numObj + Object_customSimObjs->GetNumElements();
      }
    }
  }
  return;
}

/* ---- GetSimObj  [OBJECT.CPP:256-290] SLD-VERIFIED ---- */


Trk_SimObject *
GetSimObj(int objIndex,Object_tSimObjList *objList,int *chunk)

{
  Trk_SimObject *simObj;
  int index;

  index = objIndex;
  simObj = (Trk_SimObject *)0x0;
  if (index >= objList->numObjects + objList->numObjects2) {
    index = index - objList->numObjects - objList->numObjects2;
    simObj = (Trk_SimObject *)(Object_customSimObjs + 1);
    *chunk = -1;
    return simObj + index;
  }
  *chunk = objList->chunk;
  if (objList->numObjects <= index) {
    index = index - objList->numObjects;
    *chunk = objList->chunk2;
  }
  if (Track_chunkList[*chunk].simObjBuf != (Group *)0x0) {
    simObj = (Trk_SimObject *)(Track_chunkList[*chunk].simObjBuf + 1);
    simObj += index;
    if (simObj->type == '\x10') {
      simObj = (Trk_SimObject *)0x0;
    }
  }
  return simObj;
}



/* ---- Object_GetRadiusCollisionData  [OBJECT.CPP:304-330] SLD-VERIFIED ---- */


int Object_GetRadiusCollisionData(Object_tSimObjList *objList,int objIndex,coorddef *pos,int *radius)

{
  Trk_SimObject *simObj;
  int chunk;
  
  simObj = GetSimObj(objIndex,objList,&chunk);
  if (simObj != (Trk_SimObject *)0x0) {
    if (((simObj->type & 0x80) != 0) && (gSimObjAnims[simObj->serialNum] == (ObjectAnim *)0x0)) {
      int dummy;
      Chunk *pMChunk;

      pMChunk = Track_chunkList + chunk;
      Anim_GetPos((Trk_AnimateInst *)
                      FindObjInstanceFromSerialNum(pMChunk->objInstanceBuf,
                                                   (u_int)simObj->instIndex),
                  1,simGlobal.gameTicks,(coorddef *)simObj,&dummy,&dummy);
    }
    *pos = *(coorddef *)simObj;
    *radius = (int)simObj->radius << 7;
  }
  else {
    *radius = 0;
  }
  return 0;
}



/* ---- Object_GetPointsCollisionData  [OBJECT.CPP:336-381] SLD-VERIFIED ---- */


void Object_GetPointsCollisionData(Object_tSimObjList *objList,int objIndex,int *numPoints,coorddef *resultPoints)

{
  Trk_SimObject *simObj;
  int chunk;
  
  simObj = GetSimObj(objIndex,objList,&chunk);
  if (simObj != (Trk_SimObject *)0x0) {
    Trk_SimpleInst *objInstance;

    if (chunk == -1) {
      objInstance = FindObjInstanceFromSerialNum(
          (Group *)0x0,(u_int)simObj->instIndex);
    }
    else {
      objInstance = FindObjInstanceFromSerialNum(
          Track_chunkList[chunk].objInstanceBuf,(u_int)simObj->instIndex);
    }
    if (objInstance != (Trk_SimpleInst *)0x0) {
      Trk_ObjectDef *objDef;

      objDef = Track_gObjDefs[objInstance->pad];
      if ((objInstance->type == '\x05') &&
          (*(char *)((int)&objInstance[1].y + 3) == '\0')) {
        CalcObjExtentPoints((coorddef *)simObj,(CCOORD16 *)(objDef + 1),
                            resultPoints,(tQuat *)(objInstance + 1));
        *numPoints = 3;
      }
      else {
        *resultPoints = *(coorddef *)simObj;
        *numPoints = 1;
      }
    }
    else {
      *numPoints = 1;
      *resultPoints = *(coorddef *)simObj;
    }
  }
  else {
    *numPoints = 0;
  }
  return;
}



/* ---- Object_InitStatus  [OBJECT.CPP:398-404] SLD-VERIFIED ---- */


void Object_InitStatus(void)

{
  int i;

  i = 0x1c1;
  do {
    gSimObjAnims[i] = (ObjectAnim *)0x0;
    i = i + -1;
  } while (-1 < i);
  return;
}



/* ---- Object_KillStatus  [OBJECT.CPP:408-415] SLD-VERIFIED ---- */


void Object_KillStatus(void)

{
  ObjectAnim *pOVar1;
  ObjectAnim **ppOVar2;
  int i;
  
  i = 0;
  ppOVar2 = gSimObjAnims;
  do {
    pOVar1 = *ppOVar2;
    if (pOVar1 != (ObjectAnim *)0x0) {
      (*(*pOVar1->_vf)[1].pfn)((int)&pOVar1->_vf + (int)(*pOVar1->_vf)[1].delta,3);
    }
    i = i + 1;
    ppOVar2 = ppOVar2 + 1;
  } while (i < 0x1c2);
  return;
}



/* ---- Object_GetAnim  [OBJECT.CPP:427-430] SLD-VERIFIED ---- */


ObjectAnim * Object_GetAnim(Trk_SimObject *simObj)

{
  if (simObj == (Trk_SimObject *)0x0) {
    return (ObjectAnim *)0x0;
  }
  return gSimObjAnims[simObj->serialNum];
}

static inline ObjectSignAnim *
Object_CreateSignAnim(BO_tNewtonObj *N,AnimDef *animDef,
                      Trk_CollideBoomInst *objInstance,Trk_ObjectDef *objDef,
                      Trk_SimObject *simObj,ObjectFinishedSignAnim *finishedSign)
{
  ObjectSignAnim *signAnim;

  signAnim = (ObjectSignAnim *)__builtin_new(sizeof(ObjectSignAnim));
  return new(signAnim) ObjectSignAnim(
      &N->linearVel,
      fixedatan((N->linearVel).x >> 8,(N->linearVel).z >> 8) >> 8,
      animDef,objInstance,objDef,simObj,
      (coorddef *)((N->roadMatrix).m + 3),finishedSign);
}



/* ---- Object_CheckCollisionResults  [OBJECT.CPP:455-557] SLD-VERIFIED ---- */
int Object_CheckCollisionResults(Object_tSimObjList *objList,int objIndex,BO_tNewtonObj *N)

{
  Trk_SimObject *simObj;
  ObjectAnim *objStatus;
  int vel;
  int chunk;
  int type;
  int ret;

  ret = 0;
  vel = (__builtin_abs((N->linearVel).x) + __builtin_abs((N->linearVel).z)) >> 16;
  simObj = GetSimObj(objIndex,objList,&chunk);
  objStatus = gSimObjAnims[simObj->serialNum];
  type = simObj->type & 0xf;
  switch (type) {
  case 2:
    if (objStatus != (ObjectAnim *)0x0) {
      break;
    }
    /* BUG FIX (w59-a10 BRANCH-TARGET AUDIT): the two guards used to be one
       `||`, which gated PASS 166/166 but emitted 06200067 for the vel test
       (retail 06200063) -- ours branched to the epilogue (insn 156, returning
       ret==0) while retail branches to .L800A5550 (insn 152) = the shared
       `ret = 1` block that `case 1` also uses.  Retail returns 1 on vel < 0.
       (Unreachable in practice -- vel is a sum of two __builtin_abs -- but it
       is the retail encoding.) */
    if (vel < 0) goto Object_ret1;
    {
    Chunk *pMChunk;
    Trk_SimpleInst *objInstance;
    Trk_ObjectDef *objDef;
    AnimDef *animDef;

    pMChunk = Track_chunkList + chunk;
    objInstance = (Trk_SimpleInst *)
         FindObjInstanceFromSerialNum(pMChunk->objInstanceBuf,(int)simObj->instIndex);
    if (objInstance->type == '\x06') {
      animDef = gAnimDefs + *(u_char *)((int)&objInstance->y + 1);
    }
    else {
      animDef = gAnimDefs +
          ((Trk_CollideBoomInst *)(void *)objInstance)->boomIndex;
    }
    if (animDef->animIndex != 0) {
      objDef = (Trk_ObjectDef *)(gPersistObjDef + 1);
    }
    else {
      objDef = Track_gObjDefs[objInstance->pad];
    }
    if (animDef->type != 0) {
      if (animDef->type != 1) {
        ret = -1;
        goto done;
      }
      ObjectFinishedMultiAnim *finishedMulti;

      finishedMulti = (ObjectFinishedMultiAnim *)__builtin_new(sizeof(ObjectFinishedMultiAnim));
      (finishedMulti->_base_ObjectAnim)._vf =
           (__vtbl_ptr_type (*) [3])ObjectFinishedMultiAnim_vtable;
      gSimObjAnims[simObj->serialNum] =
          &(new ObjectMultiAnim(&N->linearVel,animDef,
                                (Trk_CollideBoomInst *)(void *)objInstance,objDef,simObj,
                                finishedMulti))->_base_ObjectAnim;
    }
    else {
      ObjectFinishedSignAnim *finishedSign;

      finishedSign = (ObjectFinishedSignAnim *)__builtin_new(sizeof(ObjectFinishedSignAnim));
      (finishedSign->_base_ObjectAnim)._vf =
           (__vtbl_ptr_type (*) [3])ObjectFinishedSignAnim_vtable;
      gSimObjAnims[simObj->serialNum] =
          &Object_CreateSignAnim(N,animDef,
                                 (Trk_CollideBoomInst *)(void *)objInstance,
                                 objDef,simObj,finishedSign)
               ->_base_ObjectAnim;
    }
    ret = -1;
    }
    break;
  case 1:
  Object_ret1:
    ret = 1;
    break;
  case 3:
    ret = 2;
    break;
  }
 done:
  return ret;
}

/* ---- Object_InitCustomObjects  [OBJECT.CPP:581-594] SLD-VERIFIED ---- */


void Object_InitCustomObjects(void)

{
  Group *dst;
  
  Object_customObjInst = reservememadr("Custom Objects",0x400,0);
  Object_customObjInst->m_num_elements = 0;
  Object_customSimObjs = reservememadr("Custom SimObjects",0x400,0);
  dst = Object_customSimObjs + 1;
  Object_customSimObjs->m_num_elements = 0;
  blockfill(dst,0x3fc,0);
  Object_customSFXInst = reservememadr("Custom SimObjects",0x400,0);
  Object_customSFXInst->m_num_elements = 0;
  Object_customSliceNum = 0;
  return;
}



/* ---- Object_DeInitCustomObjects  [OBJECT.CPP:600-610] SLD-VERIFIED ---- */


void Object_DeInitCustomObjects(void)

{
  if (Object_customObjInst != (Group *)0x0) {
    purgememadr(Object_customObjInst);
  }
  if (Object_customSFXInst != (Group *)0x0) {
    purgememadr(Object_customSFXInst);
  }
  if (Object_customSimObjs != (Group *)0x0) {
    purgememadr(Object_customSimObjs);
  }
  Object_customObjInst = (Group *)0x0;
  Object_customSFXInst = (Group *)0x0;
  Object_customSimObjs = (Group *)0x0;
  return;
}



/* ---- Object_ClearCustomObjects  [OBJECT.CPP:616-635] SLD-VERIFIED ---- */


void Object_ClearCustomObjects(void)

{
  int i;
  
  Object_customObjInst->m_num_elements = 0;
  Object_customSimObjs->m_num_elements = 0;
  Object_customSFXInst->m_num_elements = 0;
  for (i = 0; i < Cars_gNumTrafficCars; i++) {
    Cars_gTrafficCarList[i]->carFlags =
        Cars_gTrafficCarList[i]->carFlags & 0xfffffbff;
  }
  for (i = 0; i < Cars_gNumCopCars; i++) {
    Cars_gCopCarList[i]->carFlags =
        Cars_gCopCarList[i]->carFlags & 0xfffffbff;
  }
  if (Track_gSaveSurface != (Object_SaveSurfaceCodegenView *)0x0) {
    (Track_gSaveSurface)->RestoreAll();
  }
  return;
}



/* ---- SetCautionSurface  [OBJECT.CPP:648-657] SLD-VERIFIED ---- */
void SetCautionSurface(coorddef *pt,BWorldSm_Pos *slicePos)

{
  Trk_NewSimQuad *simQuad;

  BWorldSm_FindClosestQuadRez(pt,slicePos,1);
  simQuad = slicePos->simQuad;
  if ((simQuad != (Trk_NewSimQuad *)0x0) && ((simQuad->surface & 0x40) == 0)) {
    (Track_gSaveSurface)->Save(simQuad);
    slicePos->simQuad->surface = slicePos->simQuad->surface | 0x40;
  }
  return;
}

/* ---- Object_AddCustomSimObject  [OBJECT.CPP:668-718] SLD-VERIFIED ---- */


int Object_AddCustomSimObject(SceneElem *objectData,int serialNum,int instIndex)

{
  Trk_SimObject *simObj;
  BWorldSm_Pos slicePos;
  coorddef pt;
  
  if (objectData->type == 0) {
    simObj = (Trk_SimObject *)Object_customSimObjs->GetData() +
             Object_customSimObjs->m_num_elements;
    simObj->point[0] = objectData->cp.x;
    simObj->point[1] = objectData->cp.y;
    simObj->point[2] = objectData->cp.z;
    BWorldSm_SetSlice(1,&slicePos);
    pt = objectData->cp;
    SetCautionSurface(&pt,&slicePos);
    pt.x = pt.x + -0x40000;
    SetCautionSurface(&pt,&slicePos);
    pt.x = pt.x + 0x80000;
    SetCautionSurface(&pt,&slicePos);
    pt.x = pt.x + -0x40000;
    pt.z = pt.z + -0x40000;
    SetCautionSurface(&pt,&slicePos);
    pt.z = pt.z + 0x80000;
    SetCautionSurface(&pt,&slicePos);
    Object_customSliceNum = slicePos.slice;
    simObj->radius = objectData->scalar2 >> 9;
    simObj->serialNum = serialNum + 400;
    simObj->instIndex = instIndex - 0x80;
    if (objectData->scalar1 < 9) {
      simObj->type = 2;
    } else {
      simObj->type = 1;
    }
    Object_customSimObjs->m_num_elements = Object_customSimObjs->m_num_elements + 1;
  }
  return Object_customSimObjs->m_num_elements + -1;
}



/* ---- Object_GetObjDefID  [OBJECT.CPP:785-790] SLD-VERIFIED ---- */


int Object_GetObjDefID(int index)

{
  if ((gPersistObjDef != (Group *)0x0) && (index < gPersistObjDef->m_num_elements)) {
    return (int)Track_gObjDefs[index]->id;
  }
  return 0;
}



/* ---- Object_FindDefWithThisID  [OBJECT.CPP:794-800] SLD-VERIFIED ---- */


int Object_FindDefWithThisID(int ID)

{
  Group *pThis;
  Trk_ObjectDef *objDef;
  int i;
  Trk_ObjectDef **ppTVar2;

  i = 0;
  ppTVar2 = Track_gObjDefs;
  while (true) {
    if (gPersistObjDef->m_num_elements <= i) {
      goto notFound;
    }
    objDef = *ppTVar2;
    ppTVar2 = ppTVar2 + 1;
    if (ID != objDef->id) {
      goto nextObjectDef;
    }
    return i;
nextObjectDef:
    i = i + 1;
  }
notFound:
  return -1;
}



/* ---- Object_AddCustomObject  [OBJECT.CPP:808-1002] SLD-VERIFIED ---- */
void Object_AddCustomObject(SceneElem *objectData,int setupSimDataFlag)

{
  int type;

  type = objectData->type;
  if (type == 1) {
    goto traffic_object;
  }
  if (type < 2) {
    if (type == 0) {
      goto custom_object;
    }
    goto done;
  }
  if (type == 2) {
    goto sfx_object;
  }
  goto done;
custom_object:
    {
      Trk_CollideBoomInst *objBoomInstance;
      int index;
      tQuat quat;

      index = Object_customObjInst->GetNumElements();
      objBoomInstance = (Trk_CollideBoomInst *)(Object_customObjInst + 1);
      index--;
      if (index != -1) {
        short size;

        size = (short)Object_customObjInst[1].m_num_elements;
        do {
          index--;
          objBoomInstance = (Trk_CollideBoomInst *)((char *)objBoomInstance + size);
        } while (index != -1);
      }
      objBoomInstance->size = sizeof(Trk_CollideBoomInst);
      if (objectData->scalar1 < 9) {
        objBoomInstance->type = 5;
      }
      else {
        objBoomInstance->type = 2;
      }
      objBoomInstance->zoffset = 3;
      objBoomInstance->flags = 0;
      objBoomInstance->x = objectData->cp.x;
      objBoomInstance->y = objectData->cp.y;
      objBoomInstance->z = objectData->cp.z;
      objBoomInstance->objectIndex = 0;
      objBoomInstance->pad = (short)objectData->subTypeIndex;
      if (objBoomInstance->pad >= gPersistObjDef->m_num_elements) {
        objBoomInstance->pad = 0;
      }
      if ((objectData->committed != 0) && (objectData->visible != 0)) {
        if (Object_GetObjDefID(objBoomInstance->pad) != objectData->scalar1) {
          int newInd;

          Object_FindDefWithThisID(objectData->scalar1);
          newInd = Object_FindDefWithThisID(objectData->scalar1);
          if (newInd != -1) {
            objBoomInstance->pad = (short)newInd;
            objectData->subTypeIndex = newInd;
            Object_FindDefWithThisID(objectData->scalar1);
          }
          else {
            objectData->scalar1 = Object_GetObjDefID(objBoomInstance->pad);
          }
        }
      }
      Quatern_MatToQuat(&objectData->orient,&quat);
      objBoomInstance->qw = quat.w;
      objBoomInstance->qx = quat.x;
      objBoomInstance->qy = quat.y;
      objBoomInstance->qz = quat.z;
      objBoomInstance->sx = 0x100;
      objBoomInstance->sy = 0x100;
      objBoomInstance->sz = 0x100;
      if (setupSimDataFlag != 0) {
        objBoomInstance->simIndex =
            Object_AddCustomSimObject(objectData,Object_customObjInst->m_num_elements,
                                      Object_customObjInst->m_num_elements);
        objBoomInstance->boomIndex = (u_char)objectData->scalar1;
      }
      else {
        objBoomInstance->simIndex = 0;
        objBoomInstance->boomIndex = 0;
      }
      Object_customObjInst->m_num_elements++;
    }
    goto done;
sfx_object:
    {
      Trk_SFX *sfxInstance;

      sfxInstance = (Trk_SFX *)Object_customSFXInst->GetData() +
                    Object_customSFXInst->m_num_elements;
      sfxInstance->point[0] = objectData->cp.x;
      sfxInstance->point[1] = objectData->cp.y;
      sfxInstance->point[2] = objectData->cp.z;
      sfxInstance->type = (short)objectData->subType;
      sfxInstance->pad = 0;
      Object_customSFXInst->m_num_elements++;
    }
    goto done;
traffic_object:
    {
      int i;
      Car_tObj *carObj;

      /* NEAR-MISS 11 (ours 212 / oracle 213).  Retail materialises `i = 0` EARLY
         (its own SLD statement, line 925 -- ours sinks it into the `bnez` delay
         slot) and then COPIES it into a second pseudo `addu a0,a1,zero` (SLD 927)
         which is what the pre-loop `i < Cars_gNumTrafficCars` guard compares
         (`slt v0,a0,v1`); the loop counter stays $a1 in both builds.  FALSIFIED
         (W55-A16, 1 compile): an explicit second source variable
         `guard = i; ... (guard < Cars_gNumTrafficCars)` -- cse constant-folds it
         back (both pseudos are provably 0) and the diff count is UNCHANGED at 11.
         The copy therefore is NOT a source-level second variable holding a known
         zero; whatever feeds retail's guard pseudo is not constant-0 to cse.
         Remaining 2 diffs are the carObj base ($a0 vs $v0) at :779/:780.
         FALSIFIED (W56-A14): inner-shadow `int i;` inside the if-block DOES add the
         missing copy (count 212->213 exact) but colors the inner loop counter off $a1
         (32 diffs) -- oracle keeps i in $a1 throughout with ONLY the guard using the a0
         copy; a scheduling/coloring split, permuter-class re-seed (not spelling).
         FALSIFIED (W60-A9), closing the 09G "make the copy a GLOBAL allocno" route:
         a second `int guard = i;` carrying an OPACITY fence `"=r"(guard):"0"(guard)`
         (the w47 value-numbering barrier cse cannot fold through) = 15 @216 -- it
         does defeat the constant-fold but emits THREE extra insns, not retail's one;
         the same fence placed on `i` itself before the copy = 31 @216.  And the
         second residual (the carObj base $a0-vs-$v0 at :779/:780) does NOT respond to
         an opacity fence on `carObj` (11, unchanged).  So the missing copy is a
         local-alloc copy-preference question (06E), consistent with the W56-A14
         inner-shadow measurement, and the remaining route is a permuter re-seed.
         FALSIFIED (W61-A13, 2026-08-15) -- the W60 12D DEAD-PSEUDO-STAGING route is
         now closed too.  SYM 8c @800a5c80 (block line 117) gives the ground truth:
         `i` = REG $5 = $a1 and `carObj` = REG $4 = $a0, so retail's missing insn
         `addu a0,a1,zero` stages i's zero THROUGH carObj's own register -- exactly
         the shape 12D says to reproduce by assigning into the register's owning
         variable rather than inventing one.  Measured (real gate runs):
           carObj = (Car_tObj *)i;  + guard `(int)carObj < N` ....... 19 @212
           same with the guard written Yoda ......................... 19 @212
           drop the redundant `i < N` guard conjunct entirely ........ 11 @212
           guard on the literal `0 < N` ............................. 13 @214
           guard `0 < N` + `for (; i < N; i++)` ..................... 13 @214
           guard `i < N` + `for (; i < N; i++)` ..................... 11 @212
           guard Yoda `N > i` + `for (i = 0; ...)` .................. 11 @212
           guard `0 < N` + `for (i = i; ...)` ....................... 13 @214
         Note the literal-guard forms DO add two instructions (214) but the wrong
         ones.  Every route that produces retail's copy also moves the loop counter
         off $a1 (W56-A14) -- 12E's law in the flesh: a dial buys retail's REGISTER
         or retail's COUNT, never both.  Instrument-only from here (local-alloc
         copy preference); do not spend more spellings. */
      i = 0;
      /* MATCH (W62-A12, 11 -> PASS 213/213, DEVICE-FREE): retail's missing insn
         was `addu a0,a1,zero` in the `bnez` delay slot -- 12D DEAD-PSEUDO STAGING:
         the zero is carried through carObj's OWN register (SYM 8c @800a5c80:
         carObj = REG $4 = $a0, i = REG $5 = $a1), so the guard must read the
         STAGED value, not `i`.  The second half of the pair (and the reason five
         earlier waves' staging attempts all failed) is that the `for`'s redundant
         re-init `i = 0` must GO: it is exactly the one reference reqdelta prices
         (p188 refs 9 -> 8) that swaps i off $a0 and lets carObj take it.  Land the
         pair or neither -- staging alone is 19-20, dropping the init alone is 11. */
      carObj = (Car_tObj *)i;
      if (((objectData->subType == 0) && (Cars_gNumTrafficCars != 0)) &&
          ((int)carObj < Cars_gNumTrafficCars)) {
        for (; i < Cars_gNumTrafficCars; i++) {
          if (((Cars_gTrafficCarList[i]->carFlags & 0x400U) == 0) &&
              ((int)Cars_gTrafficCarList[i]->render.currentCarType ==
               objectData->scalar3)) {
            break;
          }
        }
        if (i < Cars_gNumTrafficCars) {
          AIHigh_Traffic *aicar;
          SceneElem *accidentData;

          carObj = Cars_gTrafficCarList[i];
          aicar = highLevelAIObjs[carObj->carIndex];
          accidentData = objectData;
          aicar->accidentData_ = accidentData;
        }
      }
    }
done:
  return;
}

/* ---- GetObjMaxDimensions  [OBJECT.CPP:1011-1048] SLD-VERIFIED ---- */
void GetObjMaxDimensions(Trk_ObjectDef **pObjDefs,Trk_SimpleInst *objInstance,coorddef *dimensions)

{
  Trk_ObjectDef *objDef;
  int vertCount;
  int lastVert;
  int stopVert;
  CCOORD16 *pts;
  CCOORD16 minDim;
  CCOORD16 maxDim;

  objDef = pObjDefs[objInstance->pad];
  memset(&minDim,0,8);
  memset(&maxDim,0,8);
  lastVert = -1;
  vertCount = (int)objDef->vertexCount;
  pts = (CCOORD16 *)(objDef + 1);
  vertCount = vertCount + -1;
  if (vertCount != lastVert) {
    stopVert = lastVert;
    do {
    if (pts->x > maxDim.x) {
      maxDim.x = pts->x;
    }
    else if (pts->x < minDim.x) {
      minDim.x = pts->x;
    }
    if (pts->y > maxDim.y) {
      maxDim.y = pts->y;
    }
    else if (pts->y < minDim.y) {
      minDim.y = pts->y;
    }
    if (pts->z > maxDim.z) {
      maxDim.z = pts->z;
    }
    else if (pts->z < minDim.z) {
      minDim.z = pts->z;
    }
    pts = pts + 1;
    vertCount = vertCount + -1;
    } while (vertCount != stopVert);
  }
  dimensions->x = ((int)maxDim.x - (int)minDim.x) * 0x200;
  dimensions->y = ((int)maxDim.y - (int)minDim.y) * 0x200;
  dimensions->z = ((int)maxDim.z - (int)minDim.z) * 0x200;
  return;
}

/* ---- Object_InitIMassObjectInfo  [OBJECT.CPP:1055-1088] SLD-VERIFIED ---- */


void Object_InitIMassObjectInfo(void)

{
  Trk_AnimateInst *objInst;
  int objIndex;
  
  gNumIMassObjects = 0;
  Object_IMassObjInst = (Object_tIMassObjInfo *)0x0;
  if ((gPersistObjInst != (Group *)0x0) && (gPersistObjDef != (Group *)0x0)) {
    Object_IMassObjInst =
         reservememadr("IMObj info",gPersistObjInst->m_num_elements << 5,0)
    ;
    if (Object_IMassObjInst != (Object_tIMassObjInfo *)0x0) {
      objIndex = 0;
      objInst = (Trk_AnimateInst *)(gPersistObjInst + 1);
      if (0 < gPersistObjInst->m_num_elements) {
        do {
          if (objInst->type == '\a') {
            Object_IMassObjInst[gNumIMassObjects].animInst =
                (Trk_AnimateInst *)objInst;
            GetObjMaxDimensions(Track_gObjDefs,(Trk_SimpleInst *)objInst,
                &Object_IMassObjInst[gNumIMassObjects].dimension);
            Object_IMassObjInst[gNumIMassObjects].lastPos.x = 0;
            Object_IMassObjInst[gNumIMassObjects].lastPos.y = 0;
            Object_IMassObjInst[gNumIMassObjects].lastPos.z = 0;
            Object_IMassObjInst[gNumIMassObjects].lastTick = 0;
            gNumIMassObjects = gNumIMassObjects + 1;
          }
          objIndex = objIndex + 1;
          objInst =
              (Trk_AnimateInst *)((int)&objInst->size + (int)objInst->size);
        } while (objIndex < gPersistObjInst->m_num_elements);
      }
    }
  }
  return;
}



/* ---- Object_DeInitIMassObjectInfo  [OBJECT.CPP:1093-1095] SLD-VERIFIED ---- */


void Object_DeInitIMassObjectInfo(void)

{
  if (Object_IMassObjInst != (Object_tIMassObjInfo *)0x0) {
    purgememadr(Object_IMassObjInst);
  }
  return;
}



/* ---- Object_GetNumIMassObjects  [OBJECT.CPP:1101-1102] SLD-VERIFIED ---- */


int Object_GetNumIMassObjects(void)

{
  return gNumIMassObjects;
}



/* ---- Object_GetIMassObjectDimensions  [OBJECT.CPP:1108-1111] SLD-VERIFIED ---- */


void Object_GetIMassObjectDimensions(int objIndex,coorddef *dimensions)

{
  *dimensions = Object_IMassObjInst[objIndex].dimension;
  return;
}



/* ---- Object_GetIMassObjectMotion  [OBJECT.CPP:1117-1143] SLD-VERIFIED ---- */
void Object_GetIMassObjectMotion(int objIndex,coorddef *cpoint,matrixtdef *orientMat,coorddef *velocity)

{
  int objTime;
  int timeDiff;

  objTime = DrawW_GetAnimationTime(Object_IMassObjInst[objIndex].animInst);
  Anim_GetRotPos(Object_IMassObjInst[objIndex].animInst,1,objTime,cpoint,orientMat);
  timeDiff = objTime - Object_IMassObjInst[objIndex].lastTick;
  if (0 < timeDiff) {
    velocity->x = (cpoint->x - Object_IMassObjInst[objIndex].lastPos.x) / timeDiff << 6;
    velocity->y = (cpoint->y - Object_IMassObjInst[objIndex].lastPos.y) / timeDiff << 6;
    velocity->z = (cpoint->z - Object_IMassObjInst[objIndex].lastPos.z) / timeDiff << 6;
  }
  else {
    velocity->x = 0;
    velocity->y = 0;
    velocity->z = 0;
  }
  Object_IMassObjInst[objIndex].lastPos = *cpoint;
  Object_IMassObjInst[objIndex].lastTick = objTime;
  return;
}

/* ---- ObjectFinishedMultiAnim_Draw  [OBJECT.CPP:1160-1161] SLD-VERIFIED ---- */

int ObjectFinishedMultiAnim::Draw(DRender_tView *Vi,Draw_DCache *sd,int offset)

{
  return 2;
}



/* ---- ObjectMultiAnim_ct  [OBJECT.CPP:1165-1183] SLD-VERIFIED ---- */
ObjectMultiAnim::ObjectMultiAnim(coorddef *impactVel,AnimDef *def,
          Trk_CollideBoomInst *objCollideInstance,Trk_ObjectDef *objDef,Trk_SimObject *simObj,
          ObjectFinishedMultiAnim *finishedAnim)

{
  _base_ObjectAnim._vf = (__vtbl_ptr_type (*) [3])ObjectMultiAnim_vtable;
  this->impactVel.x = impactVel->x >> 6;
  this->impactVel.y = impactVel->y >> 6;
  int z = impactVel->z;
  animParms = def;
  this->objCollideInstance = objCollideInstance;
  this->objDef = objDef;
  this->simObj = simObj;
  this->impactVel.z = z >> 6;
  if (objCollideInstance->type == '\x06') {
    script = new AnimScript(gPersistObjInst,8,
                            *(u_char *)((int)&objCollideInstance->y + 1),
                            animParms->numPieces);
  }
  else {
    script = new AnimScript(gPersistObjInst,8,objCollideInstance->boomIndex,
                            animParms->numPieces);
  }
  script->SetAnimAttrib(2);
  this->finishedAnim = finishedAnim;
}



/* ---- ObjectMultiAnim::Draw  [OBJECT.CPP:1188-1296] SLD-VERIFIED ----
 * PASS 265/265.  The retail method symbol was previously missing because this
 * was emitted as a flat helper.  SLD scopes recover the 208-byte frame and the
 * animIndex/partCount/objInst allocation; struct copies recover the packed quat
 * and base coordinate bursts.  The short-lived t3 plus targeted volatile matrix
 * destinations preserve retail's three fixedmult-result store schedules. */
int ObjectMultiAnim::Draw(DRender_tView *Vi,Draw_DCache *sd,int offset)

{
  matrixtdef matrix;
  coorddef animcp;

  if ((u_int)(script->GetTimedAnimPosRot(0,&animcp,&matrix) + 1) < 2) {
    int i;
    ObjectAnim *anim;

    anim = (ObjectAnim *)finishedAnim;
    i = simObj->serialNum;
    finishedAnim = (ObjectFinishedMultiAnim *)0x0;
    if (gSimObjAnims[i] != (ObjectAnim *)0x0) {
      (*(*gSimObjAnims[i]->_vf)[1].pfn)
        ((int)&gSimObjAnims[i]->_vf + (int)(*gSimObjAnims[i]->_vf)[1].delta,3);
    }
    gSimObjAnims[i] = anim;
    return (*(*anim->_vf)[2].pfn)
      ((int)&anim->_vf + (int)(*anim->_vf)[2].delta,Vi,sd,offset);
  }
  else {
    Trk_ObjectDef *pObjDef;
    int animIndex;
    int partCount;
    coorddef cp;
    coorddef impact;
    matrixtdef RSmatrix;
    Trk_AnimateBoomInst *objInst;

    animIndex = 0;
    {
      int ticks;
      Trk_AnimateInst *animInst;

      ticks = simGlobal.gameTicks - script->baseTicks;
      animInst = *script->inst;
      partCount = animParms->numPieces;
      if (((int)animInst->interval * (int)animInst->count >> 1) < ticks) {
        ticks = (int)animInst->interval * (int)animInst->count >> 1;
      }
      impact.x = impactVel.x * ticks;
      impact.y = impactVel.y * ticks;
      impact.z = impactVel.z * ticks;
    }
    if (objCollideInstance->type != '\x06') {
      tQuat quat;

      quat = *(tQuat *)&objCollideInstance->qx;
      Quatern_QuatToMat(&quat,&RSmatrix);
      {
        int t1;
        int t2;
        int t3;
        int sx;
        int sy;
        int sz;

        sx = (int)objCollideInstance->sx << 8;
        sy = (int)objCollideInstance->sy << 8;
        sz = (int)objCollideInstance->sz << 8;
        t1 = fixedmult(RSmatrix.m[0],sx);
        t2 = fixedmult(RSmatrix.m[3],sx);
        t3 = fixedmult(RSmatrix.m[6],sx);
        *(volatile int *)&RSmatrix.m[0] = t1;
        *(volatile int *)&RSmatrix.m[3] = t2;
        RSmatrix.m[6] = t3;
        t1 = fixedmult(RSmatrix.m[1],sy);
        t2 = fixedmult(RSmatrix.m[4],sy);
        t3 = fixedmult(RSmatrix.m[7],sy);
        *(volatile int *)&RSmatrix.m[1] = t1;
        *(volatile int *)&RSmatrix.m[4] = t2;
        RSmatrix.m[7] = t3;
        t1 = fixedmult(RSmatrix.m[2],sz);
        t2 = fixedmult(RSmatrix.m[5],sz);
        t3 = fixedmult(RSmatrix.m[8],sz);
        *(volatile int *)&RSmatrix.m[2] = t1;
        *(volatile int *)&RSmatrix.m[5] = t2;
        RSmatrix.m[8] = t3;
      }
    }
    objInst = (Trk_AnimateBoomInst *)(gPersistObjInst + 1);
    while (animIndex < partCount) {
      script->GetTimedAnimPosRot(animIndex,&animcp,&matrix);
      if (objCollideInstance->type != '\x06') {
        Math_fasttransmult(&matrix,&RSmatrix,&matrix);
      }
      cp = *(coorddef *)simObj;
      cp.x += animcp.x + impact.x;
      cp.y += animcp.y;
      cp.z += animcp.z + impact.z;
      while( true ) {
        if (objInst->type == '\b') {
          if (((objCollideInstance->type != '\x05') ||
               (objInst->boomIndex == objCollideInstance->boomIndex)) &&
              ((objCollideInstance->type != '\x06') ||
               (objInst->boomIndex == ((u_char *)&objCollideInstance->y)[1]))) {
            break;
          }
        }
        objInst = (Trk_AnimateBoomInst *)((char *)objInst + objInst->size);
      }
      pObjDef = Track_gObjDefs[objInst->pad];
      DrawObjectTransform(Vi,sd,&matrix,pObjDef,&cp,offset,-1);
      animIndex = animIndex + 1;
      objInst = (Trk_AnimateBoomInst *)((char *)objInst + objInst->size);
    }
    return 4;
  }
}

/* ---- ObjectFinishedSignAnim_Draw  [OBJECT.CPP:1302-1304] SLD-VERIFIED ---- */

int ObjectFinishedSignAnim::Draw(DRender_tView *Vi,Draw_DCache *sd,int offset)

{
  ObjectFinishedSignAnim *pThis = this;
  
  DrawObjectTransform(Vi,sd,(matrixtdef *)((int)pThis + 4),*(Trk_ObjectDef **)((int)pThis + 0x28),
             (coorddef *)(*(int *)((int)pThis + 0x2c) + 8),offset,-1);
  return 2;
}



/* ---- ObjectSignAnim_ct  [OBJECT.CPP:1308-1354] SLD-VERIFIED ---- */
ObjectSignAnim::ObjectSignAnim(coorddef *impactVel,int impactAngle,AnimDef *def,
          Trk_CollideBoomInst *objCollideInstance,Trk_ObjectDef *objDef,Trk_SimObject *simObj,
          coorddef *roadNormal,ObjectFinishedSignAnim *finishedAnim)

{
  int vel;
  coorddef *roty;
  coorddef *rotz;
  coorddef *rotx;
  matrixtdef yawMat;
  matrixtdef objAngleMat;
  matrixtdef tmpMat;
  matrixtdef mat;

  _base_ObjectAnim._vf = (__vtbl_ptr_type (*) [3])ObjectSignAnim_vtable;
  vel = (__builtin_abs(impactVel->x) + __builtin_abs(impactVel->z)) >> 16;
  this->impactVel = *impactVel;
  this->impactAngle = impactAngle << 8;
  animParms = def;
  this->objCollideInstance = objCollideInstance;
  this->objDef = objDef;
  this->simObj = simObj;
  objectAngle = CalcObjYawAngle((CCOORD16 *)(objDef + 1)) << 8;
  if (vel < 10)
    script = new AnimScript(animParms->baseAnim,animParms->numPieces);
  else
    script = new AnimScript(animParms->baseAnim + 1,animParms->numPieces);
  script->SetAnimAttrib(2);
  this->finishedAnim = finishedAnim;

  rotx = (coorddef *)&finishedAnim->finalMatrix.m[0];
  roty = (coorddef *)&finishedAnim->finalMatrix.m[3];
  rotz = (coorddef *)&finishedAnim->finalMatrix.m[6];
  *roty = *roadNormal;
  rotz->x = 0;
  rotz->y = 0;
  rotz->z = 0x10000;
  rotx->x = fixedmult(roty->y,rotz->z) - fixedmult(roty->z,rotz->y);
  rotx->y = fixedmult(roty->z,rotz->x) - fixedmult(roty->x,rotz->z);
  rotx->z = fixedmult(roty->x,rotz->y) - fixedmult(roty->y,rotz->x);
  rotz->x = fixedmult(rotx->y,roty->z) - fixedmult(rotx->z,roty->y);
  rotz->y = fixedmult(rotx->z,roty->x) - fixedmult(rotx->x,roty->z);
  rotz->z = fixedmult(rotx->x,roty->y) - fixedmult(rotx->y,roty->x);
  reorthogonalize(&finishedAnim->finalMatrix);
  fixedxformx(&mat,0x4000);
  fixedxformy(&objAngleMat,-objectAngle);
  fixedxformy(&yawMat,this->impactAngle);
  Math_fasttransmult(&objAngleMat,&mat,&tmpMat);
  Math_fasttransmult(&tmpMat,&yawMat,&tmpMat);
  Math_fasttransmult(&tmpMat,&finishedAnim->finalMatrix,
                     &finishedAnim->finalMatrix);
  finishedAnim->objDef = objDef;
  finishedAnim->objCollideInstance = objCollideInstance;
}



/* ---- ObjectSignAnim_Draw  [OBJECT.CPP:1360-1401] SLD-VERIFIED ---- */
int ObjectSignAnim::Draw(DRender_tView *Vi,Draw_DCache *sd,int offset)

{
  ObjectSignAnim *pThis = this;
  int i;
  int ret;
  __vtbl_ptr_type (*pa_Var3) [3];
  Trk_CollideBoomInst *pTVar4;
  ObjectAnim *anim;
  Trk_ObjectDef *pObjDef;
  ObjectFinishedSignAnim *finishedAnim;
  matrixtdef matrix;
  coorddef animcp;
  coorddef cp;
  int frame;
  int numFrames;

  ret = (pThis->script)->GetTimedAnimPosRot(0, &animcp, &matrix);
  if (ret + 1U < 2) {
    finishedAnim = pThis->finishedAnim;
    i = pThis->simObj->serialNum;
    pThis->finishedAnim = (ObjectFinishedSignAnim *)0x0;
    anim = gSimObjAnims[i];
    if (anim != (ObjectAnim *)0x0) {
      (*(*anim->_vf)[1].pfn)((int)&anim->_vf + (int)(*anim->_vf)[1].delta,3);
    }
    gSimObjAnims[i] = &finishedAnim->_base_ObjectAnim;
    pa_Var3 = (finishedAnim->_base_ObjectAnim)._vf;
    ret = (*(*pa_Var3)[2].pfn)
                    ((int)finishedAnim + (int)(*pa_Var3)[2].delta,Vi,sd,offset);
  }
  else {
    pObjDef = pThis->objDef;
    (pThis->script)->GetTimedAnimPosRot(0, &animcp, &matrix);
    (pThis->script)->GetAnimFrameInfo(&frame, &numFrames);
    pTVar4 = pThis->objCollideInstance;
    cp = *(coorddef *)&pTVar4->x;
    cp.x += animcp.x;
    cp.y += animcp.y;
    cp.z += animcp.z;
    BuildObjCollisionMatrix((frame << 0x10) / numFrames,pThis->objectAngle,pThis->impactAngle,&matrix);
    DrawObjectTransform(Vi,sd,&matrix,pObjDef,&cp,offset,-1);
    ret = 4;
  }
  return ret;
}

/* ---- ___14ObjectSignAnim  [OBJECT.CPP:?] SLD-FLAG:NO_SLD ---- */

extern "C" void ___14ObjectSignAnim(ObjectSignAnim *pThis,int __in_chrg)

{
  __vtbl_ptr_type (*pa_Var1) [3];
  ObjectFinishedSignAnim *pOVar2;
  AnimScript *deleteMe;
  
  deleteMe = pThis->script;
  (pThis->_base_ObjectAnim)._vf = (__vtbl_ptr_type (*) [3])ObjectSignAnim_vtable;
  if (deleteMe != (AnimScript *)0x0) {
    if (deleteMe->inst != (Trk_AnimateInst **)0x0) {
      __builtin_vec_delete(deleteMe->inst);
    }
    __builtin_delete(deleteMe);
  }
  pOVar2 = pThis->finishedAnim;
  if (pOVar2 != (ObjectFinishedSignAnim *)0x0) {
    pa_Var1 = (pOVar2->_base_ObjectAnim)._vf;
    (*(*pa_Var1)[1].pfn)((int)&(pOVar2->_base_ObjectAnim)._vf + (int)(*pa_Var1)[1].delta,3);
  }
  (pThis->_base_ObjectAnim)._vf = (__vtbl_ptr_type (*) [3])ObjectAnim_vtable;
  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }
  return;
}



/* ---- ___22ObjectFinishedSignAnim  [OBJECT.CPP:?] SLD-FLAG:NO_SLD ---- */

extern "C" void ___22ObjectFinishedSignAnim(ObjectFinishedSignAnim *pThis,int __in_chrg)

{
  (pThis->_base_ObjectAnim)._vf = (__vtbl_ptr_type (*) [3])ObjectAnim_vtable;
  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }
  return;
}



/* ---- ___15ObjectMultiAnim  [OBJECT.CPP:?] SLD-FLAG:NO_SLD ---- */

extern "C" void ___15ObjectMultiAnim(ObjectMultiAnim *pThis,int __in_chrg)

{
  __vtbl_ptr_type (*pa_Var1) [3];
  ObjectFinishedMultiAnim *pOVar2;
  AnimScript *deleteMe;
  
  deleteMe = pThis->script;
  (pThis->_base_ObjectAnim)._vf = (__vtbl_ptr_type (*) [3])ObjectMultiAnim_vtable;
  if (deleteMe != (AnimScript *)0x0) {
    if (deleteMe->inst != (Trk_AnimateInst **)0x0) {
      __builtin_vec_delete(deleteMe->inst);
    }
    __builtin_delete(deleteMe);
  }
  pOVar2 = pThis->finishedAnim;
  if (pOVar2 != (ObjectFinishedMultiAnim *)0x0) {
    pa_Var1 = (pOVar2->_base_ObjectAnim)._vf;
    (*(*pa_Var1)[1].pfn)((int)&(pOVar2->_base_ObjectAnim)._vf + (int)(*pa_Var1)[1].delta,3);
  }
  (pThis->_base_ObjectAnim)._vf = (__vtbl_ptr_type (*) [3])ObjectAnim_vtable;
  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }
  return;
}



/* ---- ___23ObjectFinishedMultiAnim  [OBJECT.CPP:?] SLD-FLAG:NO_SLD ---- */

extern "C" void ___23ObjectFinishedMultiAnim(ObjectFinishedMultiAnim *pThis,int __in_chrg)

{
  (pThis->_base_ObjectAnim)._vf = (__vtbl_ptr_type (*) [3])ObjectAnim_vtable;
  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }
  return;
}



/* ---- _._10ObjectAnim  [OBJECT.H:53] SLD-VERIFIED ---- */
/* W60-A9: moved here from between the ObjectMultiAnim marker and its body to restore retail
 * VA emission order (___10ObjectAnim @0x800a6de0 is the LAST of the four dtors:
 * FinishedSignAnim 0x800a6cc4 < MultiAnim 0x800a6cf8 < FinishedMultiAnim 0x800a6dac < this). */
ObjectAnim::~ObjectAnim()
{
  _vf = (__vtbl_ptr_type (*) [3])ObjectAnim_vtable;
}


/* end of object.cpp */
