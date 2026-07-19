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
char         *AudioCmn_FESFX_loadLangMap[12] = {   /* @0x8005570c : image ptrs into the pooled lang-code literals @0x8013c68c+ (gcc string pooling reproduces the sharing) */
    "eng", "brt", "eng", "fre", "eng", "brt", "ger", "brt", "eng", "eng", "eng", 0
};
int          gBankNumLookupTable[71] = { 0, 2, 0, 2, 0, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 5, 5, 5, 5, 3, 3, 3, 3, 5, 2, 2, 2, 2, 0, 1, 2, 2, 2, 2, 0, 0, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0 };   /* @0x8010e4d0 */
int          falseLapTrigNumsForward[10][2] = { 4, 7, 4, 7, 4, 7, -1, -1, 4, 7, 4, 9, 4, 9, -1, -1, -1, -1, 4, 9 };   /* @0x8010e5ec */
int          falseLapTrigNumsBackward[10][2] = { 4, 5, 4, 5, -1, -1, -1, -1, 4, 5, 4, 5, 4, 5, -1, -1, -1, -1, 4, 5 };   /* @0x8010e63c */
char         Xfade[129] = { 0, 3, 7, 10, 13, 16, 19, 22, 24, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 46, 48, 50, 51, 53, 54, 55, 57, 58, 60, 61, 62, 63, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 84, 85, 86, 87, 88, 88, 89, 90, 91, 91, 92, 93, 94, 94, 95, 96, 96, 97, 98, 98, 99, 100, 100, 101, 101, 102, 103, 103, 104, 104, 105, 106, 106, 107, 107, 108, 108, 109, 109, 110, 110, 111, 111, 112, 112, 113, 113, 114, 114, 115, 115, 116, 116, 117, 117, 118, 118, 119, 119, 119, 120, 120, 121, 121, 122, 122, 122, 123, 123, 124, 124, 125, 125, 125, 126, 127, 127 };   /* @0x8010e68c */
char         SkidInitMaxFreq[71] = { 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };   /* @0x8010e710 */
char         *AudioCmn_LanguageName[7] = {   /* @0x8010e774 : image ptrs 0x8013c68c/90/94/98/9c + "eng" x2 (pooled) */
    "eng", "ger", "frn", "spn", "itl", "eng", "eng"
};
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
int AudioCmn_GetAsyncSfx(int bank,int patch,bool checkonly);
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


/* local helper used only for the AudioCmn_UnPause inline expansion below (the oracle inlines
   the AudioCmn_MusicLevel formula directly into UnPause with no jal -- see UnPause body).
   static so it folds away after inlining and never competes with the real out-of-line
   AudioCmn_MusicLevel__Fi symbol. */
static inline int AudioCmn_MusicLevel_inl(int level)
{
  if (0x56 <= level) {
    return (((level + -0x55) * 7) / 2 + 0x55) * 0x46 >> 7;
  }
  return level * 0x46 >> 7;
}

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
/* SYM (nfs4-f-v3.txt @0x80076674): named locals `oldest`=$s0, `ticks`=$v1, `i`=$a3 (outer
   loop) / $a1 (inner loop, same source name `i`, fresh block scope). Rewritten with array
   indexing (matches the SYM's plain "i" loop var, not a pointer-walk) instead of a
   pAVar2/pAVar2++ struct-pointer walk. */
