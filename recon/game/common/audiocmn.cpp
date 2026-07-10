/* game/common/audiocmn.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "../../nfs4_types.h"
#include "audiocmn_externs.h"

/* ---- owning-TU defs for link-harness (extern-declared, never defined; BSS) ---- */
char *gAudioBasePath[1] __attribute__((section(".bss")));   /* .bss=absolute; oracle never %gp_rel's this symbol */

/* ---- AudioCmn.obj-OWNED data globals -- extern-declared in audiocmn_externs.h but never
   defined (surfaced by the link harness). Defined here in the owning TU; BSS zero. */
Audio_tFESFXTable Audio_gFESFXTable;             /* single FE-SFX descriptor */
char *Audio_gLangAssignmentTable[9];             /* per-language sample-name table (iterated +0..+9) */

/* ---- audiocmn.obj anon writable global (no SYM name; Ghidra inlined as string literal) ---- */
static char gAudioCmnLastFreq[34] = "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";   /* @0x8010E710 */


/* ---- audiocmn.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
int          *AudioCmn_FESFX_loadLangMap[12];   /* @0x8005570c */
int          gBankNumLookupTable[71] = { 0, 2, 0, 2, 0, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 5, 5, 5, 5, 3, 3, 3, 3, 5, 2, 2, 2, 2, 0, 1, 2, 2, 2, 2, 0, 0, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0 };   /* @0x8010e4d0 */
int          falseLapTrigNumsForward[10][2] = { 4, 7, 4, 7, 4, 7, -1, -1, 4, 7, 4, 9, 4, 9, -1, -1, -1, -1, 4, 9 };   /* @0x8010e5ec */
int          falseLapTrigNumsBackward[10][2] = { 4, 5, 4, 5, -1, -1, -1, -1, 4, 5, 4, 5, 4, 5, -1, -1, -1, -1, 4, 5 };   /* @0x8010e63c */
char         Xfade[129] = { 0, 3, 7, 10, 13, 16, 19, 22, 24, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 46, 48, 50, 51, 53, 54, 55, 57, 58, 60, 61, 62, 63, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 84, 85, 86, 87, 88, 88, 89, 90, 91, 91, 92, 93, 94, 94, 95, 96, 96, 97, 98, 98, 99, 100, 100, 101, 101, 102, 103, 103, 104, 104, 105, 106, 106, 107, 107, 108, 108, 109, 109, 110, 110, 111, 111, 112, 112, 113, 113, 114, 114, 115, 115, 116, 116, 117, 117, 118, 118, 119, 119, 119, 120, 120, 121, 121, 122, 122, 122, 123, 123, 124, 124, 125, 125, 125, 126, 127, 127 };   /* @0x8010e68c */
char         SkidInitMaxFreq[71] = { 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };   /* @0x8010e710 */
char         *AudioCmn_LanguageName[7];   /* @0x8010e774 */
int          bSirenOn[6];   /* @0x8010e790  (bss(zero)) */
int          bSirenPitchingUp[6] = { 1, 1, 1, 1, 1, 1 };   /* @0x8010e7a8 */
int          quickSirenActive[6];   /* @0x8010e7c0  (bss(zero)) */
int          sirenPitchWidth[6] = { 32, 40, 28, 42, 28, 42 };   /* @0x8010e7d8 */
int          sirenCurrentPitch[6] = { 32, 32, 32, 32, 32, 32 };   /* @0x8010e7f0 */
int          slowSirenReps[6] = { 3, 3, 3, 3, 3, 3 };   /* @0x8010e808 */
int          sirenCount[6];   /* @0x8010e820  (bss(zero)) */
int          reachedSirenMin[6];   /* @0x8010e838  (bss(zero)) */
int          quickSirenTimeCount[6];   /* @0x8010e850  (bss(zero)) */
AudioCmn_tReTrig AudioCmn_gReTrig[2];   /* @0x8010e868  (bss(zero)) */
SndBnk_t     gSndBnk[7];   /* @0x8010e8a8  (bss(zero)) */
Channels_t   gaChannel[71];   /* @0x8010e8fc  (bss(zero)) */
AudioCmn_tAsyncSfxSlot AudioCmn_gSfxSlot[32];   /* @0x8010eb34  (bss(zero)) */
char         carbankname[12];   /* @0x8010ee34  (bss(zero)) */
char         trackMusicState = 4;   /* @0x8013c628 */
int          audioBackwardsDirection;   /* @0x8013c62c  (bss(zero)) */
int          intensityFalseLapCounter;   /* @0x8013c630  (bss(zero)) */
int          falseLapCounter;   /* @0x8013c634  (bss(zero)) */
int          gMusicStyle;   /* @0x8013c638  (bss(zero)) */
char         countdown;   /* @0x8013c63c  (bss(zero)) */
char         FadingMusic;   /* @0x8013c63d  (bss(zero)) */
char         StartedNewMusic;   /* @0x8013c63e  (bss(zero)) */
int          recordLapTime;   /* @0x8013c640  (bss(zero)) */
int          AudioCmn_kAudioOn = 1;   /* @0x8013c644 */
int          AudioCmn_kAudioStreamingOn = 1;   /* @0x8013c648 */
int          SgameSFXvol = 40;   /* @0x8013c64c */
int          gMasterMusicLevel = 127;   /* @0x8013c650 */
int          gMasterSFXLevel = 127;   /* @0x8013c654 */
int          gMasterEngineLevel = 127;   /* @0x8013c658 */
int          gMasterFENarrationLevel = 127;   /* @0x8013c65c */
int          gMasterAmbientLevel = 127;   /* @0x8013c660 */
int          previousSFXLevel = 127;   /* @0x8013c664 */
int          AudioCmn_musicInteractive = 1;   /* @0x8013c668 */
int          gFEmusicON = 1;   /* @0x8013c66c */
int          NumSFXOn;   /* @0x8013c670  (bss(zero)) */
int          gStereoMode = 1;   /* @0x8013c674 */
char         fReverbOn;   /* @0x8013c678  (bss(zero)) */
char         fReverbLevel = 0;   /* @0x8013c679 */
int          falseLapTrigCur;   /* @0x8013c6b4  (bss(zero)) */
int          flaseLapTrigTrack;   /* @0x8013c6b8  (bss(zero)) */
char         currentLap[2];   /* @0x8013c6bc  (bss(zero)) */
int          bestLapTime[2];   /* @0x8013c6c0  (bss(zero)) */
int          gtotallaptimes[2];   /* @0x8013c6c8  (bss(zero)) */
int          AudioCmn_gPlayerArrested[2];   /* @0x8013c6d0  (bss(zero)) */
int          AudioCmn_gCursorSndHandle;   /* @0x8013c6d8  (bss(zero)) */
int          AudioCmn_gLastFade;   /* @0x8013c6dc  (bss(zero)) */
void         *AudioCmn_gLoadTables;   /* @0x8013c6e0  (bss(zero)) */
void         *AudioCmn_gCruiseTables;   /* @0x8013c6e4  (bss(zero)) */
int          AudioCmn_gResume;   /* @0x8013c6e8  (bss(zero)) */
int          AudioCmn_gStreamRestartTimer;   /* @0x8013c6ec  (bss(zero)) */
char         fMysticWindON[2];   /* @0x8013c6f0  (bss(zero)) */
char         fAmbientRangeON[2];   /* @0x8013c6f4  (bss(zero)) */
int          currentWindVal[2];   /* @0x8013c6f8  (bss(zero)) */
int          nextWindVal[2];   /* @0x8013c700  (bss(zero)) */
int          currentWindPan;   /* @0x8013c708  (bss(zero)) */
int          nextWindPan;   /* @0x8013c70c  (bss(zero)) */
int          gQuickSirenCount;   /* @0x8013c710  (bss(zero)) */
int          AudioCmn_ThunderAmp;   /* @0x8013c714  (bss(zero)) */
int          AudioCmn_ThunderAzi;   /* @0x8013c718  (bss(zero)) */
int          AudioCmn_ThunderDel;   /* @0x8013c71c  (bss(zero)) */
int          PlayersRampedGasLevel[2];   /* @0x8013dd80  (bss(zero)) */


/* ---- intra-TU forward declarations ---- */
int AudioCmn_MusicLevel(int level);
int AudioCmn_GetTrackRecordLapTime(void);
void AudioCmn_InitThunder(void);
void AudioCmn_PlayThunder(int intensity,int azimuth);
void AudioCmn_UpdateThunder(void);
void AudioCmn_InitAsyncSfx(void);
void AudioCmn_RemoveAsyncSfx(int slot);
void AudioCmn_DeInitAsyncSfx(void);
int AudioCmn_RemoveOldestAsyncSfx(int bank);
void AudioCmn_LoadAsyncSfx(int bank,int patch,void *pbank,int size);
int AudioCmn_GetAsyncSfx(int bank,int patch,void *checkonly);
void AudioCmn_Init(void);
void AudioCmn_SetLevels(void);
int AudioCmn_GetTimePhrase(int time);
void AudioCmn_CheckState(Car_tObj *car);
void AudioCmn_LoadFESamples(void);
void AudioCmn_LoadGameSamples(void);
void AudioCmn_InitChannelArray(void);
int scaleFrequency(int sndPlayer,int iSFXnum,int tweakedForce);
int ChooseImpactSample(int force,s_type surface1,s_type surface2);
int ChooseLoopedSample(s_type surface1,s_type surface2);
void freeVoiceChannel(int sndPlayer);
int AudioCmn_PlayDoppleredSound(int bhandle,int patchNum,int azimuth,int vol,int bend,int doppler);
int AudioCmn_PlaySound(int bhandle,int patchNum,int azimuth,int vol,int bend);
int AudioCmn_PlaySFX(int sndPlayer,int iSFXnum,int iFreqIn,int iDopplerIn,int iAmpIn,int azimuth);
void AudioCmn_TrafficSFX(int iChan,int iSFXnum,int freq,int doppler,int dst,int azimuth,int relvel,int dir);
void AudioCmn_TrafficSkidSFX(int sndPlayer,s_type surface1,s_type surface2,int force,int Distsq,int azimuth);
void AudioCmn_PlayerHornOn(int carIndex,int Distsq,int iFreqIn,int azimuth,int doppler);
int AudioCmn_PlayerHornOff(int carIndex);
void AudioCmn_PlayFESFX(int SFXnum);
void AudioCmn_PlayFESFXVol(int SFXnum,int vol);
void AudioCmn_PlayWrongWaySFX(void);
void AudioCmn_PlayPauseSound(int patch);
void quickSirenOn(int sirennum);
void SuperCopSirenOn(int sirennum);
void SirenOn(int sirennum,int supercop);
void SirenOff(int sirennum);
void UpdateSiren(int sirennum,int amp,int dop,int azimuth,int supercop);
void AudioCmn_UnPause(void);
void AudioCmn_InitReverb(void);


