/* game/psx/debug.h -- debug.obj's type environment.
 * The retail SYM block of debug.obj (73 type records) = the pad structs, the graphics/sys types of nfs4_types.h and the
 * font types (kernpair/KERN, font callback typedefs); no coorddef/linedef/SHAPETABLEENTRY and no EA scalar typedefs. */
#ifndef _GAME_PSX_DEBUG_H_
#define _GAME_PSX_DEBUG_H_
#define NFS4_CORE_PADS_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#include "nfs4_types.h"

#include "shared/PAD_PSX.h"
#include "shared/PAD_NEGCON.h"
#include "shared/PAD_ANALOG.h"
#include "shared/PAD_MOUSE.h"
#include "shared/PAD_COMMON.h"
#include "shared/kernpair.h"

typedef struct kernpair KERN;

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif /* _GAME_PSX_DEBUG_H_ */
