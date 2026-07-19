/* game/common/aih_basiccop.cpp -- RECONSTRUCTED (base cop AI class + blockade helpers; C++ TU)
 *   8 fns: AIHigh_BasicCop base class (ctor/CheckSpikeBelt/ShouldIPerformCutOffBlock/
 *   SetupBlockadeElements/HandleBlockadeSpeech) + 3 free fns (Blockade_AddRoadFlare/
 *   Blockade_AddObject/PlacePointOnRoad). Composition-modeled inheritance (_base_AIHigh_Base);
 *   manual _vf vtable. Faithful C++ (option A). NOT original; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "../../nfs4_types.h"
#include "aih_basiccop_externs.h"

/* H18: not in this TU's externs -- needed by the ShouldIPerformCutOffBlock reconstruction */
extern int AI_elapsedTime;                              /* ai.cpp @0x8013C554 */
int AIWorld_SplineDistance(Car_tObj *a, Car_tObj *b);   /* AIWORLD.obj */
extern int D_8011E0B0[];   /* == &simGlobal.gameTicks (a distinct alias symbol the oracle
                              addresses directly in CheckSpikeBelt's SECOND read, keeping the
                              two gameTicks reads textually distinct so gcc can't CSE one
                              %hi/lui base across the intervening AILife_IsSliceInAnyVisibleArea
                              call -- see aiphysic_externs.h) */


/* ---- __15AIHigh_BasicCopP8Car_tObji  AIHigh_BasicCop::ctor  [AIH_BASICCOP.CPP:18-34] SLD-VERIFIED ---- */
AIHigh_BasicCop::AIHigh_BasicCop(Car_tObj *carObj,int copIndex)



{

  (new((AIHigh_Base *)this) AIHigh_Base(carObj));

  this->_vf = (__vtbl_ptr_type (*) [3])AIHigh_BasicCop_vtable;

  this->copIndex_ = copIndex;

  if ((carObj->carFlags & 0x40U) != 0) {
    this->type_ = 1;
  }
  else {
    this->type_ = 0;
  }

  (this->blockade_).mode = 0;

  (this->blockade_).target = (AIHigh_Player *)0x0;

  (this->blockade_).requestSpikeBeltAtSlice = -1;

  (this->blockade_).blockadeSpeechFlags = 0;

  this->driveAway_ = 0;

  return;

}








/* ---- CheckSpikeBelt__15AIHigh_BasicCop  AIHigh_BasicCop::CheckSpikeBelt  [AIH_BASICCOP.CPP:41-73] SLD-VERIFIED ---- */

void AIHigh_BasicCop::CheckSpikeBelt()



{
  int timeNow;

  Car_tObj *pCVar1;

  int freshenElapsed;



  freshenElapsed = 0;

  if (AICop_spikeBelt.active_ != 0) {

    timeNow = D_8011E0B0[0];

    timeNow -= AICop_spikeBelt.freshenTime_;

    timeNow = timeNow < 0x140;

    freshenElapsed = !timeNow;  /* MATCH: split bool + ! emits slti+sltiu (seq); `> 0x13f` emits slti+xori */

  }

  if (freshenElapsed) {

    pCVar1 = AILife_IsSliceInAnyVisibleArea(AICop_spikeBelt.slice_);

    if (pCVar1 == (Car_tObj *)0x0) {

      BWorld_InitSpikeBelt();

      AICop_spikeBelt.active_ = 0;

    }

    else {

      AICop_spikeBelt.freshenTime_ = D_8011E0B0[0];

    }

  }

  if ((AICop_gRoadBlockState == 2) &&

     (pCVar1 = AILife_IsSliceInAnyVisibleArea(Object_customSliceNum),

     pCVar1 == (Car_tObj *)0x0)) {

    Object_ClearCustomObjects();

    AICop_gRoadBlockState = 0;

  }

  return;

}








