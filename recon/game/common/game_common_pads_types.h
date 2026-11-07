/* game/common/game_common_pads_types.h -- the controller-pad tail of game_common_min_types.h (PAD_* records, the
 * anonymous pad-timer struct and the EA scalar typedefs).  A separate piece only so that draw_leaf_types.h phase 2
 * can place it after a frontend screen graph (NFS4_DRAW_LEAF_CORE_ONLY, retail type order). */
#ifndef NFS4_GAME_COMMON_PADS_TYPES_H
#define NFS4_GAME_COMMON_PADS_TYPES_H

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
