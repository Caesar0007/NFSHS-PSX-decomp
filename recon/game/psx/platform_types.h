/* platform.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_PLATFORM_TYPES_H
#define NFS4_GAME_PSX_PLATFORM_TYPES_H

#include "../common/color_types.h"

#include "shared/TCB.h"
#include "shared/EXEC.h"



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
