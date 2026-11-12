/* game/common/aitrigger_manager_class.h -- triggerType and class AITrigger_TriggerManager (AITRIGER.H), one definition
 * for every includer (header-truth 4n; moved from aitriger_types.h, the owner). */
#ifndef NFS4_GAME_COMMON_AITRIGGER_MANAGER_CLASS_H
#define NFS4_GAME_COMMON_AITRIGGER_MANAGER_CLASS_H
#include "shared/triggerType.h"
typedef struct AITrigger_TriggerManager {   /* C-style form: retail records TPDEF twice at the definition */
    int numTriggers_, invNumTriggers_;
    trigger_t *triggers_[100];
    int checkTime_[100];
    int lastTriggerChecked_[9];
    void Init(char *rawTriggers);
    int InsertTrigger(trigger_t *trigger, bool fromFile);
    trigger_t *GetNextTrigger(int car);
    trigger_t *GetPrevTrigger(int car);
    /* Inferred semantic name: retail's three nested inline scope pairs prove
     * this bounds-checked receiver/index shape, not its literal spelling.
     * Like retail, the check is only against numTriggers_ (no lower bound). */
    inline trigger_t *GetCheckedTrigger(int triggerNum);



    int CheckForTriggerAtSlice(int car, int slice);
    trigger_t *GetTrigger(int trigger, int *used);
    int CheckForClosestTriggerOfType(int slice, triggerType type, int direction);
    void DescribeTrigger(trigger_t *trigger);
    void Sort(); inline int InvNumTriggers();   /* defined in aih_play.cpp (same-file inline there) */
} AITrigger_TriggerManager; /* bodies after the typedef: retail records both TPDEFs before the trigger_t walk */ inline trigger_t *AITrigger_TriggerManager::GetCheckedTrigger(int triggerNum) { if (triggerNum < numTriggers_) return triggers_[triggerNum]; return (trigger_t *)0; }
#endif
