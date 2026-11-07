/* Track records shared by the retail FETracks.obj and FECars.obj owners. */
#ifndef NFS4_FRONTEND_COMMON_FE_TRACK_TYPES_H
#define NFS4_FRONTEND_COMMON_FE_TRACK_TYPES_H

#include "fe_core_types.h"
#ifndef NFS4_FE_TRACK_NO_PLAYER
#include "fe_player_types.h"
#endif

enum tTrackClassType {
    tct_Beginner = 0,
    tct_Intermediate = 1,
    tct_Expert = 2,
    tct_GTR = 3,
    tct_Bonus = 4
};


#include "shared/tTrackInformation.h"
#ifdef NFS4_FE_TRACK_SAVEINFO   /* retail FEMemcard: tSaveTrackInfo right after tTrackInformation */
#include "shared/tSaveTrackInfo.h"
#endif

struct tSaveTrackInfo;

struct tTrackManager {
    u_long fNumTracks;
    tTrackInformation *fTracks;
    bool fAvailableTracks[16], fViewableTracks[16];

    void Initialize();
    void LoadTracks(tSaveTrackInfo &load);
    void SaveTracks(tSaveTrackInfo &save);
    void GetTrack(short trackNumber, tTrackInformation &trackInfo);
    void LoadDescription();
    void ReleaseDescription();
    void SetTrackAvailable(short track, bool avail);
    void SetClassAvailable(tTrackClassType trackClass, bool avail);
    tTrackInformation *GetTrackByID(short track);
};
#ifdef NFS4_FE_TRACK_HOOK_AFTER_MANAGER   /* owner hook right after tTrackManager (retail: tListIteratorTrack) */
#define NFS4_FE_TRACK_IN_HOOK
#include NFS4_FE_TRACK_HOOK_AFTER_MANAGER
#undef NFS4_FE_TRACK_IN_HOOK
#endif

#endif
