/* game/common/audioclc.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "audioclc_externs.h"


/* ---- audioclc.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
AudioClc_tPlayer AudioClc_gPlayer[2];   /* @0x8010e2a8  (bss(zero)) */
AudioClc_tSource AudioClc_gClosest[4];   /* @0x8010e348  (bss(zero)) */
DRender_tCalcView AudioClc_gRenderView;   /* @0x8010e428  (bss(zero)) */
int          AudioClc_PursuitTime[9];   /* @0x8010e4ac  (bss(zero)) */
coorddef     *AudioClc_gCameraVelocity;   /* @0x8013c608  (bss(zero)) */
int          AudioClc_gRandomPhrase;   /* @0x8013c60c  (bss(zero)) */
int          AudioClc_gBullHornCount;   /* @0x8013c610  (bss(zero)) */
int          AudioClc_gBumpCopCount;   /* @0x8013c614  (bss(zero)) */
int          AudioClc_gLastVoice;   /* @0x8013c618  (bss(zero)) */
int          AudioClc_gLastphrase1;   /* @0x8013c61c  (bss(zero)) */
int          AudioClc_gLastphrase2;   /* @0x8013c620  (bss(zero)) */
int          AudioClc_gLastphrase3;   /* @0x8013c624  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
void AudioClc_SndError(int shandle);
void AudioClc_SetHorn(Car_tObj *car,int state);
void AudioClc_HonkHorn(Car_tObj *car,int numBeeps,int ticksOn,int ticksOff);
void AudioClc_InitSource(AudioClc_tSource *s,Car_tObj *car);
void AudioClc_StartUp(void);
int AudioClc_CalcDopplerShiftRatio(coorddef *objectPos,coorddef *objectVel);
int AudioClc_CalcDistance(DRender_tCalcView *view,coorddef *object);
int AudioClc_CalcAzimuth(DRender_tCalcView *view,coorddef *object);
int AudioClc_CalcCarDirection(DRender_tCalcView *view,Car_tObj *car);
int AudioClc_CalcTrackAzimuth(DRender_tCalcView *view,Car_tObj *car);
void AudioClc_SoundOpponentHorn(int closestIndex,int azimuth,int dop,int dsquare);
void AudioClc_SilenceOpponentHorn(int closestIndex);
void AudioClc_SoundCloseCar(int playerIndex,int closestIndex);
void AudioClc_SoundPlayersCar(int playerIndex);
void AudioClc_ResetClosest(int closestIndex,Car_tObj *car,int playerIndex);
void AudioClc_GetClosestCars(int playerIndex,int closestIndex,int numclosest);
void AudioClc_SoundSpeech(void);


/* ---- AudioClc_SndError__Fi  [@0x80074730] ---- */
void AudioClc_SndError(int shandle)
{
  return;
}

/* ---- AudioClc_SetHorn__FP8Car_tObji  [@0x80074738] ---- */
void AudioClc_SetHorn(Car_tObj *car,int state)
{
  AudioClc_tSource*s;
  int i;
  int *piVar1;
  AudioClc_tSource *pAVar2;
  int iVar3;
  
  iVar3 = 0;
  pAVar2 = AudioClc_gClosest;
  piVar1 = &AudioClc_gClosest[0].hornCount;
  do {
    if (pAVar2->car == car) {
      if (state == 0) {
        if (piVar1[-3] != 0) {
          piVar1[-3] = 1;
          piVar1[-2] = 1;
          *piVar1 = 1;
        }
      }
      else {
        piVar1[-3] = 1;
        piVar1[-2] = 0;
      }
    }
    iVar3 = iVar3 + 1;
    piVar1 = piVar1 + 0xe;
    pAVar2 = pAVar2 + 1;
  } while (iVar3 < 4);
  return;
}

/* ---- AudioClc_HonkHorn__FP8Car_tObjiii  [@0x800747a8] ---- */
void AudioClc_HonkHorn(Car_tObj *car,int numBeeps,int ticksOn,int ticksOff)
{
  AudioClc_tSource*s;
  int i;
  int *piVar1;
  AudioClc_tSource *pAVar2;
  int iVar3;
  
  iVar3 = 0;
  pAVar2 = AudioClc_gClosest;
  piVar1 = &AudioClc_gClosest[0].hornCount;
  do {
    if ((pAVar2->car == car) && (piVar1[-3] == 0)) {
      piVar1[-3] = ticksOn;
      piVar1[-2] = ticksOn;
      piVar1[-1] = -ticksOff;
      *piVar1 = numBeeps;
    }
    iVar3 = iVar3 + 1;
    piVar1 = piVar1 + 0xe;
    pAVar2 = pAVar2 + 1;
  } while (iVar3 < 4);
  return;
}

/* ---- AudioClc_InitSource__FP16AudioClc_tSourceP8Car_tObj  [@0x80074808] ---- */
void AudioClc_InitSource(AudioClc_tSource *s,Car_tObj *car)
{
  s->distToCamera = -1;
  s->dopplerShift = -1;
  s->car = car;
  s->gameTicks = 0;
  s->horn = 0;
  s->distSq = 0x1324;
  s->frequency = 0;
  s->pursuit = 0;
  s->yelled = 0;
  return;
}

