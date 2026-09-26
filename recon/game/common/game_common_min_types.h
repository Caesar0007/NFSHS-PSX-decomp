/* Minimal common-game include surface proved identically by new.obj and
 * paths.obj.  This preserves their retail debug graph without exposing the
 * unrelated declarations in nfs4_types.h. */
#ifndef NFS4_GAME_COMMON_MIN_TYPES_H
#define NFS4_GAME_COMMON_MIN_TYPES_H

#include "nfs4_types.h"

#include "shared/coorddef.h"


typedef struct coorddef LIBCOORD;

#include "shared/linedef.h"


typedef struct linedef LINE;

#include "shared/SHAPETABLEENTRY.h"




#include "shared/PAD_PSX.h"




#include "shared/PAD_NEGCON.h"







#include "shared/PAD_ANALOG.h"




#include "shared/PAD_MOUSE.h"





#include "shared/PAD_COMMON.h"









struct {
    char bActive, time;
};

typedef void *va_list;
typedef int INTFN();
typedef void MVI;
typedef int EACHOOKCALLBACKFUNC();
typedef int arg_t;
typedef int boolean;
typedef int fixed88;
typedef int fixed824;
typedef int fixed248;

#endif
