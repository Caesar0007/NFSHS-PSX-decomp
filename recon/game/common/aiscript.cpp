/* game/common/aiscript.cpp -- RECONSTRUCTED (NFS4 AI action/reaction scripting; 8 free AIScript_* fns).
 *   Player-action submission + reaction-table processing. SYM-v3 locals; vs disasm-v2.txt.
 *   NOT original source; SYM-faithful, recompilable C++.
 */
#include "aiscript_types.h"


/* ---- intra-TU forward declarations ---- */
void AIScript_Assign(AIScript_t *script,AIScript_tReactionDetails (*data) [7]);
void AIScript_ClearLastReactionIndex(AIScript_t *script);
void AIScript_Startup(AIScript_t *script);
void AIScript_Cleanup(void);
void AIScript_ProcessActionsAndReactions(AIScript_t *script,int elapsedTicks);
int AIScript_DoReAction(AIScript_t *script,AIScript_tAIReaction testReaction);
int AIScript_GetReactionTicksLeft(AIScript_t *script);


/* ---- AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails  [@0x8006f6f8] ---- */
void AIScript_Assign(AIScript_t *script,AIScript_tReactionDetails (*data) [7])
{
  script->data = data;
  return;
}

/* ---- AIScript_ClearLastReactionIndex__FP10AIScript_t  [@0x8006f700] ---- */
void AIScript_ClearLastReactionIndex(AIScript_t *script)
{
  int initLoop;
  /* SYM-CODEGEN-CARRIER: neg1 -- absent from the surviving outer-local
   * records. A literal or const local preserves the 9-insn body but schedules
   * `li $v1,-1` after `li $v0,6` (2 diffs); a mutable scalar reproduces the
   * retail constant order exactly. */
  int neg1;

  neg1 = -1;
  initLoop = 6;
  do {
    script->lastReactionIndex[initLoop] = neg1;
    initLoop = initLoop + -1;
  } while (-1 < initLoop);
  return;
}

/* ---- AIScript_Startup__FP10AIScript_t  [@0x8006f724] ---- */
void AIScript_Startup(AIScript_t *script)
{
  script->actionIndex = 7;
  script->detectAction = 7;
  script->reaction = 1;
  AIScript_ClearLastReactionIndex(script);
  script->lastActionTime = 0;
  return;
}

/* ---- AIScript_Cleanup__Fv  [@0x8006f760] ---- */
void AIScript_Cleanup(void)
{
  return;
}

/* ---- AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni  [@0x8006f768] ---- */
void AIScript_SubmitPlayerAction(AIScript_t *script,int humCarIndex,AIScript_tPlayAction playerAction,
               int currentTime64)
{
  if (script->lastActionTime < currentTime64 + -0x500) {
    AIScript_ClearLastReactionIndex(script);
  }
  script->lastActionTime = currentTime64;
  if ((script->actionIndex == 7) && ((int)playerAction < (int)script->detectAction)) {
    script->detectAction = playerAction;
    script->detectHumCarIndex = humCarIndex;
  }
  return;
}

/* ---- AIScript_ProcessActionsAndReactions__FP10AIScript_ti  [@0x8006f7f0] ---- */
void AIScript_ProcessActionsAndReactions(AIScript_t *script,int elapsedTicks)
{
  AIScript_tReactionDetails (*scriptData) [7];
  int go;
  /* SYM-CODEGEN-CARRIER: one -- direct literal 1 usage adds one instruction
     and changes constant/table allocation to 47 diffs. */
  int one;
  /* SYM-CODEGEN-CARRIER: seven -- direct literal 7 stores remove one
     instruction and change constant allocation/control flow to 15 diffs. */
  int seven;
  /* SYM-CODEGEN-CARRIER: two -- direct literal 2 preserves 90 instructions
     but changes shift selection and comparison allocation to eight diffs. */
  int two;
  int *lastReactionIndex;
  /* SYM-CODEGEN-CARRIER: new_var2 -- spelling (*scriptData) directly preserves
     90 instructions but changes table-base/constant allocation to 24 diffs. */
  AIScript_tReactionDetails *new_var2;
  /* SYM-CODEGEN-CARRIER: new_var -- assigning *lastReactionIndex directly
     preserves all 90 instructions but moves one store, yielding two diffs. */
  unsigned int new_var;
  AIScript_tAIReaction newReaction;
  int newTime;

  scriptData = script->data;
  if ((newReaction = script->actionIndex) == 7) {   /* cache actionIndex for the compares */
    go = 1;
    if (script->detectAction != 7) {
      script->actionIndex = script->detectAction;
      script->actionHumCarIndex = script->detectHumCarIndex;
      script->detectAction = 7;
      script->reactionTicksLeft = 0;
      lastReactionIndex = script->lastReactionIndex + script->actionIndex;
      new_var = *lastReactionIndex;   /* load cached early (oracle order) */
      one = (script->reaction = 1);   /* reuse the stored 1 (oracle's move t2,t1) */
      seven = 7;
      two = 2;
      script->reactionIndex = new_var;
      new_var2 = *scriptData;
     loopTop:
      if (go != 0) {
        if ((script->reactionIndex + 1 < 4) &&
           ((newReaction = one << (unsigned char)new_var2[script->actionIndex].reaction[script->reactionIndex + 1]) != two)) {
          script->reactionIndex = script->reactionIndex + 1;
          do { *lastReactionIndex = *lastReactionIndex + 1; } while (0);  /* block scope nudges gcc's store scheduling to match */
        }
        newReaction = one << (unsigned char)new_var2[script->actionIndex].reaction[script->reactionIndex];
        script->reaction = script->reaction | newReaction;
        newTime = (unsigned char)new_var2[script->actionIndex].halfSeconds[script->reactionIndex];
        if (newTime != 0) {
          script->reactionTicksLeft = newTime << 4;
          go = 0;
        }
        if (script->reaction == one) {
          script->actionIndex = seven;
          script->detectAction = seven;
        }
        goto loopTop;
      }
    }
    if (script->actionIndex == 7) {
      return;
    }
  }
  if (script->reactionTicksLeft <= 0) {
    script->actionIndex = 7;
    script->detectAction = 7;
    return;
  }
  script->reactionTicksLeft = script->reactionTicksLeft - elapsedTicks;
  return;
}

/* ---- AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction  [@0x8006f958] ---- */
int AIScript_DoReAction(AIScript_t *script,AIScript_tAIReaction testReaction)
{
  int humCarIndex;

  humCarIndex = -1;
  if ((script->actionIndex != 7) && ((testReaction & script->reaction) != 0)) {
    humCarIndex = script->actionHumCarIndex;
  }
  return humCarIndex;
}

/* ---- AIScript_GetReactionTicksLeft__FP10AIScript_t  [@0x8006f988] ---- */
int AIScript_GetReactionTicksLeft(AIScript_t *script)
{
  if (script->actionIndex != 7) {
    return script->reactionTicksLeft;
  }
  return 0;
}
