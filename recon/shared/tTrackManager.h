/* tTrackManager -- FETRACKS.H, one definition for every includer (header-truth 4t). Members are defined in fetracks.cpp. */
#ifndef NFS4_SHARED_TTRACKMANAGER_H
#define NFS4_SHARED_TTRACKMANAGER_H
struct tSaveTrackInfo;
#include "shared/tTrackClassType.h"
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
#endif
