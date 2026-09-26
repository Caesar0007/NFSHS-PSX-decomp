/* Trk_NewSlice -- the one definition of this type, shared by 18 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TRK_NEWSLICE_H
#define NFS4_SHARED_TRK_NEWSLICE_H

struct Trk_NewSlice {
    int center[3];
    char normal[3], forward[3], right[3];
    u_char acousticType;
    short pavedProfile, leftDrive, rightDrive;
    u_char chunkIndex, laneCount, avgPavedWidthLf, avgPavedWidthRt;
};
#endif
