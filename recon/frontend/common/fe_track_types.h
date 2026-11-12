/* Track records shared by the retail FETracks.obj and FECars.obj owners. */
#ifndef NFS4_FRONTEND_COMMON_FE_TRACK_TYPES_H
#define NFS4_FRONTEND_COMMON_FE_TRACK_TYPES_H

#include "fe_core_types.h"
#ifndef NFS4_FE_TRACK_NO_PLAYER
#include "fe_player_types.h"
#endif

#include "shared/tTrackClassType.h"








#include "shared/tTrackInformation.h"
#ifdef NFS4_FE_TRACK_SAVEINFO   /* retail FEMemcard: tSaveTrackInfo right after tTrackInformation */
#include "shared/tSaveTrackInfo.h"
#endif

struct tSaveTrackInfo;

#include "shared/tTrackManager.h"   /* one tTrackManager definition (header-truth 4t) */














#ifdef NFS4_FE_TRACK_HOOK_AFTER_MANAGER   /* owner hook right after tTrackManager (retail: tListIteratorTrack) */
#define NFS4_FE_TRACK_IN_HOOK
#include NFS4_FE_TRACK_HOOK_AFTER_MANAGER
#undef NFS4_FE_TRACK_IN_HOOK
#endif

#endif
