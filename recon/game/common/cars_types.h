#if !defined(NFS4_GAME_COMMON_CARS_TYPES_H)   /* first pass */
#define NFS4_GAME_COMMON_CARS_TYPES_H   /* cars.obj's exact source-visible delta over the shared CopSpeak graph. */
#define NFS4_COLOR_GS_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_FIRST   /* retail type order (game/common/color_types.h) */
#define NFS4_DRAW_LEAF_HOOK_AFTER_PADS "cars_after_pads.h"   /* retail: GameSetup + scheduler right after the pads */
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_AUDIOCLC_OMIT_SOUND_API_TYPES
#define NFS4_AUDIOCLC_LATE_KERNEL   /* retail: TCB..Skidmark right after tfrontEnd (audiocmn_types.h) */
#define NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#define NFS4_AUDIOCMN_OMIT_AUDIO_MUS_ENTRY
#define NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#define NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#define NFS4_COPSPEAK_KEEP_CAMERA_VIEW
#define NFS4_COPSPEAK_KEEP_FORCE_FOCUS
#define NFS4_COLOR_OMIT_UDFF_HANDLE
#define NFS4_COLOR_HOOK_AFTER_CAR "cars_types.h"   /* retail: physics/AIDataRecord/anim/object types right after Car_tObj (second pass below) */
#include "copspeak_types.h"
#endif
#if defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_CARS_EARLY_DONE)   /* second pass, from color_types.h */
#define NFS4_CARS_EARLY_DONE
typedef struct AIPhysic_BrakeInfo {
    u_char brakeTable_[128];
    int deceleration_;
} AIPhysic_BrakeInfo;
#include "shared/AIPhysic_ModelConfig_t.h"
enum AIDataRecord_RecordMethod_t {
    NORMAL_M = 0,
    RECORD_M = 1,
    TEST_M = 2
};
typedef struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    AIDataRecord_RecordMethod_t recordMethod_;
    virtual ~AIDataRecord_t();   /* aidatarecord.cpp owns the family; slots: dtor, Setup */
    virtual void Setup();
} AIDataRecord_t;
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {};
typedef struct AnimScript {   /* retail: C-style typedef (two TPDEF AnimScript) */
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
} AnimScript;

#include "shared/SceneElem.h"







#include "shared/SceneSortedElem.h"
#include "shared/AnimDef.h"

struct DRender_tView;
struct Draw_DCache;
/* object.cpp's polymorphic root, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */
struct ObjectAnim {
    ObjectAnim() {}
    virtual ~ObjectAnim() {}
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
struct ObjectFinishedMultiAnim : public ObjectAnim { };
struct ObjectFinishedSignAnim : public ObjectAnim {
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
};
#endif
#if !defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_CARS_TAIL_DONE)   /* first pass, after copspeak_types.h */
#define NFS4_CARS_TAIL_DONE
struct AIDataRecord_AccTable_t : public AIDataRecord_t { int scale_; };
#undef NFS4_COLOR_OMIT_UDFF_HANDLE
#undef NFS4_COPSPEAK_KEEP_FORCE_FOCUS
#undef NFS4_COPSPEAK_KEEP_CAMERA_VIEW
#undef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#undef NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#undef NFS4_AUDIOCMN_OMIT_AUDIO_MUS_ENTRY
#undef NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#undef NFS4_AUDIOCLC_OMIT_SOUND_API_TYPES



typedef int CarLogic_tObservations[1][3];

#include "shared/Trk_ObjectDef.h"

#include "shared/Trk_CollideBoomInst.h"








#include "shared/Trk_AnimateInst.h"





#include "shared/Trk_SimObject.h"





#include "shared/Trk_NewSlice.h"













#include "shared/Object_tIMassObjInfo.h"

typedef Udff_tInfo *Udff_tHandle;

#endif
