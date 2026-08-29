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

/* ---- #75: aihigh.obj-owned anonymous vtables (real nfs4-f.exe bytes; pfn VAs symbolicated) ---- */
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */
/* w66-a2: retail's dtor slot holds a REAL destructor symbol (read per slot out
 * of asm/data/*.s at the slot VA+4 -- for a class with no declared dtor that is
 * an ANCESTOR's `___<len><Base>`, w65-a3's DTOR-DEPTH LAW).  The slots below name
 * those symbols directly; the fabricated per-class wrappers
 * `static int wrap(X *p){ p->~X(); return 0; }` (an artifact of C++ forbidding
 * `&Class::~Class`) are gone. */
extern "C" void ___11AIHigh_None(void *thisp);   /* ~AIHigh_None */
extern "C" void ___15AIHigh_BTC_Perp(void *thisp);   /* ~AIHigh_BTC_Perp */
__vtbl_ptr_type AIHigh_kVtbl_80054dcc[4] = {   /* @0x80054dcc  BTC_Perp-family abstract vtable: {null, __pure_virtual, ~AIHigh_BTC_Perp, AIHigh_BasicPerp::CheckForCrimes}. Distinct from size-3 AIHigh_BTC_Perp_vtable@0x80054fe0. Address-name = #148 cleanup carry-over. */
  {0, 0, (int (*)(...))0},                                  /* @0x80054dcc */
  {0, 0, (int (*)(...))&__pure_virtual},                    /* @0x80054dd4  fn=0x800e4354 __pure_virtual */
  {0, 0, (int (*)(...))&___15AIHigh_BTC_Perp},           /* @0x80054ddc  fn=0x8005b438 ~AIHigh_BTC_Perp */
  {0, 0, (int (*)(...))&AIHigh_BasicPerp::CheckForCrimes},  /* @0x80054de4  fn=0x8005b500 */
};
__vtbl_ptr_type AIHigh_None_vtable[3] = {   /* @0x80054dec (AIHigh_None vtable) */
  {0, 0, (int (*)(...))0},                                  /* @0x80054dec */
  {0, 0, (int (*)(...))&AIHigh_None::HighExecute},          /* @0x80054df4  fn=0x8005b460 */
  {0, 0, (int (*)(...))&___11AIHigh_None},               /* @0x80054dfc  fn=0x8005b468 ~AIHigh_None */
};

/* ---- aihigh.obj-owned globals (.bss zero) ---- */
AIHigh_Base  *highLevelAIObjs[9];   /* @0x8010cd38  (bss(zero)) */
AIHigh_CopGameType_t AIHigh_CopGameType;   /* @0x8013c55c  (bss(zero)) */


/* ---- AIHigh_StartUp__Fv  AIHigh_StartUp  [AIHIGH.CPP:58-105] SLD-VERIFIED ---- */

void AIHigh_StartUp(void)
{
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
      AIHigh_Base *newHigh;
      AIHigh_Base **slot;
      u_int carFlags;
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
        AIHigh_BTC_HumanCop *p = operator new(0x8c);
        newHigh = (AIHigh_Base *)new(p) AIHigh_BTC_HumanCop(carObj,copCounter++);
      }
      else if ((carFlags & 4U) != 0) {
        AIHigh_BTC_AIPerp *p = operator new(0x88);
        new((AIHigh_BasicPerp *)p) AIHigh_BasicPerp(carObj);
        p->_vf = (__vtbl_ptr_type (*) [3])&AIHigh_kVtbl_80054dcc;
        p->caught_ = 1;
        p->hudActivated_ = 0;
        p->originalActivationCop_ = (AIHigh_BTC_HumanCop *)0x0;
        p->_vf = (__vtbl_ptr_type (*) [3])AIHigh_BTC_HumanPerp_vtable;
        newHigh = (AIHigh_Base *)p;
      }
      else if ((carFlags & 8U) != 0) {
        AIHigh_BTC_AIPerp *p = operator new(0xac);
        newHigh = (AIHigh_Base *)new(p) AIHigh_BTC_AIPerp(carObj);
      }
      else if ((carFlags & 0x10U) != 0) {
        AIHigh_Traffic *p = operator new(0x24);
        newHigh = (AIHigh_Base *)new(p) AIHigh_Traffic(carObj);
      }
      else if ((carFlags & 0x20U) != 0) {
        AIHigh_BTC_Wingman *p = operator new(0x7c);
        newHigh = (AIHigh_Base *)new(p) AIHigh_BTC_Wingman(carObj,copCounter++);
      }
      else {
        AIHigh_Base *p = operator new(0x18);
        new(p) AIHigh_Base(carObj);
        p->_vf = (__vtbl_ptr_type (*) [3])&AIHigh_None_vtable;
        newHigh = p;
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
        AIHigh_Human *p = operator new(0xb0);
        newHigh = (AIHigh_Base *)new(p) AIHigh_Human(carObj);
      }
      else if ((carObj->carFlags & 8U) != 0) {
        AIHigh_Opponent *p = operator new(0xc0);
        newHigh = (AIHigh_Base *)new(p) AIHigh_Opponent(carObj);
      }
      else if ((carObj->carFlags & 0x10U) != 0) {
        AIHigh_Traffic *p = operator new(0x24);
        newHigh = (AIHigh_Base *)new(p) AIHigh_Traffic(carObj);
      }
      else if ((carObj->carFlags & 0x20U) != 0) {
        AIHigh_Cop *p = operator new(0x6c);
        newHigh = (AIHigh_Base *)new(p) AIHigh_Cop(carObj,copCounter++);
      }
      else {
        AIHigh_Base *p = operator new(0x18);
        new(p) AIHigh_Base(carObj);
        p->_vf = (__vtbl_ptr_type (*) [3])&AIHigh_None_vtable;
        newHigh = p;
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

  return;

}








