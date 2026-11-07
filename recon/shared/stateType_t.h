/* stateType_t -- the one definition of this type (moved verbatim from game/common/aih_hierarchy_types.h;
   every copy now includes this file; retail declares it next to its first user). */
#ifndef NFS4_SHARED_STATETYPE_T_H
#define NFS4_SHARED_STATETYPE_T_H

enum stateType_t {
    STATE_NONE = 0,
    STATE_PURGATORY = 1,
    STATE_NORMAL = 2,
    STATE_IDLE = 3,
    STATE_CHASE = 4,
    STATE_OFFROAD = 5,
    STATE_ROVING_TRAFFIC = 6,
    STATE_NONACTIVE = 7,
    STATE_DONUTS = 8,
    STATE_GOTOSLICE = 9,
    STATE_CRUISE = 10
};
#endif
