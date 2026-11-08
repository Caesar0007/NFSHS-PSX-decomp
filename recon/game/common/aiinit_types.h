#if !defined(NFS4_GAME_COMMON_AIINIT_TYPES_H)
#define NFS4_GAME_COMMON_AIINIT_TYPES_H   /* aiinit.obj reconstruction types over the shared color graph. */
#define NFS4_TRANSFORMER_Z_HOOK "../game/common/aiinit_types.h"   /* retail aiinit.obj: Udff types right after Transformer_zOverlay */
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_OWNER_DEFINES_UDFF_TYPES
#include "color_types.h"

/* Canonical gmesetup.obj aggregate used by this translation unit. */
/* GameSetup_tData: not in retail aiinit.obj (GameSetup_gData is read through its word view) */
















#define RaceType_Id3 3

#include "shared/Sched_tSchedule.h"





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

    virtual ~AIDataRecord_t();
    virtual void Setup();

    static void StartUp1();
    static void StartUp2();
    static void CleanUp1();
    static void CleanUp2();
} AIDataRecord_t;

struct AIDataRecord_AccTable_t : public AIDataRecord_t {
    int scale_;
    AIDataRecord_AccTable_t(char *name, int n, int which)
      asm("__23AIDataRecord_AccTable_tPci26AIDataRecord_WhichRecord_t");
    ~AIDataRecord_AccTable_t();
    void Setup();
};

struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {
    AIDataRecord_CurveSpeedTable_t(char *name, int which)
      asm("__30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t");
    ~AIDataRecord_CurveSpeedTable_t();
    void Upgrade(int i);
};

/* P892: the shared data owner's native type (SYM130b95..130c49,
   EXT1371f7), needed for the real leaderBoard fields. This foreign type
   projection is not claimed present in aiinit.obj's surviving type list. */
#include "shared/AISpeeds_tLeaderBoard.h"



struct AIPhysic_BrakeInfo { u_char brakeTable_[128]; int deceleration_; /* the 5 retail AIPhysic_BrakeInfo inline bodies (aiphysic_types.h + aispeeds_types.h); retail 7 TPDEFs per includer */ inline void SetBrakeDistance(int speed, int distance) { int sIndex = speed / 0x10000; if (sIndex < 0) sIndex = -sIndex; if (!(sIndex < 0x80)) sIndex = 0x80; brakeTable_[sIndex] = (u_char)(distance / 0x20000); } AIPhysic_BrakeInfo(int deceleration) { int invDeceleration; deceleration_ = deceleration; invDeceleration = fixeddiv(0x10000, deceleration); for (int brakeTableLoop = 0; brakeTableLoop < 0x80; brakeTableLoop++) { int brakeDistanceMeters = fixedmult(fixedmult(brakeTableLoop << 0x10, invDeceleration), brakeTableLoop << 0x10) / 2; SetBrakeDistance(brakeTableLoop << 0x10, brakeDistanceMeters); } } inline int Deceleration() { return deceleration_; } int GetBrakeDistance(int speed) { int sIndex = speed / 0x10000; if (sIndex < 0) { sIndex = -sIndex; } if (!(sIndex < 0x80)) { sIndex = 0x80; } return (u_int)brakeTable_[sIndex] * 0x20000; } int GetNeededDistance(int futureSpeed,int currentSpeed) { return GetBrakeDistance(currentSpeed) - GetBrakeDistance(futureSpeed); } };

#include "shared/AIPhysic_ModelConfig_t.h"





#include "shared/AIPhysic_Config_t.h"





#include "shared/AI_tInfo.h"





#include "shared/accelscale_t.h"



#include "shared/trigger_anyTrigger_t.h"
#include "shared/trigger_simple_t.h"
#include "shared/trigger_roadblock_t.h"
#include "shared/trigger_offroad_t.h"





#include "shared/trigger_trafficAccident_t.h"




#include "shared/trigger_pathPosition_t.h"
#include "shared/trigger_trafficPath_t.h"





#include "shared/trigger_t.h"








struct AITrigger_TriggerManager {
    int numTriggers_, invNumTriggers_;
    trigger_t *triggers_[100];
    int checkTime_[100];
    int lastTriggerChecked_[9];
    void Init(char *rawTriggers);
};

typedef int CarLogic_tObservations[1][3];

#elif defined(NFS4_TRANSFORMER_IN_HOOK) && !defined(NFS4_AIINIT_TZ_DONE)   /* second pass: shared/Transformer_z.h */
#define NFS4_AIINIT_TZ_DONE
typedef enum Udff_tAccessType {
    UDFF_FILE = 0,
    UDFF_MEMORY = 1
} Udff_tAccessType;
#include "shared/Udff_tInfo.h"




typedef Udff_tInfo *Udff_tHandle;
#endif
