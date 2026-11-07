/* frontend/psx/cache.h -- cache.obj's type environment (C translation unit: STRTAG shapetbl/coorddef/scoorddef/linedef
 * carry no implicit C++ TPDEF in retail).  Retail cache.obj SYM block (60 type records): the graphics/sys types of the
 * older EA/PsyQ header revision (NFS4_EAC_OLD_TYPES: no CD stream, MEMBLOCK, no wchar_t/file/thread typedefs), ARGB,
 * coorddef/LIBCOORD, scoorddef/SCOORD, linedef/LINE, SHAPETABLEENTRY, RPOINT and the EA scalar typedefs (va_list is
 * PTR UCHAR here).  Member layouts of ARGB/scoorddef/RPOINT from the retail SYM (only cache.obj records them). */
#ifndef _FRONTEND_PSX_CACHE_H_
#define _FRONTEND_PSX_CACHE_H_

#define NFS4_EAC_OLD_TYPES
#include "nfs4_types.h"
#undef NFS4_EAC_OLD_TYPES

typedef struct ARGB {
    u_char b, g, r, a;
} ARGB;

#include "shared/coorddef.h"

typedef struct coorddef LIBCOORD;

struct scoorddef {
    int x, y;
};
typedef struct scoorddef SCOORD;

#include "shared/linedef.h"

typedef struct linedef LINE;

#include "shared/SHAPETABLEENTRY.h"

typedef struct SHAPETABLEENTRY SHAPETABLEENTRY;

typedef struct RPOINT {
    SCOORD uv;
    LIBCOORD xyz;
    SCOORD xy;
    int light;
    ARGB fog;
} RPOINT;

typedef char *va_list;
typedef int INTFN();
typedef void MVI;
typedef int EACHOOKCALLBACKFUNC();
typedef int arg_t;

#endif
