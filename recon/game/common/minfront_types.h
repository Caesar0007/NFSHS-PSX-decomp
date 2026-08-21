/* MinFront.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_MINFRONT_TYPES_H
#define NFS4_GAME_COMMON_MINFRONT_TYPES_H

#include "color_types.h"

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0,
    FOCUS_AI = 1,
    FOCUS_COPANDAI = 2
} forceFocus_t;

typedef int Input_tDeviceCall();

#endif
