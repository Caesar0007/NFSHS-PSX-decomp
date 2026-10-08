/* game/common/aihigh.cpp -- RECONSTRUCTED (AIHigh subsystem base + orchestrators; C++ TU)
 *   14 fns: AIHigh_StartUp/Restart1/Restart2/CleanUp/Execute free orchestrators + AIHigh_Base
 *   ctor/dtor + cfront weak comdat fragments (AIHigh_None HighExecute/dtor, AIState_None
 *   Execute/dtor, AIState_Base TestForRelease/dtor, AIHigh_BTC_Perp dtor [also in sibling objs]).
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable. Faithful C++ (option A).
 *   NOT original; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "aihigh_types.h"
#include "aihigh_externs.h"

/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline int NumCars(void) { return Cars_gNumCars; }


/* Retail aihigh.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
extern "C" int sprintf(char *, const char *, ...);

/* ---- #75: aihigh.obj-owned anonymous vtables (real nfs4-f.exe bytes; pfn VAs symbolicated) ---- */
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */
/* w66-a2: retail's dtor slot holds a REAL destructor symbol (read per slot out
 * of asm/data/*.s at the slot VA+4 -- for a class with no declared dtor that is
 * an ANCESTOR's `___<len><Base>`, w65-a3's DTOR-DEPTH LAW).  The slots below name
 * those symbols directly; the fabricated per-class wrappers
 * `static int wrap(X *p){ p->~X(); return 0; }` (an artifact of C++ forbidding
 * `&Class::~Class`) are gone. */
/* ---- aihigh.obj-owned globals (.bss zero) ---- */
AIHigh_Base  *highLevelAIObjs[9];   /* @0x8010cd38  (bss(zero)) */
AIHigh_CopGameType_t AIHigh_CopGameType;   /* @0x8013c55c  (bss(zero)) */


/* ---- AIHigh_StartUp__Fv [retail AIHIGH.CPP:58-105; 234/234 byte PASS,
 * native/SLD recovery still open] ---- */
/* Loop-owned car pointers and direct flags need no allocation fence. The
 * base-first slot-address expression preserves the retail handout at234/234.
 * newHigh/slot remain explicitly unresolved; no original-object necessity is
 * inferred from the failed alternate allocation shapes. */

void AIHigh_StartUp(void)
{

  int carLoop;
  int copCounter;
  int humanCopCounter;

  copCounter = 0;
  humanCopCounter = 0;

  AIState_StartUp();

  if (((GameSetup_gData.raceType == RaceType_HotPursuit) || (GameSetup_gData.raceType == RaceType_Id5)) &&
      (((Cars_gHumanRaceCarList[0]->carFlags & 0x200) != 0 ||
       ((Cars_gNumHumanRaceCars == 2 &&
         ((Cars_gHumanRaceCarList[1]->carFlags & 0x200) != 0)))))) {
    for (carLoop = 0; carLoop < Cars_gNumCars; carLoop++) {
      /* UNRESOLVED RECONSTRUCTION: newHigh is absent from retail locals.
         Direct allocation expressions still need their native construction/
         allocation shape recovered; current trials are recorded in sym-match. */
      AIHigh_Base *newHigh;
      /* UNRESOLVED RECONSTRUCTION: slot is absent from retail locals.
         Eliminating this address holder on the current source is237/234,
         29dif; that does not prove an original pointer object existed. */
      AIHigh_Base **slot;
      Car_tObj *carObj = Cars_gList[carLoop];
      slot = (AIHigh_Base **)((int)highLevelAIObjs + (carLoop << 2));
      if ((carObj->carFlags & 0x200U) != 0) {
        newHigh = new AIHigh_BTC_HumanCop(carObj,copCounter++);
      }
      else if ((carObj->carFlags & 4U) != 0) {
        newHigh = new AIHigh_BTC_HumanPerp(carObj);   /* inline HumanPerp/BTC_Perp ctors: caught_/hudActivated_/originalActivationCop_ */
      }
      else if ((carObj->carFlags & 8U) != 0) {
        newHigh = new AIHigh_BTC_AIPerp(carObj);
      }
      else if ((carObj->carFlags & 0x10U) != 0) {
        newHigh = new AIHigh_Traffic(carObj);
      }
      else if ((carObj->carFlags & 0x20U) != 0) {
        newHigh = new AIHigh_BTC_Wingman(carObj,copCounter++);
      }
      else {
        newHigh = new AIHigh_None(carObj);
      }
      *slot = newHigh;
      if ((carObj->carFlags & 0x200U) != 0) {
        humanCopCounter = humanCopCounter + 1;
      }
    }

    if (humanCopCounter == 2) {
      AIHigh_CopGameType = COP_GAME_BTC_2HC;
      return;
    }
    if (humanCopCounter == 1) {
      if (copCounter == humanCopCounter) {
        AIHigh_CopGameType = COP_GAME_BTC_1HC1HP;
        return;
      }
    }
    AIHigh_CopGameType = COP_GAME_BTC_1HC;
    return;
  }
  else {
    for (carLoop = 0, copCounter = carLoop;
         carLoop < Cars_gNumCars; carLoop++) {
      AIHigh_Base *newHigh;

      Car_tObj *carObj = Cars_gList[carLoop];
      if ((carObj->carFlags & 4U) != 0) {
        newHigh = new AIHigh_Human(carObj);
      }
      else if ((carObj->carFlags & 8U) != 0) {
        newHigh = new AIHigh_Opponent(carObj);
      }
      else if ((carObj->carFlags & 0x10U) != 0) {
        newHigh = new AIHigh_Traffic(carObj);
      }
      else if ((carObj->carFlags & 0x20U) != 0) {
        newHigh = new AIHigh_Cop(carObj,copCounter++);
      }
      else {
        newHigh = new AIHigh_None(carObj);
      }
      highLevelAIObjs[carLoop] = newHigh;
    }

    if (0 < copCounter) {
      AIHigh_CopGameType = COP_GAME_PURSUIT;
      return;
    }
    AIHigh_CopGameType = COP_GAME_NO;
    return;
  }
}








