/* Track records shared by the retail FETracks.obj and FECars.obj owners. */
#ifndef NFS4_FRONTEND_COMMON_FE_TRACK_TYPES_H
#define NFS4_FRONTEND_COMMON_FE_TRACK_TYPES_H

#include "fe_core_types.h"
#ifndef NFS4_FE_TRACK_NO_PLAYER
#include "fe_player_types.h"
#endif

typedef enum tTrackClassType {
    tct_Beginner = 0,
    tct_Intermediate = 1,
    tct_Expert = 2,
    tct_GTR = 3,
    tct_Bonus = 4
} tTrackClassType;

struct tListIteratorIndexed : public tListIterator {
    char *fIndex;

#ifndef NFS4_FE_TRACK_NO_PLAYER
    tListIteratorIndexed(short *selection, char *valPtr, char *index);
    ~tListIteratorIndexed();
    char Value(tPlayer player);
    short TextValue(tPlayer player);
    void Increment(tPlayer player);
    void Decrement(tPlayer player);
#endif
};

struct tTrackInformation {
    char fTrackID;
    u_char fSimNumber, fTrackDifficulty, fAvailable, fIsEgg;
    u_char fLengthKM, fLengthMiles, fNumMoments;
    char fShapeName[8], fSplineName[8];
    char fCountry, fDispatch, fReverseCall, fLanguage;
    char fTrafficCars[6];
    short fTX, fTY, fSX, fSY;
    u_char fSpeedoCountry, fPad;
    long fRotate;
};

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

#endif
