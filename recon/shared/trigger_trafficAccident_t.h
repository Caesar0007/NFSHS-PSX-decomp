/* trigger_trafficAccident_t -- the one definition of this type, shared by 6 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRIGGER_TRAFFICACCIDENT_T_H
#define NFS4_SHARED_TRIGGER_TRAFFICACCIDENT_T_H

struct trigger_trafficAccident_t {
    int type, slice;
    coorddef position;
    matrixtdef orientation;
};
#endif
