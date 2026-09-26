/* Shared font/PsyQ type surface proved by textpix.obj and textpsx.obj. */
#ifndef NFS4_GAME_PSX_FONT_TYPES_H
#define NFS4_GAME_PSX_FONT_TYPES_H

#define NFS4_PSYQ_WCHAR_TYPE u_long
#include "nfs4_types.h"
#undef NFS4_PSYQ_WCHAR_TYPE

#include "shared/kernpair.h"




typedef struct kernpair KERN;

#include "shared/charactertbl.h"





typedef struct charactertbl FONTFILECHAR;

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif
