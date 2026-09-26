/* tTierInfo -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TTIERINFO_H
#define NFS4_SHARED_TTIERINFO_H

struct tTierInfo {
    u_char fNumTournaments, fDescriptionID, fTournOffset, fPad;
    u_char fReserved[8];
};
#endif