/* ---- AudioClc_StartUp__Fv  [@0x80074838] ---- */
void AudioClc_StartUp(void)
{
  AudioClc_tPlayer*p;
  AudioClc_tSource*c;
  int i;
  AudioClc_tPlayer *pAVar1;
  int iVar2;
  AudioClc_tSource *s;
  AudioClc_tPlayer *pAVar3;
  AudioClc_tSource *s_00;
  Car_tObj **ppCVar4;
  
  pAVar3 = AudioClc_gPlayer;
  s_00 = AudioClc_gClosest;
  iVar2 = 0;
  pAVar1 = AudioClc_gPlayer;
  ppCVar4 = Cars_gHumanRaceCarList;
  AudioClc_gRandomPhrase = 0;
  AudioClc_gBullHornCount = 0;
  AudioClc_gBumpCopCount = 0;
  AudioClc_gLastVoice = -1;
  AudioClc_gLastphrase1 = -1;
  AudioClc_gLastphrase2 = -1;
  AudioClc_gLastphrase3 = -1;
  do {
    s = &pAVar1->source;
    pAVar3->cameraMode = -1;
    *(u_int *)((int)(s + -1) + 0x24) = 0;
    *(u_int *)((int)(s + -1) + 0x28) = 0;
    AudioClc_InitSource(s,(Car_tObj *)0x0);
    if (GameSetup_gData.commMode < 2) {
      if (iVar2 < Cars_gNumHumanRaceCars) {
        s->car = *ppCVar4;
      }
    }
    else if ((iVar2 == 0) && (GameSetup_gData.localCar < Cars_gNumHumanRaceCars)) {
      s->car = Cars_gHumanRaceCarList[GameSetup_gData.localCar];
    }
    ppCVar4 = ppCVar4 + 1;
    iVar2 = iVar2 + 1;
    pAVar1 = (AudioClc_tPlayer *)(s + 1);
    pAVar3 = pAVar3 + 1;
  } while (iVar2 < 2);
  iVar2 = 0;
  do {
    AudioClc_InitSource(s_00,(Car_tObj *)0x0);
    iVar2 = iVar2 + 1;
    s_00 = s_00 + 1;
  } while (iVar2 < 4);
  AudioClc_gCameraVelocity = (coorddef *)0x0;
  return;
}

/* ---- AudioClc_CalcDopplerShiftRatio__FP8coorddefT0  [@0x80074994] ---- */
int AudioClc_CalcDopplerShiftRatio(coorddef *objectPos,coorddef *objectVel)
{
  coorddef*cameraPos;
  coorddef*cameraVel;
  coorddef vectorToSound;
  int relativeVelocity;
  coorddef *pcVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  coorddef local_20;
  
  pcVar1 = AudioClc_gCameraVelocity;
  /* @0x800749AC-EC: vectorToSound = (objectPos - AudioClc_gRenderView.translation) >> 8 per axis.
   * disasm $a1=0x8010E428=&AudioClc_gRenderView.translation; the camera-translation subtraction
   * was dropped (H41), normalizing the world-space position instead of the camera-relative vector. */
  local_20.x = (objectPos->x - AudioClc_gRenderView.translation.x) >> 8;
  local_20.y = (objectPos->y - AudioClc_gRenderView.translation.y) >> 8;
  local_20.z = (objectPos->z - AudioClc_gRenderView.translation.z) >> 8;
  Math_NormalizeVector(&local_20);
  iVar8 = 0;
  if (objectVel != (coorddef *)0x0) {
    iVar8 = local_20.x;
    if (local_20.x < 0) {
      iVar8 = local_20.x + 0xff;
    }
    iVar2 = objectVel->x;
    if (iVar2 < 0) {
      iVar2 = iVar2 + 0xff;
    }
    iVar6 = local_20.y;
    if (local_20.y < 0) {
      iVar6 = local_20.y + 0xff;
    }
    iVar3 = objectVel->y;
    if (iVar3 < 0) {
      iVar3 = iVar3 + 0xff;
    }
    iVar7 = local_20.z;
    if (local_20.z < 0) {
      iVar7 = local_20.z + 0xff;
    }
    iVar4 = objectVel->z;
    if (iVar4 < 0) {
      iVar4 = iVar4 + 0xff;
    }
    iVar8 = (iVar8 >> 8) * (iVar2 >> 8) + (iVar6 >> 8) * (iVar3 >> 8) + (iVar7 >> 8) * (iVar4 >> 8);
  }
  if (pcVar1 != (coorddef *)0x0) {
    iVar2 = local_20.x;
    if (local_20.x < 0) {
      iVar2 = local_20.x + 0xff;
    }
    iVar6 = pcVar1->x;
    if (iVar6 < 0) {
      iVar6 = iVar6 + 0xff;
    }
    iVar3 = local_20.y;
    if (local_20.y < 0) {
      iVar3 = local_20.y + 0xff;
    }
    iVar7 = pcVar1->y;
    if (iVar7 < 0) {
      iVar7 = iVar7 + 0xff;
    }
    iVar4 = local_20.z;
    if (local_20.z < 0) {
      iVar4 = local_20.z + 0xff;
    }
    iVar5 = pcVar1->z;
    if (iVar5 < 0) {
      iVar5 = iVar5 + 0xff;
    }
    iVar8 = iVar8 - ((iVar2 >> 8) * (iVar6 >> 8) + (iVar3 >> 8) * (iVar7 >> 8) +
                    (iVar4 >> 8) * (iVar5 >> 8));
  }
  iVar8 = fixeddiv(0x1540000,iVar8 + 0x1540000);
  return iVar8;
}

