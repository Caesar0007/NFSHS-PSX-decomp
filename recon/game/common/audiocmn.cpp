/* game/common/audiocmn.cpp -- RECONSTRUCTED from Ghidra 12.0.4 decompile + PsyQ SYM v3.
 *   bworld.obj (GAME\COMMON\bworld.cpp) = 20 fns: BWorld road geometry build/render
 *   (chunk visibility, build lists, spike belt, glare effects, render contexts). Self-contained.
 *   Verified vs disasm-v2.txt. NOT original source; SYM-faithful, recompilable C++.
 */
#include "audiocmn_types.h"
#include "audiocmn_externs.h"

/* Canonical EA spelling recovered from the symbol-bearing NFS2 audiocmn.c. */
#define MIN(a,b) (((a) > (b)) ? (b) : (a))

/* w64-a19 LINK FIX: called at :576/:722/:2429/:2472/:2500 but only DEFINED at :2518,
 * with no prior prototype -> implicit declaration -> the five calls were emitted
 * UNMANGLED (`AudioCmn_ReverbOff`) and could never resolve to `AudioCmn_ReverbOff__Fv`
 * defined in this same object.  Prototype hoisted, signature unchanged. */
void AudioCmn_ReverbOff(void);

/* ---- audiocmn.obj-owned globals (SYM-typed; .data=real EXE bytes, .bss=zero) ---- */
/* forward decls of the W67-A4 .sdata literal-pool arrays (defined after the
   =0 batch below so they EMIT at their retail positions 0x8013c67c..0x8013c6a8;
   the generated local-initializer template and tables reference them). */
extern char D_8013C67C[], D_8013C684[], D_8013C68C[], D_8013C690[], D_8013C694[],
            D_8013C698[], D_8013C69C[], D_8013C6A0[], D_8013C6A4[], D_8013C6A8[];
extern char *AudioCmn_LanguageName[7];
extern int bSirenOn[6], bSirenPitchingUp[6], quickSirenActive[6];
extern int sirenPitchWidth[6], sirenCurrentPitch[6], slowSirenReps[6];
extern int sirenCount[6], reachedSirenMin[6], quickSirenTimeCount[6];
extern AudioCmn_tReTrig AudioCmn_gReTrig[2];
extern SndBnk_t gSndBnk[7];
extern Channels_t gaChannel[71];
extern AudioCmn_tAsyncSfxSlot AudioCmn_gSfxSlot[32];
extern char carbankname[12];
extern int falseLapTrigCur, flaseLapTrigTrack;
extern char currentLap[2];
extern int bestLapTime[2], gtotallaptimes[2], AudioCmn_gPlayerArrested[2];
extern int AudioCmn_gCursorSndHandle, AudioCmn_gLastFade;
extern void *AudioCmn_gLoadTables, *AudioCmn_gCruiseTables;
extern int AudioCmn_gResume, AudioCmn_gStreamRestartTimer;
extern char fMysticWindON[2], fAmbientRangeON[2];
extern int currentWindVal[2], nextWindVal[2];
extern int currentWindPan, nextWindPan, gQuickSirenCount;
extern int AudioCmn_ThunderAmp, AudioCmn_ThunderAzi, AudioCmn_ThunderDel;
int          gBankNumLookupTable[71] = { 0, 2, 0, 2, 0, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 5, 5, 5, 5, 3, 3, 3, 3, 5, 2, 2, 2, 2, 0, 1, 2, 2, 2, 2, 0, 0, 3, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0 };   /* @0x8010e4d0 */
int          falseLapTrigNumsForward[10][2] = { 4, 7, 4, 7, 4, 7, -1, -1, 4, 7, 4, 9, 4, 9, -1, -1, -1, -1, 4, 9 };   /* @0x8010e5ec */
int          falseLapTrigNumsBackward[10][2] = { 4, 5, 4, 5, -1, -1, -1, -1, 4, 5, 4, 5, 4, 5, -1, -1, -1, -1, 4, 5 };   /* @0x8010e63c */
char         Xfade[129] = { 0, 3, 7, 10, 13, 16, 19, 22, 24, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 46, 48, 50, 51, 53, 54, 55, 57, 58, 60, 61, 62, 63, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 84, 85, 86, 87, 88, 88, 89, 90, 91, 91, 92, 93, 94, 94, 95, 96, 96, 97, 98, 98, 99, 100, 100, 101, 101, 102, 103, 103, 104, 104, 105, 106, 106, 107, 107, 108, 108, 109, 109, 110, 110, 111, 111, 112, 112, 113, 113, 114, 114, 115, 115, 116, 116, 117, 117, 118, 118, 119, 119, 119, 120, 120, 121, 121, 122, 122, 122, 123, 123, 124, 124, 125, 125, 125, 126, 127, 127 };   /* @0x8010e68c */
static char  SkidInitMaxFreq[71] = { 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };   /* @0x8010e710 */
char         trackMusicState = 4;   /* @0x8013c628 */
int          audioBackwardsDirection = 0;   /* @0x8013c62c  (bss(zero)) */
int          intensityFalseLapCounter = 0;   /* @0x8013c630  (bss(zero)) */
int          falseLapCounter = 0;   /* @0x8013c634  (bss(zero)) */
int          gMusicStyle = 0;   /* @0x8013c638  (bss(zero)) */
char         countdown = 0;   /* @0x8013c63c  (bss(zero)) */
char         FadingMusic = 0;   /* @0x8013c63d  (bss(zero)) */
char         StartedNewMusic = 0;   /* @0x8013c63e  (bss(zero)) */
int          recordLapTime = 0;   /* @0x8013c640  (bss(zero)) */
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
int          NumSFXOn = 0;   /* @0x8013c670  (bss(zero)) */
int          gStereoMode = 1;   /* @0x8013c674 */
char         fReverbOn = 0;   /* @0x8013c678  (bss(zero)) */
char         fReverbLevel = 0;   /* @0x8013c679 */
/* W67-A4: retail's -G8 string-literal pool 0x8013c67c..0x8013c6ac + the two
   initialised fn-statics @0x8013c6ac/0x8013c6b0 (SYM: lastImpactSample INT,
   cobbleCount CHAR), reproduced in DEFINITION ORDER.  Whole-TU -G8 breaks
   CheckState (W59-11G), so the literals are NAMED .sdata arrays (w66a6/sim.cpp
   device; storage-only, address form stays absolute).  The generated local
   initializer, data table, and three code sites reference these arrays -- reloc-name-lenient, and the
   pooling ("eng" x6 -> one copy) is exactly retail's.  DO NOT RE-SORT. */
/* SYM-GLOBAL-CARRIER: D_8013C67C
   SYM-GLOBAL-CARRIER: D_8013C684
   SYM-GLOBAL-CARRIER: D_8013C68C
   SYM-GLOBAL-CARRIER: D_8013C690
   SYM-GLOBAL-CARRIER: D_8013C694
   SYM-GLOBAL-CARRIER: D_8013C698
   SYM-GLOBAL-CARRIER: D_8013C69C
   SYM-GLOBAL-CARRIER: D_8013C6A0
   SYM-GLOBAL-CARRIER: D_8013C6A4
   SYM-GLOBAL-CARRIER: D_8013C6A8
   Retail fixes the literal bytes, pooling, addresses, and owner, but SYM does
   not retain compiler-generated identifiers for string literals. */
char D_8013C67C[] __attribute__((section(".sdata"), aligned(4))) = "SFXHDR";
char D_8013C684[] __attribute__((section(".sdata"), aligned(4))) = "fesfx";
char D_8013C68C[] __attribute__((section(".sdata"), aligned(4))) = "eng";
char D_8013C690[] __attribute__((section(".sdata"), aligned(4))) = "ger";
char D_8013C694[] __attribute__((section(".sdata"), aligned(4))) = "frn";
char D_8013C698[] __attribute__((section(".sdata"), aligned(4))) = "spn";
char D_8013C69C[] __attribute__((section(".sdata"), aligned(4))) = "itl";
char D_8013C6A0[] __attribute__((section(".sdata"), aligned(4))) = "Gen";
char D_8013C6A4[] __attribute__((section(".sdata"), aligned(4))) = "brt";
char D_8013C6A8[] __attribute__((section(".sdata"), aligned(4))) = "fre";
static int   PlayersRampedGasLevel[2] __attribute__((section(".bss")));   /* SYM STAT @0x8013dd80 */


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

/* W60-A9: file-scope helper decls hoisted here from the old audiocmn.obj-tail block
 * so they precede EVERY consumer after the retail-VA reorder of the fn definitions. */

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
void systemtask(int taskFlag) asm("systemtask");
extern "C" int  SNDstopall(void);             /* @0x800E81A8 */
extern "C" void SPCH_ClearEventQueue(void);   /* @0x800E74E0 */
/* additional helpers for AudioCmn_Reset (gettick/SNDSTRM_setpriority/SNDmemlargestunused
 * come from lib/libfns.h already included via audiocmn_externs.h) */
