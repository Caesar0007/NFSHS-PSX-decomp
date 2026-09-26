/* AudioMus_tCurrentSong -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_AUDIOMUS_TCURRENTSONG_H
#define NFS4_SHARED_AUDIOMUS_TCURRENTSONG_H

struct AudioMus_tCurrentSong {
    int newsong, index, remaining;
    AudioMus_tSongEntry info;
};
#endif
