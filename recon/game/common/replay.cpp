/* game/psx/replay.cpp -- RECONSTRUCTED (NFS4 PSX replay record/playback system; C++ TU)
 *   6 fns: Scene_Init/DeInit/PurgeScene/BuildCustomSceneList/LoadSceneFile + GetPlaneY.
 *   GTE-free. Full SYM-locals applied.
 */
#include "../../nfs4_types.h"
#include "replay_externs.h"

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
int Replay_ReplayGetPtr;
int Replay_ReplayMode;
int Replay_ReplayStorePtr;
int Replay_Size;
int numValidCams;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
char * Replay_Compress(char *uncompressed_data);
char * Replay_Decompress(char *compressed_data);
void Replay_InitReplay(void);
void Replay_ResetReplay(void);
void Replay_StoringReplay(void);
void Replay_StoringControllerData(tControllerData controllerdata);
tControllerData Replay_RetreivingControllerData(void);
void Replay_SaveInput(int car);
void Replay_GetInput(int car);
void Replay_SaveReplay(void);
void Replay_LoadReplay(void);
void Replay_DoReplay(Car_tObj *carObj);
void Replay_GetInterfaceKey(void);
void Replay_LoadCameraFile(void);
void Replay_ReplayChooseCamera(int player,int slice);
void Replay_ReplayFindClosestCamera(int player,int slice);


/* ---- Replay_Compress__FPc  [REPLAY.CPP:72-121] SLD-VERIFIED ---- */
char * Replay_Compress(char *uncompressed_data)

{
  /* SYM lists exactly five source locals: i, done, count, c_pointer, and begin_byte.
   * The marker and paired end cursors expose unnamed retail invariant temporaries; the
   * duplicated end value is required for the inner and outer pointer comparisons. */
  int i;
  int done;
  int count;
  register int c_pointer;
  char begin_byte;
  char marker;
  char *end;
  char *innerEnd;

  done = 0;
  c_pointer = 1;
  marker = (char)0xff;
  end = uncompressed_data + 0x20;
  innerEnd = end;
  do {
    begin_byte = *uncompressed_data;
    count = 0;
    do {
      uncompressed_data = uncompressed_data + 1;
      count = count + 1;
    } while ((*uncompressed_data == begin_byte) &&
             ((int)uncompressed_data < (int)innerEnd));
    if (count >= 3) {
      compressed_data[c_pointer] = marker;
      compressed_data[c_pointer + 1] = (char)count;
      compressed_data[c_pointer + 2] = begin_byte;
      c_pointer = c_pointer + 3;
    }
    else {
      i = 0;
      if (0 < count) {
        do {
          compressed_data[c_pointer] = begin_byte;
          c_pointer = c_pointer + 1;
          i = i + 1;
        } while (i < count);
      }
    }
    if ((int)end <= (int)uncompressed_data) {
      done = 1;
    }
  } while (!done);
  compressed_data[0] = (char)c_pointer;
  compressed_data[c_pointer] = '\0';
  return compressed_data;
}

/* ---- Replay_Decompress__FPc  [REPLAY.CPP:127-161] SLD-VERIFIED ---- */
char * Replay_Decompress(char *compressed_data)

{
  /* SYM (nfs4-f-v3.txt) Function-start block for this VA lists exactly 5 REG locals:
   * i, data_size, count, c_pointer, current_byte -- no pointer-typed locals. The compressed-
   * side read position is therefore a plain int ARRAY INDEX (c_pointer), not a walked pointer;
   * only the uncompressed-side write cursor is a genuine anonymous pointer temp (no SYM entry). */
  int i;
  int count;
  char current_byte;
  int c_pointer;
  int data_size;
  char *pcVar4;

  data_size = (int)(u_char)*compressed_data;
  c_pointer = 1;
  if (c_pointer < data_size) {
    pcVar4 = uncompressed_data;
    do {
      current_byte = compressed_data[c_pointer];
      /* char is UNSIGNED on this build (lbu even for plain char): the RLE marker byte is 0xFF,
       * so test it as an UNSIGNED byte against 0xff (not a signed -1 cast, which needs a 2nd
       * signed lb re-read of the same byte and diverges from the oracle's single lbu compare). */
      if ((u_char)current_byte == 0xff) {
        count = (int)(u_char)compressed_data[c_pointer + 1];
        i = 0;
        if (count != 0) {
          do {
            i = i + 1;
            *pcVar4 = compressed_data[c_pointer + 2];
            pcVar4 = pcVar4 + 1;
          } while (i < count);
        }
        c_pointer = c_pointer + 3;
      }
      else {
        *pcVar4 = current_byte;
        pcVar4 = pcVar4 + 1;
        c_pointer = c_pointer + 1;
      }
    } while (c_pointer < data_size);
  }
  return uncompressed_data;
}

