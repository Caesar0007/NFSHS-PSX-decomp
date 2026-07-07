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

    freshenElapsed = timeNow > 0x13f;

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
  coorddef*rotx;
  coorddef*roty;
  coorddef*rotz;

  coorddef *pcVar1;

  int iVar2;

  u_char local_100 [32];

  int local_e0;

  int local_dc;

  int local_d8;

  int local_d4;

  int local_d0;

  int local_cc;

  int local_c8;

  int local_c4;

  int local_c0;

  int local_bc;

  int local_b8;

  int local_b4;

  int local_b0;

  BWorldSm_Pos BStack_a0;

  

  (*(int *)&(local_100)) = 0;

  local_bc = 1;

  local_b4 = Object_GetObjDefID(objectID);

  local_b0 = 0x23916;

  (*(int *)((u_char *)&(local_100) + 16)) = pos->x;

  (*(int *)((u_char *)&(local_100) + 20)) = pos->y;

  (*(int *)((u_char *)&(local_100) + 24)) = pos->z;

  local_b8 = objectID;

  BWorldSm_SetSlice(slice,&BStack_a0);

  BWorldSm_FindClosestQuadRez(pos,&BStack_a0,1);

  pcVar1 = BWorldSm_UNormal(&BStack_a0);

  local_d4 = pcVar1->x;

  local_d0 = pcVar1->y;

  local_cc = pcVar1->z;

  pcVar1 = BWorldSm_UForward(&BStack_a0);

  local_c8 = pcVar1->x;

  local_c4 = pcVar1->y;

  local_c0 = pcVar1->z;

  iVar2 = fixedmult(local_d0,local_c0);

  local_e0 = fixedmult(local_cc,local_c4);

  local_e0 = iVar2 - local_e0;

  iVar2 = fixedmult(local_cc,local_c8);

  local_dc = fixedmult(local_d4,local_c0);

  local_dc = iVar2 - local_dc;

  iVar2 = fixedmult(local_d4,local_c4);

  local_d8 = fixedmult(local_d0,local_c8);

  local_d8 = iVar2 - local_d8;

  transpose((MATRIX *)&local_e0,(MATRIX *)&local_e0);

  Object_AddCustomObject((SceneElem *)local_100,1);

  return;

}








/* ---- PlacePointOnRoad__FiP8coorddef  PlacePointOnRoad  [AIH_BASICCOP.CPP:165-193] SLD-VERIFIED ---- */

void PlacePointOnRoad(int slice,coorddef *offset)



{
  coorddef slicecenter;
  BWorldSm_Pos testSimRoadInfo;
  coorddef ioff;
  int vecXz;
  int vecZx;
  int vecZz;

  char cVar1;

  char cVar2;

  char cVar3;

  int *piVar4;

  coorddef *norm;

  u_int *puVar5;

  coorddef *pointOnPlane;

  BWorldSm_Pos *pBVar6;

  u_int uVar7;

  int iVar8;

  u_int uVar9;

  int iVar10;

  int iVar11;

  int iVar12;

  int iVar13;

  BWorldSm_Pos local_b0;

  int local_28;

  int local_24;

  int local_20;

  

  pBVar6 = &local_b0;

  local_28 = offset->x;

  local_24 = offset->y;

  local_20 = offset->z;

  puVar5 = (u_int *)((char *)Cars_gHumanRaceCarList[0] + 8);

  do {

    uVar7 = *puVar5;

    uVar9 = puVar5[1];

    iVar11 = puVar5[2];

    iVar13 = puVar5[3];

    pBVar6->slice = (short)uVar7;

    pBVar6->stripQuadInd = (short)((u_int)uVar7 >> 0x10);

    *(u_int *)&pBVar6->simRotFlag = uVar9;

    pBVar6->quadPts[0].x = iVar11;

    pBVar6->quadPts[0].y = iVar13;

    puVar5 = puVar5 + 4;

    pBVar6 = (BWorldSm_Pos *)&pBVar6->quadPts[0].z;

  } while (puVar5 != (u_int *)((char *)Cars_gHumanRaceCarList[0] + 0x88));

  *(int *)pBVar6 = *(int *)((char *)Cars_gHumanRaceCarList[0] + 0x88);

  local_b0.slice = (short)slice;

  piVar4 = (int *)(slice * 0x20 + BWorldSm_slices);

  iVar8 = *piVar4;

  iVar10 = piVar4[1];

  iVar12 = piVar4[2];

  iVar11 = slice * 0x20 + BWorldSm_slices;

  cVar1 = *(char *)(iVar11 + 0x14);

  cVar2 = *(char *)(iVar11 + 0xf);

  cVar3 = *(char *)(iVar11 + 0x11);

  iVar11 = fixedmult((int)*(char *)(iVar11 + 0x12) << 9,local_28);

  iVar13 = fixedmult((int)cVar2 << 9,local_20);

  offset->x = iVar8 + iVar11 + iVar13;

  offset->y = iVar10;

  iVar11 = fixedmult((int)cVar1 << 9,local_28);

  iVar13 = fixedmult((int)cVar3 << 9,local_20);

  offset->z = iVar12 + iVar11 + iVar13;

  BWorldSm_FindClosestQuadRez(offset,&local_b0,1);

  norm = BWorldSm_UNormal(&local_b0);

  if (local_b0.simQuad == (Trk_NewSimQuad *)0x0) {

    pointOnPlane = (coorddef *)(BWorldSm_slices + local_b0.slice * 0x20);

  }

  else {

    pointOnPlane = local_b0.quadPts;

  }

  iVar11 = GetPlaneY(norm,pointOnPlane,offset);

  offset->y = iVar11;

  return;

}








