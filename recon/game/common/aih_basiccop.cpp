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

  /* H22-a12: rotx/roty/rotz are NOT separate stack locals -- they're pointers straight into
     theObj.orient's 3 rows (matrixtdef.m[0..2]/[3..5]/[6..8], each a coorddef-shaped row). The
     oracle builds the object's rotation matrix IN PLACE inside theObj (orient sits at SceneElem
     +0x20, right after cp; the address arithmetic 0x30/0x3C/0x48 in the raw is exactly
     &theObj+0x20/0x2C/0x38) -- so orient is NOT left uninitialized (prior comment was wrong): it's
     row1=UNormal, row2=UForward, row0=row1 x row2 (cross product), then transposed in place. */
  theObj.type = 0;

  theObj.subType = 1;

  theObj.scalar1 = Object_GetObjDefID(objectID);

  theObj.scalar2 = 0x23916;

  theObj.cp = *pos;

  theObj.subTypeIndex = objectID;

  BWorldSm_SetSlice(slice,&slicePos);

  BWorldSm_FindClosestQuadRez(pos,&slicePos,1);

  roty = BWorldSm_UNormal(&slicePos);

  *(coorddef *)&theObj.orient.m[3] = *roty;

  rotz = BWorldSm_UForward(&slicePos);

  *(coorddef *)&theObj.orient.m[6] = *rotz;

  roty = (coorddef *)&theObj.orient.m[3];

  rotz = (coorddef *)&theObj.orient.m[6];

  rotx = (coorddef *)&theObj.orient.m[0];

  rotx->x = fixedmult(roty->y,rotz->z) - fixedmult(roty->z,rotz->y);

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

  int vecXz;

  int vecZx;

  int vecZz;

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

  slicecenter = *(coorddef *)BWorldSm_slices[slice].center;

  vecXz = (int)((signed char *)BWorldSm_slices[slice].right)[2] << 9;

  vecZx = (int)((signed char *)BWorldSm_slices[slice].forward)[0] << 9;

  vecZz = (int)((signed char *)BWorldSm_slices[slice].forward)[2] << 9;

  offset->x =
      slicecenter.x +
      fixedmult((int)((signed char *)BWorldSm_slices[slice].right)[0] << 9,
                ioff.x) +
      fixedmult(vecZx,ioff.z);

  offset->y = slicecenter.y;

  offset->z =
      slicecenter.z + fixedmult(vecXz,ioff.x) + fixedmult(vecZz,ioff.z);

  BWorldSm_FindClosestQuadRez(offset,&testSimRoadInfo,1);

  offset->y = GetPlaneY(
      BWorldSm_UNormal(&testSimRoadInfo),
      testSimRoadInfo.simQuad != (Trk_NewSimQuad *)0x0
          ? testSimRoadInfo.quadPts
          : (coorddef *)((int)BWorldSm_slices + testSimRoadInfo.slice * 0x20),
      offset);

  return;

}



/* ---- SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t  AIHigh_BasicCop::SetupBlockadeElements  [AIH_BASICCOP.CPP:198-290] SLD-VERIFIED ---- */

void AIHigh_BasicCop::SetupBlockadeElements(blockade_t *blockade)
{
  /* H22-a12: full SYM-block-scope rewrite (nfs4-f-v3.txt @0x8005C790). SYM declares a FRESH
     "coorddef pt" AUTO (same -0x30(fp) slot) per branch and a FRESH "int i" REG per loop --
     each branch's own pt/i, not one function-scope pt shared across all 4 loops -- so this
     mirrors that exactly: 1 & 2's flags-branches each get their own pt, and every do-while
     gets its own block-scoped i (SYM regs $s0/$s2 alternate per loop within a branch). The
     "skip when i==3" compare constant is loop-invariant-hoisted to match the oracle's
     `li s5,3` outside the loop. */
  if (blockade->flags != 0) {

    int slice;

    Object_ClearCustomObjects();

    slice = blockade->slice;

    Object_customSliceNum = slice;

    if ((blockade->flags & 1U) != 0) {

      coorddef pt;

      {
        int i;

        for (i = 0; i < 5; i = i + 1) {

          pt.x = i * 0x20000;

          pt.y = 0;

          pt.z = blockade->direction * (i * 0x40000 - 0x100000);

          PlacePointOnRoad(slice,&pt);

          Blockade_AddRoadFlare(&pt);

        }
      }

      {
        int i;

        for (i = 1; i < 5; i = i + 1) {

          pt.x = i * -0x20000;

          pt.y = 0;

          pt.z = blockade->direction * (i * 0x40000 - 0x100000);

          PlacePointOnRoad(slice,&pt);

          Blockade_AddRoadFlare(&pt);

        }
      }

    }

    else if ((blockade->flags & 2U) != 0) {

      coorddef pt;

      {
        int i;

        for (i = 0; i < 7; i = i + 1) {

          pt.x = i * 0x20000 - 0x60000;

          pt.y = 0;

          pt.z = blockade->direction * (i * 0x40000 - 0x180000);

          PlacePointOnRoad(slice,&pt);

          Blockade_AddRoadFlare(&pt);

        }
      }

      {
        int i;

        for (i = 0; i < 7; i = i + 1) {

          if (i != 3) {

            pt.x = 0x60000 - i * 0x20000;

            pt.y = 0;

            pt.z = blockade->direction * (i * 0x40000 - 0x180000);

            PlacePointOnRoad(slice,&pt);

            Blockade_AddRoadFlare(&pt);

          }

        }
      }

    }

    if ((blockade->flags & 4U) != 0) {

      int objId;

      objId = Object_FindDefWithThisID(3);

      if (objId != -1) {

        coorddef pt;

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
