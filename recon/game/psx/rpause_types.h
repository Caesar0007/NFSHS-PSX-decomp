/* rpause.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_RPAUSE_TYPES_H
#define NFS4_GAME_PSX_RPAUSE_TYPES_H

#include "../common/draw_leaf_types.h"

struct TCB { long status, mode; u_long reg[40]; long system[6]; };
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

struct Draw_tView {
    int otsize, membudget;
    DRAWENV drawenv[2];
    u_long *ot[2];
};

struct dflip {
    DISPENV disp;
    char *server;
};

#endif
