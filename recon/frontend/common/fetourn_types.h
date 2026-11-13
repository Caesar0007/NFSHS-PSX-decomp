/* Owner-specific type surface for FETourn.obj. */
#ifndef NFS4_FRONTEND_COMMON_FETOURN_TYPES_H
#define NFS4_FRONTEND_COMMON_FETOURN_TYPES_H
#define NFS4_FE_CORE_CARS_CLASSTYPE   /* retail FETourn: tCarClassType right after tOwnedCarInfo */
#ifndef NFS4_FE_COLOR_LATE   /* The retail owner contains color.obj's complete 71-record graph. */
#include "../../game/common/color_types.h"
#endif
#define NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup right after tPersonalities */
#define NFS4_FE_CORE_CARS_HOOK_MANAGER "fetourn_carmanager.h"   /* FETourn spells its own tCarManager (moved verbatim), at the retail place */
#define NFS4_FE_TRACK_HOOK_AFTER_MANAGER "fetourn_trophysize.h"   /* retail: tTrophySize right after tTrackManager */
#include "fe_core_types.h"
/* FETourn's real tCarManager follows below */

/* FETourn retains tListIteratorIndexed's layout but not the foreign tPlayer
 * enum or its method declarations. */
#define NFS4_FE_TRACK_NO_PLAYER
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER

/* Source spellings/constants that do not create retail type records. */
#define byte unsigned char
#define uchar unsigned char
#define uint unsigned int
/* (2026-09-19) the `#define tPlayer int` spelling is gone: with real virtuals the overrides below must have the SAME
 * parameter type as tListIterator's virtuals, or they overload instead of overriding (retail's vtable has the overrides). */
#define NULL 0
#define Tourn_StartMoney 20000
#define Tourn_RacersCount 6
#define Tourn_TRN_HeaderSize 0x6
#define Tourn_TRN_EntriesStart 0x7
#include "fecheats_cheatcode.h"   /* the real tCheatCode enum (was a macro fake; header-truth 4-C.2) */







#include "shared/tSaveTournament.h"
/* The linked FETourn SYM retains this public array typedef while attributing
 * the already-defined element tag body to its earlier owner. */
#include "shared/tRecordBuffer.h"


typedef tRecordBuffer tSaveRecords[187];





















#include "fetourn_manager_class.h"   /* class tTournamentManager: one definition (header-truth 4l) */















































#include "felist_tournament_iter.h"   /* tListIteratorTournament: one definition (header-truth 4s) */











#endif
