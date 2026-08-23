/* overlays.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_OVERLAYS_TYPES_H
#define NFS4_GAME_PSX_OVERLAYS_TYPES_H

#include "../common/color_types.h"

#define RaceType_HotPursuit 1

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

struct tBTCPerpInfo {
    char name[8];
    int time;
    bool caught;
};

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef kernpair KERN;

typedef void (*adjustchar)();
typedef void (*fontblit)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef int (*getcode)();

#endif