/* ---- ShouldIPerformCutOffBlock__15AIHigh_BasicCopiP8Car_tObj  AIHigh_BasicCop::ShouldIPerformCutOffBlock  [AIH_BASICCOP.CPP:83-193] SLD-VERIFIED ---- */

int AIHigh_BasicCop::ShouldIPerformCutOffBlock(int chancePerSecond,Car_tObj *target)



{
  int chanceForElapsedTime;
  int chanceOutOf1000;
  int random1000;
  int targetLatPosition;
  int relLatPosition;
  int absRelLatPosition;
  int metersBetween;
  int carLength;

  /* H18: full body reconstructed from oracle 0x8005C2B4-0x8005C410 (was stubbed `return 0`, so the
     cut-off block could never fire). this=$s1, target=$s0; cop car = this->carObj_, RE-DERIVED
     fresh at each use (NOT hoisted into a saved local) -- the oracle re-derefs this->carObj_ both
     before AND after the AIWorld_SplineDistance call rather than caching it across the call. */
  chanceForElapsedTime = (chancePerSecond / 32) * AI_elapsedTime;          /* 0x8005C2DC-E4 */
  chanceOutOf1000 = (chanceForElapsedTime * 1000) / 0x10000;              /* *125<<3 then signed >>16, 0x8005C2E8-F8 / C320 */

  randtemp = fastRandom * randSeed;                                        /* 0x8005C31C/330 */
  fastRandom = fastRandom * randSeed & 0xffff;                             /* 0x8005C328/340 */
  random1000 = (int)((((randtemp >> 8) & 0xffff) * 1000) >> 16);           /* 0x8005C334-358 (randtemp u_int -> logical shifts) */

  if (random1000 < chanceOutOf1000) {                                      /* 0x8005C35C/360 */
    targetLatPosition = *(int *)((char *)target + 1396);

    relLatPosition = *(int *)((char *)this->carObj_ + 1396) - targetLatPosition;   /* 0x8005C36C-378 */
    absRelLatPosition = __builtin_abs(relLatPosition);
    if ((*(int *)((char *)target + 308) + 0x10000) < absRelLatPosition &&  /* 0x8005C388-398 */
        absRelLatPosition <= 0x3FFFF) {                                    /* 0x8005C39C-3A8 */
      metersBetween = AIWorld_SplineDistance(this->carObj_, target);      /* 0x8005C3B0 */
      carLength = metersBetween * *(int *)((char *)this->carObj_ + 1364);  /* 0x8005C3B8-C8/DC */
      if ((*(int *)((char *)target + 316) * 2 + 0x20000) < carLength &&    /* 0x8005C3CC-E4 */
          carLength < 0xC0000) {   /* H18-fix: was `0xBFFFF < carLength` (wrong polarity/logic --
                                       traced the beqz+delay-slot-1 idiom at 0x8005C3F4/F8: branch
                                       TAKEN (v1==0) skips the v0-reset and returns the delay slot's
                                       v0=1 -- so it's an UPPER-cap range check, not an open lower
                                       bound; verify_asm PASS confirms) 0x8005C3E8-F4 */
        return 1;                                                          /* 0x8005C3F8 */
      }
    }
  }
  return 0;                                                                /* 0x8005C3FC / C400 */

}








/* ---- Blockade_AddRoadFlare__FP8coorddef  Blockade_AddRoadFlare  [AIH_BASICCOP.CPP:119-193] SLD-VERIFIED ---- */

void Blockade_AddRoadFlare(coorddef *pos)



{
  Trk_SFX*sfxInstance;

  Group *pGVar1;

  Group *pGVar2;

  int iVar3;

  

  pGVar1 = Object_customSFXInst;

  pGVar2 = pGVar1 + 1;

  pGVar2 = pGVar2 + pGVar1->m_num_elements * 4;

  pGVar2->m_num_elements = pos->x;

  pGVar2[1].m_num_elements = pos->y;

  iVar3 = pos->z;

  *(u_short *)&pGVar2[3].m_num_elements = 0x16;

  *(u_short *)((int)&pGVar2[3].m_num_elements + 2) = 0;

  pGVar2[2].m_num_elements = iVar3;

  pGVar1->m_num_elements = pGVar1->m_num_elements + 1;

  return;

}








