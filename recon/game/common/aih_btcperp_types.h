#define NFS4_AICOP_GS_ROWS /* aih_btcperp.obj's exact owner delta over the shared AI hierarchy; key: GameSetup_gData row view (aicop_info_types.h) */
#if !defined(NFS4_GAME_COMMON_AIH_BTCPERP_TYPES_H)
#define NFS4_GAME_COMMON_AIH_BTCPERP_TYPES_H
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_AIHIGH_BLOCKADE_HEAD "aih_btcperp_types.h"   /* retail: AIHigh_BTC_AIPerp right after AIHigh_BTC_HumanPerp (aihigh.h, second pass below) */
#include "aih_hierarchy_types.h"
#include "shared/BW_tContext.h"

enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
};

#line 276 "C:/nfs4/GAME/COMMON/AIHIGH.H"
static inline void _btc_perp_dtor_ref(void *p) { ((AIHigh_BTC_Perp *)p)->~AIHigh_BTC_Perp(); }   /* DEVICE (exact-only): keeps the synthesized dtor's line-276 note; void* param so it adds no BTC_Perp TPDEF */
#line 19 "C:\\Temp\\nfs4-decomp\\recon\\game\\common\\aih_btcperp_types.h"

#include "shared/Trk_ObjectDef.h"
#include "shared/Trk_CollideBoomInst.h"







#include "shared/Trk_AnimateInst.h"




#include "shared/Trk_SimObject.h"





#include "aistate.h"


#include "speech_class.h"   /* retail: the full Speech class graph (Speaker + CarBank/LocationBank/CallSignBank with their inline bodies) is recorded in this AI object */











































#include "shared/AnimScript.h"   /* one AnimScript definition (header-truth 4f) */



#include "shared/AnimDef.h"
struct DRender_tView;
struct Draw_DCache;
/* object.cpp's polymorphic root, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */
#include "object_anim_classes.h"   /* the OBJECT.H animation class family: no private copies (header-truth 4h) */










/* Canonical foreign aggregates used by this translation unit. */
#include "shared/AITune_BTC_t.h"



/* GameSetup_tData: not in retail aih_btcperp.obj (GameSetup_gData is read through its row view) */















#include "shared/Sim_tSimGlobalVar.h"



#include "shared/camera_info.h"





























enum AICop_RoadBlockState {
    kAICop_RoadBlockState_None = 0,
    kAICop_RoadBlockState_WaitingForPerp = 1,
    kAICop_RoadBlockState_PerpPassed = 2
};

typedef int CarLogic_tObservations[1][3];
typedef long (*ReparmFuncPtr)();
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();

#elif !defined(NFS4_AIH_BTCPERP_BLK_DONE)   /* second pass: aihigh.h NFS4_AIHIGH_BLOCKADE_HEAD */
#define NFS4_AIH_BTCPERP_BLK_DONE
#include "cls_AIHigh_BTC_AIPerp.h"   /* class AIHigh_BTC_AIPerp (one definition) */













#include "shared/blockadeMode_t.h"
#endif
