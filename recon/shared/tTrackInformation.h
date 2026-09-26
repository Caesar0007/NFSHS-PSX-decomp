/* tTrackInformation -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TTRACKINFORMATION_H
#define NFS4_SHARED_TTRACKINFORMATION_H

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
#endif
