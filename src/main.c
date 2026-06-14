#include "common.h"
/* auto_reloc externs */
extern int D_8013C338;
extern int D_80148448;
extern int ticks;


void AI_StartUp__Fv(void) {
}

void AI_CleanUp__Fv(void) {
}

void AI_Main_OverallSetup__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", AI_CarAvoidance__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_WorldAvoidance__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_InitAIInfo__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_GenericBeginCycle__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_GenericCycle__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_GenericEndCycle__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_TargetLane__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AI_ClearLaneMerits__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AI_DoReactions__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_CheckForPlayerActions__FP8Car_tObjT0);

INCLUDE_ASM("asm/nonmatchings/main", AI_DoReactionsAndBehavior__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_OpponentBlockPlayer__FP8Car_tObjT0);

INCLUDE_ASM("asm/nonmatchings/main", AI_CheckForBarriers__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_SetupOncomingLaneDemerits__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_HandleChangeInNumLanes__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_HandleShouldersAndOffRoad__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_CalculateLaneSpeeds__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_CalcMeritsBasedOnSpeed__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_CheckForClearLanes__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_CalcBestLineMerits__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", func_8005972C);

INCLUDE_ASM("asm/nonmatchings/main", AI_AvoidObjects__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_AvoidSpikeBelt__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_SubmitObstacle__FP8Car_tObjiiii);

INCLUDE_ASM("asm/nonmatchings/main", AI_HandleTrafficHonking__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_CheckForCarsOnSide__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_ProcessObservationsAndChooseLane__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_ChooseBestLane__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_CheckPreferredLateralPosition__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_TryToShareLanes__FP8Car_tObjT0);

INCLUDE_ASM("asm/nonmatchings/main", AI_CalculateDesiredLatPosition__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_IsMellowZone__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AI_KeepCarsInLane__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_PushFinishedCarsToSide__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_MaybeChangeLaneSlack__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AI_ChooseNewLaneSlack__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", __10AIDelayCarP8Car_tObjT1i);

INCLUDE_ASM("asm/nonmatchings/main", SetNewTargetCar__10AIDelayCarP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Update__10AIDelayCar);

INCLUDE_ASM("asm/nonmatchings/main", AIHigh_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AIHigh_Restart1__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AIHigh_Restart2__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AIHigh_CleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AIHigh_Execute__Fv);

INCLUDE_ASM("asm/nonmatchings/main", __11AIHigh_BaseP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", ___11AIHigh_Base);

INCLUDE_ASM("asm/nonmatchings/main", func_8005B438);

void func_8005B460(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_8005B468);

void func_8005B488(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_8005B490);

int func_8005B4C4(void) {
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", func_8005B4CC);

INCLUDE_ASM("asm/nonmatchings/main", CheckForCrimes__16AIHigh_BasicPerp);

INCLUDE_ASM("asm/nonmatchings/main", CheckIfCaught__16AIHigh_BasicPerp);

INCLUDE_ASM("asm/nonmatchings/main", RemoveCloseCops__16AIHigh_BasicPerp);

INCLUDE_ASM("asm/nonmatchings/main", RemoveChaser__16AIHigh_BasicPerpii7copType);

INCLUDE_ASM("asm/nonmatchings/main", AddChaser__16AIHigh_BasicPerpii7copType);

INCLUDE_ASM("asm/nonmatchings/main", CheckChaserPosition__16AIHigh_BasicPerpii);

INCLUDE_ASM("asm/nonmatchings/main", Clear__16AIHigh_BasicPerp);

INCLUDE_ASM("asm/nonmatchings/main", __16AIHigh_BasicPerpP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", ___16AIHigh_BasicPerp);

INCLUDE_ASM("asm/nonmatchings/main", __15AIHigh_BasicCopP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", CheckSpikeBelt__15AIHigh_BasicCop);

INCLUDE_ASM("asm/nonmatchings/main", ShouldIPerformCutOffBlock__15AIHigh_BasicCopiP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", func_8005C414);

INCLUDE_ASM("asm/nonmatchings/main", func_8005C468);

INCLUDE_ASM("asm/nonmatchings/main", func_8005C5E4);

INCLUDE_ASM("asm/nonmatchings/main", SetupBlockadeElements__15AIHigh_BasicCopP10blockade_t);

INCLUDE_ASM("asm/nonmatchings/main", HandleBlockadeSpeech__15AIHigh_BasicCop);

INCLUDE_ASM("asm/nonmatchings/main", func_8005CB4C);

INCLUDE_ASM("asm/nonmatchings/main", __14AIHigh_BTC_CopP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AssignToPlayer__14AIHigh_BTC_CopP15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", CheckForNewTarget__14AIHigh_BTC_Cop);

INCLUDE_ASM("asm/nonmatchings/main", StartArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", FinishArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp);

int FalseArrest__14AIHigh_BTC_CopP15AIHigh_BTC_Perp(void *cop, void *perp) {
    if (*(void **)((char *)cop + 0x58) == perp)
        *(int *)((char *)cop + 0x60) = 2;
    return 2;
}
void FreezeAndEndChase__14AIHigh_BTC_Cop(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", HudOff__14AIHigh_BTC_Cop);

INCLUDE_ASM("asm/nonmatchings/main", __19AIHigh_BTC_HumanCopP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii);

INCLUDE_ASM("asm/nonmatchings/main", ReleaseAndStartChase__19AIHigh_BTC_HumanCopP15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", FreezeAndEndChase__19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", CheckConditionWithCop0__19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", NewStage__19AIHigh_BTC_HumanCopiii);

INCLUDE_ASM("asm/nonmatchings/main", UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", RequestWingman__19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", RequestBlockader__19AIHigh_BTC_HumanCopi);

INCLUDE_ASM("asm/nonmatchings/main", CheckForWingmanRequest__19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi);

INCLUDE_ASM("asm/nonmatchings/main", UpdateWingmanRole__19AIHigh_BTC_HumanCop12Wingman_Role);

INCLUDE_ASM("asm/nonmatchings/main", ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", ResetClearTrafficToPurgatory__19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", SetDesiredSpeed__19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", HighExecute__19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", HudOn__19AIHigh_BTC_HumanCopP15AIHigh_BTC_PerpiP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", __18AIHigh_BTC_WingmanP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", HighExecute__18AIHigh_BTC_Wingman);

INCLUDE_ASM("asm/nonmatchings/main", CheckForActivation__18AIHigh_BTC_Wingman);

INCLUDE_ASM("asm/nonmatchings/main", UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman);

INCLUDE_ASM("asm/nonmatchings/main", SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi);

INCLUDE_ASM("asm/nonmatchings/main", ___18AIHigh_BTC_Wingman);

INCLUDE_ASM("asm/nonmatchings/main", ___19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", ___14AIHigh_BTC_Cop);

void func_8005F624(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_8005F62C);

int func_8005F678(void) {
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", func_8005F680);

INCLUDE_ASM("asm/nonmatchings/main", ReleaseCops__15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", HandleCops__15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", IsFalseArrest__15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", CheckForControlsPressed__15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", HandlePullOver__15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", NotifyCopsOfArrest__15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", CheckForActivation__15AIHigh_BTC_Perp);

INCLUDE_ASM("asm/nonmatchings/main", NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", HighExecute__20AIHigh_BTC_HumanPerp);

INCLUDE_ASM("asm/nonmatchings/main", __17AIHigh_BTC_AIPerpP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", ___17AIHigh_BTC_AIPerp);

INCLUDE_ASM("asm/nonmatchings/main", AvoidCops__17AIHigh_BTC_AIPerp);

INCLUDE_ASM("asm/nonmatchings/main", CalculateTimeTillContact__17AIHigh_BTC_AIPerp);

INCLUDE_ASM("asm/nonmatchings/main", FindClosestCop__17AIHigh_BTC_AIPerp);

INCLUDE_ASM("asm/nonmatchings/main", HighExecute__17AIHigh_BTC_AIPerp);

INCLUDE_ASM("asm/nonmatchings/main", NewStage__17AIHigh_BTC_AIPerpP19AIHigh_BTC_HumanCop);

INCLUDE_ASM("asm/nonmatchings/main", ___20AIHigh_BTC_HumanPerp);

INCLUDE_ASM("asm/nonmatchings/main", func_80061348);

void func_80061370(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_80061378);

int func_800613C4(void) {
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", func_800613CC);

INCLUDE_ASM("asm/nonmatchings/main", CheckIfABlockadeCanBeSetup__13AIHigh_Player);

INCLUDE_ASM("asm/nonmatchings/main", SetupBlockade__13AIHigh_Player);

INCLUDE_ASM("asm/nonmatchings/main", CheckForNewLevel__13AIHigh_Playeri);

INCLUDE_ASM("asm/nonmatchings/main", HandleSpeech__13AIHigh_Player);

INCLUDE_ASM("asm/nonmatchings/main", MaintainAvailableCops__13AIHigh_Player);

INCLUDE_ASM("asm/nonmatchings/main", __13AIHigh_PlayerP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", HandleCops__13AIHigh_Player);

INCLUDE_ASM("asm/nonmatchings/main", CleanupBlockaders__13AIHigh_Playeri);

INCLUDE_ASM("asm/nonmatchings/main", HandlePullOver__13AIHigh_Player);

INCLUDE_ASM("asm/nonmatchings/main", func_80063248);

INCLUDE_ASM("asm/nonmatchings/main", HighExecute__12AIHigh_Human);

INCLUDE_ASM("asm/nonmatchings/main", __12AIHigh_HumanP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", ___12AIHigh_Human);

INCLUDE_ASM("asm/nonmatchings/main", CheckForWipeOut__15AIHigh_Opponent);

INCLUDE_ASM("asm/nonmatchings/main", DoRearEnder__15AIHigh_Opponent);

INCLUDE_ASM("asm/nonmatchings/main", HighExecute__15AIHigh_Opponent);

INCLUDE_ASM("asm/nonmatchings/main", __15AIHigh_OpponentP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", DoProvokedAttack__15AIHigh_Opponent);

INCLUDE_ASM("asm/nonmatchings/main", ___15AIHigh_Opponent);

INCLUDE_ASM("asm/nonmatchings/main", __10AIHigh_CopP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", SetTuningLevers__10AIHigh_Cop);

INCLUDE_ASM("asm/nonmatchings/main", HighExecute__10AIHigh_Cop);

INCLUDE_ASM("asm/nonmatchings/main", CheckForNeedyPlayers__10AIHigh_Cop);

INCLUDE_ASM("asm/nonmatchings/main", CheckForWipeOut__10AIHigh_Cop);

INCLUDE_ASM("asm/nonmatchings/main", CheckForNewTarget__10AIHigh_Cop);

INCLUDE_ASM("asm/nonmatchings/main", AssignToPlayer__10AIHigh_CopP13AIHigh_Player);

INCLUDE_ASM("asm/nonmatchings/main", GetCheckChasePosition__10AIHigh_CopP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", CheckForNewTriggers__10AIHigh_Cop);

INCLUDE_ASM("asm/nonmatchings/main", ___10AIHigh_Cop);

INCLUDE_ASM("asm/nonmatchings/main", CheckForCops__14AIHigh_TrafficPi);

INCLUDE_ASM("asm/nonmatchings/main", CopCheck__14AIHigh_TrafficPi);

INCLUDE_ASM("asm/nonmatchings/main", HighExecute__14AIHigh_Traffic);

INCLUDE_ASM("asm/nonmatchings/main", __14AIHigh_TrafficP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", CheckForNewTriggers__14AIHigh_Traffic);

INCLUDE_ASM("asm/nonmatchings/main", ___14AIHigh_Traffic);

INCLUDE_ASM("asm/nonmatchings/main", AICop_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AICop_Restart__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AICop_CleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AICop_NoCopsInArea__Fii);

INCLUDE_ASM("asm/nonmatchings/main", AILife_EvaluateLife__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AILife_RCSetSpeeds__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AILife_RCPickSliceAndDirection__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AILife_RCPickDesiredLatPosition__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AILife_PlaceCarAtLocation__FP8Car_tObjiiiii);

INCLUDE_ASM("asm/nonmatchings/main", AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AILife_PlaceCarAtLocation__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AILife_ReencarnateTraffic__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", AILife_ReencarnateCopBySlice__FP8Car_tObjiiii);

INCLUDE_ASM("asm/nonmatchings/main", AILife_ReencarnateCopByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", AILife_ReencarnateCopByLatPosAndRotation__FP8Car_tObjiiii);

INCLUDE_ASM("asm/nonmatchings/main", AILife_IsCoordInThisLiveArea__FP8coorddefP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AILife_IsTrafficCarInAnyLiveArea__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AILife_IsCarInAnyVisibleArea__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AILife_IsSliceInAnyVisibleArea__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AILife_IsSliceCloseToAnyCopCar__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AILife_IsPositionInAnyVisibleArea__FP8coorddef);

void AILife_Debug__FPce(char *fmt, ...) {
}
INCLUDE_ASM("asm/nonmatchings/main", AIPerson_LoadGridAndSetPersonalityIndexes__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AIPerson_SetPersonality__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AIPerson_SetPersonalityPointers__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AIPerson_LoadPersonalityData__FP10Udff_tInfo);

INCLUDE_ASM("asm/nonmatchings/main", AIPerson_LoadScriptData__FP10Udff_tInfo);

INCLUDE_ASM("asm/nonmatchings/main", AIPerson_LoadGlue__FP10Udff_tInfo);

INCLUDE_ASM("asm/nonmatchings/main", AIPerson_Startup__Fv);

void AIPerson_Cleanup__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_StopCar__FP8Car_tObjii);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_RevEngine__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_HandleShifting__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_CalculateGear__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_GearInvSpeedRange__FP8Car_tObj6Gear_t);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_GearTopSpeed__FP8Car_tObj6Gear_t);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_GearBottomSpeed__FP8Car_tObj6Gear_t);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_CalcAcceleration__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_CalcDeceleration__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_CheckDesiredDirection__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_HandleSignalling__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_HandleWipeoutTimer__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_Main__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_CheckForBadPosition__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysics_UseCoolPhysics__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_SimplePhysics__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_SimplePhysics_LongVel__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_SimplePhysics_LatVel__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_CoolPhysics__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_HandleDirection__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_Preperation__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_CalculateRoadPosition__FP8coorddefi);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_GetDesiredVector__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_TargetedGetDesiredVector__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_CheckIfOutOfControl__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_OutOfControlPhysics__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_GetRearEndDamageFactor__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_InControlPhysics__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_FinishUp__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_HitWallCheck__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_ProcessBarrierCollision__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_ProcessCollision__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_ChangeDirection__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_CheckForGripReduction__FP8Car_tObj);

void AIPhysic_StartUp__Fv(void) {
}

void AIPhysic_CleanUp__Fv(void) {
}

void AIPhysic_Reset__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_ResetCar__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_InitCar__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIPhysic_DeInitCar__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", __14AIDataRecord_t26AIDataRecord_WhichRecord_tPc);

INCLUDE_ASM("asm/nonmatchings/main", ___14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", AddRecordToCollection__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", RemoveRecordFromCollection__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", StartUp1__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", StartUp2__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", CleanUp1__14AIDataRecord_t);

void CleanUp2__14AIDataRecord_t(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Setup__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", Load__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", SaveAndPurge__14AIDataRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", __23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t);

int Get__23AIDataRecord_AccTable_ti(void *this, int i) {
    short *table = *(short **)((char *)this + 0x48);
    return table[i] << 8;
}
INCLUDE_ASM("asm/nonmatchings/main", Setup__23AIDataRecord_AccTable_t);

INCLUDE_ASM("asm/nonmatchings/main", __23AIDataRecord_BestLine_t26AIDataRecord_WhichRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", __25AIDataRecord_TrackCurve_t26AIDataRecord_WhichRecord_t);

unsigned char Get__25AIDataRecord_TrackCurve_ti(void *this, int i) {
    unsigned char *table = *(unsigned char **)((char *)this + 0x48);
    return table[i];
}
INCLUDE_ASM("asm/nonmatchings/main", __30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t);

INCLUDE_ASM("asm/nonmatchings/main", Get__30AIDataRecord_CurveSpeedTable_ti);

INCLUDE_ASM("asm/nonmatchings/main", Upgrade__30AIDataRecord_CurveSpeedTable_ti);

int func_8006D50C(void) {
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", func_8006D514);

INCLUDE_ASM("asm/nonmatchings/main", func_8006D534);

INCLUDE_ASM("asm/nonmatchings/main", func_8006D554);

INCLUDE_ASM("asm/nonmatchings/main", func_8006D574);

INCLUDE_ASM("asm/nonmatchings/main", ___23AIDataRecord_AccTable_t);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_ReadTuningInfo__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_CleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_CalcOpponentTopSpeed__FP8Car_tObjPi);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_CalcOpponentCurveSpeed__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_BTCGetGlueFactor__FP8Car_tObj);

int AISpeeds_GetNextAICar__FP8Car_tObj(void *a0) {
    return *(int *)((char *)a0 + 0x768);
}
INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_GetPrevAICar__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_GetCaravanFactor__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_GetGlueFactor__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_GetDamageFactor__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_LimitGlueMultiplier__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_CalcCopTopSpeed__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_GetLegalSpeed__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_RandomizeTrafficSpeed__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_CalcDesiredSpeed__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_CalculateOncomingCarSpeed__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_SetTrafficSpeedRandomFactor__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_MaintainLeaderBoard__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_GetScriptFactor__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_GetUpgradeAccMult__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_GetUpgradeBrakeMult__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_GetUpgradeHandlingMult__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_GetUpgradeTopSpeedMult__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_CalcHumanTopSpeed__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj);

void AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails(void *p, void *arr) {
    *(void **)((char *)p + 0x1C) = arr;
}
INCLUDE_ASM("asm/nonmatchings/main", AIScript_ClearLastReactionIndex__FP10AIScript_t);

INCLUDE_ASM("asm/nonmatchings/main", AIScript_Startup__FP10AIScript_t);

void AIScript_Cleanup__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni);

INCLUDE_ASM("asm/nonmatchings/main", AIScript_ProcessActionsAndReactions__FP10AIScript_ti);

INCLUDE_ASM("asm/nonmatchings/main", AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction);

INCLUDE_ASM("asm/nonmatchings/main", AIScript_GetReactionTicksLeft__FP10AIScript_t);

INCLUDE_ASM("asm/nonmatchings/main", AIState_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AIState_Restart__Fv);

void AIState_CleanUp__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", StateExecute__12AIState_Base);

INCLUDE_ASM("asm/nonmatchings/main", __12AIState_BaseP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Execute__14AIState_Normal);

INCLUDE_ASM("asm/nonmatchings/main", __14AIState_NormalP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Execute__12AIState_Idle);

INCLUDE_ASM("asm/nonmatchings/main", SetIdlePosition__12AIState_Idlei);

INCLUDE_ASM("asm/nonmatchings/main", __13AIState_ChaseP8Car_tObjT1P8coorddefiiiii);

INCLUDE_ASM("asm/nonmatchings/main", ___13AIState_Chase);

INCLUDE_ASM("asm/nonmatchings/main", SetTarget__13AIState_ChaseP8Car_tObjP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", SetMurderMode__13AIState_Chaseii);

INCLUDE_ASM("asm/nonmatchings/main", SetUp__13AIState_Chase);

void DoSlowNitrous__13AIState_Chase(void *this) {
    *(int *)((char *)*(void **)this + 0x73C) = 0x8000;
    *(int *)((char *)*(void **)this + 0x740) = 0xC000;
}
INCLUDE_ASM("asm/nonmatchings/main", DoNitrous__13AIState_Chasei);

INCLUDE_ASM("asm/nonmatchings/main", Execute__13AIState_Chase);

INCLUDE_ASM("asm/nonmatchings/main", FarTargeting__13AIState_Chase);

INCLUDE_ASM("asm/nonmatchings/main", CalculateCloseTargettingAheadSlowDownFactor__13AIState_Chase);

INCLUDE_ASM("asm/nonmatchings/main", CloseTargeting__13AIState_Chase);

INCLUDE_ASM("asm/nonmatchings/main", ApproachTargeting__13AIState_Chasei);

INCLUDE_ASM("asm/nonmatchings/main", CheckForBarriersAndTargetAroundThem__13AIState_Chase);

INCLUDE_ASM("asm/nonmatchings/main", FindBarrierEndSlice__13AIState_Chase);

INCLUDE_ASM("asm/nonmatchings/main", ___15AIState_Offroad);

INCLUDE_ASM("asm/nonmatchings/main", __15AIState_OffroadP8Car_tObjiP8coorddefP10matrixtdefiii);

INCLUDE_ASM("asm/nonmatchings/main", UnleashIfInRange__15AIState_OffroadP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Execute__15AIState_Offroad);

INCLUDE_ASM("asm/nonmatchings/main", __17AIState_PurgatoryP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", ___17AIState_Purgatory);

INCLUDE_ASM("asm/nonmatchings/main", TestForRelease__17AIState_Purgatory);

INCLUDE_ASM("asm/nonmatchings/main", Execute__17AIState_Purgatory);

INCLUDE_ASM("asm/nonmatchings/main", StartUp__17AIState_Purgatory);

INCLUDE_ASM("asm/nonmatchings/main", __21AIState_RovingTrafficP8Car_tObjP9trigger_t);

INCLUDE_ASM("asm/nonmatchings/main", CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi);

INCLUDE_ASM("asm/nonmatchings/main", Execute__21AIState_RovingTraffic);

INCLUDE_ASM("asm/nonmatchings/main", ___14AIState_Donuts);

INCLUDE_ASM("asm/nonmatchings/main", Execute__14AIState_Donuts);

INCLUDE_ASM("asm/nonmatchings/main", __17AIState_GotoSliceP8Car_tObjii);

INCLUDE_ASM("asm/nonmatchings/main", Execute__17AIState_GotoSlice);

INCLUDE_ASM("asm/nonmatchings/main", InTargetSliceRange__17AIState_GotoSlicei);

INCLUDE_ASM("asm/nonmatchings/main", __14AIState_CruiseP8Car_tObj12cruiseMode_ti);

INCLUDE_ASM("asm/nonmatchings/main", Execute__14AIState_Cruise);

INCLUDE_ASM("asm/nonmatchings/main", ___14AIState_Cruise);

INCLUDE_ASM("asm/nonmatchings/main", ___17AIState_GotoSlice);

int TestForRelease__21AIState_RovingTraffic(void *this) {
    int f10 = *(int *)((char *)this + 0x10);
    int fC  = *(int *)((char *)this + 0xC);
    return !(f10 < fC);
}
INCLUDE_ASM("asm/nonmatchings/main", ___21AIState_RovingTraffic);

void func_80072750(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_80072758);

INCLUDE_ASM("asm/nonmatchings/main", ___12AIState_Idle);

INCLUDE_ASM("asm/nonmatchings/main", ___14AIState_Normal);

int func_80072830(void) {
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", func_80072838);

INCLUDE_ASM("asm/nonmatchings/main", Init__24AITrigger_TriggerManagerPc);

INCLUDE_ASM("asm/nonmatchings/main", InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb);

INCLUDE_ASM("asm/nonmatchings/main", GetNextTrigger__24AITrigger_TriggerManageri);

INCLUDE_ASM("asm/nonmatchings/main", GetPrevTrigger__24AITrigger_TriggerManageri);

INCLUDE_ASM("asm/nonmatchings/main", CheckForTriggerAtSlice__24AITrigger_TriggerManagerii);

INCLUDE_ASM("asm/nonmatchings/main", GetTrigger__24AITrigger_TriggerManageriPi);

INCLUDE_ASM("asm/nonmatchings/main", CheckForClosestTriggerOfType__24AITrigger_TriggerManageri11triggerTypei);

void DescribeTrigger__24AITrigger_TriggerManagerP9trigger_t(void) {
}

int AITrigger_Compare__FPCvT0(const void **p1, const void **p2) {
    return ((int *)*p1)[1] - ((int *)*p2)[1];
}
INCLUDE_ASM("asm/nonmatchings/main", Sort__24AITrigger_TriggerManager);

INCLUDE_ASM("asm/nonmatchings/main", AITune_GetOneWay__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AITune_GetDriveSide__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AITune_GetRoughLapTimes__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AITune_StartUp1__Fv);

void AITune_StartUp2__Fv(void) {
}

void AITune_CleanUp1__Fv(void) {
}

void AITune_CleanUp2__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_ZSplineDistance__FP8Car_tObjT0);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_ZSplineDistance__FP8coorddefT0P10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_ApxSplineDistance__FP8Car_tObjT0);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_ApxSplineDistance__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_ApxSplineDistance__FiP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_ApxSplineDistance__Fii);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_SplineDistance__FP8Car_tObjT0);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_SplineDistance__FP8Car_tObjiP8coorddef);

int AIWorld_GameOdometer__FP8Car_tObj(void *car) {
    unsigned short v = ((unsigned short *)car)[3];
    return (v * 3) << 17;
}
INCLUDE_ASM("asm/nonmatchings/main", AIWorld_IsDriveableLaneInSliceRange__Fiiii);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_IsDriveableLane__Fii);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_GetProfileMask__Fi);

int AIWorld_IsDriveableLane_UsingMask__Fii(int lane, int mask) {
    char *p = (char *)(lane << 5);
    p += (int)*(char **)0x8013C7C0;
    return *(short *)(p + 0x16) & mask;
}
INCLUDE_ASM("asm/nonmatchings/main", AIWorld_CheckForBarrierBetweenLanes__Fiii);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_LaneIndex__Fii);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_CalculateLaneInfo__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_CalcRoadBend__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_CalcFutureLateralVel__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_CalcSpeed__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_CalcLateralVelocity__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AIWorld_FindBarrierLessLaneAndPosition__FP8Car_tObjPiT1);

INCLUDE_ASM("asm/nonmatchings/main", Anim_Restart__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Anim_InitSystem__FPc);

INCLUDE_ASM("asm/nonmatchings/main", Anim_DeInitSystem__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Anim_Handle__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Anim_FreeHandle__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Anim_GetAnim__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Anim_GetLastRotPos__FP15Trk_AnimateInstP8coorddefP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", Anim_GetLastAnimPosRot__FiiP8coorddefP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", Anim_GetRotPos__FP15Trk_AnimateInstiiP8coorddefP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", Anim_GetPos__FP15Trk_AnimateInstiiP8coorddefPiT4);

INCLUDE_ASM("asm/nonmatchings/main", __10AnimScripti);

INCLUDE_ASM("asm/nonmatchings/main", __10AnimScriptii);

INCLUDE_ASM("asm/nonmatchings/main", __10AnimScriptP5Groupiii);

void SetAnimAttrib__10AnimScripti(void *this, int v) {
    *(int *)((char *)this + 8) = v;
}
INCLUDE_ASM("asm/nonmatchings/main", GetAnimFrameInfo__10AnimScriptPiT1);

INCLUDE_ASM("asm/nonmatchings/main", GetTimedAnimPosRot__10AnimScriptP8coorddefP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", GetStatus__10AnimScript);

void AudioClc_SndError__Fi(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_SetHorn__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_HonkHorn__FP8Car_tObjiii);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_CalcDopplerShiftRatio__FP8coorddefT0);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_SoundOpponentHorn__Fiiii);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_SilenceOpponentHorn__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_SoundCloseCar__Fii);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_SoundPlayersCar__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_ResetClosest__FiP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_GetClosestCars__Fiii);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_SoundSpeech__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioClc_SoundCars__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_MusicLevel__Fi);

int AudioCmn_GetTrackRecordLapTime__Fv(void) {
    return *(int *)0x801132D4;
}
INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_InitThunder__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_PlayThunder__Fii);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_UpdateThunder__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_InitAsyncSfx__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_RemoveAsyncSfx__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_DeInitAsyncSfx__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_RemoveOldestAsyncSfx__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_LoadAsyncSfx__FiiPvi);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_GetAsyncSfx__Fiib);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_Init__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_Reset__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_DeInit__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_SetLevels__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_GetTimePhrase__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_CheckState__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_LoadFESamples__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_LoadGameSamples__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_InitChannelArray__Fv);

INCLUDE_ASM("asm/nonmatchings/main", scaleFrequency__Fiii);

INCLUDE_ASM("asm/nonmatchings/main", ChooseImpactSample__Fi6s_typeT1);

INCLUDE_ASM("asm/nonmatchings/main", ChooseLoopedSample__F6s_typeT0);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_SFX__Fi6s_typeT1iii);

INCLUDE_ASM("asm/nonmatchings/main", freeVoiceChannel__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_PlayDoppleredSound__Fiiiiii);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_PlaySound__Fiiiii);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_PlaySFX__Fiiiiii);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_SoundCar__FP8Car_tObjiiiiiii);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_TrafficSFX__Fiiiiiiii);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_TrafficSkidSFX__Fi6s_typeT1iii);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_PlayerHornOn__Fiiiii);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_PlayerHornOff__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_PlayFESFX__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_PlayFESFXVol__Fii);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_PlayWrongWaySFX__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_PlayPauseSound__Fi);

