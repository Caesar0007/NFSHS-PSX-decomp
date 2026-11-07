#ifndef NFS4_GAME_PSX_DEVICE_TYPES_H
#define NFS4_GAME_PSX_DEVICE_TYPES_H   /* device.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */

/* device.obj shares gmesetup.obj's frontend surface but not the completed
 * GameSetup_tData or FEI_tList owner records. */
#define NFS4_GMESETUP_OMIT_OWNER_RECORDS
#include "../common/gmesetup_types.h"
#undef NFS4_GMESETUP_OMIT_OWNER_RECORDS

#include "shared/Input_tDeviceList.h"





/* GameSetup_tData: not in retail device.obj (GameSetup_gData is read through its word view) */
















#include "shared/Sim_tSimSystemVar.h"




#include "shared/Sched_tSchedule.h"




#include "shared/tPadModuleState.h"







#endif