int AudioCmn_RemoveOldestAsyncSfx(int bank)
{
  int oldest;
  int ticks;

  oldest = -1;
  ticks = simGlobal.gameTicks + -0x10;
  {
    int i;
    i = 0;
    while (1) {
      if (!(i < 0x20)) break;
      if ((AudioCmn_gSfxSlot[i].patch != -1) && (AudioCmn_gSfxSlot[i].ticks < ticks)) {
        ticks = AudioCmn_gSfxSlot[i].ticks;
        oldest = i;
      }
      i = i + 1;
    }
  }
  if (oldest == -1) {
    int i;
    i = 0;
    while (1) {
      if (!(i < 0x20)) break;
      if ((AudioCmn_gSfxSlot[i].patch != -1) && (AudioCmn_gSfxSlot[i].bank < bank)) {
        oldest = i;
      }
      i = i + 1;
    }
  }
  if (-1 < oldest) {
    AudioCmn_RemoveAsyncSfx(oldest);
  }
  return oldest;
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
int AudioCmn_GetAsyncSfx(int bank,int patch,bool checkonly)
{
  /* SYM rule-8: fn-scope slot(s0) + AUTO r; loop1 = top-test goto loop (slti;beqz + j back)
     with block-local s (v1) over the index-form walker (a0 = strength-reduced giv). */
  int slot;
  CopSpeak_tRequest r;

  AudioCmn_tAsyncSfxSlot *s;

  slot = 0;
  while (true) {
    if (!(slot < 0x20)) break;
    s = &AudioCmn_gSfxSlot[slot];
    if ((patch == s->patch) && (bank == s->bank)) goto FOUND;
    slot = slot + 1;
  }
  slot = 0;
  while (true) {
    if (AudioCmn_gSfxSlot[slot].patch == -1) break;
    slot = slot + 1;
    if (!(slot < 0x20)) break;
  }
  if ((checkonly == false) && (slot == 0x20)) {
    slot = AudioCmn_RemoveOldestAsyncSfx(bank);
  }
  if (!((u_int)slot < 0x20)) {
    return -1;
  }
  /* MATCH: goto-dispatch in oracle VA order — FOUND block sits between the checkonly
     guard pair (beqz s3 -> DOREQ; j FILL) and the CopSpeak block, exactly as laid out. */
  if (checkonly == false) goto DOREQ;
  goto FILL;
FOUND:
  s->ticks = simGlobal.gameTicks;
  return s->handle;
DOREQ:
  if (5 < CopSpeak_SfxQueued()) {
    return -1;
  }
  CopSpeak_InitRequest(&r);
  r.phrase = patch;
  r.sfx = '\x01';
  r.bank = (char)bank;
  if (CopSpeak_Request(&r) != -1) {
FILL:
    AudioCmn_gSfxSlot[slot].bank = bank;
    AudioCmn_gSfxSlot[slot].patch = patch;
    AudioCmn_gSfxSlot[slot].ticks = simGlobal.gameTicks;
  }
  return -1;
}

/* ---- AudioCmn_Init__Fv  [@0x80076a74] ---- */
void AudioCmn_Init(void)
{
  int j;
  int temptrack;
  int (*paiVar1) [2];

  /* @0x80076A7C: if(AudioCmn_kAudioOn==0) goto lbl_80076AF0 (the per-player loop, which always runs).
   * The channel-array init + false-lap-trigger select + backwards-direction are audio-on-guarded (H42). */
  if (AudioCmn_kAudioOn != 0) {
    AudioCmn_InitChannelArray();
    /* MATCH (SYM rule-8): temptrack = REG $4 (a0), mutated IN PLACE by the &0x10 arm
       (addiu a0,v0,5); track is loaded ONCE. audioBackwardsDirection is stored then
       RE-READ for the table select (the join point starts a new EBB, so no CSE) --
       the reverse-track temp (v1) dies at the store. */
    audioBackwardsDirection = GameSetup_gData.reverseTrack;
    temptrack = GameSetup_gData.track;
    if ((temptrack & 0x10) != 0) {
      temptrack = (temptrack & 0xf) + 5;
    }
    if (audioBackwardsDirection == 0) {
      paiVar1 = falseLapTrigNumsForward;
    }
    else {
      paiVar1 = falseLapTrigNumsBackward;
    }
    falseLapTrigCur = paiVar1[temptrack][0];
    flaseLapTrigTrack = paiVar1[temptrack][1];
    falseLapCounter = 0;
    intensityFalseLapCounter = 0;
  }
  /* MATCH: pure INDEX FORM for every per-player store -- gcc strength-reduces the word
     arrays + gReTrig (stride 0x20) into givs whose la inits self-materialize
     (lui tN;addiu tN,tN) exactly like the oracle; named walker pointers came out as a
     shared lui-v0 scratch instead. j = SYM REG $3 (v1). */
  {
    /* MATCH: word arrays as pointer walkers (&arr[0] inits) + gReTrig/char arrays in index
       form: this hoists the 0x200 constant (li t1,512 pre-loop, oracle) and gives gReTrig
       the oracle's lui-v0-scratch giv init. RESIDUAL (banked): the 4 walker inits emit
       expand-time split lui $2/addiu (HIGH+LO_SUM) where the oracle has post-expand macro
       `la tN` self-form -- a pass-origin identity (expand-split vs loop-pass-macro), no
       source shape found (index-form=split giv, byte-biv regresses 104); plus the
       temptrack(v1<->a0) head pair. */
    int *p7 = &AudioCmn_gPlayerArrested[0];
    int *p6 = &gtotallaptimes[0];
    int *p5 = &PlayersRampedGasLevel[0];
    int *p4 = &bestLapTime[0];
    j = 0;
    do {
      AudioCmn_gReTrig[j].count = 0;
      fAmbientRangeON[j] = '\0';
      fMysticWindON[j] = '\0';
      currentLap[j] = '\0';
      *p4 = 0;
      *p5 = 0;
      *p6 = 0x200;
      *p7 = 0;
      p7 = p7 + 1;
      p6 = p6 + 1;
      p5 = p5 + 1;
      p4 = p4 + 1;
      j = j + 1;
    } while (j < 2);
  }
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

/* file-scope (NOT function-local) -- oracle places this array immediately after
   SkidInitMaxFreq[71]@0x8010e710 at VA 0x8010E758 (0x8010e710+0x47), i.e. it's a
   TU-static global data table, not a function-local static. */
static char compareTimes[25] = {
  30, 12, 6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9,
  -10, -11, -12, -15, -20, -25, -30
};

/* ---- AudioCmn_GetTimePhrase__Fi  [@0x8007706c] ---- */
int AudioCmn_GetTimePhrase(int time)
{
  int seconds;
  int index;

  if (-1 < time) {
    seconds = time >> 6;
  }
  else {
    seconds = (time + -1) >> 6;
  }
  index = 0;
  while (1) {
    if (!(seconds < (signed char)compareTimes[index])) break;
    index = index + 1;
    if (!(index < 0x19)) break;
  }
  return index + 0x35;
}

/* ---- AudioCmn_CheckState__FP8Car_tObj  [@0x800770bc] ---- */
void AudioCmn_CheckState(Car_tObj *car)
{
  char carnum;
  int carspeed;

  carnum = (char)car->carIndex;
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
  carspeed = car->currentSpeed;
  if (GameSetup_gData.reverseTrack != 0) {
    carspeed = -carspeed;
  }
  if (((car->stats).lap < GameSetup_gData.numLaps) &&
     (carspeed = fixedmult(carspeed,0x50000),
     ((car->stats).lap + 1) * gNumSlices < (car->stats).sliceTotal + carspeed / 0x60000)) {
    if ((recordLapTime == 0) || (simGlobal.gameTicks - gtotallaptimes[(u_char)carnum] < recordLapTime)) {
      AudioCmn_GetAsyncSfx(2,1,false);
    }
    if (((car->stats).lap != 0) &&
       (simGlobal.gameTicks - gtotallaptimes[(u_char)carnum] < bestLapTime[(u_char)carnum])) {
      AudioCmn_GetAsyncSfx(2,0,false);
    }
    {
      int opponents;
      opponents = Stats_GetNumOpponents();
      if (1 < opponents) {
        int position;
        if (!((opponents < 3) && ((car->stats).checkpointDisplay != 0))) {
          position = Stats_GetPosition(car);
          if (position == opponents) {
            position = 8;
          }
          position = position + 0x4f;
        }
        else {
          position = AudioCmn_GetTimePhrase(-(car->stats).checkpointDifference);
        }
        if (GameSetup_gData.commMode == 1) {
          AudioCmn_GetAsyncSfx(2,(u_char)carnum + 0x33,false);
          position = position + ((u_char)carnum + 1) * 0x23;
        }
        AudioCmn_GetAsyncSfx(2,position,false);
      }
    }
    carspeed = (car->stats).lap;
    if (carspeed < GameSetup_gData.numLaps + -1) {
      if (carspeed < GameSetup_gData.numLaps + -2) {
        carspeed = carspeed + 5;
      }
      else {
        carspeed = 2;
      }
      AudioCmn_GetAsyncSfx(2,carspeed,false);
    }
  }
  if (car->lap == (u_int)(u_char)currentLap[(u_char)carnum]) {
    return;
  }
  if (AudioCmn_gPlayerArrested[(u_char)carnum] != 0) {
    return;
  }
  {
    CopSpeak_tRequest r;
    bool saidplayer;

    CopSpeak_InitRequest(&r);
    saidplayer = false;
    if ((GameSetup_gData.commMode == 1) &&
       ((car->stats).time[(car->stats).lap + -1] < bestLapTime[car->carIndex])) {
      r.phrase = (u_char)carnum + 0x33;
      CopSpeak_Request(&r);
      saidplayer = true;
    }
    if ((recordLapTime == 0) ||
       (carspeed = (car->stats).time[(car->stats).lap + -1], carspeed < recordLapTime)) {
      r.phrase = 1;
      recordLapTime = (car->stats).time[(car->stats).lap + -1];
      bestLapTime[car->carIndex] = recordLapTime;
    }
    else {
      if (bestLapTime[car->carIndex] <= carspeed) goto LAB_800774e0;
      r.phrase = 0;
      bestLapTime[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
    }
    CopSpeak_Request(&r);
LAB_800774e0:
    carspeed = Stats_GetNumOpponents();
    if (1 < carspeed) {
      int position;
      position = Stats_GetPosition(car);
      if (car->lap < GameSetup_gData.numLaps) {
        int phrase;
        if ((carspeed < 3) && ((car->stats).checkpointDisplay != 0)) {
          phrase = AudioCmn_GetTimePhrase(-(car->stats).checkpointDifference);
          r.phrase = phrase;
          if (((GameSetup_gData.commMode == 1) && (!saidplayer)) &&
             ((phrase - 0x3bU < 3 || (phrase - 0x3fU < 0xf)))) {
            r.phrase = (u_char)carnum + 0x33;
            CopSpeak_Request(&r);
            saidplayer = true;
            r.phrase = phrase;
          }
        }
        else {
          r.phrase = position + 0x4e;
          if (position == carspeed) {
            r.phrase = 0x57;
          }
        }
        if ((GameSetup_gData.commMode == 1) && (!saidplayer)) {
          r.phrase = r.phrase + ((u_char)carnum + 1) * 0x23;
        }
      }
      else if ((GameSetup_gData.commMode != 1) || (saidplayer)) {
        r.phrase = position + 10;
        if ((position == carspeed) && (r.phrase = position + 10, 2 < position)) {
          r.phrase = 0x12;
        }
      }
      else if ((position == carspeed) && (2 < position)) {
        r.phrase = 0x22;
        if ((u_char)carnum == 0) {
          r.phrase = 0x1a;
        }
      }
      else {
        r.phrase = position + 0x1a;
        if ((u_char)carnum == 0) {
          r.phrase = position + 0x12;
        }
      }
      CopSpeak_Request(&r);
    }
    carspeed = (car->stats).lap;
    if (carspeed < GameSetup_gData.numLaps) {
      r.phrase = carspeed + 4;
      if (GameSetup_gData.numLaps + -1 <= carspeed) {
        r.phrase = 2;
      }
      CopSpeak_Request(&r);
    }
  }
  if (currentLap[(u_char)carnum] == '\0') {
    bestLapTime[(u_char)carnum] = simGlobal.gameTicks - gtotallaptimes[(u_char)carnum];
  }
  currentLap[(u_char)carnum] = (char)car->lap;
  gtotallaptimes[(u_char)carnum] = (car->stats).lapTime;
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
/* BUG FIX (2026-07-11): the previous recon computed the candidate sample and RETURNED it
   directly from ~20 places, entirely skipping the oracle's anti-repeat mechanism (raw disasm
   @0x80077AF8 / @0x80077BE0, global D_8013C6AC = lastImpactSample): before returning, the
   oracle compares the candidate against lastImpactSample and, for a handful of specific
   candidate values, re-rolls via random() to avoid repeating the same impact sound twice in a
   row. lastImpactSample is a function-local static that (per a full-binary grep of every
   disasm dump) is NEVER WRITTEN anywhere in the program -- so at runtime this check always
   reads 0 and the reroll paths are dead (none of the candidate values is ever 0) -- but the
   real compiler still emitted ~80 real instructions for the mechanism, which is why the
   previous recon compiled to only 103 insns against the oracle's 184. Restored the mechanism
   (still using the same never-written `lastImpactSample` static, so behavior is unchanged --
   this is a byte-fidelity fix, not a gameplay fix) by routing every candidate through
   `iSFXnum` and an anti-repeat block per half of the switch instead of an early `return`. */
int ChooseImpactSample(int force,s_type surface1,s_type surface2)
{
  static int lastImpactSample;
  int iSFXnum;
  u_int uVar1;

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
        iSFXnum = 0x21;
      }
      else if (force - 0x47U < 0x14) {
        iSFXnum = 0x20;
      }
      else if (force - 0x33U < 0x14) {
        iSFXnum = 0x25;
      }
      else if (force - 0x1aU < 0x19) {
        iSFXnum = 0x22;
      }
      else if (0x19 < force) {
        iSFXnum = 0;
      }
      else {
        iSFXnum = 0x1e;
      }
    }
    else if (0x50 < force) {
      iSFXnum = 0x21;
    }
    else if (force - 0x17U < 0x3a) {
      iSFXnum = 0x22;
    }
    else if (force - 0x11U < 6) {
      iSFXnum = 0x20;
    }
    else if (0x10 < force) {
      iSFXnum = 0;
    }
    else {
      iSFXnum = 0x1d;
    }
    /* anti-repeat (2nd half): candidates here are 0x12,0x1e,0x20,0x21,0x22,0x25 (0 is dead). */
    if (iSFXnum == lastImpactSample) {
      if (iSFXnum == 0x21) {
        /* exempt, unchanged */
      }
      else if (iSFXnum == 0x20) {
        uVar1 = random();
        iSFXnum = ((uVar1 & 1) == 0) ? 0x22 : 0x25;
      }
      else if (iSFXnum < 0x21) {
        if (iSFXnum == 0x1e) {
          iSFXnum = 0x22;
        }
      }
      else if (iSFXnum == 0x22) {
        uVar1 = random();
        iSFXnum = ((uVar1 & 1) == 0) ? 0x25 : 0x1e;
      }
      else if (iSFXnum == 0x25) {
        uVar1 = random();
        iSFXnum = ((uVar1 & 1) == 0) ? 0x22 : 0x1e;
      }
    }
    return iSFXnum;
  }
  if (surface2 == 0xd) {
    return 0x1e;
  }
  if (surface2 == 0xe) {
LAB_80077b80:
    iSFXnum = 0x1d;
  }
  else if (surface2 == 4) {
    if (0x6e < force) {
      iSFXnum = 0x21;
    }
    else {
      uVar1 = random();
      iSFXnum = ((uVar1 & 1) == 0) ? 0x20 : 0x25;
    }
  }
  else if (surface2 == 0xf) {
    uVar1 = random() & 3;
    if (uVar1 == 1) {
      iSFXnum = 0x22;
    }
    else if (uVar1 == 0) {
      iSFXnum = 0x23;
    }
    else if (uVar1 == 2) {
      iSFXnum = 0x20;
    }
    else {
      iSFXnum = 0x25;
    }
  }
  else {
    if (surface2 != 5) goto LAB_80077a88;
    goto LAB_80077b80;
  }
  /* anti-repeat (1st half, surface1==1): candidates here are 0x12,0x1d,0x20,0x21,0x22,0x23,0x25. */
  if (iSFXnum == lastImpactSample) {
    if (iSFXnum == 0x20) {
      uVar1 = random();
      iSFXnum = ((uVar1 & 1) == 0) ? 0x22 : 0x1d;
    }
    else if (iSFXnum != 0x21) {
      if (iSFXnum < 0x21) {
        if (iSFXnum == 0x1d) {
          uVar1 = random();
          iSFXnum = ((uVar1 & 1) == 0) ? 0x20 : 0x22;
        }
      }
      else if (iSFXnum == 0x22) {
        uVar1 = random();
        iSFXnum = ((uVar1 & 1) == 0) ? 0x20 : 0x1d;
      }
    }
  }
  return iSFXnum;
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
/* BUG FIX (2026-07-11): same struct-fields-as-separate-locals bug as AudioCmn_PlayFESFXVol --
   a real `SNDPLAYOPTS playopts;` was already declared but unused; every field write instead
   targeted its own free-standing local (local_30/local_2c/local_29/...), so only local_30's
   address escaped (passed to SNDplaysetdef/SNDplay) and gcc dead-store-eliminated every other
   field write. At runtime this played every dopplered sound with garbage bhandle/pan/vol/bend/
   pitchmult/use3dpos/azimuth (stack garbage) -- a real behavior bug (ours compiled to only
   50 insns vs the oracle's 152: almost the entire field-setup body was eliminated). Fixed by
   writing through the real struct so every field store's address escapes via &playopts. */
int AudioCmn_PlayDoppleredSound(int bhandle,int patchNum,int azimuth,int vol,int bend,int doppler)
{
  /* SYM rule-8: only fn-scope shandle (REG $2=v0) + AUTO playopts + block-local bank (a0)
     are named; the vol-select multiplier/level values are ANONYMOUS temps -- per-arm INLINE
     playopts.vol stores below, gcc cross-jumps the identical [lw SFX; subu; mult; sra 14]
     tails into the oracle's shared .L78278/.L7827C/.L80280 merge blocks (funnel vars in
     source would PREVENT that merge shape). gSndBnk[2].bnkID is read twice and CSE'd by
     gcc into $v1 (live to the patchNum==3 recheck) -- no named cache var. */
  SNDPLAYOPTS playopts;
  int shandle;

  SNDplaysetdef(&playopts);
  playopts.bhandle = (char)bhandle;
  if (patchNum == 0x7d) {
    playopts.vol = (u_char)(gMasterSFXLevel * vol >> 7);
  }
  else if (bhandle == -4) {
    playopts.vol = (u_char)(gMasterFENarrationLevel * 0x81 >> 7);
  }
  else if (bhandle == gSndBnk[2].bnkID) {
    playopts.vol = (u_char)(gMasterAmbientLevel * (vol * 0x28 - vol) >> 0xe);
  }
  else if (bhandle == gSndBnk[5].bnkID) {
    /* MATCH: (vol*0x41)<<1 -- the SHIFT node breaks gcc's multiply-chain linearization,
       which otherwise regroups the 0x82 constant onto the LEVEL operand (oracle shifts s0:
       sll6;addu;sll1) and flips the mult operand order out of the shared .L80078280 tail. */
    playopts.vol = (u_char)(gMasterAmbientLevel * ((vol * 0x41) << 1) >> 0xe);
  }
  else if ((patchNum == 0x16) || (patchNum == 0x12)) {
    playopts.vol = (u_char)(gMasterSFXLevel * vol >> 7);
  }
  else if ((patchNum == 3) &&
           ((bhandle == gSndBnk[0].bnkID) || (bhandle == gSndBnk[2].bnkID))) {
    playopts.vol = (u_char)(gMasterSFXLevel * (vol * 0x80 - vol) >> 0xe);
  }
  else if (patchNum == 0) {
    playopts.vol = (u_char)(gMasterEngineLevel * ((vol * 7) << 1) >> 0xe);   /* MATCH: same shift-node lever (sll3;subu;sll1 on vol) */
  }
  else {
    playopts.vol = (u_char)(gMasterSFXLevel * (vol * 0x28 - vol) >> 0xe);
  }
  /* MATCH: real if/else (not unconditional store + override) -- oracle stores patnum=1 on
     the ==99 arm then jumps to the shared merge, patnum=patchNum only on the fallthrough. */
  if (patchNum == 99) {
    playopts.patnum = 1;
  }
  else {
    playopts.patnum = patchNum;
  }
  playopts.bend = (char)bend;
  playopts.pitchmult = (u_short)(doppler >> 4);
  playopts.use3dpos = Audio_direct3davail != 0;
  /* MATCH: arm order swapped vs the Ghidra-style "==0" first -- oracle's fallthrough (common)
     path is the != 0 azimuth store; the ==0 pan/stereo code is pushed out-of-line. */
  if (Audio_direct3davail != 0) {
    playopts.azimuth = (u_short)azimuth;
  }
  else {
    /* MATCH: arm order swapped again (same lever as the outer Audio_direct3davail check) --
       oracle's fallthrough is the != 0 azimuth-band compute; ==0 pan=0x40 is out-of-line. */
    if (gStereoMode != 0) {
      if (azimuth - 0x4000U < 0x8000) {
        /* MATCH: oracle shifts this one ARITHMETICALLY (sra) -- no u_int cast (plain signed
           int >> 8), unlike the sibling branch below which does want the unsigned srl. */
        playopts.pan = (u_char)((0xbfff - azimuth) >> 8);
      }
      else {
        playopts.pan = (u_char)((u_int)(azimuth + 0x4000) >> 8);
      }
    }
    else {
      playopts.pan = 0x40;
    }
  }
  /* BUG FIX (round-2): playopts.bhandle is a plain `char` field, UNSIGNED on this build
     (CC1PLPSX reads every char field with lbu) -- comparing the raw field against -1/-4/-3
     is provably false/true for an unsigned promotion and gcc silently DELETES the whole
     GetAsyncSfx block (a real behavior bug: async bank lookup never ran). Oracle reloads
     the byte ONCE via a signed `lb` and reuses it for all three tests. */
  if ((signed char)playopts.bhandle < -1) {
    int bank;   /* SYM block line 64: REG $4 = a0 (the call arg) */
    if ((signed char)playopts.bhandle == -4) {
      bank = 2;
    }
    else {
      bank = ((signed char)playopts.bhandle == -3);
    }
    playopts.bhandle = (char)AudioCmn_GetAsyncSfx(bank,patchNum,false);
    playopts.patnum = 0;
  }
  /* BUG FIX (round-2): same unsigned-char issue -- "-1 < playopts.bhandle" on the raw
     field folds to always-true (SNDplay called unconditionally, oracle has a real bltz
     guard skipping playback for a failed/invalid handle). Cast to signed.
     MATCH: else-arm -1 (not up-front init) puts li v0,-1 in the bltz delay slot and keeps
     shandle in its SYM home REG $2 (v0) = the call result, no copies. */
  if (-1 < (signed char)playopts.bhandle) {
    shandle = SNDplay(&playopts);
  }
  else {
    shandle = -1;
  }
  NumSFXOn = NumSFXOn + 1;
  return shandle;
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
  /* SYM rule-8: sndPlayer=s4 iSFXnum=s3 iFreqIn=s5 iDopplerIn=fp, iAmpIn ARG->s1(iAmp),
     azimuth ARG->s7; locals iPartial(v0-web) iFreq(s5, clamped in place) iAmp(s1)
     PatchBank(s2). Bank select = flat goto-dispatch in oracle VA order (delay-fill steals
     each target block's lui into the branch slot); vol select = per-arm INLINE SNDvol
     calls cross-jumped into one jal (0x7d arm CSEs the .L78690 Partial load and enters
     at the mflo). */
  int iPartial;
  int iFreq;
  int iAmp;
  long PatchBank;

  iFreq = iFreqIn;
  iFreq = (iFreq < 0) ? 0 : iFreq;
  iFreq = (0x7f < iFreq) ? 0x7f : iFreq;
  iAmp = iAmpIn;
  if (iAmp < 0) {
    iAmp = 0;   /* MATCH: plain-if here (in-place zero) -- only iFreq's low clamp funnels */
  }
  iAmp = (0x7f < iAmp) ? 0x7f : iAmp;
  if (sndPlayer - 0x1cU < 4) goto BNK5;
  if (sndPlayer - 0x32U < 4) goto BNK5;
  if (sndPlayer == 0x24) goto BNK5;
  if (sndPlayer == 0x36) goto BNK5;
  if (sndPlayer - 0x37U < 0x10) goto BNK5;
  if (sndPlayer - 10U < 8) goto BNK2;
  if (!(sndPlayer - 0x1aU < 2)) goto SFXCHK;
BNK2:
  PatchBank = gSndBnk[2].bnkID;
  goto GOTBANK;
SFXCHK:
  if (iSFXnum == 0x7d) goto BNK5;
  if (!(iSFXnum < 0x7e)) goto LOOKUP;
  if (iSFXnum == 8) goto BNK3;
  if (iSFXnum < 8) goto LOOKUP;
  if (!(iSFXnum < 0xc)) goto LOOKUP;
  if (iSFXnum < 10) goto LOOKUP;
BNK3:
  PatchBank = gSndBnk[3].bnkID;
  goto GOTBANK;
BNK5:
  PatchBank = gSndBnk[5].bnkID;
  goto GOTBANK;
LOOKUP:
  {
    int lbase = (int)gBankNumLookupTable;   /* MATCH: base-first + index-first addu.
       RESIDUAL (banked): ours CSEs ONE lui for the two jump-in paths (v1); the oracle
       re-materializes %hi per path via delay-fill target-stealing (v0) -- +3 remat diffs */
    PatchBank = gSndBnk[*(u_char *)((sndPlayer << 2) + lbase)].bnkID;
  }
GOTBANK:
  if (sndPlayer == 0x31) {
    gaChannel[0x31].Partial =
         AudioCmn_PlayDoppleredSound(PatchBank,iSFXnum,azimuth,iAmp,iFreq,iDopplerIn);
    gaChannel[0x31].SFXnum = iSFXnum;
    NumSFXOn = NumSFXOn - 1;
  }
  else {
    /* MATCH: goto-dispatch in oracle VA order -- [guard section][NEWSOUND][RECHECK
       vol/pan/pitch][SETM1][RET]; the natural nested if/else places NEWSOUND last. */
    int chbase = (int)gaChannel;   /* MATCH: base materialized first, index-first addu */
    Channels_t *slot = (Channels_t *)((sndPlayer << 3) + chbase);
    if (slot->SFXnum != iSFXnum) goto NEWSOUND;
    if (SNDover(slot->Partial) != 0) {
      slot->Partial = -1;
      slot->SFXnum = -1;
    }
    if ((PatchBank < -1) &&
       (AudioCmn_GetAsyncSfx(PatchBank == -3,iSFXnum,false) == -1)) {
      slot->Partial = -1;
      slot->SFXnum = -1;
    }
    if (gaChannel[sndPlayer].SFXnum == iSFXnum) goto RECHECK;
NEWSOUND:
    {
      Channels_t *slot2 = &gaChannel[sndPlayer];
      if (slot2->Partial != -1) {
        SNDstop(slot2->Partial);
        NumSFXOn = NumSFXOn - 1;
      }
      /* MATCH: block-local result r (dies in v0, no a0 copy); != arm falls through */
      int r = AudioCmn_PlayDoppleredSound(PatchBank,iSFXnum,azimuth,iAmp,iFreq,iDopplerIn);
      if (r != -1) {
        slot2->Partial = r;
        slot2->SFXnum = iSFXnum;
      }
      else {
        slot2->Partial = r;
        slot2->SFXnum = r;
      }
    }
    goto LAB_8007887c;
RECHECK:
    iPartial = gaChannel[sndPlayer].Partial;
    if (iPartial == -1) goto SETM1;
    if (iSFXnum == 0x7d) {
      SNDvol(gaChannel[sndPlayer].Partial,gMasterSFXLevel * iAmp >> 7);
    }
    else if (PatchBank == gSndBnk[2].bnkID) {
      SNDvol(gaChannel[sndPlayer].Partial,
             gMasterAmbientLevel * (iAmp * 0x28 - iAmp) >> 0xe);
    }
    else if (PatchBank == gSndBnk[5].bnkID) {
      SNDvol(gaChannel[sndPlayer].Partial,
             gMasterAmbientLevel * ((iAmp * 0x41) << 1) >> 0xe);
    }
    else if (iSFXnum == 99) {
      SNDvol(gaChannel[sndPlayer].Partial,
             gMasterAmbientLevel * (iAmp * 0x28 - iAmp) >> 0xe);
    }
    else if ((iSFXnum == 3) &&
            ((PatchBank == gSndBnk[0].bnkID) || (PatchBank == gSndBnk[2].bnkID))) {
      SNDvol(gaChannel[sndPlayer].Partial,
             gMasterSFXLevel * (iAmp * 0x80 - iAmp) >> 0xe);
    }
    else if (iSFXnum == 0) {
      SNDvol(gaChannel[sndPlayer].Partial,
             gMasterEngineLevel * ((iAmp * 7) << 1) >> 0xe);
    }
    else {
      SNDvol(gaChannel[sndPlayer].Partial,
             gMasterSFXLevel * (iAmp * 0x28 - iAmp) >> 0xe);
    }
    if (Audio_direct3davail != 0) {
      SND3dpos(gaChannel[sndPlayer].Partial,azimuth,0);
    }
    else {
      if (gStereoMode != 0) {
        int pbase = (int)gaChannel;
        Channels_t *pch = (Channels_t *)((sndPlayer << 3) + pbase);
        u_int pan;
        if (azimuth - 0x4000U < 0x8000) {
          pan = 0xbfff - azimuth;
        }
        else {
          pan = azimuth + 0x4000U & 0xffff;
        }
        SNDpan(pch->Partial,(int)pan >> 8);
      }
    }
    {
      int bbase = (int)gaChannel;
      Channels_t *bch = (Channels_t *)((sndPlayer << 3) + bbase);
      SNDpitchbend(bch->Partial,iFreq);
      SNDpitchmult(bch->Partial,iDopplerIn >> 4);
    }
    goto LAB_8007887c;
SETM1:
    gaChannel[sndPlayer].SFXnum = -1;
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
  if (AudioCmn_kAudioOn) {
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
  /* SYM: roadNoiseAmp is REG $s1, live from here through the camera-mode selector
     block below -- split from iVar10 which is reused (2 more disjoint lives) for the
     PlayersRampedGasLevel ramp scratch and cobblestoneAmp later. */
  roadNoiseAmp = 0;
  if (-1 < iVar9 + -0xd8000) {
    roadNoiseAmp = iVar9 + -0xd8000 >> 0xf;
  }
  /* SYM: CurCarGasLevel is REG $s0, live from here through the fixedmult-based
     self-referencing scale below (blowout doubles it in place) -- split from iVar9
     which is reused afterward for unrelated values (switch-case temp, particle count). */
  CurCarGasLevel = iVar9 >> 0xf;
  if (0x7f < CurCarGasLevel) {
    CurCarGasLevel = 0x7f;
  }
  /* SYM: cobbleMod is a distinct REG local ($s3) spanning from this clamp through the
     switch-case modulo below -- split out of the Ghidra iVar4 temp (which is reused later
     for unrelated short-lived values) so its live range doesn't force one register to
     cover the whole function. */
  cobbleMod = CurCarGasLevel;
  if (CurCarGasLevel < 0) {
    cobbleMod = CurCarGasLevel + 0xf;
  }
  cobbleMod = 8 - (cobbleMod >> 4);
  if (cobbleMod < 3) {
    cobbleMod = 3;
  }
  local_38 = 0x40;
  /* @0x800789CC: oracle copies the clamped value into a FRESH reg ($s6) --
     iFreqIn's own reg ($s2) is dead after this and gets reused later
     (PlayerPan). Model as a genuinely separate local, not an in-place clamp. */
  freq = iFreqIn;
  if (0x96 < freq) {
    freq = 0x96;
  }
  if (freq < 0) {
    freq = 0;
  }
  /* SYM: roadSurface is REG $s5, spans from here through the switch dispatch below
     (blowout override + case-7 check) -- split from iVar12 which is reused for 3
     unrelated short-lived values later in the function. */
  roadSurface = (car->N).driveSurfaceType;
  pvVar5 = BWorldSm_TunnelFlagSm(&(car->N).simRoadInfo);
  if (pvVar5 != (void *)0x0) {
    if ((GameSetup_gData.commMode != 1) && ((u_char)fReverbLevel < 100)) {
      uVar7 = 100;
      if ((u_char)fReverbLevel + 10 < 0x65) {
        uVar7 = (u_char)fReverbLevel + 10;
      }
      fReverbLevel = (char)uVar7;
      SNDfxmasterlevel(0x0,uVar7 & 0xff);
      fReverbOn = '\x01';
    }
    roadNoiseAmp = roadNoiseAmp + 0x14;
    local_38 = 0x5e;
  }
  else {
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
    roadSurface = 4;
    CurCarGasLevel = CurCarGasLevel << 1;
  }
  if (dst < 0x460000) {
    /* @0x80078B7C: the final >>16 (with negative-rounding fixup) writes BACK into
       CurCarGasLevel itself ($s0) -- not a separate "iVar6". iVar6 here is only the
       transient fixedmult() result. */
    iVar6 = fixedmult(dst,dst);
    iVar6 = ((0x13240000 - iVar6) / 0x1324) * CurCarGasLevel;
    CurCarGasLevel = iVar6 >> 0x10;
    if (iVar6 < 0) {
      CurCarGasLevel = iVar6 + 0xffff >> 0x10;
    }
  }
  else {
    CurCarGasLevel = 0;
  }
  switch(roadSurface) {
  case 2:
  case 10:
  case 0xb:
  case 0xd:
    iVar9 = roadNoiseAmp;
    if (roadNoiseAmp < 0) {
      iVar9 = roadNoiseAmp + 3;
    }
    roadNoiseAmp = roadNoiseAmp + (iVar9 >> 2);
    local_38 = 0x18;
    break;
  case 4:
  case 7:
  case 0xc:
    /* @0x80078BCC: real static counter is cobbleCount (D_8013C6B0, gp-rel byte),
       NOT Audio_gFESFXTable.audioCounter -- oracle: cobbleCount+=1 (stored), then
       cobbleCount%=iVar4 (stored again); the div-by-zero guard is the automatic
       --expand-div guard on the '%' below, not a manual trap(). */
    cobbleCount = cobbleCount + 1;
    cobbleCount = cobbleCount % cobbleMod;
    if ((cobbleCount == 0) && ((car->N).objAltitude < 0x3333) && (0 < gMasterSFXLevel)) {
      iVar9 = 0;
      if (bVar3) {
        iVar9 = iVar11;
      }
      iVar4 = 0x40;
      if (roadSurface == 7) {
        iVar4 = 0x28;
      }
      AudioCmn_PlaySound(gSndBnk[3].bnkID,0x1d,iVar9,CurCarGasLevel / 2,iVar4);
    }
  }
  if (gMasterEngineLevel == 0) {
    return;
  }
  /* @0x80078CB4: real oracle shape is a flat descending guard-chain (bltz; slti<2; slti<5;
     else), NOT the Ghidra comma-expression -- that convoluted form emits a spurious xor.
     Also note the (2<=sVar2<5) case shifts by the VARIABLE iVar4 (srav), not a literal 1
     (sra) -- iVar4 happens to equal 1 there, but the register form must be reproduced. */
  sVar2 = Camera_gInfo[car->carIndex].mode;
  if (sVar2 < 0) {
    iVar4 = 2;
    iVar9 = roadNoiseAmp >> 1;
  }
  else if (sVar2 < 2) {
    iVar4 = 0;
    iVar9 = roadNoiseAmp;
  }
  else if (sVar2 < 5) {
    iVar4 = 1;
    iVar9 = roadNoiseAmp >> iVar4;
  }
  else {
    iVar4 = 2;
    iVar9 = roadNoiseAmp >> 1;
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
  /* SYM: cobblestoneAmp is REG $s0 (shares the register with CurCarGasLevel, whose
     live range ends earlier) -- the re-read of the just-updated ramped gas level,
     clamped and carried into the gear-shift block below. */
  cobblestoneAmp = PlayersRampedGasLevel[car->carIndex];
  if (0xff < cobblestoneAmp) {
    cobblestoneAmp = 0xff;
  }
  iVar12 = iVar8 * (freq + 0x28);
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
    /* @0x80078E50: the div-by-zero / INT_MIN-by(-1) guard is the automatic
       --expand-div guard on the '/' below (matches the oracle's single
       div;break7;break6 sequence) -- no manual trap() in source. */
    iVar8 = iVar12 << 0x10;
    iVar12 = iVar8 / doppler;
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
  iVar8 = cobblestoneAmp;
  if (((((car->control).gearShiftTimer != '\0') &&
       (bVar1 = (car->control).lastGear, bVar1 < (u_char)(car->control).gear)) && (bVar1 != 1)) &&
     (cobblestoneAmp != 0)) {
    uVar7 = (u_int)(u_char)(car->control).gearShiftTimer;
    iVar8 = car->specs->gearShiftDelay;
    /* @0x8007902C-ish gearShiftDelay division: automatic --expand-div guard on '/'. */
    iVar12 = iVar12 + (int)(iVar12 * uVar7) / iVar8 >> 1;
    iVar8 = cobblestoneAmp >> 2;
    if (uVar7 == 5) {
      iVar8 = cobblestoneAmp - iVar8;
    }
    else if (uVar7 == 4) {
      iVar8 = cobblestoneAmp >> 1;
    }
    else if ((uVar7 != 3) && (iVar8 = cobblestoneAmp, uVar7 < 3)) {
      iVar8 = 0;
    }
    PlayersRampedGasLevel[car->carIndex] = iVar8;
  }
  iVar10 = car->specs->redline;
  iVar9 = car->flywheelRpm << 0x10;
  /* @0x80079044 redline division (mflo a2): automatic --expand-div guard, no manual trap(). */
  iVar11 = 0x7f;
  if (car->revLimit == 0) {
    iVar11 = iVar8 >> 1;
  }
  AudioEng_Set(car->carIndex,gMasterEngineLevel * iVar12 * 0xe >> 0xe,iVar9 / iVar10,iVar11,iVar4,
             doppler,azimuth,cardir);
  }
  return;
}

/* ---- AudioCmn_TrafficSFX__Fiiiiiiii  [@0x80079104] ---- */
void AudioCmn_TrafficSFX(int iChan,int iSFXnum,int freq,int doppler,int dst,int azimuth,int relvel,int dir)
{
  /* SYM rule-8: locals = iAmpIn(s4), player(a0), pitchmult(s0) ONLY; dst/azimuth/relvel/dir
     get REG copies (a2/s7/s6/s1), freq+doppler stay ARG (stack) and are reloaded per use.
     dir is consumed IN PLACE (s2=dir>>12 kept, s1 becomes dir>>10, s2-=0x40 for the 2nd
     index); relvel clamped in place; iAmpIn reused for the final scaled amp.
     RESIDUAL (banked, 53 @ count 164/163): a pure saved-reg PERMUTATION -- ours
     {dir=s0, -1/pitchmult=s1, Xfade=s2, dir>>12=s3} vs oracle {pitchmult=s0, dir=s1,
     -1/dir>>12=s2, Xfade=s3} -- plus the 1st-index fold (ours A-(B-64), oracle (A+64)-B).
     Tried: decl order, pitchmult 2-statement split (56), 0x40-leading index (56) --
     permuter multi-basin candidate. */
  int pitchmult;
  int iAmpIn;
  int player;

  player = 0;
  if (GameSetup_gData.commMode == 1) {
    player = (iChan < 8) ^ 1;
  }
  if (Camera_gInfo[player].mode == 0xc) {
    iAmpIn = fixeddiv(0x10000000,dst + 0x10000) / 0x10000;
  }
  else {
    iAmpIn = fixeddiv(0x8000000,dst + 0x20000) / 0x10000;
  }
  if ((iAmpIn == 0) && (iChan != -1)) {
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
    pitchmult = (fixedmult(freq + 0x3333,doppler) * 0x50 >> 10) << 4;
    /* BUG FIX (2026-07-11): real crossfade table Xfade[129], not a stale "" placeholder.
       BUG FIX (wave-13): 2nd index IS +0x40 biased -- oracle mutates s2=(dir>>12)-0x40 then
       s1-s2 = (dir>>10)-(dir>>12)+0x40 (the wave-6 note claiming "no +0x40" misread the raw;
       the two calls use the symmetric +-0x40 crossfade pair). */
    AudioCmn_PlaySFX(iChan + 4,CopSpeak_GetEnginePatch(iSFXnum,0),0x40,pitchmult,
               iAmpIn * Xfade[((dir >> 0xc) + 0x40) - (dir >> 10)] >> 7,azimuth);
    AudioCmn_PlaySFX(iChan + 8,CopSpeak_GetEnginePatch(iSFXnum,1),0x40,pitchmult,
               iAmpIn * Xfade[(dir >> 10) - ((dir >> 0xc) - 0x40)] >> 7,azimuth);
    if (0x280000 < relvel) {
      relvel = 0x280000;
    }
    iAmpIn = iAmpIn * relvel / 0x280000;
    AudioCmn_PlaySFX(iChan,99,freq,doppler,iAmpIn,azimuth);
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

  /* BUG FIX (2026-07-11): the previous recon declared each SNDPLAYOPTS field as its OWN
     separate stack local (local_28/local_24/local_21/local_20/local_1f/local_1d) instead of
     members of ONE struct whose address is taken. Only local_28's address escaped (passed to
     SNDplaysetdef/SNDplay); gcc proved the other locals' addresses never escape and dead-store-
     eliminated every field write except patnum -- so at runtime PlayFESFXVol played every FE
     SFX with garbage bhandle/pan/vol/bend/use3dpos (stack garbage), a real behavior bug, not
     just a byte-match near-miss (oracle sets 6 fields; ours set 1). Fixed by using the real
     struct so all field writes go through the escaped &playopts address. */
  SNDplaysetdef(&playopts);
  playopts.patnum = SFXnum;
  playopts.use3dpos = 0;
  playopts.bend = 0x40;
  playopts.pan = 0x40;
  playopts.bhandle = (char)gSndBnk[0].bnkID;
  {
    int volScaled = vol * 0x78;
    playopts.vol = (char)((gMasterSFXLevel * volScaled) >> 0xe);
  }
  SNDplay(&playopts);
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
  /* SYM rule-8: params sirennum=s1 amp=s2 dop=s5 azimuth=s4, supercop ARG->REG s0;
     ONE block-local iFreq (a2). No other named locals: bend is a ternary straight into
     the call arg (li a1,0x7F in the slti delay slot), the channel-slot ADDRESS for the
     pitchbend/vol pair is a scoped anonymous pointer (s0, reusing dead supercop; Partial
     RELOADED per call since the jals clobber memory), and the vol arms are per-arm INLINE
     SNDvol calls cross-jumped into one jal. */
  if (bSirenOn[sirennum] != 0) {
    int iFreq;
    if (SNDover(gaChannel[sirennum + 0x2b].Partial) != 0) {
      if (supercop != 0) {
        SuperCopSirenOn(sirennum);
      }
      else {
        quickSirenOn(sirennum);
      }
    }
    quickSirenTimeCount[sirennum] = quickSirenTimeCount[sirennum] + 1;
    iFreq = dop / 0x400;
    iFreq = (iFreq < 0) ? 0 : iFreq;
    {
      int chidx = sirennum + 0x2b;   /* opaque index temp: stops gcc distributing the
                                        +0x2b into %lo(gaChannel+344); oracle keeps (s1+43)<<3 */
      Channels_t *ch;
      /* MATCH: address assignment EMBEDDED in the call -- places the [addiu s1,43;sll;
         lui/addiu;addu s0] materialization after the bend select like the oracle
         (a preceding ch=... statement schedules it before the slti). */
      SNDpitchbend((ch = &gaChannel[chidx])->Partial,(0x7f < iFreq) ? 0x7f : iFreq);
      /* MATCH: 0x25/0x2f written as (amp*9)*4+amp / (amp*3)*0x10-amp -- the inner +/-
         node blocks gcc's multiply-chain regrouping of the constant onto the LEVEL
         (same lever as PlayDoppleredSound's (vol*0x41)<<1); emits the oracle's exact
         synth-mult shapes on amp with per-arm inline calls cross-jumped into one jal. */
      if (sirenCount[sirennum] == -1) {
        SNDvol(ch->Partial,gMasterAmbientLevel * ((amp * 9) * 4 + amp) >> 0xe);
      }
      else {
        SNDvol(ch->Partial,gMasterAmbientLevel * ((amp * 3) * 0x10 - amp) >> 0xe);
      }
    }
    /* MATCH: arm order -- 3dpos is the fall-through (if-body), stereo pan out-of-line. */
    if (Audio_direct3davail != 0) {
      SND3dpos(gaChannel[sirennum + 0x2b].Partial,azimuth,0);
    }
    else {
      if (gStereoMode != 0) {
        /* MATCH: slot address hoisted into a local (a0) BEFORE the pan select; Partial
           loaded at the call (lw a0,0(a0)); pan funnels through v0 into sra a1. */
        int c2i = sirennum + 0x2b;   /* opaque index temp (stops the +344 reloc fold) */
        /* MATCH: best-found form (15 diffs total fn): base+index via the int-cast
           commutative shape; residual = base la split-vs-self + emission order
           (scheduling floor, banked). */
        Channels_t *c2 = gaChannel;
        c2 = (Channels_t *)((c2i << 3) + (int)c2);
        u_int pan;
        if (azimuth - 0x4000U < 0x8000) {
          pan = 0xbfff - azimuth;
        }
        else {
          pan = azimuth + 0x4000U & 0xffff;
        }
        SNDpan(c2->Partial,(int)pan >> 8);
      }
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

            if (AudioCmn_GetAsyncSfx(2, i + 0x2f, false) == -1)

              ready = false;

          }

        }

        if (GameSetup_gData.Weather == 1 &&

            AudioCmn_GetAsyncSfx(1, 0, false) == -1)

          ready = false;

        for (i = 0; i < GameSetup_gData.numCars; i++) {

          if (GameSetup_gData.carInfo[i].carClass == 2) {

            patch = CopSpeak_GetEnginePatch(GameSetup_gData.carInfo[i].carType, 0);

            if (-1 < patch && AudioCmn_GetAsyncSfx(1, patch, false) == -1)

              ready = false;

            patch = CopSpeak_GetEnginePatch(GameSetup_gData.carInfo[i].carType, 1);

            if (-1 < patch && AudioCmn_GetAsyncSfx(1, patch, false) == -1)

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
  SNDmastervol(0x7f);
  /* MATCH: oracle inlines the AudioCmn_MusicLevel formula here with NO jal (no
     AudioCmn_MusicLevel call in the disasm at all) -- reproduced via a local
     static-inline twin of AudioCmn_MusicLevel so cc1plus folds it in-line while the
     real out-of-line AudioCmn_MusicLevel__Fi (used by AudioCmn_Reset) stays untouched. */
  AudioMus_Volume(AudioCmn_MusicLevel_inl(gMasterMusicLevel));
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
