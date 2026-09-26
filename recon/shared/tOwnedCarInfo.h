/* tOwnedCarInfo -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TOWNEDCARINFO_H
#define NFS4_SHARED_TOWNEDCARINFO_H

struct tOwnedCarInfo {
    signed char fCarID;
    u_char fUpgrades, fCarColor, fPad;
};
#endif
