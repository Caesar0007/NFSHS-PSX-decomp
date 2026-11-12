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
/* camera_info + forceFocus_t: the copspeak path omits camera_info and views forceFocus_t as int; retail cars.obj records
   forceFocus_t as its LAST type (after Speaker) -> both are defined in the tail block below */
#define NFS4_COLOR_OMIT_UDFF_HANDLE
#define NFS4_COLOR_HOOK_AFTER_CAR "cars_types.h"   /* retail: physics/AIDataRecord/anim/object types right after Car_tObj (second pass below) */
#include "copspeak_types.h"
#endif
#if defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_CARS_EARLY_DONE)   /* second pass, from color_types.h */
#define NFS4_CARS_EARLY_DONE
struct AIPhysic_BrakeInfo {
    u_char brakeTable_[128];
    int deceleration_; /* the 5 retail AIPhysic_BrakeInfo inline bodies (aiphysic_types.h + aispeeds_types.h); retail 7 TPDEFs per includer */ inline void SetBrakeDistance(int speed, int distance) { int sIndex = speed / 0x10000; if (sIndex < 0) sIndex = -sIndex; if (!(sIndex < 0x80)) sIndex = 0x80; brakeTable_[sIndex] = (u_char)(distance / 0x20000); } AIPhysic_BrakeInfo(int deceleration) { int invDeceleration; deceleration_ = deceleration; invDeceleration = fixeddiv(0x10000, deceleration); for (int brakeTableLoop = 0; brakeTableLoop < 0x80; brakeTableLoop++) { int brakeDistanceMeters = fixedmult(fixedmult(brakeTableLoop << 0x10, invDeceleration), brakeTableLoop << 0x10) / 2; SetBrakeDistance(brakeTableLoop << 0x10, brakeDistanceMeters); } } inline int Deceleration() { return deceleration_; } int GetBrakeDistance(int speed) { int sIndex = speed / 0x10000; if (sIndex < 0) { sIndex = -sIndex; } if (!(sIndex < 0x80)) { sIndex = 0x80; } return (u_int)brakeTable_[sIndex] * 0x20000; } int GetNeededDistance(int futureSpeed,int currentSpeed) { return GetBrakeDistance(currentSpeed) - GetBrakeDistance(futureSpeed); }
};
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
    AIDataRecord_RecordMethod_t recordMethod_; /* accessors as in aidatarecord_types.h (retail 9 TPDEFs per includer) */ inline AIDataRecord_RecordMethod_t RecordMethod() { return recordMethod_; } inline char *Name() { return name_; } inline char *DataBuffer() { return dataBuffer_; } inline char *PreAllocatedBuffer() { return preAllocatedBuffer_; } inline int BufferSize() { return bSize_; } inline int NumElements() { return numElements_; } inline void SetDataBuffer(char *buffer) { dataBuffer_ = buffer; }
    virtual ~AIDataRecord_t();   /* aidatarecord.cpp owns the family; slots: dtor, Setup */
    virtual void Setup();
} AIDataRecord_t;
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {};
#include "shared/AnimScript.h"   /* one AnimScript definition (header-truth 4f) */




#include "shared/SceneElem.h"







#include "shared/SceneSortedElem.h"
#include "shared/AnimDef.h"

struct DRender_tView;
struct Draw_DCache;
/* object.cpp's polymorphic root, as this surface needs it: virtual dtor [slot 1], pure Draw [slot 2] */
#include "object_anim_classes.h"   /* the OBJECT.H animation class family: no private copies (header-truth 4h) */










#endif
#if !defined(NFS4_COLOR_IN_HOOK2) && !defined(NFS4_CARS_TAIL_DONE)   /* first pass, after copspeak_types.h */
#define NFS4_CARS_TAIL_DONE
struct AIDataRecord_AccTable_t : public AIDataRecord_t { int scale_; };
#undef NFS4_COLOR_OMIT_UDFF_HANDLE


#undef NFS4_COPSPEAK_OMIT_OWNER_ONLY_TYPES
#undef NFS4_AUDIOCMN_OMIT_COPSPEAK_REQUEST
#undef NFS4_AUDIOCMN_OMIT_AUDIO_MUS_ENTRY
#undef NFS4_AUDIOCMN_OMIT_SND_PLAY_OPTS
#undef NFS4_AUDIOCLC_OMIT_SOUND_API_TYPES
enum forceFocus_t { FOCUS_NORMAL = 0, FOCUS_AI = 1, FOCUS_COPANDAI = 2 };   /* retail cars.obj: forceFocus_t is the last type record, after Speaker */
#include "shared/camera_info.h"   /* its forceFocus field keeps the enum referenced (SLINK) */

typedef int CarLogic_tObservations[1][3];

#include "shared/Trk_ObjectDef.h"

#include "shared/Trk_CollideBoomInst.h"








#include "shared/Trk_AnimateInst.h"





#include "shared/Trk_SimObject.h"





#include "shared/Trk_NewSlice.h"













#include "shared/Object_tIMassObjInfo.h"

typedef Udff_tInfo *Udff_tHandle;

#endif
