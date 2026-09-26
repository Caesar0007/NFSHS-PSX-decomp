/* Owner-specific type surface for Feaudio.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEAUDIO_TYPES_H
#define NFS4_FRONTEND_COMMON_FEAUDIO_TYPES_H

#include "../../game/common/color_types.h"

/* Feaudio retains the menu/iterator core but not the car-manager tail. */
#define NFS4_FE_CORE_NO_CAR_TYPES
#include "fe_core_types.h"
#undef NFS4_FE_CORE_NO_CAR_TYPES

struct LUMPYHEAD {
    u_long type, len, num, hlen;
};

struct FILEINFO {
    unsigned int offset, length;
    char name[1];
};

#include "shared/SPEECHINFO.h"







#include "shared/SNDSYSCAP.h"






#include "shared/SNDSYSSET.h"







#include "shared/SNDSYSVEC.h"



#include "shared/SNDPLAYOPTS.h"






#include "shared/SNDSAMPLEFORMAT.h"




#include "shared/AudioMus_tSongEntry.h"






#include "shared/tTrackInformation.h"











struct tTrackManager {
    u_long fNumTracks;
    tTrackInformation *fTracks;
    bool fAvailableTracks[16], fViewableTracks[16];
};

#endif
