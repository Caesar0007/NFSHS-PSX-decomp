#if !defined(NFS4_GAME_PSX_DEVICE_TYPES_H)
#define NFS4_GAME_PSX_DEVICE_TYPES_H   /* device.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#define NFS4_CORE_HOOK_AFTER_CD "game/psx/device_types.h"   /* retail device.obj: scheduler types right after the CD stream */
#define NFS4_CORE_HOOK_AFTER_PADS "shared/Input_tDeviceList.h"   /* retail: Input_tDeviceList right after the early PAD_COMMON (nfs4_types.h) */

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







#elif !defined(NFS4_DEVICE_CD_DONE)   /* second pass: nfs4_types.h NFS4_CORE_HOOK_AFTER_CD */
#define NFS4_DEVICE_CD_DONE
typedef void (*Sched_tFunctionPt)(void *);
#include "shared/Sched_tFunctionSchedule.h"
#include "shared/Sched_tSchedule.h"
#define NFS4_COLOR_SCHED_DONE
#endif
