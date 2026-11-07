/* game/psx/nfs2mem.h -- nfs2mem.obj's type environment.
 * The retail SYM block of nfs2mem.obj (129 type records) is the draw-leaf graph (as in felines.obj, without
 * tTexture_ShapeInfo) plus the font types (kernpair/KERN, font callback typedefs) and the PsyQ kernel structs
 * TCB/EXEC/DIRENTRY. */
#ifndef _GAME_PSX_NFS2MEM_H_
#define _GAME_PSX_NFS2MEM_H_

#include "../common/draw_leaf_types.h"
#include "shared/kernpair.h"

typedef struct kernpair KERN;

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"

#endif
