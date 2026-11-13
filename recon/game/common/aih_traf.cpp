/* game/common/aih_traf.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Real C++ inheritance; virtual dispatch through compiler-built vtables (8-byte
 *   __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "aih_traf_types.h"
#include "aih_traf_externs.h"

/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline int NumCars(void) { return Cars_gNumCars; }


/* Retail aih_traf.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
extern "C" int sprintf(char *buffer, char *fmt, ...);


/* ---- CheckForCops__14AIHigh_TrafficPi  AIHigh_Traffic::CheckForCops  [AIH_TRAF.CPP:32-56] SLD-VERIFIED ---- */
Car_tObj *


#line 31 "C:/nfs4/GAME/COMMON/AIH_TRAF.CPP"
AIHigh_Traffic::CheckForCops(int *closestDistance)
{
  int copLoop;
  Car_tObj*closestCop; closestCop = (Car_tObj *)0x0;

  *closestDistance = 0x4e200000;



  for (copLoop = 0; copLoop < Cars_gNumCopCars; copLoop++) {
    Car_tObj*cop;
    int sliceDistance;

    cop = Cars_gCopCarList[copLoop];
    if ((cop->AIFlags & 4U) == 0) {

      sliceDistance = AIWorld_ApxSplineDistance(this->carObj_,cop);
      sliceDistance = __builtin_abs(sliceDistance);
      if (sliceDistance < *closestDistance) {

        closestCop = cop;
        *closestDistance = sliceDistance;
      }
    } }

  return closestCop;
}








/* ---- CopCheck__14AIHigh_TrafficPi  AIHigh_Traffic::CopCheck  [AIH_TRAF.CPP:61-121] SLD-VERIFIED ----
 * 04R RECEIPT (1 diff, ours 66 / oracle 67; objdiff 98.43): the oracle's closest==0 path exits
 * PAST the v0=s0 tail (.L80065E58) with `addu v0,zero,zero` eager-stolen into the beqz slot --
 * retail REMATERIALIZES the zero from $zero while a live $s0 also holds 0.  Six spellings
 * falsified (numbers = gate diffs @insns): inline wrapper 1@66 (baseline, kept) - early
 * `return 0` 1@66 (value-merged into the s0 tail) - `return closest` 1@66 (const-propped, same
 * merge) - identity fence inside the if 6@69 (out-of-line block, polarity flip) - fence above
 * the test 3@68 (zero materializes but as `addu v0,S0,zero` + empty slot: cse substitutes the
 * live s0 zero AND the fence barrier blocks the slot sink) - end-goto return-null block 5@66
 * (merged anyway).  CLASS = methodology 3.25-3b STILL-LIVE-CONSTANT no-copy-prop identity (the
 * w47-a1 nfile fingerprint: retail rematerializes a constant that is live in a register; our
 * cc1 copy-propagates) -- not source-reachable by any spelling tried; ANGLE = instrumented-cc1
 * trace of the cse/jump decision on this site (Mode-A check first), same lane as nfile's three
 * sites.  NOT a floor: the fence-above probe proves the SHAPE is one cse substitution away. */
AIHigh_Cop *


#line 60 "C:/nfs4/GAME/COMMON/AIH_TRAF.CPP"
AIHigh_Traffic::CopCheck(int *blockade)
{
  Car_tObj*closest;
  int closestDistance;
  int speed;
  AIHigh_Cop*cop;

  *blockade = 0;
  cop = (AIHigh_Cop *)0x0;

  if (Cars_gNumCopCars == 0) {
    return cop;
  }

  closest = this->CheckForCops(&closestDistance);


  if (closest == (Car_tObj *)0x0) {
    return cop;
  }
  speed = __builtin_abs(closest->currentSpeed);



  if ((speed < 0x20000) && (closestDistance < 0x4b0000))
  {

    *blockade = 1;

    cop = (AIHigh_Cop *)highLevelAIObjs[closest->carIndex];

    if (cop->PerpTarget() == (AIHigh_Player *)0x0) {
      cop = (AIHigh_Cop *)0x0;
    }
  }

  else if ((0x20000 < speed) && (closestDistance < 0x4b0000)) {


    cop = (AIHigh_Cop *)highLevelAIObjs[closest->carIndex];
  }




















  return cop;
}








/* TU-local rodata: the case-0 initial offset {0, 0x640000, 0}. Oracle @0x800551A4 loads this
 * via 3 `lw`s and stores to the stack, NOT via 3 immediate `li`/`sw`s -- confirming the source
 * assigns from a named const struct, not per-field literals. Sits immediately before this TU's
 * own _vt_14AIHigh_Traffic in rodata -> TU-owned, not a cross-module extern. */
/* SYM-GLOBAL-CARRIER: D_800551A4
/* The type5 trigger dispatch is a real switch on this one-parameter inline: its post-inline line
   note gives the dispatch the switch's closing-brace line, and its `trigger` record sits in the
   switch scope after the case body (both = retail SYM/SLD). The earlier two-parameter
   Traffic_ReencarnateAtTrigger wrapper (extra `high`, `trigger` one level deeper) is gone. */

