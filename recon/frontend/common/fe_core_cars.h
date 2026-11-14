/* frontend/common/fe_core_cars.h -- the car-manager tail of fe_core_types.h (tCarModels .. tfrontEnd).  A separate
 * piece only so that the ScreenDisplay graph can place it after its screen records (retail type order). */
#ifndef NFS4_FRONTEND_COMMON_FE_CORE_CARS_H
#define NFS4_FRONTEND_COMMON_FE_CORE_CARS_H

#ifndef NFS4_FE_CORE_NO_CAR_TYPES
#include "shared/tCarModels.h"




















#include "shared/tCarInfo.h"
#include "shared/tOwnedCarInfo.h"
#ifdef NFS4_FE_CORE_CARS_SAVEINFO   /* retail FEMemcard: tSaveCarInfo right after tOwnedCarInfo */
#include "shared/tSaveCarInfo.h"
#endif
#ifdef NFS4_FE_CORE_CARS_CLASSTYPE   /* retail: tCarClassType right after tOwnedCarInfo */
#include "shared/tCarClassType.h"
#endif
#ifdef NFS4_FE_CORE_CARS_HOOK_AFTER_OWNED   /* owner hook: records after tOwnedCarInfo/tSaveCarInfo/tCarClassType (fecars: tCarListType) */
#define NFS4_FE_CORE_CARS_IN_HOOK
#include NFS4_FE_CORE_CARS_HOOK_AFTER_OWNED
#undef NFS4_FE_CORE_CARS_IN_HOOK
#endif

#include "shared/tCarNameLength.h"




#ifdef NFS4_FE_CORE_CARS_HOOK_BEFORE_MANAGER   /* owner hook: between tCarNameLength and tCarManager (retail ScreenCarSelect: tCarStatType) */
#define NFS4_FE_CORE_CARS_IN_HOOK
#include NFS4_FE_CORE_CARS_HOOK_BEFORE_MANAGER
#undef NFS4_FE_CORE_CARS_IN_HOOK
#endif

#include "fecars_manager.h"   /* class tCarManager: one definition (header-truth 4k) */

































































#ifdef NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER   /* owner hook: right after tCarManager (retail: tListIteratorCar, tListIteratorCarColor) */
#define NFS4_FE_CORE_CARS_IN_HOOK
#include NFS4_FE_CORE_CARS_HOOK_AFTER_MANAGER
#undef NFS4_FE_CORE_CARS_IN_HOOK
#endif

#include "../../game/common/gamesetup_leaf_types.h"   /* retail: GameSetup after tCarManager */

#include "shared/tPersonalities.h"







#ifdef NFS4_FE_CORE_CARS_LINEUP   /* retail: tCarLineup right after tPersonalities, before tfrontEnd */
#include "shared/tCarLineup.h"
#endif
#include "shared/tfrontEnd.h"
#endif

#endif
