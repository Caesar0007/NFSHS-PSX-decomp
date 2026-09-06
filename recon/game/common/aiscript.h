/* game/common/aiscript.h — reconstructed from game/common/aiscript.cpp (8 fns) */
#ifndef _GAME_COMMON_AISCRIPT_H_
#define _GAME_COMMON_AISCRIPT_H_
#include "../../nfs4_types.h"

/* P875: verified source-level free names/signatures; the C++ compiler supplies
   native GCC-v2 linkage names. File-local STAT helpers stay in their .cpp. */

void AIScript_Assign(AIScript_t *script, AIScript_tReactionDetails (*data)[7]);   /* :6 */
void AIScript_ClearLastReactionIndex(AIScript_t *script);   /* :11 */
void AIScript_Startup(AIScript_t *script);   /* :18 */
void AIScript_Cleanup(void);   /* :27 */
void AIScript_SubmitPlayerAction(AIScript_t *script, int humCarIndex, AIScript_tPlayAction playerAction, int currentTime64);   /* :31 */
void AIScript_ProcessActionsAndReactions(AIScript_t *script, int elapsedTicks);   /* :55 */
int AIScript_DoReAction(AIScript_t *script, AIScript_tAIReaction testReaction);   /* :149 */
int AIScript_GetReactionTicksLeft(AIScript_t *script);   /* :157 */

#endif /* _GAME_COMMON_AISCRIPT_H_ */
