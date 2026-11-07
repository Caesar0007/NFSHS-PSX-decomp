/* AIHigh_tAttackMode -- the one definition of this type (moved verbatim from game/common/aih_hierarchy_types.h;
   every copy now includes this file; retail declares it next to its first user). */
#ifndef NFS4_SHARED_AIHIGH_TATTACKMODE_H
#define NFS4_SHARED_AIHIGH_TATTACKMODE_H

typedef enum AIHigh_tAttackMode {
    NO_ATTACK = 0,
    REAR_END = 1,
    SCRIPT_ATTACK = 2,
    PROVOKED_ATTACK = 3
} AIHigh_tAttackMode;
#endif
