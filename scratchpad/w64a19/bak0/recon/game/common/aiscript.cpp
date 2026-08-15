/* game/common/aiscript.cpp -- RECONSTRUCTED (NFS4 AI action/reaction scripting; 8 free AIScript_* fns).
 *   Player-action submission + reaction-table processing. SYM-v3 locals; vs disasm-v2.txt.
 *   NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "aiscript_externs.h"


/* ---- intra-TU forward declarations ---- */
void AIScript_Assign(AIScript_t *aiscriptt,AIScript_tReactionDetails (*arg2) [7]);
void AIScript_ClearLastReactionIndex(AIScript_t *script);
void AIScript_Startup(AIScript_t *script);
void AIScript_Cleanup(void);
void AIScript_ProcessActionsAndReactions(AIScript_t *script,int elapsedTicks);
int AIScript_DoReAction(AIScript_t *script,AIScript_tAIReaction testReaction);
int AIScript_GetReactionTicksLeft(AIScript_t *script);


/* ---- AIScript_Assign__FP10AIScript_tPA7_25AIScript_tReactionDetails  [@0x8006f6f8] ---- */
void AIScript_Assign(AIScript_t *aiscriptt,AIScript_tReactionDetails (*arg2) [7])
{
  aiscriptt->data = arg2;
  return;
}

/* ---- AIScript_ClearLastReactionIndex__FP10AIScript_t  [@0x8006f700] ---- */
void AIScript_ClearLastReactionIndex(AIScript_t *script)
{
  int iVar1;
  AIScript_tAIReaction *pAVar2;
  int neg1;

  neg1 = -1;
  iVar1 = 6;
  pAVar2 = (AIScript_tAIReaction *)&script->reactionTicksLeft;
  do {
    pAVar2[8] = neg1;
    iVar1 = iVar1 + -1;
    pAVar2 = pAVar2 + -1;
  } while (-1 < iVar1);
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
  int one;
  int seven;
  int two;
  int *lastReactionIndex;
  AIScript_tReactionDetails *new_var2;   /* *scriptData hoisted once -> lets gcc color the table base + offset like the oracle */
  unsigned int new_var;
  int iVar2;
  int newReaction;
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
      new_var2 = *scriptData;   /* dereference once */
     loopTop:
      if (go != 0) {
        iVar2 = script->reactionIndex + 1;
        if ((iVar2 < 4) &&
           ((newReaction = one << (u_char)new_var2[script->actionIndex].reaction[iVar2]) != two)) {
          script->reactionIndex = iVar2;
          do { *lastReactionIndex = *lastReactionIndex + 1; } while (0);  /* block scope nudges gcc's store scheduling to match */
        }
        newReaction = one << (u_char)new_var2[script->actionIndex].reaction[script->reactionIndex];
        script->reaction = script->reaction | newReaction;
        newTime = (u_char)new_var2[script->actionIndex].halfSeconds[script->reactionIndex];
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
  int iVar1;
  
  iVar1 = -1;
  if ((script->actionIndex != 7) && ((testReaction & script->reaction) != 0)) {
    iVar1 = script->actionHumCarIndex;
  }
  return iVar1;
}

/* ---- AIScript_GetReactionTicksLeft__FP10AIScript_t  [@0x8006f988] ---- */
int AIScript_GetReactionTicksLeft(AIScript_t *script)
{
  if (script->actionIndex != 7) {
    return script->reactionTicksLeft;
  }
  return 0;
}
