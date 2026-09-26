/* rpause.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_RPAUSE_TYPES_H
#define NFS4_GAME_PSX_RPAUSE_TYPES_H

#include "../common/draw_leaf_types.h"

#include "shared/TCB.h"
#include "shared/EXEC.h"



struct DIRENTRY {
    char name[20];
    long attr, size;
    DIRENTRY *next;
    long head;
    char system[4];
};

#include "shared/Draw_tView.h"





#include "shared/dflip.h"




#endif
