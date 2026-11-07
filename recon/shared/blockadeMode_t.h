/* blockadeMode_t -- the one definition of this type (moved verbatim from game/common/aih_hierarchy_types.h;
   every copy now includes this file; retail declares it next to its first user). */
#ifndef NFS4_SHARED_BLOCKADEMODE_T_H
#define NFS4_SHARED_BLOCKADEMODE_T_H

enum blockadeMode_t {
    BLOCKADEMODE_NONE = 0,
    BLOCKADEMODE_SETUP = 1,
    BLOCKADEMODE_WAITING = 2,
    BLOCKADEMODE_CHASE = 3,
    BLOCKADEMODE_SETUP_FOR_OTHER = 4
};
#endif
