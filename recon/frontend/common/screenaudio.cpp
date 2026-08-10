/* frontend/screens/screenaudio.cpp  --  RECONSTRUCTED  (audio-options screen; C++ TU)
 *   8 MEMBER fns of tScreenAudio : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
#include "screenaudio.h"

tScreenAudio *screenAudio;   /* global instance pointer owned by this TU (SYM EXT @0x800528e8) */

/* ---- tScreenAudio::PlaySound  (screenaudio.cpp:39) ---- */
void tScreenAudio::PlaySound()

{
  if (((menuDefs[0]->itemSlidingPlayList).fActive != 0) &&
     (this->fPrevSelectedSong != this->fSelectedSong)) {
    AudioMus_StopSong(10);
    AudioMus_PlaySong(this->songlist->song[this->fSelectedSong].filename);
    this->fPrevSelectedSong = this->fSelectedSong;
  }
  AudioMus_Volume((int)((uint)(byte)frontEnd.musicVolume * 0x23) >> 6);
  gMasterFENarrationLevel = (int)(byte)frontEnd.narrationVolume;
  if (frontEnd.audioMode != this->prevAudioMode) {
    SNDSYSOPTS opts;

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
  int item = (short)(menuDefs[0]->menuAudio).fCurrentItem;
  int validItem = 0;
  if (item > 0) {
    validItem = item < 6;
  }
  if (validItem != 0) {
    int sndover;
    int vol;
    int RepresentativeSound;

    sndover = 1;
    switch (item) {
    case 1:
      vol = (uint)(byte)frontEnd.sfxVolume;
      RepresentativeSound = 0x1f;
      break;
    case 2:
      vol = (uint)(byte)frontEnd.engineVolume;
      RepresentativeSound = rand() % 6 + 0x29;
      break;
    case 3:
      vol = (uint)(byte)frontEnd.narrationVolume;
      RepresentativeSound = -1;
      break;
    case 4:
      vol = (uint)(byte)frontEnd.ambientVolume;
      RepresentativeSound = 0x1e;
      break;
    default:
      vol = (uint)(byte)frontEnd.sfxVolume;
      RepresentativeSound = rand() % 6 + 0x29;
      break;
    }
    gMasterSFXLevel = vol;
    if (this->audioTest == 0) {
      this->audioTest = (frontEnd.audioMode == '\x01') ? 2 : 1;
    }
    else {
      sndover = SNDover(this->audioTestHandle);
    }
    if ((sndover != 0) && (*(unsigned short *)((char *)&ginfo + 0x16) == 0) &&
        (RepresentativeSound != 0)) {
      int azimuth = 0;
      short testMode = this->audioTest;

      if (testMode == 1) {
        azimuth = 0xc000;
        this->audioTest = (frontEnd.audioMode == '\x02') ? 2 : 3;
      }
      else if (testMode == 2) {
        this->audioTest = (frontEnd.audioMode == '\x01') ? 2 : 3;
      }
      else if (testMode == 3) {
        azimuth = 0x3fff;
        this->audioTest = (frontEnd.audioMode == '\x02') ? 4 : 1;
      }
      else if (testMode == 4) {
        azimuth = 0x8000;
        this->audioTest = 1;
      }
      if (RepresentativeSound == -1) {
        FeAudio_AsyncPlaySpeech(2,3);
        this->audioTestHandle = 0;
      }
      else {
        this->audioTestHandle = AudioCmn_PlaySound
                    (gSndBnk[0].bnkID,RepresentativeSound,azimuth,vol,0x40);
      }
    }
    gMasterSFXLevel = (uint)(byte)frontEnd.sfxVolume;
  }
  else {
    if (this->audioTest != 0) {
      gMasterSFXLevel = (int)(byte)frontEnd.sfxVolume;
      SNDstop(this->audioTestHandle);
      this->audioTest = 0;
    }
  }
  return;
}

/* ---- tScreenAudio::DrawForeground  (screenaudio.cpp:195) ---- */
void tScreenAudio::DrawForeground()

{
  /* MATCH W64 PASS (60 -> 0, 68 instructions): the retail loop draws shapes 48..51 with fixed
     flags/coordinates; the decompiler's four uninitialized call arguments
     were phantom locals.  Keep the clamp result in an int funnel until its
     final short assignment so gcc reproduces the retail branch graph and
     48-byte frame.  SYM scopes `i` to the draw loop.  The zero-instruction
     identity fence invalidates the obsolete fadeCalc value after assigning
     named `fade`, making the promoted call argument read retail's $s2. */
  short fade;
  int fadeCalc;
  char *label;
  int textWidth;
  
  fadeCalc = (menuDefs[0]->menuAudio).fScreenFade >> 1;
  if ((short)fadeCalc < 0x80) {
    if ((short)fadeCalc <= 0) goto DrawFgAudio_fadeZero;
  }
  if ((short)fadeCalc < 0x81) goto DrawFgAudio_fadeDone;
  fadeCalc = 0x80;
  goto DrawFgAudio_fadeDone;
DrawFgAudio_fadeZero:
  fadeCalc = 0;
DrawFgAudio_fadeDone:
  {
    int i = 0;

    fade = (short)fadeCalc;
    __asm__("" : "+r"(fadeCalc));
    do {
      DrawShapeExtended(i + 0x30,1,0,0,(int)fade,0,
                 (tDrawShapeExtended *)0x0);
      i = i + 1;
    } while (i < 4);
  }
  if (99 < fade) {
    FETextRender_MenuTextPositionedJustify(0x27d,0x1e0,0xdc,1,textState_Selected,textType_ScreenInfo);
    label = TextSys_Word(0x27d);
    textWidth = textpixels(label);
    PSXDrawSquare(0,0x1e0,0xdc,-textWidth - 5,7);
  }
  return;
}

/* ---- tScreenAudio::DrawBackground  (screenaudio.cpp:220) ---- */
/* MATCH: 115 -> 2 diffs, exact 154/154 instructions.  The SYM local budget
   removes the decompiler's slider/transition/shape temporaries; retail uses
   direct Percentage calls, a local fade clamp, and the final i+6 shape loop.
   TransitionIsFinished returns bool (the old void* prototype changed its
   test).  Remaining named angle: sprintf's selected value is copied to $a2;
   retail tests that copy with bgez, while cc1plus propagates the original $s0
   into the test.  A natural displayPercent temporary was codegen-neutral.
   This is the catalog 06E non-propagated reg-reg copy/QTY class, deferred to
   the last hard-case rounds. */
void tScreenAudio::DrawBackground()

{
  static int lastpercentage;   /* [SYM] STAT @0x800528e0 (last % shown) */
  static int perfade;          /* [SYM] STAT @0x800528e4 (bg fade accumulator) */
  short fade;
  int ColText;
  tOptionsMenu *optionsMenu;
  int percent;
  int fadeValue;
  char sBuildOutput [255];
  
  this->PlaySound();
  optionsMenu = &menuDefs[0]->menuAudio;
  fade = (short)(optionsMenu->fScreenFade >> 1);
  if (0x80 < fade) {
    fade = 0x80;
  }
  percent = -1;
  switch((short)optionsMenu->fCurrentItem) {
  case 0:
    percent = Percentage(&menuDefs[0]->itemMusicVolume);
    break;
  case 1:
    percent = Percentage(&menuDefs[0]->itemSoundEffectsVolume);
    break;
  case 2:
    percent = Percentage(&menuDefs[0]->itemEngineVolume);
    break;
  case 3:
    percent = Percentage(&menuDefs[0]->itemSpeechVolume);
    break;
  case 4:
    percent = Percentage(&menuDefs[0]->itemAmbientVolume);
    break;
  default:
    goto DrawBg_noSlider;
  }
DrawBg_noSlider:
  if (-1 < percent) {
    lastpercentage = percent;
  }
  if ((-1 < percent) || (-1 < lastpercentage)) {
    if ((percent == -1) ||
       (!::TransitionIsFinished(&menuDefs[0]->menuAudio))) {
      perfade = perfade + 4;
    }
    else {
      perfade = perfade + -4;
    }
    fadeValue = perfade;
    if (0x80 < fadeValue) {
      fadeValue = 0x80;
    }
    if (fadeValue < 0) {
      fadeValue = 0;
    }
    perfade = fadeValue;
    ColText = CalcFadeVal(kRGBVals[(byte)textDefinitions[6][5]],0,(int)fade,fadeValue);
    sprintf(sBuildOutput,"%d%%",percent < 0 ? lastpercentage : percent);
    if (perfade != 0x80) {
      FETextRender_FullTextRGB(sBuildOutput,(short)TextSys_WordX(0x1dc),
                               (short)TextSys_WordY(0x1dc),ColText,'\0',1);
    }
  }
  percent = 0;
  do {
    DrawShapeExtended
              (percent + 6,1,0,0,(int)fade,0,
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
  this->_vf = (__vtbl_ptr_type (*)[10])tScreenAudio_vtable;
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
             (tInsideBoxMenu*)&menus->menuPlayListMenu);
  this->Initialize();
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
  AudioMus_Volume((int)(byte)frontEnd.musicVolume * 0x23 >> 6);
  this->Cleanup();
  SPEECHINFO *info = &ginfo;
L_wait:
  if ((*(u_short *)&info->areLoading) != 0) {
    FeAudio_systemtask(0);
    goto L_wait;
  }
  return;
  return;
}

/* ---- tScreenAudio::~tScreenAudio  (screenaudio.cpp:74) ---- */
tScreenAudio::~tScreenAudio()

{
  return;
}

/* end of screenaudio.cpp */
