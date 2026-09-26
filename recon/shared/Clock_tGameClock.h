/* Clock_tGameClock -- the one definition of this type, shared by 2 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_CLOCK_TGAMECLOCK_H
#define NFS4_SHARED_CLOCK_TGAMECLOCK_H

struct Clock_tGameClock {
    int time128Hz, time64Hz, time32Hz;
};
#endif
