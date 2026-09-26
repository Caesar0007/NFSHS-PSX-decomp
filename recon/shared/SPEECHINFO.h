/* SPEECHINFO -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_SPEECHINFO_H
#define NFS4_SHARED_SPEECHINFO_H

struct SPEECHINFO {
    char name[4];
    int multiplay, nHandle, nSoundHandle;
    char areLoading, soundIsPlaying, playNextOne;
    char *pBankHeader, *sSpeechData, *lastSpeechData;
    int vivHandle;
};
#endif