/* ---- AIHigh_Restart2__Fv  AIHigh_Restart2  [AIHIGH.CPP:115-117] SLD-VERIFIED ---- */

void AIHigh_Restart2(void)



{

  AIState_Restart();

  AIHigh_StartUp();

  return;

}








/* ---- AIHigh_CleanUp__Fv  AIHigh_CleanUp  [AIHIGH.CPP:122-131] SLD-VERIFIED ---- */

void AIHigh_CleanUp(void)
{
  int carLoop;

  carLoop = 0;
  if (0 < Cars_gNumCars) {
    do {
      if (highLevelAIObjs[carLoop] != (AIHigh_Base *)0x0) {
        /* vtable entry 2: fn-ptr @ byte +20, this-delta @ byte +16 (byte-base, sec.3.12 #10) */
        (*(int (**)(...))((char *)highLevelAIObjs[carLoop]->_vf + 20))
                  ((int)&highLevelAIObjs[carLoop]->carObj_ +
                   (int)*(short *)((char *)highLevelAIObjs[carLoop]->_vf + 16),3);
        highLevelAIObjs[carLoop] = (AIHigh_Base *)0x0;
      }
      carLoop = carLoop + 1;
    } while (carLoop < Cars_gNumCars);
  }
  AIState_CleanUp();
  return;
}








/* ---- AIHigh_Execute__Fv  AIHigh_Execute  [AIHIGH.CPP:134-148] SLD-VERIFIED ---- */

void AIHigh_Execute(void)



{
  int carLoop;
  Car_tObj*carObj;

  bool bVar1;

  int iVar2;

  __vtbl_ptr_type (*pa_Var3) [3];

  Car_tObj *pCVar4;

  AIHigh_Base **ppAVar5;

  Car_tObj **ppCVar6;

  int iVar7;

  

  iVar7 = 0;

  ppAVar5 = highLevelAIObjs;

  ppCVar6 = Cars_gList;

  do {

    if (Cars_gNumCars <= iVar7) {

      return;

    }

    pCVar4 = *ppCVar6;

    if (*ppAVar5 != (AIHigh_Base *)0x0) {

      bVar1 = false;

      if ((*ppAVar5)->schedulingOff_ == 0) {

        iVar2 = Sched_ExecuteCheck(1,0,(pCVar4->N).distToPlayer,(pCVar4->N).objID,&AI_time,&AI_elapsedTime,

                           &AI_iTime,pCVar4->forceNoSimOptz);

        if (iVar2 != 0) goto LAB_8005b2bc;

      }

      else {

LAB_8005b2bc:

        bVar1 = true;

      }

      if (bVar1) {

        pa_Var3 = (*ppAVar5)->_vf;
        /* vtable entry 1: fn-ptr @ byte +12, this-delta @ byte +8 (byte-base, sec.3.12 #10) */
        (*(int (**)(...))((char *)pa_Var3 + 12))
            ((int)&(*ppAVar5)->carObj_ + (int)*(short *)((char *)pa_Var3 + 8));

      }

    }

    ppAVar5 = ppAVar5 + 1;

    ppCVar6 = ppCVar6 + 1;

    iVar7 = iVar7 + 1;

  } while( true );

}








/* ---- __11AIHigh_BaseP8Car_tObj  AIHigh_Base::ctor  [AIHIGH.CPP:158-165] SLD-VERIFIED ---- */

AIHigh_Base::AIHigh_Base(Car_tObj *carObj)



