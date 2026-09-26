/* tBTCPerpInfo -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TBTCPERPINFO_H
#define NFS4_SHARED_TBTCPERPINFO_H

struct tBTCPerpInfo {
    char name[8];
    int time;
    bool caught;
};
#endif
