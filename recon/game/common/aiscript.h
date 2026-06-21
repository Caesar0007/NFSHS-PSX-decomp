/* game/common/aiscript.h — reconstructed from game/common/aiscript.cpp (8 fns) */
#ifndef _GAME_COMMON_AISCRIPT_H_
#define _GAME_COMMON_AISCRIPT_H_
#include "../../nfs4_types.h"

void AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails(AIScript_t *script, AIScript_tReactionDetails (*data)[7]);   /* :6 */
void AIScript_ClearLastReactionIndex__FP10AIScript_t(AIScript_t *script);   /* :11 */
void AIScript_Startup__FP10AIScript_t(AIScript_t *script);   /* :18 */
void AIScript_Cleanup__Fv(void);   /* :27 */
void AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni(AIScript_t *script, int humCarIndex, int playerAction, int currentTime64);   /* :31 */
void AIScript_ProcessActionsAndReactions__FP10AIScript_ti(AIScript_t *script, int elapsedTicks);   /* :55 */
int AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction(AIScript_t *script, int testReaction);   /* :149 */
int AIScript_GetReactionTicksLeft__FP10AIScript_t(AIScript_t *script);   /* :157 */

#endif /* _GAME_COMMON_AISCRIPT_H_ */
