#ifndef NFS4_GAME_COMMON_AI_TYPES_H
#define NFS4_GAME_COMMON_AI_TYPES_H   /* AI.obj's exact source-visible delta over the shared color graph. */
#define NFS4_COLOR_TRK_OBJ   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "color_types.h"
#include "shared/Trk_NewSlice.h"







/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail ai.obj (GameSetup_gData is read through its word view) */
















#define RaceType_HotPursuit 1

#include "shared/Sched_tSchedule.h"




/* Canonical sim.obj aggregate from the retail SYM type graph. */
#include "shared/Sim_tSimGlobalVar.h"

typedef struct AIPhysic_BrakeInfo { u_char brakeTable_[128]; int deceleration_; } AIPhysic_BrakeInfo;
#include "shared/AI_tInfo.h"   /* retail ai.obj: BrakeInfo, AI_tInfo, ModelConfig ahead of the AIDataRecord family */
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

struct AIDataRecord_AccTable_t : public AIDataRecord_t { int scale_; void Setup(); };   /* real non-inline virtual override (aidatarecord_types.h): g++ 2.8 dfs_debug_mark then skips it in the Car_tObj field walk, as retail */
struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {};
typedef struct AIDataRecord_BestLine_t : public AIDataRecord_t {
    /* Retail AI.obj keeps this/slice and buffer/latPos as an inline pair.
     * Get follows the record family's accessor spelling; the inline name
     * itself is not retained in that scope record. */
    inline int Get(int slice) {
        int latPos;
        char *buffer;
        buffer = dataBuffer_;
        latPos = (int)(signed char)buffer[slice];
        return latPos << 0xe;
    }
} AIDataRecord_BestLine_t;














#include "shared/Trk_ObjectDef.h"
#include "shared/Trk_CollideBoomInst.h"







#include "shared/Trk_AnimateInst.h"




#include "shared/Trk_SimObject.h"





#include "shared/BW_tContext.h"





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
struct DRender_tView;
struct Draw_DCache;
struct ObjectFinishedMultiAnim : public ObjectAnim { };
struct ObjectFinishedSignAnim : public ObjectAnim {
    matrixtdef finalMatrix;
    Trk_ObjectDef *objDef;
    Trk_CollideBoomInst *objCollideInstance;
};
typedef int CarLogic_tObservations[1][3];

#endif