/* ---- AudioCmn_MusicLevel__Fi  [@0x80076420] ---- */
int AudioCmn_MusicLevel(int level)
{
  if (0x56 <= level) {
    return (((level + -0x55) * 7) / 2 + 0x55) * 0x46 >> 7;
  }
  return level * 0x46 >> 7;
}

/* ---- AudioCmn_GetTrackRecordLapTime__Fv  [@0x80076480] ---- */
int AudioCmn_GetTrackRecordLapTime(void)
{
  return GameSetup_gData.userSetting.bestlap;   /* 2-diff near-miss: oracle fuses the +offset into %lo (maspsx splits it) — a toolchain reloc difference, not a source fix */
}

/* ---- AudioCmn_InitThunder__Fv  [@0x80076490] ---- */
void AudioCmn_InitThunder(void)
{
  AudioCmn_ThunderAmp = 0;
  AudioCmn_ThunderAzi = 0;
  AudioCmn_ThunderDel = 0;
  return;
}

/* ---- AudioCmn_PlayThunder__Fii  [@0x800764a4] ---- */
void AudioCmn_PlayThunder(int intensity,int azimuth)
{
  if (AudioCmn_ThunderAmp < intensity) {
    AudioCmn_ThunderAmp = intensity;
    AudioCmn_ThunderAzi = azimuth;
    AudioCmn_ThunderDel = 0x87 - intensity;
  }
  return;
}

/* ---- AudioCmn_UpdateThunder__Fv  [@0x800764d0] ---- */
void AudioCmn_UpdateThunder(void)
{
  u_int uVar1;
  int iVar2;
  
  if ((0 < AudioCmn_ThunderAmp) &&
     (AudioCmn_ThunderDel = AudioCmn_ThunderDel + -1, AudioCmn_ThunderDel < 0)) {
    AudioCmn_PlaySound(gSndBnk[3].bnkID,0x16,AudioCmn_ThunderAzi,AudioCmn_ThunderAmp,0x40);
    if (0x2e <= AudioCmn_ThunderAmp) {
      uVar1 = random() & 0xf;
      iVar2 = AudioCmn_ThunderAmp + 3;
    }
    else {
      uVar1 = random() & 7;
      iVar2 = AudioCmn_ThunderAmp + 2;
    }
    iVar2 -= uVar1;
    AudioCmn_ThunderAmp = iVar2;
    iVar2 = random();
    AudioCmn_ThunderDel = iVar2 + 0x14U & 3;
  }
  return;
}

/* ---- AudioCmn_InitAsyncSfx__Fv  [@0x8007657c] ---- */
void AudioCmn_InitAsyncSfx(void)
{
  int iVar3;

  iVar3 = 0;
  while (1) {
    if (0x20 <= iVar3) break;
    AudioCmn_gSfxSlot[iVar3].patch = -1;
    AudioCmn_gSfxSlot[iVar3].handle = -1;
    AudioCmn_gSfxSlot[iVar3].header = (char *)0x0;
    iVar3 = iVar3 + 1;
  }
  return;
}

/* ---- AudioCmn_RemoveAsyncSfx__Fi  [@0x800765b4] ---- */
void AudioCmn_RemoveAsyncSfx(int slot)
{
  AudioCmn_tAsyncSfxSlot *s;
  char *ptr;

  s = &AudioCmn_gSfxSlot[slot];
  if (s->patch != -1) {
    if (s->handle != 0xffffffff) {
      SNDbankremove(s->handle);
      ptr = s->header;
      s->handle = -1;
      if (ptr != (char *)0x0) {
        purgememadr(ptr);
        s->header = (char *)0x0;
      }
    }
    s->patch = -1;
  }
  return;
}

/* ---- AudioCmn_DeInitAsyncSfx__Fv  [@0x8007663c] ---- */
void AudioCmn_DeInitAsyncSfx(void)
{
  int i;
  int slot;
  
  slot = 0;
  do {
    AudioCmn_RemoveAsyncSfx(slot);
    slot = slot + 1;
  } while (slot < 0x20);
  return;
}

/* ---- AudioCmn_RemoveOldestAsyncSfx__Fi  [@0x80076674] ---- */
int AudioCmn_RemoveOldestAsyncSfx(int bank)
{
  int oldest;
  int ticks;
  int i;
  int iVar1;
  AudioCmn_tAsyncSfxSlot *pAVar2;
  int iVar3;
  int slot;
  
  slot = -1;
  pAVar2 = AudioCmn_gSfxSlot;
  iVar1 = simGlobal.gameTicks + -0x10;
  for (iVar3 = 0; iVar3 < 0x20; iVar3 = iVar3 + 1) {
    if ((pAVar2->patch != -1) && (pAVar2->ticks < iVar1)) {
      iVar1 = pAVar2->ticks;
      slot = iVar3;
    }
    pAVar2 = pAVar2 + 1;
  }
  iVar1 = 0;
  if (slot == -1) {
    pAVar2 = AudioCmn_gSfxSlot;
    for (; iVar1 < 0x20; iVar1 = iVar1 + 1) {
      if ((pAVar2->patch != -1) && (pAVar2->bank < bank)) {
        slot = iVar1;
      }
      pAVar2 = pAVar2 + 1;
    }
  }
  if (-1 < slot) {
    AudioCmn_RemoveAsyncSfx(slot);
  }
  return slot;
}

/* ---- AudioCmn_LoadAsyncSfx__FiiPvi  [@0x8007675c] ---- */
void AudioCmn_LoadAsyncSfx(int bank,int patch,void *pbank,int size)
{
  int slot;
  int check;
  u_int name;
  void *pThis;
  int iVar1;
  AudioCmn_tAsyncSfxSlot *pAVar2;
  int local_30 [2];
  
  iVar1 = 0;
  pAVar2 = AudioCmn_gSfxSlot;
  while (((patch != pAVar2->patch || (bank != pAVar2->bank)) || (pAVar2->handle != -1))) {
    iVar1 = iVar1 + 1;
    pAVar2 = pAVar2 + 1;
    if (0x1f < iVar1) {
      return;
    }
  }
  if (size != 0) {
    do {
      iVar1 = SNDmemlargestunused(local_30);
      if (size <= iVar1 + -0x1000) {
        local_30[0] = SNDbankadd(&pAVar2->handle,(int)pbank);
        if (local_30[0] == 7) {
          name = SNDbankheadersize(pAVar2->handle);
          pThis = reservememadr("SFXHDR",name,0x10)
          ;
          pAVar2->header = (char *)pThis;
          if (pThis != 0x0) {
            SNDbankheadercopy(pThis,(u_char *)pAVar2->handle);
            pAVar2->patch = patch;
            pAVar2->ticks = simGlobal.gameTicks;
            return;
          }
        }
        if (bank == 2) {
          puts("SNDbankadd failed on speech!\n");
        }
        SNDbankheadersize(pAVar2->handle);
        if (-1 < local_30[0]) {
          SNDbankremove(pAVar2->handle);
        }
        goto LAB_800768b8;
      }
      iVar1 = AudioCmn_RemoveOldestAsyncSfx(bank);
    } while (iVar1 != -1);
    if (bank == 2) {
      puts("out of SPU ram on speech!\n");
      pAVar2->handle = -1;
      goto LAB_800768bc;
    }
  }
LAB_800768b8:
  pAVar2->handle = -1;
LAB_800768bc:
  pAVar2->patch = -1;
  return;
}

/* ---- AudioCmn_GetAsyncSfx__Fiib  [@0x80076900] ---- */
int AudioCmn_GetAsyncSfx(int bank,int patch,void *checkonly)
{
  int slot;
  CopSpeak_tRequest r;
  AudioCmn_tAsyncSfxSlot*s;
  bool bVar1;
  AudioCmn_tAsyncSfxSlot *pAVar2;
  int iVar3;
  u_int uVar4;
  CopSpeak_tRequest CStack_38;
  
  pAVar2 = AudioCmn_gSfxSlot;
  for (iVar3 = 0; iVar3 < 0x20; iVar3 = iVar3 + 1) {
    if ((patch == pAVar2->patch) && (bank == pAVar2->bank)) {
      pAVar2->ticks = simGlobal.gameTicks;
      return pAVar2->handle;
    }
    pAVar2 = pAVar2 + 1;
  }
  uVar4 = 0;
  pAVar2 = AudioCmn_gSfxSlot;
  do {
    if (pAVar2->patch == -1) break;
    uVar4 = uVar4 + 1;
    pAVar2 = pAVar2 + 1;
  } while ((int)uVar4 < 0x20);
  bVar1 = uVar4 < 0x20;
  if ((checkonly == (void *)0x0) && (bVar1 = uVar4 < 0x20, uVar4 == 0x20)) {
    uVar4 = AudioCmn_RemoveOldestAsyncSfx(bank);
    bVar1 = uVar4 < 0x20;
  }
  if (!bVar1) {
    return -1;
  }
  if (checkonly == (void *)0x0) {
    iVar3 = CopSpeak_SfxQueued();
    if (5 < iVar3) {
      return -1;
    }
    CopSpeak_InitRequest(&CStack_38);
    CStack_38.sfx = '\x01';
    CStack_38.bank = (char)bank;
    CStack_38.phrase = patch;
    iVar3 = CopSpeak_Request(&CStack_38);
    if (iVar3 == -1) {
      return -1;
    }
  }
  AudioCmn_gSfxSlot[uVar4].bank = bank;
  AudioCmn_gSfxSlot[uVar4].patch = patch;
  AudioCmn_gSfxSlot[uVar4].ticks = simGlobal.gameTicks;
  return -1;
}