/* ---- SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t  AIHigh_BasicCop::SetupBlockadeElements  [AIH_BASICCOP.CPP:198-290] SLD-VERIFIED ---- */

void AIHigh_BasicCop::SetupBlockadeElements(blockade_t *blockade)



{
  coorddef pt;
  int i;
  int objId;

  int iVar1;

  int iVar2;

  int iVar3;

  int slice;

  coorddef local_30;

  

  if (blockade->flags != 0) {

    Object_ClearCustomObjects();

    slice = blockade->slice;

    iVar1 = 0;

    Object_customSliceNum = slice;

    if ((blockade->flags & 1U) == 0) {

      iVar1 = -0x60000;

      if ((blockade->flags & 2U) != 0) {

        iVar3 = 0;

        iVar2 = -0x180000;

        do {

          local_30.y = 0;

          local_30.z = blockade->direction * iVar2;

          iVar3 = iVar3 + 1;

          local_30.x = iVar1;

          PlacePointOnRoad(slice,&local_30);

          Blockade_AddRoadFlare(&local_30);

          iVar2 = iVar2 + 0x40000;

          iVar1 = iVar1 + 0x20000;

        } while (iVar3 < 7);

        iVar1 = 0;

        iVar3 = -0x180000;

        iVar2 = 0x60000;

        do {

          if (iVar1 != 3) {

            local_30.y = 0;

            local_30.z = blockade->direction * iVar3;

            local_30.x = iVar2;

            PlacePointOnRoad(slice,&local_30);

            Blockade_AddRoadFlare(&local_30);

          }

          iVar3 = iVar3 + 0x40000;

          iVar2 = iVar2 + -0x20000;

          iVar1 = iVar1 + 1;

        } while (iVar1 < 7);

      }

    }

    else {

      iVar2 = -0x100000;

      local_30.x = 0;

      do {

        local_30.y = 0;

        local_30.z = blockade->direction * iVar2;

        iVar1 = iVar1 + 1;

        PlacePointOnRoad(slice,&local_30);

        Blockade_AddRoadFlare(&local_30);

        iVar2 = iVar2 + 0x40000;

        local_30.x = iVar1 * 0x20000;

      } while (iVar1 < 5);

      iVar3 = 1;

      iVar2 = -0xc0000;

      local_30.x = -0x20000;

      iVar1 = local_30.x;

      do {

        local_30.x = iVar1;

        iVar1 = local_30.x;

        local_30.y = 0;

        local_30.z = blockade->direction * iVar2;

        iVar3 = iVar3 + 1;

        PlacePointOnRoad(slice,&local_30);

        Blockade_AddRoadFlare(&local_30);

        iVar2 = iVar2 + 0x40000;

        iVar1 = iVar1 + -0x20000;

      } while (iVar3 < 5);

    }

    if (((blockade->flags & 4U) != 0) &&

       (iVar1 = Object_FindDefWithThisID(3), iVar1 != -1)) {

      local_30.x = -0x28000;

      local_30.y = 0;

      local_30.z = blockade->direction * -0x40000;

      PlacePointOnRoad(slice,&local_30);

      Blockade_AddObject(slice,&local_30,iVar1);

      local_30.x = 0x28000;

      local_30.y = 0;

      local_30.z = blockade->direction * -0x40000;

      PlacePointOnRoad(slice,&local_30);

      Blockade_AddObject(slice,&local_30,iVar1);

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
