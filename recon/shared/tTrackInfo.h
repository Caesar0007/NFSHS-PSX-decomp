/* tTrackInfo -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TTRACKINFO_H
#define NFS4_SHARED_TTRACKINFO_H

struct tTrackInfo {
    signed char fTrackNumber;
    u_char fDirection, fMirrored, fTimeOfDay, fWeather;
    u_char fRandom, fSituations, fPad;
    long fPrize[6];
    u_long fDifficulty;
    u_char fReserved[4];
};
#endif
