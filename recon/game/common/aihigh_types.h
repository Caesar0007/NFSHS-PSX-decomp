#define NFS4_AIHIGH_OWNER   /* aihigh.obj's exact owner delta over the shared AI hierarchy graph; key: AIState_None bodies (aistate.h), GetCarObj decl-only (aih_hierarchy_types.h) */
#if !defined(NFS4_GAME_COMMON_AIHIGH_TYPES_H)
#define NFS4_GAME_COMMON_AIHIGH_TYPES_H
#define NFS4_COLOR_CAR_STRUCT_ONLY   /* retail: one TPDEF Car_tObj (color_types.h) */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_AIHIGH_PLAYER_PLAIN   /* aihigh.h: AIHigh_Player stays a plain struct here (retail TPDEF count) */
#define NFS4_GAME_COMMON_AIH_HIERARCHY_TYPES_H   /* this object lists the hierarchy parts itself (retail record order) */
#include "aih_hier_triggers.h"
#include "shared/Sched_tSchedule.h"
#include "aih_hier_states.h"
#include "shared/AIHigh_CopGameType_t.h"   /* retail aihigh.obj: AIHigh_CopGameType_t between stateType_t and Wingman_Role */
#include "shared/Wingman_Role.h"
#include "aih_hier_classes.h"








#include "aistate.h"
/* Exact foreign class layouts needed by placement construction in this TU;
   their completed tags are omitted by AIHIGH.OBJ's linked debug graph. */
#line 276 "C:/nfs4/GAME/COMMON/AIHIGH.H"
inline AIHigh_BTC_HumanPerp::AIHigh_BTC_HumanPerp(Car_tObj *carObj) : AIHigh_BTC_Perp(carObj) {}
#include "cls_AIHigh_BTC_AIPerp.h"   /* class AIHigh_BTC_AIPerp: no private copy (perpMode_ has its enum type) */
























#define NFS4_AIHIGH_TYPE_PART 2
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART
#define NFS4_AIHIGH_TYPE_PART 1
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART

/* GameSetup_tData: not in retail aihigh.obj (GameSetup_gData is read through its word view) */















#define RaceType_HotPursuit 1
#define RaceType_Id5 5

typedef int CarLogic_tObservations[1][3];

#endif