/* ---- Replay_InitReplay__Fv  [REPLAY.CPP:169-194] SLD-VERIFIED ---- */
void Replay_InitReplay(void)

{
  GameSetup_tUserSetting temp;

  Replay_ReplayMode = GameSetup_gData.replayMode;
  Replay_LoadCameraFile();
  if (Replay_ReplayMode == 2) {
    temp = GameSetup_gData.userSetting;
    Replay_LoadReplay();
    GameSetup_gData = Replay_ReplayBuffer.gameSetup;
    GameSetup_gData.userSetting = temp;
    Replay_ReplayGetPtr = 0;
    Replay_Size = Replay_ReplayBuffer.size;
  }
  else {
    Replay_ReplayBuffer.gameSetup = GameSetup_gData;
  }
  return;
}

/* ---- Replay_ResetReplay__Fv  [REPLAY.CPP:202-264] SLD-VERIFIED ---- */
void Replay_ResetReplay(void)

{
  /* SYM (nfs4-f-v3.txt) lists exactly ONE local for this whole function: `i` (REG INT), one
   * flat block spanning the entire body -- the true source reuses a SINGLE int counter across
   * all three loops below (buffer clear / camera-mode init / ReplayCounter clear), not three
   * separate Ghidra-named ints. The buffer-clear loop's address is a genuine anonymous pointer
   * walk (oracle strength-reduces base+i into a decrementing pointer, §3.12 #1). The camera
   * loop is source-level Cars_gHumanRaceCarList[i]; gcc strength-reduces that index to the
   * oracle's incrementing $s2 cursor and hoists it after the GameSetup/ReplayCamera bases. */
  int i;
  char *pBuf;
  int iVar1;
  int *piVar2;
  tReplayCameraModes *cam_walk;

  if ((u_int)Replay_ReplayMode < 2) {
    i = 0x5fff;
    pBuf = (char *)&Replay_ReplayBuffer + i;
    do {
      ((tReplayBuffer *)pBuf)->buffer[0] = 0;
      pBuf = pBuf - 1;
      i = i + -1;
    } while (-1 < i);
    Replay_ReplayStorePtr = 0;
    Replay_ReplayGetPtr = 0;
  }
  else if (1 < Replay_ReplayMode) {
    i = 0;
    Replay_ReplayInterface.pause = 0;
    Replay_ReplayInterface.speed = 2;
    Replay_ReplayGetPtr = 0;
    Replay_ReplayInterface.end = 0;
    Replay_ReplayInterface.camera = 0;
    Replay_ReplayInterface.selection = 4;
    Replay_ReplayInterface.depressed = 0;
    Replay_ReplayInterface.changeCamera = 0;
    do {
      if (numValidCams != 0) {
        if ((GameSetup_gData.commMode == 1) || (i == 0)) {
          Replay_ReplayFindClosestCamera(i,(int)Cars_gHumanRaceCarList[i]->N.simRoadInfo.slice);
        }
        iVar1 = 0x13;
      }
      else {
        iVar1 = 4;
      }
      Replay_ReplayCamera[i].cameraMode = iVar1;
      Replay_ReplayCamera[i].cutToNextCamera = 0;
      i = i + 1;
    } while (i < 2);
  }
  i = 1;
  piVar2 = Replay_ReplayCounter + 1;
  do {
    *piVar2 = 0;
    i = i + -1;
    piVar2 = piVar2 + -1;
  } while (-1 < i);
  StatsTimer = 0;
  D_8013D99C = 0;
  return;
}

