/* Trk_SimObject -- the one definition of this type, shared by 11 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRK_SIMOBJECT_H
#define NFS4_SHARED_TRK_SIMOBJECT_H

struct Trk_SimObject {
    int point[3];
    short radius, serialNum;
    u_char topCRAP, bottomCRAP, instIndex, type;
};
#endif
