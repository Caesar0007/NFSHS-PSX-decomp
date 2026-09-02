#define AudioClc_SoundPlayersCar AudioClc_SoundPlayersCar_base
#include "../../../../recon/game/common/audioclc.cpp"
#undef AudioClc_SoundPlayersCar

extern int Hud_gStatsView;

extern "C" void func_80075F28(int playerIndex)
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
     (!((((GameSetup_gData.raceType == RaceType_HotPursuit || (GameSetup_gData.raceType == RaceType_Id5)) &&
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
  if (Hud_gStatsView == 0) {
    goto azimuth_zero;
  }
  if (GameSetup_gData.commMode == 1) {
    azimuth = 0xc000;
    if (playerIndex != 0) {
      azimuth = 0x3fff;
    }
    goto azimuth_done;
  }
  if (Camera_gInfo[playerIndex].mode != 0) {
    goto azimuth_calc;
  }
azimuth_zero:
  azimuth = 0;
  goto azimuth_done;
azimuth_calc:
  azimuth = AudioClc_CalcAzimuth(view,&(car->N).position);
azimuth_done:
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
      else {
        if (((channel & (int)0x80000000U) != 0) &&
            (GameSetup_gData.commMode != 1) &&
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
}