/* ---- AudioCmn_Init__Fv  [@0x80076a74] ---- */
void AudioCmn_Init(void)
{
  int j;
  int temptrack;
  int (*paiVar1) [2];
  int iVar2;
  AudioCmn_tReTrig *pAVar3;
  int *piVar4;
  int *piVar5;
  int *piVar6;
  int *piVar7;
  
  /* @0x80076A7C: if(AudioCmn_kAudioOn==0) goto lbl_80076AF0 (the per-player loop, which always runs).
   * The channel-array init + false-lap-trigger select + backwards-direction are audio-on-guarded (H42). */
  if (AudioCmn_kAudioOn != 0) {
    AudioCmn_InitChannelArray();
    iVar2 = GameSetup_gData.track;
    if ((GameSetup_gData.track & 0x10U) != 0) {
      iVar2 = (GameSetup_gData.track & 0xfU) + 5;
    }
    if (GameSetup_gData.reverseTrack == 0) {
      paiVar1 = falseLapTrigNumsForward;
    }
    else {
      paiVar1 = falseLapTrigNumsBackward;
    }
    falseLapTrigCur = paiVar1[iVar2][0];
    flaseLapTrigTrack = paiVar1[iVar2][1];
    falseLapCounter = 0;
    intensityFalseLapCounter = 0;
    audioBackwardsDirection = GameSetup_gData.reverseTrack;
  }
  iVar2 = 0;
  piVar7 = AudioCmn_gPlayerArrested;
  piVar6 = gtotallaptimes;
  piVar5 = PlayersRampedGasLevel;
  piVar4 = bestLapTime;
  pAVar3 = AudioCmn_gReTrig;
  do {
    pAVar3->count = 0;
    fAmbientRangeON[iVar2] = '\0';
    fMysticWindON[iVar2] = '\0';
    currentLap[iVar2] = '\0';
    *piVar4 = 0;
    *piVar5 = 0;
    *piVar6 = 0x200;
    *piVar7 = 0;
    piVar7 = piVar7 + 1;
    piVar6 = piVar6 + 1;
    piVar5 = piVar5 + 1;
    piVar4 = piVar4 + 1;
    iVar2 = iVar2 + 1;
    pAVar3 = pAVar3 + 1;
  } while (iVar2 < 2);
  AudioCmn_InitThunder();
  AudioCmn_InitAsyncSfx();
  AudioTrk_StartUp();
  fReverbOn = '\0';
  fReverbLevel = '\0';
  FadingMusic = '\0';
  StartedNewMusic = '\0';
  recordLapTime = AudioCmn_GetTrackRecordLapTime();
  trackMusicState = '\x04';
  AudioCmn_gLastFade = 0x7f;
  AudioCmn_gResume = 0;
  AudioCmn_gStreamRestartTimer = 0;
  gQuickSirenCount = 0;
  GameSetup_gData.userSetting.sfxLevel = gMasterSFXLevel;
  return;
}

/* ---- AudioCmn_SetLevels__Fv  [@0x8007701c] ---- */
void AudioCmn_SetLevels(void)
{
  if (Replay_ReplayInterface.statsScreen != 0) {
    AudioCmn_gLastFade = 0x20;
    gMasterSFXLevel = (GameSetup_gData.userSetting.sfxLevel * 0x40) / 0x7f;
  }
  return;
}

/* ---- AudioCmn_GetTimePhrase__Fi  [@0x8007706c] ---- */
int AudioCmn_GetTimePhrase(int time)
{
  int seconds;
  static char compareTimes[25] = {
    30, 12, 6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9,
    -10, -11, -12, -15, -20, -25, -30
  };
  int index;

  if (-1 < time) {
    seconds = time >> 6;
  }
  else {
    seconds = (time + -1) >> 6;
  }
  index = 0;
  do {
    if ((signed char)compareTimes[index] <= seconds) break;
    index = index + 1;
  } while (index < 0x19);
  return index + 0x35;
}