INCLUDE_ASM("asm/nonmatchings/main", quickSirenOn__Fi);

INCLUDE_ASM("asm/nonmatchings/main", SuperCopSirenOn__Fi);

INCLUDE_ASM("asm/nonmatchings/main", SirenOn__Fii);

INCLUDE_ASM("asm/nonmatchings/main", SirenOff__Fi);

INCLUDE_ASM("asm/nonmatchings/main", UpdateSiren__Fiiiii);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_Pause__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_UnPause__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_UnPauseAndQuit__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_UnPauseAndRestart__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_InitReverb__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_ReverbOff__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_RefreshStatus__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_Threshold__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_Buffered__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_GetCurrentSong__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_SwitchSong__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_Fail__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_QueueRequestedSong__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_SetEntry__FP19AudioMus_tSongEntry);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_SetCurrentSongInfo__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_Server__Fii);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_GetSongList__FPci);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_InitGlobals__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_InitDriverGlobals__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_DriverStartUp__Fii);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_SysStartUp__FiiPc);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_DriverCleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_SysCleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_StopSong__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_BuildPlayList__FiPi);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_BuildPattern__FPc);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_PlaySong__FPc);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_Volume__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AudioMus_AutoVolume__Fii);

INCLUDE_ASM("asm/nonmatchings/main", AudList_PurgeAudio__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudList_LoadAudioFile__Fi);

INCLUDE_ASM("asm/nonmatchings/main", AudioEng_Set__Fiiiiiiii);

INCLUDE_ASM("asm/nonmatchings/main", AudioEng_Update__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioEng_LoadDef__FPcT0illPP13AudioEng_tDef);

INCLUDE_ASM("asm/nonmatchings/main", AudioEng_StartUp__FiPc);

INCLUDE_ASM("asm/nonmatchings/main", AudioEng_StartServer__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioEng_StopServer__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioEng_Pause__Fv);

void AudioEng_Resume__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", AudioEng_CleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioTrk_Reset__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioTrk_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AudioTrk_SoundTrack__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", AudioTrk_PreLoad__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioTrk_CleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", xzsquaredist32__FP8coorddefT0);

INCLUDE_ASM("asm/nonmatchings/main", UpdateContext__FP13DRender_tViewi);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_BuildGlareEffects__FP13DRender_tViewP11Draw_DCacheP5Group);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_InitSpikeBelt__Fv);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_SetSpikeBelt__Fiii);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_GetSpikeBelt__FPiN20);

INCLUDE_ASM("asm/nonmatchings/main", SetupBuildMatrices__FP13DRender_tViewP11Draw_DCache);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_CheckChunkVisible__FP12BWorldSm_PosT0);

INCLUDE_ASM("asm/nonmatchings/main", GetRezIndex__Fi);

INCLUDE_ASM("asm/nonmatchings/main", SetupChunkBuildList__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_IsSliceInBuildList__Fi);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_OnyxBuildFacets__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", BWAllocMem__Fl);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_InitContexts__Fv);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_DeInitContexts__Fv);

INCLUDE_ASM("asm/nonmatchings/main", SetContext__Fi);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_OpenContext__Fii);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_Restart__Fv);

void BWorld_StartLoop__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", BWorld_Init__Fv);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_DeInit__Fv);

INCLUDE_ASM("asm/nonmatchings/main", BWorldSm_Init__FP5Group);

INCLUDE_ASM("asm/nonmatchings/main", BWorldSm_Restart__Fv);

void BWorldSm_DeInit__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", FindAbsClosestSliceCrude__FP8coorddefP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", RawFindClosestSlice__FP8coorddefP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", BWorldSm_SetSlice__FiP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", GetStmQuadPts__FP12BWorldSm_PosP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", SetStrip__FP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", GetFirstStmQuadPts__FP12BWorldSm_PosP8CCOORD16);

INCLUDE_ASM("asm/nonmatchings/main", BWorld_SetSimSlice__FP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", BworldSm_UpdateSimQuad__FP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", BworldSm_IsSimQuadValid__FP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", RawFindClosestQuad__FP8coorddefP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", FindClosestQuad__FP8coorddefP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi);

INCLUDE_ASM("asm/nonmatchings/main", BWorldSm_FindClosestQuadMaxIterations__FP8coorddefP12BWorldSm_Posi);

INCLUDE_ASM("asm/nonmatchings/main", PointDirection__FP8coorddefN20);

INCLUDE_ASM("asm/nonmatchings/main", BWorldSm_FindEdgeOff__FP8coorddefP12BWorldSm_PosT1Pi);

INCLUDE_ASM("asm/nonmatchings/main", BWorldSm_QuadLight__FP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", NormalCache_AddEntry__FP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", NormalCache_FindEntry__FP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", NormalCache_Init__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Check_Rot__FP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", BWorldSm_UNormal__FP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", BWorldSm_UForward__FP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi);

INCLUDE_ASM("asm/nonmatchings/main", EulerToMat__FP10matrixtdefiii);

INCLUDE_ASM("asm/nonmatchings/main", Camera_SetCamera__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", Camera_LookBack__FP10matrixtdefT0);

INCLUDE_ASM("asm/nonmatchings/main", Camera_TunnelLimit__FiPi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateCollisionCam__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateSimpleCam__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateBumperCam__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateTailCam__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateHeliCam__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateCircleCam__Fi);

INCLUDE_ASM("asm/nonmatchings/main", SetCameraZoom__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateTVCam__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateAnimCam__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateFinishCam__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateBlimpCam__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_SetSplineCam__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateSplineCam__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_IslandProfile__FUs);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdatePulloverCam__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateCopCam1__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateCopCam2__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_UpdateBTCopCam__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_Update__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Camera_Init__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Camera_Kill__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Camera_PitchAndRoll__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_TooSteep__FiP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", Camera_CheckWallCollisions__FiP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Camera_SetAboveGround__FiP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Camera_AcquireTarget__FiP8coorddefT1P10matrixtdefi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_OpponentLookBehind__FiP8coorddefi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_GetViewInfo__FiP17DRender_tCalcViewi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Camera_GetMode__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_SetMode__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Camera_NextMode__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Camera_ReplayUpdate__FiP15Camera_tCamSlot);

INCLUDE_ASM("asm/nonmatchings/main", Camera_ResetRelPos__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Cars_DoGravityEffectsOnAcc__FP8Car_tObji);

void Cars_GetDashData__FP8Car_tObjPiN21(char *car, int *speed, int *gear, int *rpm) {
    *speed = *(int *)(car + 0x468);
    *gear  = *(unsigned char *)(car + 0x442);
    *rpm   = *(int *)(car + 0x420);
}
INCLUDE_ASM("asm/nonmatchings/main", Cars_QDUpdateVelGlue__FP8Car_tObj);

void Cars_InitDashData__FP8Car_tObjPiT1(char *car, int *a, int *b) {
    char *sec;
    sec = *(char **)(car + 0x464);
    *a  = *(int *)(sec + 0xF0);
    sec = *(char **)(car + 0x464);
    *b  = *(int *)(sec + 0xF4);
}
INCLUDE_ASM("asm/nonmatchings/main", Cars_SetAudioCalls__FP8Car_tObjiiiiii);

INCLUDE_ASM("asm/nonmatchings/main", Cars_ResetCarCounters__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Cars_InitStats__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Cars_ResetVariablesAfterACollision__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Cars_ResetCollidedCars__FP8Car_tObjii);

INCLUDE_ASM("asm/nonmatchings/main", Cars_SetCarUpForHiRezSim__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Cars_DoExtraCarCollisionProcessing__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Cars_AddCarSfx__FP8Car_tObjiP8coorddefiii);

INCLUDE_ASM("asm/nonmatchings/main", Car_TireSkiddingStuff__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Cars_FindTotalSlice__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Car_DoSkiddingStuff__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Car_DoPostCollisionStuff__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Cars_CalculateStartingGridOffset__FP8Car_tObjPiP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Cars_IniCarObjects__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", Cars_InitCar__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", Cars_DeInitCar__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Cars_Restart__Fv);

void Cars_Initialize__FPci(char *buf, int n) {
    int i = 0;
    if (n <= 0) return;
    do {
        *buf++ = 0;
        i++;
    } while (i < n);
}
INCLUDE_ASM("asm/nonmatchings/main", Cars_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Cars_CleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Cars_FindCurrentLap__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Cars_CalculateRoadSpan__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Cars_CalculateRoadPosition__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Cars_CalcVelDownRoad__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Cars_Randomize__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Cars_ManageBureaucracy__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Cars_CheckForAccidentScenes__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Cars_SortCars__Fv);

INCLUDE_ASM("asm/nonmatchings/main", InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem);

void Chunk_UpdateSys__FP13DRender_tView(void) {
}

void Chunk_Init__Fv(void) {
}

void Chunk_DeInit__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Clock_MasterInterruptHandler__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Clock_SystemStartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Clock_SystemCleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CHECK_CENTER_VERTEX_WITH_DIRS__Fiii);

INCLUDE_ASM("asm/nonmatchings/main", CHECK_CENTER_VERTEX_WITH_DIRS_OTHER__Fiii);

INCLUDE_ASM("asm/nonmatchings/main", CHECK_VERTEX_WITH_DIRS__Fiii);

INCLUDE_ASM("asm/nonmatchings/main", CHECK_VERTEX_WITH_DIRS_OTHER__Fiii);

INCLUDE_ASM("asm/nonmatchings/main", Collide_DoObjectFixedObjectCollision__FP13BO_tNewtonObjP8coorddefN21);

INCLUDE_ASM("asm/nonmatchings/main", Collide_LimitAngularVel__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1);

INCLUDE_ASM("asm/nonmatchings/main", Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2);

INCLUDE_ASM("asm/nonmatchings/main", Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2);

INCLUDE_ASM("asm/nonmatchings/main", Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2);

INCLUDE_ASM("asm/nonmatchings/main", Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0);

INCLUDE_ASM("asm/nonmatchings/main", Collide_ClearCollisionRegistry__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Collide_CheckAccuratePointRadiusCollision__FP13BO_tNewtonObjP8coorddefi);

INCLUDE_ASM("asm/nonmatchings/main", Collide_CheckMeForCollisions__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", IsNumChar__Fc);

INCLUDE_ASM("asm/nonmatchings/main", Risk_ReadNextValue__FPPc);

void Control_AI__FP8Car_tObj(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Control_Human__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", func_80092464);

INCLUDE_ASM("asm/nonmatchings/main", HudPmx_InitTextures__Fv);

INCLUDE_ASM("asm/nonmatchings/main", HudPmx_Kill__Fv);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_A_CONFIRM);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_REQUEST_EMS);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_BEGIN_PURS_REP_SPDR);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR_REPLY);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_ENGAGE_PURS_REP_SPDR);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_C_IN_PURS_NEAR_PERP);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_IN_PURS_NEAR_PERP);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_STS);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_IN_PURS_NEAR_PERP_CONFIRM);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_STS);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_IN_PURS_AWAY_PERP_CONFIRM);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_STS);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_C_IDLE_WINGMAN_DISAPPEARS);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_REQ_RDBLK);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_RDBLK_SPBLT_DENIED_REPLY);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_RDBLK_SPBLT_GRANT_REPLY);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_RDBLK_CONFIRMED);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_RDBLK_FAILED);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_REQUEST_BKUP);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_BKUP_REQUEST_GRANT_REPLY);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_BKUP_REQUEST_DENIED_REPLY);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_C_NEW_OFFICER_ENGAGING);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_PERP_SIGHTED);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_PERP_SIGHTED_CONFIRM);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_PERP_LOST);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_PERP_LOST_CONFIRM);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_C_PERP_REAQUIRED);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_PERP_APPREHENSION);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_PERP_APPREHENSION_REPLY);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_PERP_CRASH_GEN);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_P_ARRESTED);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_P_WARNING);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_P_TICKET);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_P_FALSE_ARREST_BULLHORN);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_DURING_FALSE_ARREST);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_P_BULLHORN_SPEECH);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_S_C_SUPER_COP_ARRIVAL);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_S_C_SUPER_COP_CRITICISM);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_LOC);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_IN_PURS_NEAR_PERP_REP_SPD);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_IN_PURS_AWAY_PERP_REPLY_LOC);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_IN_PURS_LOOK_PERP_REPLY_LOC);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_INTRO_CALL);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_A_INTRO);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_IN_PURS_PERP_AIRBORN);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_C_SPBLT_CONFIRMED);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_REQ_SPBLT);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_SPBLT_FAILED);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_W_D_RDBLK_PLC);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_W_D_SPBLT_PLC);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_PERP_CRASH_ROLL);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_D_A_CONFIRM);

INCLUDE_ASM("asm/nonmatchings/main", SPCHNFS_C_D_ENDGAME);

INCLUDE_ASM("asm/nonmatchings/main", Speech_AllocateRAM__FlPc);

