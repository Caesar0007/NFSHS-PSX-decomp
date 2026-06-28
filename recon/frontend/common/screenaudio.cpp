/* frontend/screens/screenaudio.cpp  --  RECONSTRUCTED  (audio-options screen; C++ TU)
 *   8 MEMBER fns of tScreenAudio : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
#include "screenaudio.h"

tScreenAudio *screenAudio;   /* global instance pointer owned by this TU (SYM EXT @0x800528e8) */

/* ---- tScreenAudio::PlaySound  (screenaudio.cpp:39) ---- */
void tScreenAudio::PlaySound()

{
  byte volByte;
  short testMode;
  int RepresentativeSound;
  short item;
  int azimuth;
  int vol;
  SNDSYSOPTS opts;
  
  if (((menuDefs[0]->itemSlidingPlayList).fActive != 0) &&
     (this->fPrevSelectedSong != this->fSelectedSong)) {
    AudioMus_StopSong(10);
    AudioMus_PlaySong((char *)this->songlist[this->fSelectedSong * 8 + 1].numsongs);
    this->fPrevSelectedSong = this->fSelectedSong;
  }
  AudioMus_Volume((int)((uint)(byte)frontEnd.musicVolume * 0x23) >> 6);
  gMasterFENarrationLevel = (int)(byte)frontEnd.narrationVolume;
  if (frontEnd.audioMode != this->prevAudioMode) {
    gStereoMode = 1;
    Audio_direct3davail = 0;
    this->audioTest = 1;
    SNDSYS_getopts(&opts);
    if (frontEnd.audioMode == '\x01') {
      opts.set.outputchannels = '\x01';
      gStereoMode = 0;
      this->audioTest = 2;
    }
    else if (frontEnd.audioMode == '\0') {
      opts.set.outputchannels = '\x02';
    }
    else {
      opts.set.outputchannels = '\x02';
      Audio_direct3davail = 1;
    }
    SNDSYS_setopts(&opts);
    this->prevAudioMode = frontEnd.audioMode;
  }
  item = (short)(menuDefs[0]->menuAudio)._base_tMenu.fCurrentItem;
  if (item < 1 || 5 < item) {
    if (this->audioTest == 0) {
      return;
    }
    gMasterSFXLevel = (int)(byte)frontEnd.sfxVolume;
    SNDstop(this->audioTestHandle);
    this->audioTest = 0;
    return;
  }
  azimuth = 1;
  volByte = frontEnd.engineVolume;
  if (item == 2) {
PlaySnd_engineRand:
    vol = (uint)volByte;
    RepresentativeSound = rand();
    RepresentativeSound = RepresentativeSound % 6 + 0x29;
  }
  else {
    volByte = frontEnd.sfxVolume;
    if (item < 3) {
      if (item != 1) goto PlaySnd_engineRand;
      vol = (uint)(byte)frontEnd.sfxVolume;
      RepresentativeSound = 0x1f;
    }
    else if (item == 3) {
      vol = (uint)(byte)frontEnd.narrationVolume;
      RepresentativeSound = -1;
    }
    else {
      if (item != 4) goto PlaySnd_engineRand;
      vol = (uint)(byte)frontEnd.ambientVolume;
      RepresentativeSound = 0x1e;
    }
  }
  gMasterSFXLevel = vol;
  if (this->audioTest == 0) {
    item = 1;
    if (frontEnd.audioMode == '\x01') {
      item = 2;
    }
    this->audioTest = item;
  }
  else {
    azimuth = SNDover(this->audioTestHandle);
  }
  if (((azimuth == 0) || ((*(short *)((char *)&ginfo + 0x16)) != 0)) || (item = 1, RepresentativeSound == 0)) goto PlaySnd_setMasterLevel;
  testMode = this->audioTest;
  azimuth = 0;
  if (testMode == 1) {
    azimuth = 0xc000;
    item = 3;
    if (frontEnd.audioMode == '\x02') {
      item = 2;
    }
PlaySnd_setAudioTest:
    this->audioTest = item;
  }
  else {
    if (testMode == 2) {
      item = 3;
      if (frontEnd.audioMode == '\x01') {
        item = 2;
      }
    }
    else {
      if (testMode != 3) {
        if (testMode == 4) {
          azimuth = 0x8000;
          goto PlaySnd_setAudioTest;
        }
        goto PlaySnd_asyncSpeech;
      }
      azimuth = 0x3fff;
      item = 1;
      if (frontEnd.audioMode == '\x02') {
        item = 4;
      }
    }
    this->audioTest = item;
  }
PlaySnd_asyncSpeech:
  if (RepresentativeSound == -1) {
    FeAudio_AsyncPlaySpeech(2,3);
    this->audioTestHandle = 0;
  }
  else {
    azimuth = AudioCmn_PlaySound
                      (gSndBnk[0].bnkID,RepresentativeSound,azimuth,vol,0x40);
    this->audioTestHandle = azimuth;
  }
PlaySnd_setMasterLevel:
  gMasterSFXLevel = (uint)(byte)frontEnd.sfxVolume;
  return;
}

