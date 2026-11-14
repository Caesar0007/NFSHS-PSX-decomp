/* control.obj's exact source-visible delta over the shared color graph. */
#ifndef NFS4_GAME_COMMON_CONTROL_TYPES_H
#define NFS4_GAME_COMMON_CONTROL_TYPES_H
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "color_types.h"

#include "shared/Sched_tSchedule.h"

/* Retail does not emit these aggregate bodies in control.obj.
 * Keep the canonical cross-TU identities opaque in this consumer. */
struct Sim_tSimGlobalVar;
struct GameSetup_tData;




#include "shared/forceFocus_t.h"





#include "shared/SNDSYSCAP.h"






#include "shared/SNDSYSSET.h"







#include "shared/SNDSYSVEC.h"



#include "shared/SNDSAMPLEFORMAT.h"




typedef int CarLogic_tObservations[1][3];
typedef int Input_tDeviceCall();

#endif
