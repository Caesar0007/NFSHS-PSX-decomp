/* dashHUD.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_DASHHUD_TYPES_H
#define NFS4_GAME_COMMON_DASHHUD_TYPES_H

#include "color_types.h"

#define RaceType_Id4 4

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

struct dashhud_info {
    int splitscreen;
    char name[9];
    int conversion, flashtime, flashlap;
    int showhud[2], showmap[2], wrongway[2];
    int laptime, lap, maxlaps, rpm, redline, gear, speed, topspeed;
    int position, opponents, record, tutor;
    int warning[2];
};
typedef dashhud_info DashHUD_tInfo;

#endif
