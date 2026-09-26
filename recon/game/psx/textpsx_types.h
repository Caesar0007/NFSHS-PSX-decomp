/* textpsx.obj's exact source-visible type graph reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_TEXTPSX_TYPES_H
#define NFS4_GAME_PSX_TEXTPSX_TYPES_H

#define NFS4_PSYQ_WCHAR_TYPE u_long
#include "nfs4_types.h"
#undef NFS4_PSYQ_WCHAR_TYPE

#include "shared/coorddef.h"


typedef struct coorddef LIBCOORD;

#include "shared/linedef.h"


typedef struct linedef LINE;

#include "shared/SHAPETABLEENTRY.h"



typedef struct SHAPETABLEENTRY SHAPETABLEENTRY;

#include "shared/kernpair.h"




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