/* ---- Blockade_AddObject__FiP8coorddefi  Blockade_AddObject  [AIH_BASICCOP.CPP:134-193] SLD-VERIFIED ---- */

void Blockade_AddObject(int slice,coorddef *pos,int objectID)



{
  SceneElem theObj;

  BWorldSm_Pos slicePos;

  coorddef *roty;

  coorddef *rotz;

  coorddef *rotx;

  coorddef crossVec;

  coorddef normVec;

  coorddef fwdVec;

  /* H18-a6: full body reconstructed from oracle 0x8005C468-0x8005C5E0 (was a byte-offset hack
     into an undersized u_char[32] array, causing a ~184-byte frame overshoot / wrong reg alloc).
     theObj is the real SceneElem (92 B); only 8 of its fields are ever written by the oracle --
     size/committed/visible/height/orient are left uninitialized, faithfully reproduced by NOT
     assigning them. theObj.subType=1 is the PRE-CALL v0 literal stored in the Object_GetObjDefID
     jal's delay slot (0x8005C488/9C); theObj.scalar1 is the ACTUAL call return (0x8005C4B4). */
  theObj.type = 0;

  theObj.subType = 1;

  theObj.subTypeIndex = objectID;

  theObj.scalar1 = Object_GetObjDefID(objectID);

  theObj.scalar2 = 0x23916;

  theObj.cp.x = pos->x;

  theObj.cp.y = pos->y;

  theObj.cp.z = pos->z;

  BWorldSm_SetSlice(slice,&slicePos);

  BWorldSm_FindClosestQuadRez(pos,&slicePos,1);

  roty = BWorldSm_UNormal(&slicePos);

  normVec = *roty;

  rotz = BWorldSm_UForward(&slicePos);

  fwdVec = *rotz;

  roty = &normVec;

  rotz = &fwdVec;

  crossVec.x = fixedmult(roty->y,rotz->z) - fixedmult(roty->z,rotz->y);

  rotx = &crossVec;

  rotx->y = fixedmult(roty->z,rotz->x) - fixedmult(roty->x,rotz->z);

  rotx->z = fixedmult(roty->x,rotz->y) - fixedmult(roty->y,rotz->x);

  transpose((MATRIX *)rotx,(MATRIX *)rotx);

  Object_AddCustomObject(&theObj,1);

  return;

}



/* ---- PlacePointOnRoad__FiP8coorddef  PlacePointOnRoad  [AIH_BASICCOP.CPP:165-193] SLD-VERIFIED ---- */

void PlacePointOnRoad(int slice,coorddef *offset)