void CopSpeak_Server(void);
int  AudioTrk_PreLoad(void);
int  AudioMus_Buffered(void);
int  AudioMus_Threshold(void);
extern int gMusicHandle;


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
  if ((0 < AudioCmn_ThunderAmp) &&
     (AudioCmn_ThunderDel = AudioCmn_ThunderDel + -1, AudioCmn_ThunderDel < 0)) {
    AudioCmn_PlaySound(gSndBnk[3].bnkID,0x16,AudioCmn_ThunderAzi,AudioCmn_ThunderAmp,0x40);
    if (0x2e <= AudioCmn_ThunderAmp) {
      AudioCmn_ThunderAmp += 3 - (random() & 0xf);
    }
    else {
      AudioCmn_ThunderAmp += 2 - (random() & 7);
    }
    AudioCmn_ThunderDel = (random() + 0x14U) & 3;
  }
  return;
}

/* ---- AudioCmn_InitAsyncSfx__Fv  [@0x8007657c] ---- */
void AudioCmn_InitAsyncSfx(void)
{
  int i;

  i = 0;
  while (1) {
    if (0x20 <= i) break;
    AudioCmn_gSfxSlot[i].patch = -1;
    AudioCmn_gSfxSlot[i].handle = -1;
    AudioCmn_gSfxSlot[i].header = (char *)0x0;
    i = i + 1;
  }
  return;
}

