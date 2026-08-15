/* game/common/aispeech.h -- header for the type-only aispeech translation unit.
 * aispeech.obj contributes no code/data; it only pulls in the AI-speech type set
 * (AISpeechInfo_t + speechModeType/speechIntensityType/speechSourceType), all of which
 * live in nfs4_types.h. This header exists only so aispeech.cpp has a sibling include
 * (matching the project's per-TU header convention). */
#ifndef _GAME_COMMON_AISPEECH_H_
#define _GAME_COMMON_AISPEECH_H_
#include "../../nfs4_types.h"
#endif /* _GAME_COMMON_AISPEECH_H_ */
