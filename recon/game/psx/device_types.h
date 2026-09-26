/* device.obj's exact source-visible type surface reconstructed from SYM. */
#ifndef NFS4_GAME_PSX_DEVICE_TYPES_H
#define NFS4_GAME_PSX_DEVICE_TYPES_H

/* device.obj shares gmesetup.obj's frontend surface but not the completed
 * GameSetup_tData or FEI_tList owner records. */
#define NFS4_GMESETUP_OMIT_OWNER_RECORDS
#include "../common/gmesetup_types.h"
#undef NFS4_GMESETUP_OMIT_OWNER_RECORDS

#include "shared/Input_tDeviceList.h"





#include "shared/GameSetup_tData.h"
















#include "shared/Sim_tSimSystemVar.h"




#include "shared/Sched_tSchedule.h"




#include "shared/tPadModuleState.h"







#endif
