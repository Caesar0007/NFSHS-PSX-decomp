/* game/common/aicop.cpp -- RECONSTRUCTED (NFS4 AI action/reaction scripting; 8 free AIScript_* fns).
 *   Player-action submission + reaction-table processing. SYM-v3 locals; vs disasm-v2.txt.
 *   NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "aicop_externs.h"


/* ---- aicop.obj-owned globals (.bss zero) ---- */
copLevel_t   twoLapCopGame[4] = { {2, 0, 0, 0, 0, 16, 19660, 512, 128, 2}, {0, 2, 2, 0, 0, 32, 26214, 0, 192, 0}, {2, 0, 0, 0, 1, 32, 19660, 0, 192, 0}, {0, 3, 2, 1, 1, 32, 26214, 0, 192, 0} };   /* @0x8010cfd4 */
copLevel_t   fourLapCopGame[5] = { {2, 0, 0, 0, 0, 16, 45875, 512, 128, 2}, {0, 2, 2, 0, 0, 16, 45875, 512, 192, 0}, {0, 0, 0, 0, 0, 32, 45875, 256, 192, 0}, {2, 0, 0, 0, 1, 32, 45875, 0, 224, 0}, {0, 3, 2, 1, 1, 32, 45875, 0, 256, 0} };   /* @0x8010d0a4 */
copLevel_t   twoLapCopGameSplit[4] = { {0, 0, 0, 0, 2, 16, 32768, 512, 128, 2}, {0, 1, 0, 0, 2, 32, 32768, 0, 192, 0}, {0, 0, 0, 0, 2, 32, 32768, 0, 192, 0}, {0, 1, 0, 1, 2, 32, 32768, 0, 192, 0} };   /* @0x8010d1a8 */
copLevel_t   fourLapCopGameSplit[4] = { {0, 0, 0, 0, 2, 16, 45875, 512, 128, 2}, {0, 1, 0, 0, 2, 16, 45875, 512, 192, 0}, {0, 0, 0, 0, 2, 32, 45875, 256, 192, 0}, {0, 1, 0, 1, 2, 32, 45875, 0, 256, 0} };   /* @0x8010d278 */
copLevel_t   twoLapCopGame1H1AI[4] = { {2, 0, 0, 0, 0, 16, 19660, 512, 128, 2}, {0, 2, 2, 0, 0, 32, 19660, 0, 192, 0}, {2, 0, 0, 0, 1, 32, 19660, 0, 192, 0}, {0, 2, 2, 1, 1, 32, 19660, 0, 192, 0} };   /* @0x8010d348 */
copLevel_t   fourLapCopGame1H1AI[5] = { {1, 0, 0, 0, 0, 16, 45875, 512, 128, 2}, {0, 2, 2, 0, 0, 16, 45875, 512, 192, 0}, {2, 0, 0, 0, 0, 32, 45875, 256, 192, 0}, {2, 0, 0, 0, 1, 32, 45875, 0, 224, 0}, {0, 2, 2, 1, 1, 32, 45875, 0, 256, 0} };   /* @0x8010d418 */
copGame_t    copGame[6] = { {4, -2146381868}, {5, -2146381660}, {4, -2146381400}, {4, -2146381192}, {4, -2146380984}, {5, -2146380776} };   /* @0x8010d51c */
AICop_spikeBelt_t AICop_spikeBelt;   /* @0x8010d54c  (bss(zero)) */
void         *AICop_rawTriggers;   /* @0x8013c570  (bss(zero)) */
int          AICop_gRoadBlockState;   /* @0x8013c574  (bss(zero)) */
int          AICop_numArrestedHumans;   /* @0x8013c578  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
void AICop_StartUp(void);
void AICop_Restart(void);
void AICop_CleanUp(void);
int AICop_NoCopsInArea(int slice,int sliceDistance);


/* ---- AICop_StartUp__Fv  [@0x800669ac] ---- */
void AICop_StartUp(void)
{
  char filename[100];
  char *rawTriggers;
  char acStack_70 [104];
  
  if (GameSetup_gData.cops != 0) {
    triggerManagerCops = (AITrigger_TriggerManager *)operator new(0x34c);
    sprintf(acStack_70,"%sTr%02d.cop",Paths_Paths[22],GameSetup_gData.track);
    AICop_rawTriggers = (u_char *)loadfileadrz(acStack_70,(void *)0x0);
    rawTriggers = AICop_rawTriggers;
    if (AICop_rawTriggers == (char *)0x0) {
      rawTriggers = (char *)0x0;
    }
    triggerManagerCops->Init(rawTriggers);
  }
  AICop_spikeBelt.active_ = 0;
  AICop_numArrestedHumans = 0;
  AICop_gRoadBlockState = 0;
  return;
}

/* ---- AICop_Restart__Fv  [@0x80066a58] ---- */
void AICop_Restart(void)
{
  if ((AICop_rawTriggers != (u_char *)0x0) && (GameSetup_gData.cops != 0)) {
    triggerManagerCops->Init((char *)AICop_rawTriggers);
  }
  AICop_spikeBelt.active_ = 0;
  AICop_numArrestedHumans = 0;
  AICop_gRoadBlockState = 0;
  return;
}

/* ---- AICop_CleanUp__Fv  [@0x80066aa8] ---- */
void AICop_CleanUp(void)
{
  if (triggerManagerCops != (AITrigger_TriggerManager *)0x0) {
    operator delete(triggerManagerCops);
    triggerManagerCops = (AITrigger_TriggerManager *)0x0;
  }
  if ((AICop_rawTriggers != (u_char *)0x0) && (GameSetup_gData.cops != 0)) {
    purgememadr(AICop_rawTriggers);
    AICop_rawTriggers = (u_char *)0x0;
  }
  return;
}

/* ---- AICop_NoCopsInArea__Fii  [@0x80066b08] ---- */
int AICop_NoCopsInArea(int slice,int sliceDistance)
{
  int absDistance;
  int iVar1;
  Car_tObj **ppCVar2;
  int copLoop;
  int iVar3;
  char filename [100];
  
  iVar3 = 0;
  ppCVar2 = Cars_gCopCarList;
  do {
    if (Cars_gNumCopCars <= iVar3) {
      return 1;
    }
    if (((*ppCVar2)->AIFlags & 4U) == 0) {
      iVar1 = AIWorld_ApxSplineDistance(*ppCVar2,slice);
      if (iVar1 < 0) {
        iVar1 = -iVar1;
      }
      if (iVar1 < sliceDistance) {
        return 0;
      }
    }
    ppCVar2 = ppCVar2 + 1;
    iVar3 = iVar3 + 1;
  } while( true );
}