/* ---- Replay_StoringReplay__Fv  [REPLAY.CPP:270-275] SLD-VERIFIED ---- */
void Replay_StoringReplay(void)

{
  Replay_SaveReplay();
  numValidCams = 0;
  return;
}

/* ---- Replay_StoringControllerData__FG15tControllerData  [REPLAY.CPP:283-307] SLD-VERIFIED ---- */
void Replay_StoringControllerData(tControllerData controllerdata)

{
  /* struct-assignment (not the hand-written unaligned-copy bit-math below) reproduces the
   * oracle's inline movstrsi expansion for an unknown-alignment 33-byte copy (aligned lw/sw
   * fast path + lwl/lwr..swl/swr slow path + 1-byte tail). See catalog §D / sst.cpp precedent. */
  struct PackedBuf33 { char b[33]; };
  char packeddata [33];

  if (0x6000 <= Replay_ReplayStorePtr + 0x80) {
    Replay_ReplayMode = 1;
    Replay_Size = simGlobal.gameTicks;
    return;
  }
  *(struct PackedBuf33 *)packeddata = *(struct PackedBuf33 *)Replay_Compress(controllerdata.steering);
  memcpy(Replay_ReplayBuffer.buffer + Replay_ReplayStorePtr,packeddata,(u_int)(u_char)packeddata[0]);
  Replay_ReplayStorePtr = Replay_ReplayStorePtr + (u_int)(u_char)packeddata[0];

  *(struct PackedBuf33 *)packeddata = *(struct PackedBuf33 *)Replay_Compress((char *)controllerdata.gas);
  memcpy(Replay_ReplayBuffer.buffer + Replay_ReplayStorePtr,packeddata,(u_int)(u_char)packeddata[0]);
  Replay_ReplayStorePtr = Replay_ReplayStorePtr + (u_int)(u_char)packeddata[0];

  *(struct PackedBuf33 *)packeddata = *(struct PackedBuf33 *)Replay_Compress((char *)controllerdata.brake);
  memcpy(Replay_ReplayBuffer.buffer + Replay_ReplayStorePtr,packeddata,(u_int)(u_char)packeddata[0]);
  Replay_ReplayStorePtr = Replay_ReplayStorePtr + (u_int)(u_char)packeddata[0];

  *(struct PackedBuf33 *)packeddata = *(struct PackedBuf33 *)Replay_Compress((char *)controllerdata.states);
  memcpy(Replay_ReplayBuffer.buffer + Replay_ReplayStorePtr,packeddata,(u_int)(u_char)packeddata[0]);
  Replay_ReplayStorePtr = Replay_ReplayStorePtr + (u_int)(u_char)packeddata[0];
  return;
}
/* ---- Replay_RetreivingControllerData__Fv  [REPLAY.CPP:314-335] SLD-VERIFIED ---- */
tControllerData Replay_RetreivingControllerData(void)

