/* Diagnostic: complete corrected public header, exact typed address references. */
#include "C:/Temp/nfs4-decomp/recon/game/common/aiinit.h"

void (*p875_after_0)(void) = &AIInit_StartUp1;
void (*p875_after_1)(void) = &AIInit_StartUp2;
void (*p875_after_2)(void) = &AIInit_Reset1;
void (*p875_after_3)(void) = &AIInit_Reset2;
void (*p875_after_4)(void) = &AIInit_CleanUp1;
void (*p875_after_5)(void) = &AIInit_CleanUp2;
void (*p875_after_6)(void) = &AI_TrafficStartUp;
void (*p875_after_7)(void) = &AI_TrafficCleanUp;
void (*p875_after_8)(void) = &AIInit_LoadConfigs;
void (*p875_after_9)(Udff_tInfo *handle) = &AIInit_LoadPhysicsConfig;
void (*p875_after_10)(Car_tObj *carObj) = &AIInit_ClearAICar;
void (*p875_after_11)(Car_tObj *carObj) = &AIInit_RestartAICar;
void (*p875_after_12)(Car_tObj *carObj, Udff_tInfo *handle) = &AIInit_InitAICar;
void (*p875_after_13)(Car_tObj *carObj) = &AIInit_DeInitAICar;
void (*p875_after_14)(Car_tObj *carObj) = &AIInit_InitAICar2;
void (*p875_after_15)(Car_tObj *carObj) = &AIInit_DeInitAICar2;
int (*p875_after_16)(int index) = &AIInit_IsNonStandardCarFile;
