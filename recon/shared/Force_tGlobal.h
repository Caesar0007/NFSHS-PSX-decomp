/* Force_tGlobal -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_FORCE_TGLOBAL_H
#define NFS4_SHARED_FORCE_TGLOBAL_H

struct Force_tGlobal {
    u_char active, high, low, jolt, time, fade;
    u_char actuator[2];
};
#endif
