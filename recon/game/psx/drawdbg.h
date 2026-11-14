/* game/psx/drawdbg.h -- DrawDbg.obj's type environment.
 * The retail SYM block of DrawDbg.obj (249 type records) is the shared colour/car graph (aispeech.obj's block without
 * Sched_tSchedule / CarLogic_tObservations) plus the PsyQ kernel structs TCB/EXEC/DIRENTRY and the font types
 * (kernpair/KERN and the font callback typedefs).  Retail records Group three times (two inline members): the
 * type-only owner sees only the declaration of Group's count setter (aidebug.h precedent).  u_long (gSavePtr) comes
 * from nfs4_types.h through this graph. */
#ifndef _GAME_PSX_DRAWDBG_H_
#define _GAME_PSX_DRAWDBG_H_
#define NFS4_CORE_HOOK_AFTER_DRMODE "game/psx/drawdbg_early.h"
#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#include "../common/draw_leaf_core.h"
#if !defined(NFS4_DRAW_LEAF_CORE_ONLY) && !defined(NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H)   /* this object lists the draw leaf itself (retail record order) */
#define NFS4_GAME_COMMON_DRAW_LEAF_PHASE2_H
#include "../common/draw_leaf_a_pads.h"
#undef NFS4_CORE_CCOORD16
#include "../common/draw_leaf_b_pixmap.h"
#include "../common/draw_leaf_c_cache.h"
#include "../common/draw_leaf_d_carvertex.h"
#include "shared/kernpair.h"   /* own types at this point */
#endif
#include "../common/color_types.h"
#include "shared/TCB.h"
#include "shared/EXEC.h"
#include "shared/DIRENTRY.h"
#include "shared/kernpair.h"

typedef struct kernpair KERN;

typedef void (*fontblit)();
typedef int (*getcode)();
typedef void (*fontblitbegin)();
typedef void (*fontblitend)();
typedef void (*adjustchar)();

#endif /* _GAME_PSX_DRAWDBG_H_ */
