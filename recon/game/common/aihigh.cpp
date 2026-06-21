/* game/common/aihigh.cpp -- RECONSTRUCTED (AIHigh subsystem base + orchestrators; C++ TU)
 *   14 fns: AIHigh_StartUp/Restart1/Restart2/CleanUp/Execute free orchestrators + AIHigh_Base
 *   ctor/dtor + cfront weak comdat fragments (AIHigh_None HighExecute/dtor, AIState_None
 *   Execute/dtor, AIState_Base TestForRelease/dtor, AIHigh_BTC_Perp dtor [also in sibling objs]).
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable. Faithful C++ (option A).
 *   NOT original; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "../../nfs4_types.h"
#include "aihigh_externs.h"

/* ---- #75: aihigh.obj-owned anonymous vtables (real nfs4-f.exe bytes; pfn VAs symbolicated) ---- */
extern "C" int __pure_virtual(...);   /* @0x800e4354 (eaclib cfront runtime) */
static int _vtdtor_AIHigh_BTC_Perp(AIHigh_BTC_Perp *p){ p->~AIHigh_BTC_Perp(); return 0; }   /* @0x8005b438 */
static int _vtdtor_AIHigh_None(AIHigh_None *p){ p->~AIHigh_None(); return 0; }   /* @0x8005b468 */
__vtbl_ptr_type AIHigh_kVtbl_80054dcc[4] = {   /* @0x80054dcc  BTC_Perp-family abstract vtable: {null, __pure_virtual, ~AIHigh_BTC_Perp, AIHigh_BasicPerp::CheckForCrimes}. Distinct from size-3 AIHigh_BTC_Perp_vtable@0x80054fe0. Address-name = #148 cleanup carry-over. */
  {0, 0, (int (*)(...))0},                                  /* @0x80054dcc */
  {0, 0, (int (*)(...))&__pure_virtual},                    /* @0x80054dd4  fn=0x800e4354 __pure_virtual */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_BTC_Perp},           /* @0x80054ddc  fn=0x8005b438 ~AIHigh_BTC_Perp */
  {0, 0, (int (*)(...))&AIHigh_BasicPerp::CheckForCrimes},  /* @0x80054de4  fn=0x8005b500 */
};
__vtbl_ptr_type AIHigh_None_vtable[3] = {   /* @0x80054dec (AIHigh_None vtable) */
  {0, 0, (int (*)(...))0},                                  /* @0x80054dec */
  {0, 0, (int (*)(...))&AIHigh_None::HighExecute},          /* @0x80054df4  fn=0x8005b460 */
  {0, 0, (int (*)(...))&_vtdtor_AIHigh_None},               /* @0x80054dfc  fn=0x8005b468 ~AIHigh_None */
};

/* ---- aihigh.obj-owned globals (.bss zero) ---- */
AIHigh_Base  *highLevelAIObjs[9];   /* @0x8010cd38  (bss(zero)) */
int          AIHigh_CopGameType;   /* @0x8013c55c  (bss(zero)) */


/* ---- AIHigh_StartUp__Fv  AIHigh_StartUp  [AIHIGH.CPP:58-105] SLD-VERIFIED ---- */

void AIHigh_StartUp(void)



