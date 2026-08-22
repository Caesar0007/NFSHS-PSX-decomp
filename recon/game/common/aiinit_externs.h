/* game/common/aiinit_externs.h - reconstructed externs. NOT original.
 * Harvested from sibling *_externs.h + *.cpp defs + disasm-v2 (AI/Control demangled). */
#ifndef _GAME_COMMON_AIINIT_EXTERNS_H_
#define _GAME_COMMON_AIINIT_EXTERNS_H_

extern "C" {
int fixedmult(...);
int loadfileadrz(...);
void *memset(...);
int purgememadr(...);
int rdiv(...);
int sprintf(...);
}

/* AIDataRecord_AccTable_t / _CurveSpeedTable_t ctors now via `new Class(...)` (aidatarecord.obj) -- flat ctor externs removed */
extern AITrigger_TriggerManager *triggerManagerTraffic;
extern Car_tObj *Cars_gList[];
extern Car_tObj *Cars_gHumanRaceCarList[];
extern Car_tObj *Cars_gAIRaceCarList[];
extern int AIInit_GameSetupWords[] asm("GameSetup_gData");
extern Car_tObj *AIInit_leaderBoardCars[] asm("leaderBoard");
extern int AIInit_AIInfoWords[] asm("AI_Info");
extern int AIInit_AIPhysicConfigWords[] asm("AIPhysicConfig");
extern int AIInit_accelerationScaleWords[] asm("AITune_accelerationScale");
extern void AITrigger_Init(AITrigger_TriggerManager *,char *)
  asm("Init__24AITrigger_TriggerManagerPc");
extern Udff_tInfo * Udff_Opena(char *name,char *mem,int abortFlag);
extern int            Cars_gNumCars;
extern int   Udff_GetInt(Udff_tInfo *handle);
extern int AISpeeds_GetUpgradeAccMult(int carIndex);
extern int AISpeeds_GetUpgradeHandlingMult(int carIndex);
extern int AISpeeds_GetUpgradeTopSpeedMult(int carIndex);
extern int inverseLaneWidthTable[];
extern void AIPerson_Cleanup(void);
extern void AIPerson_Startup(void);
extern void AIPhysic_CleanUp(void);
extern void AIPhysic_DeInitCar(Car_tObj *carObj);
extern void AIPhysic_InitCar(Car_tObj *carObj);
extern void AIPhysic_Reset(void);
extern void AIPhysic_StartUp(void);
extern void AIScript_Cleanup(void);
extern void AIScript_Startup(AIScript_t *script);
extern void AISpeeds_CleanUp(void);
extern void AISpeeds_StartUp(void);
extern void AITune_CleanUp1(void);
extern void AITune_CleanUp2(void);
extern void AITune_StartUp1(void);
extern void AITune_StartUp2(void);
extern void Udff_Close(Udff_tInfo *handle);
extern void Udff_GetBuffer(Udff_tInfo *handle,char *mem,int size);
int __builtin_delete(...);
int __builtin_new(...);
void AI_CleanUp(void);
void AI_StartUp(void);
/* AIDataRecord_t::StartUp1/2 + CleanUp1/2 (static), AITrigger_TriggerManager::Init, AIDataRecord_CurveSpeedTable_t::Upgrade now called as C++ members -- flat externs removed */

#endif /* _GAME_COMMON_AIINIT_EXTERNS_H_ */
