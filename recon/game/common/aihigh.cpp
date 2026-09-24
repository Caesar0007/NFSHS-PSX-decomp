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


/* ---- AIHigh_StartUp__Fv  AIHigh_StartUp  [AIHIGH.CPP:58-105] SLD-VERIFIED ---- */

void AIHigh_StartUp(void)
{
  /* retail: this object's .rodata opens with the UNREFERENCED "SimpleMem" tag (expansion-time literal of the
     first non-leaf function, ahead of the vtable batch) */
  if (0) sprintf((char *)0,"SimpleMem");

  int carLoop;
  int copCounter;
  int humanCopCounter;
  Car_tObj *carObj;

  copCounter = 0;
  humanCopCounter = 0;

  AIState_StartUp();

  if (((GameSetup_gData.raceType == RaceType_HotPursuit) || (GameSetup_gData.raceType == RaceType_Id5)) &&
      ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
       ((Cars_gNumHumanRaceCars == 2 &&
         (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {
    carLoop = 0;
    while (carLoop < Cars_gNumCars) {
      /* SYM-CODEGEN-CARRIER: newHigh -- this is the single source carrier for
         the result of each reconstructed inline `new` expression.  A natural
         AIHigh_BTC_Perp -> AIHigh_BTC_HumanPerp constructor chain compiles to
         231 instructions/3 diffs because the manual-vtable model lets GCC
         delete the intermediate base vptr store; retaining that store with a
         read fence gives 236 instructions/12 diffs.  This carrier preserves
         the exact 234-instruction virtual-class construction sequence. */
      AIHigh_Base *newHigh;
      /* SYM-CODEGEN-CARRIER: slot -- direct
         `highLevelAIObjs[carLoop] = newHigh` produces 235 instructions and
         25 diffs by changing the three-qty local-allocation order. */
      AIHigh_Base **slot;
      /* SYM-CODEGEN-CARRIER: carFlags -- the retained flags value is part of
         the measured local-alloc three-qty basin documented below. */
      u_int carFlags;
      /* SYM-CODEGEN-CARRIER: copCarFlag -- its two-operand read fence moves
         refs across the QTY_CMP_PRI floor_log2 step; removing the carrier or
         either required ref produces the measured eight-diff allocation. */
      u_int copCarFlag;

      carObj = Cars_gList[carLoop];
      carFlags = carObj->carFlags;
      slot = &highLevelAIObjs[carLoop];
      copCarFlag = carFlags & 0x200U;
      /* ---- W62-A10 SEAL (was 8 diffs, 234/234, five waves) -------------------------
         MATCH: the residual was `sll`/`la` swapping $v0<->$v1 in the slot-address
         computation.  ROOT CAUSE (gcc-2.8 local-alloc.c, read not guessed): this basic
         block has EXACTLY THREE block-local qtys -- q0 = the `sll carLoop,2`, q1 = the
         `high`+`lo_sum` pair for &highLevelAIObjs (combine_regs ties them, refs 4+4=8),
         q2 = the `carFlags & 0x200` test -- and for next_qty == 3 block_alloc does NOT
         call qsort: it runs the hand-rolled `case 3:` ladder at local-alloc.c:1638-1652,
         which compares the RAW QTY NUMBERS 0/1/2 instead of the current qty_order[]
         contents.  With PRI(q1) > PRI(q0) the first EXCHANGE(0,1) is UNDONE by the
         fall-through `case 2:` EXCHANGE(0,1), so the order collapses back to [q0,q1,q2]
         unless PRI(q2) > PRI(q1) as well.  Measured: PRI = floor_log2(refs)*refs*size /
         (qty_death-qty_birth) (local-alloc.c:1727) gave q0=8/8=1.0, q1=24/6=4.0,
         q2=8/2=4.0 -- q2 TIED q1 exactly, so the sll was allocated first, took $v0 over
         its whole window, and pushed the la to $v1.
         FIX (pin-free, zero-byte): give the test qty ONE floor_log2 ref-step.  Naming
         `copCarFlag` and adding a TWO-OPERAND read-only fence takes its refs 4 -> 8
         (2 occurrences x loop depth 2, +2 per fence operand), so floor_log2 goes 2 -> 3
         and PRI(q2) = 24/2 = 12.0 > PRI(q1) = 4.0 > PRI(q0) = 1.0.  Now BOTH exchanges
         fire, qty_order becomes [q2,q1,q0], the la is allocated before the sll and takes
         $v0.  234/234 byte-exact.
         FALSIFIED HERE (all re-gated this session): ONE fence operand -> 8 (refs 6,
         floor_log2 still 2, PRI 3.0 < 4.0 -- the step is what matters, not the ref);
         naming copCarFlag with no fence -> 8; the fence pair moved ABOVE the slot
         statement -> 26 (236 insns: the and is then scheduled before the address and
         the block order changes); `slot` moved between the carObj and carFlags loads
         -> 8.  Earlier waves' falsifications (five address spellings byte-identical;
         naming the BASE costs 58 via LICM; a fence on carLoop -> 77) stand and are
         explained by the same model: the dial had to land on q2, not on q0/q1.
         DO NOT "simplify" the second `"r"(copCarFlag)` away -- the operand COUNT is the
         instrument. ------------------------------------------------------------------ */
      __asm__("" : : "r"(copCarFlag), "r"(copCarFlag));
      if (copCarFlag != 0) {
        newHigh = new AIHigh_BTC_HumanCop(carObj,copCounter++);
      }
      else if ((carFlags & 4U) != 0) {
        newHigh = new AIHigh_BTC_HumanPerp(carObj);   /* inline HumanPerp/BTC_Perp ctors: caught_/hudActivated_/originalActivationCop_ */
      }
      else if ((carFlags & 8U) != 0) {
        newHigh = new AIHigh_BTC_AIPerp(carObj);
      }
      else if ((carFlags & 0x10U) != 0) {
        newHigh = new AIHigh_Traffic(carObj);
      }
      else if ((carFlags & 0x20U) != 0) {
        newHigh = new AIHigh_BTC_Wingman(carObj,copCounter++);
      }
      else {
        newHigh = new AIHigh_None(carObj);
      }
      *slot = newHigh;
      if ((carObj->carFlags & 0x200U) != 0) {
        humanCopCounter = humanCopCounter + 1;
      }
      carLoop = carLoop + 1;
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
    carLoop = 0;
    copCounter = carLoop;
    while (carLoop < Cars_gNumCars) {
      AIHigh_Base *newHigh;

      carObj = Cars_gList[carLoop];
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
      carLoop = carLoop + 1;
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








/* ---- AIHigh_Execute__Fv  AIHigh_Execute  [AIHIGH.CPP:134-148] SLD-VERIFIED ---- */

void AIHigh_Execute(void)



{
  {
  int carLoop;

  /* SYM-CODEGEN-CARRIER: executeNow -- spelling the scheduling test directly as a
     short-circuit condition produces 61 instructions/33 diffs instead of the
     exact retail 66; this optimized boolean lifetime is absent from the
     surviving debug-local records. */
  bool executeNow;

  carLoop = 0;

  do {

    if (Cars_gNumCars <= carLoop) {

      return;

    }

    Car_tObj *carObj;
    carObj = Cars_gList[carLoop];

    if (highLevelAIObjs[carLoop] != (AIHigh_Base *)0x0) {

      executeNow = false;

      if (highLevelAIObjs[carLoop]->schedulingOff_ == 0) {

        if (Sched_ExecuteCheck(1,0,(carObj->N).distToPlayer,(carObj->N).objID,&AI_time,&AI_elapsedTime,
                               &AI_iTime,carObj->forceNoSimOptz) != 0) goto LAB_8005b2bc;

      }

      else {

LAB_8005b2bc:

        executeNow = true;

      }

      if (executeNow) {

        highLevelAIObjs[carLoop]->HighExecute();

      }

    }
    carLoop = carLoop + 1;

  } while( true );

  }
}








/* ---- __11AIHigh_BaseP8Car_tObj  AIHigh_Base::ctor  [AIHIGH.CPP:158-165] SLD-VERIFIED ---- */

AIHigh_Base::AIHigh_Base(Car_tObj *carObj)



{


  this->carObj_ = carObj;

  this->state_ = (AIState_Base *)0x0;

  this->stateType_ = 0;

  AIHigh_SetState(this, new AIState_None(this->carObj_),STATE_NONE);

  this->schedulingOff_ = 0;

  this->lastTrafficTriggerCheckSlice_ = (int)(this->carObj_->N).simRoadInfo.slice;

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
