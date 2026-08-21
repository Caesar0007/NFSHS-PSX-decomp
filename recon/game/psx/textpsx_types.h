/* textpsx.obj's exact source-visible type graph reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_TEXTPSX_TYPES_H
#define NFS4_GAME_PSX_TEXTPSX_TYPES_H

#define NFS4_PSYQ_WCHAR_TYPE u_long
#include "../../frontend/psx/ea_psx_types.h"
#undef NFS4_PSYQ_WCHAR_TYPE

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
typedef struct SHAPETABLEENTRY SHAPETABLEENTRY;

struct kernpair {
    u_short previouscode, code;
    char kernvalue;
    char pad[3];
};
typedef struct kernpair KERN;

typedef void *va_list;
typedef int INTFN();
typedef void MVI;
typedef int EACHOOKCALLBACKFUNC();
typedef int arg_t;
typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