{
  coorddef slicecenter;

  BWorldSm_Pos testSimRoadInfo;

  coorddef ioff;

  int cVar1;

  int cVar2;

  int cVar3;

  int *piVar4;

  coorddef *norm;

  coorddef *pointOnPlane;

  int iVar11;

  int iVar13;

  /* H18-a6: full body reconstructed from oracle 0x8005C5E4-0x8005C78C. Was a manual field-by-field
     unpack (short/masked-word/int stores across a hand-rolled 16-B/iter pointer-walk loop) copying
     Cars_gHumanRaceCarList[0]+8 into a local BWorldSm_Pos -- the oracle does a PLAIN 132-byte struct
     assignment (testSimRoadInfo = car->N.simRoadInfo; -- BO_tNewtonObj.simRoadInfo sits at +0x8,
     which is exactly the pointer-walk's start/end bounds), which gcc lowers to its OWN memcpy-shaped
     loop; the field-decomposed hand-written form was ~2x oracle size (368B frame vs 208B). The
     offset->x/y/z arithmetic below was already correct and is kept verbatim. */
  ioff = *offset;

  testSimRoadInfo = Cars_gHumanRaceCarList[0]->N.simRoadInfo;

  testSimRoadInfo.slice = (short)slice;

  piVar4 = (int *)(slice * 0x20 + (int)BWorldSm_slices);

  slicecenter.x = *piVar4;

  slicecenter.y = piVar4[1];

  slicecenter.z = piVar4[2];

  iVar11 = slice * 0x20 + (int)BWorldSm_slices;

  cVar1 = *(signed char *)(iVar11 + 0x14);

  cVar2 = *(signed char *)(iVar11 + 0xf);

  cVar3 = *(signed char *)(iVar11 + 0x11);

  iVar11 = fixedmult((int)*(signed char *)(iVar11 + 0x12) << 9,ioff.x);

  iVar13 = fixedmult((int)cVar2 << 9,ioff.z);

  offset->x = slicecenter.x + iVar11 + iVar13;

  offset->y = slicecenter.y;

  iVar11 = fixedmult((int)cVar1 << 9,ioff.x);

  iVar13 = fixedmult((int)cVar3 << 9,ioff.z);

  offset->z = slicecenter.z + iVar11 + iVar13;

  BWorldSm_FindClosestQuadRez(offset,&testSimRoadInfo,1);

  norm = BWorldSm_UNormal(&testSimRoadInfo);

  if (testSimRoadInfo.simQuad == (Trk_NewSimQuad *)0x0) {

    pointOnPlane = (coorddef *)((int)BWorldSm_slices + testSimRoadInfo.slice * 0x20);

  }

  else {

    pointOnPlane = testSimRoadInfo.quadPts;

  }

  iVar11 = GetPlaneY(norm,pointOnPlane,offset);

  offset->y = iVar11;

  return;

}



/* ---- SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t  AIHigh_BasicCop::SetupBlockadeElements  [AIH_BASICCOP.CPP:198-290] SLD-VERIFIED ---- */

void AIHigh_BasicCop::SetupBlockadeElements(blockade_t *blockade)



{
  coorddef pt;
  int objId;

  int slice;

  /* H18-a6: block-scoped the 4 loop bodies to match the oracle's SYM/disasm-v4 comments, which
     show a FRESH "int i;"/"struct coorddef pt;" pseudo per { } block (0x8005C7E8/C838/C8A8/C900) --
     the old flattened function-scope iVar1/iVar2/iVar3 reused across all 4 loops forced their live
     ranges to overlap, needing 9 saved regs (88 B frame) vs the oracle's 6 (64 B); see catalog
     "SYM block scopes are load-bearing". Arithmetic/control-flow unchanged, verified against oracle
     0x8005C790-0x8005CA04. */
  if (blockade->flags != 0) {

    Object_ClearCustomObjects();

    slice = blockade->slice;

    Object_customSliceNum = slice;

    if ((blockade->flags & 1U) == 0) {

      if ((blockade->flags & 2U) != 0) {

        {
          int i;
          int x;
          int z;

          i = 0;

          x = -0x60000;

          z = -0x180000;

          do {

            pt.y = 0;

            pt.z = blockade->direction * z;

            i = i + 1;

            pt.x = x;

            PlacePointOnRoad(slice,&pt);

            Blockade_AddRoadFlare(&pt);

            z = z + 0x40000;

            x = x + 0x20000;

          } while (i < 7);
        }

        {
          int i;
          int x;
          int z;

          i = 0;

          z = -0x180000;

          x = 0x60000;

          do {

            if (i != 3) {

              pt.y = 0;

              pt.z = blockade->direction * z;

              pt.x = x;

              PlacePointOnRoad(slice,&pt);

              Blockade_AddRoadFlare(&pt);

            }

            z = z + 0x40000;

            x = x + -0x20000;

            i = i + 1;

          } while (i < 7);
        }

      }

    }

    else {

      {
        int i;
        int z;

        i = 0;

        z = -0x100000;

        pt.x = 0;

        do {

          pt.y = 0;

          pt.z = blockade->direction * z;

          i = i + 1;

          PlacePointOnRoad(slice,&pt);

          Blockade_AddRoadFlare(&pt);

          z = z + 0x40000;

          pt.x = i * 0x20000;

        } while (i < 5);
      }

      {
        int i;
        int x;
        int z;

        i = 1;

        z = -0xc0000;

        x = -0x20000;

        do {

          pt.x = x;

          x = pt.x;

          pt.y = 0;

          pt.z = blockade->direction * z;

          i = i + 1;

          PlacePointOnRoad(slice,&pt);

          Blockade_AddRoadFlare(&pt);

          z = z + 0x40000;

          x = x + -0x20000;

        } while (i < 5);
      }

    }

    if (((blockade->flags & 4U) != 0) &&

       (objId = Object_FindDefWithThisID(3), objId != -1)) {

      pt.x = -0x28000;

      pt.y = 0;

      pt.z = blockade->direction * -0x40000;

      PlacePointOnRoad(slice,&pt);

      Blockade_AddObject(slice,&pt,objId);

      pt.x = 0x28000;

      pt.y = 0;

      pt.z = blockade->direction * -0x40000;

      PlacePointOnRoad(slice,&pt);

      Blockade_AddObject(slice,&pt,objId);

    }

    blockade->flags = 0;

  }

  return;

}








