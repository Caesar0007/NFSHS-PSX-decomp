/* platform.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_PLATFORM_TYPES_H
#define NFS4_GAME_PSX_PLATFORM_TYPES_H

#include "../common/color_types.h"

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

struct CARD_FILE_HEADER {
    char magic[2];
    char type, numslots;
    char documentname[64];
    char pad[28];
    char clut[32];
    char icon[3][128];
};

struct eacelement { eacelement *link; };
typedef eacelement EACELEMENT;
typedef unsigned int qfunc();


#endif
