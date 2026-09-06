/* P876 read-only ABI triage diagnostic; never executed. */
#include "C:/Temp/nfs4-decomp/recon/game/common/aihigh.h"
#include "C:/Temp/nfs4-decomp/recon/game/common/aistate.h"

void p876_inplace_0(AIHigh_Base *self) { self->~AIHigh_Base(); }
void p876_inplace_1(AIHigh_None *self) { self->~AIHigh_None(); }
void p876_inplace_2(AIHigh_BasicPerp *self) { self->~AIHigh_BasicPerp(); }
void p876_inplace_3(AIHigh_Player *self) { self->~AIHigh_Player(); }
void p876_inplace_4(AIHigh_Human *self) { self->~AIHigh_Human(); }
void p876_inplace_5(AIHigh_Opponent *self) { self->~AIHigh_Opponent(); }
void p876_inplace_6(AIHigh_BTC_Perp *self) { self->~AIHigh_BTC_Perp(); }
void p876_inplace_7(AIHigh_BTC_HumanPerp *self) { self->~AIHigh_BTC_HumanPerp(); }
void p876_inplace_8(AIHigh_BasicCop *self) { self->~AIHigh_BasicCop(); }
void p876_inplace_9(AIHigh_Cop *self) { self->~AIHigh_Cop(); }
void p876_inplace_10(AIHigh_BTC_Cop *self) { self->~AIHigh_BTC_Cop(); }
void p876_inplace_11(AIHigh_BTC_HumanCop *self) { self->~AIHigh_BTC_HumanCop(); }
void p876_inplace_12(AIHigh_BTC_Wingman *self) { self->~AIHigh_BTC_Wingman(); }
void p876_inplace_13(AIHigh_Traffic *self) { self->~AIHigh_Traffic(); }
void p876_inplace_14(AIState_Chase *self) { self->~AIState_Chase(); }
void p876_inplace_15(AIState_Offroad *self) { self->~AIState_Offroad(); }
void p876_inplace_16(AIState_Purgatory *self) { self->~AIState_Purgatory(); }
void (*p876_static_start)(void) = &AIState_Purgatory::StartUp;
void p876_inplace_18(AIState_Donuts *self) { self->~AIState_Donuts(); }
void p876_inplace_19(AIState_Base *self) { self->~AIState_Base(); }
void p876_inplace_20(AIState_None *self) { self->~AIState_None(); }
void p876_inplace_21(AIState_Normal *self) { self->~AIState_Normal(); }
void p876_inplace_22(AIState_Idle *self) { self->~AIState_Idle(); }
void p876_inplace_23(AIState_NonActive *self) { self->~AIState_NonActive(); }
void p876_inplace_24(AIState_RovingTraffic *self) { self->~AIState_RovingTraffic(); }
void p876_inplace_25(AIState_GotoSlice *self) { self->~AIState_GotoSlice(); }
void p876_inplace_26(AIState_Cruise *self) { self->~AIState_Cruise(); }
