#include "mpause_types.h"
#include "../../lib/nfs4_new.h"
#include "mpause_externs.h"

extern void MPause_ReadSoundMode(void *state);
extern void MPause_ApplySoundMode(void *state);
extern int SNDover(int handle);
extern void SNDstop(int handle);
extern int MPause_TicksSnapshot asm("ticks");

static tPMenu *gPauseCurrentMenu;

void MPause_MusicLogic(char active)
{
  static char wasActive;
  static char testSFX;
  static char playingSFX;
  static int vol;
  static int SFXHandle;
  static int lastplaytick;
  unsigned char soundMode[64];
  int sndover;
  int samp;
  bool musicMenu;
  int menuItem;

  sndover = 1;
  samp = 0x10;
  MPause_ReadSoundMode(soundMode);
  switch (MPause_GameSetupWords[59]) {
    case 0:
      gStereoMode = 1;
      if (soundMode[16] == 1) {
        soundMode[16] = 2;
        MPause_ApplySoundMode(soundMode);
      }
      Audio_direct3davail = 0;
      break;
    case 1:
      gStereoMode = 0;
      if (soundMode[16] == 2) {
        soundMode[16] = 1;
        MPause_ApplySoundMode(soundMode);
      }
      Audio_direct3davail = 0;
      break;
    case 2:
      gStereoMode = 1;
      if (soundMode[16] == 1) {
        soundMode[16] = 2;
        MPause_ApplySoundMode(soundMode);
      }
      Audio_direct3davail = 1;
      break;
  }
  if (active != '\0') {
    if (wasActive == '\0') {
      AudioMus_AutoVolume(500,AudioCmn_MusicLevel(gMasterMusicLevel));
    }
    musicMenu = false;
    menuItem = *((int *)gPauseCurrentMenu);
    if (menuItem == 1) {
      musicMenu = true;
    }
    else if (menuItem == 2) {
      musicMenu = true;
    }
    if (musicMenu) {
      AudioMus_Volume(AudioCmn_MusicLevel(gMasterMusicLevel));
    }
    menuItem = *((int *)gPauseCurrentMenu);
    testSFX = false;
    if (menuItem == 3) {
      samp = 0x10;
      vol = gMasterSFXLevel;
      testSFX = true;
    }
    if (*((int *)gPauseCurrentMenu) == 4) {
      samp = 0x10;
      vol = gMasterFENarrationLevel;
      testSFX = true;
    }
    menuItem = *((int *)gPauseCurrentMenu);
    if (menuItem == 5) {
      samp = 0x10;
      vol = gMasterEngineLevel;
      testSFX = true;
    }
    if (*((int *)gPauseCurrentMenu) == 6) {
      samp = 0x10;
      vol = gMasterAmbientLevel;
      testSFX = true;
    }
    if ((bool)testSFX != false) {
      if (playingSFX == '\0') {
        playingSFX = '\x01';
      }
      else {
        sndover = SNDover(SFXHandle);
      }
      if ((sndover != 0) && (0xc0 < ticks - lastplaytick)) {
        lastplaytick = MPause_TicksSnapshot;
        SFXHandle = AudioCmn_PlaySound(MPause_SndBnkWords[3][0],samp,0,vol,0x40);
      }
    }
    else if (playingSFX == '\x01') {
      SNDstop(SFXHandle);
      playingSFX = '\0';
    }
  }
  else if (wasActive != '\0') {
    SNDstop(SFXHandle);
    AudioMus_AutoVolume(500,0);
  }
  wasActive = active;
}
