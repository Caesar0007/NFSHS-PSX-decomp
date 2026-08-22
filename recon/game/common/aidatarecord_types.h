/* AIDATARECORD.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_AIDATARECORD_TYPES_H
#define NFS4_GAME_COMMON_AIDATARECORD_TYPES_H

#include "color_types.h"

/* GCC 2.7.2's old-ABI vtable entry; the compiler's modern built-in cannot be
 * materialized as an extern array by this host compiler. */
typedef struct __nfs4_vtbl_ptr_t {
    short delta, index;
    int (*pfn)(...);
} __nfs4_vtbl_ptr_t;
#define __vtbl_ptr_type __nfs4_vtbl_ptr_t

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

typedef enum AIDataRecord_WhichRecord_t {
    NORECORD_R = 0,
    RACER_SPEED_R = 1,
    TRAFFIC_SPEED_R = 2,
    ACCELERATION_R = 3,
    REMOVED_R = 4,
    BEST_LINE_R = 5,
    TRACK_CURVE_R = 6,
    CURVESPEED_TABLE_R = 7,
    CAR_TRACKING_R = 8
} AIDataRecord_WhichRecord_t;

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
    __vtbl_ptr_type (*_vf)[3];
    AIDataRecord_t() {}
    AIDataRecord_t(AIDataRecord_WhichRecord_t which, char *name);
    ~AIDataRecord_t();
    int AddRecordToCollection();
    int RemoveRecordFromCollection();
    static void StartUp1();
    static void StartUp2();
    static void CleanUp1();
    static void CleanUp2();
    void Setup();
    int Load();
    int SaveAndPurge();
};

struct AIDataRecord_AccTable_t : public AIDataRecord_t {
    int scale_;
    AIDataRecord_AccTable_t() {}
    AIDataRecord_AccTable_t(char *name, int n, AIDataRecord_WhichRecord_t which);
    ~AIDataRecord_AccTable_t();
    int Get(int i);
    void Setup();
};

struct AIDataRecord_CurveSpeedTable_t : public AIDataRecord_t {
    AIDataRecord_CurveSpeedTable_t() {}
    AIDataRecord_CurveSpeedTable_t(char *name, AIDataRecord_WhichRecord_t which);
    ~AIDataRecord_CurveSpeedTable_t();
    int Get(int i);
    void Upgrade(int i);
};

struct AIDataRecord_BestLine_t : public AIDataRecord_t {
    AIDataRecord_BestLine_t() {}
    AIDataRecord_BestLine_t(AIDataRecord_WhichRecord_t which);
    ~AIDataRecord_BestLine_t();
};

struct AIDataRecord_TrackCurve_t : public AIDataRecord_t {
    AIDataRecord_TrackCurve_t() {}
    AIDataRecord_TrackCurve_t(AIDataRecord_WhichRecord_t which);
    ~AIDataRecord_TrackCurve_t();
    int Get(int i);
};

struct AIDataRecord_CarTracking_t : public AIDataRecord_t {
    AIDataRecord_CarTracking_t() {}
    ~AIDataRecord_CarTracking_t();
    int Get(int slice);
};

typedef int CarLogic_tObservations[1][3];

#endif
