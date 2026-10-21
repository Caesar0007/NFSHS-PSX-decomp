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
#line 5 "C:/nfs4/GAME/COMMON/AISCRIPT.CPP"
void AIScript_Assign(AIScript_t *script,AIScript_tReactionDetails (*data) [7])
{
  script->data = data;
}

/* ---- AIScript_ClearLastReactionIndex__FP10AIScript_t  [@0x8006f700] ---- */
#line 10 "C:/nfs4/GAME/COMMON/AISCRIPT.CPP"
void AIScript_ClearLastReactionIndex(AIScript_t *script)
{
  for (int initLoop = 0; initLoop < 7; initLoop++) {

    script->lastReactionIndex[initLoop] = -1;
  }
}

/* ---- AIScript_Startup__FP10AIScript_t  [@0x8006f724] ---- */
#line 17 "C:/nfs4/GAME/COMMON/AISCRIPT.CPP"
void AIScript_Startup(AIScript_t *script)
{
  script->actionIndex = 7;
  script->detectAction = 7;
  script->reaction = 1;
  AIScript_ClearLastReactionIndex(script);
  script->lastActionTime = 0;
}

/* ---- AIScript_Cleanup__Fv  [@0x8006f760] ---- */
#line 26 "C:/nfs4/GAME/COMMON/AISCRIPT.CPP"
void AIScript_Cleanup(void)
{
}

/* ---- AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni  [@0x8006f768] ---- */
#line 29 "C:/nfs4/GAME/COMMON/AISCRIPT.CPP"
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

/* Native source recovery, 2026-10-20: only supplied declarations remain.
 * The direct initial-index assignment precedes reaction initialization. Read
 * the actual scriptData array and use the supplied reaction/action enums,
 * removing all four former literal/table carriers together. Once those are
 * gone, an ordinary lastReactionIndex increment also removes the one-iteration
 * do wrapper with no byte change. Their individual failures were interactions,
 * not evidence of original source objects or a required synthetic loop.
 * Both whole normal ELF and native CPE are identical; every supplied local's
 * type/home/owner and all scope regions agree. Isolated controls and stock RTL
 * plus stock-target-equal GDB-only observations are preserved under
 * build/nc12/aiscript_table_source_20261020 (the standalone host is unstable).
 * Separate the real bounds check, flag producer and END test. Ordinary layout
 * then reproduces all absolute SLD tags, block lines and the function end:
 * combined native run-k3ppevh8, all8 AISCRIPT contracts exact. This does not
 * uniquely certify original literal text or every type-preamble record. */
/* ---- AIScript_ProcessActionsAndReactions__FP10AIScript_ti  [@0x8006f7f0] ---- */
#line 54 "C:/nfs4/GAME/COMMON/AISCRIPT.CPP"
void AIScript_ProcessActionsAndReactions(AIScript_t *script,int elapsedTicks)
{
  AIScript_tReactionDetails (*scriptData) [7];

  scriptData = script->data;


  if (script->actionIndex == 7 && script->detectAction != 7)
  { int go;
    int *lastReactionIndex;
    AIScript_tAIReaction newReaction;
    go = 1;




    script->actionIndex = script->detectAction;
    script->actionHumCarIndex = script->detectHumCarIndex;
    script->detectAction = 7;
    script->reactionTicksLeft = 0;

    lastReactionIndex = script->lastReactionIndex + script->actionIndex;

    script->reactionIndex = *lastReactionIndex;

    script->reaction = AISCRIPT_AIREACTION_INIT;



    while (go != 0) {
      int newTime;




      if (script->reactionIndex + 1 < 4) {


        newReaction = AISCRIPT_AIREACTION_INIT << (unsigned char)(*scriptData)[script->actionIndex].reaction[script->reactionIndex + 1];


        if (newReaction != AISCRIPT_AIREACTION_END) {

          script->reactionIndex = script->reactionIndex + 1;
          *lastReactionIndex = *lastReactionIndex + 1;
        }
      }


      newReaction = AISCRIPT_AIREACTION_INIT << (unsigned char)(*scriptData)[script->actionIndex].reaction[script->reactionIndex];

      script->reaction = script->reaction | newReaction;
      newTime = (unsigned char)(*scriptData)[script->actionIndex].halfSeconds[script->reactionIndex];


      if (newTime != 0) {

        script->reactionTicksLeft = newTime << 4;
        go = 0;
      }

      if (script->reaction == AISCRIPT_AIREACTION_INIT) {

        script->actionIndex = AISCRIPT_PLAYACTION_SENTINAL;
        script->detectAction = AISCRIPT_PLAYACTION_SENTINAL;
      }
    }
  }


  if (script->actionIndex == 7) {
    return;
  }





  if (script->reactionTicksLeft <= 0) {




    script->actionIndex = 7; script->detectAction = 7;
    return;
  }



  script->reactionTicksLeft = script->reactionTicksLeft - elapsedTicks; return; }

/* ---- AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction  [@0x8006f958] ---- */
#line 148 "C:/nfs4/GAME/COMMON/AISCRIPT.CPP"
int AIScript_DoReAction(AIScript_t *script,AIScript_tAIReaction testReaction)
{
  int humCarIndex = -1;
  if ((script->actionIndex != 7) && ((testReaction & script->reaction) != 0)) {
    humCarIndex = script->actionHumCarIndex;
  } return humCarIndex;
}

/* ---- AIScript_GetReactionTicksLeft__FP10AIScript_t  [@0x8006f988] ---- */
#line 156 "C:/nfs4/GAME/COMMON/AISCRIPT.CPP"
int AIScript_GetReactionTicksLeft(AIScript_t *script)
{
  if (script->actionIndex != 7) {
    return script->reactionTicksLeft;
  }
  return 0;
}
