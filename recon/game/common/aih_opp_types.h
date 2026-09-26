/* aih_opp.obj's two-definition delta over the shared AI hierarchy graph. */
#ifndef NFS4_GAME_COMMON_AIH_OPP_TYPES_H
#define NFS4_GAME_COMMON_AIH_OPP_TYPES_H

#include "aih_hierarchy_types.h"

#include "aistate_classes.h"


struct AIHigh_Opponent : public AIHigh_Player {
    AIHigh_tAttackMode attackMode_;
    Car_tObj *lastHumanHitter_;
    int hitCount_, attackTicksLeft_;
    AIHigh_Opponent(Car_tObj *carObj);
    ~AIHigh_Opponent();
    void CheckForWipeOut();
    int DoRearEnder();
    void HighExecute();
    int DoProvokedAttack();
};

/* Canonical foreign aggregates used by this translation unit. */
#include "shared/GameSetup_tData.h"















#include "shared/Sim_tSimGlobalVar.h"



#include "shared/Trk_NewSlice.h"







typedef int CarLogic_tObservations[1][3];

#endif