/* ---- HandleBlockadeSpeech__15AIHigh_BasicCop  AIHigh_BasicCop::HandleBlockadeSpeech  [AIH_BASICCOP.CPP:298-339] SLD-VERIFIED ---- */

void AIHigh_BasicCop::HandleBlockadeSpeech()



{
  Car_tObj*theCar;
  int carSlice;
  int sliceDiff;
  int checkSlice;

  u_short uVar1;

  u_short uVar2;

  int iVar3;

  Speaker *pSVar4;

  Car_tObj *pCVar5;

  int iVar6;

  

  uVar1 = (this->blockade_).blockadeSpeechFlags;

  if ((this->blockade_).blockadeSpeechFlags != 0) {

    pCVar5 = ((this->blockade_).target)->carObj_;

    if ((pCVar5 == (Car_tObj *)0x0) ||

       (iVar6 = (pCVar5->stats).slice - (this->blockade_).slice, pCVar5->blowout != 0)) {

      (this->blockade_).blockadeSpeechFlags = 0;

    }

    else {

      iVar3 = iVar6;

      if (iVar6 < 0) {

        iVar3 = -iVar6;

      }

      if (iVar3 < 0x21) {

        iVar3 = (Cars_topSpeedCap[(pCVar5->render).currentCarType] * 0x1c) / 0x640000;

        uVar2 = uVar1 | 2;

        if ((iVar6 < iVar3) || (uVar2 = uVar1 | 4, iVar3 < iVar6)) {

          (this->blockade_).blockadeSpeechFlags = uVar2;

        }

        if (((this->blockade_).blockadeSpeechFlags & 6U) == 6) {

          pSVar4 = (Speaker *)Speech_Mobile(this->carObj_);

          /* manual-vtable slot 7 (raw byte offsets from the oracle jalr/lh -- __vtbl_ptr_type
             is 8 bytes, so a typed _vf[N] index/pointer-add is 8x too large; decay to a byte
             base and use the RAW displacement, §3.12 lever #10). */
          (**(int (**)(...))((char *)pSVar4->_vf + 0x3c))

                    ((int)&(pSVar4->fPosition).flags + (int)*(short *)((char *)pSVar4->_vf + 0x38));

          (this->blockade_).blockadeSpeechFlags = 0;

          AICop_gRoadBlockState = 2;

        }

      }

    }

  }

  return;

}







/* end of aih_basiccop.cpp */