/* ---- AudioCmn_RemoveAsyncSfx__Fi  [@0x800765b4] ---- */
void AudioCmn_RemoveAsyncSfx(int slot)
{
  AudioCmn_tAsyncSfxSlot *s;

  s = &AudioCmn_gSfxSlot[slot];
  if (s->patch != -1) {
    if (s->handle != 0xffffffff) {
      SNDbankremove(s->handle);
      s->handle = -1;
      if (s->header != (char *)0x0) {
        purgememadr(s->header);
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
  
  i = 0;
  do {
    AudioCmn_RemoveAsyncSfx(i);
    i = i + 1;
  } while (i < 0x20);
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

  slot = 0;
  do {
    /* SYM-CODEGEN-CARRIER: s -- the loop-local slot base is absent from the
     * retail debug local list but is required in $s4.  Direct array indexing
     * expands 105 instructions to 108 and produces 83 authoritative diffs,
     * changing the saved-register allocation and parameter-save order. */
    AudioCmn_tAsyncSfxSlot *s = &AudioCmn_gSfxSlot[slot];
    if ((patch == s->patch) && (bank == s->bank) && (s->handle == -1)) {
      if (size != 0) {
        while (SNDmemlargestunused(&check) - 0x1000 < size) {
          if (AudioCmn_RemoveOldestAsyncSfx(bank) == -1) {
            if (bank == 2) {
              puts("out of SPU ram on speech!\n");
              s->handle = -1;
              goto FAIL_PATCH;
            }
            goto FAIL_HANDLE;
          }
        }
        check = SNDbankadd(&s->handle,(int)pbank);
        if (check == 7) {
          s->header = (char *)reservememadr(D_8013C67C,SNDbankheadersize(s->handle),0x10);
          if (s->header != 0) {
            SNDbankheadercopy(s->header,(u_char *)s->handle);
            s->patch = patch;
            s->ticks = simGlobal.gameTicks;
            return;
          }
        }
        if (bank == 2) {
          puts("SNDbankadd failed on speech!\n");
        }
        SNDbankheadersize(s->handle);
        if (check >= 0) {
          SNDbankremove(s->handle);
        }
      }
      /* MATCH: the stripped wrapper adds two loop-weighted refs to the shared -1
         sentinel, placing it in s1 and bank in s2 without emitting instructions. */
      do {
FAIL_HANDLE:
        s->handle = -1;
FAIL_PATCH:
        s->patch = -1;
      } while (0);
      return;
    }
    slot++;
  } while (slot < 32);
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
  /* SYM-CODEGEN-CARRIER: backwards -- staging reverseTrack separately preserves
     retail's v1 load/store scheduling without the extra load-delay nop. */
  int backwards;

  /* @0x80076A7C: if(AudioCmn_kAudioOn==0) goto lbl_80076AF0 (the per-player loop, which always runs).
   * The channel-array init + false-lap-trigger select + backwards-direction are audio-on-guarded (H42). */
  if (AudioCmn_kAudioOn != 0) {
    AudioCmn_InitChannelArray();
    /* SYM-CODEGEN-CARRIER: setup -- the shared GameSetup base and its read-only
       identity fence preserve retail's reverseTrack load/store schedule. */
    GameSetup_tData *setup = &GameSetup_gData;
    /* MATCH (SYM rule-8): temptrack = REG $4 (a0), mutated IN PLACE by the &0x10 arm
       (addiu a0,v0,5); track is loaded ONCE. audioBackwardsDirection is stored then
       RE-READ for the table select (the join point starts a new EBB, so no CSE) --
       the reverse-track temp (v1) dies at the store. */
    temptrack = setup->track;
    backwards = setup->reverseTrack;
    /* MATCH: stage reverseTrack across the zero-insn identity fence.  This keeps
       the shared setup base live through both loads (so reverseTrack uses v1),
       while leaving its store and the temptrack mask in the same schedulable EBB.
       Result: retail's lw a0 / lw v1 / andi v0 / sw v1 head order (22 -> 18). */
    __asm__("" : "=r"(setup) : "0"(setup));
    audioBackwardsDirection = backwards;
    if ((temptrack & 0x10) != 0) {
      temptrack = (temptrack & 0xf) + 5;
    }
    /* 05E VOLATILE-ON-THE-TEST-READ: retail RE-READS audioBackwardsDirection here
       (`lw v0,0(gp); nop; bnez`) -- gcc otherwise keeps the just-stored value live in
       the reverseTrack temp and emits no load at all.  Volatile only on the TEST read
       (the store above stays ordinary).  48->45. */
    /* MATCH: SYM has no table-pointer local.  Spelling the two source arms
       directly lets gcc cross-jump their common load/store tail (29 -> 21). */
    if (*(volatile int *)&audioBackwardsDirection == 0) {
      falseLapTrigCur = falseLapTrigNumsForward[temptrack][0];
      flaseLapTrigTrack = falseLapTrigNumsForward[temptrack][1];
    }
    else {
      falseLapTrigCur = falseLapTrigNumsBackward[temptrack][0];
      flaseLapTrigTrack = falseLapTrigNumsBackward[temptrack][1];
    }
    /* MATCH: one zero-insn ref fence buys temptrack's SYM $a0 allocation;
       without it the guarded head rotates through $v1 and costs 45 diffs. */
    falseLapCounter = 0;
    intensityFalseLapCounter = 0;
  }
  {
    /* MATCH: the two explicit byte bases plus direct currentLap indexing establish
       retail's t4/t3/t2 preheader order; integer-address additions preserve the
       `addu v0,v1,tN` operand order.  The literal 512 store remains exact without
       an unsupported named local.  Retail data layout identifies -G8 as this TU's
       compiler lane: Init is source-PASS 94/94 under a strict TU-wide -G8 build. */
    j = 0;
    /* SYM-CODEGEN-CARRIER: ambient -- explicit array bases preserve retail's
       t4/t3/t2 preheader allocation and indexed-store order. */
    char *ambient = fAmbientRangeON;
    /* SYM-CODEGEN-CARRIER: mystic -- retaining this base keeps retail's address
       addition before the adjacent byte store in the loop schedule. */
    char *mystic = fMysticWindON;
    do {
      AudioCmn_gReTrig[j].count = 0;
      *(char *)((int)j + (int)ambient) = '\0';
      *(char *)((int)j + (int)mystic) = '\0';
      currentLap[j] = '\0';
      bestLapTime[j] = 0;
      PlayersRampedGasLevel[j] = 0;
      gtotallaptimes[j] = 0x200;
      AudioCmn_gPlayerArrested[j] = 0;
      j++;
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

/* ---- AudioCmn_Reset__Fv  [@0x80076bec] ---- (Ghidra/IDA + SLD cross-checked:

 *  SNDstop arg restored; carInfo[] loop de-garbled; music-buffer wait is the direct
 *  SLD-scoped compound while. MATCH: 66 -> PASS, ours/oracle 214.) */

void AudioCmn_Reset(void)

{

  int i;



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

  /* W57-A10 SYM-FIRST REWRITE (126 -> 66).  Three findings from the 8c block:
     (1) `ticks` = REG $s6 holds gettick()+0x280 = the DEADLINE computed ONCE
         (`addiu s6,v0,640` in the preheader), not t0 re-added per iteration;
     (2) the wait loop is UN-ROTATED -- retail keeps both head tests at the loop top
         with a `j` back-edge (`bnez s1` on goodtogo BEFORE the gettick call); the
         `while (!ready && ...)` form lets gcc prove entry and rotate (row 52);
     (3) SYM BLOCK SCOPES: `i` is re-declared per block -- fn-scope $s1 (channel loop),
         block line 52 $s0 (the 4-phrase loop), block line 60 $s2 (the numCars loop).
         One shared fn-scope `i` pins all three to the same register.  `goodtogo` is
         $s1 (our `ready`), which only frees up once the inner i's move out. */
  if (0 < gMasterAmbientLevel) {
    int ticks;
    int goodtogo;

    goodtogo = false;
    ticks = gettick() + 0x280;
    while (1) {
      int check;

      if (goodtogo) break;
      if (gettick() >= ticks) break;
      goodtogo = true;
      CopSpeak_Server();
      systemtask(0);
      if (0x8000 < SNDmemlargestunused(&check)) {
        if (GameSetup_gData.raceType == RaceType_HotPursuit) {
          int i;
          for (i = 0; i < 4; i++) {
            if (AudioCmn_GetAsyncSfx(2, i + 0x2f, false) == -1)
              goodtogo = false;
          }
        }
        if (GameSetup_gData.Weather == 1 &&
            AudioCmn_GetAsyncSfx(1, 0, false) == -1)
          goodtogo = false;
        {
          int i;
          i = 0;
          while (1) {
            if (i >= GameSetup_gData.numCars) break;
            if (GameSetup_gData.carInfo[i].carClass == 2) {
              int patch;

              patch = CopSpeak_GetEnginePatch(GameSetup_gData.carInfo[i].carType, 0);
              if (-1 < patch && AudioCmn_GetAsyncSfx(1, patch, false) == -1)
                goodtogo = false;
              patch = CopSpeak_GetEnginePatch(GameSetup_gData.carInfo[i].carType, 1);
              if (-1 < patch && AudioCmn_GetAsyncSfx(1, patch, false) == -1)
                goodtogo = false;
            }
            i++;
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

  {
    int ticks;

    /* MATCH: SLD line-126 `ticks` is the +0x100 deadline ($s3); gcc derives the
       +0x40 deadline in $s2. Keeping the compound test directly in the while prevents
       the first wait block's goodtogo web from leaking into this block (27 -> PASS). */
    ticks = gettick() + 0x100;
    gettick();
    AudioMus_Buffered();
    AudioMus_Threshold();
    while ((((gettick() < ticks + -0xc0) || (AudioMus_Threshold() < 1)) ||
            (AudioMus_Buffered() < AudioMus_Threshold())) && (gettick() < ticks)) {
      systemtask(0);
    }
    if (AudioMus_Buffered() < AudioMus_Threshold() + -100) {
      GameSetup_gData.userSetting.musicLevel = 0;
      gMasterMusicLevel = 0;
      AudioMus_Volume(AudioCmn_MusicLevel(0));
    }
    else {
      gettick();
    }
    gettick();
    AudioMus_Buffered();
    AudioMus_Threshold();
  }

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

  /* BUG FIX (w59-a10 BRANCH-TARGET AUDIT): the two resets used to sit OUTSIDE
     the `Partial != -1` guard.  That gated PASS 54/54 but the guard's branch
     word was 10920003 (ours) vs 10920005 (retail) -- ours re-entered at the
     `sw` pair (insn 28) instead of the loop tail (insn 30), so an ALREADY-idle
     channel still had its SFXnum forced to -1.  Retail keeps both stores inside
     the guard. */
  for (i = 0; i < 71; i++) {

    if (gaChannel[i].Partial != -1) {

      SNDstop(gaChannel[i].Partial);

      gaChannel[i].Partial = -1;

      gaChannel[i].SFXnum  = -1;

    }

  }

  SNDstopall();

  SNDbankremove(-1);

  Audio_CleanUp();

  if (fReverbOn)

    AudioCmn_ReverbOff();

  AudioCmn_kAudioStreamingOn = gFEmusicON;

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
  static char compareTimes[25] = {
    30, 12, 6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9,
    -10, -11, -12, -15, -20, -25, -30
  };
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

/* ---- AudioCmn_CheckState__FP8Car_tObj  [@0x800770bc] ----
 * MATCH: the strict source-only TU-wide -G8 lane makes the small arrays use the
 * retail gp-relative address forms.  Restoring the direct bestLapTime and
 * gtotallaptimes expressions then gives PASS 415/415.  The former -G4 residual
 * and its diagnostic TEXT_MOVES recipe are obsolete under the no-postcompile
 * policy. */
void AudioCmn_CheckState(Car_tObj *car)
{
  /* The optimized SYM stream retains only the source-visible car number and
     speed locals here; the -G8 small-data forms supply the retail schedule. */
  char carnum;
  int carspeed;

  carnum = (char)car->carIndex;
  if ((GameSetup_gData.raceType == RaceType_HotPursuit) || (GameSetup_gData.raceType == RaceType_Id5)) {
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
     ((car->stats).sliceTotal + fixedmult(carspeed,0x50000) / 0x60000 >
      ((car->stats).lap + 1) * gNumSlices)) {
    if ((recordLapTime == 0) ||
       (simGlobal.gameTicks -
        *(int *)(((u_char)carnum << 2) + (int)gtotallaptimes) < recordLapTime)) {
      AudioCmn_GetAsyncSfx(2,1,false);
    }
    if ((car->stats).lap != 0) {
      if (simGlobal.gameTicks - gtotallaptimes[(u_char)carnum] <
          bestLapTime[(u_char)carnum]) {
        AudioCmn_GetAsyncSfx(2,0,false);
      }
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
    if ((car->stats).lap < GameSetup_gData.numLaps + -1) {
      if ((car->stats).lap < GameSetup_gData.numLaps + -2) {
        AudioCmn_GetAsyncSfx(2,(car->stats).lap + 5,false);
      }
      else {
        AudioCmn_GetAsyncSfx(2,2,false);
      }
    }
  }
  if (car->lap == (u_int)(u_char)currentLap[(u_char)carnum]) {
    return;
  }
  if (*(int *)(((u_char)carnum << 2) +
               (int)AudioCmn_gPlayerArrested) != 0) {
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
       (carspeed = (car->stats).time[(car->stats).lap + -1],
        carspeed < recordLapTime)) {
      r.phrase = 1;
      recordLapTime = bestLapTime[car->carIndex] =
          (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r);
    }
    else {
      if (bestLapTime[car->carIndex] <= carspeed) goto LAB_800774e0;
      r.phrase = 0;
      bestLapTime[car->carIndex] = (car->stats).time[(car->stats).lap + -1];
      CopSpeak_Request(&r);
    }
LAB_800774e0:
    {
      int opponents;

      opponents = Stats_GetNumOpponents();
      if (1 < opponents) {
      int position;
      position = Stats_GetPosition(car);
      if (car->lap < GameSetup_gData.numLaps) {
        int phrase;
        if ((opponents >= 3) || ((car->stats).checkpointDisplay == 0)) {
          if (position == opponents) {
            r.phrase = 0x57;
          }
          else {
            r.phrase = position + 0x4e;
          }
        }
        else {
          phrase = AudioCmn_GetTimePhrase(-(car->stats).checkpointDifference);
          if (((GameSetup_gData.commMode == 1) && (!saidplayer)) &&
             ((phrase - 0x3bU < 3 || (phrase - 0x3fU < 0xf)))) {
            r.phrase = (u_char)carnum + 0x33;
            CopSpeak_Request(&r);
            saidplayer = true;
          }
          r.phrase = phrase;
        }
        if ((GameSetup_gData.commMode == 1) && (!saidplayer)) {
          r.phrase = r.phrase + ((u_char)carnum + 1) * 0x23;
        }
      }
      else if ((GameSetup_gData.commMode == 1) && (!saidplayer)) {
        if ((position == opponents) && (2 < position)) {
          if ((u_char)carnum == 0) {
            r.phrase = 0x1a;
          }
          else {
            r.phrase = 0x22;
          }
        }
        else {
          if ((u_char)carnum == 0) {
            r.phrase = position + 0x12;
          }
          else {
            r.phrase = position + 0x1a;
          }
        }
      }
      else {
        if ((position == opponents) && (2 < position)) {
          r.phrase = 0x12;
        }
        else {
          r.phrase = position + 10;
        }
      }
      CopSpeak_Request(&r);
      }
    }
    if ((car->stats).lap < GameSetup_gData.numLaps) {
      if ((car->stats).lap < GameSetup_gData.numLaps + -1) {
        r.phrase = (car->stats).lap + 4;
      }
      else {
        r.phrase = 2;
      }
      CopSpeak_Request(&r);
    }
  }
  if (currentLap[(u_char)carnum] == '\0') {
    bestLapTime[(u_char)carnum] =
        simGlobal.gameTicks - gtotallaptimes[(u_char)carnum];
  }
  currentLap[(u_char)carnum] = (char)car->lap;
  gtotallaptimes[(u_char)carnum] = (car->stats).lapTime;
  intensityFalseLapCounter = falseLapCounter = car->lap;
  return;
}

/* ---- AudioCmn_LoadFESamples__Fv  [@0x80077738] ---- */
void AudioCmn_LoadFESamples(void)
{
  char filename[100];

  strcpy(filename, Paths_Paths[0x1c]);
  strcat(filename, D_8013C684);   /* "fesfx" */
  AudioCmn_LoadBank(filename,0);
  return;
}

/* ---- AudioCmn_LoadGameSamples__Fv  [@0x8007777c] ---- */
void AudioCmn_LoadGameSamples(void)
{
  char filename[100];

  AudioEng_StartUp(0,GameSetup_gCarNames[0] + GameSetup_gData.carInfo[0].carType * 5);
  if (GameSetup_gData.commMode == 1) {
    AudioEng_StartUp(1,GameSetup_gCarNames[0] + GameSetup_gData.carInfo[1].carType * 5);
  }
  AudioEng_StartServer();
  strcpy(filename, Paths_Paths[0x1c]);
  strcat(filename, D_8013C6A0);   /* "Gen" */
  char *TrackGenBank[11] = {
    D_8013C68C, D_8013C6A4, D_8013C68C, D_8013C6A8, D_8013C68C,
    D_8013C6A4, D_8013C690, D_8013C6A4, D_8013C68C, D_8013C68C,
    D_8013C68C
  };
  strcat(filename, TrackGenBank[GameSetup_gData.track]);
  AudioCmn_LoadBank(filename,3);
  gSndBnk[5].bnkID = -2;
  gSndBnk[2].bnkID = -3;
  return;
}

/* ---- AudioCmn_InitChannelArray__Fv  [@0x800778b0] ---- */
void AudioCmn_InitChannelArray(void)
{
  int i;

  for (i = 0; i < 0x47; i++) {
    gaChannel[i].Partial = -1;
    gaChannel[i].SFXnum = -1;
  }
  AudioCmn_gCursorSndHandle = -1;
}

/* ---- scaleFrequency__Fiii  [@0x800778e8] ---- */
int scaleFrequency(int sndPlayer,int iSFXnum,int tweakedForce)
{
  int scaledFreq;

  if (sndPlayer - 0x12U < 2) {
    scaledFreq = MIN((tweakedForce * 0x7f) / 0xa0000,0x7f);
  }
  else if (sndPlayer - 0x14U < 2) {
    scaledFreq = MIN((tweakedForce * 0x7f) / 0xa0000,0x7f);
  }
  else if (gaChannel[sndPlayer].SFXnum != iSFXnum) {
    scaledFreq = MIN((tweakedForce * 0x7f) / 0xa0000,0x7f);
    SkidInitMaxFreq[sndPlayer] = (char)scaledFreq;
  }
  else {
    scaledFreq = (u_int)(u_char)SkidInitMaxFreq[sndPlayer];
  }
  return scaledFreq;
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
  /* Retail bytes confirm the nonzero initializer at .sdata+0x84. */
  static int lastImpactSample = 0x63;
  int iSFXnum = 0;

  if (surface1 == 8) {
    iSFXnum = 0x13;
  }
  else if (surface1 == 2 && surface2 == 0) {
    iSFXnum = 0x1f;
  }
  else if (surface1 == 1 && surface2 == 0xd) {
    iSFXnum = 0x1e;
  }
  else if (surface1 == 1 && surface2 == 0xe) {
    iSFXnum = 0x1d;
  }
  else if (surface1 == 1 && surface2 == 4) {
    if (force > 0x6e)
      iSFXnum = 0x21;
    else
      iSFXnum = (random() & 1) ? 0x25 : 0x20;
  }
  else if (surface1 == 1 && surface2 == 0xf) {
    switch ((u_int)random() % 4) {
    case 1: iSFXnum = 0x22; break;
    case 0: iSFXnum = 0x23; break;
    case 2: iSFXnum = 0x20; break;
    case 3: iSFXnum = 0x25; break;
    default: iSFXnum = 0x23; break;
    }
  }
  else if (surface1 == 1 && surface2 == 5) {
    iSFXnum = 0x1d;
  }
  else if (surface2 == 7) {
    iSFXnum = 0x12;
  }
  else if (surface1 == 1 && (surface2 == 0 || surface2 == 3)) {
    if (force > 0x50) {
      iSFXnum = 0x21;
    }
    else {
      if (force <= 0x50 && force > 0x16)
        iSFXnum = 0x22;
      else if (force <= 0x16 && force > 0x10)
        iSFXnum = 0x20;
      else if (force <= 0x10)
        iSFXnum = 0x1d;
    }

    if (iSFXnum == lastImpactSample && iSFXnum != 0x21) {
      switch (iSFXnum) {
      case 0x22:
        iSFXnum = (random() & 1) ? 0x1d : 0x20;
        break;
      case 0x1d:
        iSFXnum = (random() & 1) ? 0x22 : 0x20;
        break;
      case 0x20:
        iSFXnum = (random() & 1) ? 0x1d : 0x22;
        break;
      }
    }
  }
  else {
    if (force > 0x5a) {
      iSFXnum = 0x21;
    }
    else {
      if (force <= 0x5a && force > 0x46)
        iSFXnum = 0x20;
      else if (force <= 0x46 && force > 0x32)
        iSFXnum = 0x25;
      else if (force <= 0x32 && force > 0x19)
        iSFXnum = 0x22;
      else if (force <= 0x19)
        iSFXnum = 0x1e;
    }

    if (iSFXnum == lastImpactSample && iSFXnum != 0x21) {
      switch (iSFXnum) {
      case 0x1e:
        iSFXnum = 0x22;
        break;
      case 0x22:
        iSFXnum = (random() & 1) ? 0x1e : 0x25;
        break;
      case 0x25:
        iSFXnum = (random() & 1) ? 0x1e : 0x22;
        break;
      case 0x20:
        iSFXnum = (random() & 1) ? 0x25 : 0x22;
        break;
      }
    }
  }
  return iSFXnum;
}

/* ---- ChooseLoopedSample__F6s_typeT0  [@0x80077c94] ---- */
int ChooseLoopedSample(s_type surface1,s_type surface2)
{
  int SFXnum;
  
  SFXnum = 0x2c;
  if (surface1 == 2) {
    if (surface2 == 0) {
      SFXnum = 0x2a;
    }
    if (surface2 == 0x10) {
      SFXnum = 0x2d;
    }
    if (surface2 == 0x11) {
      SFXnum = 0x2e;
    }
    if (surface2 == 0x12) {
      SFXnum = 0x2f;
    }
    if (surface2 == 0xb) {
      SFXnum = 0x2b;
    }
    if (surface2 == 0xc) {
      SFXnum = 0x2c;
    }
  }
  /* MATCH (w59-a10 branch-target audit): the old `if (surface2 != 0xc) goto
     LAB_80077cec;` + a SECOND `iVar1 = 0x2c;` outside the surface1==2 block
     gated PASS but branched the `surface1 != 2` entry test into idx20 (the
     re-store) instead of retail's idx21 (.L80077CE8) -- retail 14820013 vs
     ours 14820012.  The plain nested `if (surface2 == 0xc)` arm reproduces
     retail's target: the unconditional `iVar1 = 0x2c` already lives in the
     entry bne's DELAY SLOT (idx2), so no second store outside is needed. */
  if ((surface1 == 1) &&
     ((((surface2 == 0 || (surface2 == 0x10)) || (surface2 == 3)) || (surface2 == 0xb)))) {
    SFXnum = 0x28;
  }
  if ((surface1 == 2) && (surface2 == 3)) {
    SFXnum = 0x29;
  }
  if ((surface1 == 1) && (surface2 == 0xc)) {
    SFXnum = 0x2c;
  }
  return SFXnum;
}

/* ---- AudioCmn_SFX__Fi6s_typeT1iii  [@0x80077d50] ---- */
/* MATCH (2026-08-14): PASS (224 insns), from authoritative 134-diff baseline.
   Retail shape: two block-local default/override clamp bridges keep the computed
   quotient in v1/a0 (impact) and v1/a3 (loop), with the named tempAmp copied to
   s0 in the ChooseImpactSample delay slot.  The negative non-impact arm is a
   literal PlaySFX(0x31,...,0x40,...) tail, not assignments to shared locals.
   The loop uses the out-of-line low-amplitude cleanup and `amplitude +
   (amplitude << 1)` for the retail addend order.  Empty read-only fences buy
   the SYM s5/s0/s1/s3/s4 allocation; their placement before the loop branch is
   essential so reorg can fill the later retail delay slots. */
/* SYM rule-8 REWRITE (w54-a11).  Local map from the SYM `8c Function start` block:
   iSFXnumber = REG $17 (s1), amplitude = REG $19 (s3), frequency = REG $20 (s4) at
   function scope; tempAmp = REG $16 (s0) in the block starting 0x80077E18; c (PTR
   Car_tObj) = REG $16 (s0) in the block starting 0x80077FB0.  sndPlayer = s5,
   tweakedForce = s0, Distsq = ARG copied to v1, azimuth = ARG copied to s6.
   Everything else the old recon declared (iVar1..iVar4, pCVar5, uVar6, vol) was
   fabricated.  BUG FIX: the retail entry guard on AudioCmn_kAudioOn (SLD 1485,
   0x80077D58/0x80077D84) was missing entirely. */
void AudioCmn_SFX(int sndPlayer,s_type surface1,s_type surface2,int tweakedForce,int Distsq,
               int azimuth)
{
  int iSFXnumber;
  int amplitude;
  int frequency;

  if (AudioCmn_kAudioOn == 0) {
    return;
  }
  if (Distsq < 0x1324) {
    amplitude = ((0x1324 - Distsq) * 0x7f) / 0x1324;
  }
  else {
    amplitude = 0;
  }
  __asm__("" : : "r"(tweakedForce), "r"(tweakedForce), "r"(tweakedForce),
                 "r"(tweakedForce), "r"(tweakedForce), "r"(tweakedForce),
                 "r"(tweakedForce), "r"(tweakedForce), "r"(tweakedForce),
                 "r"(tweakedForce));
  __asm__("" : : "r"(tweakedForce), "r"(tweakedForce), "r"(tweakedForce),
                 "r"(tweakedForce));
  if (sndPlayer < 0) {
    /* Retail spells the 0x23 follow-up as its OWN PlaySFX call with literal args; gcc
       cross-jumps it into the shared tail `jal` at 0x800780A0, entering one instruction
       late because it stores tempAmp instead of amplitude into 0x10(sp). */
    int tempAmp;
    tweakedForce = MIN((tweakedForce * 0x7f) / 0xa0000,0x7f);
    iSFXnumber = ChooseImpactSample(tweakedForce,surface1,surface2);
    if (iSFXnumber == 0x1f) {
      tempAmp = ((amplitude * tweakedForce) / 0x7f) * 2;
      if (0x7f < tempAmp) {
        tempAmp = 0x7f;
      }
      AudioCmn_PlaySFX(0x31,0x1f,0x40,0x10000,amplitude,azimuth);
      AudioCmn_PlaySFX(0x31,0x23,0x40,0x10000,tempAmp,azimuth);
      return;
    }
    if (iSFXnumber == 0x12) {
      AudioCmn_PlaySound(gSndBnk[3].bnkID,0x12,azimuth,0x7f,0x40);
      AudioCmn_PlaySound(gSndBnk[3].bnkID,0x16,azimuth,0x7f,0x40);
      AudioCmn_PlaySound(gSndBnk[3].bnkID,0x23,azimuth,amplitude,0x40);
      return;
    }
    AudioCmn_PlaySFX(0x31,iSFXnumber,0x40,0x10000,amplitude,azimuth);
    return;
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
    iSFXnumber = ChooseLoopedSample(surface1,surface2);
    frequency = scaleFrequency(sndPlayer,iSFXnumber,tweakedForce);
    __asm__("" : : "r"(sndPlayer - 0x12U), "r"(sndPlayer - 0x12U),
                   "r"(sndPlayer - 0x12U), "r"(sndPlayer - 0x12U),
                   "r"(iSFXnumber), "r"(iSFXnumber), "r"(iSFXnumber),
                   "r"(iSFXnumber), "r"(iSFXnumber), "r"(iSFXnumber));
    __asm__("" : : "r"(iSFXnumber), "r"(iSFXnumber), "r"(iSFXnumber),
                   "r"(iSFXnumber), "r"(iSFXnumber), "r"(amplitude),
                   "r"(amplitude), "r"(amplitude), "r"(amplitude));
    if (sndPlayer - 0x12U < 2) {
      tweakedForce = MIN((tweakedForce * 0x7f) / 0xa0000,0x7f);
      amplitude = amplitude * tweakedForce >> 7;
      if (amplitude >= 0x1f) {
        Car_tObj*c;

        c = Cars_gList[sndPlayer - 0x12U];
        if ((c->carInfo->carType < 0x1c) &&
           ((((c->render).currentRoll > 0 && (0x1e0000 < (c->N).damage[7]))
            || (((c->render).currentRoll < 0 && (0x1e0000 < (c->N).damage[3])))))) {
          AudioCmn_PlaySFX(sndPlayer + 4,0x28,frequency + 10,0x10000,
                           amplitude + (amplitude << 1),azimuth);
          c->audioDamageScrape = amplitude;
        }
      }
      else {
        freeVoiceChannel(sndPlayer + 4);
        Cars_gList[sndPlayer - 0x12U]->audioDamageScrape = 0;
      }
    }
    if ((iSFXnumber == 0x2c) && (frequency = frequency + -0x3c, frequency < 0)) {
      frequency = 0;
    }
  }
  AudioCmn_PlaySFX(sndPlayer,iSFXnumber,frequency,0x10000,amplitude,azimuth);
  return;
}

/* ---- freeVoiceChannel__Fi  [@0x800780d0] ---- */
void freeVoiceChannel(int sndPlayer)
{
  if (AudioCmn_kAudioOn != 0) {
    if (sndPlayer != -1) {
      if ((void *)gaChannel[sndPlayer].Partial != (void *)0xffffffff) {   /* @0x80078108: Partial == -1 sentinel (disasm-v3) */
        SNDautovol((void *)gaChannel[sndPlayer].Partial,5,-1);
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
  return AudioCmn_PlayDoppleredSound(bhandle,patchNum,azimuth,vol,bend,0x10000);
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
    /* SYM-CODEGEN-CARRIER: lookup -- the typed byte-table base remains a
       separate address quantity in retail's lookup arm. */
    u_char *lookup = (u_char *)gBankNumLookupTable;
    /* ORIGINAL-NAME-RECOVERED: bankNum -- the symbol-bearing NFS2 AudioCmn_PlaySFX
       records the same byte-table index as `bankNum`.  The intermediate gives
       retail's v0 lookup base and v1 index/load web; folding both names into
       one expression is count-exact but leaves 36 authoritative diffs. */
    u_char bankNum = lookup[sndPlayer << 2];
    PatchBank = gSndBnk[bankNum].bnkID;
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
    /* SYM-CODEGEN-CARRIER: chbase -- materializing the base before the shifted
       index gives retail's index-first add.  Direct array addressing is
       count-exact but reverses the address chain for 8 diffs. */
    int chbase = (int)gaChannel;
    /* SYM-CODEGEN-CARRIER: slot -- the selected-channel pointer must survive
       through SNDover and the async guard.  Its measured post-use reference is
       zero-instruction and closes the former 94-diff allocation basin. */
    Channels_t *slot = (Channels_t *)((sndPlayer << 3) + chbase);
    if (slot->SFXnum != iSFXnum) goto NEWSOUND;
    if (SNDover(slot->Partial) != 0) {
      slot->Partial = -1;
      slot->SFXnum = -1;
    }
    /* MATCH: retail computes this flag before the PatchBank < -1 guard.  Reusing
       the disjoint iPartial web initially crosses a 20 -> 94 allocation basin;
       one post-SNDover reference to slot restores iAmp=s1/slot=s0 and reaches
       PASS together with the typed lookup above.  The fence emits no code. */
    __asm__("" : : "r"(slot));
    iPartial = (PatchBank == -3);
    if ((PatchBank < -1) &&
       (AudioCmn_GetAsyncSfx(iPartial,iSFXnum,false) == -1)) {
      slot->Partial = -1;
      slot->SFXnum = -1;
    }
    if (gaChannel[sndPlayer].SFXnum == iSFXnum) goto RECHECK;
NEWSOUND:
    {
      /* SYM-CODEGEN-CARRIER: nbase -- staging the channel-array base before
         the shifted index fixes the `%lo` materialization position.  Direct
         `&gaChannel[sndPlayer]` is count-exact but leaves 2 diffs. */
      int nbase = (int)gaChannel;
      if (((Channels_t *)((sndPlayer << 3) + nbase))->Partial != -1) {
        SNDstop(((Channels_t *)((sndPlayer << 3) + nbase))->Partial);
        NumSFXOn = NumSFXOn - 1;
      }
      /* SYM-CODEGEN-CARRIER: r -- the block-local result dies in `$v0` and
         preserves the shared-store control flow.  Reusing SYM's `iPartial`
         emits 317/316 instructions and 13 diffs. */
      int r = AudioCmn_PlayDoppleredSound(PatchBank,iSFXnum,azimuth,iAmp,iFreq,iDopplerIn);
      if (r != -1) {
        ((Channels_t *)((sndPlayer << 3) + nbase))->Partial = r;
        ((Channels_t *)((sndPlayer << 3) + nbase))->SFXnum = iSFXnum;
      }
      else {
        ((Channels_t *)((sndPlayer << 3) + nbase))->Partial = r;
        ((Channels_t *)((sndPlayer << 3) + nbase))->SFXnum = r;
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
        /* SYM-CODEGEN-CARRIER: pbase -- the explicit base controls the stereo
           pan block's high/low materialization.  Direct array addressing is
           count-exact but moves both instructions (4 diffs). */
        int pbase = (int)gaChannel;
        /* SYM-CODEGEN-CARRIER: pch -- keeping the selected channel separate
           from the base preserves the pan-result and address webs.  Folding
           the pointer into SNDpan is count-exact but leaves 20 diffs. */
        Channels_t *pch = (Channels_t *)((sndPlayer << 3) + pbase);
        /* SYM-CODEGEN-CARRIER: pan -- the unsigned scoped result must remain
           separate from SYM's earlier `iPartial` web.  Reusing `iPartial`
           emits 322/316 instructions and 46 diffs. */
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
      /* SYM-CODEGEN-CARRIER: bbase -- the final pitch block needs a fresh
           base/index web.  Direct array addressing is count-exact but leaves
           6 address-generation diffs. */
      int bbase = (int)gaChannel;
      SNDpitchbend(((Channels_t *)((sndPlayer << 3) + bbase))->Partial,iFreq);
      SNDpitchmult(((Channels_t *)((sndPlayer << 3) + bbase))->Partial,
                   iDopplerIn >> 4);
    }
    goto LAB_8007887c;
SETM1:
    gaChannel[sndPlayer].SFXnum = -1;
  }
LAB_8007887c:
  return gaChannel[sndPlayer].Partial;
}

/* ---- AudioCmn_SoundCar__FP8Car_tObjiiiiiii  [@0x800788bc] ---- */
/* MATCH (2026-08-24): the IDA/SYM-guided local and expression rewrite gives
   source-PASS 530/530 in the authoritative strict TU-wide -G8 build.
   Comma-staging tunnelFlag with the load-amplitude shift, plus an input-only
   tunnelFlag fence, fills the multiply latency window and removes its load-delay
   nop.  A single staged PlayersRampedGasLevel pointer preserves the retail address
   lifetime through the ramp update; direct indexing is exact at the later read and
   store sites.  In the signed divide-by-eight block,
   putting gasDelta's opacity use inside only the negative arm and spelling the
   nonnegative assignment explicitly keeps gasDelta as the branch operand while
   allowing gcc to fill `bgez`'s delay slot with `currentGas = gasDelta`.
   The former carIndex and +2-ref staging workarounds are unnecessary in the
   restored source and are intentionally absent in the sealed 48/48 TU lane. */
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
  static char cobbleCount = 0;
  int loadAmp;
  int amplitude;
  int roadNoiseAmp;
  int wetNoiseAmp;
  int roadNoiseFreq;
  int wetNoiseFreq;
  /* SLD places iAmpIn in the frame rather than a saved register.  The explicit
     defining store models that boundary; the later read remains ordinary. */
  int iAmpIn;
  int tuntrig;
  /* SYM-CODEGEN-CARRIER: tunnelFlag -- branching directly on SYM's `tuntrig`
     grows 530 to 531 instructions, shifts all three frame slots, and leaves 23
     authoritative diffs; this snapshot is the required stack-layout carrier. */
  int tunnelFlag;
  int cam;
  int roadNoisePatch;
  /* SYM-CODEGEN-CARRIER: scaledAmplitude -- folding this temporary into the
     SYM-named `amplitude` preserves count but changes 14 instructions around the
     clamp and multiply handoff. */
  int scaledAmplitude;
  /* SYM-CODEGEN-CARRIER: rpmRatio -- inlining the redline quotient into
     AudioEng_Set grows 530 to 531 instructions and changes 43 instructions by
     advancing the guarded divide ahead of the gas selection. */
  int rpmRatio;
  /* SYM-CODEGEN-CARRIER: clampedRoadNoiseAmp -- direct if/ternary clamp forms
     shrink 530 to 529 instructions and leave seven branch/copy diffs. */
  int clampedRoadNoiseAmp;
  
  AudioCmn_CheckState(car);
  if (AudioCmn_kAudioOn) {
  /* SYM-CODEGEN-CARRIER: attenuation -- direct signed `/ 0x10000` grows 530 to
     531 instructions with seven diffs; splitting the subsequent speed-noise phase
     into another local preserves count but changes ten register-allocation sites. */
  int attenuation;

  if (Camera_gInfo[car->carIndex].mode == 0xc) {
    attenuation = fixeddiv(0x10000000,dst + 0x10000);
  }
  else {
    attenuation = fixeddiv(0x8000000,dst + 0x20000);
  }
  /* Reconstruct the compiler's signed / 0x10000 rounding before the stack spill. */
  if (attenuation < 0) {
    attenuation = attenuation + 0xffff;
  }
  *(int *)&iAmpIn = attenuation >> 0x10;
  attenuation = -0xd8000;
  /* W85-S2: an INERT zero-insn fence was deleted here -- measured PASS
     alone and jointly with the other two, on the WHOLE-TU gate (48/48). */
  /* SYM: roadNoiseAmp is REG $s1, live from here through the camera-mode selector
     and later amplitude clamp. */
  roadNoiseAmp = 0;
  attenuation = __builtin_abs((car->linearVel_ch).z) + attenuation;
  if (-1 < attenuation) {
    roadNoiseAmp = attenuation >> 0xf;
  }
  /* SYM: CurCarGasLevel is REG $s0, live from here through the fixedmult-based
     self-referencing scale below; blowout doubles it in place. */
  CurCarGasLevel = __builtin_abs((car->linearVel_ch).z) >> 0xf;
  if (0x7f < CurCarGasLevel) {
    CurCarGasLevel = 0x7f;
  }
  /* SYM: cobbleMod is a distinct REG local ($s3) spanning from this clamp through the
     switch-case modulo below -- split out of the Ghidra iVar4 temp (which is reused later
     for unrelated short-lived values) so its live range doesn't force one register to
     cover the whole function. */
  cobbleMod = CurCarGasLevel / 0x10;
  cobbleMod = 8 - cobbleMod;
  if (cobbleMod < 3) {
    cobbleMod = 3;
  }
  roadNoiseFreq = 0x40;
  /* Keep the source-level freq lifetime distinct from iFreqIn.  Retail carries
     iFreqIn in $s2, then reuses that register for PlayerPan and loadAmp. */
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
  *(int *)&tuntrig = (int)BWorldSm_TunnelFlagSm(&(car->N).simRoadInfo);
  if (tuntrig != 0) {
    if ((GameSetup_gData.commMode != 1) && ((u_char)fReverbLevel < 100)) {
      fReverbLevel = (char)((100 < (u_char)fReverbLevel + 10) ?
          100 : (u_char)fReverbLevel + 10);
      SNDfxmasterlevel(0x0,(u_char)fReverbLevel);
      fReverbOn = '\x01';
    }
    roadNoiseAmp = roadNoiseAmp + 0x14;
    roadNoiseFreq = 0x5e;
  }
  else {
    if ((u_char)fReverbLevel < 0x20) {
      fReverbLevel = ' ';
      SNDfxmasterlevel(0x0,0x20);
      fReverbOn = '\x01';
    }
    else if (0x20 < (u_char)fReverbLevel) {
      fReverbLevel = (char)((0x20 > (int)((u_char)fReverbLevel - 5)) ?
          0x20 : (u_char)fReverbLevel - 5);
      SNDfxmasterlevel(0x0,(u_char)fReverbLevel);
    }
  }
  if (GameSetup_gData.commMode == 1) {
    SPSC = true;
    PlayerPan = 0xc002;
    if (car->carIndex != 0) {
      PlayerPan = 0x3ffe;
    }
  }
  else {
    SPSC = false;
    PlayerPan = 0;
  }
  if (car->blowout != 0) {
    roadSurface = 4;
    CurCarGasLevel = CurCarGasLevel << 1;
  }
  if (dst < 0x460000) {
    /* SYM-CODEGEN-CARRIER: distanceScale -- replacing the lowered signed-shift
       result with the direct `/ 0x10000` source expression preserves count but
       changes 92 instructions by perturbing the saved-register allocation. */
    int distanceScale;

    /* @0x80078B7C: the final >>16 (with negative-rounding fixup) writes BACK into
       CurCarGasLevel itself ($s0). */
    distanceScale = ((0x13240000 - fixedmult(dst,dst)) / 0x1324) * CurCarGasLevel;
    CurCarGasLevel = distanceScale >> 0x10;
    if (distanceScale < 0) {
      distanceScale = distanceScale + 0xffff;
      CurCarGasLevel = distanceScale >> 0x10;
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
    roadNoiseAmp += roadNoiseAmp / 4;
    roadNoiseFreq = 0x18;
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
      AudioCmn_PlaySound(gSndBnk[3].bnkID,0x1d,SPSC ? PlayerPan : 0,
          CurCarGasLevel / 2,roadSurface == 7 ? 0x28 : 0x40);
    }
  }
  if (gMasterEngineLevel == 0) {
    return;
  }
  /* @0x80078CB4: real oracle shape is a flat descending guard-chain (bltz; slti<2; slti<5;
     else), NOT the Ghidra comma-expression -- that convoluted form emits a spurious xor.
     Also note the 2<=mode<5 case shifts by the VARIABLE `cam` (srav), not a literal 1
     (sra) -- cam happens to equal 1 there, but the register form must be reproduced. */
  if (Camera_gInfo[car->carIndex].mode < 0) {
    cam = 2;
    roadNoiseAmp = roadNoiseAmp >> 1;
  }
  else if (Camera_gInfo[car->carIndex].mode < 2) {
    cam = 0;
  }
  else if (Camera_gInfo[car->carIndex].mode < 5) {
    cam = 1;
    roadNoiseAmp = roadNoiseAmp >> cam;
  }
  else {
    cam = 2;
    roadNoiseAmp = roadNoiseAmp >> 1;
  }
  {
  /* SYM-CODEGEN-CARRIER: currentGas -- merging the adjusted difference back into
     this byte snapshot removes retail's delay-slot copy and leaves eight diffs. */
  int currentGas;
  /* SYM-CODEGEN-CARRIER: previousGas -- repeated direct pointer reads grow 530 to
     535 instructions and leave nine diffs because GCC must conservatively reload. */
  int previousGas;
  /* SYM-CODEGEN-CARRIER: rampedGas -- direct array expressions grow 530 to 545
     instructions and leave 77 diffs; this scoped pointer preserves one address
     across every conditional store. */
  int *rampedGas;

  rampedGas = PlayersRampedGasLevel + car->carIndex;
  __asm__("" : : "r"(rampedGas));
  currentGas = (u_char)(car->control).gasLevel;
  previousGas = *rampedGas;
  amplitude = iAmpIn;
  if (previousGas < currentGas) {
    if (0 < (currentGas - previousGas) / 2) {
      *rampedGas = previousGas + (currentGas - previousGas) / 2;
    }
    else {
      *rampedGas = previousGas + 1;
    }
  }
  else if (currentGas < previousGas) {
    /* SYM-CODEGEN-CARRIER: gasDelta -- reusing currentGas for the subtraction
       preserves count but loses the retail `bgez` delay-slot copy (eight diffs). */
    int gasDelta = currentGas - previousGas;
    if (gasDelta < 0) {
      __asm__("" : "+r"(gasDelta));
      currentGas = gasDelta + 7;
    }
    else {
      currentGas = gasDelta;
    }
    currentGas >>= 3;
    if (currentGas < 0) {
      *rampedGas = previousGas + currentGas;
    }
    else {
      *rampedGas = previousGas - 1;
    }
  }
  }
  /* SYM: cobblestoneAmp is REG $s0 (shares the register with CurCarGasLevel, whose
     live range ends earlier) -- the re-read of the just-updated ramped gas level,
     clamped and carried into the gear-shift block below. */
  cobblestoneAmp = PlayersRampedGasLevel[car->carIndex];
  if (0xff < cobblestoneAmp) {
    cobblestoneAmp = 0xff;
  }
  {
  /* SYM-CODEGEN-CARRIER: roadProduct -- folding the product into roadNoiseAmp
     shrinks 530 to 529 instructions and leaves 11 multiply-latency diffs. */
  int roadProduct;

  /* Write the signed /128 as a DIVIDE, not the hand-expanded bgez/+0x7f/sra rounding:
     gcc emits that idiom itself and schedules the `li 127` into the bgez delay slot
     exactly like retail (151->145). */
  loadAmp = 0x7f;
  scaledAmplitude = amplitude * (freq + 0x28) / 128;
  if (scaledAmplitude < amplitude) {
    scaledAmplitude = amplitude;
  }
  amplitude = scaledAmplitude;
  scaledAmplitude = scaledAmplitude * loadAmp;
  roadProduct = roadNoiseAmp * amplitude;
  loadAmp = (tunnelFlag = tuntrig, scaledAmplitude >> 7);
  __asm__("" : : "r"(tunnelFlag));
  __asm__("" : : "r"(roadProduct));
  roadNoiseAmp = roadProduct >> 7;
  }
  if (tunnelFlag == 0) goto SoundCar_getWetNoise;
  wetNoiseAmp = 0;
  goto SoundCar_haveWetNoise;
SoundCar_getWetNoise:
  wetNoiseAmp = Weather_GetNumParticles(car->carIndex);
SoundCar_haveWetNoise:
  if (0x7f < wetNoiseAmp) {
    wetNoiseAmp = 0x7f;
  }
  wetNoiseFreq = 0x48 - (wetNoiseAmp >> 3);
  clampedRoadNoiseAmp = 0x7f;
  if (roadNoiseAmp < 0x80) {
    clampedRoadNoiseAmp = roadNoiseAmp;
  }
  roadNoiseAmp = clampedRoadNoiseAmp;
  if ((relvel != 0) || (Camera_gInfo[car->carIndex].mode == 0xb)) {
    /* @0x80078E50: the div-by-zero / INT_MIN-by(-1) guard is the automatic
       --expand-div guard on the '/' below (matches the oracle's single
       div;break7;break6 sequence) -- no manual trap() in source. */
    loadAmp = (loadAmp << 0x10) / doppler;
  }
  __asm__("" : : "r"(freq * doppler));
  roadNoisePatch = 0xe;
  if (cam == 0) {
    roadNoisePatch = 0;
    if (GameSetup_gData.commMode == 1) {
      roadNoisePatch = 0xe;
    }
  }
  if (roadNoiseAmp != 0) {
    AudioCmn_PlaySFX(car->carIndex == 0 ? 0x18 : 0x19,
        roadNoisePatch,roadNoiseFreq,doppler,roadNoiseAmp,azimuth);
  }
  else {
    freeVoiceChannel(car->carIndex == 0 ? 0x18 : 0x19);
  }
  if (car->carIndex == 0) {
    if ((GameSetup_gData.Weather == 1) && (wetNoiseAmp != 0)) {
      AudioCmn_PlaySFX(0x1a,0,wetNoiseFreq,doppler,wetNoiseAmp,0);
    }
    else {
      freeVoiceChannel(0x1a);
    }
  }
  if (((((car->control).gearShiftTimer != '\0') &&
       ((u_char)(car->control).gear > (u_char)(car->control).lastGear)) &&
      ((u_char)(car->control).lastGear != 1)) &&
     (cobblestoneAmp != 0)) {
    /* @0x8007902C-ish gearShiftDelay division: automatic --expand-div guard on '/'. */
    loadAmp = (loadAmp + loadAmp * (u_char)(car->control).gearShiftTimer /
        car->specs->gearShiftDelay) >> 1;
    if ((u_char)(car->control).gearShiftTimer == 5) {
      cobblestoneAmp = cobblestoneAmp - (cobblestoneAmp >> 2);
    }
    else if ((u_char)(car->control).gearShiftTimer == 4) {
      cobblestoneAmp = cobblestoneAmp >> 1;
    }
    else if ((u_char)(car->control).gearShiftTimer == 3) {
      cobblestoneAmp = cobblestoneAmp >> 2;
    }
    else if ((u_char)(car->control).gearShiftTimer < 3) {
      cobblestoneAmp = 0;
    }
    PlayersRampedGasLevel[car->carIndex] = cobblestoneAmp;
  }
  {
    int gas;

    /* @0x80079044 redline division (mflo a2): automatic --expand-div guard, no manual trap(). */
    rpmRatio = (car->flywheelRpm << 0x10) / car->specs->redline;
    gas = 0x7f;
    if (car->revLimit == 0) {
      gas = cobblestoneAmp >> 1;
    }
    AudioEng_Set(car->carIndex,(gMasterEngineLevel * 0xe) * loadAmp >> 0xe,rpmRatio,gas,cam,
               doppler,azimuth,cardir);
  }
  }
  return;
}

/* ---- AudioCmn_TrafficSFX__Fiiiiiiii  [@0x80079104] ---- */
void AudioCmn_TrafficSFX(int iChan,int iSFXnum,int freq,int doppler,int dst,int azimuth,int relvel,int dir)
{
  /* SYM rule-8: locals = iAmpIn(s4), player(a0), pitchmult(s0) ONLY; dst/azimuth/relvel/dir
     get REG copies (a2/s7/s6/s1), freq+doppler stay ARG (stack) and are reloaded per use.
     The two direct symmetric crossfade expressions compile to retail's destructive
     s2=dir>>12 / s1=dir>>10 chain; relvel is clamped in place and iAmpIn is reused.
     MATCH (2026-08-14): PASS 163/163.  qtytrace priced the saved-register cycle: five
     zero-instruction pitchmult references cross its local-allocation priority boundary;
     direct crossfade indices reproduce retail's `(dir12+64)-dir10` chain; staging the
     nested patch result and Xfade base plus a between-call scheduling fence
     gives the exact call/shift order.  No register pin or emitted asm instruction is used.
     Earlier basins: 53 -> 51 (post-`>>10` pitch scale), 24 (priced pitch refs),
     14 (destructive dir12 chain), 10/6/4/2 (statement/fence placement) -> PASS. */
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
    /* SYM-CODEGEN-CARRIER: patch -- retaining the first patch lookup result as a
       named pseudo is required for retail's a0/a1 setup order around the jal. */
    int patch;
    /* SYM-CODEGEN-CARRIER: fade -- the named Xfade base preserves retail's
       placement of the destructive dir shift between the two call sequences. */
    u_char *fade;

    pitchmult = fixedmult(freq + 0x3333,doppler) * 0x50 >> 10;
    /* BUG FIX (2026-07-11): real crossfade table Xfade[129], not a stale "" placeholder.
       BUG FIX (wave-13): 2nd index IS +0x40 biased -- oracle mutates s2=(dir>>12)-0x40 then
       s1-s2 = (dir>>10)-(dir>>12)+0x40 (the wave-6 note claiming "no +0x40" misread the raw;
       the two calls use the symmetric +-0x40 crossfade pair). */
    patch = CopSpeak_GetEnginePatch(iSFXnum,0);
    fade = Xfade;
    /* W85-S2: an INERT zero-insn fence was deleted here -- measured PASS
       alone and jointly with the other two, on the WHOLE-TU gate (48/48). */
    AudioCmn_PlaySFX(iChan + 4,patch,0x40,pitchmult << 4,
               iAmpIn * fade[((dir >> 0xc) + 0x40) - (dir >> 10)] >> 7,azimuth);
    /* W85-S2: an INERT zero-insn fence was deleted here -- measured PASS
       alone and jointly with the other two, on the WHOLE-TU gate (48/48). */
    AudioCmn_PlaySFX(iChan + 8,CopSpeak_GetEnginePatch(iSFXnum,1),0x40,pitchmult << 4,
               iAmpIn * fade[(dir >> 10) - ((dir >> 0xc) - 0x40)] >> 7,azimuth);
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

  if (AudioCmn_kAudioOn != 0) {
    if (Distsq < 0x1324) {
      iAmpIn = ((0x1324 - Distsq) * 0x7f) / 0x1324;
    }
    else {
      iAmpIn = 0;
    }
    if ((iAmpIn == 0) && (sndPlayer != -1)) {
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
  int iAmpIn;

  if (AudioCmn_kAudioOn != 0) {
    if (Distsq < 0x1324) {
      iAmpIn = ((0x1324 - Distsq) * 0x7f) / 0x1324;
    }
    else {
      iAmpIn = 0;
    }
    if (GameSetup_gData.commMode == 1) {
      sfx = 10;
      if (carIndex == 0) {
        player = 0x29;
      }
      else {
        player = 0x2a;
      }
    }
    else {
      sfx = 3;
      player = 0x29;
    }
    if ((gaChannel[player].Partial == 0xffffffff) ||
        (SNDover(gaChannel[player].Partial) == 0)) {
      AudioCmn_PlaySFX(player,sfx,iFreqIn,doppler,iAmpIn,azimuth);
    }
  }
  return;
}

/* ---- AudioCmn_PlayerHornOff__Fi  [@0x80079548] ---- */
int AudioCmn_PlayerHornOff(int carIndex)
{
  int player;

  if (AudioCmn_kAudioOn == 0) {
    return 0;
  }
  player = 0x29;
  if (carIndex != 0) {
    if (GameSetup_gData.commMode == 1) {
      player = 0x2a;
      goto LAB_8007957c;
    }
  }
  else {
LAB_8007957c:
    if (GameSetup_gData.commMode == 1) goto LAB_800795e8;
  }
  if (((Cars_gList[carIndex]->carInfo->carType == 0x14) &&
      (gaChannel[player].Partial != 0xffffffff)) &&
     (SNDover(gaChannel[player].Partial) == 0)) {
    return 1;
  }
LAB_800795e8:
  freeVoiceChannel(player);
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
    /* SYM-CODEGEN-CARRIER: volScaled -- the named product is optimized into
     * retail's value flow but blocks GCC from reassociating the multiplications.
     * Folding it into the field assignment grows 34 instructions to 35 and
     * produces seven authoritative diffs. */
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
  
  patch = 8;
  if ((sirennum & 1U) != 0) {
    patch = 6;
  }
  gaChannel[sirennum + 0x2b].Partial =
      AudioCmn_PlaySound(gSndBnk[3].bnkID,patch,0x40,0,sirenCurrentPitch[sirennum]);
  return;
}

/* ---- SuperCopSirenOn__Fi  [@0x80079790] ---- */
void SuperCopSirenOn(int sirennum)
{
  gaChannel[sirennum + 0x2b].Partial =
      AudioCmn_PlaySound(gSndBnk[3].bnkID,9,0x40,0,sirenCurrentPitch[sirennum]);
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
    /* SYM rule-8: the ONLY named local in retail is iFreq -- ch/chidx/c2/c2i/pan were
       all fabricated.  Every channel-slot reference is the FULL expression
       gaChannel[sirennum + 0x2b].Partial; gcc CSEs it into s0 by itself and hoists the
       shared %hi(gaChannel) above the 3dpos/stereo branch (it lands in that beqz's
       delay slot), which is exactly the `addiu v1,v1,0` the pan arm reuses. */
    /* MATCH (W55-A10, sealed 129/129 PASS; was 10 diffs, count-exact).  The whole residual
       was ARG-EVALUATION ORDER at this one call: retail expands the CLAMP first and only then
       materializes the channel-slot address (`lui/addiu %hi/%lo(gaChannel)` + `addiu v0,s1,43`
       + `sll 3` + `addu s0`), so the 5-insn address block sits AFTER the slti/beqz/li-127 pair
       -- ours expanded the address first (and got the v0/v1 pair the other way round as a
       consequence).  Giving the clamp its own statement (a block-scoped temp, so it does not
       join the SYM's named-local budget) fixes the issue order; the register naming follows. */
    { /* SYM-CODEGEN-CARRIER: bend -- this scoped argument-order carrier is
         absent from retail's optimized local list.  Inlining the ternary
         expands the channel address before the clamp and produces the
         previously measured 10-diff ordering residual; the separate statement
         yields the retail clamp-before-address sequence with no extra code. */
      int bend = (0x7f < iFreq) ? 0x7f : iFreq;
      SNDpitchbend(gaChannel[sirennum + 0x2b].Partial,bend); }
    /* MATCH: 0x25/0x2f written as (amp*9)*4+amp / (amp*3)*0x10-amp -- the inner +/-
       node blocks gcc's multiply-chain regrouping of the constant onto the LEVEL
       (same lever as PlayDoppleredSound's (vol*0x41)<<1). */
    if (sirenCount[sirennum] == -1) {
      SNDvol(gaChannel[sirennum + 0x2b].Partial,gMasterAmbientLevel * ((amp * 9) * 4 + amp) >> 0xe);
    }
    else {
      SNDvol(gaChannel[sirennum + 0x2b].Partial,gMasterAmbientLevel * ((amp * 3) * 0x10 - amp) >> 0xe);
    }
    /* MATCH: arm order -- 3dpos is the fall-through (if-body), stereo pan out-of-line. */
    if (Audio_direct3davail != 0) {
      SND3dpos(gaChannel[sirennum + 0x2b].Partial,azimuth,0);
    }
    else {
      if (gStereoMode != 0) {
        SNDpan(gaChannel[sirennum + 0x2b].Partial,
               (int)((azimuth - 0x4000U < 0x8000) ? 0xbfff - azimuth
                                                  : (azimuth + 0x4000U & 0xffff)) >> 8);
      }
    }
  }
  return;
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

/* ---- AudioCmn_UnPauseAndQuit__Fv  [@0x80079ca4] ---- */
void AudioCmn_UnPauseAndQuit(void)
{
  int i;

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
  {
    int i;
    for (i = 0; i < 0x80; i++)
      SNDmastervol(i);
  }
}

/* ---- AudioCmn_UnPauseAndRestart__Fv  [@0x80079d8c] ---- */
void AudioCmn_UnPauseAndRestart(void)
{
  int i;

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
  {
    int i;
    for (i = 0; i < 0x80; i++)
      SNDmastervol(i);
  }
  if (fReverbOn)
    AudioCmn_ReverbOff();
  GameSetup_gData.userSetting.sfxLevel   = gMasterSFXLevel;
  GameSetup_gData.userSetting.musicLevel = gMasterMusicLevel;
  AudioCmn_Init();
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

/* ---- AudioCmn_ReverbOff__Fv  [@0x80079ecc] ---- */

void AudioCmn_ReverbOff(void)

{

  SNDfxmasterlevel(0,0);

  fReverbLevel = '\0';

  fReverbOn = '\0';

}

/* Definitions following their original function-local .data predecessor. */
char *AudioCmn_LanguageName[7] = { /* @0x8010e774 */
  D_8013C68C, D_8013C690, D_8013C694, D_8013C698, D_8013C69C, D_8013C68C, D_8013C68C
};
int bSirenOn[6] = {0};                                      /* @0x8010e790 */
int bSirenPitchingUp[6] = { 1, 1, 1, 1, 1, 1 };             /* @0x8010e7a8 */
int quickSirenActive[6] = {0};                              /* @0x8010e7c0 */
int sirenPitchWidth[6] = { 32, 40, 28, 42, 28, 42 };        /* @0x8010e7d8 */
int sirenCurrentPitch[6] = { 32, 32, 32, 32, 32, 32 };      /* @0x8010e7f0 */
int slowSirenReps[6] = { 3, 3, 3, 3, 3, 3 };               /* @0x8010e808 */
int sirenCount[6] = {0};                                   /* @0x8010e820 */
int reachedSirenMin[6] = {0};                              /* @0x8010e838 */
int quickSirenTimeCount[6] = {0};                          /* @0x8010e850 */
AudioCmn_tReTrig AudioCmn_gReTrig[2] = {0};                 /* @0x8010e868 */
SndBnk_t gSndBnk[7] = {0};                                 /* @0x8010e8a8 */
Channels_t gaChannel[71] = {0};                             /* @0x8010e8fc */
AudioCmn_tAsyncSfxSlot AudioCmn_gSfxSlot[32] = {0};         /* @0x8010eb34 */
char carbankname[12] = {0};                                /* @0x8010ee34 */

/* Definitions following both function-local .sdata records.  The explicit
 * section attributes preserve their retail small-data ownership; this TU is
 * compiled in its retail -G8 lane. */
int falseLapTrigCur = 0;                                    /* @0x8013c6b4 */
int flaseLapTrigTrack = 0;                                  /* @0x8013c6b8 */
char currentLap[2] = {0, 0};                                /* @0x8013c6bc */
int bestLapTime[2] __attribute__((section(".sdata"))) = {0, 0}; /* @0x8013c6c0 */
int gtotallaptimes[2] __attribute__((section(".sdata"))) = {0, 0}; /* @0x8013c6c8 */
int AudioCmn_gPlayerArrested[2] __attribute__((section(".sdata"))) = {0, 0}; /* @0x8013c6d0 */
int AudioCmn_gCursorSndHandle = 0;                          /* @0x8013c6d8 */
int AudioCmn_gLastFade = 0;                                 /* @0x8013c6dc */
void *AudioCmn_gLoadTables = 0;                             /* @0x8013c6e0 */
void *AudioCmn_gCruiseTables = 0;                           /* @0x8013c6e4 */
int AudioCmn_gResume = 0;                                   /* @0x8013c6e8 */
int AudioCmn_gStreamRestartTimer = 0;                       /* @0x8013c6ec */
char fMysticWindON[2] = {0, 0};                             /* @0x8013c6f0 */
char fAmbientRangeON[2] = {0, 0};                           /* @0x8013c6f4 */
int currentWindVal[2] __attribute__((section(".sdata"))) = {0, 0}; /* @0x8013c6f8 */
int nextWindVal[2] __attribute__((section(".sdata"))) = {0, 0}; /* @0x8013c700 */
int currentWindPan = 0;                                     /* @0x8013c708 */
int nextWindPan = 0;                                        /* @0x8013c70c */
int gQuickSirenCount = 0;                                   /* @0x8013c710 */
int AudioCmn_ThunderAmp = 0;                                /* @0x8013c714 */
int AudioCmn_ThunderAzi = 0;                                /* @0x8013c718 */
int AudioCmn_ThunderDel = 0;                                /* @0x8013c71c */