{
  struct PackedBuf32 { char b[32]; };
  tControllerData controllerdata;
  char packeddata [33];
  char *pcVar4;

  memcpy(packeddata,Replay_ReplayBuffer.buffer + Replay_ReplayGetPtr,
             (u_int)(u_char)Replay_ReplayBuffer.buffer[Replay_ReplayGetPtr]);
  pcVar4 = Replay_Decompress(packeddata);
  *(struct PackedBuf32 *)controllerdata.steering = *(struct PackedBuf32 *)pcVar4;
  Replay_ReplayGetPtr = Replay_ReplayGetPtr + (u_int)(u_char)packeddata[0];

  memcpy(packeddata,Replay_ReplayBuffer.buffer + Replay_ReplayGetPtr,
             (u_int)(u_char)Replay_ReplayBuffer.buffer[Replay_ReplayGetPtr]);
  pcVar4 = Replay_Decompress(packeddata);
  *(struct PackedBuf32 *)controllerdata.gas = *(struct PackedBuf32 *)pcVar4;
  Replay_ReplayGetPtr = Replay_ReplayGetPtr + (u_int)(u_char)packeddata[0];

  memcpy(packeddata,Replay_ReplayBuffer.buffer + Replay_ReplayGetPtr,
             (u_int)(u_char)Replay_ReplayBuffer.buffer[Replay_ReplayGetPtr]);
  pcVar4 = Replay_Decompress(packeddata);
  *(struct PackedBuf32 *)controllerdata.brake = *(struct PackedBuf32 *)pcVar4;
  Replay_ReplayGetPtr = Replay_ReplayGetPtr + (u_int)(u_char)packeddata[0];

  memcpy(packeddata,Replay_ReplayBuffer.buffer + Replay_ReplayGetPtr,
             (u_int)(u_char)Replay_ReplayBuffer.buffer[Replay_ReplayGetPtr]);
  pcVar4 = Replay_Decompress(packeddata);
  *(struct PackedBuf32 *)controllerdata.states = *(struct PackedBuf32 *)pcVar4;
  Replay_ReplayGetPtr = Replay_ReplayGetPtr + (u_int)(u_char)packeddata[0];
  return controllerdata;
}

/* ---- Replay_SaveInput__Fi  [REPLAY.CPP:342-364] SLD-VERIFIED ---- */
void Replay_SaveInput(int car)

{
  Input_Fetch(car);
  controlData[car].steering[Replay_ReplayCounter[car]] =
      (char)((int)(signed char)Input_gSim.steering / 4) + '@';
  controlData[car].gas[Replay_ReplayCounter[car]] = Input_gSim.gas >> 3;
  controlData[car].brake[Replay_ReplayCounter[car]] = Input_gSim.brake >> 3;
  controlData[car].states[Replay_ReplayCounter[car]] = Input_gSim.flags;
  if (Cars_gHumanRaceCarList[car]->carInfo->RampSteering != 0) {
    controlData[car].steering[Replay_ReplayCounter[car]] =
        controlData[car].steering[Replay_ReplayCounter[car]] | 0x80;
  }
  if (Cars_gHumanRaceCarList[car]->carInfo->RampGas != 0) {
    controlData[car].gas[Replay_ReplayCounter[car]] =
        controlData[car].gas[Replay_ReplayCounter[car]] | 0x80;
  }
  if (Cars_gHumanRaceCarList[car]->carInfo->RampBrake != 0) {
    controlData[car].brake[Replay_ReplayCounter[car]] =
        controlData[car].brake[Replay_ReplayCounter[car]] | 0x80;
  }
  Replay_ReplayCounter[car] = Replay_ReplayCounter[car] + 1;
  if (Replay_ReplayCounter[car] == 0x20) {
    Replay_ReplayCounter[car] = 0;
    Replay_StoringControllerData(controlData[car]);
  }
  return;
}

/* ---- Replay_GetInput__Fi  [REPLAY.CPP:371-441] SLD-VERIFIED ---- */
void Replay_GetInput(int car)

