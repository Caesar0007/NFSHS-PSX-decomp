/* Owner-specific type surface for Feaudio.obj. */
#ifndef NFS4_FRONTEND_COMMON_FEAUDIO_TYPES_H
#define NFS4_FRONTEND_COMMON_FEAUDIO_TYPES_H
#include "../../game/common/gamesetup_leaf_types.h"   /* retail: core + GameSetup, then the sound records, then color */
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

#ifndef NFS4_FE_COLOR_LATE
#include "../../game/common/color_types.h"
#endif
/* Feaudio retains the menu/iterator core but not the car-manager tail. */
#define NFS4_FE_CORE_NO_CAR_TYPES
#include "fe_core_types.h"
#undef NFS4_FE_CORE_NO_CAR_TYPES
#include "shared/AudioMus_tSongEntry.h"
#include "shared/tTrackInformation.h"

#include "shared/tTrackManager.h"   /* one tTrackManager definition (header-truth 4t) */





#endif
