/* game/common/aiphysic_externs.h - reconstructed externs. NOT original. */
#ifndef _GAME_COMMON_AIPHYSIC_EXTERNS_H_
#define _GAME_COMMON_AIPHYSIC_EXTERNS_H_
#include "../../nfs4_types.h"

extern "C" int fixedmult(int, int);
int AIScript_DoReAction(AIScript_t *script, AIScript_tAIReaction testReaction);
void AIPhysic_ChangeDirection(Car_tObj *car, int dir);
void AIPhysic_HandleDirection(Car_tObj *car);
int  AIPhysic_HitWallCheck(Car_tObj *car);
void AIPhysic_Preperation(Car_tObj *car);
int  AIPhysic_CheckIfOutOfControl(Car_tObj *car);
void AIPhysic_OutOfControlPhysics(Car_tObj *car);
void AIPhysic_InControlPhysics(Car_tObj *car);
void AIPhysic_FinishUp(Car_tObj *car);
extern GameSetup_tData GameSetup_gData;

#endif
