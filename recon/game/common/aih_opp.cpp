/* game/common/aih_opp.cpp -- RECONSTRUCTED (AI state-machine hierarchy; C++ TU)
 *   52 fns across 11 classes (AIState_Base + Normal/NonActive/Idle/Chase/Offroad/Purgatory/
 *   RovingTraffic/Donuts/GotoSlice/Cruise) + 3 free AIState_StartUp/Restart/CleanUp.
 *   Composition-modeled inheritance (_base_ members); manual _vf vtable dispatch (8-byte
 *   __vtbl_ptr_type entries); deleting dtors. Each ctor/dtor installs AIState_<C>_vtable.
 *   Faithful C++ (option A). NOT original source; SYM-faithful, recompilable. vs disasm-v2.
 */
#include "../../lib/nfs4_new.h"
#include "../../nfs4_types.h"
#include "aih_opp_externs.h"

extern int          AI_elapsedTime;     /* H24: ai.cpp @0x8013C554 (not in this TU's externs) */
extern AIHigh_Base *highLevelAIObjs[];  /* H24: @0x8010CD38 (not in this TU's externs) */


/* ---- CheckForWipeOut__15AIHigh_Opponent  AIHigh_Opponent::CheckForWipeOut  [AIH_OPP.CPP:38-94] SLD-VERIFIED ---- */

void AIHigh_Opponent::CheckForWipeOut()



{
  int perTickProb;
  int randVal;
  int oppLevel;
  int oppFines;
  AICop_PerpChaseInfo *pInfo;   /* SYM: 2nd "this" (REG this PTR STRUCT AICop_PerpChaseInfo) --
                                    dumpsym names any locally-materialized base pointer "this";
                                    the oracle computes &this->perpChaseInfo_ ONCE (addiu v1,t0,0x8C)
                                    and derives BOTH copGameInfo_ and bestChaseLevelIndex_ off it. */
  int hLoop;
  Car_tObj*thisPlayerObj;
  AIHigh_Player*thisPlayer;
  int playFines;

  bool bVar1;

  int iVar2;

  oppLevel = *(int *)((char *)this + 148);                    /* $t7, unconditional prologue load */
  oppFines = *(int *)((char *)this->carObj_ + 932);           /* $t6, unconditional prologue load (via carObj_ = $v1) */

  if ((Cars_gNumCopCars != 0) &&

     ((this->carObj_)->wipeOutEndTick <=

      simGlobal.gameTicks)) {

    bVar1 = false;

    if ((this->basicPerpInfo_.crime_ == 0) ||

       (this->basicPerpInfo_.copsAssigned_[0] +

        this->basicPerpInfo_.copsAssigned_[1] == 0)) {

      bVar1 = true;

    }

    if ((!bVar1) &&

       (0x27f < simGlobal.gameTicks -

                (this->carObj_)->wipeOutEndTick)) {

      /* H24: reconstructed pre-loop roll + per-human-race-car wipe-out loop (oracle 0x800633AC-0x800634D8;
         recon had an EMPTY loop AND dropped the pre-loop conditional store -> wipe-out timer never re-armed).
         The oracle materializes `this` into a stable base reg ($t0 = $a0) at entry and RE-LOADS
         this->carObj_ fresh at EACH wipeOutEndTick write site off that base, rather than caching
         carObj_ itself in one register across the whole function -- write through
         this->carObj_->wipeOutEndTick directly at each site, don't cache carObj_ into a local. */
      randtemp    = fastRandom * randSeed;                        /* 0x800633AC */
      perTickProb = AI_elapsedTime * 2 + AI_elapsedTime;          /* $a0 = 3*ae, 0x800633BC-C0 -- scheduled into the mult->mflo latency gap */
      fastRandom  = randtemp & 0xffff;                            /* 0x800633C8/E4 */
      randVal     = (int)(randtemp >> 8) & 0xffff;                /* $t1, 0x800633D4-D8 */
      if (randVal < perTickProb) {                                /* 0x800633DC-E8 */
        this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;      /* 0x800633EC-F8 */
      }
      iVar2 = 0;
      pInfo = &this->perpChaseInfo_;
      if (pInfo->bestChaseLevelIndex_ != (pInfo->copGameInfo_)->numLevels + -1) {
        for (hLoop = 0; hLoop < Cars_gNumHumanRaceCars; hLoop = hLoop + 1) {   /* 0x80063450 */
          Car_tObj    *carObj_h     = Cars_gHumanRaceCarList[hLoop];           /* 0x8006345C */
          int          field1380    = *(int *)((char *)carObj_h + 1380);       /* 0x80063468 */
          int          absField1380 = (field1380 < 0) ? -field1380 : field1380;/* 0x80063474-7C */
          AIHigh_Base *tableEntry   = highLevelAIObjs[*(int *)((char *)carObj_h + 596)]; /* carIndex, 0x80063464-84 */
          int          oppFines_v1  = *(int *)((char *)carObj_h + 932);        /* 0x80063488 */
          int          state        = *(int *)((char *)tableEntry + 148);      /* 0x8006348C */
          if (0xd5554 < absField1380) {                                        /* 0x80063480/90 */
            if (state < 2 && !(oppLevel < 3)) {                                /* 0x80063494-A0: skips the fines check */
              /* branch 0x800634A0's DELAY SLOT (0x800634A4 $a0=$t2<<2=116*ae) runs before reaching RANDGATE.
                 oracle recomputes `AI_elapsedTime*116` FRESH at EACH branch's delay slot (byte-identical
                 `sll a0,t2,2` at both 0x800634A4 and 0x800634B4) instead of hoisting ONE shared boolean
                 out of the loop; a plain (non-volatile) read here lets gcc CSE+LICM the whole compare to a
                 single flag computed before the loop even starts. The volatile read defeats that CSE/LICM
                 (real semantic effect: this->AI_elapsedTime is a per-tick global gcc must not treat as
                 provably loop-invariant across this branch merge) and reproduces the oracle's per-branch
                 recompute shape (107->86 diffs measured). */
              if (randVal < *(volatile int *)&AI_elapsedTime * 116)           /* 0x800634B8 */
                this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;    /* 0x800634C4-D0 */
            } else if (2 <= oppFines_v1 - oppFines) {                          /* 0x800634A8-B0 (skip if <2) */
              if (randVal < *(volatile int *)&AI_elapsedTime * 116)          /* $t2<<2, 0x800634B4-BC */
                this->carObj_->wipeOutEndTick = simGlobal.gameTicks + 0xC0;    /* 0x800634C4-D0 */
            }
          }
        }
      }

    }

  }

  return;

}








