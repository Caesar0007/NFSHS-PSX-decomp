/* frontend/screens/screenaudio.cpp  --  RECONSTRUCTED  (audio-options screen; C++ TU)
 *   8 MEMBER fns of tScreenAudio : tScreen. Member-fn decls in nfs4_types.h. Bodies: Ghidra.
 */
#include "screenaudio_types.h"
#include "screenaudio_externs.h"

/* retail's SYM records an inline-call pair at these reads: the value is read through an inline getter */
static inline tGlobalMenuDefs * MenuDefs(void) { return menuDefs; }

/* ORIGINAL-NAME-UNRESOLVED: inferred status getter for retail's inline pair at +604..628.
   Its literal original name is not recorded; the two fields belong to ginfo. */
static inline bool FeAudio_SpeechIsBusy()
{
  return ginfo.areLoading != 0 || ginfo.soundIsPlaying != 0;
}


/* Retail screenaudio.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }

tScreenAudio *screenAudio;   /* global instance pointer owned by this TU (SYM EXT @0x800528e8) */

/* ---- tScreenAudio::PlaySound  (screenaudio.cpp:39) ---- */
void tScreenAudio::PlaySound()

{
  if (menuDefs->itemSlidingPlayList.IsActive() &&
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
  if (menuDefs->menuAudio.CurrentItem() > 0 &&
      menuDefs->menuAudio.CurrentItem() < 6) {
    int sndover;
    int vol;
    int RepresentativeSound;

    sndover = 1;
    switch (menuDefs->menuAudio.CurrentItem()) {
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
    if ((sndover != 0) && !FeAudio_SpeechIsBusy() &&
        (RepresentativeSound != 0)) {
      int azimuth = 0;

      if (this->audioTest == 1) {
        azimuth = 0xc000;
        this->audioTest = (frontEnd.audioMode == '\x02') ? 2 : 3;
      }
      else if (this->audioTest == 2) {
        this->audioTest = (frontEnd.audioMode == '\x01') ? 2 : 3;
      }
      else if (this->audioTest == 3) {
        azimuth = 0x3fff;
        this->audioTest = (frontEnd.audioMode == '\x02') ? 4 : 1;
      }
      else if (this->audioTest == 4) {
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
/* SOURCE-REVIEW-UNRESOLVED: fadeCalc and the savedFadeCalc/zero/restore
   sequence are not recovered retail locals or proved original source.
   Direct short ownership was 18 diffs at 68 words; structured short clamps
   were 24 at 68; placing the final assignment before a for-header loop was
   7 at 69 (2026-10-09). These failures do not prove a distinct input object.
   The canonical sibling GetScreenFade accessor reproduces the retail empty
   inline pair here; its literal original spelling is not recorded by SYM. */
void tScreenAudio::DrawForeground()

{
  short fade;
  int fadeCalc;

  fadeCalc = menuDefs->menuAudio.GetScreenFade() >> 1;
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
    short savedFadeCalc = (short)fadeCalc; fadeCalc = 0; fadeCalc = savedFadeCalc; /* C-only CSE boundary. */
    do {
      DrawShapeExtended(i + 0x30,1,0,0,(int)fade,0,
                 (tDrawShapeExtended *)0x0);
      i = i + 1;
    } while (i < 4);
  }
  if (99 < fade) {
    FETextRender_MenuTextPositionedJustify(0x27d,0x1e0,0xdc,1,textState_Selected,textType_ScreenInfo);
    PSXDrawSquare(0,0x1e0,0xdc,-textpixels(TextSys_Word(0x27d)) - 5,7);
  }
  return;
}

/* ---- tScreenAudio::DrawBackground  (screenaudio.cpp:220) ---- */
/* Byte verified at 154 instructions; original source/SLD remains unsealed.
   The option-menu getter pair now matches retail without optionsMenu.
   Percentage calls use their real member declarations. The remaining
   fadeValue/displayPercent carriers are explicitly unresolved below. */
void tScreenAudio::DrawBackground()

{
  /* initialized => .data at this function (retail 0x800528e0 = -1, 0x800528e4 = 0x80), not .lcomm */
  static int lastpercentage = -1;   /* [SYM] STAT @0x800528e0 (last % shown) */
  static int perfade = 0x80;        /* [SYM] STAT @0x800528e4 (bg fade accumulator) */
  short fade;
  int percent;
  /* SOURCE-REVIEW-UNRESOLVED: fadeValue is unrecorded. The direct static
     clamp trial is 56 diffs at 154 words after the getter restoration;
     this is not proof of an original register-local clamp object. */
  int fadeValue;
  
  this->PlaySound();
  fade = (short)(menuDefs->menuAudio.GetScreenFade() >> 1);
  if (0x80 < fade) {
    fade = 0x80;
  }
  percent = -1;
  switch(menuDefs->menuAudio.CurrentItem()) {
  case 0:
    percent = menuDefs->itemMusicVolume.Percentage();
    break;
  case 1:
    percent = menuDefs->itemSoundEffectsVolume.Percentage();
    break;
  case 2:
    percent = menuDefs->itemEngineVolume.Percentage();
    break;
  case 3:
    percent = menuDefs->itemSpeechVolume.Percentage();
    break;
  case 4:
    percent = menuDefs->itemAmbientVolume.Percentage();
    break;
  default:
    goto DrawBg_noSlider;
  }
DrawBg_noSlider:
  if (-1 < percent) {
    lastpercentage = percent;
  }
  if ((-1 < percent) || (-1 < lastpercentage)) {
    int ColText;
    /* SOURCE-REVIEW-UNRESOLVED: displayPercent is absent from retail SYM.
       Direct argument forms still change the tested register or allocation;
       the duplicated assignment is not a proved original source object. */
    int displayPercent;
    char sBuildOutput [255];

    if ((percent == -1) ||
       (!::TransitionIsFinished(&menuDefs->menuAudio))) {
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
    if (percent < 0) {
      displayPercent = percent;
    }
    else {
      displayPercent = percent;
    }
    sprintf(sBuildOutput,"%d%%",displayPercent < 0 ? lastpercentage : displayPercent);
    if (perfade != 0x80) {
      FETextRender_FullTextRGB(sBuildOutput,(short)TextSys_WordX(0x1dc),
                               (short)TextSys_WordY(0x1dc),ColText,'\0',1);
    }
  }
  {
    int i;

    /* SOURCE-REVIEW-UNRESOLVED: i is the retail loop local in s0, but the
       dead percent assignment used to shape its coalescing is not proved
       original. Byte PASS does not certify full SLD attribution. */
    i = percent = 0;
    do {
      DrawShapeExtended
                (i + 6,1,0,0,(int)fade,0,
                 (tDrawShapeExtended *)0x0);
      i = i + 1;
    } while (i < 0x20);
  }
  return;
}

/* ---- tScreenAudio::GetShapeInfo  (screenaudio.cpp:288) ---- */
void tScreenAudio::GetShapeInfo(short &numPermShapes,short &numSwapShapes,char **permFileName,
               char **swapFileName)

{

  numSwapShapes = 0; *swapFileName = (char *)0x0;
  numPermShapes = 0x34;
  *permFileName = "zAudio";
}

/* ---- tScreenAudio::tScreenAudio  (screenaudio.cpp:297) ---- */
tScreenAudio::tScreenAudio()

{
  this->fSelectedSong = 0;
  this->fCurrentAudioMode = '\0';
  this->songlist = (AudioMus_tSongList *)0x0;
}

/* ---- tScreenAudio::Initialize  (screenaudio.cpp:305) ---- */
/* The initial selection store precedes the direct menuDefs call in source.
   This ordering gives the retail $a2 reuse with no non-SYM menus local. */
void tScreenAudio::Initialize()

{
  this->fPrevSelectedSong = -1;

  SetMenu((tMenuItemSlidingMenu *)&menuDefs->itemSlidingPlayList,true,(tInsideBoxMenu*)&menuDefs->menuPlayListMenu);

  this->tScreen::Initialize();
  this->prevAudioMode = frontEnd.audioMode;
  this->audioTest = 0;
  this->audioTestHandle = 0;
  this->songlist = (AudioMus_tSongList *)0x0;
}

/* ---- tScreenAudio::Cleanup  (screenaudio.cpp:318) ---- */
/* retail's Cleanup ends in a loop level holding an inline-call pair: the speech-loading test is an
   inline taking the info block, whose hoisted address is what the old `info` carrier reproduced */
static inline int SpeechLoading(SPEECHINFO *si) { return *(u_short *)&si->areLoading; }

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
  this->tScreen::Cleanup();
  while (SpeechLoading(&ginfo)) {
    FeAudio_systemtask(0);
  }
  return;
}

/* ---- tScreenAudio::~tScreenAudio  (screenaudio.cpp:74) ---- */
/* W65-A3 (calltarget): dtor made IMPLICIT (declaration dropped from
 * nfs4_types.h) so every derived dtor and every scope-exit collapses to
 * ___7tScreen the way retail does; the standalone symbol gcc then stops
 * emitting is supplied here, in place, with C linkage. */
extern "C" void ___7tScreen(void *);

/* end of screenaudio.cpp */
