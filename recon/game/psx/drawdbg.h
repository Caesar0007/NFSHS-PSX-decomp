/* game/psx/drawdbg.h -- DrawDbg.obj's type environment.
 * The retail SYM block of DrawDbg.obj (249 type records) is the shared colour/car graph (aispeech.obj's block without
 * Sched_tSchedule / CarLogic_tObservations) plus the PsyQ kernel structs TCB/EXEC/DIRENTRY and the font types
 * (kernpair/KERN and the font callback typedefs).  Retail records Group three times (two inline members): the
 * type-only owner sees only the declaration of Group's count setter (aidebug.h precedent).  u_long (gSavePtr) comes
 * from nfs4_types.h through this graph. */
#ifndef _GAME_PSX_DRAWDBG_H_
#define _GAME_PSX_DRAWDBG_H_
#define NFS4_CORE_HOOK_AFTER_DRMODE "game/psx/drawdbg_early.h"
#define NFS4_DRAW_LEAF_HOOK_AFTER_CARVERTEX "shared/kernpair.h"   /* retail: kernpair right after Draw_CarVertex */
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
