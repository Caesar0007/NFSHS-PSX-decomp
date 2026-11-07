/* game/psx/profile.h -- profile.obj's type environment.
 * The retail SYM block of profile.obj (85 type records) = the PsyQ kernel structs TCB/EXEC/DIRENTRY, the pad structs,
 * the graphics/sys types of nfs4_types.h, coorddef/LIBCOORD, linedef/LINE, SHAPETABLEENTRY and the EA scalar typedefs
 * va_list..arg_t (the common game core of paths.obj without its trailing boolean/fixed* typedefs and anonymous struct). */
#ifndef _GAME_PSX_PROFILE_H_
#define _GAME_PSX_PROFILE_H_
#define NFS4_CORE_KERNEL_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#include "nfs4_types.h"

#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"

#include "shared/coorddef.h"

typedef struct coorddef LIBCOORD;

#include "shared/linedef.h"

typedef struct linedef LINE;

#include "shared/SHAPETABLEENTRY.h"
#include "shared/PAD_PSX.h"
#include "shared/PAD_NEGCON.h"
#include "shared/PAD_ANALOG.h"
#include "shared/PAD_MOUSE.h"
#include "shared/PAD_COMMON.h"

typedef void *va_list;
typedef int INTFN();
typedef void MVI;
typedef int EACHOOKCALLBACKFUNC();
typedef int arg_t;

#endif
