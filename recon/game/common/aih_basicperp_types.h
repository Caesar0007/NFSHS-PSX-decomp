#ifndef NFS4_GAME_COMMON_AIH_BASICPERP_TYPES_H
#define NFS4_GAME_COMMON_AIH_BASICPERP_TYPES_H   /* aih_basicperp.obj's exact owner delta over the shared AI hierarchy. */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */

/* Retail inlines these members here; other key-function TUs must not emit out-of-line copies merely because they include the shared hierarchy. */
/* (NONE_KEEP lifted: with the Speech graph present, retail Car_tObj no longer needs the AIState_None ctor record) */
#define NFS4_AIHIGH_PLAYER_PLAIN   /* aihigh.h: AIHigh_Player stays a plain struct here (retail TPDEF count) */
#define NFS4_AIHIGH_COP_AFTER_BASICCOP   /* aihigh.h: AIHigh_Cop right after AIHigh_BasicCop (retail AIHIGH.H order 414/448/471) */
#include "aih_hierarchy_types.h"

#include "shared/forceFocus_t.h"





#include "shared/BW_tContext.h"






#define NFS4_AIHIGH_TYPE_PART 1
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART


#include "speech_class.h"   /* retail: the full Speech class graph (Speaker + CarBank/LocationBank/CallSignBank with their inline bodies) is recorded in this AI object */












































/* Canonical foreign aggregates used by this translation unit. */
/* GameSetup_tData: not in retail aih_basicperp.obj (GameSetup_gData is read through its word view) */















#include "shared/Sim_tSimGlobalVar.h"



#include "shared/Trk_NewSlice.h"







#define RaceType_HotPursuit 1
#define RaceType_Id5 5

typedef int CarLogic_tObservations[1][3];
typedef long (*ReparmFuncPtr)();
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();

#endif
