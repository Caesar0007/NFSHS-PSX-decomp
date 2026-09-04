/* game/common/aih_basiccop.cpp -- RECONSTRUCTED (base cop AI class + blockade helpers; C++ TU)
 *   8 fns: AIHigh_BasicCop base class (ctor/CheckSpikeBelt/ShouldIPerformCutOffBlock/
 *   SetupBlockadeElements/HandleBlockadeSpeech) + 3 free fns (Blockade_AddRoadFlare/
 *   Blockade_AddObject/PlacePointOnRoad). Composition-modeled inheritance (_base_AIHigh_Base);
 *   manual _vf vtable. Faithful C++ (option A). NOT original; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "aih_basiccop_types.h"
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
  /* SYM-CODEGEN-CARRIER: freshenElapsed -- retail's short-circuit result is
     optimized out of the local table, but a distinct predicate is required
     for the exact zero initialization and slti/sltiu sequence.  The two
     `timeNow` declarations below are the exact names and lexical regions
     retained by the SLD for the elapsed-time and refresh expansions. */
  int freshenElapsed;

  freshenElapsed = 0;

  if (AICop_spikeBelt.active_ != 0) {
    int timeNow;

    timeNow = D_8011E0B0[0];
    timeNow -= AICop_spikeBelt.freshenTime_;
    timeNow = timeNow < 0x140;
    freshenElapsed = !timeNow;
  }

  if (freshenElapsed) {
    if (AILife_IsSliceInAnyVisibleArea(AICop_spikeBelt.slice_) == 0) {

      BWorld_InitSpikeBelt();

      AICop_spikeBelt.active_ = 0;

    }
    else {
      int timeNow;

      timeNow = D_8011E0B0[0];
      AICop_spikeBelt.freshenTime_ = timeNow;

    }
  }

  if ((AICop_gRoadBlockState == kAICop_RoadBlockState_PerpPassed) &&
      (AILife_IsSliceInAnyVisibleArea(Object_customSliceNum) == 0)) {

    Object_ClearCustomObjects();

    AICop_gRoadBlockState = kAICop_RoadBlockState_None;

  }

  return;

}








/* ---- ShouldIPerformCutOffBlock__15AIHigh_BasicCopiP8Car_tObj  AIHigh_BasicCop::ShouldIPerformCutOffBlock  [AIH_BASICCOP.CPP:83-193] SLD-VERIFIED ---- */

int AIHigh_BasicCop::ShouldIPerformCutOffBlock(int chancePerSecond,Car_tObj *target)



{
  int chanceForElapsedTime;
  int chanceOutOf1000;
  int random1000;
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
    relLatPosition = *(int *)((char *)this->carObj_ + 1396) -
                     *(int *)((char *)target + 1396);                     /* 0x8005C36C-378 */
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

static void Blockade_AddRoadFlare(coorddef *pos)



{
  Trk_SFX*sfxInstance;

  sfxInstance = (Trk_SFX *)Object_customSFXInst->GetData() +
                Object_customSFXInst->GetNumElements();
  sfxInstance->point[0] = pos->x;
  sfxInstance->point[1] = pos->y;
  sfxInstance->point[2] = pos->z;
  sfxInstance->type = 0x16;
  sfxInstance->pad = 0;
  Object_customSFXInst->m_num_elements++;

  return;

}








/* ---- Blockade_AddObject__FiP8coorddefi  Blockade_AddObject  [AIH_BASICCOP.CPP:134-193] SLD-VERIFIED ---- */

static void Blockade_AddObject(int slice,coorddef *pos,int objectID)



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

static void PlacePointOnRoad(int slice,coorddef *offset)



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

  if ((this->blockade_).blockadeSpeechFlags != 0) {

    theCar = ((this->blockade_).target)->GetCarObj();

    if (theCar == (Car_tObj *)0x0) {

      (this->blockade_).blockadeSpeechFlags = 0;

    }

    else {
      int carSlice;
      int sliceDiff;

      carSlice = (theCar->stats).slice;

      sliceDiff = carSlice - (this->blockade_).slice;

      if (theCar->blowout != 0) {

        (this->blockade_).blockadeSpeechFlags = 0;

      }

      else {

        if (__builtin_abs(sliceDiff) < 0x21) {
          int checkSlice;

          checkSlice =
              (Cars_topSpeedCap[(theCar->render).currentCarType] * 0x1c) /
              0x640000;

          if (sliceDiff < checkSlice) {

            (this->blockade_).blockadeSpeechFlags =
                (this->blockade_).blockadeSpeechFlags | 2;

          }

          else if (checkSlice < sliceDiff) {

            (this->blockade_).blockadeSpeechFlags =
                (this->blockade_).blockadeSpeechFlags | 4;

          }

          if (((this->blockade_).blockadeSpeechFlags & 6U) == 6) {
            Speech_Mobile(this->carObj_)->Lose();

            (this->blockade_).blockadeSpeechFlags = 0;

            AICop_gRoadBlockState = kAICop_RoadBlockState_PerpPassed;

          }

        }

      }

    }

  }

  return;

}







/* ---- ___15AIHigh_BasicCop  AIHigh_BasicCop::dtor  [AIH_BASICCOP.CPP:?] SLD-FLAG:NO_SLD ----
   The owner-scoped declaration lets this ordinary empty destructor emit the
   standalone retail symbol while derived owners still see the implicit base
   destructor that retail inlines through to AIHigh_Base. */
AIHigh_BasicCop::~AIHigh_BasicCop()
{
}







/* end of aih_basiccop.cpp */
