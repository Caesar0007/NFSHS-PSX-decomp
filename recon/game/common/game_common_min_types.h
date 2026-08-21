/* Minimal common-game include surface proved identically by new.obj and
 * paths.obj.  This preserves their retail debug graph without exposing the
 * unrelated declarations in nfs4_types.h. */
#ifndef NFS4_GAME_COMMON_MIN_TYPES_H
#define NFS4_GAME_COMMON_MIN_TYPES_H

#include "../../frontend/psx/ea_psx_types.h"

struct coorddef {
    int x, y, z;
};
typedef struct coorddef LIBCOORD;

struct linedef {
    int start, end, colour, thickness;
};
typedef struct linedef LINE;

struct SHAPETABLEENTRY {
    char id[4];
    long offset;
};

struct PAD_PSX {
    u_short state;
    u_short unused[2];
};

struct PAD_NEGCON {
    u_char state : 4;
    u_char start : 4;
    u_char buttonAB : 4;
    u_char rightshift : 4;
    u_char twist, buttonI, buttonII, leftshift;
};

struct PAD_ANALOG {
    u_short state;
    u_char rightx, righty, leftx, lefty;
};

struct PAD_MOUSE {
    u_char unused, state;
    char horizontalvalue, verticalvalue;
    u_char unused2[2];
};

struct PAD_COMMON {
    u_char nopad, ID;
    union {
        PAD_PSX standard;
        PAD_NEGCON negcon;
        PAD_MOUSE mouse;
        PAD_ANALOG analog;
    } data;
};

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
