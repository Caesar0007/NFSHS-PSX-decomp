#ifndef NFS4_GAME_COMMON_AIH_TRAF_TYPES_H
#define NFS4_GAME_COMMON_AIH_TRAF_TYPES_H   /* aih_traf.obj owner types; Cop/Traffic use canonical AIHIGH.H definitions. */
#define NFS4_COLOR_CAR_STRUCT_ONLY   /* retail: one TPDEF Car_tObj (color_types.h) */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_AIH_TRAF_OWNER   /* aihigh.h: AIHigh_Traffic inline copies LINK_STRIPPED */
#define NFS4_AIHIGH_PLAYER_PLAIN   /* aihigh.h: AIHigh_Player stays a plain struct here (retail TPDEF count) */
#define NFS4_AIHIGH_COP_AFTER_BASICCOP   /* aihigh.h: AIHigh_Cop right after AIHigh_BasicCop (retail AIHIGH.H order 414/448/471) */
#include "aih_hierarchy_types.h"
#include "../../link_stripped.h"
#define NFS4_AIHIGH_TYPE_PART 1
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART
#define NFS4_AIHIGH_TYPE_PART 2
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART

#include "aistate.h"


/* Exact foreign header definitions used by this owner but omitted by its
   linked debug graph. Their canonical names preserve call mangling. */
#include "shared/Trk_NewSlice.h"






#include "aitrigger_manager_class.h"   /* triggerType + class AITrigger_TriggerManager: one definition (header-truth 4n) */















typedef int CarLogic_tObservations[1][3];

#endif
