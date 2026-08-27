/* Owner-specific type tail for FETracks.obj. */
#ifndef NFS4_FRONTEND_COMMON_FETRACKS_TYPES_H
#define NFS4_FRONTEND_COMMON_FETRACKS_TYPES_H

#include "fe_track_types.h"

/* This source spelling is not a typedef record in FETracks.obj. */
#define uchar unsigned char

struct tSaveTrackInfo {
    u_char fTrackActivated[16];
};

struct tListIteratorTrack : public tListIteratorIndexed {
    tTrackManager *fTrackManager;

    tListIteratorTrack(char *valPtr, char *index,
                       tTrackManager *trackManager);
    ~tListIteratorTrack();
    short TextValue(tPlayer atIndex);
    void Increment(tPlayer atIndex);
    void Decrement(tPlayer atIndex);
    bool ValidTrack(char track);
};

#endif