INCLUDE_ASM("asm/nonmatchings/main", Speech_PurgeRAM__FPc);

INCLUDE_ASM("asm/nonmatchings/main", Speech_HandleRequest__Fllll);

INCLUDE_ASM("asm/nonmatchings/main", SetCar__Q26Speech11CarBankNamei);

INCLUDE_ASM("asm/nonmatchings/main", Check__Q26Speech7CarBankPciPQ26Speech11CarBankName);

INCLUDE_ASM("asm/nonmatchings/main", CheckCarBank__6SpeechPQ26Speech7CarBankPciPQ26Speech11CarBankName);

INCLUDE_ASM("asm/nonmatchings/main", SetCar__Q26Speech7SpeakerP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", CountLocations__6Speech);

INCLUDE_ASM("asm/nonmatchings/main", CheckLocationBank__6SpeechPQ26Speech12LocationBankPci);

INCLUDE_ASM("asm/nonmatchings/main", Distance__Q26Speech12LocationBanki);

INCLUDE_ASM("asm/nonmatchings/main", FindClosestLocationTo__6SpeechPQ26Speech12LocationBanki);

INCLUDE_ASM("asm/nonmatchings/main", FindLocation__Q26Speech7SpeakerP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci);

INCLUDE_ASM("asm/nonmatchings/main", CheckMultiBank__6SpeechPciPQ26Speech11CarBankName);

INCLUDE_ASM("asm/nonmatchings/main", CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3);

INCLUDE_ASM("asm/nonmatchings/main", LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell);

INCLUDE_ASM("asm/nonmatchings/main", __6Speech);

INCLUDE_ASM("asm/nonmatchings/main", Reset__6Speech);

INCLUDE_ASM("asm/nonmatchings/main", ___6Speech);

INCLUDE_ASM("asm/nonmatchings/main", BankPatch__6SpeechlP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", SubmitRequest__6Speechlll);

void Report__Q26Speech7SpeakerP8Car_tObj(void) {
}

void Deny__Q26Speech7Speaker(void) {
}

void Grant__Q26Speech7Speaker(void) {
}

void Ready__Q26Speech7SpeakerP8Car_tObj(void) {
}

void Engage__Q26Speech7SpeakerP8Car_tObj(void) {
}

void Lose__Q26Speech7Speaker(void) {
}

void Accident__Q26Speech7Speakeri(void) {
}

void Catch__Q26Speech7Speakeri(void) {
}

void RoadBlock__Q26Speech7Speaker(void) {
}

void SpikeBelt__Q26Speech7Speaker(void) {
}

void Backup__Q26Speech7Speaker(void) {
}

void ReportBlockade__Q26Speech7Speaker(void) {
}

void Roger__Q26Speech7Speaker(void) {
}

void Bullhorn__Q26Speech7Speaker(void) {
}

void Purge__Q26Speech7Speaker(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Promote__Q26Speech7Speaker);

INCLUDE_ASM("asm/nonmatchings/main", Speech_Server__Fv);

INCLUDE_ASM("asm/nonmatchings/main", SetDelayedStatus__6SpeechPQ26Speech7Speakeri);

INCLUDE_ASM("asm/nonmatchings/main", Activate__Q26Speech15DispatchSpeakeri);

INCLUDE_ASM("asm/nonmatchings/main", Dispatch__6Speech);

INCLUDE_ASM("asm/nonmatchings/main", Roger__Q26Speech15DispatchSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", StatusReply__Q26Speech15DispatchSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", Status__Q26Speech15DispatchSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", Status__Q26Speech13MobileSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", ClearPerp__Q26Speech15DispatchSpeakerP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", KnownPerp__Q26Speech15DispatchSpeakerP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", AddPerp__Q26Speech15DispatchSpeakerP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Report__Q26Speech15DispatchSpeakerP8Car_tObj);

void Accident__Q26Speech15DispatchSpeakeri(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Deny__Q26Speech15DispatchSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", Grant__Q26Speech15DispatchSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", Ready__Q26Speech15DispatchSpeakerP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", PickVoice__6SpeechP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", GetVoice__6SpeechP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Activate__Q26Speech13MobileSpeakerP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", ReActivate__Q26Speech13MobileSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", FindMobile__6SpeechP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Mobile__6SpeechP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", CalcMph__Q26Speech7SpeakerP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", SetSpeed__Q26Speech13MobileSpeakerP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", DistToPerp__Q26Speech13MobileSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", Report__Q26Speech13MobileSpeakerP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Engage__Q26Speech13MobileSpeakerP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Lose__Q26Speech13MobileSpeaker);

void Accident__Q26Speech13MobileSpeakeri(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Catch__Q26Speech13MobileSpeakeri);

INCLUDE_ASM("asm/nonmatchings/main", RoadBlock__Q26Speech13MobileSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", SpikeBelt__Q26Speech13MobileSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", Backup__Q26Speech13MobileSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", Roger__Q26Speech13MobileSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", Bullhorn__Q26Speech13MobileSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", Purge__Q26Speech13MobileSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", ReportBlockade__Q26Speech13MobileSpeaker);

int Perp__Q26Speech13MobileSpeaker(void *a0) {
    return *(int *)((char *)a0 + 0x64);
}
int Unit__Q26Speech13MobileSpeaker(void *a0) {
    return *(int *)((char *)a0 + 0x5C);
}
INCLUDE_ASM("asm/nonmatchings/main", CallSign__Q26Speech13MobileSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", FindClosestLocationTo__Q26Speech13MobileSpeakeri);

INCLUDE_ASM("asm/nonmatchings/main", GetCarBank__Q26Speech13MobileSpeakeri);

int CarObj__Q26Speech13MobileSpeaker(void *a0) {
    return *(int *)((char *)a0 + 0x60);
}
int IsSuper__Q26Speech13MobileSpeaker(void *this) {
    unsigned int v = *(unsigned int *)((char *)*(void **)((char *)this + 0x60) + 0x260);
    return (v >> 6) & 1;
}
INCLUDE_ASM("asm/nonmatchings/main", CallSign__Q26Speech15DispatchSpeaker);

INCLUDE_ASM("asm/nonmatchings/main", FindClosestLocationTo__Q26Speech15DispatchSpeakeri);

INCLUDE_ASM("asm/nonmatchings/main", GetCarBank__Q26Speech15DispatchSpeakeri);

void PurgeStatusSub__Q26Speech15DispatchSpeaker(void *this) {
    *(int *)((char *)this + 0x54) = 0;
}
int StatusSub__Q26Speech15DispatchSpeaker(void *a0) {
    return *(int *)((char *)a0 + 0x54);
}
int StatusCount__Q26Speech15DispatchSpeaker(void *a0) {
    return *(int *)((char *)a0 + 0x50);
}
void *CallSign__Q26Speech7Speaker(void *this) {
    return 0;
}
int FindClosestLocationTo__Q26Speech7Speakeri(void *this, int a) { return 0; }
int GetCarBank__Q26Speech7Speakeri(void *this, int a) { return 0; }
int Perp__Q26Speech7Speaker(void *this) { return 0; }
void ReActivate__Q26Speech7Speaker(void) {
}

void *CarObj__Q26Speech7Speaker(void *this) {
    return 0;
}
int DistToPerp__Q26Speech7Speaker(void *this) {
    return 0x03E80000;
}
void PurgeStatusSub__Q26Speech7Speaker(void) {
}

int StatusSub__Q26Speech7Speaker(void *this) { return 0; }
int StatusCount__Q26Speech7Speaker(void *this) { return 0; }
int IsSuper__Q26Speech7Speaker(void *this) { return 0; }
void ClearPerp__Q26Speech7SpeakerP8Car_tObj(void) {
}

int KnownPerp__Q26Speech7SpeakerP8Car_tObj(void *this, void *c) { return 0; }
int Unit__Q26Speech7Speaker(void *this) { return 0; }
void Status__Q26Speech7Speaker(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_RadioStaticInit__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_RadioStaticActive__Fi);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_RadioStaticSquelch__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_InitRequest__FP17CopSpeak_tRequest);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_SilenceCop__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Alloc__FP17CopSpeak_tRequest);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Free__FP17CopSpeak_tRequest);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_ReadyNextRequest__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Cancel__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Stop__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_CleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_InitVars__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_DirectRequest__FillP8Car_tObjPc);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_GenericBankRequest__FiP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_GetEnginePatch__Fii);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Play__FP17CopSpeak_tRequesti);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Skip__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Request__FP17CopSpeak_tRequest);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_BankVolume__FP17CopSpeak_tRequest);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_LoadNextRequest__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_PlayNextRequest__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Flush__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Server__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_SfxQueued__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_ShowQueue__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CopSpeak_Debug__Fv);

INCLUDE_ASM("asm/nonmatchings/main", DashHUD_InitHUD__Fv);

INCLUDE_ASM("asm/nonmatchings/main", DashHUD_KillHUD__Fv);

INCLUDE_ASM("asm/nonmatchings/main", DashHUD_ResetHUD__Fv);

INCLUDE_ASM("asm/nonmatchings/main", DashHUD_ToggleHud__Fi);

INCLUDE_ASM("asm/nonmatchings/main", DashHUD_CheckWrongWay__Fi);

INCLUDE_ASM("asm/nonmatchings/main", DashHUD_HUDCalc__Fi);

void FastRandom_CleanUp__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", FastRandom_StartUp__FUi);

INCLUDE_ASM("asm/nonmatchings/main", GenericPMX_LoadTexture__Fv);

INCLUDE_ASM("asm/nonmatchings/main", GameSetup_StartUp__FPi);

void GameSetup_CleanUp__Fv(void) {
}

char *LocateNextGroupType__15SerializedGroupi(char *grp, int type) {
    char *p = grp + *(int *)(grp + 4);
    if (*(int *)p != type) return 0;
    return p;
}
INCLUDE_ASM("asm/nonmatchings/main", LocateGroupType__15SerializedGroupii);

INCLUDE_ASM("asm/nonmatchings/main", LocateGroupNum__15SerializedGroupi);

INCLUDE_ASM("asm/nonmatchings/main", LocateCreateGroupType__15SerializedGroupiP9SimpleMemi);

INCLUDE_ASM("asm/nonmatchings/main", CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem);

INCLUDE_ASM("asm/nonmatchings/main", CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi);

INCLUDE_ASM("asm/nonmatchings/main", Input_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Input_WingCommandMode__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Input_Update__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Input_Store__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Input_Fetch__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Input_Gear__Fci);

INCLUDE_ASM("asm/nonmatchings/main", Input_Interface__FUli);

INCLUDE_ASM("asm/nonmatchings/main", Input_MainExitKey__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Math_DistXZ__FP8coorddefT0);

INCLUDE_ASM("asm/nonmatchings/main", Math_Dist3D__FP8coorddefT0);

INCLUDE_ASM("asm/nonmatchings/main", Math_BetterDist__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Math_ResolveRotatedVector__FiiiPiT3);

INCLUDE_ASM("asm/nonmatchings/main", Math_VectorLength__FP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Math_VectorLength2__FP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Math_NormalizeVector__FP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Math_NormalizeShortVector__FP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Math_QDNormalizeVector__FP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Math_fasttransmult__FP10matrixtdefN20);

INCLUDE_ASM("asm/nonmatchings/main", __14tPauseMenuDefs);

INCLUDE_ASM("asm/nonmatchings/main", ___14tPauseMenuDefs);

INCLUDE_ASM("asm/nonmatchings/main", MPause_MusicLogic__Fc);

INCLUDE_ASM("asm/nonmatchings/main", MPause_ControllerLogic__Fv);

INCLUDE_ASM("asm/nonmatchings/main", MPause_Logic__Fv);

INCLUDE_ASM("asm/nonmatchings/main", MPause_Render__Fv);

INCLUDE_ASM("asm/nonmatchings/main", MPause_InitMPause__Fv);

INCLUDE_ASM("asm/nonmatchings/main", MPause_StartPauseMenu__Fv);

INCLUDE_ASM("asm/nonmatchings/main", MPause_EndPauseMenu__Fv);

INCLUDE_ASM("asm/nonmatchings/main", MPause_KillMPause__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Newton_AddDamageZone__FP13BO_tNewtonObjiii);

INCLUDE_ASM("asm/nonmatchings/main", Newton_FindClosestQuad__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Newton_CalculateSliceYaw__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Newton_UpdateRoadGeometry__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Newton_FindGroundElevationGeneral__FP8coorddefN20);

INCLUDE_ASM("asm/nonmatchings/main", Newton_FindGroundElevationRough__FP8coorddefN20);

INCLUDE_ASM("asm/nonmatchings/main", Newton_FindGroundElevationAndNormalFast__FP13BO_tNewtonObjP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Newton_CalcPerpenHeightOfLowestPointFromGround__FP13BO_tNewtonObjP8coorddefT1);

INCLUDE_ASM("asm/nonmatchings/main", Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1);

INCLUDE_ASM("asm/nonmatchings/main", Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Newton_UpdateRoadInfo__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Newton_CopyRoadMatrixToOrientMat__FP13BO_tNewtonObji);

INCLUDE_ASM("asm/nonmatchings/main", Newton_CopyRoadMatrixToShadowMat__FP13BO_tNewtonObji);

INCLUDE_ASM("asm/nonmatchings/main", Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi);

INCLUDE_ASM("asm/nonmatchings/main", Newton_InitBaseNewtonObj__FP13BO_tNewtonObjiiiiii);

INCLUDE_ASM("asm/nonmatchings/main", Newton_QDUpdateVel__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Newton_OptzRotxform__FP10matrixtdefiiiPiiT4);

INCLUDE_ASM("asm/nonmatchings/main", Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi);

INCLUDE_ASM("asm/nonmatchings/main", Newton_CalcRealShadowCoordinates__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", Newton_CheckForSpikeBelts__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi);

INCLUDE_ASM("asm/nonmatchings/main", Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Newton_LimitAngularVelocity__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Newton_CalculateRoadPositionFromSliceAndPosition__FiP8coorddefP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", Newton_CalculateRoadPosition__FP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", __builtin_new);

INCLUDE_ASM("asm/nonmatchings/main", __builtin_vec_new);

INCLUDE_ASM("asm/nonmatchings/main", __builtin_delete);

INCLUDE_ASM("asm/nonmatchings/main", __builtin_vec_delete);

INCLUDE_ASM("asm/nonmatchings/main", Nfs2_SystemNLibStartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Nfs2_BefuddleCode__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Nfs2_ResetGame__Fv);

INCLUDE_ASM("asm/nonmatchings/main", func_800A3F08);

INCLUDE_ASM("asm/nonmatchings/main", Nfs2_GameModuleStartUp__FPi);

INCLUDE_ASM("asm/nonmatchings/main", Nfs2_CleanUpGameModule__Fv);

INCLUDE_ASM("asm/nonmatchings/main", LoadFrontendOverlay__Fv);

INCLUDE_ASM("asm/nonmatchings/main", LoadOverlay__Fv);

INCLUDE_ASM("asm/nonmatchings/main", NFS4_LoadingIcon__Fv);

INCLUDE_ASM("asm/nonmatchings/main", NFS3_CheckForFileOperations__Fv);

INCLUDE_ASM("asm/nonmatchings/main", main);

INCLUDE_ASM("asm/nonmatchings/main", CalcObjYawAngle__FP8CCOORD16);

INCLUDE_ASM("asm/nonmatchings/main", CalcObjExtentPoints__FP8coorddefP8CCOORD16T0P5tQuat);

INCLUDE_ASM("asm/nonmatchings/main", BuildObjCollisionMatrix__FiiiP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", FindObjInstanceFromSerialNum__FP5Groupi);

INCLUDE_ASM("asm/nonmatchings/main", Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi);

INCLUDE_ASM("asm/nonmatchings/main", GetSimObj__FiP18Object_tSimObjListPi);

INCLUDE_ASM("asm/nonmatchings/main", Object_GetRadiusCollisionData__FP18Object_tSimObjListiP8coorddefPi);

INCLUDE_ASM("asm/nonmatchings/main", Object_GetPointsCollisionData__FP18Object_tSimObjListiPiP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Object_InitStatus__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Object_KillStatus__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Object_GetAnim__FP13Trk_SimObject);

INCLUDE_ASM("asm/nonmatchings/main", Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj);

INCLUDE_ASM("asm/nonmatchings/main", Object_InitCustomObjects__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Object_DeInitCustomObjects__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Object_ClearCustomObjects__Fv);

INCLUDE_ASM("asm/nonmatchings/main", SetCautionSurface__FP8coorddefP12BWorldSm_Pos);

INCLUDE_ASM("asm/nonmatchings/main", Object_AddCustomSimObject__FP9SceneElemii);

INCLUDE_ASM("asm/nonmatchings/main", Object_GetObjDefID__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Object_FindDefWithThisID__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Object_AddCustomObject__FP9SceneElemi);

INCLUDE_ASM("asm/nonmatchings/main", GetObjMaxDimensions__FPP13Trk_ObjectDefP14Trk_SimpleInstP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Object_InitIMassObjectInfo__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Object_DeInitIMassObjectInfo__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Object_GetNumIMassObjects__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Object_GetIMassObjectDimensions__FiP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Object_GetIMassObjectMotion__FiP8coorddefP10matrixtdefT1);

int Draw__23ObjectFinishedMultiAnimP13DRender_tViewP11Draw_DCachei(void *a, void *b, int c) { return 2; }
INCLUDE_ASM("asm/nonmatchings/main", __15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim);

INCLUDE_ASM("asm/nonmatchings/main", Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei);

INCLUDE_ASM("asm/nonmatchings/main", Draw__22ObjectFinishedSignAnimP13DRender_tViewP11Draw_DCachei);

INCLUDE_ASM("asm/nonmatchings/main", __14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim);

INCLUDE_ASM("asm/nonmatchings/main", Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei);

INCLUDE_ASM("asm/nonmatchings/main", ___14ObjectSignAnim);

INCLUDE_ASM("asm/nonmatchings/main", ___22ObjectFinishedSignAnim);

INCLUDE_ASM("asm/nonmatchings/main", ___15ObjectMultiAnim);

INCLUDE_ASM("asm/nonmatchings/main", ___23ObjectFinishedMultiAnim);

INCLUDE_ASM("asm/nonmatchings/main", func_800A6DE0);

INCLUDE_ASM("asm/nonmatchings/main", Paths_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", PauseMenu_FullText__FPcsss);

INCLUDE_ASM("asm/nonmatchings/main", PauseMenu_MenuTextPositioned__Fssss);

INCLUDE_ASM("asm/nonmatchings/main", PauseMenu_MenuText__FsbT1);

INCLUDE_ASM("asm/nonmatchings/main", __14tPListIteratorPsPi);

INCLUDE_ASM("asm/nonmatchings/main", ___14tPListIterator);

INCLUDE_ASM("asm/nonmatchings/main", Value__14tPListIterator7tPlayer);

INCLUDE_ASM("asm/nonmatchings/main", TextValue__14tPListIterator7tPlayer);

INCLUDE_ASM("asm/nonmatchings/main", Increment__14tPListIterator7tPlayer);

INCLUDE_ASM("asm/nonmatchings/main", Decrement__14tPListIterator7tPlayer);

INCLUDE_ASM("asm/nonmatchings/main", __21tPListIteratorIndexedPsPiPc);

INCLUDE_ASM("asm/nonmatchings/main", ___21tPListIteratorIndexed);

int Value__21tPListIteratorIndexed7tPlayer(char *this) {
    unsigned char *idxp = *(unsigned char **)(this + 0xC);
    int *array = *(int **)(this + 4);
    return array[*idxp];
}
INCLUDE_ASM("asm/nonmatchings/main", TextValue__21tPListIteratorIndexed7tPlayer);

INCLUDE_ASM("asm/nonmatchings/main", Increment__21tPListIteratorIndexed7tPlayer);

INCLUDE_ASM("asm/nonmatchings/main", Decrement__21tPListIteratorIndexed7tPlayer);

INCLUDE_ASM("asm/nonmatchings/main", __10tPMenuItemUi);

INCLUDE_ASM("asm/nonmatchings/main", ___10tPMenuItem);

int NextMenu__10tPMenuItem(void *this) { return 0; }
int Debounce__10tPMenuItem(void *this) { return 1; }
void ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", __28tPMenuItemNonInteractiveTextUi);

INCLUDE_ASM("asm/nonmatchings/main", ___28tPMenuItemNonInteractiveText);

INCLUDE_ASM("asm/nonmatchings/main", Draw__28tPMenuItemNonInteractiveTextb);

INCLUDE_ASM("asm/nonmatchings/main", __21tPMenuItemInteractiveUi);

INCLUDE_ASM("asm/nonmatchings/main", ___21tPMenuItemInteractive);

INCLUDE_ASM("asm/nonmatchings/main", Draw__21tPMenuItemInteractiveb);

INCLUDE_ASM("asm/nonmatchings/main", __25tPMenuItemLeftRightChoiceUiP14tPListIterator);

INCLUDE_ASM("asm/nonmatchings/main", ___25tPMenuItemLeftRightChoice);

INCLUDE_ASM("asm/nonmatchings/main", ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand);

INCLUDE_ASM("asm/nonmatchings/main", Draw__25tPMenuItemLeftRightChoiceb);

INCLUDE_ASM("asm/nonmatchings/main", __25tPMenuItemLeftRightSliderUiPic);

INCLUDE_ASM("asm/nonmatchings/main", ___25tPMenuItemLeftRightSlider);

int Debounce__25tPMenuItemLeftRightSlider(void *this) { return 0; }
INCLUDE_ASM("asm/nonmatchings/main", ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand);

INCLUDE_ASM("asm/nonmatchings/main", Draw__25tPMenuItemLeftRightSliderb);

INCLUDE_ASM("asm/nonmatchings/main", __32tPMenuItemLeftRightSliderIndexedUiPicPc);

INCLUDE_ASM("asm/nonmatchings/main", ___32tPMenuItemLeftRightSliderIndexed);

INCLUDE_ASM("asm/nonmatchings/main", ProcessInput__32tPMenuItemLeftRightSliderIndexedR13tInputKeyTypeR13tPMenuCommand);

INCLUDE_ASM("asm/nonmatchings/main", Draw__32tPMenuItemLeftRightSliderIndexedb);

INCLUDE_ASM("asm/nonmatchings/main", __24tPMenuItemGoToMenuButtonUiP6tPMenuPFR13tPMenuCommand_v);

INCLUDE_ASM("asm/nonmatchings/main", ___24tPMenuItemGoToMenuButton);

int NextMenu__24tPMenuItemGoToMenuButton(void *a0) {
    return *(int *)((char *)a0 + 0xC);
}
INCLUDE_ASM("asm/nonmatchings/main", ProcessInput__24tPMenuItemGoToMenuButtonR13tInputKeyTypeR13tPMenuCommand);

INCLUDE_ASM("asm/nonmatchings/main", __23tPMenuItemCommandButtonUi17tPMenuCommandType);

INCLUDE_ASM("asm/nonmatchings/main", ___23tPMenuItemCommandButton);

INCLUDE_ASM("asm/nonmatchings/main", ProcessInput__23tPMenuItemCommandButtonR13tInputKeyTypeR13tPMenuCommand);

INCLUDE_ASM("asm/nonmatchings/main", tPMenuConstructor__6tPMenuP10tPMenuItemPv);

INCLUDE_ASM("asm/nonmatchings/main", __6tPMenuP10tPMenuIteme);

INCLUDE_ASM("asm/nonmatchings/main", ___6tPMenu);

INCLUDE_ASM("asm/nonmatchings/main", Initialize__6tPMenu);

INCLUDE_ASM("asm/nonmatchings/main", Debounce__6tPMenu);

INCLUDE_ASM("asm/nonmatchings/main", CheckForDisabled__6tPMenu);

INCLUDE_ASM("asm/nonmatchings/main", ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand);

INCLUDE_ASM("asm/nonmatchings/main", Draw__6tPMenu);

INCLUDE_ASM("asm/nonmatchings/main", NumEnabledItems__6tPMenu);

INCLUDE_ASM("asm/nonmatchings/main", ItemEnabledNum__6tPMenui);

int IsNavigable__21tPMenuItemInteractive(void *this) { return 1; }
int IsNavigable__28tPMenuItemNonInteractiveText(void *this) { return 0; }
INCLUDE_ASM("asm/nonmatchings/main", IsEnabled__10tPMenuItem);

INCLUDE_ASM("asm/nonmatchings/main", IsDisabled__10tPMenuItem);

INCLUDE_ASM("asm/nonmatchings/main", Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo);

INCLUDE_ASM("asm/nonmatchings/main", Physics_CalculateDerivedCarSpecs__FP8Car_tObj);

void Physics_CheckGamedata__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", Physics_SetCurrentWallType__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Physics_GetTorque__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Physics_DoBarrierCheck__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Physics_AutoShift__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Physics_RampCarControlValues__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Physics_FixEngineRpm__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Physics_ResetCar__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Physics_StopCar__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Physics_TestForBarrierCollision__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Physics_CalculateRoadGripModifiers__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Physics_CalculateCarAcceleration__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct);

INCLUDE_ASM("asm/nonmatchings/main", Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct);

INCLUDE_ASM("asm/nonmatchings/main", Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct);

INCLUDE_ASM("asm/nonmatchings/main", Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii);

INCLUDE_ASM("asm/nonmatchings/main", Physics_Real__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Physics_SimCar__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Quatern_VecInterpolate__FP8coorddefT0iT0);

INCLUDE_ASM("asm/nonmatchings/main", Quatern_Interpolate__FP5tQuatT0P8coorddefT2iT0T2);

INCLUDE_ASM("asm/nonmatchings/main", Quatern_QuatToMat__FP5tQuatP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", Quatern_MatToQuat__FP10matrixtdefP5tQuat);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_ChangeTrafficColor__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_PostStartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_Restart__Fv);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_CleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_ReadInCarData__FPcP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", R3DCcar_ReadeMapData__Fv);

INCLUDE_ASM("asm/nonmatchings/main", R3DCcar_ReadTrackShadow__Fv);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_CalcCarDimensions__FP8Car_tObjP18Transformer_zScenei);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_DeInstantiate3DCar__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_DeInstantiate3DCarMenu__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_GetFileName__FPcN20);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_LoadFileAdr__FPc);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_GetCarName__FPcii);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_Instantiate3DCar__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_Visibilty__FP8Car_tObjP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_TurnHeadLightOn__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_TurnHeadLightOff__FP8Car_tObji);

