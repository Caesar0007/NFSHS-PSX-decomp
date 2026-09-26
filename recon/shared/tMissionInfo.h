/* tMissionInfo -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_TMISSIONINFO_H
#define NFS4_SHARED_TMISSIONINFO_H

struct tMissionInfo {
    u_char fDescriptionID, fTrackNumber, fDirection, fMirrored;
    u_char fTimeOfDay, fWeather, fTraffic, fPad;
    u_short fStageOffset;
    u_char fNumStages;
    u_char fReserved[9];
};
#endif