/* ---- AudioCmn_CheckState__FP8Car_tObj  [@0x800770bc] ---- */
void AudioCmn_CheckState(Car_tObj *car)
{
  char carnum;
  int carspeed;
  int opponents;
  int position;
  CopSpeak_tRequest r;
  bool saidplayer;
  int phrase;
  bool bVar1;
  int iVar2;
  int iVar3;
  u_int uVar4;
  CopSpeak_tRequest CStack_38;
  
  uVar4 = (u_int)(u_char)car->carIndex;
  if ((GameSetup_gData.raceType == 1) || (GameSetup_gData.raceType == 5)) {
    if (((*(int *)((char *)Cars_gHumanRaceCarList[0] + 0x260)) & 0x200) != 0) {
      return;
    }
    if ((Cars_gNumHumanRaceCars == 2) && (((*(int *)((char *)Cars_gHumanRaceCarList[1] + 0x260)) & 0x200) != 0)) {
      return;
    }
  }
  if (GameSetup_gData.numLaps == 1) {
    return;
  }
  iVar3 = car->currentSpeed;
  if (GameSetup_gData.reverseTrack != 0) {
    iVar3 = -iVar3;
  }
  if (((car->stats).lap < GameSetup_gData.numLaps) &&
     (iVar3 = fixedmult(iVar3,0x50000),
     ((car->stats).lap + 1) * gNumSlices < (car->stats).sliceTotal + iVar3 / 0x60000)) {
    if ((recordLapTime == 0) || (simGlobal.gameTicks - gtotallaptimes[uVar4] < recordLapTime)) {
      AudioCmn_GetAsyncSfx(2,1,(void *)0x0);
    }
    if (((car->stats).lap != 0) &&
       (simGlobal.gameTicks - gtotallaptimes[uVar4] < bestLapTime[uVar4])) {
      AudioCmn_GetAsyncSfx(2,0,(void *)0x0);
    }
    iVar3 = Stats_GetNumOpponents();
    if (1 < iVar3) {
      if ((iVar3 < 3) && ((car->stats).checkpointDisplay != 0)) {
        iVar2 = AudioCmn_GetTimePhrase(-(car->stats).checkpointDifference);
      }
      else {
        iVar2 = Stats_GetPosition(car);
        if (iVar2 == iVar3) {
          iVar2 = 8;
        }
        iVar2 = iVar2 + 0x4f;
      }
      if (GameSetup_gData.commMode == 1) {
        AudioCmn_GetAsyncSfx(2,uVar4 + 0x33,(void *)0x0);
        iVar2 = iVar2 + (uVar4 + 1) * 0x23;
      }
      AudioCmn_GetAsyncSfx(2,iVar2,(void *)0x0);
    }
    iVar3 = (car->stats).lap;
    if (iVar3 < GameSetup_gData.numLaps + -1) {
      if (iVar3 < GameSetup_gData.numLaps + -2) {
        iVar3 = iVar3 + 5;
      }
      else {
        iVar3 = 2;
      }
      AudioCmn_GetAsyncSfx(2,iVar3,(void *)0x0);
    }
  }
  if (car->lap == (u_int)(u_char)currentLap[uVar4]) {
    return;
  }
  if (AudioCmn_gPlayerArrested[uVar4] != 0) {
    return;
  }
  CopSpeak_InitRequest(&CStack_38);
  bVar1 = false;
  if ((GameSetup_gData.commMode == 1) &&
     ((car->stats).time[(car->stats).lap + -1] < bestLapTime[car->carIndex])) {
    CStack_38.phrase = uVar4 + 0x33;
    CopSpeak_Request(&CStack_38);
    bVar1 = true;
  }
  if ((recordLapTime == 0) ||
     (iVar3 = (car->stats).time[(car->stats).lap + -1], iVar3 < recordLapTime)) {
    CStack_38.phrase = 1;
    recordLapTime = (car->stats).time[(car->stats).lap + -1];
    bestLapTime[car->carIndex] = recordLapTime;
  }
  else {
    if (bestLapTime[car->carIndex] <= iVar3) goto LAB_800774e0;
    CStack_38.phrase = 0;
    bestLapTime[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
  }
  CopSpeak_Request(&CStack_38);
LAB_800774e0:
  iVar3 = Stats_GetNumOpponents();
  if (1 < iVar3) {
    iVar2 = Stats_GetPosition(car);
    if (car->lap < GameSetup_gData.numLaps) {
      if ((iVar3 < 3) && ((car->stats).checkpointDisplay != 0)) {
        iVar3 = AudioCmn_GetTimePhrase(-(car->stats).checkpointDifference);
        CStack_38.phrase = iVar3;
        if (((GameSetup_gData.commMode == 1) && (!bVar1)) &&
           ((iVar3 - 0x3bU < 3 || (iVar3 - 0x3fU < 0xf)))) {
          CStack_38.phrase = uVar4 + 0x33;
          CopSpeak_Request(&CStack_38);
          bVar1 = true;
          CStack_38.phrase = iVar3;
        }
      }
      else {
        CStack_38.phrase = iVar2 + 0x4e;
        if (iVar2 == iVar3) {
          CStack_38.phrase = 0x57;
        }
      }
      if ((GameSetup_gData.commMode == 1) && (!bVar1)) {
        CStack_38.phrase = CStack_38.phrase + (uVar4 + 1) * 0x23;
      }
    }
    else if ((GameSetup_gData.commMode != 1) || (bVar1)) {
      CStack_38.phrase = iVar2 + 10;
      if ((iVar2 == iVar3) && (CStack_38.phrase = iVar2 + 10, 2 < iVar2)) {
        CStack_38.phrase = 0x12;
      }
    }
    else if ((iVar2 == iVar3) && (2 < iVar2)) {
      CStack_38.phrase = 0x22;
      if (uVar4 == 0) {
        CStack_38.phrase = 0x1a;
      }
    }
    else {
      CStack_38.phrase = iVar2 + 0x1a;
      if (uVar4 == 0) {
        CStack_38.phrase = iVar2 + 0x12;
      }
    }
    CopSpeak_Request(&CStack_38);
  }
  iVar3 = (car->stats).lap;
  if (iVar3 < GameSetup_gData.numLaps) {
    CStack_38.phrase = iVar3 + 4;
    if (GameSetup_gData.numLaps + -1 <= iVar3) {
      CStack_38.phrase = 2;
    }
    CopSpeak_Request(&CStack_38);
  }
  if (currentLap[uVar4] == '\0') {
    bestLapTime[uVar4] = simGlobal.gameTicks - gtotallaptimes[uVar4];
  }
  currentLap[uVar4] = (char)car->lap;
  gtotallaptimes[uVar4] = (car->stats).lapTime;
  falseLapCounter = car->lap;
  intensityFalseLapCounter = car->lap;
  return;
}

/* ---- AudioCmn_LoadFESamples__Fv  [@0x80077738] ---- */
void AudioCmn_LoadFESamples(void)
{
  char acStack_70 [104];

  strcpy(acStack_70, gAudioBasePath[0]);
  strcat(acStack_70, "fesfx");
  AudioCmn_LoadBank(acStack_70,0);
  return;
}

/* ---- AudioCmn_LoadGameSamples__Fv  [@0x8007777c] ---- */
void AudioCmn_LoadGameSamples(void)
{
  char filename[100];
  char *TrackGenBank[11];

  AudioEng_StartUp(0,GameSetup_gCarNames[0] + GameSetup_gData.carInfo[0].carType * 5);
  if (GameSetup_gData.commMode == 1) {
    AudioEng_StartUp(1,GameSetup_gCarNames[0] + GameSetup_gData.carInfo[1].carType * 5);
  }
  AudioEng_StartServer();
  strcpy(filename, gAudioBasePath[0]);
  strcat(filename, "Gen");
  memcpy(TrackGenBank, (char **)AudioCmn_FESFX_loadLangMap, sizeof(TrackGenBank));
  strcat(filename, TrackGenBank[(int)Audio_gFESFXTable.languages]);
  AudioCmn_LoadBank(filename,3);
  gSndBnk[5].bnkID = -2;
  gSndBnk[2].bnkID = -3;
  return;
}

/* ---- AudioCmn_InitChannelArray__Fv  [@0x800778b0] ---- */
void AudioCmn_InitChannelArray(void)
{
  int i;
  Channels_t *pCVar1;
  int iVar2;
  int neg1;

  iVar2 = 0;
  neg1 = -1;
  pCVar1 = gaChannel;
  do {
    pCVar1->Partial = neg1;
    pCVar1->SFXnum = neg1;
    pCVar1 = pCVar1 + 1;
  } while (++iVar2 < 0x47);
  AudioCmn_gCursorSndHandle = -1;
  return;
}

/* ---- scaleFrequency__Fiii  [@0x800778e8] ---- */
int scaleFrequency(int sndPlayer,int iSFXnum,int tweakedForce)
{
  int scaledFreq;
  u_int uVar1;
  u_int uVar2;
  
  if (sndPlayer - 0x12U < 2) {
    uVar1 = (tweakedForce * 0x7f) / 0xa0000;
    uVar2 = 0x7f;
    if ((int)uVar1 < 0x80) {
      uVar2 = uVar1;
    }
  }
  else if (sndPlayer - 0x14U < 2) {
    uVar1 = (tweakedForce * 0x7f) / 0xa0000;
    uVar2 = 0x7f;
    if ((int)uVar1 < 0x80) {
      uVar2 = uVar1;
    }
  }
  else if (gaChannel[sndPlayer].SFXnum != iSFXnum) {
    uVar1 = (tweakedForce * 0x7f) / 0xa0000;
    uVar2 = 0x7f;
    if ((int)uVar1 < 0x80) {
      uVar2 = uVar1;
    }
    gAudioCmnLastFreq[sndPlayer] = (char)uVar2;
  }
  else {
    uVar2 = (u_int)(u_char)gAudioCmnLastFreq[sndPlayer];
  }
  return uVar2;
}

/* ---- ChooseImpactSample__Fi6s_typeT1  [@0x800779b4] ---- */
int ChooseImpactSample(int force,s_type surface1,s_type surface2)
{
  static int lastImpactSample;
  int iSFXnum;
  u_int uVar1;
  int iVar2;
  
  if (surface1 == 8) {
    return 0x13;
  }
  if ((surface1 == 2) && (surface2 == 0)) {
    return 0x1f;
  }
  if (surface1 != 1) {
LAB_80077a88:
    if (surface2 == 7) {
      return 0x12;
    }
    if ((surface1 != 1) || ((surface2 != 0 && (surface2 != 3)))) {
      if (0x5a < force) {
        return 0x21;
      }
      if (force - 0x47U < 0x14) {
        return 0x20;
      }
      if (force - 0x33U < 0x14) {
        return 0x25;
      }
      if (force - 0x1aU < 0x19) {
        return 0x22;
      }
      if (0x19 < force) {
        return 0;
      }
      return 0x1e;
    }
    if (0x50 < force) {
      return 0x21;
    }
    if (force - 0x17U < 0x3a) {
      return 0x22;
    }
    if (force - 0x11U < 6) {
      return 0x20;
    }
    if (0x10 < force) {
      return 0;
    }
    return 0x1d;
  }
  if (surface2 == 0xd) {
    return 0x1e;
  }
  if (surface2 == 0xe) {
LAB_80077b80:
    iVar2 = 0x1d;
  }
  else {
    if (surface2 == 4) {
      if (0x6e < force) {
        return 0x21;
      }
      uVar1 = random();
      if ((uVar1 & 1) == 0) {
        return 0x20;
      }
    }
    else {
      if (surface2 != 0xf) {
        if (surface2 != 5) goto LAB_80077a88;
        goto LAB_80077b80;
      }
      uVar1 = random();
      uVar1 = uVar1 & 3;
      if (uVar1 == 1) {
        return 0x22;
      }
      if (uVar1 == 0) {
        return 0x23;
      }
      if (uVar1 == 2) {
        return 0x20;
      }
      if (uVar1 != 3) {
        return 0x23;
      }
    }
    iVar2 = 0x25;
  }
  return iVar2;
}

/* ---- ChooseLoopedSample__F6s_typeT0  [@0x80077c94] ---- */
int ChooseLoopedSample(s_type surface1,s_type surface2)
{
  int SFXnum;
  int iVar1;
  
  iVar1 = 0x2c;
  if (surface1 == 2) {
    if (surface2 == 0) {
      iVar1 = 0x2a;
    }
    if (surface2 == 0x10) {
      iVar1 = 0x2d;
    }
    if (surface2 == 0x11) {
      iVar1 = 0x2e;
    }
    if (surface2 == 0x12) {
      iVar1 = 0x2f;
    }
    if (surface2 == 0xb) {
      iVar1 = 0x2b;
    }
    if (surface2 != 0xc) goto LAB_80077cec;
  }
  iVar1 = 0x2c;
LAB_80077cec:
  if ((surface1 == 1) &&
     ((((surface2 == 0 || (surface2 == 0x10)) || (surface2 == 3)) || (surface2 == 0xb)))) {
    iVar1 = 0x28;
  }
  if ((surface1 == 2) && (surface2 == 3)) {
    iVar1 = 0x29;
  }
  if ((surface1 == 1) && (surface2 == 0xc)) {
    iVar1 = 0x2c;
  }
  return iVar1;
}

/* ---- AudioCmn_SFX__Fi6s_typeT1iii  [@0x80077d50] ---- */
void AudioCmn_SFX(int sndPlayer,s_type surface1,s_type surface2,int tweakedForce,int Distsq,
               int azimuth)
{
  int iSFXnumber;
  int amplitude;
  int frequency;
  int tempAmp;
  Car_tObj*c;
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  Car_tObj *pCVar5;
  u_int uVar6;
  int vol;
  
  if (Distsq < 0x1324) {
    vol = ((0x1324 - Distsq) * 0x7f) / 0x1324;
  }
  else {
    vol = 0;
  }
  if (sndPlayer < 0) {
    iVar1 = (tweakedForce * 0x7f) / 0xa0000;
    iVar2 = 0x7f;
    if (iVar1 < 0x80) {
      iVar2 = iVar1;
    }
    iVar1 = ChooseImpactSample(iVar2,surface1,surface2);
    if (iVar1 == 0x1f) {
      iVar4 = ((vol * iVar2) / 0x7f) * 2;
      if (0x7f < iVar4) {
        iVar4 = 0x7f;
      }
      AudioCmn_PlaySFX(0x31,0x1f,0x40,0x10000,vol,azimuth);
      sndPlayer = 0x31;
      iVar1 = 0x23;
      iVar2 = 0x40;
      vol = iVar4;
    }
    else {
      sndPlayer = 0x31;
      if (iVar1 == 0x12) {
        AudioCmn_PlaySound(gSndBnk[3].bnkID,0x12,azimuth,0x7f,0x40);
        AudioCmn_PlaySound(gSndBnk[3].bnkID,0x16,azimuth,0x7f,0x40);
        AudioCmn_PlaySound(gSndBnk[3].bnkID,0x23,azimuth,vol,0x40);
        return;
      }
      iVar2 = 0x40;
    }
  }
  else {
    if (tweakedForce < 1) {
      freeVoiceChannel(sndPlayer);
      if (1 < sndPlayer - 0x12U) {
        return;
      }
      freeVoiceChannel(sndPlayer + 4);
      Cars_gList[sndPlayer - 0x12U]->audioDamageScrape = 0;
      return;
    }
    iVar1 = ChooseLoopedSample(surface1,surface2);
    iVar2 = scaleFrequency(sndPlayer,iVar1,tweakedForce);
    uVar6 = sndPlayer - 0x12;
    if (uVar6 < 2) {
      iVar4 = (tweakedForce * 0x7f) / 0xa0000;
      iVar3 = 0x7f;
      if (iVar4 < 0x80) {
        iVar3 = iVar4;
      }
      vol = vol * iVar3 >> 7;
      if (vol < 0x1f) {
        freeVoiceChannel(sndPlayer + 4);
        Cars_gList[uVar6]->audioDamageScrape = 0;
      }
      else {
        pCVar5 = Cars_gList[uVar6];
        if ((pCVar5->carInfo->carType < 0x1c) &&
           (((iVar4 = (pCVar5->render).currentRoll, 0 < iVar4 && (0x1e0000 < (pCVar5->N).damage[7]))
            || ((iVar4 < 0 && (0x1e0000 < (pCVar5->N).damage[3])))))) {
          AudioCmn_PlaySFX(sndPlayer + 4,0x28,iVar2 + 10,0x10000,vol * 3,azimuth);
          pCVar5->audioDamageScrape = vol;
        }
      }
    }
    if ((iVar1 == 0x2c) && (iVar2 = iVar2 + -0x3c, iVar2 < 0)) {
      iVar2 = 0;
    }
  }
  AudioCmn_PlaySFX(sndPlayer,iVar1,iVar2,0x10000,vol,azimuth);
  return;
}

/* ---- freeVoiceChannel__Fi  [@0x800780d0] ---- */
void freeVoiceChannel(int sndPlayer)
{
  void *pThis;

  if (AudioCmn_kAudioOn != 0) {
    if (sndPlayer != -1) {
      pThis = gaChannel[sndPlayer].Partial;
      if (pThis != (void *)0xffffffff) {   /* @0x80078108: Partial == -1 sentinel (disasm-v3) */
        SNDautovol(pThis,5,-1);
        gaChannel[sndPlayer].Partial = -1;
        gaChannel[sndPlayer].SFXnum = -1;
        NumSFXOn = NumSFXOn + -1;
      }
    }
  }
  return;
}

/* ---- AudioCmn_PlayDoppleredSound__Fiiiiii  [@0x80078140] ---- */
int AudioCmn_PlayDoppleredSound(int bhandle,int patchNum,int azimuth,int vol,int bend,int doppler)
{
  int shandle;
  SNDPLAYOPTS playopts;
  int iVar1;
  int iVar2;
  u_int bank;
  int local_30;
  char local_2c;
  u_char local_29;
  u_char local_28;
  u_char local_27;
  u_char local_25;
  u_short local_24;
  u_short local_20;
  
  SNDplaysetdef(&local_30);
  local_2c = (char)bhandle;
  if (patchNum == 0x7d) {
    local_28 = (u_char)(gMasterSFXLevel * vol >> 7);
    goto LAB_8007828c;
  }
  if (bhandle == -4) {
    local_28 = (u_char)(gMasterFENarrationLevel * 0x81 >> 7);
    goto LAB_8007828c;
  }
  iVar2 = gMasterAmbientLevel;
  if (bhandle == gSndBnk[2].bnkID) {
    iVar1 = vol * 0x28;
LAB_8007827c:
    iVar1 = iVar1 - vol;
  }
  else {
    if (bhandle != gSndBnk[5].bnkID) {
      if ((patchNum == 0x16) || (patchNum == 0x12)) {
        local_28 = (u_char)(gMasterSFXLevel * vol >> 7);
        goto LAB_8007828c;
      }
      iVar2 = gMasterSFXLevel;
      if ((patchNum != 3) ||
         ((iVar1 = vol << 7, bhandle != gSndBnk[0].bnkID && (bhandle != gSndBnk[2].bnkID)))) {
        if (patchNum == 0) {
          iVar1 = vol * 0xe;
          iVar2 = gMasterEngineLevel;
          goto LAB_80078280;
        }
        iVar1 = vol * 0x28;
      }
      goto LAB_8007827c;
    }
    iVar1 = vol * 0x82;
  }
LAB_80078280:
  local_28 = (u_char)(iVar2 * iVar1 >> 0xe);
LAB_8007828c:
  local_30 = patchNum;
  if (patchNum == 99) {
    local_30 = 1;
  }
  local_27 = (u_char)bend;
  local_24 = (u_short)(doppler >> 4);
  local_25 = Audio_direct3davail != 0;
  if (Audio_direct3davail == 0) {
    if (gStereoMode == 0) {
      local_29 = 0x40;
    }
    else if (azimuth - 0x4000U < 0x8000) {
      local_29 = (u_char)((u_int)(0xbfff - azimuth) >> 8);
    }
    else {
      local_29 = (u_char)((u_int)(azimuth + 0x4000) >> 8);
    }
  }
  else {
    local_20 = (u_short)azimuth;
  }
  if (local_2c < -1) {
    if (local_2c == -4) {
      bank = 2;
    }
    else {
      bank = (u_int)(local_2c == -3);
    }
    iVar2 = AudioCmn_GetAsyncSfx(bank,patchNum,(void *)0x0);
    local_2c = (char)iVar2;
    local_30 = 0;
  }
  iVar2 = -1;
  if (-1 < local_2c) {
    SNDplay(&local_30);
  }
  NumSFXOn = NumSFXOn + 1;
  return iVar2;
}

/* ---- AudioCmn_PlaySound__Fiiiii  [@0x800783a0] ---- */
int AudioCmn_PlaySound(int bhandle,int patchNum,int azimuth,int vol,int bend)
{
  int iVar1;
  
  iVar1 = AudioCmn_PlayDoppleredSound(bhandle,patchNum,azimuth,vol,bend,0x10000);
  return iVar1;
}

/* ---- AudioCmn_PlaySFX__Fiiiiii  [@0x800783cc] ---- */
int AudioCmn_PlaySFX(int sndPlayer,int iSFXnum,int iFreqIn,int iDopplerIn,int iAmpIn,int azimuth)
{
  int iPartial;
  int iFreq;
  int iAmp;
  long PatchBank;
  u_int uVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  Channels_t *pCVar6;
  
  if (iFreqIn < 0) {
    iFreqIn = 0;
  }
  iVar3 = 0x7f;
  if (iFreqIn < 0x80) {
    iVar3 = iFreqIn;
  }
  if (iAmpIn < 0) {
    iAmpIn = 0;
  }
  iVar4 = 0x7f;
  if (iAmpIn < 0x80) {
    iVar4 = iAmpIn;
  }
  iVar5 = gSndBnk[5].bnkID;
  if ((((((3 < sndPlayer - 0x1cU) && (3 < sndPlayer - 0x32U)) && (sndPlayer != 0x24)) &&
       ((sndPlayer != 0x36 && (0xf < sndPlayer - 0x37U)))) &&
      ((iVar5 = gSndBnk[2].bnkID, 7 < sndPlayer - 10U &&
       ((1 < sndPlayer - 0x1aU && (iVar5 = gSndBnk[5].bnkID, iSFXnum != 0x7d)))))) &&
     ((0x7d < iSFXnum ||
      ((iVar5 = gSndBnk[3].bnkID, iSFXnum != 8 &&
       (((iSFXnum < 8 || (0xb < iSFXnum)) || (iSFXnum < 10)))))))) {
    iVar5 = gSndBnk[*(u_char *)(gBankNumLookupTable + sndPlayer)].bnkID;
  }
  if (sndPlayer == 0x31) {
    gaChannel[0x31].Partial =
         AudioCmn_PlayDoppleredSound(iVar5,iSFXnum,azimuth,iVar4,iVar3,iDopplerIn);
    NumSFXOn = NumSFXOn + -1;
    gaChannel[0x31].SFXnum = iSFXnum;
  }
  else {
    pCVar6 = gaChannel + sndPlayer;
    if (gaChannel[sndPlayer].SFXnum == iSFXnum) {
      uVar1 = SNDover(pCVar6->Partial);
      if (uVar1 != 0) {
        pCVar6->Partial = -1;
        gaChannel[sndPlayer].SFXnum = -1;
      }
      if ((iVar5 < -1) &&
         (iVar2 = AudioCmn_GetAsyncSfx((u_int)(iVar5 == -3),iSFXnum,(void *)0x0), iVar2 == -1))
      {
        pCVar6->Partial = -1;
        gaChannel[sndPlayer].SFXnum = -1;
      }
      if (gaChannel[sndPlayer].SFXnum == iSFXnum) {
        uVar1 = gaChannel[sndPlayer].Partial;
        if (uVar1 == 0xffffffff) {
          gaChannel[sndPlayer].SFXnum = -1;
        }
        else {
          if (iSFXnum == 0x7d) {
            iVar5 = gMasterSFXLevel * iVar4 >> 7;
          }
          else {
            if (iVar5 == gSndBnk[2].bnkID) {
              iVar5 = gMasterAmbientLevel * iVar4 * 0x27;
            }
            else if (iVar5 == gSndBnk[5].bnkID) {
              iVar5 = gMasterAmbientLevel * iVar4 * 0x82;
            }
            else if (iSFXnum == 99) {
              iVar5 = gMasterAmbientLevel * iVar4 * 0x27;
            }
            else if ((iSFXnum == 3) && ((iVar5 == gSndBnk[0].bnkID || (iVar5 == gSndBnk[2].bnkID))))
            {
              iVar5 = gMasterSFXLevel * iVar4 * 0x7f;
            }
            else {
              if (iSFXnum == 0) {
                iVar4 = iVar4 * 0xe;
                iVar5 = gMasterEngineLevel;
              }
              else {
                iVar4 = iVar4 * 0x27;
                iVar5 = gMasterSFXLevel;
              }
              iVar5 = iVar5 * iVar4;
              uVar1 = gaChannel[sndPlayer].Partial;
            }
            iVar5 = iVar5 >> 0xe;
          }
          SNDvol(uVar1,iVar5);
          if (Audio_direct3davail == 0) {
            if (gStereoMode != 0) {
              if (azimuth - 0x4000U < 0x8000) {
                uVar1 = 0xbfff - azimuth;
              }
              else {
                uVar1 = azimuth + 0x4000U & 0xffff;
              }
              SNDpan(gaChannel[sndPlayer].Partial,(int)uVar1 >> 8);
            }
          }
          else {
            SND3dpos(gaChannel[sndPlayer].Partial,azimuth,0);
          }
          SNDpitchbend(gaChannel[sndPlayer].Partial,iVar3);
          SNDpitchmult(gaChannel[sndPlayer].Partial,iDopplerIn >> 4);
        }
        goto LAB_8007887c;
      }
    }
    pCVar6 = gaChannel + sndPlayer;
    if (pCVar6->Partial != 0xffffffff) {
      SNDstop(pCVar6->Partial);
      NumSFXOn = NumSFXOn + -1;
    }
    iVar3 = AudioCmn_PlayDoppleredSound(iVar5,iSFXnum,azimuth,iVar4,iVar3,iDopplerIn);
    if (iVar3 == -1) {
      pCVar6->Partial = -1;
      gaChannel[sndPlayer].SFXnum = -1;
    }
    else {
      pCVar6->Partial = iVar3;
      gaChannel[sndPlayer].SFXnum = iSFXnum;
    }
  }
LAB_8007887c:
  return gaChannel[sndPlayer].Partial;
}

/* ---- AudioCmn_SoundCar__FP8Car_tObjiiiiiii  [@0x800788bc] ---- */
void AudioCmn_SoundCar(Car_tObj *car,int dst,int iFreqIn,int doppler,int azimuth,int trackazim,int relvel,
               int cardir)
{
  int CurCarGasLevel;
  int freq;
  int roadSurface;
  int cobbleMod;
  int cobblestoneAmp;
  char SPSC;
  int PlayerPan;
  static char cobbleCount;
  int loadAmp;
  int amplitude;
  int roadNoiseAmp;
  int wetNoiseAmp;
  int roadNoiseFreq;
  int wetNoiseFreq;
  int iAmpIn;
  int tuntrig;
  int cam;
  int roadNoisePatch;
  int gas;
  u_char bVar1;
  short sVar2;
  bool bVar3;
  int iVar4;
  void *pvVar5;
  int iVar6;
  u_int uVar7;
  int iVar8;
  int sndPlayer;
  int iVar9;
  int iVar10;
  int iVar11;
  int iVar12;
  int local_38;
  
  AudioCmn_CheckState(car);
  iVar8 = 0x8000000;
  if (Camera_gInfo[car->carIndex].mode == 0xc) {
    iVar8 = 0x10000000;
    iVar9 = 0x10000;
  }
  else {
    iVar9 = 0x20000;
  }
  iVar8 = fixeddiv(iVar8,dst + iVar9);
  if (iVar8 < 0) {
    iVar8 = iVar8 + 0xffff;
  }
  iVar8 = iVar8 >> 0x10;
  iVar9 = (car->linearVel_ch).z;
  if (iVar9 < 0) {
    iVar9 = -iVar9;
  }
  iVar10 = 0;
  if (-1 < iVar9 + -0xd8000) {
    iVar10 = iVar9 + -0xd8000 >> 0xf;
  }
  iVar9 = iVar9 >> 0xf;
  if (0x7f < iVar9) {
    iVar9 = 0x7f;
  }
  iVar4 = iVar9;
  if (iVar9 < 0) {
    iVar4 = iVar9 + 0xf;
  }
  iVar4 = 8 - (iVar4 >> 4);
  if (iVar4 < 3) {
    iVar4 = 3;
  }
  local_38 = 0x40;
  if (0x96 < iFreqIn) {
    iFreqIn = 0x96;
  }
  if (iFreqIn < 0) {
    iFreqIn = 0;
  }
  iVar12 = (car->N).driveSurfaceType;
  pvVar5 = BWorldSm_TunnelFlagSm(&(car->N).simRoadInfo)
  ;
  if (pvVar5 == (void *)0x0) {
    if ((u_char)fReverbLevel < 0x20) {
      fReverbLevel = ' ';
      SNDfxmasterlevel(0x0,0x20);
      fReverbOn = '\x01';
    }
    else if (0x20 < (u_char)fReverbLevel) {
      uVar7 = 0x20;
      if (0x1f < (int)((u_char)fReverbLevel - 5)) {
        uVar7 = (u_char)fReverbLevel - 5;
      }
      fReverbLevel = (char)uVar7;
      SNDfxmasterlevel(0x0,uVar7 & 0xff);
    }
  }
  else {
    if ((GameSetup_gData.commMode != 1) && ((u_char)fReverbLevel < 100)) {
      uVar7 = 100;
      if ((u_char)fReverbLevel + 10 < 0x65) {
        uVar7 = (u_char)fReverbLevel + 10;
      }
      fReverbLevel = (char)uVar7;
      SNDfxmasterlevel(0x0,uVar7 & 0xff);
      fReverbOn = '\x01';
    }
    iVar10 = iVar10 + 0x14;
    local_38 = 0x5e;
  }
  bVar3 = false;
  if (GameSetup_gData.commMode == 1) {
    bVar3 = true;
    iVar11 = 0xc002;
    if (car->carIndex != 0) {
      iVar11 = 0x3ffe;
    }
  }
  else {
    iVar11 = 0;
  }
  if (car->blowout != 0) {
    iVar12 = 4;
    iVar9 = iVar9 << 1;
  }
  if (dst < 0x460000) {
    iVar6 = fixedmult(dst,dst);
    iVar9 = ((0x13240000 - iVar6) / 0x1324) * iVar9;
    iVar6 = iVar9 >> 0x10;
    if (iVar9 < 0) {
      iVar6 = iVar9 + 0xffff >> 0x10;
    }
  }
  else {
    iVar6 = 0;
  }
  switch(iVar12) {
  case 2:
  case 10:
  case 0xb:
  case 0xd:
    iVar9 = iVar10;
    if (iVar10 < 0) {
      iVar9 = iVar10 + 3;
    }
    iVar10 = iVar10 + (iVar9 >> 2);
    local_38 = 0x18;
    break;
  case 4:
  case 7:
  case 0xc:
                    
    if (iVar4 == 0) {
      trap(0x1c00);
    }
                    
    Audio_gFESFXTable.audioCounter = (u_char)(1 % iVar4);
    if ((((1 % iVar4 & 0xffU) == 0) && ((car->N).objAltitude < 0x3333)) && (0 < gMasterSFXLevel)) {
      iVar9 = 0;
      if (bVar3) {
        iVar9 = iVar11;
      }
      iVar4 = 0x40;
      if (iVar12 == 7) {
        iVar4 = 0x28;
      }
      AudioCmn_PlaySound(gSndBnk[3].bnkID,0x1d,iVar9,iVar6 / 2,iVar4);
    }
  }
  if (gMasterEngineLevel == 0) {
    return;
  }
  sVar2 = Camera_gInfo[car->carIndex].mode;
  if ((sVar2 < 0) ||
     ((iVar4 = 0, iVar9 = iVar10, 1 < sVar2 && (iVar4 = 1, iVar9 = iVar10 >> 1, 4 < sVar2)))) {
    iVar4 = 2;
    iVar9 = iVar10 >> 1;
  }
  uVar7 = (u_int)(u_char)(car->control).gasLevel;
  iVar10 = PlayersRampedGasLevel[car->carIndex];
  if (iVar10 < (int)uVar7) {
    iVar12 = (int)(uVar7 - iVar10) / 2;
    iVar11 = iVar10 + iVar12;
    if (iVar12 < 1) {
      iVar11 = iVar10 + 1;
    }
  }
  else {
    iVar12 = uVar7 - iVar10;
    if (iVar10 <= (int)uVar7) goto LAB_80078d54;
    if (iVar12 < 0) {
      iVar12 = iVar12 + 7;
    }
    iVar11 = iVar10 + -1;
    if (iVar12 >> 3 < 0) {
      iVar11 = iVar10 + (iVar12 >> 3);
    }
  }
  PlayersRampedGasLevel[car->carIndex] = iVar11;
LAB_80078d54:
  iVar10 = PlayersRampedGasLevel[car->carIndex];
  if (0xff < iVar10) {
    iVar10 = 0xff;
  }
  iVar12 = iVar8 * (iFreqIn + 0x28);
  if (iVar12 < 0) {
    iVar12 = iVar12 + 0x7f;
  }
  iVar11 = iVar12 >> 7;
  if (iVar12 >> 7 < iVar8) {
    iVar11 = iVar8;
  }
  iVar12 = iVar11 * 0x7f >> 7;
  iVar8 = iVar9 * iVar11 >> 7;
  if (pvVar5 == (void *)0x0) {
    iVar9 = Weather_GetNumParticles(car->carIndex);
  }
  else {
    iVar9 = 0;
  }
  iVar11 = iVar9 >> 3;
  if (0x7f < iVar9) {
    iVar9 = 0x7f;
    iVar11 = 0xf;
  }
  iVar6 = 0x7f;
  if (iVar8 < 0x80) {
    iVar6 = iVar8;
  }
  if ((relvel != 0) || (Camera_gInfo[car->carIndex].mode == 0xb)) {
    iVar8 = iVar12 << 0x10;
    iVar12 = iVar8 / doppler;
    if (doppler == 0) {
      trap(0x1c00);
    }
    if ((doppler == -1) && (iVar8 == -0x80000000)) {
      trap(0x1800);
    }
  }
  iVar8 = 0xe;
  if ((iVar4 == 0) && (iVar8 = 0, GameSetup_gData.commMode == 1)) {
    iVar8 = 0xe;
  }
  if (iVar6 == 0) {
    iVar8 = 0x19;
    if (car->carIndex == 0) {
      iVar8 = 0x18;
    }
    freeVoiceChannel(iVar8);
  }
  else {
    sndPlayer = 0x19;
    if (car->carIndex == 0) {
      sndPlayer = 0x18;
    }
    AudioCmn_PlaySFX(sndPlayer,iVar8,local_38,doppler,iVar6,azimuth);
  }
  if (car->carIndex == 0) {
    if ((GameSetup_gData.Weather == 1) && (iVar9 != 0)) {
      AudioCmn_PlaySFX(0x1a,0,0x48 - iVar11,doppler,iVar9,0);
    }
    else {
      freeVoiceChannel(0x1a);
    }
  }
  iVar8 = iVar10;
  if (((((car->control).gearShiftTimer != '\0') &&
       (bVar1 = (car->control).lastGear, bVar1 < (u_char)(car->control).gear)) && (bVar1 != 1)) &&
     (iVar10 != 0)) {
    uVar7 = (u_int)(u_char)(car->control).gearShiftTimer;
    iVar8 = car->specs->gearShiftDelay;
    if (iVar8 == 0) {
      trap(0x1c00);
    }
    if ((iVar8 == -1) && (iVar12 * uVar7 == -0x80000000)) {
      trap(0x1800);
    }
    iVar12 = iVar12 + (int)(iVar12 * uVar7) / iVar8 >> 1;
    iVar8 = iVar10 >> 2;
    if (uVar7 == 5) {
      iVar8 = iVar10 - iVar8;
    }
    else if (uVar7 == 4) {
      iVar8 = iVar10 >> 1;
    }
    else if ((uVar7 != 3) && (iVar8 = iVar10, uVar7 < 3)) {
      iVar8 = 0;
    }
    PlayersRampedGasLevel[car->carIndex] = iVar8;
  }
  iVar10 = car->specs->redline;
  iVar9 = car->flywheelRpm << 0x10;
  if (iVar10 == 0) {
    trap(0x1c00);
  }
  if ((iVar10 == -1) && (iVar9 == -0x80000000)) {
    trap(0x1800);
  }
  iVar11 = 0x7f;
  if (car->revLimit == 0) {
    iVar11 = iVar8 >> 1;
  }
  AudioEng_Set(car->carIndex,gMasterEngineLevel * iVar12 * 0xe >> 0xe,iVar9 / iVar10,iVar11,iVar4,
             doppler,azimuth,cardir);
                    
  return;
}

/* ---- AudioCmn_TrafficSFX__Fiiiiiiii  [@0x80079104] ---- */
void AudioCmn_TrafficSFX(int iChan,int iSFXnum,int freq,int doppler,int dst,int azimuth,int relvel,int dir)
{
  int iAmpIn;
  int player;
  int pitchmult;
  int iSFXnum_00;
  u_int uVar1;
  int iVar2;
  int iVar3;
  int iDopplerIn;
  
  uVar1 = 0;
  if (GameSetup_gData.commMode == 1) {
    uVar1 = iChan < 8 ^ 1;
  }
  iVar2 = 0x8000000;
  if (Camera_gInfo[uVar1].mode == 0xc) {
    iVar2 = 0x10000000;
    iVar3 = 0x10000;
  }
  else {
    iVar3 = 0x20000;
  }
  iVar2 = fixeddiv(iVar2,dst + iVar3);
  if (iVar2 < 0) {
    iVar2 = iVar2 + 0xffff;
  }
  iVar2 = iVar2 >> 0x10;
  if ((iVar2 == 0) && (iChan != -1)) {
    if (gaChannel[iChan].Partial != -1) {
      freeVoiceChannel(iChan);
    }
    if (gaChannel[iChan + 4].Partial != -1) {
      freeVoiceChannel(iChan + 4);
    }
    if (gaChannel[iChan + 8].Partial != -1) {
      freeVoiceChannel(iChan + 8);
    }
  }
  else {
    iVar3 = fixedmult(freq + 0x3333,doppler);
    iSFXnum_00 = CopSpeak_GetEnginePatch(iSFXnum,0);
    iDopplerIn = (iVar3 * 0x50 >> 10) << 4;
    AudioCmn_PlaySFX(iChan + 4,iSFXnum_00,0x40,iDopplerIn,
               (int)(iVar2 * (u_int)(u_char)""[((dir >> 0xc) - (dir >> 10)) + 0x40]) >> 7,azimuth);
    iVar3 = CopSpeak_GetEnginePatch(iSFXnum,1);
    AudioCmn_PlaySFX(iChan + 8,iVar3,0x40,iDopplerIn,
               (int)(iVar2 * (u_int)(u_char)""[(dir >> 10) - ((dir >> 0xc) + -0x40)]) >> 7,azimuth);
    iVar3 = iVar2 * relvel;
    if (0x280000 < relvel) {
      iVar3 = iVar2 * 0x280000;
    }
    AudioCmn_PlaySFX(iChan,99,freq,doppler,iVar3 / 0x280000,azimuth);
  }
  return;
}

/* ---- AudioCmn_TrafficSkidSFX__Fi6s_typeT1iii  [@0x80079390] ---- */
void AudioCmn_TrafficSkidSFX(int sndPlayer,s_type surface1,s_type surface2,int force,int Distsq,int azimuth)
{
  int iAmpIn;
  int iVar1;

  if (AudioCmn_kAudioOn != 0) {
    if (Distsq < 0x1324) {
      iVar1 = ((0x1324 - Distsq) * 0x7f) / 0x1324;
    }
    else {
      iVar1 = 0;
    }
    if ((iVar1 == 0) && (sndPlayer != -1)) {
      if (gaChannel[sndPlayer].Partial != -1) {
        freeVoiceChannel(sndPlayer);
      }
    }
    else {
      AudioCmn_SFX(sndPlayer,surface1,surface2,force,Distsq,azimuth);
    }
  }
  return;
}

/* ---- AudioCmn_PlayerHornOn__Fiiiii  [@0x80079444] ---- */
void AudioCmn_PlayerHornOn(int carIndex,int Distsq,int iFreqIn,int azimuth,int doppler)
{
  int sfx;
  int player;
  u_int uVar1;
  int sndPlayer;
  int iSFXnum;
  int iAmpIn;

  if (AudioCmn_kAudioOn != 0) {
    if (Distsq < 0x1324) {
      iAmpIn = ((0x1324 - Distsq) * 0x7f) / 0x1324;
    }
    else {
      iAmpIn = 0;
    }
    if (GameSetup_gData.commMode == 1) {
      iSFXnum = 10;
      if (carIndex == 0) {
        sndPlayer = 0x29;
      }
      else {
        sndPlayer = 0x2a;
      }
    }
    else {
      iSFXnum = 3;
      sndPlayer = 0x29;
    }
    if ((gaChannel[sndPlayer].Partial == 0xffffffff) ||
       (uVar1 = SNDover(gaChannel[sndPlayer].Partial), uVar1 == 0)) {
      AudioCmn_PlaySFX(sndPlayer,iSFXnum,iFreqIn,doppler,iAmpIn,azimuth);
    }
  }
  return;
}

/* ---- AudioCmn_PlayerHornOff__Fi  [@0x80079548] ---- */
int AudioCmn_PlayerHornOff(int carIndex)
{
  int player;
  u_int uVar1;
  int sndPlayer;

  if (AudioCmn_kAudioOn == 0) {
    return 0;
  }
  sndPlayer = 0x29;
  if (carIndex != 0) {
    if (GameSetup_gData.commMode == 1) {
      sndPlayer = 0x2a;
      goto LAB_8007957c;
    }
  }
  else {
LAB_8007957c:
    if (GameSetup_gData.commMode == 1) goto LAB_800795e8;
  }
  if (((Cars_gList[carIndex]->carInfo->carType == 0x14) &&
      (gaChannel[sndPlayer].Partial != 0xffffffff)) &&
     (uVar1 = SNDover(gaChannel[sndPlayer].Partial), uVar1 == 0)) {
    return 1;
  }
LAB_800795e8:
  freeVoiceChannel(sndPlayer);
  return 0;
}

/* ---- AudioCmn_PlayFESFX__Fi  [@0x80079604] ---- */
void AudioCmn_PlayFESFX(int SFXnum)
{
  AudioCmn_PlayFESFXVol(SFXnum,0x7f);
  return;
}

/* ---- AudioCmn_PlayFESFXVol__Fii  [@0x80079624] ---- */
void AudioCmn_PlayFESFXVol(int SFXnum,int vol)
{
  SNDPLAYOPTS playopts;
  int local_28;
  u_char local_24;
  u_char local_21;
  u_char local_20;
  u_char local_1f;
  u_char local_1d;
  
  SNDplaysetdef(&local_28);
  local_1d = 0;
  local_1f = 0x40;
  local_21 = 0x40;
  local_24 = (u_char)gSndBnk[0].bnkID;
  local_20 = (u_char)(gMasterSFXLevel * vol * 0x78 >> 0xe);
  local_28 = SFXnum;
  SNDplay(&local_28);
  NumSFXOn = NumSFXOn + 1;
  return;
}

/* ---- AudioCmn_PlayWrongWaySFX__Fv  [@0x800796ac] ---- */
void AudioCmn_PlayWrongWaySFX(void)
{
  AudioCmn_PlaySound(gSndBnk[3].bnkID,0x10,0,0x7f,0x40);
  return;
}

/* ---- AudioCmn_PlayPauseSound__Fi  [@0x800796e4] ---- */
void AudioCmn_PlayPauseSound(int patch)
{
  AudioCmn_gCursorSndHandle = AudioCmn_PlaySound(gSndBnk[3].bnkID,patch,0,0x7f,0x40);
  return;
}

/* ---- quickSirenOn__Fi  [@0x8007971c] ---- */
void quickSirenOn(int sirennum)
{
  int patch;
  int iVar1;
  
  iVar1 = 8;
  if ((sirennum & 1U) != 0) {
    iVar1 = 6;
  }
  iVar1 = AudioCmn_PlaySound(gSndBnk[3].bnkID,iVar1,0x40,0,sirenCurrentPitch[sirennum]);
  gaChannel[sirennum + 0x2b].Partial = iVar1;
  return;
}

/* ---- SuperCopSirenOn__Fi  [@0x80079790] ---- */
void SuperCopSirenOn(int sirennum)
{
  int iVar1;
  
  iVar1 = AudioCmn_PlaySound(gSndBnk[3].bnkID,9,0x40,0,sirenCurrentPitch[sirennum]);
  gaChannel[sirennum + 0x2b].Partial = iVar1;
  return;
}

/* ---- SirenOn__Fii  [@0x800797f8] ---- */
void SirenOn(int sirennum,int supercop)
{
  if (bSirenOn[sirennum] == 0) {
    bSirenOn[sirennum] = 1;
    if (supercop != 0) {
      quickSirenActive[sirennum] = 1;
      sirenCount[sirennum] = -1;
      SuperCopSirenOn(sirennum);
    }
    else {
      quickSirenActive[sirennum] = 1;
      sirenCount[sirennum] = gQuickSirenCount;
      quickSirenOn(sirennum);
      gQuickSirenCount = gQuickSirenCount + 1;
    }
  }
  return;
}

/* ---- SirenOff__Fi  [@0x800798a0] ---- */
void SirenOff(int sirennum)
{
  bSirenOn[sirennum] = 0;
  bSirenPitchingUp[sirennum] = 1;
  quickSirenActive[sirennum] = 0;
  sirenCurrentPitch[sirennum] = 0x20;
  slowSirenReps[sirennum] = 3;
  reachedSirenMin[sirennum] = 0;
  quickSirenTimeCount[sirennum] = 0;
  SNDautovol(gaChannel[sirennum + 0x2b].Partial,5,-1);
  return;
}

/* ---- UpdateSiren__Fiiiii  [@0x8007995c] ---- */
void UpdateSiren(int sirennum,int amp,int dop,int azimuth,int supercop)
{
  int iFreq;
  u_int uVar1;
  int bend;
  int iVar2;
  
  if (bSirenOn[sirennum] != 0) {
    uVar1 = SNDover(gaChannel[sirennum + 0x2b].Partial);
    if (uVar1 != 0) {
      if (supercop == 0) {
        quickSirenOn(sirennum);
      }
      else {
        SuperCopSirenOn(sirennum);
      }
    }
    quickSirenTimeCount[sirennum] = quickSirenTimeCount[sirennum] + 1;
    if (dop < 0) {
      dop = dop + 0x3ff;
    }
    iVar2 = dop >> 10;
    if (iVar2 < 0) {
      iVar2 = 0;
    }
    bend = 0x7f;
    if (iVar2 < 0x80) {
      bend = iVar2;
    }
    SNDpitchbend(gaChannel[sirennum + 0x2b].Partial,bend);
    if (sirenCount[sirennum] == -1) {
      iVar2 = amp * 0x25;
    }
    else {
      iVar2 = amp * 0x2f;
    }
    SNDvol(gaChannel[sirennum + 0x2b].Partial,gMasterAmbientLevel * iVar2 >> 0xe);
    if (Audio_direct3davail == 0) {
      if (gStereoMode != 0) {
        if (azimuth - 0x4000U < 0x8000) {
          uVar1 = 0xbfff - azimuth;
        }
        else {
          uVar1 = azimuth + 0x4000U & 0xffff;
        }
        SNDpan(gaChannel[sirennum + 0x2b].Partial,(int)uVar1 >> 8);
      }
    }
    else {
      SND3dpos(gaChannel[sirennum + 0x2b].Partial,azimuth,0);
    }
  }
  return;
}

/* ===================================================================================
 *  RECONSTRUCTED 2026-06-12 from nfs4-f.exe (disasm-v3 MIPS) — the audiocmn.obj tail
 *  SKIPPED from the original 42-fn pass. Full reconstructions, NOT stubs.
 *  Helper VAs resolved via disasm-v3 offset markers. 0x801131EC = &GameSetup_gData;
 *  +240/+244 = userSetting.musicLevel/.sfxLevel; gaChannel[71] (Channels_t {Partial,SFXnum}).
 * =================================================================================== */
/* sibling externs not already in audiocmn.cpp scope (defined in audioeng/audio/copspeak/spch) */
void AudioEng_StopServer(void);
void AudioEng_CleanUp(void);
void AudioEng_Pause(void);
void AudioTrk_CleanUp(void);
void Audio_CleanUp(void);
void CopSpeak_Stop(void);
void CopSpeak_Cancel(void);
void CopSpeak_SilenceCop(Car_tObj *car, int playerIndex);
void AudioMus_StopSong(int fadeticks);
void systemtask(int taskFlag);
extern "C" int  SNDstopall(void);             /* @0x800E81A8 */
extern "C" void SPCH_ClearEventQueue(void);   /* @0x800E74E0 */
/* additional helpers for AudioCmn_Reset (gettick/SNDSTRM_setpriority/SNDmemlargestunused
 * come from lib/libfns.h already included via audiocmn_externs.h) */
void CopSpeak_Server(void);
int  AudioTrk_PreLoad(void);
int  AudioMus_Buffered(void);
int  AudioMus_Threshold(void);
extern int gMusicHandle;

/* ---- AudioCmn_ReverbOff__Fv  [@0x80079ecc] ---- */
void AudioCmn_ReverbOff(void)
{
  SNDfxmasterlevel(0,0);
  fReverbLevel = '\0';
  fReverbOn = '\0';
}

/* ---- AudioCmn_Reset__Fv  [@0x80076bec] ---- (Ghidra decompile @NFS4.EXE.c:54396, disasm-v3 cross-checked:
 *  SNDstop arg restored; carInfo[] loop de-garbled; the goto-converging music-buffer wait kept verbatim.) */
void AudioCmn_Reset(void)
{
  bool ready;
  int  i, t, t0, b, th, patch;
  int  unused[2];   /* auStack_28[8] : SNDmemlargestunused scratch */

  CopSpeak_SilenceCop((Car_tObj *)0, 0);
  CopSpeak_Cancel();
  SPCH_ClearEventQueue();
  AudioCmn_DeInitAsyncSfx();
  for (i = 0; i < 0x47; i++) {
    if (gaChannel[i].Partial != -1) {
      SNDstop(gaChannel[i].Partial);
      gaChannel[i].Partial = -1;
      gaChannel[i].SFXnum  = -1;
    }
  }
  if (fReverbOn != '\0')
    AudioCmn_ReverbOff();
  AudioCmn_Init();
  if (0 < gMasterAmbientLevel) {
    ready = false;
    t0 = gettick();
    while (!ready && (t = gettick(), t < t0 + 0x280)) {
      ready = true;
      CopSpeak_Server();
      systemtask(0);
      if (0x8000 < SNDmemlargestunused(unused)) {
        if (GameSetup_gData.raceType == 1) {
          for (i = 0; i < 4; i++) {
            if (AudioCmn_GetAsyncSfx(2, i + 0x2f, (void *)0) == -1)
              ready = false;
          }
        }
        if (GameSetup_gData.Weather == 1 &&
            AudioCmn_GetAsyncSfx(1, 0, (void *)0) == -1)
          ready = false;
        for (i = 0; i < GameSetup_gData.numCars; i++) {
          if (GameSetup_gData.carInfo[i].carClass == 2) {
            patch = CopSpeak_GetEnginePatch(GameSetup_gData.carInfo[i].carType, 0);
            if (-1 < patch && AudioCmn_GetAsyncSfx(1, patch, (void *)0) == -1)
              ready = false;
            patch = CopSpeak_GetEnginePatch(GameSetup_gData.carInfo[i].carType, 1);
            if (-1 < patch && AudioCmn_GetAsyncSfx(1, patch, (void *)0) == -1)
              ready = false;
          }
        }
      }
    }
  }
  AudioTrk_PreLoad();
  if (gMasterMusicLevel == 0)
    return;
  AudioMus_Volume(AudioCmn_MusicLevel(gMasterMusicLevel));
  SNDSTRM_setpriority(gMusicHandle, 0xff, 0xff);
  t0 = gettick();
  gettick();
  AudioMus_Buffered();
  AudioMus_Threshold();
  do {
    ready = false;
    t = gettick();
    if (t < t0 + 0x40 || AudioMus_Threshold() < 1)
      goto music_deadline;
    b  = AudioMus_Buffered();
    th = AudioMus_Threshold();
    if (b < th)
      goto music_deadline;
  music_deadline:
    if (gettick() < t0 + 0x100)
      ready = true;
    if (!ready) {
      b  = AudioMus_Buffered();
      th = AudioMus_Threshold();
      if (b < th + -100) {
        GameSetup_gData.userSetting.musicLevel = 0;
        gMasterMusicLevel = 0;
        AudioMus_Volume(AudioCmn_MusicLevel(0));
      } else {
        gettick();
      }
      gettick();
      AudioMus_Buffered();
      AudioMus_Threshold();
      return;
    }
    systemtask(0);
  } while (1);
}

/* ---- AudioCmn_DeInit__Fv  [@0x80076f44] ---- */
void AudioCmn_DeInit(void)
{
  int i;

  AudioEng_StopServer();
  AudioEng_CleanUp();
  CopSpeak_Stop();
  gMasterSFXLevel   = GameSetup_gData.userSetting.sfxLevel;    /* @0x801132e0 */
  gMasterMusicLevel = GameSetup_gData.userSetting.musicLevel;  /* @0x801132dc */
  AudioTrk_CleanUp();
  AudioCmn_DeInitAsyncSfx();
  for (i = 0; i < 71; i++) {
    if (gaChannel[i].Partial != -1)
      SNDstop(gaChannel[i].Partial);
    gaChannel[i].Partial = -1;
    gaChannel[i].SFXnum  = -1;
  }
  SNDstopall();
  SNDbankremove(-1);
  Audio_CleanUp();
  if (fReverbOn)
    AudioCmn_ReverbOff();
  AudioCmn_kAudioStreamingOn = gFEmusicON;
}

/* ---- AudioCmn_Pause__Fv  [@0x80079b60] ---- */
void AudioCmn_Pause(void)
{
  int i;

  CopSpeak_SilenceCop((Car_tObj *)0, 0);
  for (i = 0; i < 71; i++) {
    if (gaChannel[i].Partial != -1)
      SNDvol(gaChannel[i].Partial, 0);
  }
  AudioMus_Volume(0);
  if (fReverbOn)
    AudioCmn_ReverbOff();
  AudioEng_Pause();
  SNDstopall();
  gMasterSFXLevel   = GameSetup_gData.userSetting.sfxLevel;
  gMasterMusicLevel = GameSetup_gData.userSetting.musicLevel;
}

/* ---- AudioCmn_UnPauseAndQuit__Fv  [@0x80079ca4] ---- */
void AudioCmn_UnPauseAndQuit(void)
{
  int i;
  int j;

  while (SNDover(AudioCmn_gCursorSndHandle) == 0)
    systemtask(0);
  CopSpeak_Stop();
  SNDmastervol(0);
  AudioMus_StopSong(0);
  for (i = 0; i < 71; i++) {
    if (gaChannel[i].Partial != -1) {
      SNDstop(gaChannel[i].Partial);
      gaChannel[i].Partial = -1;
      gaChannel[i].SFXnum  = -1;
    }
  }
  GameSetup_gData.userSetting.sfxLevel   = gMasterSFXLevel;
  GameSetup_gData.userSetting.musicLevel = gMasterMusicLevel;
  if (fReverbOn)
    AudioCmn_ReverbOff();
  for (j = 0; j < 0x80; j++)
    SNDmastervol(j);
}

/* ---- AudioCmn_UnPauseAndRestart__Fv  [@0x80079d8c] ---- */
void AudioCmn_UnPauseAndRestart(void)
{
  int i;
  int j;

  SPCH_ClearEventQueue();
  while (SNDover(AudioCmn_gCursorSndHandle) == 0)
    systemtask(0);
  CopSpeak_Cancel();
  SNDmastervol(0);
  AudioCmn_DeInitAsyncSfx();
  AudioMus_StopSong(0);
  for (i = 0; i < 71; i++) {
    if (gaChannel[i].Partial != -1) {
      SNDstop(gaChannel[i].Partial);
      gaChannel[i].Partial = -1;
      gaChannel[i].SFXnum  = -1;
    }
  }
  for (j = 0; j < 0x80; j++)
    SNDmastervol(j);
  if (fReverbOn)
    AudioCmn_ReverbOff();
  GameSetup_gData.userSetting.sfxLevel   = gMasterSFXLevel;
  GameSetup_gData.userSetting.musicLevel = gMasterMusicLevel;
  AudioCmn_Init();
}

/* ---- AudioCmn_UnPause__Fv  [@0x80079c18] ---- */
void AudioCmn_UnPause(void)
{
  int iVar1;
  int iVar2;

  SNDmastervol(0x7f);
  iVar2 = gMasterMusicLevel;
  iVar1 = iVar2 << 3;
  if (0x55 < iVar2) {
    iVar2 = ((iVar2 + -0x55) * 7) / 2 + 0x55;
    iVar1 = iVar2 << 3;
  }
  AudioMus_Volume(((iVar1 + iVar2) * 4 - iVar2) * 2 >> 7);
  AudioEng_Resume();
  GameSetup_gData.userSetting.sfxLevel = gMasterSFXLevel;
  GameSetup_gData.userSetting.musicLevel = gMasterMusicLevel;
  return;
}

/* ---- AudioCmn_InitReverb__Fv  [@0x80079e88] ---- */
void AudioCmn_InitReverb(void)
{
  SNDfxinitbus(0x0,0x7f,10,-1,-1);
  fReverbLevel = '\0';
  SNDfxmasterlevel(0x0,0);
  fReverbOn = '\0';
  return;
}