/* ---- AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef  [@0x80074b60] ---- */
int AudioClc_CalcDistance(DRender_tCalcView *view,coorddef *object)
{
  int x;
  int y;
  int z;
  int length;
  int length1;
  int iVar1;
  int iVar2;
  int iVar3;
  
  iVar3 = object->x - (view->translation).x;
  if (iVar3 < 0) {
    iVar3 = -iVar3;
  }
  iVar2 = object->y - (view->translation).y;
  iVar1 = object->z - (view->translation).z;
  if (iVar2 < 0) {
    iVar2 = -iVar2;
  }
  if (iVar1 < 0) {
    iVar1 = -iVar1;
  }
  if (iVar1 < iVar3) {
    iVar3 = iVar3 + (iVar1 >> 2);
  }
  else {
    iVar3 = iVar1 + (iVar3 >> 2);
  }
  if (iVar3 < iVar2) {
    return iVar2 + (iVar3 >> 2);
  }
  return iVar3 + (iVar2 >> 2);
}

/* ---- AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef  [@0x80074be8] ---- */
int AudioClc_CalcAzimuth(DRender_tCalcView *view,coorddef *object)
{
  coorddef temp;
  int x;
  int y;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  u_int uVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  int iVar9;
  
  iVar8 = object->x - (view->translation).x;
  iVar9 = object->y - (view->translation).y;
  iVar6 = object->z - (view->translation).z;
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar1 = (view->mrotation).m[0];
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  if (iVar9 < 0) {
    iVar9 = iVar9 + 0xff;
  }
  iVar2 = (view->mrotation).m[1];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar7 = iVar6;
  if (iVar6 < 0) {
    iVar7 = iVar6 + 0xff;
  }
  iVar3 = (view->mrotation).m[2];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar4 = (view->mrotation).m[6];
  iVar1 = (iVar8 >> 8) * (iVar1 >> 8) + (iVar9 >> 8) * (iVar2 >> 8) + (iVar7 >> 8) * (iVar3 >> 8);
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar2 = (view->mrotation).m[7];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar7 = (view->mrotation).m[8];
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  if (GameSetup_gData.mirrorTrack != 0) {
    iVar1 = -iVar1;
  }
  uVar5 = intatan(iVar1 >> 8,
                     (iVar8 >> 8) * (iVar4 >> 8) + (iVar9 >> 8) * (iVar2 >> 8) +
                     (iVar6 >> 8) * (iVar7 >> 8) >> 8);
  return (uVar5 & 0x3ff) << 6;
}

/* ---- AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj  [@0x80074d50] ---- */
int AudioClc_CalcCarDirection(DRender_tCalcView *view,Car_tObj *car)
{
  coorddef temp;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  int iVar6;
  
  iVar4 = (car->N).position.x - (view->translation).x;
  iVar6 = (car->N).position.y - (view->translation).y;
  iVar5 = (car->N).position.z - (view->translation).z;
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar1 = (car->N).orientMat.m[6];
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar2 = (car->N).orientMat.m[7];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  if (iVar5 < 0) {
    iVar5 = iVar5 + 0xff;
  }
  iVar3 = (car->N).orientMat.m[8];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  return (iVar4 >> 8) * (iVar1 >> 8) + (iVar6 >> 8) * (iVar2 >> 8) + (iVar5 >> 8) * (iVar3 >> 8);
}

/* ---- AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj  [@0x80074e24] ---- */
int AudioClc_CalcTrackAzimuth(DRender_tCalcView *view,Car_tObj *car)
{
  int x;
  int y;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  u_int uVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  
  iVar8 = (car->N).roadMatrix.m[6];
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xff;
  }
  iVar1 = (view->mrotation).m[0];
  if (iVar1 < 0) {
    iVar1 = iVar1 + 0xff;
  }
  iVar7 = (car->N).roadMatrix.m[7];
  if (iVar7 < 0) {
    iVar7 = iVar7 + 0xff;
  }
  iVar2 = (view->mrotation).m[1];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar6 = (car->N).roadMatrix.m[8];
  if (iVar6 < 0) {
    iVar6 = iVar6 + 0xff;
  }
  iVar3 = (view->mrotation).m[2];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  iVar4 = (view->mrotation).m[6];
  iVar1 = (iVar8 >> 8) * (iVar1 >> 8) + (iVar7 >> 8) * (iVar2 >> 8) + (iVar6 >> 8) * (iVar3 >> 8);
  if (iVar4 < 0) {
    iVar4 = iVar4 + 0xff;
  }
  iVar2 = (view->mrotation).m[7];
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xff;
  }
  iVar3 = (view->mrotation).m[8];
  if (iVar3 < 0) {
    iVar3 = iVar3 + 0xff;
  }
  if (GameSetup_gData.mirrorTrack != 0) {
    iVar1 = -iVar1;
  }
  uVar5 = intatan(iVar1 >> 8,
                     (iVar8 >> 8) * (iVar4 >> 8) + (iVar7 >> 8) * (iVar2 >> 8) +
                     (iVar6 >> 8) * (iVar3 >> 8) >> 8);
  return (uVar5 & 0x3ff) << 6;
}