void R3DCar_MATRIX3DT_Copy__FPiT0(int *src, int *dst) {
    int i = 8;
    do {
        *dst++ = *src++;
        i--;
    } while (i != -1);
}
INCLUDE_ASM("asm/nonmatchings/main", R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_ReadInCarTextureMenu__FP8Car_tObjPcii);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_InsertCarFacetII__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_InsertCarFacetMenuII__FP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_Showroom__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_InsertCarFacetZ__FP8Car_tObjP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", R3DCar_InsertAllListFacet__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", Render_CreatePlayerViews__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_CreatePauseMenuViews__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_CreateViews__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_StartRenderingWorldView__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Render_StopRenderingWorldView__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Render_RenderWorld__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", Render_RenderPlayerView__Fii);

void Render_RenderDebugView__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Render_StartFrameRender__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_StopFrameRender__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_InitPauseMenu__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_RenderPauseMenuView__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_KillPauseMenu__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_Render__Fi);

INCLUDE_ASM("asm/nonmatchings/main", FlareThing__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_InitTrackRender__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_RestartTrackRender__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_InitTrackRenderPostSim__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_KillTrackRender__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_InitLibRender__Fv);

INCLUDE_ASM("asm/nonmatchings/main", StampImage__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Render_InitBlurMode__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Render_InsertDepthOfField__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Replay_Compress__FPc);

INCLUDE_ASM("asm/nonmatchings/main", Replay_Decompress__FPc);

INCLUDE_ASM("asm/nonmatchings/main", Replay_InitReplay__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Replay_ResetReplay__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Replay_StoringReplay__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Replay_StoringControllerData__FG15tControllerData);

INCLUDE_ASM("asm/nonmatchings/main", Replay_RetreivingControllerData__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Replay_SaveInput__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Replay_GetInput__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Replay_SaveReplay__Fv);

void Replay_LoadReplay__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Replay_DoReplay__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Replay_GetInterfaceKey__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Replay_LoadCameraFile__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Replay_ReplayChooseCamera__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Replay_ReplayFindClosestCamera__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Scene_Init__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Scene_DeInit__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Scene_PurgeScene__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Scene_BuildCustomSceneList__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Scene_LoadSceneFile__Fi);

INCLUDE_ASM("asm/nonmatchings/main", GetPlaneY__FPC8coorddefN20);

INCLUDE_ASM("asm/nonmatchings/main", Sched_ExecuteCheck__FiiiiPiN24i);

INCLUDE_ASM("asm/nonmatchings/main", Sched_CreateNewSchedule__FPci);

INCLUDE_ASM("asm/nonmatchings/main", Sched_CleanUpSchedule__FP15Sched_tSchedule);

INCLUDE_ASM("asm/nonmatchings/main", Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi);

INCLUDE_ASM("asm/nonmatchings/main", Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv);

INCLUDE_ASM("asm/nonmatchings/main", Sched_Execute__FP15Sched_tSchedule);

INCLUDE_ASM("asm/nonmatchings/main", Sim_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Sim_Restart__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Sim_CleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Sim_FadeInSFX__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Sim_ProcessSimSchedules__Fv);

INCLUDE_ASM("asm/nonmatchings/main", func_800B6B9C);

INCLUDE_ASM("asm/nonmatchings/main", Sim_CheckForPause__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Sim_MainGameLoop__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Alloc__9SimpleMemii);

INCLUDE_ASM("asm/nonmatchings/main", FeignAlloc__9SimpleMemi);

INCLUDE_ASM("asm/nonmatchings/main", ResizeToFit__9SimpleMem);

INCLUDE_ASM("asm/nonmatchings/main", SimQueue_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", SimQueue_Reset__Fv);

INCLUDE_ASM("asm/nonmatchings/main", SimQueue_CleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", SimQueue_Put__FiP14Input_tResults);

INCLUDE_ASM("asm/nonmatchings/main", SimQueue_SetCurrentInput__Fi);

INCLUDE_ASM("asm/nonmatchings/main", SimQueue_GetCurrentInput__FiP14Input_tResults);

INCLUDE_ASM("asm/nonmatchings/main", func_800B75CC);

INCLUDE_ASM("asm/nonmatchings/main", func_800B75F8);

INCLUDE_ASM("asm/nonmatchings/main", GetGustWind__FP17Souffle_tISouffle);

INCLUDE_ASM("asm/nonmatchings/main", GetAngleWind__FP17Souffle_tISouffle);

INCLUDE_ASM("asm/nonmatchings/main", MoveAngleWind__FP17Souffle_tISouffle);

INCLUDE_ASM("asm/nonmatchings/main", Souffle_Add__FP8coorddefiT0iii);

INCLUDE_ASM("asm/nonmatchings/main", Souffle_DoSouffle__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Souffle_CircleClip__FP8coorddefT0i);

INCLUDE_ASM("asm/nonmatchings/main", Souffle_InsertFacet__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", Souffle_InitTrackSouffle__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Souffle_RestartTrackSouffle__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Souffle_KillTrackSouffle__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Stats_DoPlayerGlue__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Stats_ClearPosition__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Stats_GetPosition__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Stats_GetNumOpponents__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Stats_TrackStats__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Stats_ExtrapolateOpponentTimes__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Stats_TrackEndGame__Fv);

INCLUDE_ASM("asm/nonmatchings/main", TextSys_LoadWordsGeneric__FiPc);

INCLUDE_ASM("asm/nonmatchings/main", TextSys_LoadInGame__Fi);

INCLUDE_ASM("asm/nonmatchings/main", TextSys_LoadWords__Fi);

INCLUDE_ASM("asm/nonmatchings/main", TextSys_Word__Fi);

INCLUDE_ASM("asm/nonmatchings/main", TextSys_WordFlags__Fi);

INCLUDE_ASM("asm/nonmatchings/main", TextSys_WordX__Fi);

INCLUDE_ASM("asm/nonmatchings/main", TextSys_WordY__Fi);

INCLUDE_ASM("asm/nonmatchings/main", TextSys_UnloadWords__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Track_SetTrackNumber__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Track_MakeTrackPathName__FPc);

INCLUDE_ASM("asm/nonmatchings/main", Track_MakeTrackDataPathName__FPc);

INCLUDE_ASM("asm/nonmatchings/main", AllocArtResource__FP18Track_tArtresourcei);

INCLUDE_ASM("asm/nonmatchings/main", InitArtResources__Fv);

INCLUDE_ASM("asm/nonmatchings/main", DeInitArtResources__Fv);

INCLUDE_ASM("asm/nonmatchings/main", LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii);

INCLUDE_ASM("asm/nonmatchings/main", LoadShapesAndMakePmx_EnvMap__FPcP12Draw_tPixMapii);

INCLUDE_ASM("asm/nonmatchings/main", TexturesLoadInitial__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Track_AnimateTextures__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Track_GetProperMultiPalShapeIndex__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Track_ProcessFlipAndUVFlags__FiP12Draw_tPixMapT1);

INCLUDE_ASM("asm/nonmatchings/main", Track_AssociateSingleMaterial__FP12Trk_MaterialP15Track_tMaterialP18Track_tArtresource);

INCLUDE_ASM("asm/nonmatchings/main", Track_LinkMaterials__FP15SerializedGroupiP15Track_tMaterial);

INCLUDE_ASM("asm/nonmatchings/main", ReduceObjectPrecision__FP5GroupT0i);

INCLUDE_ASM("asm/nonmatchings/main", InvalidatePersistentCollideBoomObjects__FP5GroupT0);

INCLUDE_ASM("asm/nonmatchings/main", CalcObjectBoundingSphere__FP5GroupT0);

INCLUDE_ASM("asm/nonmatchings/main", CalcObjDefPtrs__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Track_InitPersistentData__FP15SerializedGroup);

INCLUDE_ASM("asm/nonmatchings/main", Track_Init__FPc);

INCLUDE_ASM("asm/nonmatchings/main", Track_DeInit__Fv);

void Track_AnimateTrackLighting__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", KillFile_OpenRead__Fv);

void KillFile_ReadEntry__FPciRiT2(char *file, int i, int *hash, int *size) {
    int *p = (int *)(file + i * 8);
    *hash = p[1];
    *size = p[2];
}
INCLUDE_ASM("asm/nonmatchings/main", Track_LoadObjectKillData__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Save__11SaveSurfaceP14Trk_NewSimQuad);

INCLUDE_ASM("asm/nonmatchings/main", __11SaveSurfacei);

INCLUDE_ASM("asm/nonmatchings/main", ___11SaveSurface);

INCLUDE_ASM("asm/nonmatchings/main", RestoreAll__11SaveSurface);

INCLUDE_ASM("asm/nonmatchings/main", TrgSfx_AddEnviroEffect__FiiP8coorddefT2);

INCLUDE_ASM("asm/nonmatchings/main", TrgSfx_AddCarSfx__FiP8coorddefiT1);

INCLUDE_ASM("asm/nonmatchings/main", TrgSfx_AddCarWheelSfx__FiiP8coorddefiT2i);

INCLUDE_ASM("asm/nonmatchings/main", TrgSfx_AddCarExtraCheck__Fii);

INCLUDE_ASM("asm/nonmatchings/main", TrgSfx_AddCarExtraSfx__FiiP8coorddefiT2iii);

INCLUDE_ASM("asm/nonmatchings/main", TrgSfx_AddCarSplash__FiiP8coorddefiT2ii);

INCLUDE_ASM("asm/nonmatchings/main", TrgSfx_CrashCar__FP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", TrgSfx_AddSkidmark__FiiP8coorddefiiP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", TrgSfx_InitTrgSfx__Fv);

INCLUDE_ASM("asm/nonmatchings/main", TrgSfx_RestartTrgSfx__Fv);

void TrgSfx_KillTrgSfx__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Udff_Opena__FPcT0i);

INCLUDE_ASM("asm/nonmatchings/main", Udff_Close__FP10Udff_tInfo);

int Udff_GetInt__FP10Udff_tInfo(void *this) {
    int **pp = (int **)((char *)this + 8);
    int *p = *pp;
    int v = *p;
    *pp = p + 1;
    return v;
}
INCLUDE_ASM("asm/nonmatchings/main", Udff_GetBuffer__FP10Udff_tInfoPci);

INCLUDE_ASM("asm/nonmatchings/main", Audio_InitDriver__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Audio_DeInitDriver__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Audio_CleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Audio_FECleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_AddBank__FPciT0i);

INCLUDE_ASM("asm/nonmatchings/main", AudioCmn_LoadBank__FPci);

INCLUDE_ASM("asm/nonmatchings/main", CarIO_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CarIO_CleanUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CarIO_ReStart__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CarIO_CopyFromShape__FPsT0iiii);

INCLUDE_ASM("asm/nonmatchings/main", CarIO_CopyToShape__FPsT0i);

INCLUDE_ASM("asm/nonmatchings/main", CarIO_CreateLicense__FPcii);

INCLUDE_ASM("asm/nonmatchings/main", CarIO_CleanUpLicense__Fi);

INCLUDE_ASM("asm/nonmatchings/main", CarIO_LicenseCheck__FiPiT1P8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", CarIO_ReadInCarTextureData__FPcP8Car_tObjii);

INCLUDE_ASM("asm/nonmatchings/main", CarIO_UpdateCarTextureData__FPcP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", CarIO_ReleaseCarCluts__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Device_VerifyType__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Device_Fail__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Device_Update__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Device_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Device_SetHardCodedKeys__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Device_PSXPad__FUl);

INCLUDE_ASM("asm/nonmatchings/main", Device_ReadPad__FiUl);

INCLUDE_ASM("asm/nonmatchings/main", Device_PSXPadMulti__FUl);

INCLUDE_ASM("asm/nonmatchings/main", Device_Analog__FUl);

int Device_Null__FUl(unsigned long x) { return 0; }
INCLUDE_ASM("asm/nonmatchings/main", Draw_SetView__Fiiiiiiiii);

INCLUDE_ASM("asm/nonmatchings/main", Draw_InitViews__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Draw_InitViewOT__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Draw_InitViewOTInGame__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Draw_DeInitViews__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Draw_DeInitViewsInGame__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Draw_GetDRAWENV__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Draw_SetViewMemBudget__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Draw_SetViewColor__Fiiii);

INCLUDE_ASM("asm/nonmatchings/main", AllocatePrimitivesBuffer__Fv);

INCLUDE_ASM("asm/nonmatchings/main", ClearPrimitivesBuffer__Fv);

INCLUDE_ASM("asm/nonmatchings/main", ClearPlatformPrimitivesBuffer__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Draw_StartRenderingView__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Draw_StopRenderingView__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Draw_CheckFirstFrameRender__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Draw_StartFrameRender__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Draw_SetDrawSyncCallback__FPFv_v);

INCLUDE_ASM("asm/nonmatchings/main", Draw_StopFrameRender__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Draw_DrawDirectScreen__FP8shapetblii);

INCLUDE_ASM("asm/nonmatchings/main", Draw_DirectSetEnvironment__Fiiiiiiiiii);

INCLUDE_ASM("asm/nonmatchings/main", Draw_SetEnvironment__Fiiiiiiii);

INCLUDE_ASM("asm/nonmatchings/main", Draw_InitRenderEngine__Fiiiiii);

void Draw_RestartRenderEngine__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Draw_DeInitRenderEngine__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Draw_InitLibRender__Fv);

void ChangeTPage__FPUsi(unsigned short *p, int i) {
    *p = (*p & 0xFF9F) | (i << 5);
}
void DrawC_SetEnviroment__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", DrawC_ReadLightingData__Fv);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_ReadeMapData__Fv);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_BuildRenderingData__Fv);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_KillRenderingData__Fv);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_NightHeadlight__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_MenuColorData__FiP8Car_tObji);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_PrimStart__FP12Draw_tVertexP8Car_tObjiP13Draw_CarCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_PrimStop__FP8Car_tObjP13Draw_CarCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_Prim__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_DividePrim__FP7COORD16N20PUsN23P12Draw_tPixMapP13Draw_CarCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_PrimClip__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_PrimMenu__FP10matrixtdefP8coorddefP16Transformer_zObjP20Transformer_zOverlayiP13Draw_CarCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_ShadowPrim__FP12Draw_tVertexP13Draw_CarCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_DivideShadowPrim__FP7COORD16N30PUsN34P12Draw_tPixMapP13Draw_CarCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_ShadowPrimClip__FP12Draw_tVertexP13Draw_CarCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_SpotPrims__FP10matrixtdefP8coorddefP13Draw_CarCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawC_ShowroomPrims__FP10matrixtdefP8coorddefP13Draw_CarCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_AddSubdividPrimGT4__FP8POLY_GT4P12Draw_SVertexN31P25Draw_tGiveShelbyMoreCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_AddSubdividPrimGT3__FP8POLY_GT3P12Draw_SVertexN21P25Draw_tGiveShelbyMoreCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_DivVertice__FP12Draw_SVertexN20);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_CalcSubdivision__FP25Draw_tGiveShelbyMoreCacheP12Draw_SVertexN31);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_SubdividFacet__FP25Draw_tGiveShelbyMoreCacheiP12Draw_SVertexN32ss);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_LoadPrecVECTOR__FP12Draw_SVertexP6VECTOR);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_SetUpSubdividFacet__FiP25Draw_tGiveShelbyMoreCache);

INCLUDE_ASM("asm/nonmatchings/main", Night_NightCopCalc__FP6VECTORPs);

INCLUDE_ASM("asm/nonmatchings/main", Night_NightCalc__FP6VECTORPsP25Draw_tGiveShelbyMoreCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_NightColorCalc__FP25Draw_tGiveShelbyMoreCacheP8POLY_GT4P8CCOORD16N32);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_DrawQuad__FP25Draw_tGiveShelbyMoreCacheP8Trk_Quad);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_DoTrough__FP13DRender_tViewP11tBuildEntry);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_WorldSetUpMatrix__FP10matrixtdefP6MATRIX);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_WorldSetUpTranslation__FP8coorddefP6MATRIX);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_ResetAnimationTimer__Fv);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_GetAnimationTime__FP15Trk_AnimateInst);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_SetAnimationTime__FP15Trk_AnimateInstPii);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_DoObjectAnimations__Fv);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_BuildObjectFacets__FP13DRender_tViewP15ChunkObjectInfo);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi);

