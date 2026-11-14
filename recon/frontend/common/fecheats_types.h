/* Owner-specific type surface for FECheats.obj. */
#ifndef NFS4_FRONTEND_COMMON_FECHEATS_TYPES_H
#define NFS4_FRONTEND_COMMON_FECHEATS_TYPES_H

#ifndef NFS4_FECHEATS_NO_CHEAT_RECORDS
#include "fecheats_cheatcode.h"

































#endif

#ifndef NFS4_FE_COLOR_LATE   /* The retail owner contains color.obj's complete physics/AI/car graph. */
#include "../../game/common/color_types.h"
#endif
#if !defined(NFS4_FE_CORE_CARS_CLASSTYPE) && !defined(NFS4_TCARCLASSTYPE_DEFINED)   /* FEMemcard: tCarClassType from fe_core_cars.h instead */
#define NFS4_TCARCLASSTYPE_DEFINED
#include "shared/tCarClassType.h"





#endif

/* FECheats retains the input enum but not the foreign tPlayer enum. */
#define NFS4_FE_INPUT_NO_PLAYER
#include "fe_input_enums.h"
#undef NFS4_FE_INPUT_NO_PLAYER

/* Add only the one car-manager member used by this owner. */
#define NFS4_FE_TRACK_NO_PLAYER
#ifdef NFS4_FECHEATS_OWNER   /* enter the fe_core graph here, so fe_core_cars.h's owner hook expands the track records after tCarManager */
#include "fe_core_types.h"
#endif
#include "fe_tournament_types.h"
#undef NFS4_FE_TRACK_NO_PLAYER

#include "fetourn_manager_class.h"   /* class tTournamentManager: one definition (header-truth 4l) */

















#ifndef NFS4_FECHEATS_DIALOGS_LATE   /* FEMemcard: dialog/app block after its memcard records */
#include "fecheats_dialogs.h"
#endif




























/* The owner retains tSaveRecords but attributes this already-seen element tag
 * body elsewhere in the linked SYM.  The canonical audit pair-locks both. */
#ifndef NFS4_FECHEATS_NO_RECORD_BUFFER
#include "shared/tRecordBuffer.h"
typedef tRecordBuffer tSaveRecords[187];
#endif

#if !defined(NFS4_FECHEATS_NO_CHEAT_RECORDS) && !defined(NFS4_FECHEATS_TCHEAT_IN_CPP)
struct tCheat {
    u_char name[8];
    tCheatCode cheat;
};
#endif

#endif