/* ---- AudioClc_SoundOpponentHorn__Fiiii  [@0x80074f5c] ---- */
void AudioClc_SoundOpponentHorn(int closestIndex,int azimuth,int dop,int dsquare)
{
  AudioClc_tSource*source;
  int cartype;
  int carhornSFX;
  static char trafficFreqs[50];
  int iamp;
  int iSFXnum;
  int iVar1;
  
  iVar1 = (AudioClc_gClosest[closestIndex].car)->carInfo->carType;
  iSFXnum = 10;
  if (iVar1 == 0x30) {
    iSFXnum = 0xb;
  }
  AudioCmn_PlaySFX(closestIndex + 0x25,iSFXnum,(u_int)"XPFA<2UZ<-Z2UKTJ"[iVar1],dop,
             ((0x1324 - dsquare) * 0x7f) / 0x1324,azimuth);
  return;
}

/* ---- AudioClc_SilenceOpponentHorn__Fi  [@0x80075008] ---- */
void AudioClc_SilenceOpponentHorn(int closestIndex)
{
  freeVoiceChannel(closestIndex + 0x25);
  return;
}

/* ---- AudioClc_SoundCloseCar__Fii  [@0x80075028] ---- */
void AudioClc_SoundCloseCar(int playerIndex,int closestIndex)
{
  AudioClc_tSource*source;
  int distSq;
  int dop;
  int dst;
  int dir;
  int c;
  int iamp;
  int doppler;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int relvel;
  int iVar5;
  s_type surface1;
  s_type surface2;
  coorddef *objectPos;
  int *piVar6;
  Car_tObj *car;
  int azimuth;
  int dsquare;
  
  car = AudioClc_gClosest[closestIndex].car;
  objectPos = &(car->N).position;
  if (car == (Car_tObj *)0x0) {
    return;
  }
  doppler = AudioClc_CalcDopplerShiftRatio(objectPos,&(car->N).linearVel);
  if (doppler < 0) {
    return;
  }
  iVar1 = AudioClc_CalcDistance(&AudioClc_gRenderView,objectPos);
  iVar2 = AudioClc_CalcCarDirection(&AudioClc_gRenderView,car);
  iVar2 = fixeddiv(iVar2,iVar1);
  if (iVar2 < 0x10001) {
    iVar2 = AudioClc_CalcCarDirection(&AudioClc_gRenderView,car);
    iVar2 = fixeddiv(iVar2,iVar1);
    if (-0x10001 < iVar2) goto LAB_800750fc;
    iVar2 = -0x10000;
  }
  else {
LAB_800750fc:
    iVar2 = AudioClc_CalcCarDirection(&AudioClc_gRenderView,car);
    iVar2 = fixeddiv(iVar2,iVar1);
    if (iVar2 < 0x10001) {
      iVar2 = AudioClc_CalcCarDirection(&AudioClc_gRenderView,car);
      iVar2 = fixeddiv(iVar2,iVar1);
    }
    else {
      iVar2 = 0x10000;
    }
  }
  if (GameSetup_gData.commMode == 1) {
    azimuth = 0x3fff;
    if (playerIndex == 0) {
      azimuth = 0xc000;
    }
  }
  else {
    azimuth = AudioClc_CalcAzimuth(&AudioClc_gRenderView,&(car->N).position);
  }
  iVar3 = iVar1;
  if (iVar1 < 0) {
    iVar3 = iVar1 + 0xffff;
  }
  iVar3 = (iVar3 >> 0x10) * (iVar3 >> 0x10);
  dsquare = 0x1324;
  if (iVar3 < 0x1324) {
    dsquare = iVar3;
  }
  if (AudioClc_gCameraVelocity == (coorddef *)0x0) {
    iVar4 = car->currentSpeed;
    if (iVar4 < 0) {
      iVar4 = -iVar4;
    }
  }
  else {
    iVar5 = (AudioClc_gPlayer[playerIndex].source.car)->currentSpeed;
    iVar4 = car->currentSpeed - iVar5;
    if (iVar4 < 1) {
      iVar4 = iVar5 - car->currentSpeed;
    }
  }
  AudioClc_gClosest[closestIndex].relVelocity = iVar4;
  AudioClc_gClosest[closestIndex].distSq = dsquare;
  iVar4 = car->specs->redline;
  iVar5 = car->flywheelRpm << 0x10;
  if (iVar4 == 0) {
    trap(0x1c00);
  }
  if ((iVar4 == -1) && (iVar5 == -0x80000000)) {
    trap(0x1800);
  }
  relvel = (car->linearVel_ch).z;
  if (relvel < 0) {
    relvel = -relvel;
  }
  AudioCmn_TrafficSFX(closestIndex + 6,car->carInfo->carType,iVar5 / iVar4,doppler,iVar1,azimuth,relvel,iVar2
            );
  iVar1 = car->audioCount + -1;
  if (-1 < iVar1) {
    piVar6 = &(car->N).simRoadInfo.quadPts[car->audioCount * 2 + -4].z;
    do {
      iVar2 = closestIndex + 0x20;
      if (piVar6[0x1e7] < 0) {
        surface1 = piVar6[0x1e8];
        surface2 = piVar6[0x1e9];
        iVar5 = piVar6[0x1ea];
        iVar2 = -1;
        iVar4 = dsquare;
      }
      else {
        surface1 = piVar6[0x1e8];
        surface2 = piVar6[0x1e9];
        iVar5 = piVar6[0x1ea];
        iVar4 = iVar3;
      }
      piVar6 = piVar6 + -6;
      AudioCmn_TrafficSkidSFX(iVar2,surface1,surface2,iVar5,iVar4,azimuth);
      iVar1 = iVar1 + -1;
    } while (-1 < iVar1);
  }
  if ((car->carFlags & 4U) == 0) {
    iVar1 = AudioClc_gClosest[closestIndex].horn;
    if (0 < iVar1) {
      if (0 < AudioClc_gClosest[closestIndex].hornOn) {
        AudioClc_gClosest[closestIndex].horn = iVar1 + -1;
      }
      if (AudioClc_gClosest[closestIndex].horn == 0) {
        (car->control).horn = '\0';
        AudioClc_SilenceOpponentHorn(closestIndex);
        iVar1 = AudioClc_gClosest[closestIndex].hornCount + -1;
        AudioClc_gClosest[closestIndex].hornCount = iVar1;
        if (iVar1 != 0) {
          AudioClc_gClosest[closestIndex].horn = AudioClc_gClosest[closestIndex].hornOff;
        }
      }
      else {
        (car->control).horn = '\x01';
        AudioClc_SoundOpponentHorn(closestIndex,azimuth,doppler,dsquare);
      }
      goto LAB_800753f8;
    }
    if ((-1 < iVar1) || (AudioClc_gClosest[closestIndex].horn = iVar1 + 1, iVar1 + 1 != 0))
    goto LAB_800753f8;
    iVar1 = AudioClc_gClosest[closestIndex].hornOn;
  }
  else {
    if ((car->control).horn == '\0') {
      if (AudioClc_gClosest[closestIndex].horn != 0) {
        AudioClc_SilenceOpponentHorn(closestIndex);
        AudioClc_gClosest[closestIndex].horn = 0;
      }
      goto LAB_800753f8;
    }
    AudioClc_SoundOpponentHorn(closestIndex,azimuth,doppler,dsquare);
    iVar1 = 1;
  }
  AudioClc_gClosest[closestIndex].horn = iVar1;
LAB_800753f8:
  if (car->carInfo->carType - 0x16U < 6) {
    if ((car->AIFlags & 2U) == 0) {
      if (bSirenOn[closestIndex] != 0) {
        SirenOff(closestIndex);
        freeVoiceChannel(closestIndex + 0x2b);
      }
    }
    else if (bSirenOn[closestIndex] == 0) {
      SirenOn(closestIndex,car->carFlags & 0x40);
    }
    else {
      UpdateSiren(closestIndex,((0x1324 - dsquare) * 0x7f) / 0x1324,doppler,azimuth,
                 car->carFlags & 0x40);
    }
  }
  return;
}

