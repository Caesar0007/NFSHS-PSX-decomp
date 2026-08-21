/* Textsys.obj's exact source-visible type surface.  The retail SYM graph is
 * the minimal game/common platform graph plus the font kerning declarations
 * and callback typedefs used by the original text headers. */
#ifndef NFS4_GAME_COMMON_TEXTSYS_TYPES_H
#define NFS4_GAME_COMMON_TEXTSYS_TYPES_H

#include "game_common_min_types.h"

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef struct kernpair KERN;

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