{
  bool hasCameras;

  Input_Fetch(car);
  if (*(int *)((char *)Replay_ReplayCounter + (car << 2)) == 0) {
    if (Replay_ReplayBuffer.buffer[Replay_ReplayGetPtr] == '\0') {
      Replay_ReplayMode = 3;
    }
    else {
      controlData[car] = Replay_RetreivingControllerData();
    }
  }
  if (Replay_ReplayMode == 2) {
    if (((int)(signed char)controlData[car].steering[
            *(int *)((char *)Replay_ReplayCounter + (car << Replay_ReplayMode))] & 0x80U) != 0) {
      Cars_gHumanRaceCarList[car]->carInfo->RampSteering = 1;
    }
    else {
      Cars_gHumanRaceCarList[car]->carInfo->RampSteering = 0;
    }
    if ((controlData[car].gas[
            *(int *)((char *)Replay_ReplayCounter + (car << 2))] & 0x80) != 0) {
      Cars_gHumanRaceCarList[car]->carInfo->RampGas = 1;
    }
    else {
      Cars_gHumanRaceCarList[car]->carInfo->RampGas = 0;
    }
    if ((controlData[car].brake[
            *(int *)((char *)Replay_ReplayCounter + (car << 2))] & 0x80) != 0) {
      Cars_gHumanRaceCarList[car]->carInfo->RampBrake = 1;
    }
    else {
      Cars_gHumanRaceCarList[car]->carInfo->RampBrake = 0;
    }
    controlData[car].steering[
        *(int *)((char *)Replay_ReplayCounter + (car << 2))] =
        controlData[car].steering[
            *(int *)((char *)Replay_ReplayCounter + (car << 2))] & 0x7f;
    controlData[car].gas[Replay_ReplayCounter[car]] =
        controlData[car].gas[Replay_ReplayCounter[car]] & 0x7f;
    controlData[car].brake[Replay_ReplayCounter[car]] =
        controlData[car].brake[Replay_ReplayCounter[car]] & 0x7f;
    {
      int steering =
          (signed char)controlData[car].steering[Replay_ReplayCounter[car]];
      Input_gSim.steering = (char)((steering - '@') << 2);
    }
    Input_gSim.gas = controlData[car].gas[Replay_ReplayCounter[car]] << 3;
    Input_gSim.brake = controlData[car].brake[Replay_ReplayCounter[car]] << 3;
    Input_gSim.flags = controlData[car].states[Replay_ReplayCounter[car]];
  }
  else if (Replay_ReplayMode == 3) {
    Input_gSim.steering = '\0';
    Input_gSim.gas = '\0';
    Input_gSim.brake = '\0';
    Input_gSim.flags = '\0';
  }
  hasCameras = numValidCams != 0;
  {
    int *counter = &Replay_ReplayCounter[car];
    *counter = *counter + 1;
  }
  if (((hasCameras) && (Replay_ReplayCamera[car].cameraMode == 0x13)) &&
      (simGlobal.gameStarted != 0)) {
    Replay_ReplayChooseCamera(car,(int)(Cars_gHumanRaceCarList[car]->N).simRoadInfo.slice);
  }
  {
    int *counter = &Replay_ReplayCounter[car];
    if (*counter == 0x20) {
      *counter = 0;
    }
  }
  return;
}

/* ---- Replay_SaveReplay__Fv  [REPLAY.CPP:447-453] SLD-VERIFIED ---- */
void Replay_SaveReplay(void)

{
  if (Replay_ReplayMode == 0) {
    Replay_Size = simGlobal.gameTicks;
  }
  Replay_ReplayBuffer.gameSetup = GameSetup_gData;
  Replay_ReplayBuffer.gameSetup.replayMode = 2;
  Replay_ReplayBuffer.size = Replay_Size;
  return;
}

/* ---- Replay_LoadReplay__Fv  [REPLAY.CPP:469-492] SLD-VERIFIED ---- */
void Replay_LoadReplay(void)

{
  return;
}

/* ---- Replay_DoReplay__FP8Car_tObj  [REPLAY.CPP:498-506] SLD-VERIFIED ---- */
void Replay_DoReplay(Car_tObj *carObj)

{
  if ((u_int)Replay_ReplayMode < 2) {
    Replay_SaveInput(carObj->humanIndex);
  }
  else {
    Replay_GetInput(carObj->humanIndex);
  }
  return;
}

/* ---- Replay_GetInterfaceKey__Fv  [REPLAY.CPP:516-647] SLD-VERIFIED ---- */
void Replay_GetInterfaceKey(void)

