/* platform.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_PLATFORM_TYPES_H
#define NFS4_GAME_PSX_PLATFORM_TYPES_H

#include "../common/color_types.h"

#include "shared/TCB.h"
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

#include "shared/CARD_FILE_HEADER.h"








#include "shared/eacelement.h"
typedef eacelement EACELEMENT;
typedef unsigned int qfunc();


#endif
