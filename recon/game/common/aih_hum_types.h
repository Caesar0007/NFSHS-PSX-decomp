/* aih_hum.obj's one-definition delta over the shared AI hierarchy graph. */
#ifndef NFS4_GAME_COMMON_AIH_HUM_TYPES_H
#define NFS4_GAME_COMMON_AIH_HUM_TYPES_H

#include "aih_hierarchy_types.h"

struct AIHigh_Human : public AIHigh_Player {
    AIHigh_Human() {}
    AIHigh_Human(Car_tObj *carObj);
    ~AIHigh_Human();
    void HighExecute();
};

typedef int CarLogic_tObservations[1][3];

#endif