/* ---- AudioClc_SoundPlayersCar__Fi  [@0x80075508] ---- */
void AudioClc_SoundPlayersCar(int playerIndex)
{
  DRender_tCalcView*view;
  AudioClc_tSource*previous;
  int azimuth;
  int dsquare;
  int frequency;
  int dop;
  int dst;
  int facing;
  int cardir;
  int trkazi;
  int revLimit;
  int c;
  int channel;
  int iamp;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  u_int uVar5;
  int iVar6;
  coorddef *objectPos;
  int iVar7;
  int *piVar8;
  Car_tObj *car;
  int iVar9;
  int iVar10;
  
  car = AudioClc_gPlayer[playerIndex].source.car;
  if (car == (Car_tObj *)0x0) {
    return;
  }
  iVar7 = 0;
  if ((car->carFlags & 0x200U) == 0) {
    iVar10 = fixedmult((car->N).orientMat.m[6],
                        (int)*(char *)((car->N).simRoadInfo.slice * 0x20 + BWorldSm_slices + 0xf));
    iVar2 = fixedmult((car->N).orientMat.m[7],
                       (int)*(char *)((car->N).simRoadInfo.slice * 0x20 + BWorldSm_slices + 0x10));
    iVar7 = fixedmult((car->N).orientMat.m[8],
                       (int)*(char *)((car->N).simRoadInfo.slice * 0x20 + BWorldSm_slices + 0x11));
    iVar7 = iVar10 + iVar2 + iVar7;
    if (GameSetup_gData.reverseTrack != 0) {
      iVar7 = -iVar7;
    }
  }
  else if (car->desiredDirection != car->direction) {
    iVar7 = -1;
  }
  if (((car->stats).finishType == 2) ||
     (((((GameSetup_gData.raceType == 1 || (GameSetup_gData.raceType == 5)) &&
        ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
         ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) &&
       ((car->carFlags & 0x204U) == 4)) ||
      (((car->RSControl != 0 || (car->pullOver != 0)) || (-1 < iVar7)))))) {
    car->wrongway = 0;
  }
  else if (((car->N).flightTime == 0) && ((car->collision).smoking == 0)) {
    uVar5 = car->wrongway + 1;
    car->wrongway = uVar5;
    if (((0x3f < (int)uVar5) && ((uVar5 & 0x1f) == 0)) &&
       (((int)uVar5 < 0x94 || (Hud_BeTheCop != 0)))) {
      AudioCmn_PlayWrongWaySFX();
    }
  }
  objectPos = &(car->N).position;
  iVar7 = AudioClc_CalcDopplerShiftRatio(objectPos,&(car->N).linearVel);
  if (GameSetup_gData.commMode == 1) {
    iVar10 = 0xc000;
    if (playerIndex != 0) {
      iVar10 = 0x3fff;
    }
  }
  else if (Camera_gInfo[playerIndex].mode == 0) {
    iVar10 = 0;
  }
  else {
    iVar10 = AudioClc_CalcAzimuth(&AudioClc_gRenderView,objectPos);
  }
  iVar2 = AudioClc_CalcDistance(&AudioClc_gRenderView,&(car->N).position);
  iVar3 = AudioClc_CalcCarDirection(&AudioClc_gRenderView,car);
  iVar3 = fixeddiv(iVar3,iVar2);
  if (iVar3 < 0x10001) {
    iVar3 = AudioClc_CalcCarDirection(&AudioClc_gRenderView,car);
    iVar3 = fixeddiv(iVar3,iVar2);
    iVar9 = -0x10000;
    if (-0x10001 < iVar3) goto LAB_80075824;
  }
  else {
LAB_80075824:
    iVar3 = AudioClc_CalcCarDirection(&AudioClc_gRenderView,car);
    iVar3 = fixeddiv(iVar3,iVar2);
    iVar9 = 0x10000;
    if (iVar3 < 0x10001) {
      iVar3 = AudioClc_CalcCarDirection(&AudioClc_gRenderView,car);
      iVar9 = fixeddiv(iVar3,iVar2);
    }
  }
  iVar3 = iVar2;
  if (iVar2 < 0) {
    iVar3 = iVar2 + 0xffff;
  }
  iVar3 = (iVar3 >> 0x10) * (iVar3 >> 0x10);
  if (car->carInfo->Transmission == 1) {
    iVar6 = car->specs->redline + 1000;
  }
  else {
    iVar6 = car->specs->redline + 2000;
  }
  if (5 < (car->N).flightTime) {
    iVar6 = iVar6 + -500;
  }
  iVar1 = car->flywheelRpm * 0x7f;
  if (iVar6 == 0) {
    trap(0x1c00);
  }
  if ((iVar6 == -1) && (iVar1 == -0x80000000)) {
    trap(0x1800);
  }
  if (AudioClc_gCameraVelocity == (coorddef *)0x0) {
    iVar4 = car->currentSpeed;
    if (iVar4 < 0) {
      iVar4 = -iVar4;
    }
    AudioClc_gPlayer[playerIndex].source.relVelocity = iVar4;
  }
  else {
    AudioClc_gPlayer[playerIndex].source.relVelocity = 0;
  }
  iVar4 = AudioClc_CalcTrackAzimuth(&AudioClc_gRenderView,car);
  AudioTrk_SoundTrack(car,iVar4);
  AudioCmn_SoundCar(car,iVar2,iVar1 / iVar6,iVar7,iVar10,iVar4,
             AudioClc_gPlayer[playerIndex].source.relVelocity,iVar9);
  if (gMasterSFXLevel == 0) {
    return;
  }
  iVar2 = car->audioCount + -1;
  if (-1 < iVar2) {
    piVar8 = &(car->N).simRoadInfo.quadPts[car->audioCount * 2 + -4].z;
    do {
      iVar9 = piVar8[0x1e7];
      if (iVar9 == 0x12) {
        iVar9 = 0x12;
        if (playerIndex != 0) {
          iVar9 = 0x13;
        }
      }
      else if ((iVar9 == 0x14) && (iVar9 = 0x14, playerIndex != 0)) {
        iVar9 = 0x15;
      }
      if (((piVar8[0x1e6] == 5) || (piVar8[0x1e6] == 3)) && (-1 < iVar9)) {
        freeVoiceChannel(iVar9);
        if (iVar9 - 0x12U < 2) {
          freeVoiceChannel(iVar9 + 4);
        }
      }
      else {
        iVar6 = iVar10;
        if (((iVar9 < 0) && (GameSetup_gData.commMode != 1)) &&
           ((piVar8[0x1e8] != 10 && (piVar8[0x1e8] != 8)))) {
          iVar6 = AudioClc_CalcAzimuth(&AudioClc_gRenderView,&(car->N).collision.collisionPoint);
        }
        AudioCmn_SFX(iVar9,piVar8[0x1e8],piVar8[0x1e9],piVar8[0x1ea],iVar3,iVar6);
      }
      piVar8 = piVar8 + -6;
      iVar2 = iVar2 + -1;
    } while (-1 < iVar2);
  }
  if ((car->control).horn == '\0') {
    if (AudioClc_gPlayer[playerIndex].source.horn == 0) goto LAB_80075b0c;
    iVar2 = AudioCmn_PlayerHornOff(car->carIndex);
  }
  else {
    AudioCmn_PlayerHornOn(car->carIndex,iVar3,0x40,iVar10,iVar7);
    iVar2 = 1;
  }
  AudioClc_gPlayer[playerIndex].source.horn = iVar2;
LAB_80075b0c:
  if (car->carInfo->carType - 0x16U < 6) {
    if ((car->AIFlags & 2U) == 0) {
      iVar7 = car->carIndex + 4;
      if (bSirenOn[iVar7] != 0) {
        SirenOff(iVar7);
        freeVoiceChannel(car->carIndex + 0x2f);
      }
    }
    else {
      if (iVar3 < 0x1324) {
        iVar2 = ((0x1324 - iVar3) * 0x7f) / 0x1324;
      }
      else {
        iVar2 = 0;
      }
      iVar3 = car->carIndex + 4;
      if (bSirenOn[iVar3] == 0) {
        SirenOn(iVar3,car->carFlags & 0x40);
      }
      else {
        UpdateSiren(iVar3,iVar2,iVar7,iVar10,car->carFlags & 0x40);
      }
    }
  }
  return;
}