{
  int i;
  int Cameras;

  Cameras = 1;
  if (GameSetup_gData.commMode == 1) {
    Cameras = 2;
  }
  Replay_ReplayInterface.changeCamera = 0;
  if (0 < Replay_ReplayInterface.depressed) {
    Replay_ReplayInterface.depressed = Replay_ReplayInterface.depressed - 1;
  }
  else if (Replay_ReplayInterface.statsScreen != 0) {
    if ((Input_Interface(5,1) != 0) || (Input_Interface(6,1) != 0)) {
      Replay_ReplayInterface.depressed = 0x18;
      Replay_ReplayInterface.end = 1;
    }
    else if (Input_Interface(0x19,1) != 0) {
      AudioCmn_PlayPauseSound(4);
      Replay_ReplayInterface.statsScreen = 0;
    }
  }
  else {
    if (Input_Interface(3,1) != 0) {
      AudioCmn_PlayPauseSound(3);
      if (Replay_ReplayInterface.selection == 0) {
        Replay_ReplayInterface.selection = 4;
      }
      else {
        Replay_ReplayInterface.selection = Replay_ReplayInterface.selection - 1;
      }
    }
    else if (Input_Interface(4,1) != 0) {
      AudioCmn_PlayPauseSound(3);
      Replay_ReplayInterface.selection = (Replay_ReplayInterface.selection + 1) % 5;
    }
    else if (Input_Interface(5,1) != 0) {
      AudioCmn_PlayPauseSound(4);
      Replay_ReplayInterface.depressed = 8;
      switch(Replay_ReplayInterface.selection) {
      case 0:
        Replay_ReplayInterface.end = 1;
        GameSetup_gData.instantReplay = 1;
        break;
      case 1:
        Replay_ReplayInterface.end = 1;
        break;
      case 2:
        Replay_ReplayInterface.pause = Replay_ReplayInterface.pause ^ 1;
        break;
      case 3:
        if (GameSetup_gData.commMode == 1) {
          Replay_ReplayInterface.speed = (Replay_ReplayInterface.speed + 1) % 3;
        }
        else {
          Replay_ReplayInterface.speed = (Replay_ReplayInterface.speed + 1) % 4;
        }
        break;
      case 4:
        Replay_ReplayInterface.changeCamera = 1;
        Replay_ReplayInterface.camera = (Replay_ReplayInterface.camera + 1) % 9;
        if (ReplayCameraList[Replay_ReplayInterface.camera] == 0x13) {
          for (i = 0; i < Cameras; i++) {
            if (numValidCams != 0) {
              Camera_gInfo[i].anchor = &Cars_gHumanRaceCarList[i]->N;
              Camera_gInfo[i].target = &Cars_gHumanRaceCarList[i]->N;
              Replay_ReplayFindClosestCamera(
                  i,(int)Cars_gHumanRaceCarList[i]->N.simRoadInfo.slice);
              Replay_ReplayCamera[i].cameraMode = 0x13;
            }
            else {
              Camera_SetMode(i,10);
            }
          }
        }
        else {
          for (i = 0; i < Cameras; i++) {
            Replay_ReplayCamera[i].defaultCamera = 0;
            Camera_gInfo[i].twist = 0;
            Camera_gInfo[i].anchor = &Cars_gHumanRaceCarList[i]->N;
            Camera_gInfo[i].target = &Cars_gHumanRaceCarList[i]->N;
            Camera_SetMode(i,ReplayCameraList[Replay_ReplayInterface.camera]);
            Replay_ReplayCamera[i].cameraMode =
                ReplayCameraList[Replay_ReplayInterface.camera];
          }
        }
        break;
      }
    }
    else if (Input_Interface(6,1) != 0) {
      Replay_ReplayInterface.depressed = 8;
      Replay_ReplayInterface.end = 1;
    }
    else if (Input_Interface(0x19,1) != 0) {
      StatsTimer = 0;
      D_8013D99C = 0;
      Replay_ReplayInterface.statsScreen = 1;
      AudioCmn_PlayPauseSound(4);
    }
  }
  if (simVar.quickPauseSim != 0) {
    Camera_Update();
  }
  return;
}

/* ---- Replay_LoadCameraFile__Fv  [REPLAY.CPP:665-785] SLD-VERIFIED ---- */
void Replay_LoadCameraFile(void)

