/* MinFront.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_MINFRONT_TYPES_H
#define NFS4_GAME_COMMON_MINFRONT_TYPES_H

#define NFS4_CORE_CCOORD16   /* CCOORD16 right after COORD16 */
#define NFS4_CORE_FULL   /* this object lists the start of the core itself (retail record order) */
#define NFS4_GAME_COMMON_MIN_TYPES_H
#define NFS4_GAME_COMMON_PADS_TYPES_H
#include "game_common_min_core.h"
#include "pads_records.h"
#include "gamesetup_leaf_types.h"   /* own types at this point */
#include "pads_tail.h"
#undef NFS4_CORE_FULL
#undef NFS4_CORE_CCOORD16
#include "color_types.h"

#include "shared/forceFocus_t.h"





typedef int Input_tDeviceCall();

#endif