/* UNRESOLVED RECONSTRUCTION: retail records trigger one level shallower and
   no high parameter. This wrapper still has both mismatches; value-pointer,
   reference/member and statement-expression trials do not resolve them.
   The car read must remain late and the operation must remain type5-guarded.
   (TRIGX2) TriggerType itself now lives in shared/trigger_t.h, keyed for this TU (retail trigger_t record run). */






/* ---- HighExecute__14AIHigh_Traffic [retail AIH_TRAF.CPP:129-340;
 * 547/547 byte PASS, native/SLD recovery still open] ---- */


#line 128 "C:/nfs4/GAME/COMMON/AIH_TRAF.CPP"
void AIHigh_Traffic::HighExecute()
{
  carObj_->unlap = 0;
  carObj_->lap = 0;


  switch ((stateType_t)stateType_)
  {

  case STATE_NONE: {
        coorddef trafficOffset = { 0, 0x640000, 0 };
        if ((carObj_->carFlags & 0x400U) != 0)
        {

          this->SetState(new AIState_Idle(carObj_, 1), STATE_IDLE);
        }
        else
        {

          this->SetState(new AIState_Purgatory(carObj_), STATE_PURGATORY);
        }

        Newton_SetInitialSlicePositionOrientationEtc(&carObj_->N,0,&trafficOffset,1);
        return;
      }
  case STATE_PURGATORY: trigger_t *pNewTrigger; /* after the STATE_NONE block: retail TPDEF run `coorddef trigger_t BWorldSm_Pos` */


      if (accidentData_ != (SceneElem *)0x0)
      {
        BWorldSm_Pos spos;
        this->SetState(new AIState_Idle(carObj_, 1), STATE_IDLE);


        spos.slice = 0;
        BWorldSm_FindClosestSlice(&accidentData_->cp,&spos);
        AILife_ReencarnateTrafficByPosition
          (carObj_,(int)spos.slice,1,&accidentData_->cp,&accidentData_->orient);



        carObj_->carFlags = carObj_->carFlags | 0x400U;

        accidentData_ = (SceneElem *)0x0;
      }
      else
      { if ((state_->TestForRelease() != 0) && (this->ForcePurgatory() == 0))
        {
          pNewTrigger = CheckForNewTriggers(); if (pNewTrigger != (trigger_t *)0x0)
          {


            triggerManagerTraffic->DescribeTrigger(pNewTrigger); switch (TriggerType(pNewTrigger))

            {

            case 5:
              this->SetState(new AIState_RovingTraffic(carObj_,pNewTrigger), STATE_ROVING_TRAFFIC);
              AILife_ReencarnateTrafficByPosition(carObj_, pNewTrigger->trafficPath.slice, 1, &pNewTrigger->trafficPath.path->position, &pNewTrigger->trafficPath.orientation);


              break;
            }
          }
          else

          {

            this->SetState(new AIState_Normal(carObj_), STATE_NORMAL);
            AILife_ReencarnateTraffic(carObj_);
          }
        }
      } break;
  case STATE_NORMAL:

    {
      int blockade;
      if (AILife_EvaluateLife(carObj_) != 0)
      {

        this->SetState(new AIState_Purgatory(carObj_), STATE_PURGATORY);
      }
      else if (this->ForcePurgatory() != 0)
      {

        this->SetState(new AIState_Purgatory(carObj_), STATE_PURGATORY);
      }

      else if (CopCheck(&blockade) != (AIHigh_Cop *)0x0)
      {
        if (ignoreCops_ == 0)
        {
          randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xffff; int cRand = ((randtemp >> 8) & 0xffff) * 5 >> 0xf;
          if (blockade != 0)
          {
















            {
            AIState_Idle *idleState;



            int slice = (int)carObj_->N.simRoadInfo.slice;
            this->SetState(new AIState_Idle(carObj_, 1), STATE_IDLE);
            idleState = (AIState_Idle *)this->state_;
            idleState->SetIdlePosition( carObj_->direction == 1 ? ((u_int)BWorldSm_slices[slice].avgPavedWidthRt << 0xf) * (BWorldSm_slices[slice].laneCount & 0xf) : ((u_int)BWorldSm_slices[slice].avgPavedWidthLf << 0xf) * ((u_int)BWorldSm_slices[slice].laneCount >> 4));
            }
          }


          else {



            if (cRand <= 0)
            {



              this->SetState(new AIState_Idle(carObj_, 1), STATE_IDLE);
            {} }

            else if (cRand < 8)
            {
              AIState_Idle *idleState;



              int slice = (int)carObj_->N.simRoadInfo.slice;
              this->SetState(new AIState_Idle(carObj_, 1), STATE_IDLE);
              idleState = (AIState_Idle *)this->state_;
              idleState->SetIdlePosition( carObj_->direction == 1 ? ((u_int)BWorldSm_slices[slice].avgPavedWidthRt << 0xf) * (BWorldSm_slices[slice].laneCount & 0xf) : ((u_int)BWorldSm_slices[slice].avgPavedWidthLf << 0xf) * ((u_int)BWorldSm_slices[slice].laneCount >> 4));
            }
            else {




              ignoreCops_ = 1;
            } }
        }
      }
      else {


        ignoreCops_ = 0; } }


    break;
  case STATE_IDLE:


    {
      int blockade;
      if (AILife_EvaluateLife(carObj_) != 0)
      {
        this->SetState(new AIState_Purgatory(carObj_), STATE_PURGATORY);
      {} }

      else if ((CopCheck(&blockade) == (AIHigh_Cop *)0x0) && ((carObj_->carFlags & 0x400U) == 0))
      {
        this->SetState(new AIState_Normal(carObj_), STATE_NORMAL);
      }
    }

    break;
  case STATE_ROVING_TRAFFIC:


    {
      if (AILife_EvaluateLife(carObj_) != 0)
      {
        this->SetState(new AIState_Purgatory(carObj_), STATE_PURGATORY);
      {} }

      else if (this->ForcePurgatory() != 0)
      {

        this->SetState(new AIState_Purgatory(carObj_), STATE_PURGATORY);
      }
      else if (state_->TestForRelease() != 0)
      {
        this->SetState(new AIState_Normal(carObj_), STATE_NORMAL);
      {} }
    }
    break;
  case STATE_CHASE:
  case STATE_OFFROAD:
  case STATE_NONACTIVE: case STATE_DONUTS:
  case STATE_GOTOSLICE: case STATE_CRUISE:
  default: break;
  }





  state_->StateExecute();
}








