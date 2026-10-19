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
}

/* ---- AIScript_ClearLastReactionIndex__FP10AIScript_t  [@0x8006f700] ---- */
void AIScript_ClearLastReactionIndex(AIScript_t *script)
{
  for (int initLoop = 0; initLoop < 7; initLoop++) {

    script->lastReactionIndex[initLoop] = -1;
  }
}

/* ---- AIScript_Startup__FP10AIScript_t  [@0x8006f724] ---- */
void AIScript_Startup(AIScript_t *script)
{
  script->actionIndex = 7;
  script->detectAction = 7;
  script->reaction = 1;
  AIScript_ClearLastReactionIndex(script);
  script->lastActionTime = 0;
}

/* ---- AIScript_Cleanup__Fv  [@0x8006f760] ---- */
void AIScript_Cleanup(void)
{
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
}

/* MATCH, retail-absent codegen carriers in this byte-PASS source basin:
 * reactionSeedMask: direct literal 1 adds one instruction, 47 diffs.
 * noActionIndex: direct literal 7 removes one instruction, 15 diffs.
 * reactionBitTwo: direct literal 2 retains 90 instructions, eight diffs.
 * reactionTable: direct (*scriptData) retains 90 instructions, 24 diffs.
 * storedReactionIndex: direct *lastReactionIndex moves one store, two diffs.
 * These semantic names are not claimed as literal EA spellings, nor do the
 * failed forms prove that distinct original source objects were required.
 * SOURCE REVIEW: the one-iteration do below still changes store scheduling;
 * it is not a recovered original loop. Removing it on the restored owners
 * changes compiler scheduling and has not passed the byte gate.
 *
 * 2026-10-19: the combined action/detection guard and real processing while
 * restore every supplied declaration's type/home/depth/full owner and all four
 * declaring regions. newReaction belongs beside go/lastReactionIndex, and
 * newTime belongs in the processing loop. No setup-value capture of the
 * initial actionIndex is needed. The five extra carriers above and complete
 * SLD attribution remain unresolved; native declaration CLEAN is not claimed.
 * The cached index precedes the reaction initialization; reactionSeedMask
 * currently preserves the latter store's shared constant value. */
/* ---- AIScript_ProcessActionsAndReactions__FP10AIScript_ti  [@0x8006f7f0] ---- */
void AIScript_ProcessActionsAndReactions(AIScript_t *script,int elapsedTicks)
{
  AIScript_tReactionDetails (*scriptData) [7];
  int reactionSeedMask;
  int noActionIndex;
  int reactionBitTwo;
  AIScript_tReactionDetails *reactionTable;
  unsigned int storedReactionIndex;

  scriptData = script->data;
  if (script->actionIndex == 7 && script->detectAction != 7) {
    int go;
    int *lastReactionIndex;
    AIScript_tAIReaction newReaction;
    go = 1;
    script->actionIndex = script->detectAction;
    script->actionHumCarIndex = script->detectHumCarIndex;
    script->detectAction = 7;
    script->reactionTicksLeft = 0;
    lastReactionIndex = script->lastReactionIndex + script->actionIndex;
    storedReactionIndex = *lastReactionIndex;
    reactionSeedMask = (script->reaction = 1);
    noActionIndex = 7;
    reactionBitTwo = 2;
    script->reactionIndex = storedReactionIndex;
    reactionTable = *scriptData;
    while (go != 0) {
      int newTime;
      if ((script->reactionIndex + 1 < 4) &&
          ((newReaction = reactionSeedMask << (unsigned char)reactionTable[script->actionIndex].reaction[script->reactionIndex + 1]) != reactionBitTwo)) {
        script->reactionIndex = script->reactionIndex + 1;
        do { *lastReactionIndex = *lastReactionIndex + 1; } while (0);
      }
      newReaction = reactionSeedMask << (unsigned char)reactionTable[script->actionIndex].reaction[script->reactionIndex];
      script->reaction = script->reaction | newReaction;
      newTime = (unsigned char)reactionTable[script->actionIndex].halfSeconds[script->reactionIndex];
      if (newTime != 0) {
        script->reactionTicksLeft = newTime << 4;
        go = 0;
      }
      if (script->reaction == reactionSeedMask) {
        script->actionIndex = noActionIndex;
        script->detectAction = noActionIndex;
      }
    }
  }
  if (script->actionIndex == 7) {
    return;
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
  int humCarIndex = -1;
  if ((script->actionIndex != 7) && ((testReaction & script->reaction) != 0)) {
    humCarIndex = script->actionHumCarIndex;
  } return humCarIndex;
}

/* ---- AIScript_GetReactionTicksLeft__FP10AIScript_t  [@0x8006f988] ---- */
int AIScript_GetReactionTicksLeft(AIScript_t *script)
{
  if (script->actionIndex != 7) {
    return script->reactionTicksLeft;
  }
  return 0;
}
