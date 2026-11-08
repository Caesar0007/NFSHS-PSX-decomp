/* aih_basiccop.obj's exact owner delta over the shared AI hierarchy graph. */
#ifndef NFS4_GAME_COMMON_AIH_BASICCOP_TYPES_H
#define NFS4_GAME_COMMON_AIH_BASICCOP_TYPES_H
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_TRK_SFX   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#include "aih_hierarchy_types.h"
#include "shared/BW_tContext.h"




#include "shared/Trk_ObjectDef.h"
#include "shared/Trk_CollideBoomInst.h"







#include "shared/Trk_AnimateInst.h"




#include "shared/Trk_SimObject.h"





typedef struct AnimScript {   /* retail: C-style typedef (two TPDEF AnimScript) */
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
} AnimScript; inline void AnimScript_FreeInst(Trk_AnimateInst **inst) { delete [] inst; } /* INFERRED body: retail aih_basiccop.obj TPDEF run AnimScript AnimScript Trk_AnimateInst (the AnimScript dtor delete [] inst, without the receiver); never called */
#include "shared/AnimDef.h"
struct DRender_tView;
struct Draw_DCache;
/* object.cpp's polymorphic root, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */
struct ObjectAnim {
    ObjectAnim() {}
    virtual ~ObjectAnim() {}
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
typedef struct ObjectFinishedMultiAnim : public ObjectAnim { ObjectFinishedMultiAnim() {} /* INFERRED body: retail aih_basiccop.obj TPDEF/param run evidence (Multi x4, Trk_SimObject, Trk_CollideBoomInst, Trk_ObjectDef), as ai_types.h; static (no this record), never called */ static void InheritMultiAnimState(Trk_SimObject *simObj, Trk_CollideBoomInst *objCollideInstance, Trk_ObjectDef *objDef); } ObjectFinishedMultiAnim; inline void ObjectFinishedMultiAnim::InheritMultiAnimState(Trk_SimObject *simObj, Trk_CollideBoomInst *objCollideInstance, Trk_ObjectDef *objDef) {}
typedef struct ObjectFinishedSignAnim : public ObjectAnim { ObjectFinishedSignAnim() {}
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
} ObjectFinishedSignAnim;
#include "shared/FLARE_PIECE_DEF.h"   /* retail aih_basiccop.obj: right after ObjectFinishedSignAnim */
#define NFS4_SPEECH_AI_VIEW   /* speech_class.h: Speech + Speaker + banks, no MobileSpeaker/DispatchSpeaker (retail AI-object view) */
#include "speech_class.h"   /* retail: the full Speech class graph (Speaker + CarBank/LocationBank/CallSignBank with their inline bodies) is recorded in this AI object */












































#include "shared/Trk_SFX.h"






/* Canonical foreign aggregates from the retail aicop.obj/bworldSm.obj type graphs. */
#include "shared/AICop_spikeBelt_t.h"


#include "shared/Trk_NewSlice.h"







typedef int CarLogic_tObservations[1][3];
typedef long (*ReparmFuncPtr)();
typedef long (*SampleRequestFuncPtr)();
typedef long (*TestSentenceRuleFuncPtr)();
typedef long (*TraceFuncPtr)();
typedef char *(*MemAllocFuncPtr)();
typedef void (*MemFreeFuncPtr)();
typedef void (*SetSentenceRuleFuncPtr)();

#endif