{
  Camera_tCamSlot *cameraFile;
  char fname [80];
  int bigFile;
  
  if (numValidCams == 0) {
    bigFile = 0;
    sprintf(fname,"%scamera.viv",Paths_Paths[8]);
    FILE_addbigsync(fname,0x10,100,&bigFile);
    if (GameSetup_gData.reverseTrack) {
      sprintf(fname,"tr%02dr.rho",GameSetup_gData.track);
    } else {
      sprintf(fname,"tr%02d.rho",GameSetup_gData.track);
    }
    cameraFile = (Camera_tCamSlot *)loadfileadrz(fname,0);
    numValidCams = 0;
    FILE_delbigsync(bigFile,100);
    {
      int i;
      for (i = 0; i < 32; i++) {
        gReplayCameraSlots[i].mode = 2;
        gReplayCameraSlots[i].zoom = 0;
        gReplayCameraSlots[i].slice = -1;
      }
    }
    if (cameraFile) {
      int i;
      int j;

      memcpy(gReplayCameraSlots,cameraFile,sizeof(Camera_tCamSlot) * 32);
      for (i = 0; i < 32; i++) {
        if (gReplayCameraSlots[i].fov) {
          numValidCams++;
        } else {
          gReplayCameraSlots[i].slice = -1;
        }
      }
      purgememadr(cameraFile);
      for (j = 0; j < 31; j++) {
        for (i = 0; i < 31; i++) {
          if (((gReplayCameraSlots[i].slice > gReplayCameraSlots[i + 1].slice) ||
               (gReplayCameraSlots[i].slice < 0)) &&
              (gReplayCameraSlots[i + 1].slice >= 0)) {
            Camera_tCamSlot temp;
            temp = gReplayCameraSlots[i];
            gReplayCameraSlots[i] = gReplayCameraSlots[i + 1];
            gReplayCameraSlots[i + 1] = temp;
          }
        }
      }
      if (GameSetup_gData.reverseTrack != 0) {
        int temp;
        temp = gReplayCameraSlots[numValidCams - 1].slice;
        for (i = numValidCams - 1; i >= 0; i--) {
          if (i == 0) {
            gReplayCameraSlots[0].slice = temp;
          } else {
            gReplayCameraSlots[i].slice = gReplayCameraSlots[i - 1].slice;
          }
        }
      }
      for (i = 0; i < numValidCams; i++) {
        gReplayCameraSlots[i].pos.x <<= 6;
        gReplayCameraSlots[i].pos.y <<= 6;
        gReplayCameraSlots[i].pos.z <<= 6;
      }
    }
  }
  return;
}

/* ---- Replay_ReplayChooseCamera__Fii  [REPLAY.CPP:797-833] SLD-VERIFIED ---- */
void Replay_ReplayChooseCamera(int player,int slice)

{
  int currIndex;
  int prevIndex;
  int nextIndex;
  int currDist;
  int nextDist;
  
  currIndex = Replay_ReplayCamera[player].cutToNextCamera;
  prevIndex = currIndex - 1;
  if (prevIndex < 0) {
    prevIndex = numValidCams - 1;
  }
  nextIndex = 0;
  if (currIndex + 1 < numValidCams) {
    nextIndex = currIndex + 1;
  }
  currDist = gReplayCameraSlots[currIndex].slice;
  nextDist = gReplayCameraSlots[nextIndex].slice;
  if (slice < currDist) {
    if (((slice - currDist > 0) ? slice - currDist : currDist - slice) < 200) {
      Replay_ReplayCamera[player].cutToNextCamera = prevIndex;
      goto ReplayChooseCam_cutCheck;
    }
  }
  if (slice >= nextDist) {
    if (((slice - nextDist > 0) ? slice - nextDist : nextDist - slice) < 200) {
      Replay_ReplayCamera[player].cutToNextCamera = nextIndex;
    }
  }
ReplayChooseCam_cutCheck:
  if (Replay_ReplayCamera[player].cutToNextCamera != currIndex) {
    if (((((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) &&
         (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) != 0 ||
          ((Cars_gNumHumanRaceCars == 2 && ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) != 0)))))
         ) || (Cars_gHumanRaceCarList[player]->wrongway != 0)) &&
       (gReplayCameraSlots[Replay_ReplayCamera[player].cutToNextCamera].mode == '\v')) {
      Replay_ReplayCamera[player].defaultCamera = 0;
      Camera_gInfo[player].zooming =
          gReplayCameraSlots[Replay_ReplayCamera[player].cutToNextCamera].zoom;
      Camera_gInfo[player].splineMode =
          gReplayCameraSlots[Replay_ReplayCamera[player].cutToNextCamera].splineMode;
      Camera_SetMode(player,11);
    }
    else {
      Replay_ReplayCamera[player].defaultCamera = 1;
      Camera_ReplayUpdate(
          player,gReplayCameraSlots + Replay_ReplayCamera[player].cutToNextCamera);
    }
  }
  return;
}

