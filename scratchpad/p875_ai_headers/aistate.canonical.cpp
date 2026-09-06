/* Diagnostic: existing canonical members, not the legacy free bridges. */
#include "C:/Temp/nfs4-decomp/recon/nfs4_types.h"

__typeof__(&AIState_Base::StateExecute) p875_member_0 = &AIState_Base::StateExecute;
AIState_Base *p875_ctor_1(Car_tObj *carObj) { return new AIState_Base(carObj); }
__typeof__(&AIState_Normal::Execute) p875_member_2 = &AIState_Normal::Execute;
AIState_Normal *p875_ctor_3(Car_tObj *carObj) { return new AIState_Normal(carObj); }
__typeof__(&AIState_Idle::Execute) p875_member_4 = &AIState_Idle::Execute;
__typeof__(&AIState_Idle::SetIdlePosition) p875_member_5 = &AIState_Idle::SetIdlePosition;
AIState_Chase *p875_ctor_6(Car_tObj *carObj, Car_tObj *targetCar, coorddef *relPosition, int nitrousTicks, int nitrousMinForeDistance, int nitrousMinAftDistance, int aggressionLevel, int delayTime) { return new AIState_Chase(carObj, targetCar, relPosition, nitrousTicks, nitrousMinForeDistance, nitrousMinAftDistance, aggressionLevel, delayTime); }
__typeof__(&AIState_Chase::SetTarget) p875_member_7 = &AIState_Chase::SetTarget;
__typeof__(&AIState_Chase::SetMurderMode) p875_member_8 = &AIState_Chase::SetMurderMode;
__typeof__(&AIState_Chase::SetUp) p875_member_9 = &AIState_Chase::SetUp;
__typeof__(&AIState_Chase::DoSlowNitrous) p875_member_10 = &AIState_Chase::DoSlowNitrous;
__typeof__(&AIState_Chase::DoNitrous) p875_member_11 = &AIState_Chase::DoNitrous;
__typeof__(&AIState_Chase::Execute) p875_member_12 = &AIState_Chase::Execute;
__typeof__(&AIState_Chase::FarTargeting) p875_member_13 = &AIState_Chase::FarTargeting;
__typeof__(&AIState_Chase::CalculateCloseTargettingAheadSlowDownFactor) p875_member_14 = &AIState_Chase::CalculateCloseTargettingAheadSlowDownFactor;
__typeof__(&AIState_Chase::CloseTargeting) p875_member_15 = &AIState_Chase::CloseTargeting;
__typeof__(&AIState_Chase::ApproachTargeting) p875_member_16 = &AIState_Chase::ApproachTargeting;
__typeof__(&AIState_Chase::CheckForBarriersAndTargetAroundThem) p875_member_17 = &AIState_Chase::CheckForBarriersAndTargetAroundThem;
__typeof__(&AIState_Chase::FindBarrierEndSlice) p875_member_18 = &AIState_Chase::FindBarrierEndSlice;
AIState_Offroad *p875_ctor_19(Car_tObj *carObj, int startSlice, coorddef *position, matrixtdef *orientation, int maxSpeedKPH, int releaseTime, int endSlice) { return new AIState_Offroad(carObj, startSlice, position, orientation, maxSpeedKPH, releaseTime, endSlice); }
__typeof__(&AIState_Offroad::UnleashIfInRange) p875_member_20 = &AIState_Offroad::UnleashIfInRange;
__typeof__(&AIState_Offroad::Execute) p875_member_21 = &AIState_Offroad::Execute;
AIState_Purgatory *p875_ctor_22(Car_tObj *carObj) { return new AIState_Purgatory(carObj); }
__typeof__(&AIState_Purgatory::TestForRelease) p875_member_23 = &AIState_Purgatory::TestForRelease;
__typeof__(&AIState_Purgatory::Execute) p875_member_24 = &AIState_Purgatory::Execute;
AIState_RovingTraffic *p875_ctor_25(Car_tObj *carObj, trigger_t *trigger) { return new AIState_RovingTraffic(carObj, trigger); }
__typeof__(&AIState_RovingTraffic::CheckIfCarIsNearbyAndStop) p875_member_26 = &AIState_RovingTraffic::CheckIfCarIsNearbyAndStop;
__typeof__(&AIState_RovingTraffic::Execute) p875_member_27 = &AIState_RovingTraffic::Execute;
__typeof__(&AIState_Donuts::Execute) p875_member_28 = &AIState_Donuts::Execute;
AIState_GotoSlice *p875_ctor_29(Car_tObj *carObj, int targetSlice, int stopWhenArrivedAtSlice) { return new AIState_GotoSlice(carObj, targetSlice, stopWhenArrivedAtSlice); }
__typeof__(&AIState_GotoSlice::Execute) p875_member_30 = &AIState_GotoSlice::Execute;
__typeof__(&AIState_GotoSlice::InTargetSliceRange) p875_member_31 = &AIState_GotoSlice::InTargetSliceRange;
AIState_Cruise *p875_ctor_32(Car_tObj *carObj, cruiseMode_t cruiseMode, int speedOrFactor) { return new AIState_Cruise(carObj, cruiseMode, speedOrFactor); }
__typeof__(&AIState_Cruise::Execute) p875_member_33 = &AIState_Cruise::Execute;
