/* Owner-specific type tail for FETracks.obj. */
#ifndef NFS4_FRONTEND_COMMON_FETRACKS_TYPES_H
#define NFS4_FRONTEND_COMMON_FETRACKS_TYPES_H

#include "fe_core_types.h"

/* This source spelling is not a typedef record in FETracks.obj. */
#define uchar unsigned char

typedef enum tTrackClassType {
    tct_Beginner = 0,
    tct_Intermediate = 1,
    tct_Expert = 2,
    tct_GTR = 3,
    tct_Bonus = 4
} tTrackClassType;

typedef enum tPlayer {
    kPlayerBoth = -1,
    kPlayerOne = 0,
    kPlayerTwo = 1
} tPlayer;

struct tListIteratorIndexed : public tListIterator {
    char *fIndex;

    tListIteratorIndexed(short *selection, char *valPtr, char *index);
    ~tListIteratorIndexed();
    char Value(tPlayer player);
    short TextValue(tPlayer player);
    void Increment(tPlayer player);
    void Decrement(tPlayer player);
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

struct tSaveTrackInfo {
    u_char fTrackActivated[16];
};

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