/* ---- AIHigh_Restart1__Fv  AIHigh_Restart1  [AIHIGH.CPP:110-111] SLD-VERIFIED ---- */

void AIHigh_Restart1(void)



{
  AIHigh_CleanUp();
}








/* ---- AIHigh_Restart2__Fv  AIHigh_Restart2  [AIHIGH.CPP:115-117] SLD-VERIFIED ---- */

void AIHigh_Restart2(void)



{
  AIState_Restart();
  AIHigh_StartUp();
}








/* ---- AIHigh_CleanUp__Fv  AIHigh_CleanUp  [AIHIGH.CPP:122-131] SLD-VERIFIED ---- */

void AIHigh_CleanUp(void)
{
  for (int carLoop = 0; carLoop < Cars_gNumCars; carLoop = carLoop + 1) {

    if (highLevelAIObjs[carLoop] != (AIHigh_Base *)0x0)
    {
      delete highLevelAIObjs[carLoop];
      highLevelAIObjs[carLoop] = (AIHigh_Base *)0x0;
    }
  }
  AIState_CleanUp();
}








inline bool AIHigh_Base::SchedulingOff() { return schedulingOff_ != 0; }

/* ---- AIHigh_Execute__Fv [retail AIHIGH.CPP:134-148; native ownership exact,
 * full SLD attribution open] ---- */
/* MATCH: 66/66 instructions, both locals/all eight scope regions. Boolean
 * query plus direct short-circuit recovers the unnamed dispatch-result funnel;
 * executeNow and the decompiler label are unnecessary. SchedulingOff's literal
 * original identifier is unproven; this is an inferred semantic query. */
void AIHigh_Execute(void)
{
  for (int carLoop = 0; carLoop < Cars_gNumCars; carLoop++) {
    Car_tObj *carObj = Cars_gList[carLoop];
    if (highLevelAIObjs[carLoop] != (AIHigh_Base *)0) {
      if (highLevelAIObjs[carLoop]->SchedulingOff() ||
          (Sched_ExecuteCheck(1,0,carObj->N.distToPlayer,carObj->N.objID,
             &AI_time,&AI_elapsedTime,&AI_iTime,carObj->forceNoSimOptz) != 0))
        highLevelAIObjs[carLoop]->HighExecute();
    }
  }
}








/* ---- __11AIHigh_BaseP8Car_tObj  AIHigh_Base::ctor  [AIHIGH.CPP:158-165] SLD-VERIFIED ---- */

AIHigh_Base::AIHigh_Base(Car_tObj *carObj)



{

  this->carObj_ = carObj;

  this->state_ = (AIState_Base *)0x0;

  this->stateType_ = 0;

  this->SetState(new AIState_None(this->carObj_),STATE_NONE);

  this->schedulingOff_ = 0;

  this->lastTrafficTriggerCheckSlice_ = (int)(this->CarObj()->N).simRoadInfo.slice;

  return;

}








/* ---- _._11AIHigh_Base  AIHigh_Base::dtor  [AIHIGH.CPP:169-276] SLD-VERIFIED ---- */

AIHigh_Base::~AIHigh_Base()



{


  if (this->state_ != (AIState_Base *)0x0) {
    delete this->state_;   /* virtual ~AIState_Base with __in_chrg 3 */

    this->state_ = (AIState_Base *)0x0;

  }


  return;

}






















/* ---- Execute__12AIState_None  AIState_None::Execute  [AIHIGH.CPP:?] SLD-FLAG:NO_SLD ---- */









/* ---- _._12AIState_None  AIState_None::dtor  [AIHIGH.CPP:?] SLD-FLAG:NO_SLD ---- */
























/* ---- TestForRelease__12AIState_Base  AIState_Base::TestForRelease  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */









/* ---- _._12AIState_Base  AIState_Base::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */








/* end of aihigh.cpp */
