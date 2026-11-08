/* MinFront.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_MINFRONT_TYPES_H
#define NFS4_GAME_COMMON_MINFRONT_TYPES_H

#define NFS4_PADS_HOOK_AFTER "gamesetup_leaf_types.h"   /* retail minfront.obj: GameSetup records right after PAD_COMMON */
#include "color_types.h"

enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
};

typedef int Input_tDeviceCall();

#endif
