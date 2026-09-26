/* dashhud_info -- the one definition of this type, shared by 4 headers (moved verbatim by
   tools/psyq_pipe/dedup_types.py; every former copy now includes this file at the same place). */
#ifndef NFS4_SHARED_DASHHUD_INFO_H
#define NFS4_SHARED_DASHHUD_INFO_H

struct dashhud_info {
    int splitscreen;
    char name[9];
    int conversion, flashtime, flashlap;
    int showhud[2], showmap[2], wrongway[2];
    int laptime, lap, maxlaps, rpm, redline, gear, speed, topspeed;
    int position, opponents, record, tutor;
    int warning[2];
};
#endif
