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
      if (state != 0) {
        pAVar2->horn = 1;
        pAVar2->hornOn = 0;
      }
      else if (pAVar2->horn != 0) {
        pAVar2->horn = 1;
        pAVar2->hornOn = 1;
        pAVar2->hornCount = 1;
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
    if ((pAVar2->car == car) && (pAVar2->horn == 0)) {
      pAVar2->horn = ticksOn;
      pAVar2->hornOn = ticksOn;
      pAVar2->hornOff = -ticksOff;
      pAVar2->hornCount = numBeeps;
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

  p = AudioClc_gPlayer;
  c = AudioClc_gClosest;
  i = 0;
  AudioClc_gRandomPhrase = 0;
  AudioClc_gBullHornCount = 0;
  AudioClc_gBumpCopCount = 0;
  AudioClc_gLastVoice = -1;
  AudioClc_gLastphrase1 = -1;
  AudioClc_gLastphrase2 = -1;
  AudioClc_gLastphrase3 = -1;
  do {
    p->cameraMode = -1;
    p->gameTicks = 0;
    p->warnings = 0;
    AudioClc_InitSource(&p->source,(Car_tObj *)0x0);
    if (GameSetup_gData.commMode >= 2) {
      if ((i == 0) && (GameSetup_gData.localCar < Cars_gNumHumanRaceCars)) {
        p->source.car = Cars_gHumanRaceCarList[GameSetup_gData.localCar];
      }
    }
    else if (i < Cars_gNumHumanRaceCars) {
      p->source.car = Cars_gHumanRaceCarList[i];
    }
    i = i + 1;
    p = p + 1;
  } while (i < 2);
  i = 0;
  do {
    AudioClc_InitSource(c,(Car_tObj *)0x0);
    i = i + 1;
    c = c + 1;
  } while (i < 4);
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

  cameraPos = &AudioClc_gRenderView.translation;
  cameraVel = AudioClc_gCameraVelocity;
  vectorToSound.x = (objectPos->x - cameraPos->x) >> 8;
  vectorToSound.y = (objectPos->y - cameraPos->y) >> 8;
  vectorToSound.z = (objectPos->z - cameraPos->z) >> 8;
  Math_NormalizeVector(&vectorToSound);
  relativeVelocity = 0;
  if (objectVel != (coorddef *)0x0) {
    relativeVelocity =
        vectorToSound.x / 256 * (objectVel->x / 256) +
        vectorToSound.y / 256 * (objectVel->y / 256) +
        vectorToSound.z / 256 * (objectVel->z / 256);
  }
  if (cameraVel != (coorddef *)0x0) {
    relativeVelocity = relativeVelocity -
        (vectorToSound.x / 256 * (cameraVel->x / 256) +
         vectorToSound.y / 256 * (cameraVel->y / 256) +
         vectorToSound.z / 256 * (cameraVel->z / 256));
  }
  return fixeddiv(0x1540000,relativeVelocity + 0x1540000);
}

/* ---- AudioClc_CalcDistance__FP17DRender_tCalcViewP8coorddef  [@0x80074b60] ---- */
int AudioClc_CalcDistance(DRender_tCalcView *view,coorddef *object)
{
  int x;
  int y;
  int z;
  int length;
  int length1;

  x = object->x - (view->translation).x;
  y = object->y - (view->translation).y;
  z = object->z - (view->translation).z;
  x = __builtin_abs(x);
  y = __builtin_abs(y);
  z = __builtin_abs(z);
  if (z < x) {
    length = x + (z >> 2);
  }
  else {
    length = z + (x >> 2);
  }
  if (length < y) {
    length1 = y + (length >> 2);
  }
  else {
    length1 = length + (y >> 2);
  }
  return length1;
}

/* ---- AudioClc_CalcAzimuth__FP17DRender_tCalcViewP8coorddef  [@0x80074be8] ---- */
int AudioClc_CalcAzimuth(DRender_tCalcView *view,coorddef *object)
{
  coorddef temp;
  int x;
  int y;

  temp.x = object->x - (view->translation).x;
  temp.y = object->y - (view->translation).y;
  temp.z = object->z - (view->translation).z;
  x = temp.x / 256 * ((view->mrotation).m[0] / 256) +
      temp.y / 256 * ((view->mrotation).m[1] / 256) +
      temp.z / 256 * ((view->mrotation).m[2] / 256);
  y = temp.x / 256 * ((view->mrotation).m[6] / 256) +
      temp.y / 256 * ((view->mrotation).m[7] / 256) +
      temp.z / 256 * ((view->mrotation).m[8] / 256);
  if (GameSetup_gData.mirrorTrack != 0) {
    x = -x;
  }
  return (intatan(x >> 8,y >> 8) << 6) & 0xffc0;
}

/* ---- AudioClc_CalcCarDirection__FP17DRender_tCalcViewP8Car_tObj  [@0x80074d50] ---- */
int AudioClc_CalcCarDirection(DRender_tCalcView *view,Car_tObj *car)
{
  coorddef temp;

  temp.x = (car->N).position.x - (view->translation).x;
  temp.y = (car->N).position.y - (view->translation).y;
  temp.z = (car->N).position.z - (view->translation).z;
  return temp.x / 256 * ((car->N).orientMat.m[6] / 256) +
         temp.y / 256 * ((car->N).orientMat.m[7] / 256) +
         temp.z / 256 * ((car->N).orientMat.m[8] / 256);
}

/* ---- AudioClc_CalcTrackAzimuth__FP17DRender_tCalcViewP8Car_tObj  [@0x80074e24] ---- */
int AudioClc_CalcTrackAzimuth(DRender_tCalcView *view,Car_tObj *car)
{
  int x;
  int y;

  x = (car->N).roadMatrix.m[6] / 256 * ((view->mrotation).m[0] / 256) +
      (car->N).roadMatrix.m[7] / 256 * ((view->mrotation).m[1] / 256) +
      (car->N).roadMatrix.m[8] / 256 * ((view->mrotation).m[2] / 256);
  y = (car->N).roadMatrix.m[6] / 256 * ((view->mrotation).m[6] / 256) +
      (car->N).roadMatrix.m[7] / 256 * ((view->mrotation).m[7] / 256) +
      (car->N).roadMatrix.m[8] / 256 * ((view->mrotation).m[8] / 256);
  if (GameSetup_gData.mirrorTrack != 0) {
    x = -x;
  }
  return (intatan(x >> 8,y >> 8) << 6) & 0xffc0;
}

/* ---- AudioClc_SoundOpponentHorn__Fiiii  [@0x80074f5c] ---- */
void AudioClc_SoundOpponentHorn(int closestIndex,int azimuth,int dop,int dsquare)
{
  AudioClc_tSource*source;
  int cartype;
  int carhornSFX;
  static char trafficFreqs[50] = {
    0x58,0x50,0x46,0x41,0x3c,0x32,0x55,0x5a,0x3c,0x2d,
    0x5a,0x32,0x55,0x4b,0x54,0x4a,0x32,0x46,0x2d,0x48,
    0x3c,0x3c,0x37,0x46,0x3c,0x2d,0x32,0x4b,0x41,0x52,
    0x48,0x3c,0x56,0x22,0x2f,0x52,0x2f,0x50,0x1e,0x1e,
    0x40,0x4a,0x37,0x32,0x34,0x34,0x3e,0x15,0x40,0x15
  };
  int iamp;
  
  source = AudioClc_gClosest + closestIndex;
  cartype = source->car->carInfo->carType;
  carhornSFX = 10;
  if (cartype == 0x30) {
    carhornSFX = 0xb;
  }
  iamp = ((0x1324 - dsquare) * 0x7f) / 0x1324;
  AudioCmn_PlaySFX(closestIndex + 0x25,carhornSFX,
             (u_int)trafficFreqs[cartype],dop,iamp,azimuth);
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
  AudioClc_tSource *source;
  Car_tObj *car;
  int dsquare;
  int distSq;
  int dop;
  int dst;
  int dir;
  int azimuth;

  source = &AudioClc_gClosest[closestIndex];
  car = source->car;
  if (car == (Car_tObj *)0x0) {
    return;
  }
  dop = AudioClc_CalcDopplerShiftRatio(&(car->N).position,&(car->N).linearVel);
  if (dop < 0) {
    return;
  }
  dst = AudioClc_CalcDistance(&AudioClc_gRenderView,&(car->N).position);
  dir =
      (((fixeddiv(AudioClc_CalcCarDirection(&AudioClc_gRenderView,car),dst) <
          0x10001) ?
         fixeddiv(AudioClc_CalcCarDirection(&AudioClc_gRenderView,car),dst) :
         0x10000) >= -0x10000) ?
        ((fixeddiv(AudioClc_CalcCarDirection(&AudioClc_gRenderView,car),dst) <
          0x10001) ?
         fixeddiv(AudioClc_CalcCarDirection(&AudioClc_gRenderView,car),dst) :
         0x10000) :
        -0x10000;
  if (GameSetup_gData.commMode == 1) {
    azimuth = 0x3fff;
    if (playerIndex == 0) {
      azimuth = 0xc000;
    }
  }
  else {
    azimuth = AudioClc_CalcAzimuth(&AudioClc_gRenderView,&(car->N).position);
  }
  dsquare = dst / 0x10000;
  dsquare *= dsquare;
  distSq = 0x1324;
  if (dsquare < 0x1324) {
    distSq = dsquare;
  }
  if (AudioClc_gCameraVelocity != (coorddef *)0x0) {
    source->relVelocity =
        ((car->currentSpeed -
          AudioClc_gPlayer[playerIndex].source.car->currentSpeed) > 0) ?
        (car->currentSpeed -
         AudioClc_gPlayer[playerIndex].source.car->currentSpeed) :
        (AudioClc_gPlayer[playerIndex].source.car->currentSpeed -
         car->currentSpeed);
  }
  else {
    source->relVelocity = __builtin_abs(car->currentSpeed);
  }
  source->distSq = distSq;
  AudioCmn_TrafficSFX(closestIndex + 6,car->carInfo->carType,
                      (car->flywheelRpm << 0x10) / car->specs->redline,
                      dop,dst,azimuth,__builtin_abs((car->linearVel_ch).z),dir);
  {
    int c;

    c = car->audioCount - 1;
    while (c >= 0) {
      if (car->audio[c].channel >= 0) {
        AudioCmn_TrafficSkidSFX(closestIndex + 0x20,
            (s_type)car->audio[c].surface1,(s_type)car->audio[c].surface2,
            car->audio[c].force,dsquare,azimuth);
      }
      else {
        AudioCmn_TrafficSkidSFX(-1,
            (s_type)car->audio[c].surface1,(s_type)car->audio[c].surface2,
            car->audio[c].force,distSq,azimuth);
      }
      c--;
    }
  }
  if ((car->carFlags & 4U) != 0) {
    if ((car->control).horn != '\0') {
      AudioClc_SoundOpponentHorn(closestIndex,azimuth,dop,distSq);
      source->horn = 1;
    }
    else if (source->horn != 0) {
      AudioClc_SilenceOpponentHorn(closestIndex);
      source->horn = 0;
    }
  }
  else {
    if (0 < source->horn) {
      if (0 < source->hornOn) {
        source->horn--;
      }
      if (source->horn == 0) {
        (car->control).horn = '\0';
        AudioClc_SilenceOpponentHorn(closestIndex);
        source->hornCount--;
        if (source->hornCount != 0) {
          source->horn = source->hornOff;
        }
      }
      else {
        (car->control).horn = '\x01';
        AudioClc_SoundOpponentHorn(closestIndex,azimuth,dop,distSq);
      }
    }
    else if (source->horn < 0) {
      source->horn++;
      if (source->horn == 0) {
        source->horn = source->hornOn;
      }
    }
  }
  if (car->carInfo->carType - 0x16U < 6) {
    if ((car->AIFlags & 2U) != 0) {
      int iamp;

      iamp = ((0x1324 - distSq) * 0x7f) / 0x1324;
      if (bSirenOn[closestIndex] == 0) {
        SirenOn(closestIndex,car->carFlags & 0x40);
      }
      else {
        UpdateSiren(closestIndex,iamp,dop,azimuth,
                 car->carFlags & 0x40);
      }
    }
    else {
      if (bSirenOn[closestIndex] != 0) {
        SirenOff(closestIndex);
        freeVoiceChannel(closestIndex + 0x2b);
      }
    }
  }
  return;
}

/* ---- AudioClc_SoundPlayersCar__Fi  [@0x80075508] ---- */
/* MATCH: PASS 461/461 via the per-fn -fno-thread-jumps splice (build.py
 * PER_FN_NO_THREAD_JUMPS, 2026-08-08).  The 4-diff residual was gcc's
 * thread_jumps pass redirecting the `(type==5||type==3) && (channel>=0)`
 * fail edge PAST the else-if chain's `bgez channel` re-test; the threaded
 * entry label between the bgez and the commMode compare blocked the
 * delay-slot fill (`bgez; nop; lw; li` vs retail's unthreaded
 * `bgez; li(slot); lw; nop`).  Retail's compile did not thread this edge;
 * no source spelling reaches that (both branch layouts are identical at
 * the label level) -- same per-fn-flag precedent as
 * PER_FN_NO_DELAYED_BRANCH. */
void AudioClc_SoundPlayersCar(int playerIndex)
{
  DRender_tCalcView *view;
  AudioClc_tSource *previous;
  Car_tObj *car;
  int azimuth;
  int dsquare;
  int frequency;
  int dop;
  int dst;
  int facing;
  int cardir;
  int trkazi;

  view = &AudioClc_gRenderView;
  previous = &AudioClc_gPlayer[playerIndex].source;
  car = previous->car;
  if (car == (Car_tObj *)0x0) {
    return;
  }
  facing = 0;
  if ((car->carFlags & 0x200U) != 0) {
    if (car->desiredDirection != car->direction) {
      facing = -1;
    }
  }
  else {
    facing = fixedmult((car->N).orientMat.m[6],
                       (int)*(signed char *)((car->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices + 0xf)) +
             fixedmult((car->N).orientMat.m[7],
                       (int)*(signed char *)((car->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices + 0x10)) +
             fixedmult((car->N).orientMat.m[8],
                       (int)*(signed char *)((car->N).simRoadInfo.slice * 0x20 + (int)BWorldSm_slices + 0x11));
    if (GameSetup_gData.reverseTrack != 0) {
      facing = -facing;
    }
  }
  if (((car->stats).finishType != 2) &&
     (!((((GameSetup_gData.raceType == 1 || (GameSetup_gData.raceType == 5)) &&
        ((((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0 ||
         ((Cars_gNumHumanRaceCars == 2 && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)))))) &&
       ((car->carFlags & 0x204U) == 4)))) &&
      (car->RSControl == 0) && (car->pullOver == 0) && (facing < 0)) {
    if (((car->N).flightTime == 0) && ((car->collision).smoking == 0)) {
      car->wrongway++;
      if (((0x3f < car->wrongway) && ((car->wrongway & 0x1f) == 0)) &&
         ((car->wrongway < 0x94 || (Hud_BeTheCop != 0)))) {
        AudioCmn_PlayWrongWaySFX();
      }
    }
  }
  else {
    car->wrongway = 0;
  }
  dop = AudioClc_CalcDopplerShiftRatio(&(car->N).position,&(car->N).linearVel);
  if (GameSetup_gData.commMode == 1) {
    azimuth = 0xc000;
    if (playerIndex != 0) {
      azimuth = 0x3fff;
    }
  }
  else if (Camera_gInfo[playerIndex].mode == 0) {
    azimuth = 0;
  }
  else {
    azimuth = AudioClc_CalcAzimuth(view,&(car->N).position);
  }
  dst = AudioClc_CalcDistance(view,&(car->N).position);
  cardir =
      (((fixeddiv(AudioClc_CalcCarDirection(view,car),dst) < 0x10001) ?
         fixeddiv(AudioClc_CalcCarDirection(view,car),dst) : 0x10000) >=
       -0x10000) ?
      ((fixeddiv(AudioClc_CalcCarDirection(view,car),dst) < 0x10001) ?
       fixeddiv(AudioClc_CalcCarDirection(view,car),dst) : 0x10000) :
      -0x10000;
  dsquare = dst / 0x10000;
  dsquare *= dsquare;
  {
    int revLimit;

    if (car->carInfo->Transmission == 1) {
      revLimit = car->specs->redline + 1000;
    }
    else {
      revLimit = car->specs->redline + 2000;
    }
    if (5 < (car->N).flightTime) {
      revLimit -= 500;
    }
    frequency = (car->flywheelRpm * 0x7f) / revLimit;
  }
  if (AudioClc_gCameraVelocity != (coorddef *)0x0) {
    previous->relVelocity = 0;
  }
  else {
    previous->relVelocity = __builtin_abs(car->currentSpeed);
  }
  trkazi = AudioClc_CalcTrackAzimuth(view,car);
  AudioTrk_SoundTrack(car,trkazi);
  AudioCmn_SoundCar(car,dst,frequency,dop,azimuth,trkazi,
             previous->relVelocity,cardir);
  if (gMasterSFXLevel == 0) {
    return;
  }
  {
    int c;
    int channel;

    c = car->audioCount - 1;
    while (c >= 0) {
      if (car->audio[c].channel == 0x12) {
        channel = 0x12;
        if (playerIndex != 0) {
          channel = 0x13;
        }
      }
      else if (car->audio[c].channel == 0x14) {
        channel = 0x14;
        if (playerIndex != 0) {
          channel = 0x15;
        }
      }
      else {
        channel = car->audio[c].channel;
      }
      if (((car->audio[c].type == 5) ||
           (car->audio[c].type == 3)) && (channel >= 0)) {
        freeVoiceChannel(channel);
        if (channel - 0x12U < 2) {
          freeVoiceChannel(channel + 4);
        }
      }
      else if ((channel < 0) && (GameSetup_gData.commMode != 1) &&
               (car->audio[c].surface1 != 10) &&
               (car->audio[c].surface1 != 8)) {
        AudioCmn_SFX(channel,car->audio[c].surface1,
                     car->audio[c].surface2,car->audio[c].force,
                     dsquare,
                     AudioClc_CalcAzimuth(view,
                       &(car->N).collision.collisionPoint));
      }
      else {
        AudioCmn_SFX(channel,car->audio[c].surface1,
                     car->audio[c].surface2,car->audio[c].force,
                     dsquare,azimuth);
      }
      c--;
    }
  }
  if ((car->control).horn != '\0') {
    AudioCmn_PlayerHornOn(car->carIndex,dsquare,0x40,azimuth,dop);
    previous->horn = 1;
  }
  else if (previous->horn != 0) {
    previous->horn = AudioCmn_PlayerHornOff(car->carIndex);
  }
  if (car->carInfo->carType - 0x16U < 6) {
    if ((car->AIFlags & 2U) != 0) {
      int iamp;

      if (dsquare < 0x1324) {
        iamp = ((0x1324 - dsquare) * 0x7f) / 0x1324;
      }
      else {
        iamp = 0;
      }
      if (bSirenOn[car->carIndex + 4] == 0) {
        SirenOn(car->carIndex + 4,car->carFlags & 0x40);
      }
      else {
        UpdateSiren(car->carIndex + 4,iamp,dop,azimuth,
                    car->carFlags & 0x40);
      }
    }
    else {
      if (bSirenOn[car->carIndex + 4] != 0) {
        SirenOff(car->carIndex + 4);
        freeVoiceChannel(car->carIndex + 0x2f);
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
/* MATCH: FAIL 3 (268/267), was 17 -- 2026-08-08 round: three SYM/source
 * truths landed: (1) `__builtin_abs` for the x/y/z folds (17->5; same
 * spelling as the PASSing CalcDistance -- the if(x<0)x=-x form rotated the
 * whole abs region); (2) C++ MIXED-DECL order per the SYM symbol list:
 * `closest` DECL-WITH-INIT *before* the `cl[numclosest]` VLA decl (5->3;
 * the alloca's sp-sub is prologue-hoisted but the s6=sp+16 base BIND stays
 * at the decl point, after the closest computation = retail order);
 * (3) searchdist/patch block-scoped per SYM.  RESIDUAL 3 = ONE extra lui:
 * our translation.x (offset 0) folds to (mem (lo_sum high sym)) with its
 * own high-pseudo, while y/z (+4/+8, not lo_sum-offsettable) force the
 * full address -> loop.c hoists it (p149, REG_EQUIV) -> reload remats as
 * the `la t1`; retail routes the x-load through that shared base too
 * (`lw v0,0(t1)`), ours keeps TWO identical (high sym) pseudos un-merged
 * (expand-created vs loop-created -- never in one cse scope; loop.c
 * combine_movables didn't merge them).  FALSIFIED: y,z,x / z-first orders
 * (120/30 diffs @count-EXACT 267 -- base-reuse works but defs rotate),
 * operand swaps, split stmt, cast-ptr (FE folds back), abs interleave,
 * whole-TU no_split_addresses (9 PASSes break), -fforce-addr (same double
 * lui).  Route: instrument loop.c combine_movables (r11-style) or accept.
 * W59-A4 adds two more falsifications on the same 3: a plain
 * `coorddef *viewpos = &AudioClc_gRenderView.translation;` local with x/y/z read
 * through it is INERT (3 -- the FE folds it back exactly as the cast-ptr note
 * says), and the same local laundered with an identity fence
 * `__asm__("" : "=r"(viewpos) : "0"(viewpos))` REGRESSES to 29 (the opaque base
 * un-CSEs the y/z pair and rotates the whole abs region).  Route unchanged. */
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
  Car_tObj **car;
  AudioClc_tSource *closest = AudioClc_gClosest + closestIndex;
  AudioClc_tCLCache cl[numclosest];

  for (i = 0; i < numclosest; i++) {
    cl[i].ptr = 0;
    cl[i].dst = 0x12c0000;
  }

  i = 0;
  car = Cars_gList;
  while (i < Cars_gNumCars) {
    if (GameSetup_gData.commMode == 1) {
      if (((*car)->carFlags & 4U) != 0) {
        goto AudioClc_nextCar;
      }
    }
    else if (*car == AudioClc_gPlayer[playerIndex].source.car) {
      goto AudioClc_nextCar;
    }

    if ((*car)->N.active != 0) {
        int searchdist;

        searchdist = 0x12c0000;
        if (((*car)->carFlags & 0x10U) != 0) {
          searchdist = 0x320000;
        }

        x = (*car)->N.position.x - AudioClc_gRenderView.translation.x;
        y = (*car)->N.position.y - AudioClc_gRenderView.translation.y;
        z = (*car)->N.position.z - AudioClc_gRenderView.translation.z;
        x = __builtin_abs(x);
        y = __builtin_abs(y);
        z = __builtin_abs(z);

        if (z < x) {
          distance = x + (z >> 2);
        }
        else {
          distance = z + (x >> 2);
        }

        if (distance < 0x1900000) {
          int patch;

          patch = CopSpeak_GetEnginePatch((*car)->carInfo->carType,0);
          if (patch >= 0) {
            AudioCmn_GetAsyncSfx(1,patch,(void *)0);
          }
        }

        if (distance < searchdist) {
          if (distance < y) {
            distance1 = y + (distance >> 2);
          }
          else {
            distance1 = distance + (y >> 2);
          }

          if (distance1 < searchdist) {
            for (j = 0; j < numclosest; j++) {
              if (distance1 < cl[j].dst) {
                for (k = numclosest - 1; k > j; k--) {
                  cl[k].ptr = cl[k - 1].ptr;
                  cl[k].dst = cl[k - 1].dst;
                }
                cl[j].ptr = *car;
                cl[j].dst = distance1;
                break;
              }
            }
          }
        }
    }

AudioClc_nextCar:
    i++;
    car++;
  }

  for (i = 0; i < numclosest; i++) {
    if (closest[i].car != 0) {
      for (j = 0; j < numclosest; j++) {
        if (cl[j].ptr == closest[i].car) {
          cl[j].ptr = 0;
          break;
        }
      }
      if (j == numclosest) {
        closest[i].car = (Car_tObj *)-1;
      }
    }
  }

  for (i = 0; i < numclosest; i++) {
    if (cl[i].ptr != 0) {
      for (j = 0; j < numclosest; j++) {
        if ((closest[j].car == 0) || (closest[j].car == (Car_tObj *)-1)) {
          AudioClc_ResetClosest(j + closestIndex,cl[i].ptr,playerIndex);
          break;
        }
      }
    }
  }

  for (i = 0; i < numclosest; i++) {
    if (closest[i].car == (Car_tObj *)-1) {
      AudioClc_ResetClosest(i + closestIndex,0,playerIndex);
    }
  }
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

  AudioClc_SoundSpeech();
  AudioCmn_UpdateThunder();

  if ((GameSetup_gData.raceType == 1 || GameSetup_gData.raceType == 5) &&
      ((Cars_gHumanRaceCarList[0]->carFlags & 0x200) ||
       (Cars_gNumHumanRaceCars == 2 && (Cars_gHumanRaceCarList[1]->carFlags & 0x200))) &&
      HudBustedOverlay != 0) {
    /* MATCH: PASS 176/176 (2026-08-08, was FAIL 2 under a w30-a6 "pure
     * allocator artifact" floor verdict + 505-iter permuter).  Three SYM
     * truths cracked it together: NO `gs`/`patch` locals (SYM block lists
     * only `i` -- the calls are NESTED, v0->a1 directly), `i` block-scoped,
     * and the loop written as a plain `for` (its rotated guard makes
     * loop.c's strength-reduction giv-init source the HOISTED base pseudo
     * -> `addu s0,s2` chain; the old explicit if+do-while sourced the
     * address temp -> `addu s0,a1` = the whole 2-diff residual). */
    {
      int i;

      for (i = 0; i < GameSetup_gData.numPerps; i++) {
        AudioCmn_GetAsyncSfx(1, CopSpeak_GetEnginePatch(GameSetup_gData.perpInfo[i].CarType, 0), (void *)0);
        AudioCmn_GetAsyncSfx(1, CopSpeak_GetEnginePatch(GameSetup_gData.perpInfo[i].CarType, 1), (void *)0);
      }
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