INCLUDE_ASM("asm/nonmatchings/main", DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis);

INCLUDE_ASM("asm/nonmatchings/main", DrawObjectSimple__FP13DRender_tViewP11Draw_DCacheP13Trk_ObjectDefP8coorddefi);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_BuildChunkObjectFacets__FP13DRender_tViewP15ChunkObjectInfo);

INCLUDE_ASM("asm/nonmatchings/main", ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_DoObjects__FP13DRender_tViewP11tBuildEntry);

INCLUDE_ASM("asm/nonmatchings/main", Draw_CircleClip__FP8coorddefT0i);

INCLUDE_ASM("asm/nonmatchings/main", Draw_kCtrlSkidmark__FP18Draw_tCtrlSkidmark);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_SetUpSubdividFacet_Line__FP25Draw_tGiveShelbyMoreCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_BuildChunkCenterLineFacets__FP5ChunkP5GroupP25Draw_tGiveShelbyMoreCacheP7COORD16);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_DoLines__FP13DRender_tViewP11tBuildEntryP11Draw_DCache);

INCLUDE_ASM("asm/nonmatchings/main", DrawW_BuildSpikeBelt__FP13DRender_tViewiP11Draw_DCache);

INCLUDE_ASM("asm/nonmatchings/main", DepthCue_Init__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Force_Vbl__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Force_Update__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Force_StartUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Force_Disable__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Force_IsForceOn__FP8Car_tObj);

INCLUDE_ASM("asm/nonmatchings/main", Force_Pause__Fv);

void Force_UnPause__Fv(void) {
}

void Force_HitSign__FP8Car_tObj(void) {
}

void Force_HitWall__Fi(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Font_TextColor__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Font_TextTint__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Font_SetABR__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Font_Blit__FiiPviiP12charactertbli);

INCLUDE_ASM("asm/nonmatchings/main", Font_ComputeColors__Fiiic);

INCLUDE_ASM("asm/nonmatchings/main", func_800CB6A0);

INCLUDE_ASM("asm/nonmatchings/main", Font_Getcharacter__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Font_SetBlitter__FPFiiPviiP12charactertbli_v);

INCLUDE_ASM("asm/nonmatchings/main", Font_ReSetBlitter__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Font_SwitchFont__FPc);

INCLUDE_ASM("asm/nonmatchings/main", Font_DeInit__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Font_ExitFromGame__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Font_LoadFont__FPciic);

INCLUDE_ASM("asm/nonmatchings/main", Font_TextXY__FPcii);

INCLUDE_ASM("asm/nonmatchings/main", Font_GetUVWH__FcPiN41);

INCLUDE_ASM("asm/nonmatchings/main", Flare_Tri__FPlN20i);

INCLUDE_ASM("asm/nonmatchings/main", Flare_SetMatrix__FP10matrixtdef);

void Flare_IdentMatrix__FP6MATRIX(int *m) {
    m[0] = 0x1000;
    m[1] = 0;
    m[2] = 0x1000;
    m[3] = 0;
    m[4] = 0x1000;
}
INCLUDE_ASM("asm/nonmatchings/main", Flare_OctFlare__FPli);

INCLUDE_ASM("asm/nonmatchings/main", Flare_OctFlareSpikes__FPli);

INCLUDE_ASM("asm/nonmatchings/main", Flare_Spikes__FPli);

INCLUDE_ASM("asm/nonmatchings/main", Flare_HexFlare__FPli);

INCLUDE_ASM("asm/nonmatchings/main", Flare_ReflectHexFlare__FPli);

INCLUDE_ASM("asm/nonmatchings/main", Flare_QuadFlare__FPli);

INCLUDE_ASM("asm/nonmatchings/main", Flare_CarShapedHalo__FiP7COORD16N21siP15Draw_FlareCache);

INCLUDE_ASM("asm/nonmatchings/main", Flare_Halo2__FP13DRender_tViewiiP8coorddefT3P15Draw_FlareCache);

INCLUDE_ASM("asm/nonmatchings/main", Flare_Halo__FP13DRender_tViewiiP8coorddefP15Draw_FlareCache);

INCLUDE_ASM("asm/nonmatchings/main", Flare_2DSpike__FPlT0i);

INCLUDE_ASM("asm/nonmatchings/main", Flare_2DHalo__Fiiiii);

INCLUDE_ASM("asm/nonmatchings/main", Flare_PreCalcHexLightBeam__FPli);

INCLUDE_ASM("asm/nonmatchings/main", Flare_Quad__FPlP7CVECTORi);

INCLUDE_ASM("asm/nonmatchings/main", Flare_QuadNotTransparent__FPlP7CVECTORi);

INCLUDE_ASM("asm/nonmatchings/main", Flare_QuadRing__FPlP7CVECTORi);

INCLUDE_ASM("asm/nonmatchings/main", Flare_TextureQuad__FPlP7CVECTORci);

INCLUDE_ASM("asm/nonmatchings/main", Flare_SingleColorTex__FP7DVECTORP7CVECTORiici);

INCLUDE_ASM("asm/nonmatchings/main", Flare_SingleColorHex__FP7DVECTORP7CVECTORiii);

INCLUDE_ASM("asm/nonmatchings/main", Flare_SingleColorOct__FP7DVECTORP7CVECTORiii);

INCLUDE_ASM("asm/nonmatchings/main", Flare_SingleColorOctRing__FP7DVECTORP7CVECTORiii);

INCLUDE_ASM("asm/nonmatchings/main", Flare_InitLensFlare__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Flare_LensFlare__FP7DVECTORP15Draw_FlareCache);

INCLUDE_ASM("asm/nonmatchings/main", Flare_Sun__FP7SVECTORP15Draw_FlareCache);

INCLUDE_ASM("asm/nonmatchings/main", Flare_Moon__FP7SVECTORP15Draw_FlareCache);

INCLUDE_ASM("asm/nonmatchings/main", Horizon_InterpolateLineSCoords__FP7DVECTORN20Piii);

INCLUDE_ASM("asm/nonmatchings/main", Sky_InitStars__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Sky_KillStars__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_InitSkyColor__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_InitSky__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_Init2DRing__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_GetHorizonPixMap__FP12Draw_tPixMap);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_InitHorizon__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_KillHorizon__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_LightningAddFork__FScScSc);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_CalculateLightning__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_TextureQuad__FP7DVECTORccP11Draw_DCache);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_SetLightingPosInSky__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_BuildForkLightning__FP11Draw_DCache);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_LightningFlicker__Fi);

INCLUDE_ASM("asm/nonmatchings/main", HrzSetPsxMatrix__FP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", HrzSetPsxTranslation__FP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_RotProj16__FiP7SVECTORPiP7DVECTOR);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_SetDitheringPrim__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_BuildSky__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Sky_RenderStars__FP13Draw_SkyCachei);

INCLUDE_ASM("asm/nonmatchings/main", Hrz_BuildHorizon__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", Hud_CreateHudViews__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_GoTpage__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_DebugInfo__Fv);

void Hud_DebugCrap__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildSprite__FP4SPRTiiiUli);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildSprite2__FP4SPRTiii);

INCLUDE_ASM("asm/nonmatchings/main", Hud_FBuildSprite__FiiiUli);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildSpriteFromFont__FP4SPRTcii);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildF3__FP7POLY_F3P13HudPmx_tShapeiiUl);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildGT4__FP8POLY_GT4P13HudPmx_tShapeiiUl);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildMapMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildF4__FP7POLY_F4iiiiiUl);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildG4__FP7POLY_G4iiiiiUlUlUlUl);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildF4o__FP7POLY_F4iiiiiUlScSc);

INCLUDE_ASM("asm/nonmatchings/main", Hud_FBuildGT4__FP13HudPmx_tShapeiiUl);

INCLUDE_ASM("asm/nonmatchings/main", Hud_FBuildFT4__FP13HudPmx_tShapeiiUl);

INCLUDE_ASM("asm/nonmatchings/main", Hud_FBuildF4__FiiiiiUlcc);

INCLUDE_ASM("asm/nonmatchings/main", func_800D2A44);

INCLUDE_ASM("asm/nonmatchings/main", Hud_Kill__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_Init0__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_InitMapFrame__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildTimeSprites__FP4SPRTPcii);

INCLUDE_ASM("asm/nonmatchings/main", Hud_Init__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_InitTables__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildETimeString__FP4SPRTi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildDistanceString__FP4SPRTi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildTimeString__FP4SPRTi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildTach__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildString__FPciiiib);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildNumbers0__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildNumbers__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_InitMap__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildMapMarkers__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_WingmanFlash__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildWingmanInterface__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_InitCdPlayer__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildCdPlayer__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildRadar__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BuildReplay__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_NextPlayer__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_NextPlayerNameOrCarOrTime__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_RenderMapView__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BlackThinBox__Fiiii);

INCLUDE_ASM("asm/nonmatchings/main", Hud_Draw321Num__Fiiiiii);

INCLUDE_ASM("asm/nonmatchings/main", Hud_Render321Go__Fv);

INCLUDE_ASM("asm/nonmatchings/main", BigBTCTime__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Hud_RenderHudView__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_RenderTacView__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_ParseTime__FiPc);

INCLUDE_ASM("asm/nonmatchings/main", Hud_RenderPauseBox__Fiiii);

INCLUDE_ASM("asm/nonmatchings/main", Hud_Render__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_PositionMap__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BTC_Update__FPcib);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BustedOverlayOn__FiPcbs);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BustedOverlayOff__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_Reset__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BTC_QuitOut__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BTC_BonusTime__Fl);

INCLUDE_ASM("asm/nonmatchings/main", Hud_Perp_OverlayOn__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Hud_Perp_OverlayOff__Fi);

INCLUDE_ASM("asm/nonmatchings/main", OptionsBarThing__Fiiii);

INCLUDE_ASM("asm/nonmatchings/main", RaceSummary__Fv);

INCLUDE_ASM("asm/nonmatchings/main", RaceStatistics__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Hud_BTCStats__Fsb);

INCLUDE_ASM("asm/nonmatchings/main", Hud_RenderStatsView__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Loading_DrawLoadingScreen__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Loading_UpdateLoadingScreen__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Loading_GetInitialMemory__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Night_FindClosestColor__FG7CVECTORPi);

INCLUDE_ASM("asm/nonmatchings/main", Night_CreateNightTableElement__FiliPUc);

INCLUDE_ASM("asm/nonmatchings/main", Night_CreateNightTable__FiliPA256_A16_Uc);

INCLUDE_ASM("asm/nonmatchings/main", Night_GenerateNextLightningEvent__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Night_PauseLightningEffect__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Night_DoLightningEffect__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", Night_SetCopColor__FP18GameSetup_tCarData);

INCLUDE_ASM("asm/nonmatchings/main", Night_InitPlayerHeadLightColor__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Night_SetPlayerHeadLightColor__Fiii);

INCLUDE_ASM("asm/nonmatchings/main", Night_InitCopLightColors__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Night_SetCopLightColors__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Night_InitWeatherTables__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Night_SetWeatherColors__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Night_GenerateAllLightTables__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Night_InitNightDriving__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Night_KillNightDriving__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Night_RestartNightDriving__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Night_SetEnviroment__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", Night_AdditiveNightCalc__FP6VECTORP7CVECTOR);

INCLUDE_ASM("asm/nonmatchings/main", Platform_InitMemory__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Platform_ReserveMemory__FiPc);

INCLUDE_ASM("asm/nonmatchings/main", Platform_TempReserveMemory__FiPc);

INCLUDE_ASM("asm/nonmatchings/main", Platform_SysStartUp__Fv);

void Platform_DebuggerPollHost__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", nfs2eacinit__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Platform_ResetDCTBuffer__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Platform_GetDCTBuffer__FiPc);

INCLUDE_ASM("asm/nonmatchings/main", InGame_ResetPSXController__Fii);

INCLUDE_ASM("asm/nonmatchings/main", InGame_GetPSXPadValue__Fii);

int InGame_GetDevice__Fi(int x) { return x & 0xFF; }
INCLUDE_ASM("asm/nonmatchings/main", InGame_SetRamp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", RPause_CopyBackToFrontBuffer__Fv);

INCLUDE_ASM("asm/nonmatchings/main", RPause_StartPauseMenu__Fv);

INCLUDE_ASM("asm/nonmatchings/main", RPause_StopPauseMenu__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Sfx_Transform__FP8coorddefP7SVECTORT0);

INCLUDE_ASM("asm/nonmatchings/main", Sfx_BuildSmokeFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMap);

INCLUDE_ASM("asm/nonmatchings/main", Sfx_ThickenXZ__FP7SVECTORP8coorddefN21);

INCLUDE_ASM("asm/nonmatchings/main", Sfx_BuildFastDisolveFacet__FP17Souffle_tISouffleP10sfxsouffleP12Draw_tPixMapT2);

INCLUDE_ASM("asm/nonmatchings/main", Sfx_AdditivePrim__FP12Draw_tPixMapP7SVECTORiiP10Sfx_tCache);

INCLUDE_ASM("asm/nonmatchings/main", Sfx_BuildSouffleFacet__FP13DRender_tViewP17Souffle_tISouffle);

INCLUDE_ASM("asm/nonmatchings/main", Sfx_Add__FP17Souffle_tISouffle);

INCLUDE_ASM("asm/nonmatchings/main", CalcStartSegment__FP16Skidmark_SegmentT0P8coorddefN22i);

INCLUDE_ASM("asm/nonmatchings/main", CalcOneSegment__FP16Skidmark_SegmentP8coorddefN21i);

INCLUDE_ASM("asm/nonmatchings/main", Skidmark_CheckChunk__FP8coorddefii);

INCLUDE_ASM("asm/nonmatchings/main", Skidmark_Add__FP5tSkidP8coorddefP7CVECTORiii);

INCLUDE_ASM("asm/nonmatchings/main", Skidmark_AddStretch__FPP16Skidmark_SegmentPiP5tSkidP8coorddefP7CVECTORiii);

INCLUDE_ASM("asm/nonmatchings/main", Skidmark_Stretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii);

INCLUDE_ASM("asm/nonmatchings/main", Skidmark_EndStretch__FP16Skidmark_SegmentiP5tSkidP8coorddefP7CVECTORii);

INCLUDE_ASM("asm/nonmatchings/main", Skidmark_OnyxBuildFacets__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", Skidmark_InitSkidmark__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Skidmark_RestartSkidmark__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Skidmark_KillSkidmark__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Texture_InitPaletteSharing__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Texture_DeInitPaletteSharing__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Texture_ResetPaletteSharing__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Texture_CheckForSharedPalette__FiPcP12Draw_tPixMapi);

INCLUDE_ASM("asm/nonmatchings/main", Texture_AddSharedPalette__FPcP12Draw_tPixMapi);

INCLUDE_ASM("asm/nonmatchings/main", Texture_InitClut__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Texture_GetClutId__FiPiT1);

INCLUDE_ASM("asm/nonmatchings/main", Texture_MenuReleaseClutId__Fs);

INCLUDE_ASM("asm/nonmatchings/main", Texture_ColorCarPalette__FPcT0i);

INCLUDE_ASM("asm/nonmatchings/main", Texture_CopyPalette__FPciii);

INCLUDE_ASM("asm/nonmatchings/main", Texture_ProcessPaletteCopy__FP15Texture_pal8bitii);

INCLUDE_ASM("asm/nonmatchings/main", Texture_LoadImage__FP4RECTPUl);

INCLUDE_ASM("asm/nonmatchings/main", Texture_Vramf__FP8shapetbliiii);

INCLUDE_ASM("asm/nonmatchings/main", Texture_Vramcf__FP8shapetbliiii);

INCLUDE_ASM("asm/nonmatchings/main", Texture_GetTranslucencyMode__FP8shapetbl);

INCLUDE_ASM("asm/nonmatchings/main", Texture_LoadPmx__FPcT0iiiiiP12Draw_tPixMap);

INCLUDE_ASM("asm/nonmatchings/main", Texture_CloneUVPmx__FP12Draw_tPixMapiT0);

INCLUDE_ASM("asm/nonmatchings/main", Texture_InitTrackTexture__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Texture_InitMenuClut__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Texture_InitMenuTexture__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Texture_CleanupMenuTexture__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Texture_LoadMenuTexture__Fv);

void Texture_KillTrackTexture__Fv(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", Texture_KillMenuTexture__Fv);

INCLUDE_ASM("asm/nonmatchings/main", TextureProcess_TransColorCheck__FPci);

INCLUDE_ASM("asm/nonmatchings/main", TextureProcess_ColorClut__FiiPciii);

INCLUDE_ASM("asm/nonmatchings/main", TextureProcess_DepthColorCluts__FPci);

INCLUDE_ASM("asm/nonmatchings/main", Fog_CheckRange__FiP6FogKey);

INCLUDE_ASM("asm/nonmatchings/main", Fog_FindKey__FiP6FogKey);

INCLUDE_ASM("asm/nonmatchings/main", Fog_AllocKey__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Fog_AddKey__Fii);

INCLUDE_ASM("asm/nonmatchings/main", Fog_Update__Fi);

INCLUDE_ASM("asm/nonmatchings/main", Fog_MakeTrackPathName__FPc);

INCLUDE_ASM("asm/nonmatchings/main", Fog_ReadFogKeys__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Fog_InitFogTriggers__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Fog_DeInitFogTriggers__Fv);

INCLUDE_ASM("asm/nonmatchings/main", TextureProcess_Init__Fv);

INCLUDE_ASM("asm/nonmatchings/main", CV_ProcessWorldColors_FINAL__FiP7CVECTORs);

INCLUDE_ASM("asm/nonmatchings/main", CV_ColorTracks__Fiii);

INCLUDE_ASM("asm/nonmatchings/main", CV_InitColorVertices__Fv);

INCLUDE_ASM("asm/nonmatchings/main", TrackSpec_SetDefault__FP10CTrackSpec);

INCLUDE_ASM("asm/nonmatchings/main", TrackSpec_SetUp__Fv);

INCLUDE_ASM("asm/nonmatchings/main", read__FPPcPvi);

INCLUDE_ASM("asm/nonmatchings/main", TrackSpec_Read__Fi);

INCLUDE_ASM("asm/nonmatchings/main", TrackSpec_Load__Fii);

INCLUDE_ASM("asm/nonmatchings/main", TrsProj_SetTransPrecision__Fi);

INCLUDE_ASM("asm/nonmatchings/main", TrsProj_ResetTransPrecision__Fv);

INCLUDE_ASM("asm/nonmatchings/main", TrsProj_SetProjection__Fiiii);

INCLUDE_ASM("asm/nonmatchings/main", TrsProj_SetMenuProjection__Fiiii);

INCLUDE_ASM("asm/nonmatchings/main", TrsProj_SetViewTrsProjEnviro__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", TrsProj_SetPsxMatrix__FP10matrixtdefP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", TrsProj_SetPsxTrans__FP8coorddef);

INCLUDE_ASM("asm/nonmatchings/main", TrsProj_SetPsxTransZero__Fv);

INCLUDE_ASM("asm/nonmatchings/main", TrsProj_TransPt__FP8coorddefT0);

INCLUDE_ASM("asm/nonmatchings/main", TrsProj_TransPtN16__FP10RelCoord16P8coorddefi);

INCLUDE_ASM("asm/nonmatchings/main", TrsProj_TransformProjectVertex__FP10matrixtdefP8coorddefiT1P12Draw_tVertex);

int Weather_GetNumParticles__Fi(int player) {
    return *(int *)0x80123408;
}
INCLUDE_ASM("asm/nonmatchings/main", Weather_SetMatrix__FP10matrixtdef);

INCLUDE_ASM("asm/nonmatchings/main", Weather_SetIdentMatrix__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_InitSnow__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_InitRain__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_InitSplats__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_GetNewState__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_ChangeDensityState__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_ChangeIntensityState__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_ChangeDensityBasedOnTime__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_ChangeIntensityBasedOnTime__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_InitStateControls__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_Restart__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_Init__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_DeInit__Fv);

INCLUDE_ASM("asm/nonmatchings/main", Weather_TransformVertex__FP10matrixtdefiP7SVECTOR);

INCLUDE_ASM("asm/nonmatchings/main", Weather_CheckAndResetParticles__FP7SVECTOR);

INCLUDE_ASM("asm/nonmatchings/main", Weather_QuickReOrthogonalize__FP10matrixtdefT0);

INCLUDE_ASM("asm/nonmatchings/main", Weather_ProcessParticles__FP13DRender_tViewiP7SVECTORPc);

INCLUDE_ASM("asm/nonmatchings/main", Weather_CreateSnow__FP7SVECTOR);

INCLUDE_ASM("asm/nonmatchings/main", Weather_CreateRain__FP7SVECTORP7DVECTORPc);

INCLUDE_ASM("asm/nonmatchings/main", Weather_CreateSplat__FP18Weather_tSplatInfo);

INCLUDE_ASM("asm/nonmatchings/main", Weather_DoSplats__FiP18Weather_tSplatInfo);

INCLUDE_ASM("asm/nonmatchings/main", Weather_DoWeather__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", Weather_BuildWeather__FP13DRender_tView);

INCLUDE_ASM("asm/nonmatchings/main", textnpixels);

INCLUDE_ASM("asm/nonmatchings/main", textpixels);

void fortext4(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", inittextdraw);

INCLUDE_ASM("asm/nonmatchings/main", restoretextdraw);

INCLUDE_ASM("asm/nonmatchings/main", unpackz);

INCLUDE_ASM("asm/nonmatchings/main", unpack);

INCLUDE_ASM("asm/nonmatchings/main", unpacksizez);

INCLUDE_ASM("asm/nonmatchings/main", unpacksize);

void __main(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", __SN_ENTRY_POINT);

INCLUDE_ASM("asm/nonmatchings/main", stup1);

INCLUDE_ASM("asm/nonmatchings/main", stup0);

INCLUDE_ASM("asm/nonmatchings/main", padinit);

INCLUDE_ASM("asm/nonmatchings/main", PAD_restore);

INCLUDE_ASM("asm/nonmatchings/main", PAD_state);

INCLUDE_ASM("asm/nonmatchings/main", func_800E41FC);

INCLUDE_ASM("asm/nonmatchings/main", PAD_update);

INCLUDE_ASM("asm/nonmatchings/main", memset);

INCLUDE_ASM("asm/nonmatchings/main", fixedmult);

INCLUDE_ASM("asm/nonmatchings/main", __pure_virtual);

INCLUDE_ASM("asm/nonmatchings/main", transpose);

INCLUDE_ASM("asm/nonmatchings/main", rdiv);

INCLUDE_ASM("asm/nonmatchings/main", SetSp);

INCLUDE_ASM("asm/nonmatchings/main", sprintf);

INCLUDE_ASM("asm/nonmatchings/main", FREE_find);

INCLUDE_ASM("asm/nonmatchings/main", FREE_findlargest);

INCLUDE_ASM("asm/nonmatchings/main", FREE_add);

void FREE_remove(int unused, char *node) {
    char *next;
    char *prev;
    unsigned short flags;
    next  = *(char **)(node + 0x14);
    prev  = *(char **)(node + 0x10);
    *(char **)(next + 0x10) = prev;
    *(char **)(prev + 0x14) = next;
    flags = *(unsigned short *)(node + 2);
    *(unsigned short *)(node + 0) = 0;
    *(unsigned short *)(node + 2) = flags & 0xBFFF;
}
INCLUDE_ASM("asm/nonmatchings/main", initmemblock);

INCLUDE_ASM("asm/nonmatchings/main", MEM_infosize);

INCLUDE_ASM("asm/nonmatchings/main", MEM_tailsize);

INCLUDE_ASM("asm/nonmatchings/main", creatememclass);

INCLUDE_ASM("asm/nonmatchings/main", largestunused);

INCLUDE_ASM("asm/nonmatchings/main", getblocksize);

INCLUDE_ASM("asm/nonmatchings/main", getblockname);

INCLUDE_ASM("asm/nonmatchings/main", reservememadr);

INCLUDE_ASM("asm/nonmatchings/main", purgememadr);

INCLUDE_ASM("asm/nonmatchings/main", filesizeatomic);

INCLUDE_ASM("asm/nonmatchings/main", filesize);

INCLUDE_ASM("asm/nonmatchings/main", func_800E56B0);

INCLUDE_ASM("asm/nonmatchings/main", loadfileadrz);

INCLUDE_ASM("asm/nonmatchings/main", loadfileadr);

INCLUDE_ASM("asm/nonmatchings/main", func_800E5830);

INCLUDE_ASM("asm/nonmatchings/main", loadfileatadrz);

INCLUDE_ASM("asm/nonmatchings/main", loadfileatadr);

INCLUDE_ASM("asm/nonmatchings/main", func_800E5938);

INCLUDE_ASM("asm/nonmatchings/main", loadbigfileheader);

INCLUDE_ASM("asm/nonmatchings/main", xformy);

INCLUDE_ASM("asm/nonmatchings/main", strcpy);

INCLUDE_ASM("asm/nonmatchings/main", intatan);

INCLUDE_ASM("asm/nonmatchings/main", loadpackadrz);

INCLUDE_ASM("asm/nonmatchings/main", loadpackadr);

INCLUDE_ASM("asm/nonmatchings/main", strcmp);

INCLUDE_ASM("asm/nonmatchings/main", qsort);

INCLUDE_ASM("asm/nonmatchings/main", func_800E5EDC);

INCLUDE_ASM("asm/nonmatchings/main", typeofbigfile);

INCLUDE_ASM("asm/nonmatchings/main", sizeofbigfileheader);

INCLUDE_ASM("asm/nonmatchings/main", locatebigentryz);

INCLUDE_ASM("asm/nonmatchings/main", locatebigentry);

INCLUDE_ASM("asm/nonmatchings/main", locatebigoffset);

INCLUDE_ASM("asm/nonmatchings/main", locatebig);

INCLUDE_ASM("asm/nonmatchings/main", bigcount);

INCLUDE_ASM("asm/nonmatchings/main", strstr);

INCLUDE_ASM("asm/nonmatchings/main", blockmove);

INCLUDE_ASM("asm/nonmatchings/main", iSNDremovepatches);

INCLUDE_ASM("asm/nonmatchings/main", SNDbankremove);

INCLUDE_ASM("asm/nonmatchings/main", cSNDbankremove);

INCLUDE_ASM("asm/nonmatchings/main", SNDplaysetdef);

INCLUDE_ASM("asm/nonmatchings/main", SNDpan);

INCLUDE_ASM("asm/nonmatchings/main", iSNDunsafevol);

INCLUDE_ASM("asm/nonmatchings/main", SNDvol);

INCLUDE_ASM("asm/nonmatchings/main", addsystemtask);

INCLUDE_ASM("asm/nonmatchings/main", delsystemtask);

INCLUDE_ASM("asm/nonmatchings/main", systemtask);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_setpriority);

INCLUDE_ASM("asm/nonmatchings/main", SNDfxinitbus);

INCLUDE_ASM("asm/nonmatchings/main", SNDfxmasterlevel);

INCLUDE_ASM("asm/nonmatchings/main", func_800E6E88);

INCLUDE_ASM("asm/nonmatchings/main", func_800E6E94);

INCLUDE_ASM("asm/nonmatchings/main", func_800E6EA8);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SearchEventDat);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_FindEvent);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_InitEventDat);

INCLUDE_ASM("asm/nonmatchings/main", GetFilterLength);

INCLUDE_ASM("asm/nonmatchings/main", GetFilterPriority);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_InitEventQueue);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_FindEventSlot);

INCLUDE_ASM("asm/nonmatchings/main", SPCH_AddEvent);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ChooseEvent);

INCLUDE_ASM("asm/nonmatchings/main", SPCH_ClearEventQueue);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ClearOldEvents);