{
  int carLoop;
  int copCounter;
  int humanCopCounter;
  Car_tObj*carObj;

  AIHigh_BTC_HumanCop *newObj;

  AIHigh_BTC_AIPerp *pAVar1;

  void **ppvVar2;

  AIHigh_Traffic *pAVar3;

  AIHigh_BTC_Wingman *this_00;

  AIHigh_Human *this_01;

  AIHigh_Base *pAVar4;

  AIHigh_Opponent *pAVar5;

  AIHigh_Cop *pAVar6;

  u_int uVar7;

  Car_tObj *pCVar8;

  int iVar9;

  int iVar10;

  int iVar11;

  int iVar12;

  Car_tObj **ppCVar13;

  AIHigh_Base **ppAVar14;

  

  iVar12 = 0;

  AIState_StartUp();

  if (((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&

     ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||

      ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) {

    ppCVar13 = Cars_gList;

    iVar11 = 0;

    for (iVar10 = 0; iVar10 < Cars_gNumCars; iVar10 = iVar10 + 1) {

      pCVar8 = *ppCVar13;

      uVar7 = pCVar8->carFlags;

      if ((uVar7 & 0x200) == 0) {

        iVar9 = iVar11;

        if ((uVar7 & 4) == 0) {

          if ((uVar7 & 8) == 0) {

            if ((uVar7 & 0x10) == 0) {

              if ((uVar7 & 0x20) == 0) {

                pAVar1 = operator new(0x18);

                (new((AIHigh_Base *)pAVar1) AIHigh_Base(pCVar8));

                ppvVar2 = (void **)&AIHigh_None_vtable;

                goto LAB_8005af74;

              }

              this_00 = operator new(0x7c);

              iVar9 = iVar11 + 1;

              pAVar1 = (AIHigh_BTC_AIPerp *) (new(this_00) AIHigh_BTC_Wingman(pCVar8,iVar11));

            }

            else {

              pAVar3 = operator new(0x24);

              pAVar1 = (AIHigh_BTC_AIPerp *) (new(pAVar3) AIHigh_Traffic(pCVar8));

            }

          }

          else {

            pAVar1 = operator new(0xac);

            pAVar1 = (new(pAVar1) AIHigh_BTC_AIPerp(pCVar8));

          }

        }

        else {

          pAVar1 = operator new(0x88);

          (new((AIHigh_BasicPerp *)pAVar1) AIHigh_BasicPerp(pCVar8));

          (pAVar1->_base_AIHigh_BTC_Perp)._base_AIHigh_BasicPerp._base_AIHigh_Base._vf =

               (__vtbl_ptr_type (*) [3])&AIHigh_kVtbl_80054dcc;

          (pAVar1->_base_AIHigh_BTC_Perp).caught_ = 1;

          ppvVar2 = (void **)AIHigh_BTC_HumanPerp_vtable;

          (pAVar1->_base_AIHigh_BTC_Perp).hudActivated_ = 0;

          (pAVar1->_base_AIHigh_BTC_Perp).originalActivationCop_ = (AIHigh_BTC_HumanCop *)0x0;

LAB_8005af74:

          (pAVar1->_base_AIHigh_BTC_Perp)._base_AIHigh_BasicPerp._base_AIHigh_Base._vf =

               (__vtbl_ptr_type (*) [3])ppvVar2;

        }

      }

      else {

        newObj = operator new(0x8c);

        pAVar1 = (AIHigh_BTC_AIPerp *)

                 (new(newObj) AIHigh_BTC_HumanCop(pCVar8,iVar11))

        ;

        iVar9 = iVar11 + 1;

      }

      highLevelAIObjs[iVar10] = (AIHigh_Base *)pAVar1;

      if ((pCVar8->carFlags & 0x200U) != 0) {

        iVar12 = iVar12 + 1;

      }

      ppCVar13 = ppCVar13 + 1;

      iVar11 = iVar9;

    }

    if (iVar12 == 2) {

      AIHigh_CopGameType = 3;

    }

    else if ((iVar12 == 1) && (iVar11 == 1)) {

      AIHigh_CopGameType = 4;

    }

    else {

      AIHigh_CopGameType = 2;

    }

  }

  else {

    ppAVar14 = highLevelAIObjs;

    ppCVar13 = Cars_gList;

    iVar12 = 0;

    for (iVar11 = iVar12; iVar11 < Cars_gNumCars; iVar11 = iVar11 + 1) {

      pCVar8 = *ppCVar13;

      uVar7 = pCVar8->carFlags;

      if ((uVar7 & 4) == 0) {

        if ((uVar7 & 8) == 0) {

          if ((uVar7 & 0x10) == 0) {

            if ((uVar7 & 0x20) == 0) {

              pAVar4 = operator new(0x18);

              (new(pAVar4) AIHigh_Base(pCVar8));

              pAVar4->_vf = (__vtbl_ptr_type (*) [3])&AIHigh_None_vtable;

              *ppAVar14 = pAVar4;

            }

            else {

              pAVar6 = operator new(0x6c);

              pAVar6 = (new(pAVar6) AIHigh_Cop(pCVar8,iVar12));

              *ppAVar14 = (AIHigh_Base *)pAVar6;

              iVar12 = iVar12 + 1;

            }

          }

          else {

            pAVar3 = operator new(0x24);

            pAVar3 = (new(pAVar3) AIHigh_Traffic(pCVar8));

            *ppAVar14 = &pAVar3->_base_AIHigh_Base;

          }

        }

        else {

          pAVar5 = operator new(0xc0);

          pAVar5 = (new(pAVar5) AIHigh_Opponent(pCVar8));

          *ppAVar14 = (AIHigh_Base *)pAVar5;

        }

      }

      else {

        this_01 = operator new(0xb0);

        pAVar4 = (AIHigh_Base *)(new(this_01) AIHigh_Human(pCVar8))

        ;

        *ppAVar14 = pAVar4;

      }

      ppAVar14 = ppAVar14 + 1;

      ppCVar13 = ppCVar13 + 1;

    }

    if (iVar12 < 1) {

      AIHigh_CopGameType = 0;

    }

    else {

      AIHigh_CopGameType = 1;

    }

  }

  return;

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

  AIHigh_Base *pAVar1;

  AIHigh_Base **ppAVar2;

  int iVar3;

  

  iVar3 = 0;

  if (0 < Cars_gNumCars) {

    ppAVar2 = highLevelAIObjs;

    do {

      pAVar1 = *ppAVar2;

      if (pAVar1 != (AIHigh_Base *)0x0) {

        (**(int (**)(...))(pAVar1->_vf[6] + 2))

                  ((int)&pAVar1->carObj_ + (int)*(short *)(pAVar1->_vf[5] + 1),3);

        *ppAVar2 = (AIHigh_Base *)0x0;

      }

      iVar3 = iVar3 + 1;

      ppAVar2 = ppAVar2 + 1;

    } while (iVar3 < Cars_gNumCars);

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

        (**(int (**)(...))(pa_Var3 + 4))((int)&(*ppAVar5)->carObj_ + (int)*(short *)(pa_Var3[2] + 2));

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

    (*(int (*)(...))pAVar1->_vf[5])((int)&pAVar1->carObj_ + (int)*(short *)pAVar1->_vf[4],3);

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

    (*(int (*)(...))pAVar1->_vf[5])((int)&pAVar1->carObj_ + (int)*(short *)pAVar1->_vf[4],3);

    this->state_ = (AIState_Base *)0x0;

  }


  return;

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

AIState_None::~AIState_None()



{


  

  (this->_base_AIState_Base)._vf = (__vtbl_ptr_type (*) [4])AIState_None_vtable;


  return;

}























/* end of aihigh.cpp */
