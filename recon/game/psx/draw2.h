/* game/psx/draw2.h -- Draw2.obj's type environment (C translation unit: retail records STRTAG shapetbl/coorddef/
 * linedef/cdstreamstruct/matrixtdef/TCB without the implicit C++ TPDEFs, and one TPDEF per typedef'd struct).
 * Graph = the draw-leaf graph + the PsyQ kernel structs TCB/EXEC/DIRENTRY. */
#ifndef _GAME_PSX_DRAW2_H_
#define _GAME_PSX_DRAW2_H_
#define NFS4_CORE_KERNEL_FIRST   /* retail: kernel/pad types ahead of the core (nfs4_types.h) */
#include "../common/draw_leaf_types.h"
typedef struct SHAPETABLEENTRY SHAPETABLEENTRY;   /* C: the SDK typedef (textpsx_types.h precedent) */
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#endif /* _GAME_PSX_DRAW2_H_ */