INCLUDE_ASM("asm/nonmatchings/main", SPCH_PlaySpeech);

INCLUDE_ASM("asm/nonmatchings/main", SPCH_ChooseSpeech);

INCLUDE_ASM("asm/nonmatchings/main", random);

INCLUDE_ASM("asm/nonmatchings/main", seedrandom);

INCLUDE_ASM("asm/nonmatchings/main", strcat);

INCLUDE_ASM("asm/nonmatchings/main", iSNDunsafebend);

INCLUDE_ASM("asm/nonmatchings/main", SNDpitchbend);

INCLUDE_ASM("asm/nonmatchings/main", SNDplay);

INCLUDE_ASM("asm/nonmatchings/main", cSNDplay);

INCLUDE_ASM("asm/nonmatchings/main", SNDover);

INCLUDE_ASM("asm/nonmatchings/main", SNDbankheadersize);

INCLUDE_ASM("asm/nonmatchings/main", SNDbankheadercopy);

INCLUDE_ASM("asm/nonmatchings/main", SNDmemlargestunused);

INCLUDE_ASM("asm/nonmatchings/main", SNDbankadd);

INCLUDE_ASM("asm/nonmatchings/main", SNDstop);

INCLUDE_ASM("asm/nonmatchings/main", SNDpitchmult);

INCLUDE_ASM("asm/nonmatchings/main", SNDmastervol);

INCLUDE_ASM("asm/nonmatchings/main", func_800E80C4);

INCLUDE_ASM("asm/nonmatchings/main", puts);

INCLUDE_ASM("asm/nonmatchings/main", SND3dpos);

INCLUDE_ASM("asm/nonmatchings/main", SNDstopall);

int gettick(void) {
    return ticks;
}
INCLUDE_ASM("asm/nonmatchings/main", elapsedticks);

INCLUDE_ASM("asm/nonmatchings/main", resettick);

INCLUDE_ASM("asm/nonmatchings/main", timedwait);

INCLUDE_ASM("asm/nonmatchings/main", SNDautovol);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_getvol);

INCLUDE_ASM("asm/nonmatchings/main", CdDiskReady);

INCLUDE_ASM("asm/nonmatchings/main", CdGetDiskType);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_status);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_requeststatus);

INCLUDE_ASM("asm/nonmatchings/main", func_800E8940);

INCLUDE_ASM("asm/nonmatchings/main", wildcard);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamdestroyall);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamgetstreamptr);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamremoverequest);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamreleasecallback);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamnotifycallback);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamparseheader);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamparsenumchunks);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamparsedata);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamparseend);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamparsechunk);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamisheld);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamhotroddatachunks);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamservice);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamnumcreated);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamcreate);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamqueue);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_create);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_destroy);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_queuefile);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_purge);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_setgreedylevel);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_setgreedystate);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_autovol);

INCLUDE_ASM("asm/nonmatchings/main", SetRCnt);

INCLUDE_ASM("asm/nonmatchings/main", GetRCnt);

INCLUDE_ASM("asm/nonmatchings/main", StartRCnt);

INCLUDE_ASM("asm/nonmatchings/main", strlen);

INCLUDE_ASM("asm/nonmatchings/main", SNDgetlimits);

INCLUDE_ASM("asm/nonmatchings/main", SNDsetlimits);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_overheadtap);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_overhead);

INCLUDE_ASM("asm/nonmatchings/main", SNDSTRM_vol);

INCLUDE_ASM("asm/nonmatchings/main", iSNDserver);

INCLUDE_ASM("asm/nonmatchings/main", iSND100hzserver);

INCLUDE_ASM("asm/nonmatchings/main", iSNDenteraudio);

INCLUDE_ASM("asm/nonmatchings/main", iSNDleaveaudio);

INCLUDE_ASM("asm/nonmatchings/main", iSNDserveradd100hzclient);

INCLUDE_ASM("asm/nonmatchings/main", iSNDserverremove100hzclient);

INCLUDE_ASM("asm/nonmatchings/main", func_800EA6CC);

INCLUDE_ASM("asm/nonmatchings/main", func_800EA7E8);

INCLUDE_ASM("asm/nonmatchings/main", FILE_opensync);

INCLUDE_ASM("asm/nonmatchings/main", FILE_readsync);

INCLUDE_ASM("asm/nonmatchings/main", FILE_closesync);

INCLUDE_ASM("asm/nonmatchings/main", FILE_sizesync);

INCLUDE_ASM("asm/nonmatchings/main", FILE_addbigsync);

INCLUDE_ASM("asm/nonmatchings/main", FILE_delbigsync);

INCLUDE_ASM("asm/nonmatchings/main", memcpy);

INCLUDE_ASM("asm/nonmatchings/main", rand);

INCLUDE_ASM("asm/nonmatchings/main", crossproduct);

INCLUDE_ASM("asm/nonmatchings/main", SetGeomScreen);

INCLUDE_ASM("asm/nonmatchings/main", fixedxformx);

INCLUDE_ASM("asm/nonmatchings/main", fixedxformy);

INCLUDE_ASM("asm/nonmatchings/main", fixedxformz);

INCLUDE_ASM("asm/nonmatchings/main", intarcsin);

INCLUDE_ASM("asm/nonmatchings/main", intarccos);

INCLUDE_ASM("asm/nonmatchings/main", intsincos);

INCLUDE_ASM("asm/nonmatchings/main", transform);

INCLUDE_ASM("asm/nonmatchings/main", addtimer);

INCLUDE_ASM("asm/nonmatchings/main", deltimer);

INCLUDE_ASM("asm/nonmatchings/main", initgp);

INCLUDE_ASM("asm/nonmatchings/main", savegp);

INCLUDE_ASM("asm/nonmatchings/main", restoregp);

INCLUDE_ASM("asm/nonmatchings/main", fixedsqrt);

INCLUDE_ASM("asm/nonmatchings/main", atoi);

INCLUDE_ASM("asm/nonmatchings/main", locateshape);

INCLUDE_ASM("asm/nonmatchings/main", locateshapez);

INCLUDE_ASM("asm/nonmatchings/main", strncmp);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_InitBanks);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_DisposeBanks);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_BankMemAlloc);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_GetFreeBank);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_FindBank);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_TestSubBankBounds);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SetCycleBits);

INCLUDE_ASM("asm/nonmatchings/main", SPCH_AddBank);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_MemAlloc);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_MemFree);

INCLUDE_ASM("asm/nonmatchings/main", SPCH_Deinit);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_InitInGame);

INCLUDE_ASM("asm/nonmatchings/main", SPCH_GetSampleDataRate);

INCLUDE_ASM("asm/nonmatchings/main", SPCH_InitBankMem);

INCLUDE_ASM("asm/nonmatchings/main", SPCH_Init);

INCLUDE_ASM("asm/nonmatchings/main", __floatsidf);

INCLUDE_ASM("asm/nonmatchings/main", __ltdf2);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_EACrandom);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_EACseedrandom);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_Rand);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_BindData);

INCLUDE_ASM("asm/nonmatchings/main", SPCH_ResolveData);

INCLUDE_ASM("asm/nonmatchings/main", FILE_init);

INCLUDE_ASM("asm/nonmatchings/main", FILE_initwithmem);

INCLUDE_ASM("asm/nonmatchings/main", FILE_overhead);

INCLUDE_ASM("asm/nonmatchings/main", FILE_opstatus);

INCLUDE_ASM("asm/nonmatchings/main", FILE_operror);

INCLUDE_ASM("asm/nonmatchings/main", FILE_callbackop);

INCLUDE_ASM("asm/nonmatchings/main", FILE_priorityop);

INCLUDE_ASM("asm/nonmatchings/main", FILE_cancelop);

INCLUDE_ASM("asm/nonmatchings/main", FILE_waitop);

INCLUDE_ASM("asm/nonmatchings/main", FILE_completeop);

INCLUDE_ASM("asm/nonmatchings/main", FILE_open);

INCLUDE_ASM("asm/nonmatchings/main", FILE_close);

INCLUDE_ASM("asm/nonmatchings/main", FILE_read);

INCLUDE_ASM("asm/nonmatchings/main", FILE_size);

INCLUDE_ASM("asm/nonmatchings/main", iFILE_addbigreadcallback);

INCLUDE_ASM("asm/nonmatchings/main", iFILE_addbigopencallback);

INCLUDE_ASM("asm/nonmatchings/main", FILE_addbig);

INCLUDE_ASM("asm/nonmatchings/main", iFILE_delbigclosecallback);

INCLUDE_ASM("asm/nonmatchings/main", FILE_delbig);

INCLUDE_ASM("asm/nonmatchings/main", FILE_atomic);

INCLUDE_ASM("asm/nonmatchings/main", func_800ECB98);

INCLUDE_ASM("asm/nonmatchings/main", iFILE_CommandCompleteCallback);