/* ---- AudioClc_ResetClosest__FiP8Car_tObji  [@0x80075c3c] ---- */
void AudioClc_ResetClosest(int closestIndex,Car_tObj *car,int playerIndex)
{
  if (AudioClc_gClosest[closestIndex].car != (Car_tObj *)0x0) {
    if (car == (Car_tObj *)0x0) {
      freeVoiceChannel(closestIndex + 6);
      freeVoiceChannel(closestIndex + 10);
      freeVoiceChannel(closestIndex + 0xe);
    }
    if (bSirenOn[closestIndex] != 0) {
      SirenOff(closestIndex);
    }
    freeVoiceChannel(closestIndex + 0x20);
    freeVoiceChannel(closestIndex + 0x25);
  }
  AudioClc_InitSource(AudioClc_gClosest + closestIndex,car);
  return;
}

/* ---- AudioClc_GetClosestCars__Fiii  [@0x80075d04] ---- */
void AudioClc_GetClosestCars(int playerIndex,int closestIndex,int numclosest)
{
  int i;
  int j;
  int k;
  int x;
  int y;
  int z;
  int distance;
  int distance1;
  Car_tObj**car;
  AudioClc_tSource*closest;
  AudioClc_tCLCache*cl[0];
  int searchdist;
  int patch;
  int *piVar1;
  int iVar2;
  AudioClc_tSource *pAVar3;
  Car_tObj *pCVar4;
  int iVar5;
  int iVar6;
  int *piVar7;
  int iVar8;
  Car_tObj **ppCVar9;
  int iVar10;
  AudioClc_tSource *local_30;
  int iStack_2c;
  
  iVar8 = 0;
  piVar7 = (int *)((int)&local_30 - ((u_int)(numclosest << 6) >> 3));
  local_30 = AudioClc_gClosest + closestIndex;
  piVar1 = piVar7;
  if (0 < numclosest) {
    do {
      *piVar1 = 0;
      piVar1[1] = 0x12c0000;
      iVar8 = iVar8 + 1;
      piVar1 = piVar1 + 2;
    } while (iVar8 < numclosest);
  }
  iVar8 = 0;
  ppCVar9 = Cars_gList;
LAB_80075da0:
  if (Cars_gNumCars <= iVar8) {
    iVar8 = 0;
    pAVar3 = local_30;
    if (0 < numclosest) {
      do {
        if (pAVar3->car != (Car_tObj *)0x0) {
          iVar10 = 0;
          piVar1 = piVar7;
          if (0 < numclosest) {
            do {
              if ((Car_tObj *)*piVar1 == pAVar3->car) {
                *piVar1 = 0;
                break;
              }
              iVar10 = iVar10 + 1;
              piVar1 = piVar1 + 2;
            } while (iVar10 < numclosest);
          }
          if (iVar10 == numclosest) {
            pAVar3->car = (Car_tObj *)0xffffffff;
          }
        }
        iVar8 = iVar8 + 1;
        pAVar3 = pAVar3 + 1;
      } while (iVar8 < numclosest);
    }
    iVar8 = 0;
    if (0 < numclosest) {
      do {
        if ((*piVar7 != 0) && (iVar10 = 0, pAVar3 = local_30, 0 < numclosest)) {
          do {
            if ((pAVar3->car == (Car_tObj *)0x0) || (pAVar3->car == (Car_tObj *)0xffffffff)) {
              AudioClc_ResetClosest(iVar10 + closestIndex,(Car_tObj *)*piVar7,playerIndex);
              break;
            }
            iVar10 = iVar10 + 1;
            pAVar3 = pAVar3 + 1;
          } while (iVar10 < numclosest);
        }
        piVar7 = piVar7 + 2;
        iVar8 = iVar8 + 1;
      } while (iVar8 < numclosest);
    }
    iVar8 = 0;
    pAVar3 = local_30;
    if (0 < numclosest) {
      do {
        if (pAVar3->car == (Car_tObj *)0xffffffff) {
          AudioClc_ResetClosest(iVar8 + closestIndex,(Car_tObj *)0x0,playerIndex);
        }
        iVar8 = iVar8 + 1;
        pAVar3 = pAVar3 + 1;
      } while (iVar8 < numclosest);
    }
    return;
  }
  if (GameSetup_gData.commMode == 1) {
    if (((*ppCVar9)->carFlags & 4U) == 0) {
LAB_80075e18:
      pCVar4 = *ppCVar9;
      if ((pCVar4->N).active != '\0') {
        iVar10 = 0x12c0000;
        if ((pCVar4->carFlags & 0x10U) != 0) {
          iVar10 = 0x320000;
        }
        iVar2 = (pCVar4->N).position.x;
        iVar6 = (pCVar4->N).position.y;
        iVar5 = (pCVar4->N).position.z;
        if (iVar2 < 0) {
          iVar2 = -iVar2;
        }
        if (iVar6 < 0) {
          iVar6 = -iVar6;
        }
        if (iVar5 < 0) {
          iVar5 = -iVar5;
        }
        if (iVar5 < iVar2) {
          iVar2 = iVar2 + (iVar5 >> 2);
        }
        else {
          iVar2 = iVar5 + (iVar2 >> 2);
        }
        if ((iVar2 < 0x1900000) &&
           (iVar5 = CopSpeak_GetEnginePatch((*ppCVar9)->carInfo->carType,0), -1 < iVar5)) {
          AudioCmn_GetAsyncSfx(1,iVar5,(void *)0x0);
        }
        if (iVar2 < iVar10) {
          if (iVar2 < iVar6) {
            iVar6 = iVar6 + (iVar2 >> 2);
          }
          else {
            iVar6 = iVar2 + (iVar6 >> 2);
          }
          if ((iVar6 < iVar10) && (iVar10 = 0, piVar1 = piVar7, 0 < numclosest)) {
            do {
              iVar2 = numclosest + -1;
              if (iVar6 < piVar1[1]) goto joined_r80075f4c;
              iVar10 = iVar10 + 1;
              piVar1 = piVar1 + 2;
            } while (iVar10 < numclosest);
          }
        }
      }
    }
  }
  else if (*ppCVar9 != AudioClc_gPlayer[playerIndex].source.car) goto LAB_80075e18;
  goto LAB_80075fa8;
joined_r80075f4c:
  while (iVar10 < iVar2) {
    piVar7[iVar2 * 2] = piVar7[(iVar2 + -1) * 2];
    (piVar7 + iVar2 * 2)[1] = (piVar7 + (iVar2 + -1) * 2)[1];
    iVar2 = iVar2 + -1;
  }
  pCVar4 = *ppCVar9;
  piVar1[1] = iVar6;
  *piVar1 = (int)pCVar4;
LAB_80075fa8:
  iVar8 = iVar8 + 1;
  ppCVar9 = ppCVar9 + 1;
  goto LAB_80075da0;
}

