#if !defined(NFS4_GAME_PSX_DEVICE_TYPES_H)
#define NFS4_GAME_PSX_DEVICE_TYPES_H   /* device.obj's exact source-visible type surface reconstructed from SYM. */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */

/* device.obj shares gmesetup.obj's frontend surface but not the completed
 * GameSetup_tData or FEI_tList owner records. */
#define NFS4_GMESETUP_OMIT_OWNER_RECORDS
#define NFS4_CORE_CCOORD16
#define NFS4_CORE_FULL
#define NFS4_CORE_EA
#define NFS4_TYPES_H   /* this object lists the root type graph itself (retail record order) */
#include "nfs4_core_0_kernel.h"
#include "shared/Input_tDeviceList.h"   /* own types at this point */
#include "nfs4_core_1_gpu.h"
#include "nfs4_core_2_shape.h"
#include "nfs4_core_3_cd.h"
#include "game/psx/device_types.h"   /* own types at this point */
#include "nfs4_core_4_tail.h"
#undef NFS4_CORE_EA
#undef NFS4_CORE_FULL
#undef NFS4_CORE_CCOORD16
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