void func_800ED0D4(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", func_800ED0DC);

INCLUDE_ASM("asm/nonmatchings/main", func_800ED1F8);

INCLUDE_ASM("asm/nonmatchings/main", func_800ED240);

INCLUDE_ASM("asm/nonmatchings/main", func_800ED2F0);

INCLUDE_ASM("asm/nonmatchings/main", SNDtimeremaining);

INCLUDE_ASM("asm/nonmatchings/main", fixedinverse);

INCLUDE_ASM("asm/nonmatchings/main", fixedsin);

INCLUDE_ASM("asm/nonmatchings/main", fixedcos);

INCLUDE_ASM("asm/nonmatchings/main", fixedatan);

INCLUDE_ASM("asm/nonmatchings/main", ResetGraph);

INCLUDE_ASM("asm/nonmatchings/main", SetDispMask);

INCLUDE_ASM("asm/nonmatchings/main", DrawSync);

INCLUDE_ASM("asm/nonmatchings/main", func_800ED8E4);

INCLUDE_ASM("asm/nonmatchings/main", ClearImage);

INCLUDE_ASM("asm/nonmatchings/main", LoadImage);

INCLUDE_ASM("asm/nonmatchings/main", StoreImage);

INCLUDE_ASM("asm/nonmatchings/main", MoveImage);

INCLUDE_ASM("asm/nonmatchings/main", ClearOTagR);

INCLUDE_ASM("asm/nonmatchings/main", DrawOTag);

INCLUDE_ASM("asm/nonmatchings/main", PutDrawEnv);

INCLUDE_ASM("asm/nonmatchings/main", PutDispEnv);

INCLUDE_ASM("asm/nonmatchings/main", SetTexWindow);

INCLUDE_ASM("asm/nonmatchings/main", SetDrawArea);

INCLUDE_ASM("asm/nonmatchings/main", SetDrawStp);

INCLUDE_ASM("asm/nonmatchings/main", SetDrawMode);

INCLUDE_ASM("asm/nonmatchings/main", SetDrawEnv);

INCLUDE_ASM("asm/nonmatchings/main", func_800EE608);

INCLUDE_ASM("asm/nonmatchings/main", func_800EE878);

INCLUDE_ASM("asm/nonmatchings/main", func_800EE898);

INCLUDE_ASM("asm/nonmatchings/main", func_800EE930);

INCLUDE_ASM("asm/nonmatchings/main", func_800EE9C8);

INCLUDE_ASM("asm/nonmatchings/main", func_800EE9E4);

INCLUDE_ASM("asm/nonmatchings/main", func_800EEA64);

INCLUDE_ASM("asm/nonmatchings/main", func_800EEA7C);

INCLUDE_ASM("asm/nonmatchings/main", func_800EEB5C);

INCLUDE_ASM("asm/nonmatchings/main", func_800EED8C);

INCLUDE_ASM("asm/nonmatchings/main", func_800EEFC8);

INCLUDE_ASM("asm/nonmatchings/main", func_800EF248);

INCLUDE_ASM("asm/nonmatchings/main", func_800EF26C);

INCLUDE_ASM("asm/nonmatchings/main", func_800EF280);

INCLUDE_ASM("asm/nonmatchings/main", func_800EF2C0);

INCLUDE_ASM("asm/nonmatchings/main", func_800EF308);

INCLUDE_ASM("asm/nonmatchings/main", func_800EF338);

INCLUDE_ASM("asm/nonmatchings/main", func_800EF35C);

INCLUDE_ASM("asm/nonmatchings/main", func_800EF60C);

INCLUDE_ASM("asm/nonmatchings/main", func_800EF86C);

INCLUDE_ASM("asm/nonmatchings/main", func_800EF9BC);

INCLUDE_ASM("asm/nonmatchings/main", func_800EFAF8);

INCLUDE_ASM("asm/nonmatchings/main", func_800EFB2C);

INCLUDE_ASM("asm/nonmatchings/main", func_800EFC70);

INCLUDE_ASM("asm/nonmatchings/main", DrawOTag2);

INCLUDE_ASM("asm/nonmatchings/main", func_800EFE0C);

INCLUDE_ASM("asm/nonmatchings/main", func_800EFE34);

INCLUDE_ASM("asm/nonmatchings/main", PadStartCom);

INCLUDE_ASM("asm/nonmatchings/main", PadStopCom);

INCLUDE_ASM("asm/nonmatchings/main", PadGetState);

INCLUDE_ASM("asm/nonmatchings/main", PadInfoMode);

INCLUDE_ASM("asm/nonmatchings/main", PadInfoAct);

INCLUDE_ASM("asm/nonmatchings/main", PadSetActAlign);

INCLUDE_ASM("asm/nonmatchings/main", PadSetMainMode);

INCLUDE_ASM("asm/nonmatchings/main", PadSetAct);

INCLUDE_ASM("asm/nonmatchings/main", addmatrix);

INCLUDE_ASM("asm/nonmatchings/main", submatrix);

INCLUDE_ASM("asm/nonmatchings/main", scalematrix);

INCLUDE_ASM("asm/nonmatchings/main", reorthogonalize);

INCLUDE_ASM("asm/nonmatchings/main", __gtdf2);

INCLUDE_ASM("asm/nonmatchings/main", initlinkmode);

INCLUDE_ASM("asm/nonmatchings/main", waitdraw);

INCLUDE_ASM("asm/nonmatchings/main", settrans);

INCLUDE_ASM("asm/nonmatchings/main", movfxya);

int shapecount(void *a0) {
    return *(int *)((char *)a0 + 0x8);
}
INCLUDE_ASM("asm/nonmatchings/main", shapepointer);

INCLUDE_ASM("asm/nonmatchings/main", shapename);

INCLUDE_ASM("asm/nonmatchings/main", func_800F0B1C);

INCLUDE_ASM("asm/nonmatchings/main", func_800F0B74);

INCLUDE_ASM("asm/nonmatchings/main", func_800F0BC0);

INCLUDE_ASM("asm/nonmatchings/main", func_800F0BF4);

INCLUDE_ASM("asm/nonmatchings/main", func_800F0C50);

INCLUDE_ASM("asm/nonmatchings/main", func_800F0CE8);

INCLUDE_ASM("asm/nonmatchings/main", func_800F0D24);

INCLUDE_ASM("asm/nonmatchings/main", func_800F0D80);

INCLUDE_ASM("asm/nonmatchings/main", func_800F0E54);

INCLUDE_ASM("asm/nonmatchings/main", func_800F0F18);

INCLUDE_ASM("asm/nonmatchings/main", func_800F1024);

INCLUDE_ASM("asm/nonmatchings/main", func_800F1120);

INCLUDE_ASM("asm/nonmatchings/main", initasync);

INCLUDE_ASM("asm/nonmatchings/main", asyncloadfilecallback);

INCLUDE_ASM("asm/nonmatchings/main", asyncloadfile);

INCLUDE_ASM("asm/nonmatchings/main", asyncloadfileatcallback);

INCLUDE_ASM("asm/nonmatchings/main", asyncloadfileat);

INCLUDE_ASM("asm/nonmatchings/main", setasyncfile);

INCLUDE_ASM("asm/nonmatchings/main", asyncloadsegmentcallback);

INCLUDE_ASM("asm/nonmatchings/main", asyncloadsegment);

INCLUDE_ASM("asm/nonmatchings/main", cancelasyncload);

INCLUDE_ASM("asm/nonmatchings/main", getasyncreadadr);

INCLUDE_ASM("asm/nonmatchings/main", getasyncreadstatus);

INCLUDE_ASM("asm/nonmatchings/main", SetVideoMode);

int GetVideoMode(void) {
    return *(int *)0x80134838;
}
INCLUDE_ASM("asm/nonmatchings/main", blockclear);

INCLUDE_ASM("asm/nonmatchings/main", blockfill);

INCLUDE_ASM("asm/nonmatchings/main", intcos);

INCLUDE_ASM("asm/nonmatchings/main", intsin);

INCLUDE_ASM("asm/nonmatchings/main", resizememadr);

INCLUDE_ASM("asm/nonmatchings/main", VectorNormalS);

INCLUDE_ASM("asm/nonmatchings/main", VectorNormal);

INCLUDE_ASM("asm/nonmatchings/main", VectorNormalSS);

INCLUDE_ASM("asm/nonmatchings/main", func_800F1B3C);

INCLUDE_ASM("asm/nonmatchings/main", GetTPage);

INCLUDE_ASM("asm/nonmatchings/main", loadshapeadr);

INCLUDE_ASM("asm/nonmatchings/main", addexit);

INCLUDE_ASM("asm/nonmatchings/main", SNDSYS_getopts);

INCLUDE_ASM("asm/nonmatchings/main", SNDSYS_setopts);

INCLUDE_ASM("asm/nonmatchings/main", SNDSYS_init);

INCLUDE_ASM("asm/nonmatchings/main", SNDSYS_restore);

INCLUDE_ASM("asm/nonmatchings/main", iSNDsystemtaskreal);

INCLUDE_ASM("asm/nonmatchings/main", SNDSYS_vectortoreal);

INCLUDE_ASM("asm/nonmatchings/main", func_800F219C);

INCLUDE_ASM("asm/nonmatchings/main", InitGeom);

INCLUDE_ASM("asm/nonmatchings/main", SetDefDrawEnv);

INCLUDE_ASM("asm/nonmatchings/main", SetDefDispEnv);

INCLUDE_ASM("asm/nonmatchings/main", VSync);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2494);

INCLUDE_ASM("asm/nonmatchings/main", RotMatrix);

INCLUDE_ASM("asm/nonmatchings/main", SetFarColor);

INCLUDE_ASM("asm/nonmatchings/main", SetFogNear);

INCLUDE_ASM("asm/nonmatchings/main", ResetCallback);

INCLUDE_ASM("asm/nonmatchings/main", InterruptCallback);

INCLUDE_ASM("asm/nonmatchings/main", DMACallback);

INCLUDE_ASM("asm/nonmatchings/main", VSyncCallback);

INCLUDE_ASM("asm/nonmatchings/main", VSyncCallbacks);

INCLUDE_ASM("asm/nonmatchings/main", CheckCallback);

INCLUDE_ASM("asm/nonmatchings/main", SetIntrMask);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2968);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2A40);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2C10);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2D58);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2DF8);

INCLUDE_ASM("asm/nonmatchings/main", func_800F2E70);

INCLUDE_ASM("asm/nonmatchings/main", setfont);

INCLUDE_ASM("asm/nonmatchings/main", getm);

INCLUDE_ASM("asm/nonmatchings/main", geti);

void putm(unsigned char *p, unsigned int val, int count) {
    count--;
    if (count < 0) return;
    p = p + count;
    do {
        *p = (unsigned char)val;
        val >>= 8;
        count--;
        p--;
    } while (count >= 0);
}
void puti(unsigned char *p, unsigned int val, int count) {
    count--;
    if (count < 0) return;
    do {
        *p = (unsigned char)val;
        val >>= 8;
        count--;
        p++;
    } while (count >= 0);
}
INCLUDE_ASM("asm/nonmatchings/main", SetSemiTrans);

INCLUDE_ASM("asm/nonmatchings/main", RotMatrixZ);

INCLUDE_ASM("asm/nonmatchings/main", isqrt);

void SetPolyGT4(unsigned char *p) {
    p[3] = 12;
    p[7] = 0x3C;
}
INCLUDE_ASM("asm/nonmatchings/main", __mulsf3);

void SetPolyF3(unsigned char *p) {
    p[3] = 4;
    p[7] = 0x20;
}
void SetPolyF4(unsigned char *p) {
    p[3] = 5;
    p[7] = 0x28;
}
void SetPolyG4(unsigned char *p) {
    p[3] = 8;
    p[7] = 0x38;
}
void SetPolyFT4(unsigned char *p) {
    p[3] = 9;
    p[7] = 0x2C;
}
INCLUDE_ASM("asm/nonmatchings/main", fixedsincos);

INCLUDE_ASM("asm/nonmatchings/main", ccos);

INCLUDE_ASM("asm/nonmatchings/main", csin);

INCLUDE_ASM("asm/nonmatchings/main", __fixsfsi);

INCLUDE_ASM("asm/nonmatchings/main", initjoy);

INCLUDE_ASM("asm/nonmatchings/main", initfileio);

INCLUDE_ASM("asm/nonmatchings/main", setdirectory);

INCLUDE_ASM("asm/nonmatchings/main", openfile);

INCLUDE_ASM("asm/nonmatchings/main", closefile);

INCLUDE_ASM("asm/nonmatchings/main", readfile);

INCLUDE_ASM("asm/nonmatchings/main", readfile_systask);

INCLUDE_ASM("asm/nonmatchings/main", writefile);

INCLUDE_ASM("asm/nonmatchings/main", getfilesize);

INCLUDE_ASM("asm/nonmatchings/main", stopreadfile);

int MEM_defaultevent(void *arg) { return 0; }
INCLUDE_ASM("asm/nonmatchings/main", initmemadr);

INCLUDE_ASM("asm/nonmatchings/main", inittimer);

INCLUDE_ASM("asm/nonmatchings/main", restoretimer);

INCLUDE_ASM("asm/nonmatchings/main", tmrint);

INCLUDE_ASM("asm/nonmatchings/main", FlushCache);

INCLUDE_ASM("asm/nonmatchings/main", shapedepth);

unsigned short GetClut(int x, int y) {
    return (y << 6) | ((x >> 4) & 0x3F);
}
INCLUDE_ASM("asm/nonmatchings/main", func_800F4470);

INCLUDE_ASM("asm/nonmatchings/main", getcharacter);

INCLUDE_ASM("asm/nonmatchings/main", unhuff);

INCLUDE_ASM("asm/nonmatchings/main", func_800F51C0);

INCLUDE_ASM("asm/nonmatchings/main", func_800F5234);

INCLUDE_ASM("asm/nonmatchings/main", func_800F5254);

INCLUDE_ASM("asm/nonmatchings/main", unrefpack);

INCLUDE_ASM("asm/nonmatchings/main", func_800F5530);

INCLUDE_ASM("asm/nonmatchings/main", unbtree);

INCLUDE_ASM("asm/nonmatchings/main", __extendsfdf2);

INCLUDE_ASM("asm/nonmatchings/main", __truncdfsf2);

INCLUDE_ASM("asm/nonmatchings/main", __adddf3);

INCLUDE_ASM("asm/nonmatchings/main", __divdf3);

INCLUDE_ASM("asm/nonmatchings/main", _comp_mant);

INCLUDE_ASM("asm/nonmatchings/main", strncpy);

int setclipwindow(void *p) { return 0; }
INCLUDE_ASM("asm/nonmatchings/main", SetShadeTex);

INCLUDE_ASM("asm/nonmatchings/main", crc16);

INCLUDE_ASM("asm/nonmatchings/main", strchr);

INCLUDE_ASM("asm/nonmatchings/main", __floatsisf);

INCLUDE_ASM("asm/nonmatchings/main", __muldf3);

INCLUDE_ASM("asm/nonmatchings/main", _mul_mant_d);

INCLUDE_ASM("asm/nonmatchings/main", __divsf3);

INCLUDE_ASM("asm/nonmatchings/main", __fixdfsi);

void checkrect(unsigned short *rect) {
    if (rect[2] & 1) {
        rect[3] |= 1;
    }
}
INCLUDE_ASM("asm/nonmatchings/main", vramimage);

INCLUDE_ASM("asm/nonmatchings/main", vramfxya);

INCLUDE_ASM("asm/nonmatchings/main", getshapeclut);

INCLUDE_ASM("asm/nonmatchings/main", shapetoclutid);

INCLUDE_ASM("asm/nonmatchings/main", FntFlush);

INCLUDE_ASM("asm/nonmatchings/main", FntPrint);

INCLUDE_ASM("asm/nonmatchings/main", DecDCTvlcSize);

INCLUDE_ASM("asm/nonmatchings/main", DecDCTvlc);

INCLUDE_ASM("asm/nonmatchings/main", CdStatus);

INCLUDE_ASM("asm/nonmatchings/main", CdMode);

INCLUDE_ASM("asm/nonmatchings/main", CdLastPos);

INCLUDE_ASM("asm/nonmatchings/main", CdReset);

INCLUDE_ASM("asm/nonmatchings/main", CdFlush);

INCLUDE_ASM("asm/nonmatchings/main", CdSetDebug);

INCLUDE_ASM("asm/nonmatchings/main", CdSync);

INCLUDE_ASM("asm/nonmatchings/main", CdReady);

INCLUDE_ASM("asm/nonmatchings/main", CdSyncCallback);

INCLUDE_ASM("asm/nonmatchings/main", CdReadyCallback);

INCLUDE_ASM("asm/nonmatchings/main", CdControl);

INCLUDE_ASM("asm/nonmatchings/main", CdControlF);

INCLUDE_ASM("asm/nonmatchings/main", CdControlB);

INCLUDE_ASM("asm/nonmatchings/main", CdGetSector);

INCLUDE_ASM("asm/nonmatchings/main", CdGetSector2);

INCLUDE_ASM("asm/nonmatchings/main", CdDataCallback);

INCLUDE_ASM("asm/nonmatchings/main", CdDataSync);

INCLUDE_ASM("asm/nonmatchings/main", CdIntToPos);

INCLUDE_ASM("asm/nonmatchings/main", CdPosToInt);

INCLUDE_ASM("asm/nonmatchings/main", StCdInterrupt);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8794);

INCLUDE_ASM("asm/nonmatchings/main", func_800F87C0);

INCLUDE_ASM("asm/nonmatchings/main", StClearRing);

INCLUDE_ASM("asm/nonmatchings/main", DecDCTReset);

INCLUDE_ASM("asm/nonmatchings/main", DecDCTin);

INCLUDE_ASM("asm/nonmatchings/main", DecDCTout);

INCLUDE_ASM("asm/nonmatchings/main", DecDCTinSync);

INCLUDE_ASM("asm/nonmatchings/main", DecDCToutCallback);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8AF8);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8BE8);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8C78);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8D04);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8D98);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8E2C);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8E44);

INCLUDE_ASM("asm/nonmatchings/main", StUnSetRing);

INCLUDE_ASM("asm/nonmatchings/main", CdRead2);

INCLUDE_ASM("asm/nonmatchings/main", func_800F8FCC);

INCLUDE_ASM("asm/nonmatchings/main", StSetStream);

INCLUDE_ASM("asm/nonmatchings/main", CdSearchFile);

INCLUDE_ASM("asm/nonmatchings/main", func_800F9360);

INCLUDE_ASM("asm/nonmatchings/main", func_800F9380);

INCLUDE_ASM("asm/nonmatchings/main", func_800F9644);

INCLUDE_ASM("asm/nonmatchings/main", func_800F96E8);

INCLUDE_ASM("asm/nonmatchings/main", func_800F9984);

INCLUDE_ASM("asm/nonmatchings/main", StSetRing);

INCLUDE_ASM("asm/nonmatchings/main", StGetNext);

INCLUDE_ASM("asm/nonmatchings/main", func_800F9AE8);

INCLUDE_ASM("asm/nonmatchings/main", func_800F9C44);

INCLUDE_ASM("asm/nonmatchings/main", func_800F9CA4);

INCLUDE_ASM("asm/nonmatchings/main", readsectorB);

INCLUDE_ASM("asm/nonmatchings/main", loaddirinfo);

INCLUDE_ASM("asm/nonmatchings/main", func_800FA344);

INCLUDE_ASM("asm/nonmatchings/main", CD_Restore);

INCLUDE_ASM("asm/nonmatchings/main", CD_Init);

INCLUDE_ASM("asm/nonmatchings/main", CD_Restart);

INCLUDE_ASM("asm/nonmatchings/main", CD_Open);

int CD_Close(int i) {
    int *table = *(int **)0x80146CF8;
    table[i - 1] = 0;
    return 0;
}
INCLUDE_ASM("asm/nonmatchings/main", CD_Read);

INCLUDE_ASM("asm/nonmatchings/main", CD_Stopread);

INCLUDE_ASM("asm/nonmatchings/main", CD_Getinfo);

INCLUDE_ASM("asm/nonmatchings/main", StFreeRing);

INCLUDE_ASM("asm/nonmatchings/main", SNDcdvol);

INCLUDE_ASM("asm/nonmatchings/main", MemCardInit);

INCLUDE_ASM("asm/nonmatchings/main", MemCardEnd);

INCLUDE_ASM("asm/nonmatchings/main", MemCardStart);

INCLUDE_ASM("asm/nonmatchings/main", MemCardStop);

INCLUDE_ASM("asm/nonmatchings/main", MemCardExist);

INCLUDE_ASM("asm/nonmatchings/main", func_800FABF0);

INCLUDE_ASM("asm/nonmatchings/main", MemCardAccept);

INCLUDE_ASM("asm/nonmatchings/main", func_800FAE2C);

INCLUDE_ASM("asm/nonmatchings/main", MemCardReadData);

INCLUDE_ASM("asm/nonmatchings/main", func_800FB118);

INCLUDE_ASM("asm/nonmatchings/main", MemCardWriteData);

INCLUDE_ASM("asm/nonmatchings/main", func_800FB30C);

INCLUDE_ASM("asm/nonmatchings/main", MemCardReadFile);

INCLUDE_ASM("asm/nonmatchings/main", func_800FB560);

INCLUDE_ASM("asm/nonmatchings/main", MemCardWriteFile);

INCLUDE_ASM("asm/nonmatchings/main", func_800FB780);

INCLUDE_ASM("asm/nonmatchings/main", MemCardGetDirentry);

INCLUDE_ASM("asm/nonmatchings/main", MemCardCallback);

INCLUDE_ASM("asm/nonmatchings/main", MemCardSync);

INCLUDE_ASM("asm/nonmatchings/main", MemCardCreateFile);

INCLUDE_ASM("asm/nonmatchings/main", MemCardDeleteFile);

INCLUDE_ASM("asm/nonmatchings/main", MemCardFormat);

INCLUDE_ASM("asm/nonmatchings/main", MemCardUnformat);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC11C);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC170);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC1F4);

INCLUDE_ASM("asm/nonmatchings/main", cluttype);

INCLUDE_ASM("asm/nonmatchings/main", shapetype);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC2F8);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC334);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC374);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC400);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC478);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC4E4);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC548);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC5E4);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC634);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC810);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC850);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC8A8);

INCLUDE_ASM("asm/nonmatchings/main", func_800FC9B4);

INCLUDE_ASM("asm/nonmatchings/main", func_800FCB44);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_overhead);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_create);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_setfilter);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_destroy);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_setpriority);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_setgreedylevel);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_setgreedystate);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_queuefile);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_queuemem);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_cancelrequest);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_kill);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_get);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_release);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_gettable);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_state);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_isendofstream);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_buffersize);

INCLUDE_ASM("asm/nonmatchings/main", STREAM_bufferusage);

INCLUDE_ASM("asm/nonmatchings/main", InitHeap);

INCLUDE_ASM("asm/nonmatchings/main", PadInitDirect);

INCLUDE_ASM("asm/nonmatchings/main", func_800FDE88);

INCLUDE_ASM("asm/nonmatchings/main", func_800FDEF0);

INCLUDE_ASM("asm/nonmatchings/main", func_800FDFE4);

INCLUDE_ASM("asm/nonmatchings/main", func_800FDFF4);

INCLUDE_ASM("asm/nonmatchings/main", func_800FE0B0);

INCLUDE_ASM("asm/nonmatchings/main", func_800FE32C);

INCLUDE_ASM("asm/nonmatchings/main", func_800FE364);

INCLUDE_ASM("asm/nonmatchings/main", memchr);

INCLUDE_ASM("asm/nonmatchings/main", memmove);

INCLUDE_ASM("asm/nonmatchings/main", iscurrentthread);

void yieldthread(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", allocmutex);

void freemutex(int *p) {
    *p = 0;
}
INCLUDE_ASM("asm/nonmatchings/main", make64);

INCLUDE_ASM("asm/nonmatchings/main", divu64);

INCLUDE_ASM("asm/nonmatchings/main", stricmp);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformfree);

INCLUDE_ASM("asm/nonmatchings/main", iSNDbankremovepat);

INCLUDE_ASM("asm/nonmatchings/main", iSNDvalidbank);

INCLUDE_ASM("asm/nonmatchings/main", iSNDischanreserved);

INCLUDE_ASM("asm/nonmatchings/main", iSNDallocchan);

INCLUDE_ASM("asm/nonmatchings/main", iSNDfreechan);

INCLUDE_ASM("asm/nonmatchings/main", iSNDgetchan);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatform3dpos);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpatchkey);

INCLUDE_ASM("asm/nonmatchings/main", iSNDcalcvol);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxkeyon);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxkeyoff);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxeffecton);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxeffectoff);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxeffectvol);

INCLUDE_ASM("asm/nonmatchings/main", iSNDsetvol);

INCLUDE_ASM("asm/nonmatchings/main", iSNDsetslot);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstartvoice);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformoutputcaps);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformoutputset);

INCLUDE_ASM("asm/nonmatchings/main", iSNDinit);

INCLUDE_ASM("asm/nonmatchings/main", iSNDrestore);

INCLUDE_ASM("asm/nonmatchings/main", iSNDserve);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstop);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformpitch);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformfxlevel);

INCLUDE_ASM("asm/nonmatchings/main", iSNDvol);

void SNDI_mutexalloc(void) {
}

void SNDI_mutexfree(void) {
}

void SNDI_mutexlock(void) {
}

void SNDI_mutexunlock(void) {
}

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxfxinit);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformfxinit);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformfxmasterlevel);

