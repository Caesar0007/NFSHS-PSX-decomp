/* aih_traf.obj owner types; Cop/Traffic use canonical AIHIGH.H definitions. */
#ifndef NFS4_GAME_COMMON_AIH_TRAF_TYPES_H
#define NFS4_GAME_COMMON_AIH_TRAF_TYPES_H

#include "aih_hierarchy_types.h"

#define NFS4_AIHIGH_TYPE_PART 1
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART

#define NFS4_AIHIGH_TYPE_PART 2
#include "aihigh.h"
#undef NFS4_AIHIGH_TYPE_PART

#include "aistate.h"


/* Exact foreign header definitions used by this owner but omitted by its
   linked debug graph. Their canonical names preserve call mangling. */
#include "shared/Trk_NewSlice.h"






struct AITrigger_TriggerManager {
    int numTriggers_, invNumTriggers_;
    trigger_t *triggers_[100];
    int checkTime_[100];
    int lastTriggerChecked_[9];
    void Init(char *rawTriggers);
    int InsertTrigger(trigger_t *trigger, bool fromFile);
    trigger_t *GetNextTrigger(int car);
    trigger_t *GetPrevTrigger(int car);
    int CheckForTriggerAtSlice(int car, int slice);
    trigger_t *GetTrigger(int trigger, int *used);
    int CheckForClosestTriggerOfType(int slice, int type, int direction);
    void DescribeTrigger(trigger_t *trigger);
    void Sort();
};

typedef int CarLogic_tObservations[1][3];

#endif
