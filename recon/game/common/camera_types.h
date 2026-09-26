/* Camera private type projection; owner-derived foreign bodies are noted below. */
#ifndef NFS4_GAME_COMMON_CAMERA_TYPES_H
#define NFS4_GAME_COMMON_CAMERA_TYPES_H

#include "color_types.h"

#define RaceType_HotPursuit 1
#define RaceType_Id5 5

/* Owner-derived bworldSm type: SYM1cec71..1cedc3,32 bytes. Camera's
 * surviving type stream does not preserve this foreign body; its original
 * header visibility remains a source-recovery question, not a sealed claim. */
#include "shared/Trk_NewSlice.h"







/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















struct Sched_tSchedule;
#include "shared/Sim_tSimGlobalVar.h"




#include "shared/Sim_tSimSystemVar.h"




#include "shared/tReplayInterface.h"




/* Owner-derived replay type (SYM326706..32678F); camera.obj's own type
 * stream does not retain this foreign body. This is not a caller-graph seal. */
#include "shared/tReplayCameraModes.h"



typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

#include "shared/Sched_tSchedule.h"




typedef enum AIDataRecord_RecordMethod_t {
    NORMAL_M = 0,
    RECORD_M = 1,
    TEST_M = 2
} AIDataRecord_RecordMethod_t;

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

#include "shared/POLY_GT4.h"






#include "shared/Draw_SubdivStruct.h"
#include "shared/Track_tArtresource.h"






#include "shared/Track_tMaterial.h"

#include "shared/Trk_AnimateInst.h"





#include "shared/DRender_tView.h"




#include "shared/camera_info.h"





























struct camera_flags {
    coorddef arm;
    int pitch : 1;
    int jostling : 1;
    int tracking : 1;
    int checkwalls : 1;
    int noLookBack : 1;
    int checkcollisions : 1;
};

#include "shared/Camera_tCamSlot.h"











#include "shared/kernpair.h"

#include "shared/TCB.h"
#include "shared/EXEC.h"



#include "shared/DIRENTRY.h"







#include "shared/Skidmark_Segment.h"





#include "shared/Skidmark_Chunk.h"





typedef int Input_tDeviceCall();
typedef kernpair KERN;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();
typedef camera_info Camera_tInfo;
typedef camera_flags Camera_tFlags;

#endif
