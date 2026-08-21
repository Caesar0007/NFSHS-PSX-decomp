/* Shared font/PsyQ type surface proved by textpix.obj and textpsx.obj. */
#ifndef NFS4_GAME_PSX_FONT_TYPES_H
#define NFS4_GAME_PSX_FONT_TYPES_H

#define NFS4_PSYQ_WCHAR_TYPE u_long
#include "../../frontend/psx/ea_psx_types.h"
#undef NFS4_PSYQ_WCHAR_TYPE

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef struct kernpair KERN;

struct charactertbl {
    u_char index[2];
    u_char width, height;
    u_char u[2], v[2];
    char advance, xoffset, yoffset;
};
typedef struct charactertbl FONTFILECHAR;

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
