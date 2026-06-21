/* game/common/gmesetup.cpp -- RECONSTRUCTED (NFS4 PSX game-setup startup/cleanup; C++ TU)
 *   2 free fns: GameSetup_StartUp(int*) + GameSetup_CleanUp(void). Full SYM-locals applied.
 *   GTE-free. Device startup fn-ptr dispatch via Device_gDeviceList[].startupfunc.
 */
#include "../../nfs4_types.h"
#include "gmesetup_externs.h"

/* ---- gmesetup.obj OWNED global (EXT) ---- */
GameSetup_tData GameSetup_gData;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void GameSetup_StartUp(int *FrontEndDataStream);
void GameSetup_CleanUp(void);


/* ---- GameSetup_StartUp__FPi  [GMESETUP.CPP:155-354] SLD-VERIFIED ---- */
void GameSetup_StartUp(int *FrontEndDataStream)

{
  int*p;
  int i;
  int * h;
  int * s;
  FEI_tList * l;
  int iVar1;
  u_int uVar2;
  int iVar3;
  FEI_tList *pFVar4;
  int *piVar5;
  int *piVar6;
  int *piVar7;
  
  Input_StartUp();
  iVar3 = *FrontEndDataStream;
  piVar7 = FrontEndDataStream;
  do {
    if (iVar3 == 0) {
      purgememadr(FrontEndDataStream);
      timedwait(100);
      PAD_update();
      uVar2 = PAD_state(0);
      if ((uVar2 & 0xffff) == 0x909) {
        GameSetup_gData.sgge = 8;
      }
      uVar2 = PAD_state(0);
      if ((uVar2 & 0xffff) == 0xa080) {
        GameSetup_gData.sgge = 2;
      }
      uVar2 = PAD_state(0);
      if ((uVar2 & 0xffff) == 0xc001) {
        GameSetup_gData.sgge = 4;
      }
      uVar2 = PAD_state(0);
      if ((uVar2 & 0xffff) == 0x640) {
        GameSetup_gData.sgge = 0x10;
      }
      uVar2 = PAD_state(0);
      if ((uVar2 & 0xffff) == 0x610) {
        GameSetup_gData.sgge = 0x20;
      }
      uVar2 = PAD_state(0);
      if ((uVar2 & 0xffff) == 0x910) {
        GameSetup_gData.sgge = 0x40;
      }
      uVar2 = PAD_state(0);
      if ((uVar2 & 0xffff) == 0x5010) {
        GameSetup_gData.sgge = 0x80;
      }
      uVar2 = PAD_state(0);
      if ((uVar2 & 0xffff) == 0x620) {
        GameSetup_gData.sgge = 0x100;
      }
      gMasterMusicLevel = GameSetup_gData.userSetting.musicLevel;
      gMasterSFXLevel = GameSetup_gData.userSetting.sfxLevel;
      gMasterFENarrationLevel = GameSetup_gData.userSetting.speechLevel;
      gMasterEngineLevel = GameSetup_gData.userSetting.engineLevel;
      gMasterAmbientLevel = GameSetup_gData.userSetting.ambientLevel;
      Device_SetHardCodedKeys();
      return;
    }
    iVar3 = *piVar7;
    if (iVar3 < 0x103) {
      pFVar4 = FEI_gList;
      if (iVar3 < 0x4d) {
        piVar6 = (int *)0x0;
        iVar1 = FEI_gList[0].v;
        while (iVar1 != 0) {
          if (iVar1 == iVar3) {
            piVar6 = pFVar4->p;
          }
          pFVar4 = pFVar4 + 1;
          iVar1 = pFVar4->v;
        }
        if (piVar6 != (int *)0x0) {
          if (*piVar7 < 0x4b) {
            *piVar6 = piVar7[1];
          }
          else {
            iVar3 = 0;
            piVar5 = piVar7;
            if (0 < piVar7[1]) {
              do {
                iVar3 = iVar3 + 1;
                *piVar6 = piVar5[2];
                piVar6 = piVar6 + 1;
                piVar5 = piVar5 + 1;
              } while (iVar3 < piVar7[1]);
            }
          }
        }
        if (0x4a < *piVar7) {
          piVar7 = piVar7 + piVar7[1];
        }
      }
      else {
        *(int *)(GameSetup_gData.carInfo[7].driver + iVar3 * 4 + -0x28) = piVar7[1];
        if (Device_gDeviceList[piVar7[1] & 0xff].startupfunc != (u_char **)0x0) {
          (*(int (*)(...))Device_gDeviceList[piVar7[1] & 0xff].startupfunc)(piVar7[1] >> 8);
          piVar7 = piVar7 + 2;
          goto GameSetupStart_iterValuesLoop;
        }
      }
      piVar7 = piVar7 + 2;
    }
    else {
      pFVar4 = FEI_gList;
      piVar6 = (int *)0x0;
      iVar1 = FEI_gList[0].v;
      while (iVar1 != 0) {
        if (iVar1 == iVar3) {
          piVar6 = pFVar4->p;
        }
        pFVar4 = pFVar4 + 1;
        iVar1 = pFVar4->v;
      }
      if (piVar6 != (int *)0x0) {
        piVar6[piVar7[1] * 0x2d] = piVar7[2];
      }
      piVar7 = piVar7 + 3;
    }
GameSetupStart_iterValuesLoop:
    iVar3 = *piVar7;
  } while( true );
}

/* ---- GameSetup_CleanUp__Fv  [GMESETUP.CPP:369-370] SLD-VERIFIED ---- */
void GameSetup_CleanUp(void)

{
  return;
}

/* end of gmesetup.cpp */