/* ---- AudioClc_SoundSpeech__Fv  [@0x80076130] ---- */
void AudioClc_SoundSpeech(void)
{
  AudioCmn_SetLevels();
  Speech_Server();
  CopSpeak_Server();
  return;
}

/* externs for cross-module symbols not already in audioclc.cpp scope */
extern int HudBustedOverlay;
extern int gMasterAmbientLevel;
void Camera_GetAudioViewInfo(int cviewP, DRender_tCalcView *cview, coorddef **cvel);
void AudioCmn_UpdateThunder(void);

/* ---- AudioClc_SoundCars__Fv  [@0x80076160] ---- RECONSTRUCTED 2026-06-13 from disasm-v3
 *  (Ghidra @NFS4.EXE.c:53952 for structure; ALL helper-call args + the lastview vector-copy
 *  recovered from disasm-v3 0x80076160 — Ghidra had dropped the AudioClc_ helper args and
 *  mis-rendered lastview as =0). Skipped from the AudioClc pass. Per screen: get audio view,
 *  find/sound the closest cars, sound the player's car, save the view position as lastview.
 *  Pursuit "busted" block re-primes perp engine SFX. */
void AudioClc_SoundCars(void)
{
  int i, patch;
  GameSetup_tData *gs;

  AudioClc_SoundSpeech();
  AudioCmn_UpdateThunder();

  if ((GameSetup_gData.raceType == 1 || GameSetup_gData.raceType == 5) &&
      ((Cars_gHumanRaceCarList[0]->carFlags & 0x200) ||
       (Cars_gNumHumanRaceCars == 2 && (Cars_gHumanRaceCarList[1]->carFlags & 0x200))) &&
      HudBustedOverlay != 0) {
    if (0 < GameSetup_gData.numPerps) {
      i = 0;
      do {
        patch = CopSpeak_GetEnginePatch(GameSetup_gData.perpInfo[i].CarType, 0);
        AudioCmn_GetAsyncSfx(1, patch, (void *)0);
        patch = CopSpeak_GetEnginePatch(GameSetup_gData.perpInfo[i].CarType, 1);
        AudioCmn_GetAsyncSfx(1, patch, (void *)0);
        i++;
      } while (i < GameSetup_gData.numPerps);
    }
  }

  if (GameSetup_gData.commMode == 1) {
    /* two-player split screen */
    Camera_GetAudioViewInfo(0, &AudioClc_gRenderView, &AudioClc_gCameraVelocity);
    AudioClc_GetClosestCars(0, 0, 2);
    AudioClc_SoundPlayersCar(0);
    if (0 < gMasterAmbientLevel) {
      AudioClc_SoundCloseCar(0, 0);
      AudioClc_SoundCloseCar(0, 1);
    }
    AudioClc_gPlayer[0].lastview = AudioClc_gRenderView.translation;

    Camera_GetAudioViewInfo(1, &AudioClc_gRenderView, &AudioClc_gCameraVelocity);
    AudioClc_GetClosestCars(1, 2, 2);
    AudioClc_SoundPlayersCar(1);
    if (0 < gMasterAmbientLevel) {
      AudioClc_SoundCloseCar(1, 2);
      AudioClc_SoundCloseCar(1, 3);
    }
    AudioClc_gPlayer[1].lastview = AudioClc_gRenderView.translation;
  } else {
    /* single screen */
    Camera_GetAudioViewInfo(0, &AudioClc_gRenderView, &AudioClc_gCameraVelocity);
    AudioClc_GetClosestCars(0, 0, 4);
    AudioClc_SoundPlayersCar(0);
    if (0 < gMasterAmbientLevel) {
      AudioClc_SoundCloseCar(0, 0);
      AudioClc_SoundCloseCar(0, 1);
      AudioClc_SoundCloseCar(0, 2);
      AudioClc_SoundCloseCar(0, 3);
    }
    AudioClc_gPlayer[0].lastview = AudioClc_gRenderView.translation;
  }
}
