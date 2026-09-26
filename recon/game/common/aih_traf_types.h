/* aih_traf.obj's exact three-definition delta over the shared AI hierarchy. */
#ifndef NFS4_GAME_COMMON_AIH_TRAF_TYPES_H
#define NFS4_GAME_COMMON_AIH_TRAF_TYPES_H

#include "aih_hierarchy_types.h"

struct AIHigh_Cop : public AIHigh_BasicCop {
    AIHigh_Player *perpTarget_;
    int forcePurgatory_, chaseIndex_, requestSpikeBeltAtSlice_;
    int aggressionLevel_;
    AIHigh_Cop(Car_tObj *carObj, int idx);
    void SetTuningLevers();
    void HighExecute();
    int CheckForNeedyPlayers();
    void CheckForWipeOut();
    int CheckForNewTarget();
    void AssignToPlayer(AIHigh_Player *p);
    int GetCheckChasePosition(coorddef *pt);
    trigger_t *CheckForNewTriggers();
};

struct AIHigh_Traffic : public AIHigh_Base {
    int ignoreCops_, forcePurgatory_;
    SceneElem *accidentData_;
    AIHigh_Traffic(Car_tObj *carObj);
    Car_tObj *CheckForCops(int *p);
    AIHigh_Cop *CopCheck(int *p);
    void HighExecute();
    trigger_t *CheckForNewTriggers();
};

#include "aistate_classes.h"


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