/* ---- DoRearEnder__15AIHigh_Opponent  AIHigh_Opponent::DoRearEnder  [AIH_OPP.CPP:97-146] SLD-VERIFIED ---- */

int AIHigh_Opponent::DoRearEnder()



{
  int attackIndex;
  Car_tObj*otherCarObj;
  int longDistance;
  int latDistance;
  int racerLoop;

  int iVar1;

  u_int uVar3;

  Car_tObj *pCVar4;

  int iVar5;

  Car_tObj *pCVar6;

  Car_tObj **ppCVar7;

  int *tickPtr;



  iVar1 = AIScript_DoReAction(&(this->carObj_)->script,0x100);

  if (iVar1 != -1) {

    pCVar6 = Cars_gList[iVar1];

    longDistance = AIWorld_SplineDistance(pCVar6,this->carObj_);

    pCVar4 = this->carObj_;

    longDistance = longDistance * pCVar4->direction;

    iVar5 = pCVar4->roadPosition - pCVar6->roadPosition;

    if (iVar5 < 0) {

      iVar5 = -iVar5;

    }

    if ((longDistance - 0x10001U < 0x26ffff) && (iVar5 < longDistance * 2)) {

      longDistance = pCVar6->currentSpeed;

      if (longDistance < 0) {

        longDistance = -longDistance;

      }

      if (0xb1c71 < longDistance) {

        return iVar1;

      }

    }

  }

  pCVar4 = this->carObj_;

  if ((pCVar4->N).simOptz == '\0') {

    iVar1 = pCVar4->currentSpeed;

    if (iVar1 < 0) {

      iVar1 = -iVar1;

    }

    racerLoop = 0;

    if (0x140000 < iVar1) {

      ppCVar7 = Cars_gHumanRaceCarList;

      tickPtr = &simGlobal.gameTicks;   /* §3.12 lever #16: hold the address across the AIWorld_SplineDistance
                                            call (oracle keeps &simGlobal in a callee-saved $s4, re-reading
                                            gameTicks via 4($s4) at BOTH mask-check sites, instead of
                                            rematerializing %hi/%lo(simGlobal) fresh each time) */

      for (; racerLoop < Cars_gNumHumanRaceCars; racerLoop = racerLoop + 1) {   /* SYM: racerLoop is a
                                            SEPARATE local from the pre-loop longDistance check (2nd SYM
                                            decl block re-declares otherCarObj/longDistance/latDistance but
                                            NOT attackIndex/racerLoop -- racerLoop is the outer-scope loop
                                            var, conflating it with the pre-loop longDistance temp forces
                                            them into ONE callee-saved reg for the whole function). */

        pCVar4 = *ppCVar7;

        iVar1 = (pCVar4->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices;

        if (((int)-((u_int)*(u_char *)(iVar1 + 0x1e) * 0x8000 * (u_int)(*(u_char *)(iVar1 + 0x1d) >> 4))

             <= pCVar4->roadPosition) &&

           (pCVar4->roadPosition <=

            (int)((u_int)*(u_char *)(iVar1 + 0x1f) * 0x8000 * (*(u_char *)(iVar1 + 0x1d) & 0xf)))) {

          iVar1 = AIWorld_SplineDistance(pCVar4,this->carObj_);

          pCVar6 = this->carObj_;

          iVar1 = iVar1 * pCVar6->direction;

          iVar5 = pCVar6->roadPosition - pCVar4->roadPosition;

          if (iVar5 < 0) {

            iVar5 = -iVar5;

          }

          if ((((iVar1 - 0x10001U < 0x26ffff) && (iVar5 < iVar1 * 2)) &&

              (uVar3 = *(u_int *)(pCVar6->personality + 0x48),

              (*tickPtr + pCVar6->carIndex * 0x7b & uVar3) == uVar3)) ||

             ((iVar1 + 0x3ffffU < 0x7ffff &&

              (pCVar6 = this->carObj_,

              uVar3 = *(u_int *)(pCVar6->personality + 0x4c),

              (*tickPtr + pCVar6->carIndex * 0x7b & uVar3) == uVar3)))) {

            return pCVar4->carIndex;

          }

        }

        ppCVar7 = ppCVar7 + 1;

      }

    }

  }

  return -1;

}








/* ---- HighExecute__15AIHigh_Opponent  AIHigh_Opponent::HighExecute  [AIH_OPP.CPP:150-247] SLD-VERIFIED ---- */

void AIHigh_Opponent::HighExecute()



{
  AIState_Base*newState;
  int attackIndex;
  int aggression;
  AIState_Chase*attackState;

  AIState_Normal *pAVar1;

  AIState_Base *pAVar2;

  int aggressionLevel;

  AIHigh_tAttackMode AVar3;

  AIState_Base *pAVar4;

  int iVar5;

  int iVar6;

  AIState_Chase *pAVar7;

  coorddef cStack_28;

  

  switch(this->stateType_) {

  case 1:
  case 3:
  case 5:
  case 6:
  case 7:
  case 8:
  case 9:
  case 10:
    break;

  case 0:

    pAVar1 = operator new(8);

    pAVar2 = (AIState_Base*)(new(pAVar1) AIState_Normal(this->carObj_));

    pAVar4 = this->state_;

    if (pAVar4 != (AIState_Base *)0x0) {

      /* manual-vtable slot 2 (raw byte offsets from the oracle jalr/lh -- __vtbl_ptr_type
         is 8 bytes, so a typed _vf[N] index/pointer-add is 8x too large; decay to a byte
         base and use the RAW displacement, §3.12 lever #10). */
      (**(int (**)(...))((char *)pAVar4->_vf + 0x14))
                ((int)&pAVar4->carObj_ + (int)*(short *)((char *)pAVar4->_vf + 0x10),3);

    }

    this->state_ = pAVar2;

    this->stateType_ = 2;

    return;

  case 2:

    this->HandleCops();

    this->CheckForWipeOut();

    iVar5 = AIScript_DoReAction(&(this->carObj_)->script,0x40);

    if (iVar5 == -1) {

      iVar5 = this->DoRearEnder();

      if (iVar5 != -1) {

        AVar3 = 1;

        goto LAB_800638c0;

      }

      iVar5 = this->DoProvokedAttack();

      AVar3 = 3;

      if (iVar5 != -1) goto LAB_800638c0;

    }

    else {

      AVar3 = 2;

LAB_800638c0:

      this->attackMode_ = AVar3;

    }

    if (this->attackMode_ != 0) {

      memset((u_char *)&cStack_28,'\0',0xc);

      iVar6 = this->attackMode_ - 1;

      aggressionLevel = 2;

      if (1 < iVar6) {

        aggressionLevel = iVar6;

      }

      pAVar7 = operator new(0x94);

      pAVar7 = (new(pAVar7) AIState_Chase(this->carObj_,

                          Cars_gList[iVar5],&cStack_28,0x20,0x960000,0x960000,aggressionLevel,

                          0x10000));

      pAVar2 = this->state_;

      if (pAVar2 != (AIState_Base *)0x0) {

        /* manual-vtable slot 2 (raw byte offsets from the oracle jalr/lh -- __vtbl_ptr_type
           is 8 bytes, so a typed _vf[N] index/pointer-add is 8x too large; decay to a byte
           base and use the RAW displacement, §3.12 lever #10). */
        (**(int (**)(...))((char *)pAVar2->_vf + 0x14))
                  ((int)&pAVar2->carObj_ + (int)*(short *)((char *)pAVar2->_vf + 0x10),3);

      }

      this->state_ = (AIState_Base*)pAVar7;

      this->stateType_ = 4;

    }

    break;

  case 4:

    pAVar7 = (AIState_Chase *)this->state_;

    this->HandleCops();

    this->CheckForWipeOut();

    (pAVar7)->SetMurderMode(1,0xf);

    AVar3 = this->attackMode_;

    if (AVar3 == 2) {

      iVar5 = AIScript_DoReAction(&(this->carObj_)->script,0x40)

      ;

      if (iVar5 == -1) {

        this->attackMode_ = 0;

      }

    }

    else if ((int)AVar3 < 3) {

      if ((AVar3 == 1) && (iVar5 = this->DoRearEnder(), iVar5 == -1)) {

        this->attackMode_ = 0;

      }

    }

    else if ((AVar3 == 3) &&

            (iVar5 = this->attackTicksLeft_ - AI_elapsedTime, this->attackTicksLeft_ = iVar5, iVar5 < 1)) {   /* H25: decrement dropped (m2c self-assign fold); oracle 0x80063A38 $v0-=AI_elapsedTime, 0x80063A40 store, test on decremented value */

      this->attackMode_ = 0;

    }

    if (this->attackMode_ == 0) {

      iVar5 = -1;

      if (GameSetup_gData.reverseTrack == 0) {

        iVar5 = 1;

      }

      (this->carObj_)->desiredDirection = iVar5;

      pAVar1 = operator new(8);

      pAVar2 = (AIState_Base*)(new(pAVar1) AIState_Normal(this->carObj_));

      pAVar4 = this->state_;

      if (pAVar4 != (AIState_Base *)0x0) {

        /* manual-vtable slot 2 (raw byte offsets from the oracle jalr/lh -- __vtbl_ptr_type
         is 8 bytes, so a typed _vf[N] index/pointer-add is 8x too large; decay to a byte
         base and use the RAW displacement, §3.12 lever #10). */
      (**(int (**)(...))((char *)pAVar4->_vf + 0x14))
                ((int)&pAVar4->carObj_ + (int)*(short *)((char *)pAVar4->_vf + 0x10),3);

      }

      this->state_ = pAVar2;

      this->stateType_ = 2;

      this->attackMode_ = 0;

    }

  }

  (this->state_)->StateExecute();

  return;

}








/* ---- __15AIHigh_OpponentP8Car_tObj  AIHigh_Opponent::ctor  [AIH_OPP.CPP:250-255] SLD-VERIFIED ---- */
AIHigh_Opponent::AIHigh_Opponent(Car_tObj *carObj)



{

  (new((AIHigh_Player *)this) AIHigh_Player(carObj));

  this->_vf =

       (__vtbl_ptr_type (*) [3])AIHigh_Opponent_vtable;

  this->attackMode_ = 0;

  this->lastHumanHitter_ = (Car_tObj *)0x0;

  this->hitCount_ = 0;

  this->attackTicksLeft_ = 0;

  return;

}








/* ---- DoProvokedAttack__15AIHigh_Opponent  AIHigh_Opponent::DoProvokedAttack  [AIH_OPP.CPP:260-280] SLD-VERIFIED ---- */

int AIHigh_Opponent::DoProvokedAttack()



{

  int iVar1;

  Car_tObj *myCarObj;

  Car_tObj *pCVar3;

  Car_tObj *oppCarObj;

  int iVar4;



  myCarObj = this->carObj_;

  if (((simGlobal.gameTicks - (myCarObj->N).collision.lastTime < 0xf) &&

      (pCVar3 = (Car_tObj *)(myCarObj->N).collision.lastOtherObj, pCVar3 != (Car_tObj *)0x0)) &&

     ((pCVar3->carFlags & 4U) != 0)) {

    if (this->lastHumanHitter_ != pCVar3) {

      this->lastHumanHitter_ = pCVar3;

      this->hitCount_ = 0;

    }

    iVar1 = ++this->hitCount_;

    oppCarObj = this->carObj_;

    iVar4 = oppCarObj->personality;

    if (*(int *)(iVar4 + 0x24) < iVar1) {

      iVar1 = *(int *)(iVar4 + 0x28);

      this->hitCount_ = 0;

      this->attackTicksLeft_ = iVar1;

      return pCVar3->carIndex;

    }

  }

  return -1;

}







/* end of aih_opp.cpp */

/* cont.35 B3b: base-forward dtor re-attributed from main.c (�3.23 simple variant);
   oracle = jal ___11AIHigh_Base; extern-C free fn exports the exact symbol. */
extern "C" {
void ___11AIHigh_Base(void *);
}
extern __vtbl_ptr_type AIHigh_BasicPerp_vtable[];   /* owned by aih_basicperp.obj */
extern "C" {
void ___15AIHigh_Opponent(void *thisp) {
  *(void**)((char*)thisp + 0x14) = (void*)AIHigh_BasicPerp_vtable;
  ___11AIHigh_Base(thisp);
}
}
