/* tSaveCarInfo -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TSAVECARINFO_H
#define NFS4_SHARED_TSAVECARINFO_H

struct tSaveCarInfo {
    tOwnedCarInfo fSaveInfo[32];
    u_char fSaveAvailable[48], fSaveViewable[48];
};
#endif
