/* cars.obj's exact source-visible delta over the shared CopSpeak graph. */
#ifndef NFS4_GAME_COMMON_CARS_TYPES_H
#define NFS4_GAME_COMMON_CARS_TYPES_H

#define NFS4_AUDIOCLC_OMIT_SOUND_API_TYPES
#define NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#define NFS4_AUDIOCMN_OMIT_AUDIO_MUS_ENTRY
#define NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#define NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#define NFS4_COPSPEAK_KEEP_CAMERA_VIEW
#define NFS4_COPSPEAK_KEEP_FORCE_FOCUS
#define NFS4_COLOR_OMIT_UDFF_HANDLE
#include "copspeak_types.h"
#undef NFS4_COLOR_OMIT_UDFF_HANDLE
#undef NFS4_COPSPEAK_KEEP_FORCE_FOCUS
#undef NFS4_COPSPEAK_KEEP_CAMERA_VIEW
#undef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#undef NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#undef NFS4_AUDIOCMN_OMIT_AUDIO_MUS_ENTRY
#undef NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#undef NFS4_AUDIOCLC_OMIT_SOUND_API_TYPES

typedef enum AIDataRecord_RecordMethod_t {
    NORMAL_M = 0,
    RECORD_M = 1,
    TEST_M = 2
} AIDataRecord_RecordMethod_t;

typedef int CarLogic_tObservations[1][3];

#include "shared/Trk_ObjectDef.h"

#include "shared/Trk_CollideBoomInst.h"








#include "shared/Trk_AnimateInst.h"





#include "shared/Trk_SimObject.h"





#include "shared/Trk_NewSlice.h"







struct AIDataRecord_t {
    int numElements_, bSize_;
    char name_[64];
    char *dataBuffer_, *preAllocatedBuffer_;
    AIDataRecord_RecordMethod_t recordMethod_;
    virtual ~AIDataRecord_t();   /* aidatarecord.cpp owns the family; slots: dtor, Setup */
    virtual void Setup();
};

struct AIDataRecord_AccTable_t : public AIDataRecord_t { int scale_; };
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {};

struct AIPhysic_BrakeInfo {
    u_char brakeTable_[128];
    int deceleration_;
};

#include "shared/AIPhysic_ModelConfig_t.h"





struct AnimScript {
    int baseTicks, baseFrame, flags, numParts;
    Trk_AnimateInst **inst;
};

#include "shared/SceneElem.h"







#include "shared/SceneSortedElem.h"
#include "shared/AnimDef.h"

struct DRender_tView;
struct Draw_DCache;
/* object.cpp's polymorphic root, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */
struct ObjectAnim {
    virtual ~ObjectAnim();
    virtual int Draw(DRender_tView *Vi, Draw_DCache *sd, int offset) = 0;
};
struct ObjectFinishedMultiAnim : public ObjectAnim { };
struct ObjectFinishedSignAnim : public ObjectAnim {
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
};

#include "shared/Object_tIMassObjInfo.h"





#include "shared/Udff_tInfo.h"




typedef Udff_tInfo *Udff_tHandle;

#endif
