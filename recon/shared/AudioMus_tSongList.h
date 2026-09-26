/* AudioMus_tSongList -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_AUDIOMUS_TSONGLIST_H
#define NFS4_SHARED_AUDIOMUS_TSONGLIST_H

struct AudioMus_tSongList {
    int numsongs, currentsong;
    AudioMus_tSongEntry song[0];
};
#endif