/* ---- __14AIHigh_TrafficP8Car_tObj  AIHigh_Traffic::ctor  [AIH_TRAF.CPP:343-347] SLD-VERIFIED ---- */

#line 343 "C:/nfs4/GAME/COMMON/AIH_TRAF.CPP"
AIHigh_Traffic::AIHigh_Traffic(Car_tObj *carObj) : AIHigh_Base(carObj)
{
  this->ignoreCops_ = 0;
  this->forcePurgatory_ = 0;
  this->accidentData_ = (SceneElem *)0x0; return;

}














/* ---- CheckForNewTriggers__14AIHigh_Traffic [retail AIH_TRAF.CPP:353-433;
 * 149/149 byte PASS, native ownership exact, SLD tags+blocks exact] ---- */
/* The exchange owns retail this/newSlice/temp; the caller's same-value temp
 * copy is optimized out, without a second debug object. Both for statements
 * and the visibility early continue restore the complete retail scope tree.
 * The helper/caller literal spellings remain unproven original text. */

#line 352 "C:/nfs4/GAME/COMMON/AIH_TRAF.CPP"
trigger_t * AIHigh_Traffic::CheckForNewTriggers()
{


  for (int sortedLoop = Cars_gNumCars - 1; sortedLoop >= 0; sortedLoop--) {

    Car_tObj *testCar = Cars_gTotalSortedList[sortedLoop];
    if ((testCar->carFlags & 0x204U) != 0)
    { int dir = -1;

      AIHigh_Base *thisPlayer =
        (AIHigh_Base *)highLevelAIObjs[testCar->carIndex];
      int thisSlice;
      int startSlice;
      int endSlice;
      int fRandomChance = 0x320000;
      if (testCar->currentSpeed >= 0) { dir = 1;
      }

      thisSlice = dir * 0x2d; if (thisSlice >= 0) { thisSlice = testCar->N.simRoadInfo.slice + (thisSlice = thisSlice); if (thisSlice >= gNumSlices) { thisSlice -= gNumSlices; } } else { thisSlice = testCar->N.simRoadInfo.slice + (thisSlice = thisSlice); if (thisSlice < 0) { thisSlice += gNumSlices;
        }
      }
      int temp = thisPlayer->ExchangeTrafficTriggerCheckSlice(thisSlice);
      if (temp < thisSlice) {

        startSlice = temp;
        endSlice = thisSlice;
      } else {


        startSlice = thisSlice;
        endSlice = temp;
      }

      for (int sliceLoop = startSlice; (sliceLoop < endSlice) && ((endSlice - startSlice) < 0x32); sliceLoop++) {




        int triggerHere = triggerManagerTraffic->CheckForTriggerAtSlice (testCar->carIndex,sliceLoop); if (triggerHere != -1)
        {
          int iRandomChance = ((fRandomChance * 0x19) << 2) / 0x10000;
          randtemp = fastRandom * randSeed; fastRandom = randtemp & 0xffff; int randomValue = (((randtemp >> 8) & 0xffff) * 0x19) >> 0xe;











          if (AILife_IsSliceInAnyVisibleArea(sliceLoop) != (Car_tObj *)0x0)
            continue;





          if (randomValue < iRandomChance)
          { int unused;




            trigger_t *const trigger = triggerManagerTraffic->GetTrigger(triggerHere,&unused); /* DEVICE (exact-only): record-less const temp puts retail's return jump on the `}` line */
            return trigger; }






          else continue; /* DEVICE (exact-only): redundant continue = retail line note before the if-scope ends (zero code) */
        }

      }
    }
  }
  return (trigger_t *)0x0;

}





class AIHigh_Traffic;
/* end of aih_traf.cpp */