INCLUDE_ASM("asm/nonmatchings/main", SNDfxlevel);

INCLUDE_ASM("asm/nonmatchings/main", func_80100710);

INCLUDE_ASM("asm/nonmatchings/main", func_80100724);

INCLUDE_ASM("asm/nonmatchings/main", func_80100730);

INCLUDE_ASM("asm/nonmatchings/main", func_8010073C);

INCLUDE_ASM("asm/nonmatchings/main", func_80100748);

INCLUDE_ASM("asm/nonmatchings/main", func_80100760);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_MatchSample);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_GetPhraseBank);

unsigned char *iSPCH_GetBankBits(unsigned char *hdr) {
    int stride = (hdr[2] & 0xF) + 2;
    int count  = hdr[3];
    hdr += 8;
    return hdr + count * stride;
}
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ClearCycleBit);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_CheckBankBit);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_CheckTemplateSample);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SampleExists);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ChooseSamples);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SampleLength);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ConvertTime);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SentenceLength);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_OrderSentences);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_RepeatEvent);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ShortRuleStatus);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SentenceGetChoices);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_RandomizeSentencePicks);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_IterateChoice);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ChooseShortSentence);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SentenceMakeChoice);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ConstantRuleSet);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_MakeSampleRequests);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ClearChosen);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SaveChosenSentence);

int iSPCH_OneChosen(void) {
    return D_80148448;
}
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_PlayChosen);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_ChooseSentence);

INCLUDE_ASM("asm/nonmatchings/main", SPCH_SetPreLoadTicks);

INCLUDE_ASM("asm/nonmatchings/main", iSNDdetunetolinear);

INCLUDE_ASM("asm/nonmatchings/main", iSNDcalcpitch);

void iSNDresetpatch(void *p) {
    *(int *)((char *)p + 0x90) = 0;
}
INCLUDE_ASM("asm/nonmatchings/main", iSNDresettimbre);

INCLUDE_ASM("asm/nonmatchings/main", iSNDresolveheader);

INCLUDE_ASM("asm/nonmatchings/main", iSNDfindfreekey);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplaytaggedtimbre);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplaytaggedpatch);

INCLUDE_ASM("asm/nonmatchings/main", iSNDresolvetaggedpatch);

INCLUDE_ASM("asm/nonmatchings/main", iSNDremovetaggedpatch);

INCLUDE_ASM("asm/nonmatchings/main", iSNDdownloadbank);

INCLUDE_ASM("asm/nonmatchings/main", iSNDbankalloc);

INCLUDE_ASM("asm/nonmatchings/main", SNDgetvol);

INCLUDE_ASM("asm/nonmatchings/main", printf);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketplayoverhead);

INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_overhead);

INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_create);

INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_start);

INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_submit);

INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_submitspace);

INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_unsafeframesoutstanding);

INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_framesoutstanding);

INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_purge);

INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_stop);

INCLUDE_ASM("asm/nonmatchings/main", SNDPKTPLAY_destroy);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketget);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketfreeframes);

INCLUDE_ASM("asm/nonmatchings/main", iSNDmulu64);

INCLUDE_ASM("asm/nonmatchings/main", iSNDdivu64);

INCLUDE_ASM("asm/nonmatchings/main", iSNDstreamgetrequestptr);

INCLUDE_ASM("asm/nonmatchings/main", strrchr);

INCLUDE_ASM("asm/nonmatchings/main", tolower);

INCLUDE_ASM("asm/nonmatchings/main", SNDattributessetdef);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpatchtohdr);

INCLUDE_ASM("asm/nonmatchings/main", memcmp);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketgetirq);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketsetirq);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketirqcallback);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxzerospu);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketpurgeframes);

INCLUDE_ASM("asm/nonmatchings/main", iSNDfillspuwithpackets);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpacketserve);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformpacketoverhead);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformcalcdatarate);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformpacketplaycreate);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformpacketplaydestroy);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformpacketplay);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxpacketstop);

INCLUDE_ASM("asm/nonmatchings/main", iSNDserveraddclient);

INCLUDE_ASM("asm/nonmatchings/main", iSNDserverremoveclient);

INCLUDE_ASM("asm/nonmatchings/main", SNDSYS_service);

INCLUDE_ASM("asm/nonmatchings/main", _dbl_shift_us);

INCLUDE_ASM("asm/nonmatchings/main", iSNDtimeremaining);

INCLUDE_ASM("asm/nonmatchings/main", GPU_cw);

INCLUDE_ASM("asm/nonmatchings/main", _padSetVsyncParam);

INCLUDE_ASM("asm/nonmatchings/main", func_80104A48);

INCLUDE_ASM("asm/nonmatchings/main", func_80104AB0);

INCLUDE_ASM("asm/nonmatchings/main", _padStartCom);

INCLUDE_ASM("asm/nonmatchings/main", _padStopCom);

INCLUDE_ASM("asm/nonmatchings/main", _padInitSioMode);

INCLUDE_ASM("asm/nonmatchings/main", func_80105060);

INCLUDE_ASM("asm/nonmatchings/main", _padSioRW);

INCLUDE_ASM("asm/nonmatchings/main", _padSioRW2);

INCLUDE_ASM("asm/nonmatchings/main", _padClrIntSio0);

INCLUDE_ASM("asm/nonmatchings/main", _padWaitRXready);

INCLUDE_ASM("asm/nonmatchings/main", _padSetAct);

INCLUDE_ASM("asm/nonmatchings/main", _padSendAtLoadInfo);

INCLUDE_ASM("asm/nonmatchings/main", _padRecvAtLoadInfo);

INCLUDE_ASM("asm/nonmatchings/main", _padGetActSize);

INCLUDE_ASM("asm/nonmatchings/main", _padLoadActInfo);

INCLUDE_ASM("asm/nonmatchings/main", func_801058D8);

INCLUDE_ASM("asm/nonmatchings/main", func_80105980);

INCLUDE_ASM("asm/nonmatchings/main", _padSetActAlign);

INCLUDE_ASM("asm/nonmatchings/main", func_80105C5C);

INCLUDE_ASM("asm/nonmatchings/main", func_80105C78);

INCLUDE_ASM("asm/nonmatchings/main", _padSetMainMode);

INCLUDE_ASM("asm/nonmatchings/main", func_80105DD8);

INCLUDE_ASM("asm/nonmatchings/main", func_80105E2C);

void _padCmdParaMode(unsigned char *p, int mode) {
    p[0x36] = 0x43;
    *(unsigned char **)(p + 0x2C) = p + 0x24;
    p[0x24] = (unsigned char)mode;
    p[0x35] = 1;
}
INCLUDE_ASM("asm/nonmatchings/main", func_80105EAC);

INCLUDE_ASM("asm/nonmatchings/main", func_80105EC0);

INCLUDE_ASM("asm/nonmatchings/main", func_80105EE0);

INCLUDE_ASM("asm/nonmatchings/main", func_80105F00);

INCLUDE_ASM("asm/nonmatchings/main", func_80105F20);

INCLUDE_ASM("asm/nonmatchings/main", transmult);

INCLUDE_ASM("asm/nonmatchings/main", fastmovfxya);

INCLUDE_ASM("asm/nonmatchings/main", iSNDmemconstrain);

INCLUDE_ASM("asm/nonmatchings/main", iSNDmeminit);

INCLUDE_ASM("asm/nonmatchings/main", iSNDmemrestore);

INCLUDE_ASM("asm/nonmatchings/main", iSNDmalloc);

INCLUDE_ASM("asm/nonmatchings/main", _patch_gte);

INCLUDE_ASM("asm/nonmatchings/main", func_80106500);

INCLUDE_ASM("asm/nonmatchings/main", startIntrVSync);

INCLUDE_ASM("asm/nonmatchings/main", func_8010658C);

INCLUDE_ASM("asm/nonmatchings/main", func_801065F8);

INCLUDE_ASM("asm/nonmatchings/main", func_80106624);

INCLUDE_ASM("asm/nonmatchings/main", ChangeClearPAD);

INCLUDE_ASM("asm/nonmatchings/main", ChangeClearRCnt);

INCLUDE_ASM("asm/nonmatchings/main", SetDQA);

INCLUDE_ASM("asm/nonmatchings/main", SetDQB);

INCLUDE_ASM("asm/nonmatchings/main", setjmp);

INCLUDE_ASM("asm/nonmatchings/main", HookEntryInt);

INCLUDE_ASM("asm/nonmatchings/main", startIntrDMA);

INCLUDE_ASM("asm/nonmatchings/main", func_801066F8);

INCLUDE_ASM("asm/nonmatchings/main", func_80106878);

INCLUDE_ASM("asm/nonmatchings/main", func_80106924);

INCLUDE_ASM("asm/nonmatchings/main", func_8010694C);

INCLUDE_ASM("asm/nonmatchings/main", _96_remove);

INCLUDE_ASM("asm/nonmatchings/main", ExitCriticalSection);

INCLUDE_ASM("asm/nonmatchings/main", ReturnFromException);

INCLUDE_ASM("asm/nonmatchings/main", EnterCriticalSection);

INCLUDE_ASM("asm/nonmatchings/main", ResetEntryInt);

int decodeansi(unsigned char **pp) {
    unsigned char *p = *pp;
    int v = *p;
    *pp = p + 1;
    return v;
}
INCLUDE_ASM("asm/nonmatchings/main", remapshiftjiscode);

INCLUDE_ASM("asm/nonmatchings/main", decodeshiftjis);

INCLUDE_ASM("asm/nonmatchings/main", _err_math);

INCLUDE_ASM("asm/nonmatchings/main", csincos);

INCLUDE_ASM("asm/nonmatchings/main", PCread);

INCLUDE_ASM("asm/nonmatchings/main", PCopen);

INCLUDE_ASM("asm/nonmatchings/main", PCinit);

INCLUDE_ASM("asm/nonmatchings/main", PCcreat);

int psxdevelopmentsystem(void) {
    unsigned short val = *(unsigned short *)0x86;
    if (val == 0x375A) return 1;
    if (val == 0x275A) return 0;
    return -1;
}
INCLUDE_ASM("asm/nonmatchings/main", PClseek);

INCLUDE_ASM("asm/nonmatchings/main", PCclose);

INCLUDE_ASM("asm/nonmatchings/main", PCwrite);

INCLUDE_ASM("asm/nonmatchings/main", EnableEvent);

INCLUDE_ASM("asm/nonmatchings/main", OpenEvent);

INCLUDE_ASM("asm/nonmatchings/main", DisableEvent);

INCLUDE_ASM("asm/nonmatchings/main", _dbl_shift);

INCLUDE_ASM("asm/nonmatchings/main", _mainasu);

INCLUDE_ASM("asm/nonmatchings/main", _add_mant_d);

void TermPrim(unsigned long *p) {
    *p |= 0x00FFFFFFUL;
}
INCLUDE_ASM("asm/nonmatchings/main", AddPrim);

INCLUDE_ASM("asm/nonmatchings/main", func_80107080);

INCLUDE_ASM("asm/nonmatchings/main", CD_sync);

INCLUDE_ASM("asm/nonmatchings/main", CD_ready);

INCLUDE_ASM("asm/nonmatchings/main", CD_cw);

INCLUDE_ASM("asm/nonmatchings/main", CD_flush);

INCLUDE_ASM("asm/nonmatchings/main", CD_initvol);

INCLUDE_ASM("asm/nonmatchings/main", CD_initintr);

INCLUDE_ASM("asm/nonmatchings/main", CD_init_80108140);

INCLUDE_ASM("asm/nonmatchings/main", CD_datasync);

INCLUDE_ASM("asm/nonmatchings/main", CD_getsector);

INCLUDE_ASM("asm/nonmatchings/main", CD_getsector2);

INCLUDE_ASM("asm/nonmatchings/main", CD_set_test_parmnum);

INCLUDE_ASM("asm/nonmatchings/main", func_80108680);

INCLUDE_ASM("asm/nonmatchings/main", init_ring_status);

INCLUDE_ASM("asm/nonmatchings/main", data_ready_callback);

INCLUDE_ASM("asm/nonmatchings/main", DsReadyCallback);

INCLUDE_ASM("asm/nonmatchings/main", DsDataCallback);

INCLUDE_ASM("asm/nonmatchings/main", StSetMask);

INCLUDE_ASM("asm/nonmatchings/main", func_8010887C);

INCLUDE_ASM("asm/nonmatchings/main", func_801088B0);

INCLUDE_ASM("asm/nonmatchings/main", func_80108B24);

INCLUDE_ASM("asm/nonmatchings/main", func_80108BF4);

INCLUDE_ASM("asm/nonmatchings/main", CdRead);

INCLUDE_ASM("asm/nonmatchings/main", CdReadSync);

INCLUDE_ASM("asm/nonmatchings/main", toupper);

INCLUDE_ASM("asm/nonmatchings/main", CdInit);

INCLUDE_ASM("asm/nonmatchings/main", func_8010911C);

INCLUDE_ASM("asm/nonmatchings/main", func_80109158);

INCLUDE_ASM("asm/nonmatchings/main", func_80109180);

INCLUDE_ASM("asm/nonmatchings/main", func_801091A8);

INCLUDE_ASM("asm/nonmatchings/main", bsearch);

INCLUDE_ASM("asm/nonmatchings/main", CdGetToc);

INCLUDE_ASM("asm/nonmatchings/main", CdGetToc2);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformcdpanvol);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpIOE);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpError);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpTimeout);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpNewcard);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpIOEx);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpErrorx);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpTimeoutx);

INCLUDE_ASM("asm/nonmatchings/main", funcEvSpNewcardx);

INCLUDE_ASM("asm/nonmatchings/main", _card_open);

INCLUDE_ASM("asm/nonmatchings/main", _card_start);

INCLUDE_ASM("asm/nonmatchings/main", _card_close);

INCLUDE_ASM("asm/nonmatchings/main", _card_stop);

INCLUDE_ASM("asm/nonmatchings/main", _clr_card_event);

INCLUDE_ASM("asm/nonmatchings/main", _get_card_event);

INCLUDE_ASM("asm/nonmatchings/main", _get_card_event_x);

INCLUDE_ASM("asm/nonmatchings/main", _chk_card_event);

INCLUDE_ASM("asm/nonmatchings/main", _chk_card_event_x);

INCLUDE_ASM("asm/nonmatchings/main", UserFuncInit);

INCLUDE_ASM("asm/nonmatchings/main", UserFuncOpen);

INCLUDE_ASM("asm/nonmatchings/main", UserFuncExecute);

int UserFuncComplete(void) {
    return ((unsigned int)*(int *)0x8013C2E0) >> 31;
}
INCLUDE_ASM("asm/nonmatchings/main", _card_info);

INCLUDE_ASM("asm/nonmatchings/main", _card_clear);

INCLUDE_ASM("asm/nonmatchings/main", _card_load);

INCLUDE_ASM("asm/nonmatchings/main", open);

INCLUDE_ASM("asm/nonmatchings/main", close);

INCLUDE_ASM("asm/nonmatchings/main", lseek);

INCLUDE_ASM("asm/nonmatchings/main", read);

INCLUDE_ASM("asm/nonmatchings/main", write);

INCLUDE_ASM("asm/nonmatchings/main", firstfile);

INCLUDE_ASM("asm/nonmatchings/main", func_80109F5C);

INCLUDE_ASM("asm/nonmatchings/main", nextfile);

INCLUDE_ASM("asm/nonmatchings/main", erase);

INCLUDE_ASM("asm/nonmatchings/main", format);

INCLUDE_ASM("asm/nonmatchings/main", _new_card);

INCLUDE_ASM("asm/nonmatchings/main", _card_write);

INCLUDE_ASM("asm/nonmatchings/main", _padInitDirSeq);

INCLUDE_ASM("asm/nonmatchings/main", func_8010A0E4);

INCLUDE_ASM("asm/nonmatchings/main", func_8010A1E4);

INCLUDE_ASM("asm/nonmatchings/main", _dirFailAuto);

INCLUDE_ASM("asm/nonmatchings/main", func_8010A510);

INCLUDE_ASM("asm/nonmatchings/main", bzero);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxmemconstrain);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxmalloc);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxfree);

INCLUDE_ASM("asm/nonmatchings/main", iSNDdmtransfer);

INCLUDE_ASM("asm/nonmatchings/main", iSNDdmcallback);

INCLUDE_ASM("asm/nonmatchings/main", iSNDdmservice);

INCLUDE_ASM("asm/nonmatchings/main", iSNDdmqueue);

INCLUDE_ASM("asm/nonmatchings/main", iSNDdmqueuesplit);

INCLUDE_ASM("asm/nonmatchings/main", iSNDdmcomplete);

int iSNDabs(int x) {
    return x < 0 ? -x : x;
}
INCLUDE_ASM("asm/nonmatchings/main", iSNDatodlrv);

INCLUDE_ASM("asm/nonmatchings/main", iSNDatolrv);

INCLUDE_ASM("asm/nonmatchings/main", func_8010B100);

INCLUDE_ASM("asm/nonmatchings/main", func_8010B10C);

INCLUDE_ASM("asm/nonmatchings/main", func_8010B124);

INCLUDE_ASM("asm/nonmatchings/main", func_8010B140);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_SentenceUsesParm);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_GetRuleID);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_RuleSet);

INCLUDE_ASM("asm/nonmatchings/main", iSPCH_GetRuleSettings);

int iSPCH_CheckSentenceRules(int a, int b, unsigned char *rules) {
    int mask = rules[1] & ~b;
    int diff = rules[2] ^ a;
    return (diff & mask) == 0;
}
void iSPCH_InitSample(unsigned char *p) {
    *(int *)(p + 4) = -1;
    *(int *)(p + 0) = 0;
    *(int *)(p + 8) = 0;
    p[0xC] = 0xFF;
    p[0xD] = 0xFF;
    p[0xE] = 0xFF;
    p[0xF] = 0xFF;
}
INCLUDE_ASM("asm/nonmatchings/main", iSPCH_UnPackSample);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformresolve);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformremove);

INCLUDE_ASM("asm/nonmatchings/main", iSNDplatformplay);

INCLUDE_ASM("asm/nonmatchings/main", randrange);

INCLUDE_ASM("asm/nonmatchings/main", iSNDgettag);

INCLUDE_ASM("asm/nonmatchings/main", iSNDrandom);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxenablespuirq);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpsxdisablespuirq);

INCLUDE_ASM("asm/nonmatchings/main", SysDeqIntRP);

INCLUDE_ASM("asm/nonmatchings/main", SysEnqIntRP);

INCLUDE_ASM("asm/nonmatchings/main", setRC2wait);

INCLUDE_ASM("asm/nonmatchings/main", chkRC2wait);

INCLUDE_ASM("asm/nonmatchings/main", func_8010C0A8);

INCLUDE_ASM("asm/nonmatchings/main", func_8010C0F0);

INCLUDE_ASM("asm/nonmatchings/main", func_8010C1C8);

INCLUDE_ASM("asm/nonmatchings/main", func_8010C288);

INCLUDE_ASM("asm/nonmatchings/main", func_8010C314);

INCLUDE_ASM("asm/nonmatchings/main", SetDrawMove);

INCLUDE_ASM("asm/nonmatchings/main", DeliverEvent);

INCLUDE_ASM("asm/nonmatchings/main", _SN_read);

INCLUDE_ASM("asm/nonmatchings/main", _SN_write);

INCLUDE_ASM("asm/nonmatchings/main", iSNDpvtolrv);

INCLUDE_ASM("asm/nonmatchings/main", InitCARD);

INCLUDE_ASM("asm/nonmatchings/main", StartCARD);

INCLUDE_ASM("asm/nonmatchings/main", StopCARD);

INCLUDE_ASM("asm/nonmatchings/main", _bu_init);

INCLUDE_ASM("asm/nonmatchings/main", CloseEvent);

INCLUDE_ASM("asm/nonmatchings/main", TestEvent);

INCLUDE_ASM("asm/nonmatchings/main", firstfile2);

INCLUDE_ASM("asm/nonmatchings/main", iSNDlibatodlrv);

INCLUDE_ASM("asm/nonmatchings/main", iSNDgetdata);

int ReadInitPadFlag(void) {
    return D_8013C338;
}
INCLUDE_ASM("asm/nonmatchings/main", InitCARD2);

INCLUDE_ASM("asm/nonmatchings/main", func_8010C9FC);

INCLUDE_ASM("asm/nonmatchings/main", func_8010CA40);

INCLUDE_ASM("asm/nonmatchings/main", _patch_card);

INCLUDE_ASM("asm/nonmatchings/main", _patch_card2);

INCLUDE_ASM("asm/nonmatchings/main", _copy_memcard_patch);

INCLUDE_ASM("asm/nonmatchings/main", StartCARD2);

INCLUDE_ASM("asm/nonmatchings/main", StopCARD2);

INCLUDE_ASM("asm/nonmatchings/main", _ExitCard);

INCLUDE_ASM("asm/nonmatchings/main", iSNDsin);
