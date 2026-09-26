/* tRecordBuffer -- the one definition of this type, shared by 13 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRECORDBUFFER_H
#define NFS4_SHARED_TRECORDBUFFER_H

struct tRecordBuffer {
    char sName[8];
    int nCar, nTime, nBestLap;
};
#endif
