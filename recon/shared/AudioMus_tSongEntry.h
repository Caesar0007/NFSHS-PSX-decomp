/* AudioMus_tSongEntry -- the one definition of this type, shared by 17 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_AUDIOMUS_TSONGENTRY_H
#define NFS4_SHARED_AUDIOMUS_TSONGENTRY_H

struct AudioMus_tSongEntry {
    char *filename, *title, *artist, *label, *date, *notes;
    int length, index;
    char strbuf[32];
};
#endif