/* ---- tScreenAudio::DrawForeground  (screenaudio.cpp:195) ---- */
void tScreenAudio::DrawForeground()

{
  short fade;
  char *label;
  int textWidth;
  int shapeIdx;
  int i;
  int shapeFlags;
  int shapeX;
  int shapeY;
  
  fade = (short)((menuDefs[0]->menuAudio).fScreenFade >> 1);
  if ((fade < 0x80) && (fade < 1)) {
    fade = 0;
  }
  else if (0x80 < fade) {
    fade = 0x80;
  }
  i = 0;
  do {
    DrawShapeExtended(shapeIdx,shapeFlags,shapeX,shapeY,(int)fade,0,
               (tDrawShapeExtended *)0x0);
    i = i + 1;
  } while (i < 4);
  if (99 < fade) {
    FETextRender_MenuTextPositionedJustify(0x27d,0x1e0,0xdc,1,textState_Selected,textType_ScreenInfo);
    label = TextSys_Word(0x27d);
    textWidth = textpixels(label);
    PSXDrawSquare(0,0x1e0,0xdc,-5 - textWidth,7);
  }
  return;
}

/* ---- tScreenAudio::DrawBackground  (screenaudio.cpp:220) ---- */
void tScreenAudio::DrawBackground()

{
  static int lastpercentage;   /* [SYM] STAT @0x800528e0 (last % shown) */
  static int perfade;          /* [SYM] STAT @0x800528e4 (bg fade accumulator) */
  short fade;
  void *transDone;
  int ColText;
  int wordY;
  tMenuItemLeftRightAudioSlider *slider;
  int shapeIdx;
  int percent;
  int shapeFlags;
  int shapeX;
  int shapeY;
  char sBuildOutput [255];
  
  this->PlaySound();
  fade = (short)((menuDefs[0]->menuAudio).fScreenFade >> 1);
  if (0x80 < fade) {
    fade = 0x80;
  }
  percent = -1;
  switch((short)(menuDefs[0]->menuAudio)._base_tMenu.fCurrentItem) {
  case 0:
    slider = &menuDefs[0]->itemMusicVolume;
    break;
  case 1:
    slider = &menuDefs[0]->itemSoundEffectsVolume;
    break;
  case 2:
    slider = &menuDefs[0]->itemEngineVolume;
    break;
  case 3:
    slider = &menuDefs[0]->itemSpeechVolume;
    break;
  case 4:
    slider = &menuDefs[0]->itemAmbientVolume;
    break;
  default:
    goto DrawBg_noSlider;
  }
  percent = Percentage(slider);
DrawBg_noSlider:
  ColText = percent;
  if ((-1 < percent) || (ColText = lastpercentage, -1 < lastpercentage)) {
    lastpercentage = ColText;
    if ((percent == -1) ||
       (transDone = TransitionIsFinished(&menuDefs[0]->menuAudio), transDone != (void *)0x1)) {
      perfade = perfade + 4;
    }
    else {
      perfade = perfade + -4;
    }
    if (0x80 < perfade) {
      perfade = 0x80;
    }
    if (perfade < 0) {
      perfade = 0;
    }
    ColText = CalcFadeVal(kRGBVals[(byte)textDefinitions[6][5]],0,(int)fade,perfade);
    if (percent < 0) {
      percent = lastpercentage;
    }
    sprintf(sBuildOutput,"%d%%",percent);
    if (perfade != 0x80) {
      percent = TextSys_WordX(0x1dc);
      wordY = TextSys_WordY(0x1dc);
      FETextRender_FullTextRGB(sBuildOutput,(short)percent,(short)wordY,ColText,'\0',1);
    }
  }
  percent = 0;
  do {
    DrawShapeExtended
              (shapeIdx,shapeFlags,shapeX,shapeY,(int)fade,0,
               (tDrawShapeExtended *)0x0);
    percent = percent + 1;
  } while (percent < 0x20);
  return;
}

