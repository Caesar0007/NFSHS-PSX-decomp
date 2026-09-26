/* aiinit.obj reconstruction types over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AIINIT_TYPES_H
#define NFS4_GAME_COMMON_AIINIT_TYPES_H

#define NFS4_OWNER_DEFINES_UDFF_TYPES
#include "color_types.h"

/* Canonical gmesetup.obj aggregate used by this translation unit. */
#include "shared/GameSetup_tData.h"
















#define RaceType_Id3 3

#include "shared/Sched_tSchedule.h"




typedef enum Udff_tAccessType {
    UDFF_FILE = 0,
    UDFF_MEMORY = 1
} Udff_tAccessType;
#include "shared/Udff_tInfo.h"




typedef Udff_tInfo *Udff_tHandle;

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

    virtual ~AIDataRecord_t();
    virtual void Setup();

    static void StartUp1();
    static void StartUp2();
    static void CleanUp1();
    static void CleanUp2();
};

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



struct AIPhysic_BrakeInfo { u_char brakeTable_[128]; int deceleration_; };

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

#endif
