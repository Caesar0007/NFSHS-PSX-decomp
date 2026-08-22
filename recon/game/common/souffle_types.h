/* souffle.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_SOUFFLE_TYPES_H
#define NFS4_GAME_COMMON_SOUFFLE_TYPES_H

#include "color_types.h"

struct DRender_tView {
    int id, player;
    DRender_tCalcView cview;
};

struct Souffle_tISouffle {
    char type, id, wind, cycle;
    int aspeed, angle;
    coorddef source, motion, extramotion;
    SVECTOR trans;
    int rndpixmap, ground, colour;
};

struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

struct TCB {
    long status, mode;
    u_long reg[40];
    long system[6];
};

struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};

struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

#endif