{

  AIState_Base *this_00;

  AIState_Base *pAVar1;

  

  this->_vf = (__vtbl_ptr_type (*) [3])AIHigh_Base_vtable;

  this->carObj_ = carObj;

  this->state_ = (AIState_Base *)0x0;

  this->stateType_ = 0;

  this_00 = operator new(8);

  (new(this_00) AIState_Base(this->carObj_));

  /* @0x8005B360-364: the AIState_Base sub-object (state_, placement-new'd above) carries the AIState_None
   * vtable (0x80054E1C), NOT AIHigh_Base_vtable (0x80054E04, 0x18 earlier). The recon wrote AIHigh_Base's
   * vtable, so virtual dispatch through state_ (Execute/dtor/TestForRelease) hit the wrong slots. The
   * [4]-cast already matched AIState_None_vtable[4] @0x80054e1c (AIHigh_Base_vtable is [3]) (M18). */
  this_00->_vf = (__vtbl_ptr_type (*) [4])AIState_None_vtable;

  pAVar1 = this->state_;

  if (pAVar1 != (AIState_Base *)0x0) {
    /* vtable entry 2: fn-ptr @ byte +20, this-delta @ byte +16 (byte-base, sec.3.12 #10) */
    (*(int (*)(...))*(int *)((char *)pAVar1->_vf + 20))
        ((int)&pAVar1->carObj_ + (int)*(short *)((char *)pAVar1->_vf + 16),3);

  }

  this->state_ = this_00;

  this->stateType_ = 0;

  this->schedulingOff_ = 0;

  this->lastTrafficTriggerCheckSlice_ = (int)(this->carObj_->N).simRoadInfo.slice;

  return;

}








/* ---- _._11AIHigh_Base  AIHigh_Base::dtor  [AIHIGH.CPP:169-276] SLD-VERIFIED ---- */

AIHigh_Base::~AIHigh_Base()



{

  AIState_Base *pAVar1;


  

  pAVar1 = this->state_;

  this->_vf = (__vtbl_ptr_type (*) [3])AIHigh_Base_vtable;

  if (pAVar1 != (AIState_Base *)0x0) {
    /* vtable entry 2: fn-ptr @ byte +20, this-delta @ byte +16 (byte-base, sec.3.12 #10) */
    (*(int (*)(...))*(int *)((char *)pAVar1->_vf + 20))
        ((int)&pAVar1->carObj_ + (int)*(short *)((char *)pAVar1->_vf + 16),3);

    this->state_ = (AIState_Base *)0x0;

  }


  return;

}












/* ---- _._15AIHigh_BTC_Perp  AIHigh_BTC_Perp::dtor  [@0x8005B438, AIHIGH.OBJ instance] ----
   W54-A15: cfront vague-linkage duplicate.  configs/symbol_addrs.txt gives the CANONICAL
   ___15AIHigh_BTC_Perp to the AIHIGH object (0x8005B438; aih_btcperp owns the VA-suffixed
   copy at 0x80061348), and src/game/common/aihigh.c INCLUDE_ASMs it -- but no aihigh TU
   emitted it (0.00% NOT-IN-OBJECT).  Same cross-TU duplicate model the tree already uses for
   TestForRelease__12AIState_Base (defined in aistate/aih_btccop/aih_btcperp alike). */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so ~AIHigh_BTC_AIPerp / ~AIHigh_BTC_HumanPerp collapse past it
 * to ___11AIHigh_Base the way retail does.  The oracle proves AIHigh_BTC_Perp
 * owns NO vtable of its own -- its standalone dtor stores _vt_16AIHigh_BasicPerp
 * (its BASE's), i.e. it is gcc INLINING AIHigh_BasicPerp's implicit reset before
 * chaining on -- so the standalone symbol is supplied here in place, with the
 * same store and C linkage. */
extern "C" void ___11AIHigh_Base(void *);
extern "C" void ___15AIHigh_BTC_Perp(void *thisp)
{
  ((AIHigh_BTC_Perp *)thisp)->_vf = (__vtbl_ptr_type (*) [3])AIHigh_BasicPerp_vtable;
  ___11AIHigh_Base(thisp);
}


/* ---- HighExecute__11AIHigh_None  AIHigh_None::HighExecute  [AIHIGH.CPP:?] SLD-FLAG:NO_SLD ---- */

void AIHigh_None::HighExecute()



{

  return;

}








/* ---- _._11AIHigh_None  AIHigh_None::dtor  [AIHIGH.CPP:?] SLD-FLAG:NO_SLD ---- */

AIHigh_None::~AIHigh_None()



{


  return;

}








/* ---- Execute__12AIState_None  AIState_None::Execute  [AIHIGH.CPP:?] SLD-FLAG:NO_SLD ---- */

void AIState_None::Execute()



{

  return;

}








/* ---- _._12AIState_None  AIState_None::dtor  [AIHIGH.CPP:?] SLD-FLAG:NO_SLD ---- */

extern void __builtin_delete(void *);
extern "C" void ___12AIState_None(AIState_None *pThis, int __in_chrg)



{


  

  pThis->_vf = (__vtbl_ptr_type (*) [4])AIState_None_vtable;
  if ((__in_chrg & 1U) != 0) {
    __builtin_delete(pThis);
  }
  return;

}























/* ---- TestForRelease__12AIState_Base  AIState_Base::TestForRelease  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

int AIState_Base::TestForRelease()



{

  return 0;

}








/* ---- _._12AIState_Base  AIState_Base::dtor  [AISTATE.CPP:?] SLD-FLAG:NO_SLD ---- */

AIState_Base::~AIState_Base()
{
  this->_vf = (__vtbl_ptr_type (*) [4])((char *)AIState_Base_vtable + 8);
  return;
}







/* end of aihigh.cpp */
