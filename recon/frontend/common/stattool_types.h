/* Owner-specific type surface for Stattool.obj. */
#ifndef NFS4_FRONTEND_COMMON_STATTOOL_TYPES_H
#define NFS4_FRONTEND_COMMON_STATTOOL_TYPES_H

/* Statchk.obj's complete 89-record graph is a strict subset. */
#include "statchk_types.h"

struct TCB {
    long status, mode;
    u_long reg[40];
    long system[6];
};

struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};

struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

struct CARD_FILE_HEADER {
    char magic[2];
    char type, numslots;
    char documentname[64];
    char pad[28];
    char clut[32];
    char icon[3][128];
};

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
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