/* ---- Replay_ReplayFindClosestCamera__Fii  [REPLAY.CPP:841-871] SLD-VERIFIED ---- */
#define REPLAY_WRAPPED_SLICE_DIFF(a, b) \
  ((gNumSlices / 2 < (a) - (b)) ? gNumSlices - ((a) - (b)) : (a) - (b))
#define REPLAY_SLICE_DISTANCE(a, b) \
  ((REPLAY_WRAPPED_SLICE_DIFF((a), (b)) > 0) ? \
   REPLAY_WRAPPED_SLICE_DIFF((a), (b)) : \
   -REPLAY_WRAPPED_SLICE_DIFF((a), (b)))
#define REPLAY_WRAPPED_SLICE_DIFF_LE(a, b) \
  (((a) - (b) <= gNumSlices / 2) ? (a) - (b) : gNumSlices - ((a) - (b)))
#define REPLAY_SLICE_DISTANCE_LE(a, b) \
  ((REPLAY_WRAPPED_SLICE_DIFF_LE((a), (b)) > 0) ? \
   REPLAY_WRAPPED_SLICE_DIFF_LE((a), (b)) : \
   -REPLAY_WRAPPED_SLICE_DIFF_LE((a), (b)))

void Replay_ReplayFindClosestCamera(int player,int slice)

{
  int cameraIndex;
  {
    int i;
    cameraIndex = 0;
    for (i = cameraIndex; i < numValidCams; i++) {
      int currDist;
      int nextDist;
      int actualDist;
      currDist = REPLAY_SLICE_DISTANCE_LE(
          slice,gReplayCameraSlots[i].slice);
      nextDist = REPLAY_SLICE_DISTANCE(
          slice,gReplayCameraSlots[(i + 1 < numValidCams) ? i + 1 : 0].slice);
      actualDist = REPLAY_SLICE_DISTANCE(
          gReplayCameraSlots[i].slice,
          gReplayCameraSlots[(i + 1 < numValidCams) ? i + 1 : 0].slice);
      if (actualDist >= currDist + nextDist) {
        cameraIndex = i;
        break;
      }
    }
  }
  Replay_ReplayCamera[player].cutToNextCamera = cameraIndex;
  if (gReplayCameraSlots[Replay_ReplayCamera[player].cutToNextCamera].mode == 11) {
    Replay_ReplayCamera[player].defaultCamera = 0;
    Camera_gInfo[player].zooming =
        gReplayCameraSlots[Replay_ReplayCamera[player].cutToNextCamera].zoom;
    Camera_gInfo[player].splineMode =
        gReplayCameraSlots[Replay_ReplayCamera[player].cutToNextCamera].splineMode;
    Camera_SetMode(player,11);
  }
  else {
    Replay_ReplayCamera[player].defaultCamera = 1;
    Camera_ReplayUpdate(
        player,gReplayCameraSlots + Replay_ReplayCamera[player].cutToNextCamera);
  }
  return;
}

#undef REPLAY_SLICE_DISTANCE
#undef REPLAY_WRAPPED_SLICE_DIFF
#undef REPLAY_SLICE_DISTANCE_LE
#undef REPLAY_WRAPPED_SLICE_DIFF_LE

/* end of replay.cpp */
