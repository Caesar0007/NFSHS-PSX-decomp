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

struct SPEECHINFO {
    char name[4];
    int multiplay, nHandle, nSoundHandle;
    char areLoading, soundIsPlaying, playNextOne;
    char *pBankHeader, *sSpeechData, *lastSpeechData;
    int vivHandle;
};

struct SNDSYSCAP {
    u_short outputratemin, outputratemax;
    u_char outputchannelsmin, outputchannelsmax, inputvoicesmax,
           input3dvoicesmax, eax, voicemanager;
    char pad[2];
};

struct SNDSYSSET {
    u_short maxbanks, outputrate;
    u_char outputchannels, inputvoices, useeax, use3dacceleration, use3dmixing;
    char pad;
    u_short emulationsubtype;
    u_short spkrcfg3d[4][4];
};

struct SNDSYSVEC {
    int (*issurfacelocked)(void);
};

struct SNDPLAYOPTS {
    int patnum;
    char bhandle, keynum, velocity, pan, vol, bend, fxlevel0, use3dpos;
    u_short pitchmult, timemult, azimuth;
    short elevation;
};

struct SNDSAMPLEFORMAT {
    u_short samplerate;
    u_char channels, samplerep;
};

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};

struct tListIteratorIndexed : public tListIterator {
    char *fIndex;
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

struct tTrackManager {
    u_long fNumTracks;
    tTrackInformation *fTracks;
    bool fAvailableTracks[16], fViewableTracks[16];
};

#endif
