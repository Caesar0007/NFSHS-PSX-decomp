/* Diagnostic: complete corrected public header, exact typed address references. */
#include "C:/Temp/nfs4-decomp/recon/game/common/aiscript.h"

void (*p875_after_0)(AIScript_t *script, AIScript_tReactionDetails (*data)[7]) = &AIScript_Assign;
void (*p875_after_1)(AIScript_t *script) = &AIScript_ClearLastReactionIndex;
void (*p875_after_2)(AIScript_t *script) = &AIScript_Startup;
void (*p875_after_3)(void) = &AIScript_Cleanup;
void (*p875_after_4)(AIScript_t *script, int humCarIndex, AIScript_tPlayAction playerAction, int currentTime64) = &AIScript_SubmitPlayerAction;
void (*p875_after_5)(AIScript_t *script, int elapsedTicks) = &AIScript_ProcessActionsAndReactions;
int (*p875_after_6)(AIScript_t *script, AIScript_tAIReaction testReaction) = &AIScript_DoReAction;
int (*p875_after_7)(AIScript_t *script) = &AIScript_GetReactionTicksLeft;
