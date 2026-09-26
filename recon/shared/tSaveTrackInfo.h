/* tSaveTrackInfo -- the one definition of this type, shared by 3 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TSAVETRACKINFO_H
#define NFS4_SHARED_TSAVETRACKINFO_H

struct tSaveTrackInfo {
    u_char fTrackActivated[16];
};
#endif