/* ---- tScreenAudio::GetShapeInfo  (screenaudio.cpp:288) ---- */
void tScreenAudio::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)

{
  numSwapShapes = 0;
  *swapFileName = (char *)0x0;
  numPermShapes = 0x34;
  *permFileName = "zAudio";
  return;
}

/* ---- tScreenAudio::tScreenAudio  (screenaudio.cpp:297) ---- */
tScreenAudio::tScreenAudio()

{
  this->_base_tScreen._vf = (__vtbl_ptr_type (*)[10])tScreenAudio_vtable;
  this->fSelectedSong = 0;
  this->fCurrentAudioMode = '\0';
  this->songlist = (AudioMus_tSongList *)0x0;
  return;
}

/* ---- tScreenAudio::Initialize  (screenaudio.cpp:305) ---- */
void tScreenAudio::Initialize()

{
  tGlobalMenuDefs *menus;
  char audioMode;
  
  menus = menuDefs[0];
  this->fPrevSelectedSong = -1;
  SetMenu((tMenuItemSlidingMenu *)&menus->itemSlidingPlayList,true,
             &(menus->menuPlayListMenu)._base_tInsideBoxMenu);
  this->_base_tScreen.Initialize();
  audioMode = frontEnd.audioMode;
  this->audioTest = 0;
  this->audioTestHandle = 0;
  this->songlist = (AudioMus_tSongList *)0x0;
  this->prevAudioMode = audioMode;
  return;
}

/* ---- tScreenAudio::Cleanup  (screenaudio.cpp:318) ---- */
void tScreenAudio::Cleanup()

{
  
  if (this->audioTest != 0) {
    SNDstop(this->audioTestHandle);
    this->audioTest = 0;
  }
  AudioMus_Volume((int)((uint)(byte)frontEnd.musicVolume * 0x23) >> 6);
  gMasterMusicLevel = (int)(byte)frontEnd.musicVolume;
  gMasterSFXLevel = (int)(byte)frontEnd.sfxVolume;
  gMasterFENarrationLevel = (int)(byte)frontEnd.narrationVolume;
  gMasterEngineLevel = (int)(byte)frontEnd.engineVolume;
  gMasterAmbientLevel = (int)(byte)frontEnd.ambientVolume;
  AudioMus_Volume(gMasterMusicLevel * 0x23 >> 6);
  this->_base_tScreen.Cleanup();
  while ((*(short *)((char *)&ginfo + 0x16)) != 0) {
    FeAudio_systemtask(0);
  }
  return;
}

/* ---- tScreenAudio::~tScreenAudio  (screenaudio.cpp:74) ---- */
tScreenAudio::~tScreenAudio()

{
  return;
}

/* end of screenaudio.cpp */