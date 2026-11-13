/* game/common/aispeech.h -- aispeech.obj's type environment.
 * The retail SYM block of aispeech.obj (238 type records) is AITUNE.obj's block without AITUNE's own tuning types
 * (accelscale_t, copTuning_t, AITune_tTrackInfo, AITune_BTC_t): the shared colour/car graph, Sched_tSchedule and the
 * CarLogic_tObservations array typedef.  Retail records Group three times (two inline members): the type-only owner
 * sees only the declaration of Group's count setter (aidebug.h precedent). */
#ifndef _GAME_COMMON_AISPEECH_H_
#define _GAME_COMMON_AISPEECH_H_
#define NFS4_COLOR_GS_AFTER_BO   /* retail type order (game/common/color_types.h) */
#define NFS4_COLOR_SCHED_SCHEDULE   /* retail type order (game/common/color_types.h) */
#include "color_types.h"
#include "shared/Sched_tSchedule.h"

typedef int CarLogic_tObservations[1][3];

#endif /* _GAME_COMMON_AISPEECH_H_ */
